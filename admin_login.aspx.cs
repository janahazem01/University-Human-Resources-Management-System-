using System;
using System.Web.UI;

namespace Team75
{
    public partial class admin_login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Label_Error.Text = "";
            }
        }

        // MUST match OnClick="Button_Login_Click" in the .aspx
        protected void Button_Login_Click(object sender, EventArgs e)
        {
            // Hard-coded admin credentials
            const string adminID = "9999";
            const string adminPassword = "admin123";

            string enteredID = txtID.Text.Trim();
            string enteredPassword = txtPassword.Text.Trim();

            Label_Error.Text = "";

            // 1) Validate ID
            if (enteredID != adminID)
            {
                txtID.Text = "";
                Label_Error.Text = "Invalid ID, please re-enter.";
                txtID.Focus();
                return;
            }

            // 2) Validate password
            if (enteredPassword != adminPassword)
            {
                txtPassword.Text = "";
                Label_Error.Text = "Invalid password, please re-enter.";
                txtPassword.Focus();
                return;
            }

            // 3) Success → show alert then go to Admin page
            string successScript =
                "alert('Welcome back! You have successfully logged into the system.');" +
                "window.location='Admin.aspx';";

            ClientScript.RegisterStartupScript(
                this.GetType(),
                "adminLoginSuccess",
                successScript,
                true
            );
        }

        // MUST match OnClick="Button_Back_Click" in the .aspx
        protected void Button_Back_Click(object sender, EventArgs e)
        {
            Response.Redirect("Role.aspx");
        }
    }
}
