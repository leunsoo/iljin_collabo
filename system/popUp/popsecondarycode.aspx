<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popsecondarycode.aspx.cs" Inherits="iljin.popUp.popsecondarycode" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>iljin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <meta name="format-detection" content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/jquery-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/jquery-ui.structure.min.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/jquery-ui.theme.min.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/sub.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/ibuild.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/main.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/popUp.css"/>
    <script src="/webapp/js/jquery-1.11.1.min.js"></script>
    <script src="/webapp/js/skyblueUtil.js"></script>
    <script src="/webapp/js/jquery-ui.min.js"></script>
	<script src="/webapp/js/front.js"></script>
    </head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>2차코드 등록</span>
            </div>
            <table class="ltable_1">
                <tbody>
                    <tr>
                        <th>1차 코드</th>
                        <td>
                        <asp:TextBox ID="txt_prinarycode" runat="server"  ></asp:TextBox>     
                        </td>
                    </tr>
                    <tr>
                        <th>2차 코드명</th>
                        <td class="tal">
                            <asp:TextBox ID="txt_secondarycodename" CssClass="w70p" runat="server"></asp:TextBox>
                            <asp:Button ID="btn_overlap" CssClass="btn_black btn_80_30" runat="server" Text="중복확인"></asp:Button>
                        </td>
                    </tr>
                    <tr>
                        <th>순서</th>
                        <td>
                            <asp:TextBox ID="txt_order" runat="server"  ></asp:TextBox> 
                        </td>
                    </tr>
                    <tr>
                        <th>사용유무</th>
                        <td class="tal">
                            <asp:RadioButton ID="rd_use_y" runat="server" Text="Y" />
                            <asp:RadioButton ID="rd_use_n" CssClass="ml40" runat="server" Text="N" />
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="tac mt20">
            <button type="button" class="btn_150_40 btn_gray" onclick="self.close()">취소</button>
            <asp:Button ID="btn_save" CssClass="btn_150_40 btn_black ml5" runat="server" Text="저장"></asp:Button>
        </div>
        </div>
    </form>
</body>
</html>

