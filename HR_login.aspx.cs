using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Drawing;

namespace Team75
{
    public partial class HR_Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LblMessage.Text = string.Empty;
            }
        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            LblMessage.Text = string.Empty;

            string idText = TxtID.Text.Trim();
            string password = TxtPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(idText) || string.IsNullOrWhiteSpace(password))
            {
                LblMessage.Text = "Please enter both ID and password.";
                LblMessage.ForeColor = Color.Red;
                return;
            }

            if (!int.TryParse(idText, out int employeeId))
            {
                LblMessage.Text = "HR ID must be a number.";
                LblMessage.ForeColor = Color.Red;
                return;
            }

            string connStr =
                ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string query = "SELECT dbo.HRLoginValidation(@employee_ID, @password);";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@employee_ID", employeeId);
                        cmd.Parameters.AddWithValue("@password", password);

                        conn.Open();
                        object result = cmd.ExecuteScalar();

                        bool success = false;
                        if (result != null && result != DBNull.Value)
                        {
                            success = Convert.ToBoolean(result);
                        }

                        if (success)
                        {
                            // Store HR_ID in session
                            Session["HR_ID"] = employeeId;

                            string script =
                                "alert('Login happened successfully.'); window.location='HR_Home.aspx';";

                            ClientScript.RegisterStartupScript(
                                this.GetType(),
                                "HRLoginOK",
                                script,
                                true
                            );
                        }
                        else
                        {
                            LblMessage.Text = "Incorrect ID or password, or you are not in the HR department.";
                            LblMessage.ForeColor = Color.Red;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                LblMessage.Text = "Error while checking login: " + ex.Message;
                LblMessage.ForeColor = Color.Red;
            }
        }

        protected void BtnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Role.aspx");
        }
    }
}
