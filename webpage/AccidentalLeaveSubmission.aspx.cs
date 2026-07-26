using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Team75
{
    public partial class AccidentalLeaveSubmission : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Security: must be logged in
                if (Session["EmployeeID"] == null)
                {
                    Response.Redirect("academicEmployee_login.aspx");
                    return;
                }

                if (!int.TryParse(Session["EmployeeID"].ToString(), out int employeeId))
                {
                    Session.Clear();
                    Response.Redirect("academicEmployee_login.aspx");
                    return;
                }

                lblEmployeeID.Text = employeeId.ToString();
                LoadAccidentalLeaves(employeeId);
            }
        }

        private void LoadAccidentalLeaves(int employeeId)
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
                        L.start_date,
                        L.end_date,
                        L.final_approval_status
                    FROM Leave AS L
                    INNER JOIN Accidental_Leave AS A
                        ON L.request_ID = A.request_ID
                    WHERE A.emp_ID = @EmpID
                    ORDER BY L.date_of_request DESC;", conn))
                {
                    cmd.Parameters.AddWithValue("@EmpID", employeeId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvAccidentalLeaves.DataSource = dt;
                    gvAccidentalLeaves.DataBind();

                    if (dt.Rows.Count > 0)
                    {
                        lblMessage.Text = $"Found {dt.Rows.Count} accidental leave submission(s).";
                    }
                    else
                    {
                        lblMessage.Text = "You have no accidental leave submissions.";
                    }
                }
            }
            catch (Exception ex)
            {
                gvAccidentalLeaves.DataSource = null;
                gvAccidentalLeaves.DataBind();
                lblMessage.Text = "Error loading accidental leave submissions: " + ex.Message;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
