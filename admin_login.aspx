<%@ Page Language="C#" AutoEventWireup="true"
         CodeBehind="admin_login.aspx.cs"
         Inherits="Team75.admin_login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login</title>

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

        /* Full-page centering */
        .page-wrapper {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            width: 100vw;
        }

        /* White card */
        .login-container {
            background-color: #ffffff;
            padding: 40px 50px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.20);
            min-width: 480px;
            text-align: center;
        }

        .login-title {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .login-subtitle {
            font-size: 16px;
            margin-bottom: 30px;
            color: #555;
        }

        .field-row {
            margin-bottom: 18px;
            text-align: left;
        }

        .field-label {
            display: block;
            margin-bottom: 5px;
            font-size: 16px;
            font-weight: 600;
        }

        .field-input {
            width: 100%;
            padding: 10px 12px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 15px;
            box-sizing: border-box;
        }

        .buttons-row {
            margin-top: 25px;
            display: flex;
            justify-content: center;
            gap: 12px;
        }

        /* Blue login button */
        .btn-login {
            padding: 12px 20px;
            border-radius: 6px;
            border: none;
            font-size: 17px;
            font-weight: bold;
            color: white;
            background-color: #1976D2;
            cursor: pointer;
            width: 45%;
        }

        .btn-login:hover {
            background-color: #0f5cab;
        }

        /* Green back button */
        .btn-back {
            padding: 12px 20px;
            border-radius: 6px;
            border: none;
            font-size: 17px;
            font-weight: bold;
            color: white;
            background-color: #4CAF50;
            cursor: pointer;
            width: 45%;
        }

        .btn-back:hover {
            background-color: #43a047;
        }

        .error-label {
            margin-top: 15px;
            color: #d32f2f;
            font-size: 16px;
            font-weight: bold;
            display: block;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div class="page-wrapper">
            <div class="login-container">

                <div class="login-title">Admin Login</div>
                <div class="login-subtitle">Please enter your ID and password</div>

                <div class="field-row">
                    <span class="field-label">Employee ID:</span>
                    <asp:TextBox ID="txtID" runat="server" CssClass="field-input" />
                </div>

                <div class="field-row">
                    <span class="field-label">Password:</span>
                    <asp:TextBox ID="txtPassword" runat="server"
                                 TextMode="Password" CssClass="field-input" />
                </div>

                <asp:Label ID="Label_Error" runat="server" CssClass="error-label"></asp:Label>

                <div class="buttons-row">
                    <!-- OnClick name MUST match method in .cs below -->
                    <asp:Button ID="Button_Login" runat="server"
                                Text="Login"
                                CssClass="btn-login"
                                OnClick="Button_Login_Click" />

                    <asp:Button ID="Button_Back" runat="server"
                                Text="Back"
                                CssClass="btn-back"
                                OnClick="Button_Back_Click" />
                </div>

            </div>
        </div>
    </form>
</body>
</html>
