using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;

namespace Team75
{
    public partial class AddHolidayResult : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                ProcessHolidayAndLoadTable();
        }

        private void ShowMessage(string msg)
        {
            lblMessage.Text = msg;
            string escaped = msg.Replace("'", "\\'");
            ClientScript.RegisterStartupScript(
                this.GetType(),
                "alertMessage",
                $"alert('{escaped}');",
                true
            );
        }

        private void ProcessHolidayAndLoadTable()
        {
            string name = Request.QueryString["name"];
            string fromStr = Request.QueryString["from"];
            string toStr = Request.QueryString["to"];

            if (string.IsNullOrWhiteSpace(name) ||
                string.IsNullOrWhiteSpace(fromStr) ||
                string.IsNullOrWhiteSpace(toStr))
            {
                ShowMessage("holiday_data must not be NULL or empty and the date_range entered must be correct.");
                LoadHolidayTable();
                return;
            }

            if (!DateTime.TryParse(fromStr, out DateTime fromDate) ||
                !DateTime.TryParse(toStr, out DateTime toDate) ||
                fromDate > toDate)
            {
                ShowMessage("holiday_data must not be NULL or empty and the date_range entered must be correct.");
                LoadHolidayTable();
                return;
            }

            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();

                    // Check overlap
                    using (SqlCommand cmdCheck = new SqlCommand(
                        @"SELECT COUNT(*) 
                          FROM Holiday h
                          WHERE h.holiday_name = @name
                            AND NOT (h.to_date < @fromDate OR h.from_date > @toDate)", conn))
                    {
                        cmdCheck.Parameters.AddWithValue("@name", name);
                        cmdCheck.Parameters.AddWithValue("@fromDate", fromDate);
                        cmdCheck.Parameters.AddWithValue("@toDate", toDate);

                        int overlapCount = (int)cmdCheck.ExecuteScalar();
                        if (overlapCount > 0)
                        {
                            ShowMessage("Holiday date range overlaps an existing holiday for the same name.");
                            LoadHolidayTable(conn);
                            return;
                        }
                    }

                    // Run procedure
                    using (SqlCommand cmd = new SqlCommand("Add_Holiday", conn))
                    {
                        cmd.CommandType = System.Data.CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@holiday_name", name);
                        cmd.Parameters.AddWithValue("@from_date", fromDate);
                        cmd.Parameters.AddWithValue("@to_date", toDate);
                        cmd.ExecuteNonQuery();
                    }

                    ShowMessage("Holiday added successfully.");
                    LoadHolidayTable(conn);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message);
                LoadHolidayTable();
            }
        }

        private void LoadHolidayTable()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                LoadHolidayTable(conn);
            }
        }

        private void LoadHolidayTable(SqlConnection conn)
        {
            using (SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM Holiday", conn))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                GridViewHolidaysAfter.DataSource = dt;
                GridViewHolidaysAfter.DataBind();
            }
        }

        protected void btnBackToConfirm_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddHolidayConfirm.aspx");
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
