using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Drawing;

namespace Team75
{
    public partial class verify_replaceEmployee : System.Web.UI.Page
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

        protected void btnProceed_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblMessage.ForeColor = Color.Black;

            // 1) Validate inputs
            if (!int.TryParse(txtEmp1.Text.Trim(), out int emp1Id))
            {
                lblMessage.Text = "Please enter a valid numeric Emp1_ID.";
                lblMessage.ForeColor = Color.Red;
                return;
            }

            if (!int.TryParse(txtEmp2.Text.Trim(), out int emp2Id))
            {
                lblMessage.Text = "Please enter a valid numeric Emp2_ID.";
                lblMessage.ForeColor = Color.Red;
                return;
            }

            if (!DateTime.TryParse(txtFrom.Text.Trim(), out DateTime fromDate))
            {
                lblMessage.Text = "Please enter a valid From Date (YYYY-MM-DD).";
                lblMessage.ForeColor = Color.Red;
                return;
            }

            if (!DateTime.TryParse(txtTo.Text.Trim(), out DateTime toDate))
            {
                lblMessage.Text = "Please enter a valid To Date (YYYY-MM-DD).";
                lblMessage.ForeColor = Color.Red;
                return;
            }

            string connectionString =
                ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

            try
            {
                int rowsAffected;

                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("Replace_employee", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    // Parameter names must match the procedure exactly
                    cmd.Parameters.AddWithValue("@Emp1_ID", emp1Id);
                    cmd.Parameters.AddWithValue("@Emp2_ID", emp2Id);
                    cmd.Parameters.AddWithValue("@from_date", fromDate);
                    cmd.Parameters.AddWithValue("@to_date", toDate);

                    conn.Open();
                    rowsAffected = cmd.ExecuteNonQuery();
                }

                // The procedure only INSERTs when everything is valid
                if (rowsAffected > 0)
                {
                    string script =
                        "alert('The employee has been successfully replaced.');" +
                        "window.location='replaceEmployee.aspx';";

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "ReplaceSuccess",
                        script,
                        true
                    );
                }
                else
                {
                    lblMessage.Text = "Replacement cannot take place.";
                    lblMessage.ForeColor = Color.Red;
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error while replacing employee: " + ex.Message;
                lblMessage.ForeColor = Color.Red;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            // "Home" button → Admin home page
            Response.Redirect("Admin.aspx");
        }
    }
}
