<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="verify_deductionUnpaid.aspx.cs"
    Inherits="Team75.verify_deductionUnpaid" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Deduction Due to Unpaid Leave</title>

    <style type="text/css">

        /* GLOBAL PAGE BACKGROUND */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f5f5f5; /* Light grey */
        }

        /* CENTER CONTAINER */
        .container {
            max-width: 1000px;
            margin: 40px auto;
            background: #ffffff;
            border-radius: 8px;
            padding: 30px 40px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }

        /* PAGE TITLE */
        .page-title {
            text-align: center;
            font-size: 26px;
            font-weight: bold;
            color: #333;
            margin-bottom: 25px;
        }

        /* SECTION LABELS */
        .field-label {
            margin-top: 15px;
            margin-bottom: 5px;
            font-weight: bold;
            font-size: 15px;
            color: #333;
        }

        .info-label {
            font-weight: bold;
            color: #cc0000;
            margin-bottom: 15px;
            display: block;
        }

        /* GRID STYLE */
        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            margin-bottom: 25px;
            font-size: 14px;
        }

        .grid th, .grid td {
            border: 1px solid #ddd;
            padding: 8px 10px;
            text-align: center;
        }

        .grid th {
            background-color: #eee;
            font-weight: bold;
            color: #333;
        }

        /* BUTTONS */
        .btn {
            border: none;
            border-radius: 4px;
            padding: 10px 24px;
            font-size: 15px;
            cursor: pointer;
            margin-right: 10px;
        }

        .btn-primary {
            background-color: #28a745; /* GREEN */
            color: #fff;
        }
        .btn-primary:hover {
            background-color: #218838;
        }

        .btn-danger {
            background-color: #dc3545; /* RED */
            color: #fff;
        }
        .btn-danger:hover {
            background-color: #c82333;
        }

    </style>
</head>
<body>

    <form id="form1" runat="server">

        <div class="container">

            <!-- PAGE TITLE -->
            <div class="page-title">Add Deduction Due to Unpaid Leave</div>

            <!-- HR ID -->
            <asp:Label ID="lblHRID" runat="server"
                       Font-Size="Large"
                       Font-Bold="true"></asp:Label>
            <br /><br />

            <!-- ERROR LABEL -->
            <asp:Label ID="lblError" runat="server"
                       CssClass="info-label"></asp:Label>

            <!-- EMPLOYEE INPUT -->
            <asp:Label ID="lblEmpPrompt" runat="server"
                       CssClass="field-label"
                       Text="Enter Employee ID:"></asp:Label>

            <asp:TextBox ID="txtEmpID" runat="server"
                         Width="250px"></asp:TextBox>

            <br /><br />

            <!-- BUTTONS -->
            <asp:Button ID="btnCheck" runat="server"
                        Text="Show Approved Unpaid Leaves (This Month)"
                        CssClass="btn btn-primary"
                        Width="340px"
                        OnClick="btnCheck_Click" />

            <asp:Button ID="btnProceed" runat="server"
                        Text="Proceed (Calculate Deductions)"
                        CssClass="btn btn-primary"
                        Width="260px"
                        OnClick="btnProceed_Click" />

            <asp:Button ID="btnBackHome" runat="server"
                        Text="Back to HR Home"
                        CssClass="btn btn-danger"
                        Width="160px"
                        OnClick="btnBackHome_Click" />

            <br /><br />

            <!-- GRID -->
            <asp:GridView ID="gridUnpaid" runat="server"
                          AutoGenerateColumns="true"
                          CssClass="grid"
                          Visible="false" />

        </div>

    </form>
</body>
</html>