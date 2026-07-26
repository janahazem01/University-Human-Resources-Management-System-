using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Team75
{
    public partial class RemoveDeductionsConfirm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadDeductions();
        }

        private void LoadDeductions()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Deduction";

                SqlDataAdapter da = new SqlDataAdapter(query, conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewDeductions.DataSource = dt;
                GridViewDeductions.DataBind();
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            // Go to page that runs the procedure & shows updated table
            Response.Redirect("RemoveDeductionsResult.aspx");
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            // Back to admin home page
            Response.Redirect("Admin.aspx");
        }
    }
}
