using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Team75
{
    public partial class remove_unattended : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadAttendance();
        }

        private void LoadAttendance()
        {
            try
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
            catch (Exception ex)
            {
                Response.Write("<h3 style='color:red;'>Error loading updated attendance: " +
                               ex.Message + "</h3>");
            }
        }

        protected void btnConfirmPage_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_unattended.aspx");
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
