using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Team75
{
    public partial class UpdateAttendanceResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                RunProcedureAndLoadTable();
        }

        private void ShowMessage(string msg)
        {
            // Clear any text on the page
            lblMessage.Text = "";

            // Escape single quotes for JavaScript
            string safeMsg = msg.Replace("'", "\\'");

            // Popup alert ONLY
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "popupMessage",
                $"alert('{safeMsg}');",
                true
            );
        }

        private void RunProcedureAndLoadTable()
        {
            string empIdStr = Request.QueryString["empid"];
            string checkInStr = Request.QueryString["checkin"];
            string checkOutStr = Request.QueryString["checkout"];

            // validate Employee ID
            if (string.IsNullOrWhiteSpace(empIdStr) || !int.TryParse(empIdStr, out int empId))
            {
                ShowMessage("Invalid or missing Employee ID.");
                LoadAttendanceTable();
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Check if there is an attendance record for today
                    bool hasTodayRecord;
                    using (SqlCommand cmdCheck = new SqlCommand(
                        "SELECT COUNT(*) FROM Attendance " +
                        "WHERE emp_ID = @id AND [date] = CAST(GETDATE() AS DATE)", conn))
                    {
                        cmdCheck.Parameters.AddWithValue("@id", empId);
                        hasTodayRecord = (int)cmdCheck.ExecuteScalar() > 0;
                    }

                    if (!hasTodayRecord)
                    {
                        ShowMessage("No attendance record found for this employee today.");
                        LoadAttendanceTable(conn);
                        return;
                    }

                    // Run stored procedure
                    using (SqlCommand cmd = new SqlCommand("Update_Attendance", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@Employee_id", empId);

                        // check_in_time
                        SqlParameter pIn = new SqlParameter("@check_in_time", System.Data.SqlDbType.Time);
                        if (string.IsNullOrWhiteSpace(checkInStr))
                        {
                            pIn.Value = DBNull.Value;
                        }
                        else if (TimeSpan.TryParse(checkInStr, out TimeSpan checkInTime))
                        {
                            pIn.Value = checkInTime;
                        }
                        else
                        {
                            ShowMessage("Invalid check-in time format.");
                            LoadAttendanceTable(conn);
                            return;
                        }
                        cmd.Parameters.Add(pIn);

                        // check_out_time
                        SqlParameter pOut = new SqlParameter("@check_out_time", System.Data.SqlDbType.Time);
                        if (string.IsNullOrWhiteSpace(checkOutStr))
                        {
                            pOut.Value = DBNull.Value;
                        }
                        else if (TimeSpan.TryParse(checkOutStr, out TimeSpan checkOutTime))
                        {
                            pOut.Value = checkOutTime;
                        }
                        else
                        {
                            ShowMessage("Invalid check-out time format.");
                            LoadAttendanceTable(conn);
                            return;
                        }
                        cmd.Parameters.Add(pOut);

                        // execute
                        cmd.ExecuteNonQuery();
                    }

                    // success
                    ShowMessage("Attendance updated successfully!");

                    // load table after update
                    LoadAttendanceTable(conn);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message);
                LoadAttendanceTable();
            }
        }

        private void LoadAttendanceTable()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                LoadAttendanceTable(conn);
            }
        }

        private void LoadAttendanceTable(SqlConnection conn)
        {
            using (SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Attendance", conn))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewUpdatedAttendance.DataSource = dt;
                GridViewUpdatedAttendance.DataBind();
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("UpdateAttendanceConfirm.aspx");
        }
    }
}
