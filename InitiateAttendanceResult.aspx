<%@ Page Language="C#" AutoEventWireup="true"
         CodeBehind="InitiateAttendanceResult.aspx.cs"
         Inherits="Team75.InitiateAttendanceResult" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Attendance After Initiate</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        /* Center container */
        .page-wrapper {
            display: flex;
            justify-content: center;
            margin-top: 40px;
            padding: 20px;
        }

        /* White card */
        .container {
            background-color: #ffffff;
            padding: 30px 40px;
            width: 1000px;
            border-radius: 14px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.15);
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

        .btn-home {
            display: block;
            margin: 28px auto 10px auto;
            padding: 12px 26px;
            font-size: 18px;
            font-weight: bold;
            color: #ffffff;
            background-color: #4CAF50;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 220px;
            text-align: center;
        }

        .btn-home:hover {
            background-color: #45a049;
        }
    </style>
</head>

<body>

    <form id="form1" runat="server">
        <div class="page-wrapper">

            <div class="container">

                <h2>Attendance Table (After Initiating)</h2>

                <asp:Label ID="lblMessage" runat="server" CssClass="msg"></asp:Label>

                <asp:GridView ID="GridViewAttendance" runat="server"
                              AutoGenerateColumns="True"
                              CssClass="grid">
                </asp:GridView>

                <asp:Button ID="btnHome" runat="server"
                            Text="Home"
                            CssClass="btn-home"
                            OnClick="btnHome_Click" />

            </div>

        </div>
    </form>

</body>
</html>
