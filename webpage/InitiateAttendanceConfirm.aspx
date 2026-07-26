<%@ Page Language="C#" AutoEventWireup="true"
         CodeBehind="InitiateAttendanceConfirm.aspx.cs"
         Inherits="Team75.InitiateAttendanceConfirm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Initiate Attendance - Confirm</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .wrapper {
            max-width: 700px;
            margin: 60px auto;
            background: #ffffff;
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.15);
            text-align: center;
        }

        .page-title {
            font-size: 34px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        .info {
            margin-top: 10px;
            font-size: 18px;
            color: #444;
        }

        .question {
            font-size: 20px;
            font-weight: bold;
            margin: 30px 0 20px 0;
        }

        .button-row {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 25px;
        }

        .btn-green {
            background-color: #4CAF50;
            color: white;
            padding: 12px 26px;
            font-size: 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 160px;
        }

        .btn-green:hover {
            background-color: #45a049;
        }

        .btn-red {
            background-color: #d9534f;
            color: white;
            padding: 12px 26px;
            font-size: 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 160px;
        }

        .btn-red:hover {
            background-color: #c9302c;
        }
    </style>

</head>
<body>

<form id="form1" runat="server">

    <div class="wrapper">

        <div class="page-title">Initiate Attendance</div>

        <div class="info">
            Today is:
            <asp:Label ID="lblToday" runat="server"></asp:Label>
        </div>

        <div class="question">
            Are you sure you want to initiate the attendance for all employees today?
        </div>

        <div class="button-row">
            <asp:Button ID="btnYes" runat="server"
                        Text="Yes"
                        CssClass="btn-green"
                        OnClick="btnYes_Click" />

            <asp:Button ID="btnNo" runat="server"
                        Text="No"
                        CssClass="btn-red"
                        OnClick="btnNo_Click" />
        </div>

    </div>

</form>

</body>
</html>
