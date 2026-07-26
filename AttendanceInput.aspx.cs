using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace Team75
{
    public partial class AttendanceInput : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Ensure user is logged in
                if (Session["EmployeeID"] == null)
                {
                    // Session missing → go to academic login
                    Response.Redirect("academic_login.aspx");
                    return;
                }

                if (!int.TryParse(Session["EmployeeID"].ToString(), out int loggedInId))
                {
                    Session.Clear();
                    Response.Redirect("academic_login.aspx");
                    return;
                }

                // Show logged-in ID
                lblEmployeeID.Text = loggedInId.ToString();
                lblError.Text = string.Empty;
            }
        }

        protected void btnProceed_Click(object sender, EventArgs e)
        {
            // Re-check session
            if (Session["EmployeeID"] == null ||
                !int.TryParse(Session["EmployeeID"].ToString(), out int loggedInId))
            {
                string script = "alert('Session expired. Please log in again.'); window.location='academic_login.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "Expired", script, true);
                return;
            }

            // Store for consistency if you still want a separate key
            Session["AttendanceRecordsEmployeeId"] = loggedInId;

            // Go to results page
            Response.Redirect("AttendanceRecords.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
