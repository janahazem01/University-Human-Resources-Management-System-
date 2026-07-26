using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Team75
{
    public partial class empStatus : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadEmployees();
            }
        }

        private void LoadEmployees()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Employee;";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();

                da.Fill(dt);
                GridViewEmployees.DataSource = dt;
                GridViewEmployees.DataBind();
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_empStatus.aspx");
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
