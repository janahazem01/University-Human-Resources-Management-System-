using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;

namespace Team75
{
    public partial class verify_GenPayroll : System.Web.UI.Page
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
                    lblHR.Text = "Your HR ID is: " + Session["HR_ID"];
                    lblHR.ForeColor = Color.Black;
                }
                else
                {
                    lblHR.Text = "Your HR ID is: (not found in session)";
                    lblHR.ForeColor = Color.Red;
                    lblError.Text = "HR ID not found in session. Please log in again.";
                }
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("HR_Home.aspx");
        }

        protected void btnProceed_Click(object sender, EventArgs e)
        {
            lblError.Text = string.Empty;

            if (!int.TryParse(txtEmpId.Text.Trim(), out int empId))
            {
                lblError.Text = "Please enter a valid numeric Employee ID.";
                lblError.ForeColor = Color.Red;
                return;
            }

            if (!DateTime.TryParse(txtFrom.Text.Trim(), out DateTime fromDate) ||
                !DateTime.TryParse(txtTo.Text.Trim(), out DateTime toDate))
            {
                lblError.Text = "Please enter valid From and To dates.";
                lblError.ForeColor = Color.Red;
                return;
            }

            if (fromDate > toDate)
            {
                lblError.Text = "From date cannot be after To date.";
                lblError.ForeColor = Color.Red;
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    // 1) Check employee exists
                    using (SqlCommand cmdCheckEmp = new SqlCommand(
                        "SELECT COUNT(*) FROM Employee WHERE employee_id = @id", conn))
                    {
                        cmdCheckEmp.Parameters.AddWithValue("@id", empId);
                        int exists = (int)cmdCheckEmp.ExecuteScalar();
                        if (exists == 0)
                        {
                            ClientScript.RegisterStartupScript(
                                this.GetType(),
                                "InvalidEmp",
                                "alert('This employee ID is invalid, please try again');",
                                true
                            );
                            return;
                        }
                    }

                    // 2) Check if payroll already exists for this period
                    using (SqlCommand cmdCheckPay = new SqlCommand(
                        @"SELECT COUNT(*) 
                          FROM Payroll 
                          WHERE emp_ID = @id AND from_date = @from AND to_date = @to", conn))
                    {
                        cmdCheckPay.Parameters.AddWithValue("@id", empId);
                        cmdCheckPay.Parameters.AddWithValue("@from", fromDate.Date);
                        cmdCheckPay.Parameters.AddWithValue("@to", toDate.Date);

                        int exists = (int)cmdCheckPay.ExecuteScalar();
                        if (exists > 0)
                        {
                            // Save the period in session so GenPayroll can display it
                            Session["LastPayrollEmpId"] = empId;
                            Session["LastPayrollFrom"] = fromDate.Date;
                            Session["LastPayrollTo"] = toDate.Date;

                            // ALERT + REDIRECT to GenPayroll (question will be visible there)
                            ClientScript.RegisterStartupScript(
                                this.GetType(),
                                "PayrollExists",
                                "alert('Payroll has already been generated for this employee, try another employee'); " +
                                "window.location='GenPayroll.aspx';",
                                true
                            );
                            return;
                        }
                    }

                    // 3) Generate payroll via stored procedure
                    using (SqlCommand cmd = new SqlCommand("Add_Payroll", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@employee_ID", empId);
                        cmd.Parameters.AddWithValue("@from", fromDate.Date);
                        cmd.Parameters.AddWithValue("@to", toDate.Date);
                        cmd.ExecuteNonQuery();
                    }

                    // 4) Save context for GenPayroll
                    Session["LastPayrollEmpId"] = empId;
                    Session["LastPayrollFrom"] = fromDate.Date;
                    Session["LastPayrollTo"] = toDate.Date;

                    // 5) Success alert + redirect
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "PayrollOK",
                        "alert('Payroll has been generated successfully for this employee'); " +
                        "window.location='GenPayroll.aspx';",
                        true
                    );
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error generating payroll: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }
    }
}