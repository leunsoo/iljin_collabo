<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popPwChangeReg.aspx.cs" Inherits="iljin.popPwChangeReg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>iljin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <meta name="format-detection" content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/ibuild.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/login.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/popUp.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pw_wrap">
            <div class="pw_title">
                <span>비밀번호 변경</span>
            </div>
            <div class="pw_contents">
                <table class="ltable_1">
                    <tbody>
                        <tr>
                            <th>ID</th>
                            <td>
                                <asp:TextBox ID="txt_ID" runat="server" MaxLength="12" required></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th>현재 비밀번호</th>
                            <td>
                                <asp:TextBox ID="txt_Pass" runat="server" MaxLength="12" TextMode="Password" required></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th>변경 비밀번호</th>
                            <td>
                                <asp:TextBox ID="txt_NewPass" runat="server" MaxLength="12" TextMode="Password" required></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th>비밀번호 확인</th>
                            <td>
                                <asp:TextBox ID="txt_ConFirmPass" runat="server" MaxLength="12" TextMode="Password" required></asp:TextBox>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="pw_change_button">
                <asp:Button ID="btn_pw_change" CssClass="btn_change btn_150_40" runat="server" Text="변경"></asp:Button>
            </div>
        </div>
    </form>
</body>
</html>
