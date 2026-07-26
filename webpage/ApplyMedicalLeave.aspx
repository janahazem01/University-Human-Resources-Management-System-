<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ApplyMedicalLeave.aspx.cs"
    Inherits="Team75.ApplyMedicalLeave" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Apply for Medical Leave</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
        }
        .container {
            max-width: 900px;
            margin: 20px auto;
            background: #ffffff;
            padding: 30px 35px;
            border-radius: 8px;
            box-shadow: 0 0 12px rgba(0,0,0,0.12);
        }
        h1 {
            margin-bottom: 20px;
            font-size: 32px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        .textbox, .dropdown {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .value {
            font-weight: bold;
            font-size: 18px;
            display: block;
        }
        .inline {
            display: inline-block;
            margin-right: 10px;
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
            margin-top: 10px;
            color: red;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="container">

        <h1>Apply for Medical Leave</h1>

        <!-- Employee ID -->
        <div class="form-group">
            <label>Your Employee ID:</label>
            <asp:Label ID="lblEmployeeID" runat="server" CssClass="value"></asp:Label>
        </div>

        <!-- Start date -->
        <div class="form-group">
            <label for="txtStartDate">Start Date:</label>
            <asp:TextBox ID="txtStartDate" runat="server"
                         CssClass="textbox"
                         TextMode="Date" />
        </div>

        <!-- End date -->
        <div class="form-group">
            <label for="txtEndDate">End Date:</label>
            <asp:TextBox ID="txtEndDate" runat="server"
                         CssClass="textbox"
                         TextMode="Date" />
        </div>

        <!-- Medical type -->
        <div class="form-group">
            <label for="txtMedicalType">Medical Type:</label>
            <asp:TextBox ID="txtMedicalType" runat="server"
                         CssClass="textbox"
                         placeholder="e.g., Sick, Surgery, Maternity" />
        </div>

        <!-- Insurance status -->
        <div class="form-group">
            <asp:CheckBox ID="chkInsurance" runat="server"
                          CssClass="inline" />
            <label class="inline" for="chkInsurance">Covered by insurance</label>
        </div>

        <!-- Disability details -->
        <div class="form-group">
            <label for="txtDisabilityDetails">Disability Details (if any):</label>
            <asp:TextBox ID="txtDisabilityDetails" runat="server"
                         CssClass="textbox"
                         MaxLength="50"
                         placeholder="Optional" />
        </div>

        <!-- Document description -->
        <div class="form-group">
            <label for="txtDocDescription">Document Description:</label>
            <asp:TextBox ID="txtDocDescription" runat="server"
                         CssClass="textbox"
                         MaxLength="50"
                         placeholder="e.g., Medical report, lab results" />
        </div>

        <!-- File upload (we will just store the file name) -->
        <div class="form-group">
            <label for="fuDocument">Upload Document (file name will be stored):</label>
            <asp:FileUpload ID="fuDocument" runat="server" CssClass="textbox" />
        </div>

        <div class="buttons">
            <asp:Button ID="btnSubmit" runat="server"
                        Text="Submit Medical Leave"
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
