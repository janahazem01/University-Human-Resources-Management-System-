using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace Team75
{
    public partial class Deductions : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Security: ensure user is logged in
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
                lblMessage.Text = string.Empty;
                gvDeductions.DataSource = null;
                gvDeductions.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            lblMessage.Text = string.Empty;

            // Re-check session
            if (Session["EmployeeID"] == null ||
                !int.TryParse(Session["EmployeeID"].ToString(), out int employeeId))
            {
                string script = "alert('Session expired. Please log in again.'); window.location='academic_login.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "Expired", script, true);
                return;
            }

            string input = txtDate.Text.Trim();
            if (string.IsNullOrWhiteSpace(input))
            {
                lblMessage.Text = "Please enter a date or month (1–12).";
                gvDeductions.DataSource = null;
                gvDeductions.DataBind();
                return;
            }

            int month;

            // Try to parse as full date first
            if (DateTime.TryParse(input, out DateTime parsedDate))
            {
                month = parsedDate.Month;
            }
            // else try simple month number (1–12)
            else if (int.TryParse(input, out int parsedMonth) && parsedMonth >= 1 && parsedMonth <= 12)
            {
                month = parsedMonth;
            }
            else
            {
                lblMessage.Text = "Invalid date or month. Please enter a valid date (YYYY-MM-DD) or month number (1–12).";
                gvDeductions.DataSource = null;
                gvDeductions.DataBind();
                return;
            }

            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT * FROM dbo.Deductions_Attendance(@EmpID, @Month)", conn))
                {
                    cmd.Parameters.AddWithValue("@EmpID", employeeId);
                    cmd.Parameters.AddWithValue("@Month", month);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    conn.Open();
                    da.Fill(dt);

                    gvDeductions.DataSource = dt;
                    gvDeductions.DataBind();

                    if (dt.Rows.Count > 0)
                    {
                        lblMessage.Text = $"Found {dt.Rows.Count} deduction record(s) for month {month}.";
                        string alert = "alert('Deductions retrieved successfully.');";
                        ClientScript.RegisterStartupScript(this.GetType(), "Success", alert, true);
                    }
                    else
                    {
                        lblMessage.Text = "No deductions found for this month.";
                    }
                }
            }
            catch (Exception ex)
            {
                gvDeductions.DataSource = null;
                gvDeductions.DataBind();
                lblMessage.Text = "Error retrieving deductions: " + ex.Message;
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
