using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

namespace Team75
{
    public partial class verify_deductionUnpaid : System.Web.UI.Page
    {
        private string ConnectionString =>
            ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = string.Empty;

                if (Session["HR_ID"] != null)
                {
                    int hrId = Convert.ToInt32(Session["HR_ID"]);
                    lblHRID.Text = "Your HR ID is: " + hrId;
                    lblHRID.ForeColor = Color.Black;
                }
                else
                {
                    lblHRID.Text = "Your HR ID is: (not found in session)";
                    lblHRID.ForeColor = Color.Red;
                    lblError.Text = "HR ID not found in session. Please log in again.";
                }

                gridUnpaid.Visible = false;
                btnProceed.Visible = false;
            }
        }

        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("HR_Home.aspx");
        }

        // 1) Show approved unpaid leaves for this employee for the current month
        protected void btnCheck_Click(object sender, EventArgs e)
        {
            lblError.Text = "";

            if (Session["HR_ID"] == null)
            {
                lblError.Text = "HR ID not found in session. Please log in again.";
                return;
            }

            if (!int.TryParse(txtEmpID.Text.Trim(), out int empId))
            {
                lblError.Text = "Please enter a valid numeric Employee ID.";
                lblError.ForeColor = Color.Red;
                gridUnpaid.Visible = false;
                btnProceed.Visible = false;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    // Approved unpaid leaves in the current month
                    using (SqlCommand cmd = new SqlCommand(
                        @"SELECT l.request_ID,
                                 un.emp_ID,
                                 l.start_date,
                                 l.end_date,
                                 l.final_approval_status
                          FROM Unpaid_Leave un
                          INNER JOIN [Leave] l ON l.request_ID = un.request_ID
                          WHERE un.Emp_ID = @emp
                            AND l.final_approval_status = 'approved'
                            AND MONTH(l.start_date) = MONTH(GETDATE())
                            AND YEAR(l.start_date) = YEAR(GETDATE());", conn))
                    {
                        cmd.Parameters.AddWithValue("@emp", empId);

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        if (dt.Rows.Count == 0)
                        {
                            lblError.Text = "This employee has no approved unpaid leave for the current month, please try again.";
                            lblError.ForeColor = Color.Red;
                            gridUnpaid.Visible = false;
                            btnProceed.Visible = false;
                            return;
                        }

                        gridUnpaid.DataSource = dt;
                        gridUnpaid.DataBind();
                        gridUnpaid.Visible = true;
                        btnProceed.Visible = true;

                        Session["DedUnpaidEmpID"] = empId;
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error while loading unpaid leave records: " + ex.Message;
                lblError.ForeColor = Color.Red;
                gridUnpaid.Visible = false;
                btnProceed.Visible = false;
            }
        }

        // 2) Call Deduction_unpaid, avoid duplicates, and redirect
        protected void btnProceed_Click(object sender, EventArgs e)
        {
            lblError.Text = "";

            if (Session["HR_ID"] == null)
            {
                lblError.Text = "HR ID not found in session. Please log in again.";
                return;
            }

            if (!int.TryParse(txtEmpID.Text.Trim(), out int empId))
            {
                lblError.Text = "Please enter a valid numeric Employee ID.";
                lblError.ForeColor = Color.Red;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    // Find the (first) approved unpaid leave request ID for this month
                    int? requestId = null;
                    using (SqlCommand cmdReq = new SqlCommand(
                        @"SELECT TOP 1 l.request_ID
                          FROM Unpaid_Leave un
                          INNER JOIN [Leave] l ON l.request_ID = un.request_ID
                          WHERE un.Emp_ID = @emp
                            AND l.final_approval_status = 'approved'
                            AND MONTH(l.start_date) = MONTH(GETDATE())
                            AND YEAR(l.start_date) = YEAR(GETDATE());", conn))
                    {
                        cmdReq.Parameters.AddWithValue("@emp", empId);
                        object val = cmdReq.ExecuteScalar();
                        if (val != null && val != DBNull.Value)
                        {
                            requestId = Convert.ToInt32(val);
                        }
                    }

                    if (requestId == null)
                    {
                        lblError.Text = "This employee has no approved unpaid leave for the current month, please try again.";
                        lblError.ForeColor = Color.Red;
                        return;
                    }

                    // Check if deductions for this unpaid leave already exist
                    using (SqlCommand cmdCheck = new SqlCommand(
                        @"SELECT COUNT(*) 
                          FROM Deduction
                          WHERE emp_ID = @emp
                            AND type = 'unpaid'
                            AND unpaid_ID = @req;", conn))
                    {
                        cmdCheck.Parameters.AddWithValue("@emp", empId);
                        cmdCheck.Parameters.AddWithValue("@req", requestId.Value);

                        int countDed = Convert.ToInt32(cmdCheck.ExecuteScalar());
                        if (countDed > 0)
                        {
                            string scriptAlready =
                                "alert('Deductions have been already added to this employee, please try again');";
                            ClientScript.RegisterStartupScript(
                                this.GetType(),
                                "DedUnpaidAlready",
                                scriptAlready,
                                true
                            );
                            return;
                        }
                    }

                    // Call stored procedure Deduction_unpaid
                    using (SqlCommand cmdProc = new SqlCommand("Deduction_unpaid", conn))
                    {
                        cmdProc.CommandType = System.Data.CommandType.StoredProcedure;
                        cmdProc.Parameters.AddWithValue("@employee_ID", empId);
                        cmdProc.ExecuteNonQuery();
                    }

                    // Load deduction rows for this month (type unpaid)
                    DateTime today = DateTime.Today;
                    DateTime firstOfMonth = new DateTime(today.Year, today.Month, 1);

                    DataTable dtDed = new DataTable();
                    using (SqlCommand cmdDed = new SqlCommand(
                        @"SELECT *
                          FROM Deduction
                          WHERE emp_ID = @emp
                            AND type = 'unpaid'
                            AND [date] >= @fromDate
                            AND [date] <= @toDate;", conn))
                    {
                        cmdDed.Parameters.AddWithValue("@emp", empId);
                        cmdDed.Parameters.AddWithValue("@fromDate", firstOfMonth);
                        cmdDed.Parameters.AddWithValue("@toDate", today);

                        SqlDataAdapter daDed = new SqlDataAdapter(cmdDed);
                        daDed.Fill(dtDed);
                    }

                    bool hasDeduction = dtDed.Rows.Count > 0;
                    decimal totalAmount = 0m;
                    if (hasDeduction)
                    {
                        foreach (DataRow row in dtDed.Rows)
                        {
                            if (row["amount"] != DBNull.Value)
                                totalAmount += Convert.ToDecimal(row["amount"]);
                        }
                    }

                    Session["DedUnpaidEmpID"] = empId;
                    Session["DedUnpaidHasDeduction"] = hasDeduction;
                    Session["DedUnpaidAmount"] = totalAmount;

                    string alertMsg = hasDeduction
                        ? "Deductions have been added successfully"
                        : "No deductions to be calculated";

                    string script =
                        "alert('" + alertMsg.Replace("'", "\\'") +
                        "'); window.location='deductionUnpaid.aspx';";

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "DedUnpaidMsg",
                        script,
                        true
                    );
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error while calculating unpaid deductions: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }
    }
}