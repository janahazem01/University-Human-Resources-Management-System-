using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Team75
{
    public partial class EvaluateEmployees : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return WebConfigurationManager.ConnectionStrings["Team75"].ToString();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblStatus.Text = "";

                // 1) Get logged-in employee ID from session
                object idObj = Session["EmployeeID"];
                if (idObj == null || !int.TryParse(idObj.ToString(), out int currentEmpId))
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "noSession",
                        "alert('Your session has expired. Please log in again.'); window.location='Role.aspx';",
                        true
                    );
                    return;
                }

                // 2) Check if this employee is a Dean
                string role = GetEmployeeTopRole(currentEmpId);
                if (!"Dean".Equals(role, StringComparison.OrdinalIgnoreCase))
                {
                    // Not a dean → show alert and send back
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "notDean",
                        "alert('This action cannot be done as you are not a Dean.'); window.location='AcademicEmployee.aspx';",
                        true
                    );
                    return;
                }

                // 3) They are a Dean → load data
                lblStatus.Text = $"You are logged in as Dean (Employee ID: {currentEmpId}).";
                lblStatus.CssClass = "message success";

                LoadEmployees();
                LoadPerformance();
            }
        }

        private string GetEmployeeTopRole(int empId)
        {
            string connStr = GetConnectionString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT TOP 1 er.role_name
                    FROM Employee_Role er
                    INNER JOIN Role r ON er.role_name = r.role_name
                    WHERE er.emp_ID = @EmpID
                    ORDER BY r.rank ASC;";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@EmpID", empId);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                        return result.ToString();
                }
            }

            return null;
        }

        private void LoadEmployees()
        {
            string connStr = GetConnectionString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT employee_id FROM Employee ORDER BY employee_id;";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        ddlEmployees.DataSource = reader;
                        ddlEmployees.DataValueField = "employee_id";
                        ddlEmployees.DataTextField = "employee_id";
                        ddlEmployees.DataBind();
                    }
                }
            }

            ddlEmployees.Items.Insert(0, new ListItem("-- Select Employee --", ""));
        }

        private void LoadPerformance()
        {
            string connStr = GetConnectionString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM Performance ORDER BY emp_ID, semester;";

                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvPerformance.DataSource = dt;
                    gvPerformance.DataBind();
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblStatus.Text = "";
            lblStatus.CssClass = "message";

            // Basic validation
            if (string.IsNullOrEmpty(ddlEmployees.SelectedValue))
            {
                lblStatus.Text = "Please select an employee.";
                lblStatus.CssClass = "message error";
                return;
            }

            if (!int.TryParse(txtRating.Text.Trim(), out int rating))
            {
                lblStatus.Text = "Rating must be an integer.";
                lblStatus.CssClass = "message error";
                return;
            }

            string semester = txtSemester.Text.Trim();
            if (string.IsNullOrEmpty(semester) || semester.Length > 3)
            {
                lblStatus.Text = "Semester must be 1–3 characters (e.g., F23).";
                lblStatus.CssClass = "message error";
                return;
            }

            string comment = txtComment.Text.Trim();
            if (comment.Length > 50)
            {
                lblStatus.Text = "Comment cannot exceed 50 characters.";
                lblStatus.CssClass = "message error";
                return;
            }

            int empId = int.Parse(ddlEmployees.SelectedValue);

            try
            {
                SaveEvaluation(empId, rating, comment, semester);

                // Reload grid to show new row
                LoadPerformance();

                // Clear inputs
                ddlEmployees.SelectedIndex = 0;
                txtRating.Text = "";
                txtSemester.Text = "";
                txtComment.Text = "";

                string js = "alert('Evaluation has been saved successfully.');";
                ClientScript.RegisterStartupScript(this.GetType(), "evalSaved", js, true);
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Error saving evaluation: " + ex.Message;
                lblStatus.CssClass = "message error";
            }
        }

        private void SaveEvaluation(int employeeId, int rating, string comment, string semester)
        {
            string connStr = GetConnectionString();

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("Dean_andHR_Evaluation", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@employee_ID", employeeId);
                cmd.Parameters.AddWithValue("@rating", rating);
                cmd.Parameters.AddWithValue("@comment", comment);
                cmd.Parameters.AddWithValue("@semester", semester);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
