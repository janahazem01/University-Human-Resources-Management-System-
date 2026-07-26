using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Team75
{
    public partial class deductionHours : System.Web.UI.Page
    {
        private string ConnectionString =>
            ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["DedHoursEmpID"] == null ||
                    Session["DedHoursHasDeduction"] == null)
                {
                    lblInfo.Text = "No deduction calculation was performed in this session.";
                    gridDeduction.Visible = false;
                    return;
                }

                int empId = Convert.ToInt32(Session["DedHoursEmpID"]);
                bool hasDeduction = Convert.ToBoolean(Session["DedHoursHasDeduction"]);
                decimal amount = 0m;

                if (hasDeduction && Session["DedHoursAmount"] != null)
                {
                    amount = Convert.ToDecimal(Session["DedHoursAmount"]);
                }

                if (!hasDeduction)
                {
                    lblInfo.Text = "This employee has no deductions for this month.";
                    gridDeduction.Visible = false;
                    return;
                }

                lblInfo.Text = "The deductions amount of this month for this employee is: "
                               + amount.ToString("0.00");

                DateTime today = DateTime.Today;
                DateTime firstOfMonth = new DateTime(today.Year, today.Month, 1);

                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    using (SqlCommand cmd = new SqlCommand(
                        @"SELECT * 
                          FROM Deduction
                          WHERE emp_ID = @emp
                            AND type = 'missing_hours'
                            AND [date] >= @fromDate
                            AND [date] <= @toDate;", conn))
                    {
                        cmd.Parameters.AddWithValue("@emp", empId);
                        cmd.Parameters.AddWithValue("@fromDate", firstOfMonth);
                        cmd.Parameters.AddWithValue("@toDate", today);

                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gridDeduction.DataSource = dt;
                        gridDeduction.DataBind();
                        gridDeduction.Visible = true;
                    }
                }
            }
        }

        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("HR_Home.aspx");
        }
    }
}