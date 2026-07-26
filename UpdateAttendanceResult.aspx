<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateAttendanceResult.aspx.cs" Inherits="Team75.UpdateAttendanceResult" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Attendance Update Result</title>

    <style>
        body { font-family: Arial; background-color: #f5f5f5; }

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
            margin-bottom: 25px;
            font-size: 28px;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .grid th, .grid td {
            border: 1px solid #ccc;
            padding: 8px;
        }

        .grid th {
            background: #eee;
            font-weight: bold;
        }

        .buttons {
            margin-top: 25px;
            text-align: center;
        }

        /* Green Home button */
        .btn-home {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 18px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 6px;
            width: 120px;
            margin-right: 10px;
        }
        .btn-home:hover {
            background-color: #45a049;
        }

        /* Gray Back button */
        .btn-back {
            background-color: #9e9e9e;
            color: white;
            border: none;
            padding: 10px 18px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 6px;
            width: 120px;
        }
        .btn-back:hover {
            background-color: #7d7d7d;
        }
    </style>

</head>

<body>
<form id="form1" runat="server">

    <div class="container">

        <h2>Updated Attendance Table</h2>

        <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
        <br /><br />

        <asp:GridView ID="GridViewUpdatedAttendance" runat="server"
                      AutoGenerateColumns="True"
                      CssClass="grid">
        </asp:GridView>

        <div class="buttons">
            <asp:Button ID="btnHome" runat="server" Text="Home"
                        CssClass="btn-home" OnClick="btnHome_Click" />

            <asp:Button ID="btnBack" runat="server" Text="Back"
                        CssClass="btn-back" OnClick="btnBack_Click" />
        </div>

    </div>

</form>
</body>
</html>
