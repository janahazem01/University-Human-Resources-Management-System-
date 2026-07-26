<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ApproveCompensation.aspx.cs"
    Inherits="Team75.ApproveCompensation" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Compensation Leave After Approval / Rejection</title>

    <style type="text/css">
        body {
            margin: 0;
            padding: 40px 0;
            font-family: "Segoe UI", Tahoma, Arial, sans-serif;
            background-color: #f5f5f5; /* Light grey */
        }

        .page-container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 35px 45px;
            background-color: white;
            border-radius: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        }

        .page-title {
            text-align: center;
            font-size: 30px;
            font-weight: 700;
            margin-bottom: 25px;
            color: #333;
        }

        .info-label {
            display: block;
            font-weight: 600;
            color: #d9534f;
            margin-bottom: 20px;
            font-size: 15px;
        }

        .grid-title {
            font-size: 20px;
            font-weight: 600;
            margin: 20px 0 12px;
            color: #333;
        }

        .data-grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 18px;
        }

        .data-grid th,
        .data-grid td {
            padding: 9px 11px;
            border: 1px solid #e0e0e0;
            text-align: center;
        }

        .data-grid th {
            background-color: #eeeeee;
            font-weight: 600;
        }

        .data-grid tr:nth-child(even) td {
            background-color: #fafafa;
        }

        .question-label {
            display: block;
            font-size: 18px;
            font-weight: 600;
            margin-top: 25px;
            text-align: center;
            color: #333;
        }

        .button-row {
            margin-top: 25px;
            text-align: center;
        }

        .btn {
            display: inline-block;
            min-width: 140px;
            padding: 10px 20px;
            margin: 0 10px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
        }

        .btn-yes {
            background-color: #28a745; /* green */
            color: white;
        }

        .btn-yes:hover {
            background-color: #218838;
        }

        .btn-no {
            background-color: #d9534f; /* red */
            color: white;
        }

        .btn-no:hover {
            background-color: #c9302c;
        }

    </style>

</head>

<body>
    <form id="form1" runat="server">
        <div class="page-container">

            <h1 class="page-title">Compensation Leave After Approval / Rejection</h1>

            <asp:Label ID="lblInfo" runat="server"
                       CssClass="info-label"></asp:Label>

            <!-- Leave table -->
            <h3 class="grid-title">Leave Record (after update)</h3>
            <asp:GridView ID="GridViewLeaveAfter" runat="server"
                AutoGenerateColumns="true"
                CssClass="data-grid">
            </asp:GridView>

            <!-- Approval table -->
            <h3 class="grid-title">Employee_Approve_Leave Entries (after update)</h3>
            <asp:GridView ID="GridViewApproveAfter" runat="server"
                AutoGenerateColumns="true"
                CssClass="data-grid">
            </asp:GridView>

            <!-- Question -->
            <asp:Label ID="lblQuestion" runat="server"
                CssClass="question-label"
                Text="Do you want to approve/reject other compensation leaves?"></asp:Label>

            <!-- Buttons -->
            <div class="button-row">
                <asp:Button ID="btnYes" runat="server"
                    Text="Yes"
                    CssClass="btn btn-yes"
                    OnClick="btnYes_Click" />

                <asp:Button ID="btnNo" runat="server"
                    Text="No (Back to HR Home)"
                    CssClass="btn btn-no"
                    OnClick="btnNo_Click" />
            </div>

        </div>
    </form>
</body>
</html>