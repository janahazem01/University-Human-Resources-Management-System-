<%@ Page Language="C#" AutoEventWireup="true"
         CodeBehind="Deductions.aspx.cs"
         Inherits="Team75.Deductions" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Attendance Deductions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 900px;
            margin: 0 auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            margin-bottom: 15px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .textbox {
            width: 250px;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 8px 18px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 8px;
        }
        .button:hover {
            background-color: #45a049;
        }
        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        .gridview th, .gridview td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .gridview th {
            background-color: #4CAF50;
            color: white;
        }
        .gridview tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        .no-data {
            color: #f44336;
            text-align: center;
            padding: 20px;
        }
        .info {
            margin-top: 5px;
            color: #555;
        }
        .bottom-actions {
            margin-top: 20px;
            text-align: right;
        }
        .msg {
            margin-top: 10px;
            color: red;
        }
        .value {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">

            <h1>My Attendance Deductions</h1>

            <!-- Logged-in Employee ID -->
            <div class="form-group">
                <label>Your Employee ID:</label>
                <asp:Label ID="lblEmployeeID" runat="server" CssClass="value"></asp:Label>
            </div>

            <!-- Date / Month input -->
            <div class="form-group">
                <label for="txtDate">Month (enter any date in that month or month number 1–12):</label>
                <asp:TextBox ID="txtDate" runat="server" CssClass="textbox"
                             Placeholder="e.g., 2025-12-01 or 12"></asp:TextBox>
                <div class="info">
                    The system will use the month from this date to filter your deductions.
                </div>
            </div>

            <div class="form-group">
                <asp:Button ID="btnSearch" runat="server"
                            Text="Search"
                            CssClass="button"
                            OnClick="btnSearch_Click" />

                <asp:Button ID="btnBack" runat="server"
                            Text="Back to Academic Employee HomePage"
                            CssClass="button"
                            OnClick="btnBack_Click" />
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="msg"></asp:Label>

            <asp:GridView ID="gvDeductions" runat="server"
                          CssClass="gridview"
                          AutoGenerateColumns="true"
                          EmptyDataText="No deductions found for this month.">
                <EmptyDataTemplate>
                    <div class="no-data">
                        No deductions found for this month.
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>

        </div>
    </form>
</body>
</html>
