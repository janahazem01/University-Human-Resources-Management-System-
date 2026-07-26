<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="deductionHours.aspx.cs"
    Inherits="Team75.deductionHours" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Monthly Missing Hours Deduction</title>

    <style type="text/css">
        body {
            margin: 0;
            padding: 40px 0;
            font-family: "Segoe UI", Tahoma, Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .page-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 35px 45px;
            background-color: #ffffff;
            border-radius: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 4px 12px rgba(0,0,0,0.06);
        }

        .page-title {
            text-align: center;
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #333;
        }

        .info-label {
            display: block;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .info-label.red {
            color: #d9534f;
        }

        .data-grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            margin-bottom: 25px;
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

        /* Buttons */
        .btn {
            display: inline-block;
            padding: 10px 20px;
            min-width: 160px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            margin: 8px;
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
        }
        .btn-danger:hover {
            background-color: #c9302c;
        }

        .question {
            margin-top: 25px;
            font-size: 18px;
            font-weight: 600;
            color: #333;
            text-align: center;
        }

        .button-row {
            text-align: center;
            margin-top: 15px;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">

        <div class="page-container">

            <!-- PAGE TITLE -->
            <h1 class="page-title">Monthly Missing Hours Deduction</h1>

            <!-- INFO LABEL -->
            <asp:Label ID="lblInfo" runat="server"
                CssClass="info-label red"></asp:Label>

            <!-- GRID -->
            <asp:GridView ID="gridDeduction" runat="server"
                AutoGenerateColumns="true"
                CssClass="data-grid"
                Visible="false">
            </asp:GridView>

            <!-- NEW QUESTION -->
            <div class="question">
                Do you want to calculate deductions for another employee?
            </div>

            <!-- BUTTONS -->
            <div class="button-row">
                <asp:Button ID="btnYes" runat="server"
                    Text="Yes"
                    CssClass="btn btn-primary"
                    PostBackUrl="~/verify_deductionHours.aspx" />

                <asp:Button ID="btnNo" runat="server"
                    Text="No (Back to HR Home)"
                    CssClass="btn btn-danger"
                    PostBackUrl="~/HR_Home.aspx" />
            </div>

        </div>

    </form>

</body>
</html>