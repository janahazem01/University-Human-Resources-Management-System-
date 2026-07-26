<%@ Page Language="C#" AutoEventWireup="true"
         CodeBehind="AttendanceInput.aspx.cs"
         Inherits="Team75.AttendanceInput" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Attendance Records - Confirm Employee</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 500px;
            margin: 60px auto;
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1 {
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
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
        .error {
            color: red;
            margin-top: 10px;
            display: block;
        }
        .value {
            font-weight: bold;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1>Retrieve Attendance Records</h1>

            <!-- Display logged-in Employee ID (no input) -->
            <div class="form-group">
                <label>Your Employee ID:</label>
                <asp:Label ID="lblEmployeeID" runat="server" CssClass="value"></asp:Label>
            </div>

            <div class="form-group">
                <asp:Button ID="btnProceed" runat="server"
                    Text="Proceed"
                    CssClass="button"
                    OnClick="btnProceed_Click" />

                <asp:Button ID="btnBack" runat="server"
                    Text="Back to Dashboard"
                    CssClass="button"
                    OnClick="btnBack_Click" />
            </div>

            <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>
        </div>
    </form>
</body>
</html>
