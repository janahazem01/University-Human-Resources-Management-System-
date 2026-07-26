using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace Team75
{
    public partial class replaceEmployee : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadReplaceTable();
            }
        }

        private void LoadReplaceTable()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Employee_Replace_Employee;";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();

                da.Fill(dt);
                GridViewReplace.DataSource = dt;
                GridViewReplace.DataBind();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }

        protected void btnBackVerify_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_replaceEmployee.aspx");
        }
    }
}
