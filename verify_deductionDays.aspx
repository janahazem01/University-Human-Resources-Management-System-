<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="verify_deductionDays.aspx.cs"
    Inherits="Team75.verify_deductionDays" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Deduction Due to Missing Days</title>
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
            margin-bottom: 30px;
            font-size: 28px;
            color: #333333;
        }

        .section-label {
            font-weight: bold;
            margin-bottom: 5px;
            display: block;
        }

        .hr-id-label {
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 15px;
            display: block;
        }

        .textbox {
            width: 350px;
            padding: 8px 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 14px;
        }

        .btn-row {
            margin-top: 25px;
            margin-bottom: 25px;
        }

        .btn {
            display: inline-block;
            padding: 10px 26px;
            border-radius: 4px;
            border: none;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            margin-right: 12px;
        }

        .btn-large {
            font-size: 15px;
            padding: 12px 32px;
        }

        .btn-primary {
            background-color: #28a745; /* green */
            color: #ffffff;
        }

        .btn-primary:hover {
            background-color: #218838;
        }

        .btn-danger {
            background-color: #dc3545; /* red */
            color: #ffffff;
        }

        .btn-danger:hover {
            background-color: #c82333;
        }

        .error-label {
            color: #dc3545;
            font-weight: bold;
            display: block;
            margin-bottom: 10px;
        }

        .grid-container {
            margin-top: 20px;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">

            <h2>Add Deduction Due to Missing Days</h2>

            <!-- HR ID -->
            <asp:Label ID="lblHRID" runat="server"
                       CssClass="hr-id-label"></asp:Label>

            <!-- Error / info -->
            <asp:Label ID="lblError" runat="server"
                       CssClass="error-label"></asp:Label>

            <!-- Employee ID input -->
            <asp:Label ID="lblEmpPrompt" runat="server"
                       CssClass="section-label"
                       Text="Enter Employee ID:"></asp:Label>
            <asp:TextBox ID="txtEmpID" runat="server"
                         CssClass="textbox"></asp:TextBox>

            <!-- Buttons row -->
            <div class="btn-row">
                <asp:Button ID="btnCheck" runat="server"
                            Text="Show Attendance Records for This Month"
                            CssClass="btn btn-primary btn-large"
                            OnClick="btnCheck_Click" />

                <asp:Button ID="btnProceed" runat="server"
                            Text="Proceed (Calculate Deductions)"
                            CssClass="btn btn-primary btn-large"
                            OnClick="btnProceed_Click" />

                <asp:Button ID="btnBackHome" runat="server"
                            Text="Back to HR Home"
                            CssClass="btn btn-danger btn-large"
                            OnClick="btnBackHome_Click" />
            </div>

            <!-- Attendance Grid -->
            <div class="grid-container">
                <asp:GridView ID="gridAttendance" runat="server"
                              AutoGenerateColumns="true"
                              CssClass="gridview">
                </asp:GridView>
            </div>

        </div>
    </form>
</body>
</html>