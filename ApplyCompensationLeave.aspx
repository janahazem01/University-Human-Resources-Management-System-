<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ApplyCompensationLeave.aspx.cs"
    Inherits="Team75.ApplyCompensationLeave" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <title>Apply for Compensation Leave</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color:#f4f4f4;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width:900px;
            margin:30px auto;
            background:white;
            padding:30px;
            border-radius:10px;
            box-shadow:0 0 10px rgba(0,0,0,0.1);
        }

        h1 {
            font-size:36px;
            font-weight:bold;
            margin-bottom:20px;
        }

        label {
            display:block;
            margin-top:15px;
            font-size:18px;
            font-weight:bold;
        }

        input, textarea, .aspNetDisabled {
            width:100%;
            padding:10px;
            margin-top:5px;
            border:1px solid #ccc;
            border-radius:5px;
            font-size:16px;
        }

        /* BUTTONS: same green style, side‑by‑side */
        .button-row {
            display:flex;
            gap:20px;
            margin-top:20px;
        }

        .btn {
            background:#4CAF50;
            color:white;
            padding:14px 26px;
            border:none;
            border-radius:10px;
            cursor:pointer;
            font-size:18px;
            font-weight:bold;
            text-align:center;
            width:100%;
        }

        .btn:hover {
            background:#43a047;
        }

        /* Back button uses same green style */
        .back-btn {
            background:#4CAF50;
        }

        .back-btn:hover {
            background:#43a047;
        }

        .message {
            margin-top:20px;
            font-size:18px;
            font-weight:bold;
            color:red;
        }
    </style>
</head>
<body>
<form id="form1" runat="server">
    <div class="container">
        <h1>Apply for Compensation Leave</h1>

        <label>Your Employee ID:</label>
        <asp:Label ID="lblEmployeeID" runat="server" Font-Size="20px" Font-Bold="true" />

        <label>Compensation Date (the leave day):</label>
        <asp:TextBox ID="txtCompDate" runat="server" TextMode="Date" />

        <label>Original Workday Date (extra work day):</label>
        <asp:TextBox ID="txtOriginalDate" runat="server" TextMode="Date" />

        <label>Reason:</label>
        <asp:TextBox ID="txtReason" runat="server"
                     placeholder="e.g., Worked extra on exam day"
                     TextMode="MultiLine" Rows="3" />

        <div class="button-row">
            <asp:Button ID="btnSubmit" runat="server"
                        Text="Submit Compensation Leave"
                        CssClass="btn"
                        OnClick="btnSubmit_Click" />

            <asp:Button ID="btnHome" runat="server"
                        Text="Back to Academic Employee HomePage"
                        CssClass="btn back-btn"
                        OnClick="btnHome_Click" />
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="message" />
    </div>
</form>
</body>
</html>
