using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace Team75
{
    public partial class ApproveUnpaid : System.Web.UI.Page
    {
        private string ConnectionString =>
            ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["LastRequestId_Unpaid"] == null)
                {
                    lblInfo.Text = "No unpaid leave request was processed in this session.";
                    LoadEmpty();
                    return;
                }

                int requestId = Convert.ToInt32(Session["LastRequestId_Unpaid"]);
                int? hrId = null;
                if (Session["HR_ID"] != null)
                {
                    hrId = Convert.ToInt32(Session["HR_ID"]);
                }

                LoadData(requestId, hrId);
            }
        }

        private void LoadEmpty()
        {
            GridViewLeaveAfter.DataSource = null;
            GridViewLeaveAfter.DataBind();

            GridViewApproveAfter.DataSource = null;
            GridViewApproveAfter.DataBind();
        }

        private void LoadData(int requestId, int? hrId)
        {
            using (SqlConnection conn = new SqlConnection(ConnectionString))
            {
                conn.Open();

                // Leave row
                using (SqlCommand cmdLeave = new SqlCommand(
                    "SELECT * FROM [Leave] WHERE request_ID = @req", conn))
                {
                    cmdLeave.Parameters.AddWithValue("@req", requestId);
                    SqlDataAdapter daLeave = new SqlDataAdapter(cmdLeave);
                    DataTable dtLeave = new DataTable();
                    daLeave.Fill(dtLeave);
                    GridViewLeaveAfter.DataSource = dtLeave;
                    GridViewLeaveAfter.DataBind();
                }

                // Employee_Approve_Leave rows (for this leave; optionally filtered by HR)
                string sqlAppr =
                    "SELECT * FROM Employee_Approve_Leave WHERE leave_ID = @req";

                if (hrId.HasValue)
                {
                    sqlAppr += " AND Emp1_ID = @hr";
                }

                using (SqlCommand cmdAppr = new SqlCommand(sqlAppr, conn))
                {
                    cmdAppr.Parameters.AddWithValue("@req", requestId);
                    if (hrId.HasValue)
                    {
                        cmdAppr.Parameters.AddWithValue("@hr", hrId.Value);
                    }

                    SqlDataAdapter daAppr = new SqlDataAdapter(cmdAppr);
                    DataTable dtAppr = new DataTable();
                    daAppr.Fill(dtAppr);
                    GridViewApproveAfter.DataSource = dtAppr;
                    GridViewApproveAfter.DataBind();
                }
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            Response.Redirect("verify_Unpaid.aspx");
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            Response.Redirect("HR_Home.aspx");
        }
    }
}