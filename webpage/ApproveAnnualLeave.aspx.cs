using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Team75
{
    public partial class ApproveAnnualLeave : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            return WebConfigurationManager.ConnectionStrings["Team75"].ToString();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlAnnual.Visible = false;
                lblStatus.Text = "";

                // Get the ID used at login (from session)
                object idObj = Session["EmployeeID"];
                if (idObj == null)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "noSession",
                        "alert('Your session has expired. Please log in again.'); window.location='AcademicEmployee.aspx';",
                        true
                    );
                    return;
                }

                if (!int.TryParse(idObj.ToString(), out int upperboardId))
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "badId",
                        "alert('Invalid employee ID in session.'); window.location='AcademicEmployee.aspx';",
                        true
                    );
                    return;
                }

                string role = GetUpperboardRole(upperboardId);

                if (role == null)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "noRole",
                        "alert('No role found for your employee ID.'); window.location='AcademicEmployee.aspx';",
                        true
                    );
                    return;
                }

                if (role.Equals("Dean", StringComparison.OrdinalIgnoreCase) ||
                    role.Equals("Vice Dean", StringComparison.OrdinalIgnoreCase) ||
                    role.Equals("President", StringComparison.OrdinalIgnoreCase))
                {
                    Session["UpperboardID"] = upperboardId;
                    lblStatus.Text = $"Access granted. You are logged in as Employee {upperboardId} ({role}).";
                    lblStatus.CssClass = "message success";

                    pnlAnnual.Visible = true;
                    LoadAnnualRequests();
                }
                else
                {
                    Session["UpperboardID"] = null;
                    lblStatus.Text = "";

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "notAllowed",
                        "alert('This action cannot be done as you are not a Dean, Vice Dean, or President.'); window.location='AcademicEmployee.aspx';",
                        true
                    );
                }
            }
        }

        private string GetUpperboardRole(int empId)
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

        // Load annual leave requests
        private void LoadAnnualRequests()
        {
            string connStr = GetConnectionString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // NOTE: replacement_emp is selected but not displayed; it's used in DataKeys
                string query = @"
                    SELECT 
                        a.request_ID,
                        a.Emp_ID,
                        l.start_date,
                        l.end_date,
                        l.final_approval_status,
                        a.replacement_emp
                    FROM Annual_Leave a
                    INNER JOIN Leave l ON a.request_ID = l.request_ID
                    ORDER BY a.request_ID;";

                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvAnnual.DataSource = dt;
                    gvAnnual.DataBind();
                }
            }
        }

        // Handle Approve/Reject button per row (SP decides approve/reject)
        protected void gvAnnual_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ProcessReq")
            {
                if (Session["UpperboardID"] == null)
                {
                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "verifyAgain",
                        "alert('Please log in again to perform this action.'); window.location='AcademicEmployee.aspx';",
                        true
                    );
                    pnlAnnual.Visible = false;
                    return;
                }

                int upperboardId = (int)Session["UpperboardID"];
                int rowIndex = Convert.ToInt32(e.CommandArgument);

                // Get request_ID and replacement_emp from DataKeys
                var keys = gvAnnual.DataKeys[rowIndex];
                int requestId = Convert.ToInt32(keys["request_ID"]);

                // replacement_emp might be NULL
                object repObj = keys["replacement_emp"];
                int? replacementEmp = null;
                if (repObj != null && repObj != DBNull.Value)
                {
                    replacementEmp = Convert.ToInt32(repObj);
                }

                // Call backend logic (your procedure decides approve/reject)
                ProcessRequest(requestId, upperboardId, replacementEmp);

                // Reload grid so updated status appears
                LoadAnnualRequests();

                // Get latest final status from DB and show it in an alert
                string finalStatus = GetFinalStatus(requestId);
                if (string.IsNullOrEmpty(finalStatus))
                {
                    finalStatus = "Unknown";
                }

                string jsMsg = $"alert('Annual leave request {requestId} has been processed. Final status: {finalStatus}');";
                ClientScript.RegisterStartupScript(this.GetType(), "processMsg", jsMsg, true);
            }
        }

        // Hide Approve/Reject button if status is not Pending
        protected void gvAnnual_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                string status = DataBinder.Eval(e.Row.DataItem, "final_approval_status")?.ToString();
                Button btn = (Button)e.Row.FindControl("btnProcess");

                if (btn != null)
                {
                    if (!string.IsNullOrEmpty(status) &&
                        !status.Equals("Pending", StringComparison.OrdinalIgnoreCase))
                    {
                        btn.Visible = false;   // already approved/rejected → hide button
                    }
                    else
                    {
                        btn.Visible = true;    // still pending → keep button
                    }
                }
            }
        }

        private void ProcessRequest(int requestId, int upperboardId, int? replacementEmp)
        {
            string connStr = GetConnectionString();

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("Upperboard_approve_annual", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@request_ID", requestId);
                cmd.Parameters.AddWithValue("@Upperboard_ID", upperboardId);

                SqlParameter pReplacement = new SqlParameter("@replacement_ID", SqlDbType.Int);
                if (replacementEmp.HasValue)
                    pReplacement.Value = replacementEmp.Value;
                else
                    pReplacement.Value = DBNull.Value;

                cmd.Parameters.Add(pReplacement);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        private string GetFinalStatus(int requestId)
        {
            string connStr = GetConnectionString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT final_approval_status FROM Leave WHERE request_ID = @RequestID;";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@RequestID", requestId);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null && result != DBNull.Value)
                        return result.ToString();
                }
            }
            return null;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
