<%@ Page Language="C#" AutoEventWireup="true"
         CodeBehind="AttendanceRecords.aspx.cs"
         Inherits="Team75.AttendanceRecords" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Attendance Records - Current Month</title>
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
            text-align: right;
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
        .info {
            margin-top: 5px;
            color: #555;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            
            <h1>Attendance Records (Current Month)</h1>

            <asp:Label ID="lblInfo" runat="server" CssClass="info"></asp:Label>

            <asp:GridView ID="gvAttendance" runat="server"
                CssClass="gridview"
                AutoGenerateColumns="true"
                EmptyDataText="No attendance records found for this employee in the current month.">
                <EmptyDataTemplate>
                    <div class="no-data">
                        No attendance records found for this employee in the current month.
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>

            <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

            <div class="bottom-actions">
                <asp:Button ID="btnBack" runat="server"
                    Text="Back to Dashboard"
                    CssClass="button"
                    OnClick="btnBack_Click" />
            </div>

        </div>
    </form>
</body>
</html>
