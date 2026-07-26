<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="CompensationLeaveSubmission.aspx.cs"
    Inherits="Team75.CompensationLeaveSubmission" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Compensation Leave Submissions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 1000px;
            margin: 20px auto;
            background: #ffffff;
            padding: 30px 35px;
            border-radius: 8px;
            box-shadow: 0 0 12px rgba(0,0,0,0.12);
        }
        h1 {
            margin-bottom: 15px;
            font-size: 32px;
        }
        .info {
            margin-bottom: 10px;
            color: #555;
        }
        .value {
            font-weight: bold;
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
        .bottom-actions {
            margin-top: 20px;
            text-align: left;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 8px 18px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
        }
        .button:hover {
            background-color: #45a049;
        }
        .msg {
            margin-top: 10px;
            color: #333;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="container">

        <h1>My Compensation Leave Submissions</h1>

        <div class="info">
            Employee ID:
            <asp:Label ID="lblEmployeeID" runat="server" CssClass="value"></asp:Label>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="msg"></asp:Label>

        <asp:GridView ID="gvCompLeaves" runat="server"
            CssClass="gridview"
            AutoGenerateColumns="true"
            EmptyDataText="You have no compensation leave submissions.">
            <EmptyDataTemplate>
                <div class="no-data">
                    You have no compensation leave submissions.
                </div>
            </EmptyDataTemplate>
        </asp:GridView>

        <div class="bottom-actions">
            <asp:Button ID="btnBack" runat="server"
                Text="Back to Academic Employee HomePage"
                CssClass="button"
                OnClick="btnBack_Click" />
        </div>

    </div>
</form>
</body>
</html>
