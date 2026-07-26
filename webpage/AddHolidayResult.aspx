<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddHolidayResult.aspx.cs" Inherits="Team75.AddHolidayResult" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Holiday Table After Adding</title>

    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        /* Center page */
        .page-wrapper {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 20px;
        }

        /* White card */
        .container {
            background-color: #ffffff;
            padding: 30px 40px;
            width: 900px;
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.20);
        }

        h2 {
            text-align: center;
            font-size: 30px;
            margin-bottom: 20px;
        }

        .msg {
            font-weight: bold;
            margin-bottom: 15px;
            font-size: 16px;
            text-align: center;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        .grid th,
        .grid td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }

        .grid th {
            background-color: #eeeeee;
            font-weight: bold;
        }

        .buttons {
            margin-top: 25px;
            display: flex;
            justify-content: center;
            gap: 15px;
        }

        /* Green Home button */
        .btn-home {
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 180px;
        }

        .btn-home:hover {
            background-color: #43a047;
        }

        /* Grey Back-to-confirm button */
        .btn-back {
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #9e9e9e;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 220px;
        }

        .btn-back:hover {
            background-color: #757575;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">
            <div class="container">

                <h2>Holiday Table (After Adding)</h2>

                <asp:Label ID="lblMessage" runat="server" CssClass="msg"></asp:Label>

                <asp:GridView ID="GridViewHolidaysAfter" runat="server"
                              AutoGenerateColumns="True"
                              CssClass="grid">
                </asp:GridView>

                <div class="buttons">
                    <asp:Button ID="btnHome" runat="server"
                                Text="Home"
                                CssClass="btn-home"
                                OnClick="btnHome_Click" />

                    <asp:Button ID="btnBackToConfirm" runat="server"
                                Text="Back to Holiday Confirmation"
                                CssClass="btn-back"
                                OnClick="btnBackToConfirm_Click" />
                </div>

            </div>
        </div>
    </form>
</body>
</html>
