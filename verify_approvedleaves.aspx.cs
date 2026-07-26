using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Drawing;

namespace Team75
{
    public partial class verify_approvedleaves : System.Web.UI.Page
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
            try
            {
                string connectionString =
                    System.Configuration.ConfigurationManager
                    .ConnectionStrings["Team75"].ConnectionString;

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
                lblMessage.Text = "Error loading data: " + ex.Message;
                lblMessage.ForeColor = Color.Red;
            }
        }

        protected void btnProceed_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            lblMessage.ForeColor = Color.Black;

            if (!int.TryParse(txtEmployeeID.Text.Trim(), out int empId))
            {
                lblMessage.Text = "Please enter a valid numeric employee ID.";
                lblMessage.ForeColor = Color.Red;
                return;
            }

            try
            {
                string connectionString =
                    System.Configuration.ConfigurationManager
                    .ConnectionStrings["Team75"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connectionString))
                using (SqlCommand cmd = new SqlCommand("Remove_Approved_Leaves", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@employee_id", SqlDbType.Int).Value = empId;

                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        // Some rows were removed -> show updated table page
                        Response.Redirect("approvedleaves.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "This employee has no approved leave attendance records.";
                        lblMessage.ForeColor = Color.Red;
                        LoadAttendance();
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error executing Remove_Approved_Leaves: " + ex.Message;
                lblMessage.ForeColor = Color.Red;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            // Fixed the path (removed ~)
            Response.Redirect("Admin.aspx");
        }
    }
}
