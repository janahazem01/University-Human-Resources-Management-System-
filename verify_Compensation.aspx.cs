using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

namespace Team75
{
    public partial class verify_Compensation : System.Web.UI.Page
    {
        private string ConnectionString =>
            ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = string.Empty;

                if (Session["HR_ID"] != null)
                {
                    int hrId = Convert.ToInt32(Session["HR_ID"]);
                    lblHRID.Text = "Your HR ID is: " + hrId;
                    lblHRID.ForeColor = Color.Black;
                }
                else
                {
                    lblHRID.Text = "Your HR ID is: (not found in session)";
                    lblHRID.ForeColor = Color.Red;
                    lblError.Text = "HR ID not found in session. Please log in again.";
                }
            }
        }

        // 1) Load details button
        protected void btnLoad_Click(object sender, EventArgs e)
        {
            lblError.Text = string.Empty;

            if (Session["HR_ID"] == null)
            {
                lblError.Text = "HR ID not found in session. Please log in again.";
                return;
            }

            if (!int.TryParse(txtRequestID.Text.Trim(), out int requestID))
            {
                lblError.Text = "Invalid Request ID, please retry.";
                lblError.ForeColor = Color.Red;
                HideGrids();
                return;
            }

            bool ok = LoadLeaveData(requestID);
            if (!ok)
            {
                return; // message already set
            }
        }

        // 2) Proceed (approve / reject) button
        protected void btnProceed_Click(object sender, EventArgs e)
        {
            lblError.Text = string.Empty;

            if (Session["HR_ID"] == null)
            {
                lblError.Text = "HR ID not found in session. Please log in again.";
                return;
            }

            int hrId = Convert.ToInt32(Session["HR_ID"]);

            if (!int.TryParse(txtRequestID.Text.Trim(), out int requestID))
            {
                lblError.Text = "Invalid Request ID, please retry.";
                lblError.ForeColor = Color.Red;
                HideGrids();
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    // Check that request exists in Leave
                    using (SqlCommand cmdCheck = new SqlCommand(
                        "SELECT COUNT(*) FROM [Leave] WHERE request_ID = @req", conn))
                    {
                        cmdCheck.Parameters.AddWithValue("@req", requestID);
                        int cnt = (int)cmdCheck.ExecuteScalar();
                        if (cnt == 0)
                        {
                            lblError.Text = "Invalid Request ID, please retry.";
                            lblError.ForeColor = Color.Red;
                            HideGrids();
                            return;
                        }
                    }

                    // Check that request is a Compensation_Leave
                    using (SqlCommand cmdCheckType = new SqlCommand(
                        "SELECT COUNT(*) FROM Compensation_Leave WHERE request_ID = @req", conn))
                    {
                        cmdCheckType.Parameters.AddWithValue("@req", requestID);
                        int cntType = (int)cmdCheckType.ExecuteScalar();
                        if (cntType == 0)
                        {
                            lblError.Text =
                                "Cannot approve or reject this request because it is not a compensation leave.";
                            lblError.ForeColor = Color.Red;
                            return;
                        }
                    }

                    // Call stored procedure HR_approval_comp
                    using (SqlCommand cmd = new SqlCommand("HR_approval_comp", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@request_ID", requestID);
                        cmd.Parameters.AddWithValue("@HR_ID", hrId);
                        cmd.ExecuteNonQuery();
                    }

                    // Get final status
                    string status = null;
                    using (SqlCommand cmdStatus = new SqlCommand(
                        "SELECT final_approval_status FROM [Leave] WHERE request_ID = @req", conn))
                    {
                        cmdStatus.Parameters.AddWithValue("@req", requestID);
                        object val = cmdStatus.ExecuteScalar();
                        if (val != null && val != DBNull.Value)
                        {
                            status = val.ToString();
                        }
                    }

                    if (string.IsNullOrEmpty(status))
                    {
                        lblError.Text = "Leave status could not be determined.";
                        lblError.ForeColor = Color.Red;
                        return;
                    }

                    Session["LastRequestId_Comp"] = requestID;

                    string safeStatus = status.Equals("Approved", StringComparison.OrdinalIgnoreCase)
                        ? "Approved"
                        : "Rejected";

                    string script =
                        "alert('The Compensation Leave has been " + safeStatus +
                        " Successfully'); window.location='ApproveCompensation.aspx';";

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "CompUpdatedMsg",
                        script,
                        true
                    );
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error while approving/rejecting compensation leave: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }

        // Helper: Load Leave + Compensation_Leave rows
        private bool LoadLeaveData(int requestID)
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(ConnectionString))
                {
                    conn.Open();

                    // Leave table
                    SqlDataAdapter da1 = new SqlDataAdapter(
                        "SELECT * FROM [Leave] WHERE request_ID = @r", conn);
                    da1.SelectCommand.Parameters.AddWithValue("@r", requestID);
                    DataTable dt1 = new DataTable();
                    da1.Fill(dt1);

                    if (dt1.Rows.Count == 0)
                    {
                        lblError.Text = "Invalid Request ID, please retry.";
                        lblError.ForeColor = Color.Red;
                        HideGrids();
                        return false;
                    }

                    gridLeave.DataSource = dt1;
                    gridLeave.DataBind();
                    gridLeave.Visible = true;

                    // Compensation_Leave table
                    SqlDataAdapter da2 = new SqlDataAdapter(
                        "SELECT * FROM Compensation_Leave WHERE request_ID = @r", conn);
                    da2.SelectCommand.Parameters.AddWithValue("@r", requestID);
                    DataTable dt2 = new DataTable();
                    da2.Fill(dt2);
                    gridComp.DataSource = dt2;
                    gridComp.DataBind();
                    gridComp.Visible = true; // show even if empty

                    return true;
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error loading leave details: " + ex.Message;
                lblError.ForeColor = Color.Red;
                HideGrids();
                return false;
            }
        }

        private void HideGrids()
        {
            gridLeave.Visible = false;
            gridComp.Visible = false;
        }
    }
}