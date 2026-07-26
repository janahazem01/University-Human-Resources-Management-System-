using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Team75
{
    public partial class Performance : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Ensure user is logged in
                if (Session["EmployeeID"] == null)
                {
                    Response.Redirect("login_page.aspx");
                    return;
                }

                // Validate numeric ID
                if (!int.TryParse(Session["EmployeeID"].ToString(), out int loggedInId))
                {
                    Session.Clear();
                    Response.Redirect("login_page.aspx");
                    return;
                }

                // Display logged-in ID
                lblEmployeeID.Text = loggedInId.ToString();

                gvPerformance.DataSource = null;
                gvPerformance.DataBind();
                lblMessage.Text = "";
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            // Re-check session
            if (Session["EmployeeID"] == null ||
                !int.TryParse(Session["EmployeeID"].ToString(), out int employeeId))
            {
                Response.Redirect("login_page.aspx");
                return;
            }

            // Semester validation
            string semester = txtSemester.Text.Trim().ToUpper();
            if (string.IsNullOrWhiteSpace(semester))
            {
                lblMessage.Text = "Please enter a semester/period (e.g., W23, S24).";
                gvPerformance.DataSource = null;
                gvPerformance.DataBind();
                return;
            }

            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM dbo.MyPerformance(@EmpID, @Semester)", conn))
                {
                    cmd.Parameters.AddWithValue("@EmpID", employeeId);
                    cmd.Parameters.AddWithValue("@Semester", semester);

                    conn.Open();
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvPerformance.DataSource = dt;
                    gvPerformance.DataBind();

                    lblMessage.Text = dt.Rows.Count > 0
                        ? $"Found {dt.Rows.Count} record(s) for {semester}."
                        : "No performance records found.";
                }
            }
            catch (Exception ex)
            {
                gvPerformance.DataSource = null;
                gvPerformance.DataBind();
                lblMessage.Text = "Error retrieving performance: " + ex.Message;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
