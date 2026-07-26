<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="approvedleaves.aspx.cs"
    Inherits="Team75.approvedleaves" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Attendance After Removing Approved Leaves</title>

    <style>
        body {
            font-family: Arial;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .container {
            width: 1000px;
            margin: 40px auto;
            background: #fff;
            padding: 25px;
            border-radius: 8px;
            border: 1px solid #ddd;
            box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
        }

        .grid th, .grid td {
            border: 1px solid #ccc;
            padding: 8px;
        }

        .grid th {
            background: #eee;
        }

        .button-bar {
            text-align: center;
            margin-top: 25px;
        }

        .btn-home {
            background-color: #4CAF50;
            color: white;
            font-size: 16px;
            padding: 10px 22px;
            margin: 0 10px;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-home:hover {
            background-color: #45a049;
        }

        .btn-back {
            background-color: #777; 
            color: white;
            font-size: 16px;
            padding: 10px 22px;
            margin: 0 10px;
            border-radius: 6px;
            cursor: pointer;
        }

        .btn-back:hover {
            background-color: #666;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">
    <div class="container">

        <h2>Attendance Records After Removing Approved Leaves</h2>

        <asp:GridView ID="GridViewAttendance" runat="server"
                      AutoGenerateColumns="true"
                      CssClass="grid">
        </asp:GridView>

        <div class="button-bar">
            <asp:Button ID="btnBackConfirm" runat="server"
                        Text="Back to Confirmation"
                        CssClass="btn-back"
                        OnClick="btnBackConfirm_Click" />

            <asp:Button ID="btnHome" runat="server"
                        Text="Home"
                        CssClass="btn-home"
                        OnClick="btnHome_Click" />
        </div>

    </div>
</form>
</body>
</html>
