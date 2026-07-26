using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Team75
{
    public partial class GenPayroll : System.Web.UI.Page
    {
        private string ConnectionString =>
            ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["LastPayrollEmpId"] == null ||
                    Session["LastPayrollFrom"] == null ||
                    Session["LastPayrollTo"] == null)
                {
                    lblInfo.Text = "No payroll was generated (missing session data).";
                    gridPayroll.Visible = false;
                    gridDeductions.Visible = false;
                    // Question + buttons still visible
                    return;
                }

                int empId = (int)Session["LastPayrollEmpId"];
                DateTime fromDate = (DateTime)Session["LastPayrollFrom"];
                DateTime toDate = (DateTime)Session["LastPayrollTo"];

                LoadData(empId, fromDate, toDate);
            }
        }

        private void LoadData(int empId, DateTime fromDate, DateTime toDate)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                // Payroll for this employee & period
                using (SqlCommand cmdPay = new SqlCommand(
                    @"SELECT * FROM Payroll 
                      WHERE emp_ID = @id AND from_date = @from AND to_date = @to", conn))
                {
                    cmdPay.Parameters.AddWithValue("@id", empId);
                    cmdPay.Parameters.AddWithValue("@from", fromDate);
                    cmdPay.Parameters.AddWithValue("@to", toDate);

                    SqlDataAdapter daPay = new SqlDataAdapter(cmdPay);
                    DataTable dtPay = new DataTable();
                    daPay.Fill(dtPay);

                    gridPayroll.DataSource = dtPay;
                    gridPayroll.DataBind();

                    if (dtPay.Rows.Count == 0)
                    {
                        lblInfo.Text = "No payroll record found for this employee.";
                    }
                }

                // Finalized deductions for current month
                using (SqlCommand cmdDed = new SqlCommand(
                    @"SELECT * FROM Deduction
                      WHERE emp_ID = @id AND status='Finalized'
                      AND MONTH(date)=MONTH(CURRENT_TIMESTAMP)
                      AND YEAR(date)=YEAR(CURRENT_TIMESTAMP)", conn))
                {
                    cmdDed.Parameters.AddWithValue("@id", empId);

                    SqlDataAdapter daDed = new SqlDataAdapter(cmdDed);
                    DataTable dtDed = new DataTable();
                    daDed.Fill(dtDed);

                    gridDeductions.DataSource = dtDed;
                    gridDeductions.DataBind();

                    if (dtDed.Rows.Count == 0)
                    {
                        lblDeductionInfo.Text = "No deductions generated for this employee this month.";
                        gridDeductions.Visible = false;
                    }
                    else
                    {
                        lblDeductionInfo.Text = "";
                        gridDeductions.Visible = true;
                    }
                }
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_GenPayroll.aspx");
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            Response.Redirect("HR_Home.aspx");
        }
    }
}