<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="verify_Compensation.aspx.cs"
    Inherits="Team75.verify_Compensation" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Approve / Reject Compensation Leaves</title>

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
            padding: 30px 40px;
            background-color: #ffffff;
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

        .label-hrid {
            font-size: 18px;
            font-weight: 600;
            color: #222;
            display: block;
            margin-bottom: 18px;
        }

        .error-label {
            display: block;
            margin-bottom: 12px;
            color: #d9534f;
            font-weight: 600;
        }

        .input-label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
            color: #333;
        }

        .text-input {
            width: 260px;
            padding: 8px 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .button-row {
            margin-top: 16px;
            margin-bottom: 26px;
        }

        .btn {
            display: inline-block;
            min-width: 160px;
            padding: 9px 18px;
            border-radius: 6px;
            border: none;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            text-align: center;
        }

        .btn-primary {
            background-color: #28a745;
            color: #fff;
            margin-right: 10px;
        }

        .btn-primary:hover {
            background-color: #218838;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: #fff;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        /* NEW RED BUTTON */
        .btn-red {
            background-color: #d9534f;
            color: #fff;
        }
        .btn-red:hover {
            background-color: #c9302c;
        }

        .footer-buttons {
            text-align: center;
            margin-top: 25px;
        }

        .grid-title {
            font-size: 20px;
            font-weight: 600;
            margin: 18px 0 10px;
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
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="page-container">

            <h1 class="page-title">Approve / Reject Compensation Leaves</h1>

            <!-- HR ID display -->
            <asp:Label ID="lblHRID" runat="server"
                Text="Your HR ID is: (loading...)"
                CssClass="label-hrid"></asp:Label>

            <!-- Error / info label -->
            <asp:Label ID="lblError" runat="server"
                CssClass="error-label"></asp:Label>

            <!-- Request ID input -->
            <asp:Label ID="Label1" runat="server"
                Text="Enter Leave Request ID to approve/reject:"
                CssClass="input-label" />

            <asp:TextBox ID="txtRequestID" runat="server"
                CssClass="text-input"></asp:TextBox>

            <!-- Buttons -->
            <div class="button-row">
                <asp:Button ID="btnLoad" runat="server"
                    Text="Load Leave Details"
                    CssClass="btn btn-secondary"
                    OnClick="btnLoad_Click" />

                <asp:Button ID="btnProceed" runat="server"
                    Text="Proceed (Approve / Reject)"
                    CssClass="btn btn-primary"
                    OnClick="btnProceed_Click" />
            </div>

            <!-- Grids -->
            <h3 class="grid-title">Leave Record (from Leave table)</h3>
            <asp:GridView ID="gridLeave" runat="server"
                AutoGenerateColumns="true"
                CssClass="data-grid">
            </asp:GridView>

            <h3 class="grid-title">Compensation Leave Details</h3>
            <asp:GridView ID="gridComp" runat="server"
                AutoGenerateColumns="true"
                CssClass="data-grid">
            </asp:GridView>

            <!-- NEW RED BUTTON -->
            <div class="footer-buttons">
                <asp:Button ID="btnBackHome" runat="server"
                    Text="Go Back to HR Home"
                    CssClass="btn btn-red"
                    PostBackUrl="~/HR_Home.aspx" />
            </div>

        </div>
    </form>
</body>
</html>