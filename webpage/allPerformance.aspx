<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="allPerformance.aspx.cs"
    Inherits="Team75.allPerformance" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Winter Semester Performance</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .wrapper {
            max-width: 1000px;
            margin: 40px auto;
            background: #ffffff;
            padding: 35px 45px;
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

        .btn-home {
            display: block;
            margin: 0 auto;
            padding: 12px 26px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            background-color: #4CAF50;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            width: 200px;
        }

        .btn-home:hover {
            background-color: #45a049;
        }
    </style>

</head>

<body>
<form id="form1" runat="server">

    <div class="wrapper">

        <h2>Performance Details for All Winter Semesters</h2>

        <asp:GridView ID="GridViewPerformance" runat="server"
                      AutoGenerateColumns="true"
                      CssClass="grid">
        </asp:GridView>

        <asp:Button ID="btnBack"
                    runat="server"
                    Text="Home"
                    CssClass="btn-home"
                    OnClick="btnBack_Click" />

    </div>

</form>
</body>
</html>
