<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="approveAnnualAccidental.aspx.cs"
    Inherits="Team75.approveAnnualAccidental" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Approved / Rejected Leave Summary</title>

    <style type="text/css">
        /* Page background */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f5f5f5; /* light grey */
        }

        /* Centered white container */
        .container {
            max-width: 1000px;
            margin: 40px auto;
            background-color: #ffffff;
            border-radius: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
            padding: 30px 40px;
        }

        .page-title {
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            margin-bottom: 25px;
            color: #333;
        }

        .section-title {
            font-size: 20px;
            font-weight: bold;
            margin-top: 25px;
            margin-bottom: 10px;
            color: #333;
        }

        .info-label {
            font-weight: bold;
            color: #cc0000;
            margin-bottom: 15px;
            display: block;
        }

        /* Grid styling */
        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            font-size: 14px;
        }

        .grid th, .grid td {
            border: 1px solid #ddd;
            padding: 8px 10px;
            text-align: center;
        }

        /* Light grey header like the first page */
        .grid th {
            background-color: #eee;
            color: #333;
            font-weight: bold;
        }

        /* Question text */
        .question-text {
            text-align: center;
            font-weight: bold;
            margin: 25px 0 15px 0;
            color: #333;
        }

        /* Buttons area */
        .button-row {
            text-align: center;
            margin-top: 10px;
        }

        .btn {
            border: none;
            border-radius: 4px;
            padding: 10px 24px;
            font-size: 14px;
            cursor: pointer;
            margin: 0 8px;
        }

        .btn-primary-green {
            background-color: #28a745; /* green */
            color: #fff;
        }

        .btn-primary-green:hover {
            background-color: #218838;
        }

        .btn-danger-red {
            background-color: #d9534f; /* red */
            color: #fff;
        }

        .btn-danger-red:hover {
            background-color: #c9302c;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">

            <div class="page-title">
                Leave After Approval / Rejection
            </div>

            <asp:Label ID="lblInfo" runat="server"
                       CssClass="info-label"></asp:Label>

            <div class="section-title">Leave Record (after update)</div>
            <asp:GridView ID="GridViewLeaveAfter" runat="server"
                AutoGenerateColumns="true"
                CssClass="grid" />

            <div class="section-title">Employee_Approve_Leave Entries (after update)</div>
            <asp:GridView ID="GridViewApproveAfter" runat="server"
                AutoGenerateColumns="true"
                CssClass="grid" />

            <div class="question-text">
                Do you want to approve/reject other leaves?
            </div>

            <div class="button-row">
                <asp:Button ID="btnYes" runat="server"
                    Text="Yes"
                    CssClass="btn btn-primary-green"
                    OnClick="btnYes_Click" />

                <asp:Button ID="btnNo" runat="server"
                    Text="No (Back to HR Home)"
                    CssClass="btn btn-danger-red"
                    OnClick="btnNo_Click" />
            </div>

        </div>
    </form>
</body>
</html>