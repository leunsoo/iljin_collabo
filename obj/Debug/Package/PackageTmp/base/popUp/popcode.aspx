<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popcode.aspx.cs" Inherits="iljin.popUp.popcode" %>

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
                <span>2차코드 관리</span>
                <asp:HiddenField ID="hdn_code" runat="server" />
                <asp:HiddenField ID="hdn_rowIdx" runat="server" />
            </div>
            <table class="itable_1">
                <tbody>
                    <tr>
                        <th>1차코드</th>
                        <td>
                            <asp:TextBox ID="tb_upperCode" ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>정렬순번<span class="red vam"> *</span></th>
                        <td>
                            <asp:TextBox ID="tb_orderIdx" runat="server" required></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>코드명<span class="red vam"> *</span></th>
                        <td>
                            <asp:TextBox ID="tb_code_name" runat="server" required></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>사용유무</th>
                        <td>
                            
                            <asp:RadioButton ID ="chk_use" runat="server" Text="사용" GroupName="chk"/>
                            <asp:RadioButton ID ="chk_non_use" CssClass ="ml20" runat="server" Text="미사용" GroupName="chk"/>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- itable_1 -->
            <div class="tac mt20">
                <asp:Button ID="btn_save" CssClass="btn_150_40 btn_black" runat="server" Text="저장" OnClick="btn_save_Click"></asp:Button>
                <button type="button" class="btn_150_40 btn_gray ml15" onclick="self.close()">닫기</button>
            </div>
        </div>
    </form>
</body>
</html>

