using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Team75
{
    public partial class ApproveUnpaidLeave : System.Web.UI.Page
    {
        private string GetConnectionString()
        {
            // Ensure "Team75" exists in Web.config <connectionStrings>
            return WebConfigurationManager.ConnectionStrings["Team75"].ToString();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlUnpaid.Visible = false;
                lblStatus.Text = "";

                // 🔹 Get the ID used at login (adjust key name if needed)
                object idObj = Session["EmployeeID"];
                if (idObj == null)
                {
                    // No ID in session → force re-login / back
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

                // 🔹 Check role
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
                    // Authorized upperboard member
                    Session["UpperboardID"] = upperboardId;
                    lblStatus.Text = $"Access granted. You are logged in as Employee {upperboardId} ({role}).";
                    lblStatus.CssClass = "message success";

                    pnlUnpaid.Visible = true;
                    LoadUnpaidRequests();
                }
                else
                {
                    // Not authorized
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

        // Load unpaid leave requests
        private void LoadUnpaidRequests()
        {
            string connStr = GetConnectionString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT 
                        u.request_ID,
                        u.Emp_ID,
                        l.start_date,
                        l.end_date,
                        l.final_approval_status
                    FROM Unpaid_Leave u
                    INNER JOIN Leave l ON u.request_ID = l.request_ID
                    ORDER BY u.request_ID;";

                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvUnpaid.DataSource = dt;
                    gvUnpaid.DataBind();
                }
            }
        }

        // Handle Approve/Reject button in each row (the SP decides which)
        protected void gvUnpaid_RowCommand(object sender, GridViewCommandEventArgs e)
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
                    pnlUnpaid.Visible = false;
                    return;
                }

                int upperboardId = (int)Session["UpperboardID"];
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int requestId = Convert.ToInt32(gvUnpaid.DataKeys[rowIndex].Value);

                // Call backend logic (your procedure decides approve/reject)
                ProcessRequest(requestId, upperboardId);

                // Reload grid so updated status appears
                LoadUnpaidRequests();

                // Get latest final status from DB and show it in an alert
                string finalStatus = GetFinalStatus(requestId);
                if (string.IsNullOrEmpty(finalStatus))
                {
                    finalStatus = "Unknown";
                }

                string jsMsg = $"alert('Request {requestId} has been processed. Final status: {finalStatus}');";
                ClientScript.RegisterStartupScript(this.GetType(), "processMsg", jsMsg, true);
            }
        }

        // Hide Approve/Reject button if status is not Pending
        protected void gvUnpaid_RowDataBound(object sender, GridViewRowEventArgs e)
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

        private void ProcessRequest(int requestId, int upperboardId)
        {
            string connStr = GetConnectionString();

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("Upperboard_approve_unpaids", conn))
            {
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@request_ID", requestId);
                cmd.Parameters.AddWithValue("@upperboard_ID", upperboardId);

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
