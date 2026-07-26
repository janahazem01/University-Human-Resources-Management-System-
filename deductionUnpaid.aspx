<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="deductionUnpaid.aspx.cs"
    Inherits="Team75.deductionUnpaid" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Deduction Due to Unpaid Leave</title>

    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f5f5f5; 
        }

        .container {
            max-width: 1000px;
            margin: 40px auto;
            background: #ffffff;
            padding: 35px 45px;
            border-radius: 10px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }

        .page-title {
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            color: #333;
            margin-bottom: 25px;
        }

        .info-label {
            color: #dc3545;
            font-weight: bold;
            display: block;
            margin-bottom: 15px;
            font-size: 15px;
        }

   
        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
            margin-bottom: 30px;
            font-size: 14px;
        }

        .gridview th, .gridview td {
            border: 1px solid #ddd;
            padding: 8px 10px;
            text-align: center;
        }

        .gridview th {
            background-color: #eeeeee;
            color: #333;
            font-weight: bold;
        }

        .btn {
            border: none;
            padding: 10px 24px;
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
            background-color: #dc3545;
            color: #fff;
        }
        .btn-red:hover {
            background-color: #c82333;
        }

        .btn-row {
            text-align: center;
            margin-top: 20px;
        }

        .question {
            text-align: center;
            margin-top: 20px;
            font-size: 18px;
            font-weight: 600;
            color: #333;
        }

    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="container">

            <div class="page-title">Deduction Due to Unpaid Leave</div>

         
            <asp:Label ID="lblInfo" runat="server"
                       CssClass="info-label"></asp:Label>

   
            <asp:GridView ID="gridDeductions" runat="server"
                          AutoGenerateColumns="true"
                          CssClass="gridview">
            </asp:GridView>

         
            <div class="question">
                Do you want to calculate deductions for another employee?
            </div>

     
            <div class="btn-row">

                <asp:Button ID="btnYes" runat="server"
                    Text="Yes"
                    CssClass="btn btn-primary"
                    PostBackUrl="~/verify_deductionUnpaid.aspx" />

                <asp:Button ID="btnNo" runat="server"
                    Text="No (Back to HR Home)"
                    CssClass="btn btn-red"
                    PostBackUrl="~/HR_Home.aspx" />

            </div>

        </div>

    </form>
</body>
</html>