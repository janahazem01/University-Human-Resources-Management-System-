<%@ Page Language="C#" AutoEventWireup="true"
         CodeBehind="Payroll.aspx.cs"
         Inherits="Team75.Payroll" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Last Month Payroll</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .page-wrapper {
            display: flex;
            justify-content: center;
            padding: 40px 20px;
        }

        .container {
            background-color: #ffffff;
            padding: 30px 35px;
            width: 100%;
            max-width: 1100px;
            border-radius: 14px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 20px;
        }

        .msg {
            font-weight: bold;
            margin-bottom: 15px;
            text-align: center;
            font-size: 15px;
        }

        /* Wrapper to avoid page-level scrolling */
        .grid-wrapper {
            width: 100%;
            overflow-x: auto;
            margin-bottom: 25px;
        }

        .grid {
            border-collapse: collapse;
            width: auto;
            min-width: 100%;
            font-size: 14px;
        }

        .grid th,
        .grid td {
            border: 1px solid #ccc;
            padding: 6px 10px;
            text-align: center;
            white-space: nowrap;   /* keep cells on one line */
        }

        .grid th {
            background-color: #eeeeee;
            font-weight: bold;
        }

        .btn-home {
            display: block;
            margin: 0 auto;
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 160px;
        }

        .btn-home:hover {
            background-color: #43a047;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">
            <div class="container">
                <h2>Last Month Payroll</h2>

                <asp:Label ID="lblMessage" runat="server" CssClass="msg"></asp:Label>

                <div class="grid-wrapper">
                    <asp:GridView ID="GridViewPayroll" runat="server"
                                  AutoGenerateColumns="True"
                                  CssClass="grid">
                    </asp:GridView>
                </div>

                <asp:Button ID="btnBack" runat="server"
                            Text="Home"
                            CssClass="btn-home"
                            OnClick="btnBack_Click" />
            </div>
        </div>
    </form>
</body>
</html>
