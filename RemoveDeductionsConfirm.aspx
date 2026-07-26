<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoveDeductionsConfirm.aspx.cs" Inherits="Team75.RemoveDeductionsConfirm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Current Deductions</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 40px 0;
        }

        /* Main centered white card */
        .container {
            background-color: #ffffff;
            padding: 30px;
            max-width: 1100px;
            width: 90%;
            margin: 0 auto;
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.20);
            box-sizing: border-box;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-size: 32px;
            font-weight: bold;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
            font-size: 15px;
        }

        .grid th {
            background-color: #e8e8e8;
            font-weight: bold;
            padding: 10px;
            border: 1px solid #ccc;
            text-align: left;
        }

        .grid td {
            padding: 10px;
            border: 1px solid #ccc;
        }

        .grid tr:nth-child(even) {
            background-color: #fafafa;
        }

        .question {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 18px;
            text-align: center;
        }

        .buttons-row {
            text-align: center;
            margin-top: 5px;
        }

        /* YES = green button (same style as other pages) */
        .btn-yes {
            padding: 12px 26px;
            font-size: 17px;
            font-weight: bold;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            margin: 0 10px;
        }

        .btn-yes:hover {
            background-color: #43a047;
        }

        /* NO = red button (same style as logout buttons) */
        .btn-no {
            padding: 12px 26px;
            font-size: 17px;
            font-weight: bold;
            background-color: #d32f2f;
            border: none;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            margin: 0 10px;
        }

        .btn-no:hover {
            background-color: #c62828;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">

            <h2>Current Deductions</h2>

            <asp:GridView ID="GridViewDeductions" runat="server"
                AutoGenerateColumns="True"
                CssClass="grid">
            </asp:GridView>

            <div class="question">
                Are you sure you want to remove the deductions for the resigned employees?
            </div>

            <div class="buttons-row">
                <asp:Button ID="btnYes" runat="server" Text="Yes"
                            CssClass="btn-yes" OnClick="btnYes_Click" />
                <asp:Button ID="btnNo" runat="server" Text="No"
                            CssClass="btn-no" OnClick="btnNo_Click" />
            </div>

        </div>
    </form>
</body>
</html>
