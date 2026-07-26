using System;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Team75
{
    public partial class EmployeesPerDept : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadDepartments();
        }

        private void LoadDepartments()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT DISTINCT Department FROM NoEmployeeDept";

                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();

                SqlDataReader rdr = cmd.ExecuteReader();

                ddlDepartments.DataSource = rdr;
                ddlDepartments.DataTextField = "Department";
                ddlDepartments.DataValueField = "Department";
                ddlDepartments.DataBind();

                conn.Close();
            }

            // Add a default "please select" item at the top
            ddlDepartments.Items.Insert(0, new ListItem("-- Select Department --", ""));
        }

        protected void btnShow_Click(object sender, EventArgs e)
        {
            lblResult.Text = "";  // clear previous

            if (string.IsNullOrEmpty(ddlDepartments.SelectedValue))
            {
                lblResult.Text = "Please select a department first.";
                return;
            }

            string selectedDept = ddlDepartments.SelectedValue;
            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"SELECT [Number of Employees] 
                                 FROM NoEmployeeDept
                                 WHERE Department = @dept";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@dept", selectedDept);

                conn.Open();
                object result = cmd.ExecuteScalar();
                conn.Close();

                if (result != null && result != DBNull.Value)
                {
                    int numEmployees = Convert.ToInt32(result);
                    lblResult.Text = $"Department <b>{selectedDept}</b> has <b>{numEmployees}</b> employee(s).";
                }
                else
                {
                    lblResult.Text = $"No employees found for department <b>{selectedDept}</b>.";
                }
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            // Admin homepage (now labeled "Home")
            Response.Redirect("Admin.aspx");
        }
    }
}
