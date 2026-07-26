using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Team75
{
    public partial class UpdateAttendanceConfirm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadAttendance();
        }

        private void LoadAttendance()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Attendance", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewAttendance.DataSource = dt;
                GridViewAttendance.DataBind();
            }
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            if (txtEmployeeID == null || string.IsNullOrWhiteSpace(txtEmployeeID.Text))
            {
                ClientScript.RegisterStartupScript(
                    this.GetType(), "alert",
                    "alert('Please enter an Employee ID.');", true);
                return;
            }

            string empId = txtEmployeeID.Text.Trim();
            string checkIn = txtCheckIn.Text.Trim();
            string checkOut = txtCheckOut.Text.Trim();

            string url = "UpdateAttendanceResult.aspx?empid=" + empId
                       + "&checkin=" + Server.UrlEncode(checkIn)
                       + "&checkout=" + Server.UrlEncode(checkOut);

            Response.Redirect(url);
        }

        protected void btnNo_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
