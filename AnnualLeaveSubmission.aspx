<%@ Page Language="C#" AutoEventWireup="true"
         CodeBehind="AnnualLeaveSubmission.aspx.cs"
         Inherits="Team75.AnnualLeaveSubmission" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Annual Leave Submissions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }
        .container {
            max-width: 900px;
            margin: 40px auto;
            background: #ffffff;
            padding: 20px 25px;
            border-radius: 6px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 { margin-bottom: 15px; }
        .info { margin-bottom: 10px; color: #555; }
        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
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
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 8px 18px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-top: 15px;
        }
        .button:hover {
            background-color: #45a049;
        }
        .msg { margin-top: 10px; color: #333; }
        .value { font-weight: bold; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">

            <h1>My Annual Leave Submissions</h1>

            <div class="info">
                Employee ID: <asp:Label ID="lblEmployeeID" runat="server" CssClass="value"></asp:Label>
            </div>

            <asp:Label ID="lblMessage" runat="server" CssClass="msg"></asp:Label>

            <asp:GridView ID="gvAnnualLeaves" runat="server"
                          CssClass="gridview"
                          AutoGenerateColumns="True"
                          EmptyDataText="You have no pending annual leave requests.">
                <EmptyDataTemplate>
                    <div class="no-data">
                        You have no pending annual leave requests.
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>

            <asp:Button ID="btnBack" runat="server"
                        Text="Back to Academic Employee HomePage"
                        CssClass="button"
                        OnClick="btnBack_Click" />

        </div>
    </form>
</body>
</html>
