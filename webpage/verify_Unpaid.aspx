<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="verify_Unpaid.aspx.cs"
    Inherits="Team75.verify_Unpaid" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Approve / Reject Unpaid Leaves</title>

    <style type="text/css">

        /* PAGE BACKGROUND */
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, Helvetica, sans-serif;
            background-color: #f5f5f5;
        }

        /* CENTERED CONTAINER */
        .container {
            max-width: 1000px;
            margin: 40px auto;
            background: #ffffff;
            border-radius: 8px;
            padding: 30px 40px;
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

        .section-label {
            font-size: 20px;
            font-weight: bold;
            margin-top: 25px;
            margin-bottom: 10px;
            color: #333;
        }

        .info-label {
            font-weight: bold;
            color: #cc0000;
            display: block;
            margin-bottom: 15px;
        }

        /* GRID STYLING */
        .grid {
            width: 100%;
            border-collapse: collapse;
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
            color: #333;
            font-weight: bold;
        }

        /* BUTTONS */
        .btn {
            border: none;
            border-radius: 4px;
            padding: 10px 24px;
            font-size: 14px;
            cursor: pointer;
            margin-right: 12px;
        }

        .btn-primary {
            background-color: #28a745;
            color: #fff;
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

    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div class="container">

            <div class="page-title">Approve / Reject Unpaid Leaves</div>

            <!-- HR ID Label -->
            <asp:Label ID="lblHRID" runat="server"
                Text="Your HR ID is: (loading...)"
                Font-Size="Large"
                Font-Bold="true"></asp:Label>

            <br /><br />

            <!-- Error Label -->
            <asp:Label ID="lblError" runat="server"
                CssClass="info-label"></asp:Label>

            <!-- Request Input -->
            <asp:Label ID="Label1" runat="server"
                Text="Enter Leave Request ID to approve/reject:" />
            <br />
            <asp:TextBox ID="txtRequestID" runat="server"
                Width="250px"></asp:TextBox>

            <br /><br />

            <!-- ACTION BUTTONS -->
            <asp:Button ID="btnLoad" runat="server"
                Text="Load Leave Details"
                CssClass="btn btn-secondary"
                OnClick="btnLoad_Click" />

            <asp:Button ID="btnProceed" runat="server"
                Text="Proceed (Approve / Reject)"
                CssClass="btn btn-primary"
                OnClick="btnProceed_Click" />

            <br /><br />

            <!-- LEAVE GRID -->
            <div class="section-label">Leave Record (from Leave table)</div>
            <asp:GridView ID="gridLeave" runat="server"
                AutoGenerateColumns="true"
                CssClass="grid" />

            <!-- UNPAID GRID -->
            <div class="section-label">Unpaid Leave Details</div>
            <asp:GridView ID="gridUnpaid" runat="server"
                AutoGenerateColumns="true"
                CssClass="grid" />

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