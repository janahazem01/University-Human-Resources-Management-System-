<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Admin.aspx.cs" Inherits="Team75.Admin" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Panel</title>

    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        body {
            background-color: #f4f4f4;
            font-family: Arial, sans-serif;
        }

        /* Center the page */
        .page-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        /* White card */
        .admin-container {
            background-color: white;
            padding: 40px;
            width: 600px;
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.20);
            text-align: center;
        }

        h1 {
            font-size: 34px;
            margin-bottom: 25px;
        }

        .admin-buttons {
            display: flex;
            flex-direction: column;
            gap: 14px;
            margin-top: 10px;
            width: 100%;
        }

        /* Green action buttons */
        .admin-btn {
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            width: 100%;
        }

        .admin-btn:hover {
            background-color: #43a047;
        }

        /* Small centered red Logout button (same look as screenshot) */
        .logout-btn {
            margin-top: 24px;
            padding: 14px 40px;
            font-size: 20px;
            font-weight: bold;
            color: #ffffff;
            background-color: #D32F2F;
            border: none;
            border-radius: 25px;
            cursor: pointer;
            display: inline-block;   /* so it doesn’t stretch full width */
        }

        .logout-btn:hover {
            background-color: #b71c1c;
        }
    </style>

</head>
<body>

    <form id="form1" runat="server">

        <div class="page-wrapper">
            <div class="admin-container">

                <h1>Admin Home Page</h1>

                <div class="admin-buttons">

                    <!-- Part 1 Buttons -->
                    <asp:Button ID="ViewDetails" runat="server"
                        Text="View all employee profiles"
                        CssClass="admin-btn"
                        OnClick="btnViewEmployeeProfiles_Click" />

                    <asp:Button ID="EmployeesPerDept" runat="server"
                        Text="Number of employees per department"
                        CssClass="admin-btn"
                        OnClick="btnEmployeesPerDept_Click" />

                    <asp:Button ID="RejectedMedicalLeaves" runat="server"
                        Text="Rejected medical leaves"
                        CssClass="admin-btn"
                        OnClick="btnRejectedMedicalLeaves_Click" />

                    <asp:Button ID="RemoveResignedDeductions" runat="server"
                        Text="Remove deductions of resigned employees"
                        CssClass="admin-btn"
                        OnClick="btnRemoveResignedDeductions_Click" />

                    <asp:Button ID="UpdateTodayAttendance" runat="server"
                        Text="Update today's attendance for a certain employee"
                        CssClass="admin-btn"
                        OnClick="btnUpdateTodayAttendance_Click" />

                    <asp:Button ID="AddOfficialHoliday" runat="server"
                        Text="Add a new official holiday"
                        CssClass="admin-btn"
                        OnClick="btnAddOfficialHoliday_Click" />

                    <asp:Button ID="InitiateTodayAttendance" runat="server"
                        Text="Initiate today's attendance"
                        CssClass="admin-btn"
                        OnClick="btnInitiateTodayAttendance_Click" />

                    <!-- Part 2 Buttons -->
                    <asp:Button ID="YesterdayAttendance" runat="server"
                        Text="Yesterday's attendance"
                        CssClass="admin-btn"
                        OnClick="btnYesterdayAttendance_Click" />

                    <asp:Button ID="WinterPerformance" runat="server"
                        Text="Performance in all Winter semesters"
                        CssClass="admin-btn"
                        OnClick="btnWinterPerformance_Click" />

                    <asp:Button ID="RemoveHolidayAttendance" runat="server"
                        Text="Remove attendance during official holidays"
                        CssClass="admin-btn"
                        OnClick="btnRemoveHolidayAttendance_Click" />

                    <asp:Button ID="RemoveUnattendedDayOff" runat="server"
                        Text="Remove unattended day off of current month"
                        CssClass="admin-btn"
                        OnClick="btnRemoveUnattendedDayOff_Click" />

                    <asp:Button ID="RemoveApprovedLeavesFromAttendance" runat="server"
                        Text="Remove approved leaves from attendance"
                        CssClass="admin-btn"
                        OnClick="btnRemoveApprovedLeavesFromAttendance_Click" />

                    <asp:Button ID="ReplaceEmployee" runat="server"
                        Text="Replace another employee"
                        CssClass="admin-btn"
                        OnClick="btnReplaceEmployee_Click" />

                    <asp:Button ID="UpdateEmploymentStatusDaily" runat="server"
                        Text="Daily update of employment status"
                        CssClass="admin-btn"
                        OnClick="btnUpdateEmploymentStatusDaily_Click" />

                </div>

                <!-- Logout Button -->
                <asp:Button ID="LogoutButton" runat="server"
                    Text="Logout"
                    CssClass="logout-btn"
                    OnClick="LogoutButton_Click" />

            </div>
        </div>

    </form>

</body>
</html>
