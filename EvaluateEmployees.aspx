<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EvaluateEmployees.aspx.cs" Inherits="Team75.EvaluateEmployees" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Evaluate Employees</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
        .wrapper {
            max-width: 1100px;
            margin: 30px auto;
            background-color: #ffffff;
            padding: 20px 25px;
            border-radius: 6px;
            box-shadow: 0 0 8px rgba(0,0,0,0.1);
        }
        h1 {
            font-size: 36px;
            margin-bottom: 20px;
        }
        .section-title {
            font-size: 20px;
            font-weight: bold;
            margin-top: 15px;
            margin-bottom: 10px;
        }
        .field-row {
            margin-bottom: 10px;
        }
        .field-row label {
            display: inline-block;
            width: 180px;
        }
        .field-row input[type="text"],
        .field-row textarea,
        .field-row select {
            width: 250px;
            padding: 4px;
        }
        textarea {
            height: 60px;
            resize: vertical;
        }
        .btn-main {
            padding: 6px 16px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 8px;
        }
        .btn-main:hover {
            background-color: #45a049;
        }
        .message {
            margin-top: 8px;
            font-weight: bold;
        }
        .message.error {
            color: #c0392b;
        }
        .message.success {
            color: #27ae60;
        }
        .grid-container {
            margin-top: 20px;
        }
        .gridview-style {
            width: 100%;
            border-collapse: collapse;
        }
        .gridview-style th,
        .gridview-style td {
            border: 1px solid #ddd;
            padding: 6px 8px;
            text-align: center;
        }
        .gridview-style th {
            background-color: #f0f0f0;
        }
        .buttons-row {
            margin-top: 15px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <h1>Evaluate Employees</h1>

            <asp:Label ID="lblStatus" runat="server" CssClass="message"></asp:Label>

            <!-- Evaluation form (only usable if user is Dean) -->
            <div class="section-title">New Evaluation</div>

            <div class="field-row">
                <label for="ddlEmployees">Employee:</label>
                <asp:DropDownList ID="ddlEmployees" runat="server">
                </asp:DropDownList>
            </div>

            <div class="field-row">
                <label for="txtRating">Rating (integer):</label>
                <asp:TextBox ID="txtRating" runat="server"></asp:TextBox>
            </div>

            <div class="field-row">
                <label for="txtSemester">Semester (3 chars):</label>
                <asp:TextBox ID="txtSemester" runat="server" MaxLength="3"></asp:TextBox>
            </div>

            <div class="field-row">
                <label for="txtComment">Comment:</label>
                <asp:TextBox ID="txtComment" runat="server" TextMode="MultiLine"></asp:TextBox>
            </div>

            <div class="buttons-row">
                <asp:Button ID="btnSubmit" runat="server"
                            Text="Save Evaluation"
                            CssClass="btn-main"
                            OnClick="btnSubmit_Click" />

                <asp:Button ID="btnBack" runat="server"
                            Text="Back"
                            CssClass="btn-main"
                            OnClick="btnBack_Click" />
            </div>

            <div class="section-title">Existing Evaluations</div>
            <div class="grid-container">
                <asp:GridView ID="gvPerformance" runat="server"
                              AutoGenerateColumns="True"
                              CssClass="gridview-style">
                </asp:GridView>
            </div>
        </div>
    </form>
</body>
</html>
