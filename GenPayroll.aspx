<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="GenPayroll.aspx.cs"
    Inherits="Team75.GenPayroll" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Payroll Summary</title>

    <style type="text/css">
        /* PAGE BACKGROUND */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f5f5f5;
        }

        /* MAIN CONTAINER */
        .container {
            max-width: 1000px;
            margin: 40px auto;
            background-color: #ffffff;
            border-radius: 10px;
            padding: 35px 45px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }

        h2 {
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            color: #333;
            margin-bottom: 25px;
        }

        h3 {
            color: #333;
            margin-top: 25px;
            margin-bottom: 10px;
        }

        .info-label {
            color: #dc3545;
            font-weight: bold;
            margin-bottom: 12px;
            display: block;
        }

        /* GRIDVIEW STYLE */
        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
            font-size: 14px;
        }

        .gridview th {
            background-color: #eeeeee;
            font-weight: bold;
            color: #333;
            border: 1px solid #ddd;
            padding: 8px 10px;
            text-align: center;
        }

        .gridview td {
            border: 1px solid #ddd;
            padding: 8px 10px;
            text-align: center;
        }

        /* BUTTONS */
        .btn {
            border: none;
            padding: 10px 22px;
            font-size: 15px;
            border-radius: 6px;
            cursor: pointer;
            font-weight: 600;
            margin-right: 12px;
        }

        .btn-primary {
            background-color: #28a745;
            color: #fff;
        }
        .btn-primary:hover {
            background-color: #218838;
        }

        .btn-red {
            background-color: #d9534f;
            color: #fff;
        }
        .btn-red:hover {
            background-color: #c9302c;
        }

        .button-row {
            margin-top: 20px;
        }
    </style>

</head>
<body>
<form id="form1" runat="server">
    <div class="container">

        <h2>Payroll for Current Month</h2>

        <!-- INFO MESSAGE -->
        <asp:Label ID="lblInfo" runat="server"
                   CssClass="info-label"></asp:Label>

        <!-- PAYROLL GRID -->
        <h3>Payroll Record</h3>
        <asp:GridView ID="gridPayroll" runat="server"
            AutoGenerateColumns="true"
            CssClass="gridview">
        </asp:GridView>

        <!-- DEDUCTIONS SECTION -->
        <h3>Deductions (Finalized)</h3>
        <asp:Label ID="lblDeductionInfo" runat="server"
                   CssClass="info-label"></asp:Label>

        <asp:GridView ID="gridDeductions" runat="server"
            AutoGenerateColumns="true"
            CssClass="gridview">
        </asp:GridView>

        <!-- QUESTION + BUTTONS -->
        <h3>Do you want to generate a payroll for another employee?</h3>

        <div class="button-row">
            <asp:Button ID="btnYes" runat="server"
                        Text="Yes"
                        CssClass="btn btn-primary"
                        OnClick="btnYes_Click" />

            <asp:Button ID="btnNo" runat="server"
                        Text="No (Back to HR Home)"
                        CssClass="btn btn-red"
                        OnClick="btnNo_Click" />
        </div>

    </div>
</form>
</body>
</html>