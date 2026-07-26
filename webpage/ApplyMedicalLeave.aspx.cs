using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;

namespace Team75
{
    public partial class ApplyMedicalLeave : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Security: must be logged in
                if (Session["EmployeeID"] == null)
                {
                    Response.Redirect("academic_login.aspx");
                    return;
                }

                lblEmployeeID.Text = Session["EmployeeID"].ToString();
                lblMessage.Text = "";
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";

            // Validate session / employee ID
            if (Session["EmployeeID"] == null ||
                !int.TryParse(Session["EmployeeID"].ToString(), out int employeeId))
            {
                string script = "alert('Session expired. Please log in again.'); window.location='academic_login.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "Expired", script, true);
                return;
            }

            // Dates
            if (!DateTime.TryParse(txtStartDate.Text, out DateTime startDate) ||
                !DateTime.TryParse(txtEndDate.Text, out DateTime endDate))
            {
                lblMessage.Text = "Please select valid start and end dates.";
                return;
            }

            if (endDate < startDate)
            {
                lblMessage.Text = "End date cannot be earlier than start date.";
                return;
            }

            // Medical type
            string medicalType = txtMedicalType.Text.Trim();
            if (string.IsNullOrEmpty(medicalType))
            {
                lblMessage.Text = "Please enter the medical type.";
                return;
            }

            // Insurance bit
            bool insuranceStatus = chkInsurance.Checked;

            // Disability details (optional)
            string disabilityDetails = txtDisabilityDetails.Text.Trim();
            if (disabilityDetails.Length > 50)
                disabilityDetails = disabilityDetails.Substring(0, 50);

            // Document description
            string docDesc = txtDocDescription.Text.Trim();
            if (string.IsNullOrEmpty(docDesc))
            {
                lblMessage.Text = "Please enter a document description.";
                return;
            }

            // File name
            if (!fuDocument.HasFile)
            {
                lblMessage.Text = "Please upload a medical document (any file).";
                return;
            }
            string fileName = fuDocument.FileName; // only name is stored in DB

            try
            {
                string connStr = WebConfigurationManager
                                 .ConnectionStrings["Team75"]
                                 .ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("Submit_medical", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@employee_ID", employeeId);
                    cmd.Parameters.AddWithValue("@start_date", startDate);
                    cmd.Parameters.AddWithValue("@end_date", endDate);
                    cmd.Parameters.AddWithValue("@medical_type", medicalType);
                    cmd.Parameters.Add("@insurance_status", SqlDbType.Bit).Value = insuranceStatus;
                    cmd.Parameters.AddWithValue("@disability_details", disabilityDetails);
                    cmd.Parameters.AddWithValue("@document_description", docDesc);
                    cmd.Parameters.AddWithValue("@file_name", fileName);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                // On success: alert + redirect to submissions page
                string successScript =
                    "alert('Medical leave submitted successfully.');" +
                    "window.location='MedicalLeaveSubmission.aspx';";
                ClientScript.RegisterStartupScript(this.GetType(), "Success", successScript, true);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error submitting medical leave: " + ex.Message;
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("AcademicEmployee.aspx");
        }
    }
}
