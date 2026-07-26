using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Team75
{
    public partial class LeaveStatus : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Security: must be logged in
                if (Session["EmployeeID"] == null)
                {
                    Response.Redirect("academic_login.aspx");
                    return;
                }

                if (!int.TryParse(Session["EmployeeID"].ToString(), out int employeeId))
                {
                    Session.Clear();
                    Response.Redirect("academic_login.aspx");
                    return;
                }

                lblEmployeeID.Text = employeeId.ToString();
                LoadLeaveStatus(employeeId);
            }
        }

        private void LoadLeaveStatus(int employeeId)
        {
            try
            {
                string connStr = ConfigurationManager
                                 .ConnectionStrings["Team75"]
                                 .ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM dbo.status_leaves(@EmployeeID)", conn))
                {
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();

                    conn.Open();
                    da.Fill(dt);

                    gvLeaveStatus.DataSource = dt;
                    gvLeaveStatus.DataBind();

                    if (dt.Rows.Count > 0)
                    {
                        lblMessage.Text = $"Found {dt.Rows.Count} leave request(s) for this month.";
                    }
                    else
                    {
                        lblMessage.Text = "You have no annual or accidental leave requests for this month.";
                    }

                    // Success alert
                    string script = "alert('Leave status retrieved successfully.');";
                    ClientScript.RegisterStartupScript(this.GetType(), "Success", script, true);
                }
            }
            catch (Exception ex)
            {
                gvLeaveStatus.DataSource = null;
                gvLeaveStatus.DataBind();
                lblMessage.Text = "Error retrieving leave status: " + ex.Message;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
