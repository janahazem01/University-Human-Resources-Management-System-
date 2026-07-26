using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Team75
{
    public partial class Employeeview : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadEmployees();
        }

        private void LoadEmployees()
        {
            string connStr = WebConfigurationManager.ConnectionStrings["Team75"].ToString();

            SqlConnection conn = new SqlConnection(connStr);
            SqlCommand cmd = new SqlCommand("SELECT * FROM allEmployeeProfiles", conn);

            conn.Open();
            SqlDataReader rdr = cmd.ExecuteReader(CommandBehavior.CloseConnection);

            while (rdr.Read())
            {
                // Employee card
                Panel employeeBox = new Panel();
                employeeBox.CssClass = "employee-box";

                // Helper to add structured field
                void AddField(string title, string value)
                {
                    Label lbl = new Label();
                    lbl.Text =
                        $"<div class='field'>" +
                            $"<span class='field-label'>{title}:</span> {value}" +
                        $"</div>";
                    employeeBox.Controls.Add(lbl);
                }

                // Add all fields in vertical order (1 column)
                AddField("Employee ID", rdr["employee_ID"].ToString());
                AddField("First Name", rdr["first_name"].ToString());
                AddField("Last Name", rdr["last_name"].ToString());
                AddField("Gender", rdr["gender"].ToString());
                AddField("Email", rdr["email"].ToString());
                AddField("Address", rdr["address"].ToString());
                AddField("Years of Experience", rdr["years_of_experience"].ToString());
                AddField("Official Day Off", rdr["official_day_off"].ToString());
                AddField("Type of Contract", rdr["type_of_contract"].ToString());
                AddField("Employment Status", rdr["employment_status"].ToString());
                AddField("Annual Balance", rdr["annual_balance"].ToString());
                AddField("Accidental Balance", rdr["accidental_balance"].ToString());

                // Add card to container
                EmployeesContainer.Controls.Add(employeeBox);
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Admin.aspx");
        }
    }
}
