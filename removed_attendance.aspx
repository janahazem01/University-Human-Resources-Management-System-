<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="removed_attendance.aspx.cs"
    Inherits="Team75.removed_attendance" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Attendance After Removing Holiday Records</title>

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
            margin-bottom: 30px;
        }

        .grid th, .grid td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: center;
        }

        .grid th {
            background-color: #eeeeee;
            font-weight: bold;
        }

        /* Green home button */
        .btn-home {
            display: block;
            margin: 0 auto;
            padding: 12px 26px;
            background-color: #4CAF50;
            color: white;
            border: none;
            font-size: 17px;
            font-weight: bold;
            cursor: pointer;
            border-radius: 10px;
            width: 220px;
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

            <h2>Attendance Records After Removing Official Holiday Entries</h2>

            <asp:GridView ID="GridViewAttendance" runat="server"
                          AutoGenerateColumns="true"
                          CssClass="grid">
            </asp:GridView>

            <asp:Button ID="btnBack" runat="server"
                        Text="Home"
                        CssClass="btn-home"
                        OnClick="btnBack_Click" />

        </div>
    </div>

</form>
</body>
</html>
