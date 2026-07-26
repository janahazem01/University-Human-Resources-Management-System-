using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace Team75
{
    public partial class ApplyAccidentalLeave : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Security: ensure employee is logged in
                if (Session["EmployeeID"] == null)
                {
                    Response.Redirect("academic_login.aspx");
                    return;
                }

                lblEmployeeID.Text = Session["EmployeeID"].ToString();
                lblMessage.Text = "";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            // Re-check session
            if (Session["EmployeeID"] == null ||
                !int.TryParse(Session["EmployeeID"].ToString(), out int employeeId))
            {
                string script = "alert('Session expired. Please log in again.'); window.location='academic_login.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "Expired", script, true);
                return;
            }

            // Validate dates
            if (!DateTime.TryParse(txtStartDate.Text, out DateTime startDate) ||
                !DateTime.TryParse(txtEndDate.Text, out DateTime endDate))
            {
                lblMessage.Text = "Please select valid start and end dates.";
                return;
            }

            if (endDate < startDate)
            {
                lblMessage.Text = "End date cannot be earlier than start date.";
                return;
            }

            try
            {
                string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("Submit_accidental", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@employee_ID", employeeId);
                    cmd.Parameters.AddWithValue("@start_date", startDate);
                    cmd.Parameters.AddWithValue("@end_date", endDate);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // On success, mirror the Annual Leave behavior:
                // show alert then go to a "My Accidental Leave Submissions" page
                string successScript =
                    "alert('Accidental leave submitted successfully.');" +
                    "window.location='AccidentalLeaveSubmission.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "Success", successScript, true);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error submitting accidental leave: " + ex.Message;
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
