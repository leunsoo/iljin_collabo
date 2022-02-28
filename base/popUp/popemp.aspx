<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popemp.aspx.cs" Inherits="iljin.popUp.popemp" %>

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
    <script type="text/javascript">
        function overlapReset() {
            var overlap = document.getElementById('<%=hdn_overlapChk.ClientID%>').value;

<%--            if (overlap = 1) {
                document.getElementById('<%=hdn_overlapChk.ClientID%>').value = 0;
                document.forms[0].tb_empName.removeAttribute('required');
                document.forms[0].tb_password.removeAttribute('required');
                document.forms[0].tb_id.removeAttribute('required');
            }--%>
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btn_save">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>사원 등록</span>
                <asp:HiddenField ID="hdn_code" runat="server" />
                <asp:HiddenField ID="hdn_overlapChk" runat="server" />
            </div>
            <table class="itable_1">
                <tbody>
                    <tr>
                        <th>사용자코드</th>
                        <td>
                            <asp:TextBox ID="tb_userCode" ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                        <th>이름<span class="red vam"> *</span></th>
                        <td>
                            <asp:TextBox ID="tb_empName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>ID<span class="red vam"> *</span></th>
                        <td>
                            <asp:TextBox ID="tb_id" CssClass="w60p" runat="server"></asp:TextBox>
                            <asp:Button ID="btn_overlap" CssClass="btn_black btn_80_30 ml10" runat="server" Text="중복확인" OnClick="btn_overlap_Click"></asp:Button>
                        </td>
                        <th>비밀번호<span class="red vam"> *</span></th>
                        <td>
                            <asp:TextBox ID="tb_password" runat="server" TextMode="Password" MaxLength="30"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>E-Mail</th>
                        <td>
                            <asp:TextBox ID="tb_email" runat="server"></asp:TextBox>
                        </td>
                        <th>메뉴권한<span class="red vam"> *</span></th>
                        <td>
                            <asp:DropDownList ID="cb_authority" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <th>소속</th>
                        <td>
                            <asp:DropDownList ID="cb_depart" runat="server"></asp:DropDownList>
                        </td>
                        <th>직책</th>
                        <td>
                            <asp:DropDownList ID="cb_class" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <th>전화</th>
                        <td>
                            <asp:TextBox ID="tb_tel" runat="server"></asp:TextBox>
                        </td>
                        <th>휴대폰</th>
                        <td>
                            <asp:TextBox ID="tb_phone" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>사원코드</th>
                        <td>
                            <asp:TextBox ID="tb_empCode" runat="server"></asp:TextBox>
                        </td>
                        <th>내선코드</th>
                        <td>
                            <asp:TextBox ID="tb_innerCode" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>메모</th>
                        <td colspan="3">
                            <asp:TextBox ID="tb_memo" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- itable_1 -->
            <div class="mt20">
                <asp:Button ID="btn_delete" CssClass="btn_150_40 btn_red" runat="server" Text="삭제" OnClick="btn_delete_Click"></asp:Button>
                <button type="button" class="btn_150_40 btn_gray ft_right ml15" onclick="self.close()">닫기</button>
                <asp:Button ID="btn_save" CssClass="btn_150_40 btn_black  ft_right" runat="server" Text="저장" OnClick="btn_save_Click"></asp:Button>
            </div>
        </div>
    </form>
</body>
</html>

