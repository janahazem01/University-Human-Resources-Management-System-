using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Team75
{
    public partial class AnnualLeaveSubmission : Page
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
                LoadPendingAnnualLeaves(employeeId);
            }
        }

        private void LoadPendingAnnualLeaves(int employeeId)
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(
                    @"SELECT  L.request_ID,
                              L.date_of_request,
                              L.start_date,
                              L.end_date,
                              L.final_approval_status
                      FROM    Annual_Leave A
                      INNER JOIN [Leave] L ON A.request_ID = L.request_ID
                      WHERE   A.emp_ID = @EmpID      -- <== FIXED HERE
                        AND   L.final_approval_status = 'pending'
                      ORDER BY L.date_of_request DESC;", conn))
                {
                    cmd.Parameters.AddWithValue("@EmpID", employeeId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    conn.Open();
                    da.Fill(dt);

                    gvAnnualLeaves.DataSource = dt;
                    gvAnnualLeaves.DataBind();

                    if (dt.Rows.Count > 0)
                    {
                        lblMessage.Text = "Your pending annual leave submissions are listed below.";
                    }
                    else
                    {
                        lblMessage.Text = "You currently have no pending annual leave submissions.";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error loading annual leave submissions: " + ex.Message;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
