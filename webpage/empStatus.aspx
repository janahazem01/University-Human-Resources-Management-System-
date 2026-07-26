<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="empStatus.aspx.cs"
    Inherits="Team75.empStatus" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Status After Update</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .wrapper {
            max-width: 1100px;
            margin: 40px auto;
            background: white;
            border-radius: 10px;
            padding: 25px 35px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 30px;
        }

        .grid th {
            background: #eee;
            padding: 10px;
            border: 1px solid #ccc;
        }

        .grid td {
            padding: 8px;
            border: 1px solid #ccc;
        }

        .question {
            text-align: center;
            font-size: 20px;
            font-weight: bold;
            margin: 25px 0 15px 0;
        }

        /* BUTTON STYLES */
        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 8px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            color: white;
            margin: 0 10px;
        }

        .btn-yes {
            background-color: #4CAF50; /* Green */
        }

        .btn-no {
            background-color: #d9534f; /* Red */
        }

        .button-row {
            text-align: center;
            margin-bottom: 20px;
        }

    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="wrapper">

            <h2>Employee Table (After Status Update)</h2>

            <asp:GridView ID="GridViewEmployees" runat="server"
                AutoGenerateColumns="true"
                CssClass="grid">
            </asp:GridView>

            <div class="question">Do you want to update another employee's status?</div>

            <div class="button-row">
                <asp:Button ID="btnYes" runat="server"
                    Text="Yes"
                    CssClass="btn btn-yes"
                    OnClick="btnYes_Click" />

                <asp:Button ID="btnNo" runat="server"
                    Text="No"
                    CssClass="btn btn-no"
                    OnClick="btnNo_Click" />
            </div>

        </div>

    </form>
</body>
</html>
