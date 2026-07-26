using System;
using System.Web.UI;

namespace Team75
{
    public partial class Role : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("admin_login.aspx");
        }

        protected void btnAcademic_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee_login.aspx");
        }

        protected void btnHR_Click(object sender, EventArgs e)
        {
            Response.Redirect("HR_login.aspx");
        }
    }
}
