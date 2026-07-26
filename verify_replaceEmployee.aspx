<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="verify_replaceEmployee.aspx.cs"
    Inherits="Team75.verify_replaceEmployee" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Verify Replace Employee</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        /* Centered card */
        .page-wrapper {
            display: flex;
            justify-content: center;
            padding: 40px 20px;
        }

        .container {
            background-color: #ffffff;
            padding: 35px 45px;
            width: 1000px;
            border-radius: 14px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 25px;
        }

        h3 {
            margin-top: 10px;
            margin-bottom: 18px;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
        }

        .grid th,
        .grid td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }

        .grid th {
            background-color: #eeeeee;
            font-weight: bold;
        }

        .form-section {
            margin-top: 10px;
        }

        .field-label {
            display: block;
            margin-bottom: 4px;
            font-size: 15px;
        }

        .textbox {
            width: 240px;
            padding: 6px 8px;
            font-size: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .buttons {
            margin-top: 22px;
            display: flex;
            gap: 18px;
            flex-wrap: wrap;
            align-items: center;
        }

        /* Proceed button (grey) */
        .btn-proceed {
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #9E9E9E;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 130px;
        }

        .btn-proceed:hover {
            background-color: #757575;
        }

        /* Home button (green) */
        .btn-home {
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 130px;
        }

        .btn-home:hover {
            background-color: #43a047;
        }

        .message {
            margin-top: 15px;
            font-size: 15px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">
            <div class="container">

                <h2>Employee_Replace_Employee Table (Before Replacement)</h2>

                <asp:GridView ID="GridViewReplace" runat="server"
                              AutoGenerateColumns="true"
                              CssClass="grid">
                </asp:GridView>

                <h3>Please enter the following information</h3>

                <div class="form-section">
                    <asp:Label ID="lblEmp1" runat="server"
                               CssClass="field-label"
                               Text="Emp1_ID (employee being replaced):"
                               AssociatedControlID="txtEmp1"></asp:Label>
                    <asp:TextBox ID="txtEmp1" runat="server" CssClass="textbox"></asp:TextBox>
                </div>

                <div class="form-section">
                    <asp:Label ID="lblEmp2" runat="server"
                               CssClass="field-label"
                               Text="Emp2_ID (replacement employee):"
                               AssociatedControlID="txtEmp2"></asp:Label>
                    <asp:TextBox ID="txtEmp2" runat="server" CssClass="textbox"></asp:TextBox>
                </div>

                <div class="form-section">
                    <asp:Label ID="lblFrom" runat="server"
                               CssClass="field-label"
                               Text="From Date (YYYY-MM-DD):"
                               AssociatedControlID="txtFrom"></asp:Label>
                    <asp:TextBox ID="txtFrom" runat="server" CssClass="textbox"></asp:TextBox>
                </div>

                <div class="form-section">
                    <asp:Label ID="lblTo" runat="server"
                               CssClass="field-label"
                               Text="To Date (YYYY-MM-DD):"
                               AssociatedControlID="txtTo"></asp:Label>
                    <asp:TextBox ID="txtTo" runat="server" CssClass="textbox"></asp:TextBox>
                </div>

                <div class="buttons">
                    <asp:Button ID="btnProceed" runat="server"
                                Text="Proceed"
                                CssClass="btn-proceed"
                                OnClick="btnProceed_Click" />

                    <asp:Button ID="btnBack" runat="server"
                                Text="Home"
                                CssClass="btn-home"
                                OnClick="btnBack_Click" />
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

            </div>
        </div>
    </form>
</body>
</html>
