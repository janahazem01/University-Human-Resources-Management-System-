using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

namespace Team75
{
    public partial class verify_unattended : System.Web.UI.Page
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

        protected void btnProceed_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblMessage.ForeColor = Color.Black;

            if (!int.TryParse(txtEmpId.Text.Trim(), out int employeeId))
            {
                lblMessage.Text = "Please enter a valid numeric Employee ID.";
                lblMessage.ForeColor = Color.Red;
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

            try
            {
                int rowsAffected;

                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("Remove_DayOff", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_ID", employeeId);

                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();
                }

                if (rowsAffected <= 0)
                {
                    lblMessage.Text = "This employee has no attendance record on their official day off for the current month.";
                    lblMessage.ForeColor = Color.Red;
                }
                else
                {
                    string script =
                        "alert('Unattended official day-off attendance records have been removed successfully.');" +
                        "window.location='remove_unattended.aspx';";

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "DayOffRemoved",
                        script,
                        true
                    );
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error removing unattended day-off records: " + ex.Message;
                lblMessage.ForeColor = Color.Red;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
