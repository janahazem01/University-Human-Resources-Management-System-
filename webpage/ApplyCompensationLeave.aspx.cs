using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Team75
{
    public partial class ApplyCompensationLeave : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["EmployeeID"] == null)
                {
                    Response.Redirect("academic_login.aspx");
                    return;
                }

                lblEmployeeID.Text = Session["EmployeeID"].ToString();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Session["EmployeeID"] == null ||
                !int.TryParse(Session["EmployeeID"].ToString(), out int employeeId))
            {
                Response.Redirect("academicemployee_login.aspx");
                return;
            }

            if (!DateTime.TryParse(txtCompDate.Text, out DateTime compDate) ||
                !DateTime.TryParse(txtOriginalDate.Text, out DateTime origDate))
            {
                lblMessage.Text = "Please enter valid dates.";
                return;
            }

            string reason = txtReason.Text.Trim();
            if (string.IsNullOrWhiteSpace(reason))
            {
                lblMessage.Text = "Please enter a valid reason.";
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

            // === STEP 1: Auto-fetch replacement employee from backend ===
            int replacementId = employeeId;  // default if none returned

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand(@"
                SELECT emp2_id 
                FROM Employee_Replace_Employee
                WHERE Emp1_ID = @id
                  AND CURRENT_TIMESTAMP BETWEEN from_date AND to_date;", conn))
            {
                cmd.Parameters.AddWithValue("@id", employeeId);
                conn.Open();
                object result = cmd.ExecuteScalar();

                if (result != null)
                    replacementId = Convert.ToInt32(result);
            }

            // === STEP 2: Call stored procedure ===
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("Submit_compensation", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@employee_ID", employeeId);
                    cmd.Parameters.AddWithValue("@compensation_date", compDate);
                    cmd.Parameters.AddWithValue("@reason", reason);
                    cmd.Parameters.AddWithValue("@date_of_original_workday", origDate);
                    cmd.Parameters.AddWithValue("@rep_emp_id", replacementId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                string script =
                    "alert('Compensation leave submitted successfully.'); " +
                    "window.location='CompensationLeaveSubmission.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "ok", script, true);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error submitting leave: " + ex.Message;
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
