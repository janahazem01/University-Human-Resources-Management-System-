<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoveDeductionsResult.aspx.cs" Inherits="Team75.RemoveDeductionsResult" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Updated Deductions</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 40px 0;
        }

        /* Main centered card */
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

        .msg {
            font-size: 18px;
            font-weight: bold;
            color: #2e7d32;
            margin-bottom: 15px;
        }

        /* GRIDVIEW STYLE */
        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
            font-size: 15px;
        }

        .grid th {
            background-color: #e8e8e8;
            padding: 10px;
            border: 1px solid #ccc;
            font-weight: bold;
            text-align: left;
        }

        .grid td {
            padding: 10px;
            border: 1px solid #ccc;
        }

        .grid tr:nth-child(even) {
            background-color: #fafafa;
        }

        /* GREEN HOME BUTTON */
        .btn-home {
            padding: 14px 32px;
            font-size: 18px;
            font-weight: bold;
            background-color: #4CAF50;   /* green */
            border: none;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn-home:hover {
            background-color: #43a047;   /* darker green hover */
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div class="container">

            <h2>Updated Deduction Records</h2>

            <asp:Label ID="lblMessage" runat="server" CssClass="msg"></asp:Label>

            <asp:GridView ID="GridViewUpdatedDeductions" runat="server"
                AutoGenerateColumns="True"
                CssClass="grid">
            </asp:GridView>

            <div style="text-align:center;">
                <asp:Button ID="btnBackAdmin" runat="server"
                            Text="Home"
                            CssClass="btn-home"
                            OnClick="btnBackAdmin_Click" />
            </div>

        </div>

    </form>
</body>
</html>
