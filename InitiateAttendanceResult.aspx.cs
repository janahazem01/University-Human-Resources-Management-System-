using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace Team75
{
    public partial class InitiateAttendanceResult : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                RunProcedureAndLoadTable();
        }

        private void ShowMessage(string msg)
        {
            lblMessage.Text = msg;

            string safe = msg.Replace("'", "\\'");
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "alertMessage",
                $"alert('{safe}');",
                true
            );
        }

        private void RunProcedureAndLoadTable()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Run Initiate_Attendance procedure
                    using (SqlCommand cmd = new SqlCommand("Initiate_Attendance", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                    }

                    // Load updated attendance table
                    using (SqlDataAdapter da = new SqlDataAdapter(
                        "SELECT * FROM Attendance ORDER BY [date], emp_ID", conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        GridViewAttendance.DataSource = dt;
                        GridViewAttendance.DataBind();
                    }
                }

                ShowMessage("Attendance successfully initiated for today.");
            }
            catch (Exception ex)
            {
                ShowMessage("Error while initiating attendance: " + ex.Message);
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
