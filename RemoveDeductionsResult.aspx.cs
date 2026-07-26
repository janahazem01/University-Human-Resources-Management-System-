using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Team75
{
    public partial class RemoveDeductionsResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                RunProcedureAndLoadTable();
        }

        private void RunProcedureAndLoadTable()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Run stored procedure
                    using (SqlCommand cmd = new SqlCommand("Remove_Deductions", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.ExecuteNonQuery();
                    }

                    // Reload updated table
                    using (SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Deduction", conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        GridViewUpdatedDeductions.DataSource = dt;
                        GridViewUpdatedDeductions.DataBind();
                    }
                }

                lblMessage.Text = "Deductions for resigned employees have been removed successfully.";
                ClientScript.RegisterStartupScript(this.GetType(), "alertMsg",
                    "alert('Deductions for resigned employees have been removed successfully.');", true);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "An error occurred while removing deductions: " + ex.Message;
            }
        }

        protected void btnBackAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
