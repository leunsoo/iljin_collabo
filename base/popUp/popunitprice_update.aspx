<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popunitprice_update.aspx.cs" Inherits="iljin.popUp.popunitprice_update" %>

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
    <style type="text/css">
        .auto-style1 {
            height: 28px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>단가등록</span>
                <asp:HiddenField ID="hdn_itemCode" runat="server" />
                <asp:HiddenField ID="hdn_empCode" runat="server" />
            </div>
            <table class="itable_1 mt10">
                <tbody>
                    <tr>
                        <th>제품명</th>
                        <td>
                            <asp:TextBox ID="tb_itemName" ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>변경판매단가<span class="red vam"> *</span></th>
                        <td>
                            <asp:TextBox ID="tb_changeUnitprice" runat="server" required></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>적용일<span class="red vam"> *</span></th>
                        <td>
                            <asp:TextBox ID="tb_adjustDate" runat="server" CssClass="w80p" autocomplete="off" required></asp:TextBox>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br />
            <div class="tac">
                <asp:Button ID="btn_save" runat="server" CssClass="btn_150_40 btn_black" Text="저장" OnClick="btn_save_Click" />
                <asp:Button ID="btn_close" runat="server" CssClass="btn_150_40 btn_gray ml15" OnClientClick="window.close();" Text="닫기" />
            </div>
        </div>
        <script>fDatePickerById('tb_adjustDate');</script>
    </form>
</body>
</html>

