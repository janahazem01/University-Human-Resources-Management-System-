<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdateAttendanceConfirm.aspx.cs" Inherits="Team75.UpdateAttendanceConfirm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Update Attendance - Confirm</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 40px 0;
        }

        /* Main centered white card */
        .container {
            background-color: #ffffff;
            padding: 30px;
            max-width: 1100px;
            width: 90%;
            margin: 0 auto;
            border-radius: 20px;
            box-shadow: 0 0 20px rgba(0,0,0,0.20);
            box-sizing: border-box;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            font-size: 32px;
            font-weight: bold;
        }

        /* Grid styling */
        .grid {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
            font-size: 15px;
        }

        .grid th,
        .grid td {
            border: 1px solid #ccc;
            padding: 8px 10px;
        }

        .grid th {
            background-color: #e8e8e8;
            font-weight: bold;
            text-align: left;
        }

        .grid tr:nth-child(even) {
            background-color: #fafafa;
        }

        /* Input rows */
        .row-input {
            margin-top: 12px;
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .label {
            font-size: 16px;
            font-weight: bold;
            min-width: 130px;
        }

        .textbox {
            font-size: 16px;
            padding: 6px 8px;
            width: 180px;
        }

        .hint {
            font-size: 12px;
            color: #666;
        }

        .question {
            font-size: 18px;
            font-weight: bold;
            margin-top: 24px;
            text-align: center;
        }

        .buttons {
            text-align: center;
            margin-top: 20px;
        }

        /* YES = green button */
        .btn-yes {
            padding: 12px 26px;
            font-size: 17px;
            font-weight: bold;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            margin: 0 10px;
        }

        .btn-yes:hover {
            background-color: #43a047;
        }

        /* NO = red button */
        .btn-no {
            padding: 12px 26px;
            font-size: 17px;
            font-weight: bold;
            background-color: #d32f2f;
            border: none;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            margin: 0 10px;
        }

        .btn-no:hover {
            background-color: #b71c1c;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">

        <div class="container">

            <h2>Attendance Table (Before Update)</h2>

            <asp:GridView ID="GridViewAttendance" runat="server"
                          AutoGenerateColumns="True"
                          CssClass="grid">
            </asp:GridView>

            <div class="row-input">
                <span class="label">Employee ID:</span>
                <asp:TextBox ID="txtEmployeeID" runat="server" CssClass="textbox"></asp:TextBox>
            </div>

            <div class="row-input">
                <span class="label">Check-in Time:</span>
                <asp:TextBox ID="txtCheckIn" runat="server" CssClass="textbox" Placeholder="HH:MM"></asp:TextBox>
                <span class="hint">(leave empty if absent)</span>
            </div>

            <div class="row-input">
                <span class="label">Check-out Time:</span>
                <asp:TextBox ID="txtCheckOut" runat="server" CssClass="textbox" Placeholder="HH:MM"></asp:TextBox>
                <span class="hint">(leave empty if absent)</span>
            </div>

            <div class="question">
                Are you sure you want to update the attendance records?
            </div>

            <div class="buttons">
                <asp:Button ID="btnYes" runat="server" Text="Yes"
                            CssClass="btn-yes" OnClick="btnYes_Click" />
                <asp:Button ID="btnNo" runat="server" Text="No"
                            CssClass="btn-no" OnClick="btnNo_Click" />
            </div>

        </div>

    </form>
</body>
</html>
