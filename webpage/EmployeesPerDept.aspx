<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeesPerDept.aspx.cs" Inherits="Team75.EmployeesPerDept" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employees Per Department</title>

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
            max-width: 700px;
            width: 90%;
            margin: 0 auto; /* center horizontally */
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.2);
            box-sizing: border-box;
        }

        .page-title {
            text-align: center;
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 25px;
        }

        .row {
            margin-bottom: 18px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .label {
            font-weight: bold;
            min-width: 120px;
            text-align: right;
        }

        .input-control {
            padding: 8px 10px;
            font-size: 15px;
            min-width: 260px;
        }

        /* Green main button style (same as other pages) */
        .primary-btn {
            padding: 12px 24px;
            font-size: 17px;
            font-weight: bold;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            display: block;
            margin: 18px auto;
        }

        .primary-btn:hover {
            background-color: #43a047;
        }

        .result {
            margin-top: 20px;
            font-size: 18px;
            font-weight: normal;
            text-align: center;
        }

        /* Home button – same green style, just reusing class */
        .home-btn {
            padding: 12px 30px;
            font-size: 18px;
            font-weight: bold;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            display: block;
            margin: 28px auto 0 auto;
        }

        .home-btn:hover {
            background-color: #43a047;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div class="container">
            <div class="page-title">Employees Per Department</div>

            <!-- Department Dropdown -->
            <div class="row">
                <span class="label">Department:</span>
                <asp:DropDownList ID="ddlDepartments" runat="server" CssClass="input-control">
                </asp:DropDownList>
            </div>

            <!-- Show Result Button -->
            <asp:Button ID="btnShow" runat="server"
                        Text="Show Number of Employees"
                        CssClass="primary-btn"
                        OnClick="btnShow_Click" />

            <!-- RESULT TEXT -->
            <asp:Label ID="lblResult" runat="server" CssClass="result" />

            <!-- HOME BUTTON BELOW RESULT -->
            <asp:Button ID="btnHome" runat="server"
                        Text="Home"
                        CssClass="home-btn"
                        OnClick="btnHome_Click" />
        </div>

    </form>
</body>
</html>
