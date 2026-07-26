using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Team75
{
    public partial class AddHolidayConfirm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadHolidays();
        }

        private void LoadHolidays()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Holiday", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridViewHolidays.DataSource = dt;
                GridViewHolidays.DataBind();
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            string name = txtHolidayName.Text.Trim();
            string from = txtFromDate.Text.Trim();
            string to = txtToDate.Text.Trim();

            if (string.IsNullOrWhiteSpace(name) ||
                string.IsNullOrWhiteSpace(from) ||
                string.IsNullOrWhiteSpace(to))
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(),
                    "alert",
                    "alert('Please fill all holiday fields.');",
                    true
                );
                return;
            }

            // Pass values to result page via query string
            string url = "AddHolidayResult.aspx?name=" + Server.UrlEncode(name) +
                         "&from=" + Server.UrlEncode(from) +
                         "&to=" + Server.UrlEncode(to);

            Response.Redirect(url);
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            // Cancel and go back to Admin
            Response.Redirect("Admin.aspx");
        }
    }
}
