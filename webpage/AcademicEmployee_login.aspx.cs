using System;
using System.Data.SqlClient;
using System.Configuration;

namespace Team75
{
    public partial class academic_login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label_Error.Text = "";
        }

        protected void Button_Login_Click(object sender, EventArgs e)
        {
            Label_Error.Text = "";

            // Validate ID
            if (!int.TryParse(txtID.Text.Trim(), out int employeeID))
            {
                Label_Error.Text = "Employee ID must be a number.";
                return;
            }

            string password = txtPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(password))
            {
                Label_Error.Text = "Please enter your password.";
                return;
            }

            try
            {
                string connStr = ConfigurationManager
                                    .ConnectionStrings["Team75"]
                                    .ConnectionString;

                bool success = false;

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT dbo.EmployeeLoginValidation(@employee_ID, @password)", conn))
                {
                    cmd.Parameters.AddWithValue("@employee_ID", employeeID);
                    cmd.Parameters.AddWithValue("@password", password);

                    conn.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null && result != DBNull.Value)
                        success = Convert.ToInt32(result) == 1;
                }

                if (!success)
                {
                    Label_Error.Text = "Invalid ID or password, or you are not an Academic employee.";
                    return;
                }

                // Store session for later use
                Session["EmployeeId"] = employeeID;
                Session["IsLoggedIn"] = true;

                // Redirect with welcome alert
                string script =
                    "alert('Welcome, Academic Employee!');" +
                    "window.location='AcademicEmployee.aspx';";

                ClientScript.RegisterStartupScript(
                    this.GetType(), "loginSuccess", script, true);
            }
            catch (Exception ex)
            {
                Label_Error.Text = "Error during login: " + ex.Message;
            }
        }

        protected void Button_Back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Role.aspx");
        }
    }
}
