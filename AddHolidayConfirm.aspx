<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddHolidayConfirm.aspx.cs" Inherits="Team75.AddHolidayConfirm" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add New Official Holiday - Confirm</title>

    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
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
        .container {
            background-color: #ffffff;
            padding: 30px 40px;
            width: 900px;
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.20);
        }

        h2 {
            text-align: center;
            font-size: 30px;
            margin-bottom: 20px;
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

        .row-input {
            margin-top: 10px;
        }

        .label {
            font-size: 16px;
            font-weight: bold;
            margin-right: 8px;
            display: inline-block;
            width: 140px;
        }

        .textbox {
            font-size: 16px;
            padding: 6px 8px;
            width: 220px;
            margin-right: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .hint {
            font-size: 12px;
            color: #666;
            margin-left: 8px;
        }

        .question {
            font-size: 18px;
            font-weight: bold;
            margin-top: 25px;
            text-align: center;
        }

        .buttons {
            text-align: center;
            margin-top: 20px;
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        /* Green YES button (same green as other pages) */
        .btn-yes {
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 120px;
        }

        .btn-yes:hover {
            background-color: #43a047;
        }

        /* Red NO button (same red as logout) */
        .btn-no {
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #D32F2F;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 120px;
        }

        .btn-no:hover {
            background-color: #b71c1c;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">
            <div class="container">

                <h2>Holiday Table (Before Adding New Holiday)</h2>

                <asp:GridView ID="GridViewHolidays" runat="server"
                              AutoGenerateColumns="True"
                              CssClass="grid">
                </asp:GridView>

                <div class="row-input">
                    <span class="label">Holiday Name:</span>
                    <asp:TextBox ID="txtHolidayName" runat="server" CssClass="textbox"></asp:TextBox>
                </div>

                <div class="row-input">
                    <span class="label">From Date:</span>
                    <asp:TextBox ID="txtFromDate" runat="server"
                                 CssClass="textbox" Placeholder="YYYY-MM-DD"></asp:TextBox>
                    <span class="hint">(start of holiday)</span>
                </div>

                <div class="row-input">
                    <span class="label">To Date:</span>
                    <asp:TextBox ID="txtToDate" runat="server"
                                 CssClass="textbox" Placeholder="YYYY-MM-DD"></asp:TextBox>
                    <span class="hint">(end of holiday)</span>
                </div>

                <div class="question">
                    Are you sure you want to add this holiday?
                </div>

                <div class="buttons">
                    <asp:Button ID="btnYes" runat="server"
                                Text="Yes"
                                CssClass="btn-yes"
                                OnClick="btnYes_Click" />
                    <asp:Button ID="btnNo" runat="server"
                                Text="No"
                                CssClass="btn-no"
                                OnClick="btnNo_Click" />
                    <!-- Back to Admin Home button removed as requested -->
                </div>

            </div>
        </div>
    </form>
</body>
</html>
