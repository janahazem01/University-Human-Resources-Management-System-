<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="verify_empStatus.aspx.cs"
    Inherits="Team75.verify_empStatus" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Verify Employment Status Update</title>

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
            max-width: 1200px;
            border-radius: 14px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            font-size: 28px;
            margin-bottom: 25px;
        }

        /* wrapper to allow horizontal scroll if table is wider than card */
        .grid-wrapper {
            width: 100%;
            overflow-x: auto;
            margin-bottom: 25px;
        }

        .grid {
            border-collapse: collapse;
            width: auto;          /* let it be as wide as needed */
            min-width: 100%;      /* at least fill the card */
        }

        .grid th,
        .grid td {
            border: 1px solid #ccc;
            padding: 6px 10px;
            text-align: center;
            font-size: 13px;      /* a bit larger for readability */
            white-space: nowrap;  /* no word wrapping in cells */
        }

        .grid th {
            background-color: #eeeeee;
            font-weight: bold;
        }

        .prompt-row {
            margin-bottom: 8px;
            font-size: 16px;
        }

        .input-row {
            margin-bottom: 18px;
        }

        .input-row input[type="text"],
        .input-row asp\:TextBox {
            padding: 6px 8px;
            font-size: 14px;
            width: 220px;
        }

        .buttons-row {
            display: flex;
            justify-content: center;
            gap: 16px;
            flex-wrap: wrap;
            margin-bottom: 18px;
        }

        /* Proceed button (grey) */
        .btn-proceed {
            padding: 10px 22px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #9E9E9E;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 120px;
        }

        .btn-proceed:hover {
            background-color: #757575;
        }

        /* Home button (green) */
        .btn-home {
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 130px;
        }

        .btn-home:hover {
            background-color: #43a047;
        }

        .message-row {
            text-align: center;
            margin-top: 8px;
            font-size: 14px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">
            <div class="container">

                <h2>Employee Table (Before Update)</h2>

                <div class="grid-wrapper">
                    <asp:GridView ID="GridViewEmployees" runat="server"
                                  AutoGenerateColumns="true"
                                  CssClass="grid">
                    </asp:GridView>
                </div>

                <div class="prompt-row">
                    <asp:Label ID="lblPrompt" runat="server"
                               Text="Enter Employee ID to update employment status:"
                               AssociatedControlID="txtEmpId"></asp:Label>
                </div>

                <div class="input-row">
                    <asp:TextBox ID="txtEmpId" runat="server"></asp:TextBox>
                </div>

                <div class="buttons-row">
                    <asp:Button ID="btnProceed" runat="server"
                                Text="Proceed"
                                CssClass="btn-proceed"
                                OnClick="btnProceed_Click" />

                    <asp:Button ID="btnBack" runat="server"
                                Text="Home"
                                CssClass="btn-home"
                                OnClick="btnBack_Click" />
                </div>

                <div class="message-row">
                    <asp:Label ID="lblMessage" runat="server"></asp:Label>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
