<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="verify_unattended.aspx.cs"
    Inherits="Team75.verify_unattended" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Verify Unattended Day-Off Removal</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        /* Centered card */
        .page-wrapper {
            display: flex;
            justify-content: center;
            padding: 40px 20px;
        }

        .container {
            background-color: #ffffff;
            padding: 35px 45px;
            width: 1000px;
            border-radius: 14px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            font-size: 30px;
            margin-bottom: 25px;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
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

        .prompt {
            font-size: 17px;
            margin-bottom: 10px;
            display: block;
        }

        .textbox {
            width: 220px;
            padding: 6px 8px;
            font-size: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        .controls {
            margin-top: 18px;
            display: flex;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }

        /* Proceed button (blue) */
        .btn-proceed {
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #1976D2;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 130px;
        }

        .btn-proceed:hover {
            background-color: #1565C0;
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

        .message {
            margin-top: 15px;
            font-size: 15px;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">
            <div class="container">

                <h2>Current Attendance Records</h2>

                <asp:GridView ID="GridViewAttendance" runat="server"
                              AutoGenerateColumns="true"
                              CssClass="grid">
                </asp:GridView>

                <asp:Label ID="lblPrompt" runat="server"
                           CssClass="prompt"
                           Text="Enter Employee ID to remove unattended day-off records for the current month:"
                           AssociatedControlID="txtEmpId"></asp:Label>

                <asp:TextBox ID="txtEmpId" runat="server"
                             CssClass="textbox"></asp:TextBox>

                <div class="controls">
                    <asp:Button ID="btnProceed" runat="server"
                                Text="Proceed"
                                CssClass="btn-proceed"
                                OnClick="btnProceed_Click" />

                    <asp:Button ID="btnBack" runat="server"
                                Text="Home"
                                CssClass="btn-home"
                                OnClick="btnBack_Click" />
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="message"></asp:Label>

            </div>
        </div>
    </form>
</body>
</html>
