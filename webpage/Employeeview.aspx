<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employeeview.aspx.cs" Inherits="Team75.Employeeview" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>All Employee Profiles</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 30px 0;
        }

        /* Main white card */
        .container {
            background-color: #ffffff;
            padding: 30px;
            max-width: 1100px;
            width: 90%;
            margin: 0 auto; /* center horizontally */
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            box-sizing: border-box;
        }

        .page-title {
            text-align: center;
            font-size: 34px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        /* Cards arranged side-by-side */
        .cards-container {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
            justify-content: center;
            margin-bottom: 40px;
        }

        /* Each employee card */
        .employee-box {
            background: #ffffff;
            padding: 16px 18px;
            border-radius: 12px;
            border: 1px solid #e0e0e0;
            width: 330px;
            box-sizing: border-box;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
        }

        .field {
            margin-bottom: 8px;
            font-size: 14px;
        }

        .field-label {
            font-weight: bold;
        }

        /* Green Home button */
        .home-btn {
            padding: 14px 30px;
            font-size: 18px;
            font-weight: bold;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            color: white;
            cursor: pointer;
        }

        .home-btn:hover {
            background-color: #43a047;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div class="container">

            <div class="page-title">All Employee Profiles</div>

            <div class="cards-container">
                <asp:PlaceHolder ID="EmployeesContainer" runat="server"></asp:PlaceHolder>
            </div>

            <div style="text-align:center;">
                <asp:Button ID="btnHome" runat="server" Text="Home"
                            CssClass="home-btn" OnClick="btnHome_Click" />
            </div>

        </div>

    </form>
</body>
</html>
