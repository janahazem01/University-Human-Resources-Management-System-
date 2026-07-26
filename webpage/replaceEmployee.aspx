<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="replaceEmployee.aspx.cs"
    Inherits="Team75.replaceEmployee" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Replacement Records</title>

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
            font-size: 28px;
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

        .button-row {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-top: 10px;
        }

        /* Home (green) */
        .btn-home {
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 140px;
        }

        .btn-home:hover {
            background-color: #43a047;
        }

        /* Back to verify (grey/blue) */
        .btn-back {
            padding: 10px 24px;
            font-size: 16px;
            font-weight: bold;
            color: #ffffff;
            background-color: #78909C; /* grey-blue */
            border: none;
            border-radius: 10px;
            cursor: pointer;
            min-width: 180px;
        }

        .btn-back:hover {
            background-color: #607D8B;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">
            <div class="container">

                <h2>Employee_Replace_Employee Table (After Replacement)</h2>

                <asp:GridView ID="GridViewReplace" runat="server"
                              AutoGenerateColumns="true"
                              CssClass="grid">
                </asp:GridView>

                <div class="button-row">
                    <asp:Button ID="btnBackVerify" runat="server"
                                Text="Back to Verify"
                                CssClass="btn-back"
                                OnClick="btnBackVerify_Click" />

                    <asp:Button ID="btnBack" runat="server"
                                Text="Home"
                                CssClass="btn-home"
                                OnClick="btnBack_Click" />
                </div>

            </div>
        </div>
    </form>
</body>
</html>
