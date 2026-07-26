using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

namespace Team75
{
    public partial class verify_deductionHours : System.Web.UI.Page
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
            Response.Redirect("~/HR_Home.aspx");
        }

        // 1) Show attendance records for the month
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

                    // Check if there are attendance records for this month
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

                    // Load attendance rows for this month
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

                        // Save employee ID for the next page
                        Session["DedHoursEmpID"] = empId;
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

        // 2) Call procedure and redirect to summary page
        protected void btnProceed_Click(object sender, EventArgs e)
        {
            lblError.Text = "";

            if (Session["HR_ID"] == null)
            {
                lblError.Text = "HR ID not found in session. Please log in again.";
                return;
            }

            // not currently used but kept for consistency
            int hrId = Convert.ToInt32(Session["HR_ID"]);

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

                    // --- NEW: Check if deductions already exist for this employee this month ---
                    DataTable dtExisting = new DataTable();
                    using (SqlCommand cmdCheckDed = new SqlCommand(
                        @"SELECT * 
                          FROM Deduction
                          WHERE emp_ID = @emp
                            AND type = 'missing_hours'
                            AND [date] >= @fromDate
                            AND [date] <= @toDate;", conn))
                    {
                        cmdCheckDed.Parameters.AddWithValue("@emp", empId);
                        cmdCheckDed.Parameters.AddWithValue("@fromDate", firstOfMonth);
                        cmdCheckDed.Parameters.AddWithValue("@toDate", today);

                        SqlDataAdapter daCheck = new SqlDataAdapter(cmdCheckDed);
                        daCheck.Fill(dtExisting);
                    }

                    if (dtExisting.Rows.Count > 0)
                    {
                        // Already has deductions for this month -> show alert and stop
                        string scriptAlready =
                            "alert('Deductions have been already added to this employee, please try again');";
                        ClientScript.RegisterStartupScript(
                            this.GetType(),
                            "DedHoursAlready",
                            scriptAlready,
                            true
                        );
                        return;
                    }
                    // ------------------------------------------------------------------------


                    // Run the stored procedure to add deduction if needed
                    using (SqlCommand cmdProc = new SqlCommand("Deduction_hours", conn))
                    {
                        cmdProc.CommandType = System.Data.CommandType.StoredProcedure;
                        cmdProc.Parameters.AddWithValue("@employee_ID", empId);
                        cmdProc.ExecuteNonQuery();
                    }

                    // Now see if any deduction for missing_hours was inserted for this month
                    DataTable dtDed = new DataTable();
                    using (SqlCommand cmdDed = new SqlCommand(
                        @"SELECT * 
                          FROM Deduction
                          WHERE emp_ID = @emp
                            AND type = 'missing_hours'
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

                    // Save info for the summary page
                    Session["DedHoursEmpID"] = empId;
                    Session["DedHoursHasDeduction"] = hasDeduction;
                    Session["DedHoursAmount"] = totalAmount;

                    string alertMsg = hasDeduction
                        ? "Deductions have been added successfully"
                        : "No deductions to be calculated";

                    string script =
                        "alert('" + alertMsg.Replace("'", "\\'") +
                        "'); window.location='deductionHours.aspx';";

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "DedHoursMsg",
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