<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="HR_Home.aspx.cs"
    Inherits="Team75.HR_Home" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HR Home</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 900px;
            margin: 40px auto;
            background: white;
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 0 18px rgba(0,0,0,0.15);
            text-align: center;
        }

        h1 {
            font-size: 48px;
            font-weight: bold;
            margin-bottom: 40px;
        }

        .menu-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 18px;
        }

        .menu-button {
            width: 500px;
            padding: 16px;
            background-color: #4CAF50;
            color: white;
            border-radius: 10px;
            font-size: 20px;
            border: none;
            cursor: pointer;
        }

        .menu-button:hover {
            background-color: #45a049;
        }

        .logout-button {
            width: 500px;
            padding: 16px;
            background-color: #d93636;
            color: white;
            border-radius: 10px;
            font-size: 20px;
            border: none;
            cursor: pointer;
        }

        .logout-button:hover {
            background-color: #c42f2f;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="container">

            <h1>HR Home Page</h1>

            <div class="menu-container">

                <asp:Button ID="btnApproveAnnualAccidental" runat="server"
                    Text="Approve/Reject Annual or Accidental Leaves"
                    CssClass="menu-button"
                    OnClick="btnApproveAnnualAccidental_Click" />

                <asp:Button ID="btnApproveUnpaid" runat="server"
                    Text="Approve/Reject Unpaid Leaves"
                    CssClass="menu-button"
                    OnClick="btnApproveUnpaid_Click" />

                <asp:Button ID="btnApproveCompensation" runat="server"
                    Text="Approve/Reject Compensation Leaves"
                    CssClass="menu-button"
                    OnClick="btnApproveCompensation_Click" />

                <asp:Button ID="btnDeductHours" runat="server"
                    Text="Add Deduction Due to Missing Hours"
                    CssClass="menu-button"
                    OnClick="btnDeductHours_Click" />

                <asp:Button ID="btnDeductDays" runat="server"
                    Text="Add Deduction Due to Missing Days"
                    CssClass="menu-button"
                    OnClick="btnDeductDays_Click" />

                <asp:Button ID="btnDeductUnpaid" runat="server"
                    Text="Add Deduction Due to Unpaid Leave"
                    CssClass="menu-button"
                    OnClick="btnDeductUnpaid_Click" />

                <asp:Button ID="btnPayroll" runat="server"
                    Text="Generate Monthly Payroll"
                    CssClass="menu-button"
                    OnClick="btnPayroll_Click" />

                <!-- LOGOUT BUTTON -->
                <asp:Button ID="btnLogout" runat="server"
                    Text="Logout"
                    CssClass="logout-button"
                    OnClick="btnLogout_Click" />

            </div>

        </div>

    </form>
</body>
</html>
