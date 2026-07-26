<%@ Page Language="C#" AutoEventWireup="true"
         CodeBehind="ApplyAnnualLeave.aspx.cs"
         Inherits="Team75.ApplyAnnualLeave" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Apply for Annual Leave</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }
        .container {
            max-width: 800px;
            margin: 20px auto;
            background: #ffffff;
            padding: 30px 35px;
            border-radius: 8px;
            box-shadow: 0 0 12px rgba(0,0,0,0.12);
        }
        h1 {
            margin-bottom: 25px;
            font-size: 36px;
        }
        .form-group {
            margin-bottom: 18px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 6px;
            font-size: 16px;
        }
        .textbox {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .value {
            font-weight: bold;
            font-size: 18px;
            display: block;
            margin-top: 4px;
        }
        .buttons {
            margin-top: 20px;
        }
        .button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 22px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 15px;
            margin-right: 10px;
        }
        .button:hover {
            background-color: #45a049;
        }
        .msg {
            margin-top: 15px;
            color: red;
            font-size: 14px;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="container">

        <h1>Apply for Annual Leave</h1>

        <!-- Logged-in employee ID -->
        <div class="form-group">
            <label>Your Employee ID:</label>
            <asp:Label ID="lblEmployeeID" runat="server" CssClass="value"></asp:Label>
        </div>

        <!-- Start date -->
        <div class="form-group">
            <label for="txtStartDate">Start Date:</label>
            <asp:TextBox ID="txtStartDate" runat="server"
                         CssClass="textbox"
                         TextMode="Date"></asp:TextBox>
        </div>

        <!-- End date -->
        <div class="form-group">
            <label for="txtEndDate">End Date:</label>
            <asp:TextBox ID="txtEndDate" runat="server"
                         CssClass="textbox"
                         TextMode="Date"></asp:TextBox>
        </div>

        <div class="buttons">
            <asp:Button ID="btnSubmit" runat="server"
                        Text="Submit Annual Leave"
                        CssClass="button"
                        OnClick="btnSubmit_Click" />

            <asp:Button ID="btnHome" runat="server"
                        Text="Back to Academic Employee HomePage"
                        CssClass="button"
                        OnClick="btnHome_Click" />
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="msg"></asp:Label>

    </div>
</form>
</body>
</html>
