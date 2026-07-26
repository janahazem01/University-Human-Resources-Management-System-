using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

namespace Team75
{
    public partial class verify_deductionDays : System.Web.UI.Page
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

                gridAttendance.Visible = false;
                btnProceed.Visible = false;
            }
        }

        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("HR_Home.aspx");
        }

        // 1) Load attendance rows for this employee for the current month
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
                gridAttendance.Visible = false;
                btnProceed.Visible = false;
                return;
            }

            DateTime today = DateTime.Today;
            DateTime firstOfMonth = new DateTime(today.Year, today.Month, 1);

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    // Check if there are any attendance rows for this month
                    using (SqlCommand cmdCount = new SqlCommand(
                        @"SELECT COUNT(*) 
                          FROM Attendance
                          WHERE emp_ID = @emp
                            AND [date] >= @fromDate
                            AND [date] <= @toDate;", conn))
                    {
                        cmdCount.Parameters.AddWithValue("@emp", empId);
                        cmdCount.Parameters.AddWithValue("@fromDate", firstOfMonth);
                        cmdCount.Parameters.AddWithValue("@toDate", today);

                        int count = Convert.ToInt32(cmdCount.ExecuteScalar());
                        if (count == 0)
                        {
                            lblError.Text = "This ID has no attendance records, please try again";
                            lblError.ForeColor = Color.Red;
                            gridAttendance.Visible = false;
                            btnProceed.Visible = false;
                            return;
                        }
                    }

                    // Load attendance rows
                    using (SqlCommand cmd = new SqlCommand(
                        @"SELECT * 
                          FROM Attendance
                          WHERE emp_ID = @emp
                            AND [date] >= @fromDate
                            AND [date] <= @toDate
                          ORDER BY [date];", conn))
                    {
                        cmd.Parameters.AddWithValue("@emp", empId);
                        cmd.Parameters.AddWithValue("@fromDate", firstOfMonth);
                        cmd.Parameters.AddWithValue("@toDate", today);

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gridAttendance.DataSource = dt;
                        gridAttendance.DataBind();
                        gridAttendance.Visible = true;
                        btnProceed.Visible = true;

                        // remember employee for the next page
                        Session["DedDaysEmpID"] = empId;
                    }
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error while loading attendance records: " + ex.Message;
                lblError.ForeColor = Color.Red;
                gridAttendance.Visible = false;
                btnProceed.Visible = false;
            }
        }

        // 2) Call Deduction_days, protect from duplicates, and redirect to summary
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

            DateTime today = DateTime.Today;
            DateTime firstOfMonth = new DateTime(today.Year, today.Month, 1);

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    // --- check if deductions for missing_days already exist for this month ---
                    DataTable dtExisting = new DataTable();
                    using (SqlCommand cmdCheck = new SqlCommand(
                        @"SELECT *
                          FROM Deduction
                          WHERE emp_ID = @emp
                            AND type = 'missing_days'
                            AND [date] >= @fromDate
                            AND [date] <= @toDate;", conn))
                    {
                        cmdCheck.Parameters.AddWithValue("@emp", empId);
                        cmdCheck.Parameters.AddWithValue("@fromDate", firstOfMonth);
                        cmdCheck.Parameters.AddWithValue("@toDate", today);

                        SqlDataAdapter daCheck = new SqlDataAdapter(cmdCheck);
                        daCheck.Fill(dtExisting);
                    }

                    if (dtExisting.Rows.Count > 0)
                    {
                        string scriptAlready =
                            "alert('Deductions have been already added to this employee, please try again');";
                        ClientScript.RegisterStartupScript(
                            this.GetType(),
                            "DedDaysAlready",
                            scriptAlready,
                            true
                        );
                        return;
                    }
                    // -----------------------------------------------------------------------

                    // Call stored procedure to compute new deductions if needed
                    using (SqlCommand cmdProc = new SqlCommand("Deduction_days", conn))
                    {
                        cmdProc.CommandType = CommandType.StoredProcedure;
                        cmdProc.Parameters.AddWithValue("@employee_id", empId);
                        cmdProc.ExecuteNonQuery();
                    }

                    // Now read the deductions for this month
                    DataTable dtDed = new DataTable();
                    using (SqlCommand cmdDed = new SqlCommand(
                        @"SELECT *
                          FROM Deduction
                          WHERE emp_ID = @emp
                            AND type = 'missing_days'
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

                    // store for summary page
                    Session["DedDaysEmpID"] = empId;
                    Session["DedDaysHasDeduction"] = hasDeduction;
                    Session["DedDaysAmount"] = totalAmount;

                    string alertMsg = hasDeduction
                        ? "Deductions have been added successfully"
                        : "No deductions to be calculated";

                    string script =
                        "alert('" + alertMsg.Replace("'", "\\'") +
                        "'); window.location='deductionDays.aspx';";

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "DedDaysMsg",
                        script,
                        true
                    );
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error while calculating deductions: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }
    }
}