<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ChooseLeaveType.aspx.cs" Inherits="Team75.ChooseLeaveType" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Choose Leave Type</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .wrapper {
            max-width: 900px;
            margin: 40px auto;
            text-align: center;
        }

        .page-title {
            font-size: 40px;
            font-weight: bold;
            margin-bottom: 40px;
        }

        .menu-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
            width: 100%;
        }

        .menu-button {
            display: block;
            width: 380px;
            padding: 14px;
            background-color: #4CAF50;      /* green theme */
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 20px;
            cursor: pointer;
            text-align: center;
        }

        .menu-button:hover {
            background-color: #45a049;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">
    <div class="wrapper">

        <div class="page-title">Choose Leave Type</div>

        <div class="menu-container">

            <asp:Button ID="btnAnnual" runat="server"
                        CssClass="menu-button"
                        Text="Annual Leave"
                        OnClick="btnAnnual_Click" />

            <asp:Button ID="btnAccidental" runat="server"
                        CssClass="menu-button"
                        Text="Accidental Leave"
                        OnClick="btnAccidental_Click" />

            <asp:Button ID="btnMedical" runat="server"
                        CssClass="menu-button"
                        Text="Medical Leave"
                        OnClick="btnMedical_Click" />

            <asp:Button ID="btnUnpaid" runat="server"
                        CssClass="menu-button"
                        Text="Unpaid Leave"
                        OnClick="btnUnpaid_Click" />

            <asp:Button ID="btnCompensation" runat="server"
                        CssClass="menu-button"
                        Text="Compensation Leave"
                        OnClick="btnCompensation_Click" />

            <asp:Button ID="btnBack" runat="server"
                        CssClass="menu-button"
                        Text="Back"
                        OnClick="btnBack_Click" />

        </div>
    </div>
</form>
</body>
</html>
