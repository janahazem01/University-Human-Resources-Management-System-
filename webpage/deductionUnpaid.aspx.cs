using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Team75
{
    public partial class deductionUnpaid : System.Web.UI.Page
    {
        private string ConnectionString =>
            ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSummary();
            }
        }

        private void LoadSummary()
        {
            if (Session["DedUnpaidEmpID"] == null)
            {
                lblInfo.Text = "No employee was processed for unpaid deductions.";
                gridDeductions.Visible = false;
                return;
            }

            int empId = Convert.ToInt32(Session["DedUnpaidEmpID"]);

            bool hasDeduction = false;
            if (Session["DedUnpaidHasDeduction"] != null)
            {
                hasDeduction = Convert.ToBoolean(Session["DedUnpaidHasDeduction"]);
            }

            decimal amount = 0m;
            if (Session["DedUnpaidAmount"] != null)
            {
                amount = Convert.ToDecimal(Session["DedUnpaidAmount"]);
            }

            if (!hasDeduction)
            {
                lblInfo.Text = "This employee has no deductions for this month.";
                gridDeductions.Visible = false;
                return;
            }

            lblInfo.Text =
                "The deductions amount of this month for employee ID " +
                empId + " is: " + amount.ToString("0.00");

            // Load Deduction rows for this employee / month / type='unpaid'
            DateTime today = DateTime.Today;
            DateTime firstOfMonth = new DateTime(today.Year, today.Month, 1);

            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                using (SqlCommand cmd = new SqlCommand(
                    @"SELECT *
                      FROM Deduction
                      WHERE emp_ID = @emp
                        AND type = 'unpaid'
                        AND [date] >= @fromDate
                        AND [date] <= @toDate;", conn))
                {
                    cmd.Parameters.AddWithValue("@emp", empId);
                    cmd.Parameters.AddWithValue("@fromDate", firstOfMonth);
                    cmd.Parameters.AddWithValue("@toDate", today);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gridDeductions.DataSource = dt;
                    gridDeductions.DataBind();
                    gridDeductions.Visible = true;
                }
            }
        }

        protected void btnBackHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("HR_Home.aspx");
        }
    }
}