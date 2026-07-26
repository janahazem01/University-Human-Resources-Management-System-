<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="verify_approveAnnualAccidental.aspx.cs"
    Inherits="Team75.verify_approveAnnualAccidental" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Approve / Reject Annual &amp; Accidental Leaves</title>

    <style type="text/css">
        body {
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            font-family: "Segoe UI", Arial, sans-serif;
            color: #333;
        }

        .page-wrapper {
            display: flex;
            justify-content: center;
            padding: 40px 12px;
        }

        .card {
            background-color: #ffffff;
            width: 800px;
            max-width: 100%;
            padding: 30px 40px;
            border-radius: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }

        .page-title {
            text-align: center;
            font-size: 1.5rem;
            margin-bottom: 20px;
            font-weight: 600;
        }

        .message-label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .message-label.error {
            color: #c0392b;
        }

        .field-row {
            margin-bottom: 16px;
        }

        .field-row label {
            display: block;
            margin-bottom: 4px;
            font-weight: 600;
        }

        .input-text {
            width: 100%;
            max-width: 300px;
            padding: 8px 10px;
            border-radius: 4px;
            border: 1px solid #ccc;
            font-size: 0.95rem;
            box-sizing: border-box;
        }

        .button-row {
            text-align: center;
            margin: 10px 0 25px 0;
        }

        .btn {
            padding: 8px 18px;
            border-radius: 4px;
            border: 1px solid transparent;
            font-size: 0.95rem;
            cursor: pointer;
            margin: 0 6px;
        }

        .btn-primary {
            background-color: #28a745; 
            border-color: #28a745;
            color: white;
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
            color: white;
        }

     
        .btn-red {
            background-color: #d9534f;
            color: #fff;
            border-color: #d43f3a;
        }

        .btn-red:hover {
            background-color: #c9302c;
        }

        .section-title {
            margin-top: 22px;
            margin-bottom: 8px;
            font-size: 1.05rem;
            font-weight: 600;
        }

        .gridview {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 14px;
            font-size: 0.9rem;
        }

        .gridview th {
            background-color: #eee;
            font-weight: 600;
            padding: 8px;
            border-bottom: 1px solid #ddd;
        }

        .gridview td {
            padding: 8px;
            border-bottom: 1px solid #eee;
        }

        .gridview tr:nth-child(even) td {
            background-color: #fafafa;
        }

        /* Center footer button */
        .footer-buttons {
            text-align: center;
            margin-top: 25px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">
            <div class="card">

                <h2 class="page-title">Approve / Reject Annual or Accidental Leaves</h2>

                <asp:Label ID="lblHRID" runat="server"
                    CssClass="message-label"
                    Font-Size="Large"></asp:Label>

                <asp:Label ID="lblError" runat="server"
                    CssClass="message-label error"></asp:Label>

                <div class="field-row">
                    <label for="txtRequestID">Enter Leave Request ID to approve/reject:</label>
                    <asp:TextBox ID="txtRequestID" runat="server"
                        CssClass="input-text"></asp:TextBox>
                </div>

               
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

                <h3 class="section-title">Leave Record (from Leave table)</h3>
                <asp:GridView ID="gridLeave" runat="server"
                    AutoGenerateColumns="true" CssClass="gridview" GridLines="None" />

                <h3 class="section-title">Annual Leave Details</h3>
                <asp:GridView ID="gridAnnual" runat="server"
                    AutoGenerateColumns="true" CssClass="gridview" GridLines="None" />

                <h3 class="section-title">Accidental Leave Details</h3>
                <asp:GridView ID="gridAccidental" runat="server"
                    AutoGenerateColumns="true" CssClass="gridview" GridLines="None" />

             
                <div class="footer-buttons">
                    <asp:Button ID="btnBackHome" runat="server"
                        Text="Go Back to HR Home"
                        CssClass="btn btn-red"
                        PostBackUrl="~/HR_Home.aspx" />
                </div>

            </div>
        </div>
    </form>
</body>
</html>