<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApproveAnnualLeave.aspx.cs" Inherits="Team75.ApproveAnnualLeave" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Approve / Reject Annual Leaves</title>
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
            margin-top: 10px;
            margin-bottom: 10px;
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

        .gridview-style th, .gridview-style td {
            border: 1px solid #ddd;
            padding: 6px 8px;
            text-align: center;
        }

        .gridview-style th {
            background-color: #f0f0f0;
        }

        .gv-button {
            padding: 4px 8px;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            color: #fff;
        }

        .gv-process {
            background-color: #4CAF50;
        }

        .gv-process:hover {
            background-color: #45a049;
        }

        .btn-main {
            padding: 6px 14px;
            background-color: #4CAF50;
            color: #fff;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn-main:hover {
            background-color: #45a049;
        }

        .back-row {
            margin-top: 20px;
            text-align: right;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrapper">
            <h1>Approve / Reject Annual Leaves</h1>

            <!-- Auto role info -->
            <div class="section-title">Upperboard Verification</div>
            <asp:Label ID="lblStatus" runat="server" CssClass="message"></asp:Label>

            <!-- Annual leave requests table (only visible if authorized) -->
            <asp:Panel ID="pnlAnnual" runat="server" Visible="false">
                <div class="section-title">Annual Leave Requests</div>
                <div class="grid-container">
                    <asp:GridView ID="gvAnnual" runat="server"
                                  AutoGenerateColumns="False"
                                  CssClass="gridview-style"
                                  DataKeyNames="request_ID,replacement_emp"
                                  OnRowCommand="gvAnnual_RowCommand"
                                  OnRowDataBound="gvAnnual_RowDataBound">
                        <Columns>
                            <asp:BoundField DataField="request_ID" HeaderText="Request ID" />
                            <asp:BoundField DataField="Emp_ID" HeaderText="Employee ID" />
                            <asp:BoundField DataField="start_date" HeaderText="Start Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="end_date" HeaderText="End Date" DataFormatString="{0:yyyy-MM-dd}" />
                            <asp:BoundField DataField="final_approval_status" HeaderText="Final Status" />

                            <asp:TemplateField HeaderText="Process">
                                <ItemTemplate>
                                    <asp:Button ID="btnProcess" runat="server"
                                                Text="Approve / Reject"
                                                CssClass="gv-button gv-process"
                                                CommandName="ProcessReq"
                                                CommandArgument="<%# Container.DataItemIndex %>" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </asp:Panel>

            <!-- Back button -->
            <div class="back-row">
                <asp:Button ID="btnBack" runat="server"
                            Text="Back to Academic Employee"
                            CssClass="btn-main"
                            OnClick="btnBack_Click" />
            </div>
        </div>
    </form>
</body>
</html>
