<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Role.aspx.cs" Inherits="Team75.Role" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Select Your Role</title>

    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        /* FULL CENTERING */
        .page-wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;   /* centers content vertically */
            width: 100vw;    /* centers content horizontally */
        }

        .role-container {
            background-color: white;
            padding: 40px 60px;
            border-radius: 15px;
            min-width: 550px;
            text-align: center;
            box-shadow: 0 0 25px rgba(0, 0, 0, 0.18);
        }

        .role-title {
            font-size: 42px;
            font-weight: bold;
            margin-bottom: 40px;
        }

        .role-buttons {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        .role-button {
            width: 100%;
            padding: 20px 20px;
            border: none;
            border-radius: 40px;
            font-size: 26px;
            font-weight: 500;
            color: white;
            background-color: #4CAF50;
            cursor: pointer;
            transition: 0.25s ease;
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }

        .role-button:hover {
            background-color: #43a047;
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">
        <div class="page-wrapper">
            <div class="role-container">
                <div class="role-title">Select Your Role</div>

                <div class="role-buttons">

                    <asp:Button ID="btnAdmin" runat="server" Text="Admin"
                        CssClass="role-button" OnClick="btnAdmin_Click" />

                    <asp:Button ID="btnAcademic" runat="server" Text="Academic Employee"
                        CssClass="role-button" OnClick="btnAcademic_Click" />

                    <asp:Button ID="btnHR" runat="server" Text="HR Employee"
                        CssClass="role-button" OnClick="btnHR_Click" />

                </div>
            </div>
        </div>
    </form>

</body>
</html>
