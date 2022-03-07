<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="iljin.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>iljin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <meta name="format-detection" content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/ibuild.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/login.css"/>
    <style>
        .login_notice {
            font-size:30px;
        }
    </style>
</head>
<script type="text/javascript">
    function pw_change() {
        var url = "/system/popUp/popPwChangeReg.aspx";
        var name = "_blank"
        var popupX = (window.screen.width / 2) - (450 / 2);
        var popupY = (window.screen.height / 2) - (360 / 2);
        window.open(url, name, 'status=no, width=450, height=360, left=' + popupX + ',top=' + popupY);
    }
    function client_join() {
        var url = "/system/popUp/popcustomer.aspx";
        var name = "_blank"
        var popupX = (window.screen.width / 2) - (880 / 2);
        var popupY = (window.screen.height / 2) - (630 / 2);
        window.open(url, name, 'status=no, width=880, height=630, left=' + popupX + ',top=' + popupY);
    }
</script>
<body onload="window.moveTo(0,0); window.resizeTo(screen.availWidth,screen.availHeight);">
    <form id="Form1" method="post" runat="server">
    <div class="login_wrap">
    <div style="text-align:center;">
        <asp:Label ID="lb_notice" runat="server" Text="?????" CssClass="login_notice box_row"></asp:Label>
    </div>
        <div class="box">
            <div class="logo_name">
                <span class="logo_txt">일진 WMS</span>
            </div>
            <div class="id_pw">
                <%--<asp:TextBox ID="txt_com" runat="server"></asp:TextBox>--%>
                <asp:TextBox ID="txt_ID" runat="server" MaxLength="12" placeholder="ID" required></asp:TextBox>
                <asp:TextBox ID="txt_Pass" runat="server" MaxLength="12" TextMode="Password" placeholder="PASSWORD" required></asp:TextBox>
            </div>
        
            <div class="login_button">
                <asp:Button ID="btn_login" CssClass="set_bg" runat="server" Text="LOGIN" OnClick="btn_login_Click" />
                <div class="dpflex_jcsb">
                    <asp:CheckBox class="pw_change" ID="chk_rememberInfo" runat="server" Text="ID/PW 기억하기" />
           <%--         <div class="pw_change" onclick="pw_change()">비밀번호 변경</div>--%>
                   <%-- <div class="client_join" onclick="client_join()">거래처 가입신청</div>--%>
                </div>
            </div>
        </div>
    </div>
 </form>
</body>
</html>
