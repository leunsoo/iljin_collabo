<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popauthority.aspx.cs" Inherits="iljin.popUp.popgroup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>iljin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <meta name="format-detection" content="telephone=no" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/jquery-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/jquery-ui.structure.min.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/jquery-ui.theme.min.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/sub.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/ibuild.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/main.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/popUp.css" />
    <script src="/webapp/js/jquery-1.11.1.min.js"></script>
    <script src="/webapp/js/skyblueUtil.js"></script>
    <script src="/webapp/js/jquery-ui.min.js"></script>
    <script src="/webapp/js/front.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>권한 추가</span>
            </div>
            <table class="ltable_1">
                <tbody>
                    <tr>
                        <th>권한명<span class="red vam">*</span></th>
                        <td class="tal">
                            <asp:TextBox ID="txt_authName" CssClass="w70p" runat="server" required></asp:TextBox>
                            <asp:Button ID="btn_overlap" CssClass="btn_black btn_80_30" runat="server" Text="중복확인" OnClick="btn_overlap_Click"></asp:Button>
                        </td>
                    </tr>
                    <tr>
                        <th>사용유무</th>
                        <td class="tal">
                            <asp:RadioButton ID="rd_use_y" runat="server" Text="Y" GroupName="1" />
                            <asp:RadioButton ID="rd_use_n" CssClass="ml40" runat="server" Text="N" GroupName="1" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="tac mt20">
                <button type="button" class="btn_150_40 btn_gray" onclick="self.close()">취소</button>
                <asp:Button ID="btn_save" CssClass="btn_150_40 btn_black ml5" runat="server" Text="저장" OnClick="btn_save_Click"></asp:Button>
                <asp:HiddenField ID="hidden_doubleChecked" runat="server" />
                <asp:HiddenField ID="hidden_authId" runat="server" />
            </div>
        </div>
    </form>
</body>
<script>
    function set_doubleChecked_false() {
        var dc = document.getElementById("<%=hidden_doubleChecked.ClientID%>");
        dc.value = '0';
    }
</script>
</html>


