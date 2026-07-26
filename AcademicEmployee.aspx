<%@ Page Language="C#" AutoEventWireup="true" 
         CodeBehind="AcademicEmployee.aspx.cs"
         Inherits="Team75.AcademicEmployee" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Academic Home</title>

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

        /* Center page */
        .page-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        /* White card */
        .academic-container {
            background-color: #ffffff;
            padding: 40px;
            width: 600px;
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.20);
            text-align: center;
        }

        .page-title {
            font-size: 34px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .menu-buttons {
            display: flex;
            flex-direction: column;
            gap: 14px;
            width: 100%;
        }

        /* Green menu buttons */
        .menu-btn {
            padding: 12px;
            font-size: 17px;
            font-weight: bold;
            color: #ffffff;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            width: 100%;
        }

        .menu-btn:hover {
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
            display: inline-block;
        }

        .logout-btn:hover {
            background-color: #b71c1c;
        }
    </style>

</head>

<body>
<form id="form1" runat="server">
    <div class="page-wrapper">
        <div class="academic-container">

            <div class="page-title">Academic Home Page</div>

            <div class="menu-buttons">

                <asp:Button ID="btnPerformance" runat="server"
                            Text="View Performance"
                            CssClass="menu-btn"
                            OnClick="btnPerformance_Click" />

                <asp:Button ID="btnAttendanceRecords" runat="server"
                            Text="Attendance Records"
                            CssClass="menu-btn"
                            OnClick="btnAttendanceRecords_Click" />

                <asp:Button ID="btnLastMonthPayroll" runat="server"
                            Text="Last Month Payroll"
                            CssClass="menu-btn"
                            OnClick="btnLastMonthPayroll_Click" />

                <asp:Button ID="btnDeductions" runat="server"
                            Text="View Deductions"
                            CssClass="menu-btn"
                            OnClick="btnDeductions_Click" />

                <asp:Button ID="btnApplyForLeave" runat="server"
                            Text="Apply for Leave"
                            CssClass="menu-btn"
                            OnClick="btnApplyForLeave_Click" />

                <asp:Button ID="btnLeaveStatus" runat="server"
                            Text="Leave Status"
                            CssClass="menu-btn"
                            OnClick="btnLeaveStatus_Click" />

                <asp:Button ID="btnApproveUnpaid" runat="server"
                            Text="Approve Unpaid Leave"
                            CssClass="menu-btn"
                            OnClick="btnApproveUnpaid_Click" />

                <asp:Button ID="btnApproveAnnual" runat="server"
                            Text="Approve Annual Leave"
                            CssClass="menu-btn"
                            OnClick="btnApproveAnnual_Click" />

                <asp:Button ID="btnEvaluation" runat="server"
                            Text="Evaluate Employees"
                            CssClass="menu-btn"
                            OnClick="btnEvaluation_Click" />

            </div>

            <!-- Logout Button -->
            <asp:Button ID="btnLogout" runat="server"
                        Text="Logout"
                        CssClass="logout-btn"
                        OnClick="btnLogout_Click" />

        </div>
    </div>
</form>
</body>
</html>
