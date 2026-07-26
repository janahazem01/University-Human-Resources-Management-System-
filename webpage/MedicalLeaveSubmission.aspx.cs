using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Team75
{
    public partial class MedicalLeaveSubmission : Page
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
                LoadMedicalLeaves(employeeId);
            }
        }

        private void LoadMedicalLeaves(int employeeId)
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
                        L.final_approval_status,
                        M.type AS medical_type,
                        M.insurance_status,
                        M.disability_details,
                        D.file_name,
                        D.description AS document_description,
                        D.creation_date
                    FROM Leave AS L
                    INNER JOIN Medical_Leave AS M
                        ON L.request_ID = M.request_ID
                    LEFT JOIN Document AS D
                        ON D.medical_ID = L.request_ID
                       AND D.emp_ID = @EmpID
                    WHERE M.Emp_ID = @EmpID
                    ORDER BY L.date_of_request DESC;", conn))
                {
                    cmd.Parameters.AddWithValue("@EmpID", employeeId);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvMedicalLeaves.DataSource = dt;
                    gvMedicalLeaves.DataBind();

                    if (dt.Rows.Count > 0)
                    {
                        lblMessage.Text = $"Found {dt.Rows.Count} medical leave submission(s).";
                    }
                    else
                    {
                        lblMessage.Text = "You have no medical leave submissions.";
                    }
                }
            }
            catch (Exception ex)
            {
                gvMedicalLeaves.DataSource = null;
                gvMedicalLeaves.DataBind();
                lblMessage.Text = "Error loading medical leave submissions: " + ex.Message;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
