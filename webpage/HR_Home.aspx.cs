using System;

namespace Team75
{
    public partial class HR_Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Welcome message removed intentionally
        }

        protected void btnApproveAnnualAccidental_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_approveAnnualAccidental.aspx");
        }

        protected void btnApproveUnpaid_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_Unpaid.aspx");
        }

        protected void btnApproveCompensation_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_Compensation.aspx");
        }

        protected void btnDeductHours_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_deductionHours.aspx");
        }

        protected void btnDeductDays_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_deductionDays.aspx");
        }

        protected void btnDeductUnpaid_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_deductionUnpaid.aspx");
        }

        protected void btnPayroll_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_GenPayroll.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Clear HR session
            Session["HR_ID"] = null;
            Response.Redirect("Role.aspx");
        }
    }
}
