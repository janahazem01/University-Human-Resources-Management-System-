using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;

namespace Team75
{
    public partial class verify_approveAnnualAccidental : System.Web.UI.Page
    {
        private string ConnectionString =>
            ConfigurationManager.ConnectionStrings["Team75"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                lblError.Text = string.Empty;

                // Show HR ID from Session
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

        // ===== 1) Load Leave Details button =====
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
                return; // error message handled inside
            }
        }

        // ===== 2) Proceed (approve/reject) button =====
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

                    // Check request exists in Leave
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

                    // Check it's Annual or Accidental
                    int cntAnnual;
                    int cntAcc;

                    using (SqlCommand cmdAnn = new SqlCommand(
                        "SELECT COUNT(*) FROM Annual_Leave WHERE request_ID = @req", conn))
                    {
                        cmdAnn.Parameters.AddWithValue("@req", requestID);
                        cntAnnual = (int)cmdAnn.ExecuteScalar();
                    }

                    using (SqlCommand cmdAcc = new SqlCommand(
                        "SELECT COUNT(*) FROM Accidental_Leave WHERE request_ID = @req", conn))
                    {
                        cmdAcc.Parameters.AddWithValue("@req", requestID);
                        cntAcc = (int)cmdAcc.ExecuteScalar();
                    }

                    if (cntAnnual == 0 && cntAcc == 0)
                    {
                        lblError.Text =
                            "Cannot approve or reject this request because it is neither an annual nor an accidental leave.";
                        lblError.ForeColor = Color.Red;
                        return;
                    }

                    // Call stored procedure HR_approval_an_acc
                    using (SqlCommand cmd = new SqlCommand("HR_approval_an_acc", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@request_ID", requestID);
                        cmd.Parameters.AddWithValue("@HR_ID", hrId);
                        cmd.ExecuteNonQuery();
                    }

                    // Read final status from Leave
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

                    // Save the last processed request ID for summary page
                    Session["LastRequestId_AnAcc"] = requestID;

                    string safeStatus = status.Equals("Approved", StringComparison.OrdinalIgnoreCase)
                        ? "Approved"
                        : "Rejected";

                    string script =
                        "alert('The Accidental/Annual Leave has been " + safeStatus +
                        " Successfully'); window.location='approveAnnualAccidental.aspx';";

                    ClientScript.RegisterStartupScript(
                        this.GetType(),
                        "AnAccUpdatedMsg",
                        script,
                        true
                    );
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error while approving/rejecting leave: " + ex.Message;
                lblError.ForeColor = Color.Red;
            }
        }

        // ===== Helper: load Leave + Annual_Leave + Accidental_Leave =====
        // Returns true if Leave row exists; false if invalid ID
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

                    // Annual_Leave table
                    SqlDataAdapter da2 = new SqlDataAdapter(
                        "SELECT * FROM Annual_Leave WHERE request_ID = @r", conn);
                    da2.SelectCommand.Parameters.AddWithValue("@r", requestID);
                    DataTable dt2 = new DataTable();
                    da2.Fill(dt2);
                    gridAnnual.DataSource = dt2;
                    gridAnnual.DataBind();
                    gridAnnual.Visible = true; // show even if empty;

                    // Accidental_Leave table
                    SqlDataAdapter da3 = new SqlDataAdapter(
                        "SELECT * FROM Accidental_Leave WHERE request_ID = @r", conn);
                    da3.SelectCommand.Parameters.AddWithValue("@r", requestID);
                    DataTable dt3 = new DataTable();
                    da3.Fill(dt3);
                    gridAccidental.DataSource = dt3;
                    gridAccidental.DataBind();
                    gridAccidental.Visible = true; // show even if empty

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
            gridAnnual.Visible = false;
            gridAccidental.Visible = false;
        }
    }
}