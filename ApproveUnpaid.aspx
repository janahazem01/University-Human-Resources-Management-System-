<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="ApproveUnpaid.aspx.cs"
    Inherits="Team75.ApproveUnpaid" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Unpaid Leave After Approval / Rejection</title>

    <style type="text/css">
        body {
            margin: 0;
            padding: 40px 0;
            font-family: "Segoe UI", Tahoma, Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .page-container {
            max-width: 1100px;
            margin: 0 auto;
            padding: 30px;
            background-color: #ffffff;
            border-radius: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        }

        .page-title {
            text-align: center;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 30px;
            color: #333;
        }

        .section-title {
            font-size: 22px;
            font-weight: 600;
            margin: 25px 0 10px;
            color: #333;
        }

        .info-label {
            display: block;
            margin-bottom: 10px;
            color: #d9534f;
            font-weight: 600;
        }

        .data-grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .data-grid th,
        .data-grid td {
            padding: 10px 12px;
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

        .question-container {
            text-align: center;
            margin-top: 25px;
        }

        .question-text {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 18px;
            color: #333;
        }

        /* Add space ABOVE the buttons */
        .button-row {
            margin-top: 18px;
        }

        .btn {
            display: inline-block;
            min-width: 130px;
            padding: 10px 22px;
            border-radius: 6px;
            border: none;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
        }

        .btn-primary {
            background-color: #28a745;
            color: #fff;
        }

        .btn-primary:hover {
            background-color: #218838;
        }

        .btn-danger {
            background-color: #d9534f;
            color: #fff;
            margin-left: 12px;
        }

        .btn-danger:hover {
            background-color: #c9302c;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="page-container">

            <h1 class="page-title">Unpaid Leave After Approval / Rejection</h1>

            <asp:Label ID="lblInfo" runat="server" CssClass="info-label"></asp:Label>

            <h3 class="section-title">Leave Record (after update)</h3>
            <asp:GridView ID="GridViewLeaveAfter" runat="server"
                AutoGenerateColumns="true"
                CssClass="data-grid">
            </asp:GridView>

            <h3 class="section-title">Employee_Approve_Leave Entries (after update)</h3>
            <asp:GridView ID="GridViewApproveAfter" runat="server"
                AutoGenerateColumns="true"
                CssClass="data-grid">
            </asp:GridView>

            <div class="question-container">
                <asp:Label ID="lblQuestion" runat="server"
                    CssClass="question-text"
                    Text="Do you want to approve/reject other unpaid leaves?">
                </asp:Label>

                <!-- SPACED BUTTONS -->
                <div class="button-row">
                    <asp:Button ID="btnYes" runat="server"
                        Text="Yes"
                        CssClass="btn btn-primary"
                        OnClick="btnYes_Click" />

                    <asp:Button ID="btnNo" runat="server"
                        Text="No (Back to HR Home)"
                        CssClass="btn btn-danger"
                        OnClick="btnNo_Click" />
                </div>

            </div>

        </div>
    </form>
</body>
</html>