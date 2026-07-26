using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace Team75
{
    public partial class Payroll : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadPayroll();
        }

        private void LoadPayroll()
        {
            // Ensure user is logged in and we have their ID
            if (Session["EmployeeId"] == null)   // matches AcademicEmployee login
            {
                // Not logged in → redirect to academic login (adjust page name if needed)
                Response.Redirect("AcademicEmployee_login.aspx");
                return;
            }

            if (!int.TryParse(Session["EmployeeId"].ToString(), out int employeeId))
            {
                lblMessage.Text = "Invalid employee session. Please log in again.";
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    // Use your table-valued function Last_month_payroll(@employee_ID)
                    string query = "SELECT * FROM Last_month_payroll(@EmpID)";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@EmpID", employeeId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    conn.Open();
                    da.Fill(dt);

                    if (dt.Rows.Count == 0)
                    {
                        lblMessage.Text = "No payroll records found for last month.";
                    }
                    else
                    {
                        lblMessage.Text = "Below is your payroll for last month:";
                    }

                    GridViewPayroll.DataSource = dt;
                    GridViewPayroll.DataBind();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error retrieving payroll: " + ex.Message;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
