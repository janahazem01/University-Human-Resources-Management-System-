<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RejectedMedicalLeaves.aspx.cs" Inherits="Team75.RejectedMedicalLeaves" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Rejected Medical Leaves</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 40px 0;
        }

        /* Main centered card */
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
            margin-bottom: 30px;
            font-size: 32px;
            font-weight: bold;
        }

        /* Grid Styling */
        .grid {
            width: 100%;
            border-collapse: collapse;
            font-size: 16px;
        }

        .grid th {
            background-color: #e8e8e8;
            padding: 12px;
            border: 1px solid #ccc;
            text-align: left;
            font-weight: bold;
        }

        .grid td {
            padding: 12px;
            border: 1px solid #ccc;
        }

        .grid tr:nth-child(even) {
            background-color: #fafafa;
        }

        .green-check {
            color: #4CAF50;
            font-size: 22px;
            font-weight: bold;
        }

        .empty-box {
            color: #999;
            font-size: 22px;
        }

        /* Home Button (same green style) */
        .home-btn {
            padding: 14px 32px;
            font-size: 18px;
            font-weight: bold;
            background-color: #4CAF50;
            border: none;
            border-radius: 10px;
            color: white;
            cursor: pointer;
            display: block;
            margin: 35px auto 0 auto;
        }

        .home-btn:hover {
            background-color: #43a047;
        }
    </style>
</head>

<body>
    <form id="form1" runat="server">

        <div class="container">

            <h2>Rejected Medical Leaves</h2>

            <asp:GridView ID="GridViewRejectedMedicals" runat="server"
                AutoGenerateColumns="False"
                CssClass="grid">

                <Columns>

                    <asp:BoundField DataField="request_ID" HeaderText="Request ID" />

                    <asp:TemplateField HeaderText="Insurance Status">
                        <ItemTemplate>
                            <asp:Label ID="lblInsurance" runat="server"
                                Text='<%# Convert.ToBoolean(Eval("insurance_status")) ? "✓" : "□" %>'
                                CssClass='<%# Convert.ToBoolean(Eval("insurance_status")) ? "green-check" : "empty-box" %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <asp:BoundField DataField="disability_details" HeaderText="Disability Details" />
                    <asp:BoundField DataField="type" HeaderText="Type" />
                    <asp:BoundField DataField="Emp_ID" HeaderText="Employee ID" />

                </Columns>

            </asp:GridView>

            <!-- HOME BUTTON -->
            <asp:Button ID="btnBack" runat="server"
                        Text="Home"
                        CssClass="home-btn"
                        OnClick="btnBack_Click" />

        </div>

    </form>
</body>
</html>
