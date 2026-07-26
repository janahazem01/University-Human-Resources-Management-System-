using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Team75
{
    public partial class CompensationLeaveSubmission : Page
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
                    Response.Redirect("academicEmployee_login.aspx");
                    return;
                }

                lblEmployeeID.Text = employeeId.ToString();
                LoadCompensationLeaves(employeeId);
            }
        }

        private void LoadCompensationLeaves(int employeeId)
        {
            try
            {
                string connStr = ConfigurationManager
                                 .ConnectionStrings["Team75"]
                                 .ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT 
                        L.request_ID,
                        L.date_of_request,
                        L.start_date AS compensation_date,
                        C.date_of_original_workday,
                        C.reason,
                        C.replacement_emp,
                        L.final_approval_status
                    FROM Leave AS L
                    INNER JOIN Compensation_Leave AS C
                        ON L.request_ID = C.request_ID
                    WHERE C.emp_ID = @EmpID
                    ORDER BY L.date_of_request DESC;", conn))
                {
                    cmd.Parameters.AddWithValue("@EmpID", employeeId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvCompLeaves.DataSource = dt;
                    gvCompLeaves.DataBind();

                    if (dt.Rows.Count > 0)
                    {
                        lblMessage.Text = $"Found {dt.Rows.Count} compensation leave submission(s).";
                    }
                    else
                    {
                        lblMessage.Text = "You have no compensation leave submissions.";
                    }
                }
            }
            catch (Exception ex)
            {
                gvCompLeaves.DataSource = null;
                gvCompLeaves.DataBind();
                lblMessage.Text = "Error loading compensation leave submissions: " + ex.Message;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
