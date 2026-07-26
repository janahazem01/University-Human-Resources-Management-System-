using System;
using System.Web.UI;

namespace Team75
{
    public partial class Admin : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        // PART 1 BUTTONS
        protected void btnViewEmployeeProfiles_Click(object sender, EventArgs e)
        {
            Response.Redirect("Employeeview.aspx");
        }

        protected void btnEmployeesPerDept_Click(object sender, EventArgs e)
        {
            Response.Redirect("EmployeesPerDept.aspx");
        }

        protected void btnRejectedMedicalLeaves_Click(object sender, EventArgs e)
        {
            Response.Redirect("RejectedMedicalLeaves.aspx");
        }

        protected void btnRemoveResignedDeductions_Click(object sender, EventArgs e)
        {
            Response.Redirect("RemoveDeductionsConfirm.aspx");
        }

        protected void btnUpdateTodayAttendance_Click(object sender, EventArgs e)
        {
            Response.Redirect("UpdateAttendanceConfirm.aspx");
        }

        protected void btnAddOfficialHoliday_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddHolidayConfirm.aspx");
        }

        protected void btnInitiateTodayAttendance_Click(object sender, EventArgs e)
        {
            Response.Redirect("InitiateAttendanceConfirm.aspx");
        }

        // PART 2 BUTTONS
        protected void btnYesterdayAttendance_Click(object sender, EventArgs e)
        {
            Response.Redirect("yesterdaysAttendance.aspx");
        }

        protected void btnWinterPerformance_Click(object sender, EventArgs e)
        {
            Response.Redirect("allPerformance.aspx");
        }

        protected void btnRemoveHolidayAttendance_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_attendance.aspx");
        }

        protected void btnRemoveUnattendedDayOff_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_unattended.aspx");
        }

        protected void btnRemoveApprovedLeavesFromAttendance_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_approvedleaves.aspx");
        }

        protected void btnReplaceEmployee_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_replaceEmployee.aspx");
        }

        protected void btnUpdateEmploymentStatusDaily_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_empStatus.aspx");
        }

        // LOGOUT BUTTON
        protected void LogoutButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("Role.aspx");
        }
    }
}
