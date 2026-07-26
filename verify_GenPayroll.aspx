<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="verify_GenPayroll.aspx.cs"
    Inherits="Team75.verify_GenPayroll" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Generate Monthly Payroll - Verify</title>

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
            max-width: 900px;
            margin: 40px auto;
            background-color: #ffffff;
            border-radius: 10px;
            padding: 35px 45px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }

        /* TITLE */
        .page-title {
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            color: #333;
            margin-bottom: 25px;
        }

        /* LABEL BLOCKS */
        .field-label {
            display: block;
            margin-bottom: 4px;
            font-weight: 600;
            color: #333;
        }

        .hr-label {
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 10px;
            display: block;
        }

        .error-label {
            color: #dc3545;
            font-weight: bold;
            display: block;
            margin-bottom: 12px;
        }

        /* TEXTBOXES */
        .input-text {
            width: 260px;
            padding: 6px 8px;
            font-size: 14px;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        /* BUTTONS */
        .btn {
            border: none;
            border-radius: 6px;
            padding: 10px 22px;
            font-size: 15px;
            cursor: pointer;
            font-weight: 600;
            margin-right: 12px;
        }

        .btn-primary {
            background-color: #28a745; /* Green */
            color: #fff;
        }
        .btn-primary:hover {
            background-color: #218838;
        }

        .btn-red {
            background-color: #dc3545; /* Red for Back/Home */
            color: #fff;
        }
        .btn-red:hover {
            background-color: #c82333;
        }

        .btn-row {
            margin-top: 20px;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">
    <div class="container">

        <!-- PAGE TITLE -->
        <div class="page-title">Generate Monthly Payroll</div>

        <!-- HR ID -->
        <asp:Label ID="lblHR" runat="server"
                   CssClass="hr-label"></asp:Label>

        <!-- ERROR / INFO -->
        <asp:Label ID="lblError" runat="server"
                   CssClass="error-label"></asp:Label>

        <!-- EMPLOYEE ID -->
        <asp:Label ID="lblEmp" runat="server"
                   Text="Employee ID:"
                   CssClass="field-label"></asp:Label>
        <asp:TextBox ID="txtEmpId" runat="server"
                     CssClass="input-text"></asp:TextBox>
        <br /><br />

        <!-- FROM DATE -->
        <asp:Label ID="lblFrom" runat="server"
                   Text="From date:"
                   CssClass="field-label"></asp:Label>
        <asp:TextBox ID="txtFrom" runat="server"
                     CssClass="input-text"
                     TextMode="Date"></asp:TextBox>
        <br /><br />

        <!-- TO DATE -->
        <asp:Label ID="lblTo" runat="server"
                   Text="To date:"
                   CssClass="field-label"></asp:Label>
        <asp:TextBox ID="txtTo" runat="server"
                     CssClass="input-text"
                     TextMode="Date"></asp:TextBox>

        <!-- BUTTONS: Proceed first, Back second -->
        <div class="btn-row">
            <asp:Button ID="btnProceed" runat="server"
                        Text="Proceed (Generate Payroll)"
                        CssClass="btn btn-primary"
                        OnClick="btnProceed_Click" />

            <asp:Button ID="btnBack" runat="server"
                        Text="Back to HR Home"
                        CssClass="btn btn-red"
                        OnClick="btnBack_Click" />
        </div>

    </div>
</form>
</body>
</html>