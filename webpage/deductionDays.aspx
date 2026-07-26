<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="deductionDays.aspx.cs"
    Inherits="Team75.deductionDays" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Deduction Due to Missing Days</title>

    <style type="text/css">
        body {
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .page-wrapper {
            max-width: 1100px;
            margin: 30px auto;
            padding: 30px 40px;
            background-color: #ffffff;
            border-radius: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.06);
        }

        h2 {
            text-align: center;
            margin-top: 0;
            margin-bottom: 25px;
            font-size: 28px;
            color: #333333;
        }

        .info-label {
            color: #dc3545;
            font-weight: bold;
            margin-bottom: 20px;
            display: block;
            text-align: center;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
            margin-bottom: 25px;
        }

        .gridview th {
            background-color: #eeeeee;
            font-weight: bold;
            padding: 8px;
            border: 1px solid #dddddd;
            text-align: left;
        }

        .gridview td {
            padding: 8px;
            border: 1px solid #dddddd;
        }

        .question {
            margin-top: 20px;
            text-align: center;
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }

        .btn-row {
            margin-top: 15px;
            text-align: center;
        }

        .btn {
            display: inline-block;
            padding: 10px 26px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 15px;
            font-weight: 600;
            margin-right: 12px;
        }

        .btn-primary {
            background-color: #28a745;
            color: white;
        }
        .btn-primary:hover {
            background-color: #218838;
        }

        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">

            <h2>Deduction Due to Missing Days</h2>

            <asp:Label ID="lblInfo" runat="server"
                       CssClass="info-label"></asp:Label>

            <asp:GridView ID="gridDeductions" runat="server"
                          AutoGenerateColumns="true"
                          CssClass="gridview">
            </asp:GridView>

            <!-- NEW QUESTION -->
            <div class="question">
                Do you want to calculate deductions for another employee?
            </div>

            <!-- BUTTONS ROW -->
            <div class="btn-row">
                <asp:Button ID="btnYes" runat="server"
                            Text="Yes"
                            CssClass="btn btn-primary"
                            PostBackUrl="~/verify_deductionDays.aspx" />

                <asp:Button ID="btnNo" runat="server"
                            Text="No (Back to HR Home)"
                            CssClass="btn btn-danger"
                            PostBackUrl="~/HR_Home.aspx" />
            </div>

        </div>
    </form>
</body>
</html>