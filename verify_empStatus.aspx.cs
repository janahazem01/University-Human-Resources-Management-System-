using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

namespace Team75
{
    public partial class verify_empStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployees();
            }
        }

        private void LoadEmployees()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Employee;";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();

                da.Fill(dt);
                GridViewEmployees.DataSource = dt;
                GridViewEmployees.DataBind();
            }
        }

        protected void btnProceed_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblMessage.ForeColor = Color.Black;

            if (!int.TryParse(txtEmpId.Text.Trim(), out int employeeId))
            {
                lblMessage.Text = "Please enter a valid numeric Employee ID.";
                lblMessage.ForeColor = Color.Red;
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

            try
            {
                string beforeStatus = null;
                string afterStatus = null;

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    // 1) Get status BEFORE running the procedure
                    using (SqlCommand cmdBefore = new SqlCommand(
                        "SELECT employment_status FROM Employee WHERE employee_ID = @ID", conn))
                    {
                        cmdBefore.Parameters.AddWithValue("@ID", employeeId);
                        object result = cmdBefore.ExecuteScalar();

                        if (result == null || result == DBNull.Value)
                        {
                            lblMessage.Text = "Employee not found.";
                            lblMessage.ForeColor = Color.Red;
                            return;
                        }

                        beforeStatus = Convert.ToString(result);
                    }

                    // 2) Call stored procedure Update_Employment_Status
                    using (SqlCommand cmdProc = new SqlCommand("Update_Employment_Status", conn))
                    {
                        cmdProc.CommandType = CommandType.StoredProcedure;
                        cmdProc.Parameters.AddWithValue("@Employee_ID", employeeId);
                        cmdProc.ExecuteNonQuery();
                    }

                    // 3) Get status AFTER running the procedure
                    using (SqlCommand cmdAfter = new SqlCommand(
                        "SELECT employment_status FROM Employee WHERE employee_ID = @ID", conn))
                    {
                        cmdAfter.Parameters.AddWithValue("@ID", employeeId);
                        object result = cmdAfter.ExecuteScalar();

                        afterStatus = (result == null || result == DBNull.Value)
                            ? null
                            : Convert.ToString(result);
                    }
                }

                // 4) Compare before/after
                if (!string.IsNullOrEmpty(beforeStatus) &&
                    !string.IsNullOrEmpty(afterStatus) &&
                    !string.Equals(beforeStatus, afterStatus, StringComparison.OrdinalIgnoreCase))
                {
                    string script =
                        "alert('Employment status has been successfully updated.');" +
                        "window.location='empStatus.aspx';";

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "StatusUpdated",
                        script,
                        true
                    );
                }
                else
                {
                    lblMessage.Text = "Status stayed the same for this employee, no need to change.";
                    lblMessage.ForeColor = Color.Red;
                    LoadEmployees();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error updating employment status: " + ex.Message;
                lblMessage.ForeColor = Color.Red;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
