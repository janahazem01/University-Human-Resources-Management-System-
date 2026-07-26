using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Team75
{
    public partial class verify_attendance : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAttendance();
            }
        }

        private void LoadAttendance()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Attendance;";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewAttendance.DataSource = dt;
                GridViewAttendance.DataBind();
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("Remove_Holiday", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                string script =
                    "alert('Attendance records for employees on official holidays have been removed successfully.');" +
                    "window.location='removed_attendance.aspx';";

                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "HolidayRemoved",
                    script,
                    true
                );
            }
            catch (Exception ex)
            {
                Response.Write("<h3 style='color:red;'>Error removing attendance: " +
                               ex.Message + "</h3>");
            }
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
