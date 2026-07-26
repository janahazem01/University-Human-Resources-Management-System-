using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Team75
{
    public partial class AttendanceRecords : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAttendanceRecords();
            }
        }

        private void LoadAttendanceRecords()
        {
            // Check session – must be logged in
            if (Session["EmployeeID"] == null)
            {
                string script = "alert('Session expired. Please log in again.'); window.location='academic_login.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "Expired", script, true);
                return;
            }

            // Get logged-in employee ID
            if (!int.TryParse(Session["EmployeeID"].ToString(), out int employeeId))
            {
                Session.Clear();
                string script = "alert('Invalid session. Please log in again.'); window.location='academic_login.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "InvalidSession", script, true);
                return;
            }

            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM dbo.MyAttendance(@EmployeeID)", conn))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeId);

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvAttendance.DataSource = dt;
                    gvAttendance.DataBind();

                    lblInfo.Text = $"Showing attendance records for Employee ID {employeeId} (current month).";

                    // Success alert
                    string alert = "alert('Attendance records retrieved successfully.');";
                    ClientScript.RegisterStartupScript(this.GetType(), "Success", alert, true);
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error retrieving attendance records: " + ex.Message;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
