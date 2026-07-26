<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="verify_attendance.aspx.cs"
    Inherits="Team75.verify_attendance" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Verify Attendance Removal (Official Holidays)</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        /* Centered white card */
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

        .question {
            font-size: 18px;
            font-weight: bold;
            margin: 10px 0 20px 0;
            text-align: center;
        }

        .buttons {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 10px;
        }

        /* Green YES button */
        .btn-yes {
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 120px;
        }

        .btn-yes:hover {
            background-color: #43a047;
        }

        /* Red NO button */
        .btn-no {
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #D32F2F;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 120px;
        }

        .btn-no:hover {
            background-color: #b71c1c;
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

                <div class="question">
                    Are you sure you want to remove attendance records for all employees during official holidays?
                </div>

                <div class="buttons">
                    <asp:Button ID="btnYes" runat="server"
                                Text="Yes"
                                CssClass="btn-yes"
                                OnClick="btnYes_Click" />

                    <asp:Button ID="btnNo" runat="server"
                                Text="No"
                                CssClass="btn-no"
                                OnClick="btnNo_Click" />
                </div>

            </div>
        </div>
    </form>
</body>
</html>
