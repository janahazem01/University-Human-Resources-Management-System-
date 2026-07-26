<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Performance.aspx.cs" Inherits="Team75.Performance" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Performance</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background-color: #f4f4f4; }
        .container {
            max-width: 800px; margin: 0 auto; background: white;
            padding: 20px; border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        h1, h2 { color: #333; }
        .form-group { margin-bottom: 15px; }
        label { font-weight: bold; display: block; margin-bottom: 5px; }
        .textbox {
            width: 100%; padding: 8px; border: 1px solid #ddd;
            border-radius: 4px; box-sizing: border-box;
        }
        .button {
            background-color: #4CAF50; color: white;
            padding: 10px 20px; border: none;
            border-radius: 4px; cursor: pointer; font-size: 16px;
        }
        .button:hover { background-color: #45a049; }
        .gridview {
            width: 100%; border-collapse: collapse; margin-top: 20px;
        }
        .gridview th, .gridview td {
            border: 1px solid #ddd; padding: 8px; text-align: left;
        }
        .gridview th { background-color: #4CAF50; color: white; }
        .rating { font-weight: bold; color: #2196F3; }
        .no-data { color: #f44336; text-align: center; padding: 20px; }
        .bottom-actions { margin-top: 25px; text-align: right; }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="container">

        <h1>My Performance Records</h1>

        <!-- DISPLAY LOGGED-IN EMPLOYEE ID -->
        <div class="form-group">
            <label>Your Employee ID:</label>
            <asp:Label ID="lblEmployeeID" runat="server" Font-Bold="true" />
        </div>

        <!-- Semester input -->
        <div class="form-group">
            <label for="txtSemester">Semester / Period (e.g., W23, S24):</label>
            <asp:TextBox ID="txtSemester" runat="server" CssClass="textbox"
                         placeholder="e.g., W23, S24"></asp:TextBox>
        </div>

        <asp:Button ID="btnSearch" runat="server"
                    Text="Search"
                    CssClass="button"
                    OnClick="btnSearch_Click" />

        <hr />

        <h2>Performance Results</h2>

        <asp:GridView ID="gvPerformance" runat="server" CssClass="gridview"
                      AutoGenerateColumns="false"
                      EmptyDataText="No performance records found.">
            <Columns>
                <asp:BoundField DataField="performance_ID" HeaderText="ID" />
                <asp:TemplateField HeaderText="Rating">
                    <ItemTemplate>
                        <span class="rating"><%# Eval("rating") %>/5</span>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="comments" HeaderText="Comments" />
                <asp:BoundField DataField="semester" HeaderText="Semester" />
            </Columns>
            <EmptyDataTemplate>
                <div class="no-data">No performance records found.</div>
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
