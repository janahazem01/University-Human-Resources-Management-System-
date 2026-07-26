using System;
using System.Web.UI;

namespace Team75
{
    public partial class AcademicEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnPerformance_Click(object sender, EventArgs e)
        {
            Response.Redirect("Performance.aspx");
        }

        protected void btnAttendanceRecords_Click(object sender, EventArgs e)
        {
            Response.Redirect("AttendanceInput.aspx");
        }

        protected void btnLastMonthPayroll_Click(object sender, EventArgs e)
        {
            Response.Redirect("Payroll.aspx");
        }

        protected void btnDeductions_Click(object sender, EventArgs e)
        {
            Response.Redirect("Deductions.aspx");
        }

        protected void btnApplyForLeave_Click(object sender, EventArgs e)
        {
            Response.Redirect("ChooseLeaveType.aspx");
        }

        protected void btnLeaveStatus_Click(object sender, EventArgs e)
        {
            Response.Redirect("LeaveStatus.aspx");
        }

        protected void btnApproveUnpaid_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApproveUnpaidLeave.aspx");
        }

        protected void btnApproveAnnual_Click(object sender, EventArgs e)
        {
            Response.Redirect("ApproveAnnualLeave.aspx");
        }

        protected void btnEvaluation_Click(object sender, EventArgs e)
        {
            Response.Redirect("EvaluateEmployees.aspx");
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Role.aspx");
        }
    }
}
