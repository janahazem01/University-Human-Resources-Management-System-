<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="verify_deductionHours.aspx.cs"
    Inherits="Team75.verify_deductionHours" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add Deduction Due to Missing Hours</title>

    <style type="text/css">
        body {
            margin: 0;
            padding: 40px 0;
            font-family: "Segoe UI", Tahoma, Arial, sans-serif;
            background-color: #f5f5f5;
        }

        .page-container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 35px 45px;
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

        .info-label {
            display: block;
            font-weight: 600;
            color: #333;
            font-size: 17px;
            margin-bottom: 20px;
        }

        .error-label {
            color: #d9534f;
            font-weight: 600;
            font-size: 16px;
            display: block;
            margin-bottom: 15px;
        }

        .input-label {
            font-size: 17px;
            font-weight: 600;
            color: #333;
            display: block;
            margin-bottom: 6px;
        }

        .textbox {
            width: 260px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 6px;
            font-size: 15px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            min-width: 160px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            font-weight: 600;
            margin: 6px;
        }

        .btn-primary {
            background-color: #28a745;
            color: white;
        }
        .btn-primary:hover {
            background-color: #218838;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .btn-danger {
            background-color: #d9534f;
            color: white;
        }
        .btn-danger:hover {
            background-color: #c9302c;
        }

        .section-title {
            font-size: 20px;
            font-weight: 600;
            margin: 25px 0 12px;
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

            <!-- PAGE TITLE -->
            <h1 class="page-title">Add Deduction Due to Missing Hours</h1>

            <!-- HR ID -->
            <asp:Label ID="lblHRID" runat="server" CssClass="info-label"
                Text="Your HR ID is: (loading...)"></asp:Label>

            <!-- ERRORS -->
            <asp:Label ID="lblError" runat="server" CssClass="error-label"></asp:Label>

            <!-- Employee ID input -->
            <asp:Label ID="Label1" runat="server" CssClass="input-label"
                Text="Enter Employee ID:"></asp:Label>

            <asp:TextBox ID="txtEmpID" runat="server"
                CssClass="textbox"></asp:TextBox>

            <br /><br />

            <!-- Buttons -->
            <asp:Button ID="btnCheck" runat="server"
                Text="Show Attendance Records for This Month"
                CssClass="btn btn-primary"
                OnClick="btnCheck_Click" />

            <asp:Button ID="btnBackHome" runat="server"
                Text="Back to HR Home"
                CssClass="btn btn-danger"
                OnClick="btnBackHome_Click" />

            <br />

            <asp:Button ID="btnProceed" runat="server"
                Text="Proceed (Calculate Deduction)"
                CssClass="btn btn-primary"
                Visible="false"
                OnClick="btnProceed_Click" />

            <br /><br />

            <!-- Attendance Grid -->
            <h3 class="section-title">Attendance Records for This Month</h3>

            <asp:GridView ID="gridAttendance" runat="server"
                AutoGenerateColumns="true"
                CssClass="data-grid"
                Visible="false">
            </asp:GridView>

        </div>

    </form>
</body>
</html>