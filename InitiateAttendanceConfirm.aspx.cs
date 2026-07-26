using System;
using System.Web.UI;

namespace Team75
{
    public partial class InitiateAttendanceConfirm : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblToday.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            Response.Redirect("InitiateAttendanceResult.aspx");
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
