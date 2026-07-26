using System;
using System.Web.UI;

namespace Team75
{
    public partial class ChooseLeaveType : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnAnnual_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApplyAnnualLeave.aspx");
        }

        protected void btnAccidental_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApplyAccidentalLeave.aspx");
        }

        protected void btnMedical_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApplyMedicalLeave.aspx");
        }

        protected void btnUnpaid_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApplyUnpaidLeave.aspx");
        }

        protected void btnCompensation_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApplyCompensationLeave.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
