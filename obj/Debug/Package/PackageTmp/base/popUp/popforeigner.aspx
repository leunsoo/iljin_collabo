<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popforeigner.aspx.cs" Inherits="iljin.popUp.popforeigner" %>

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
    <script type="text/javascript">
        function fileSearch1() {
            document.getElementById("fl_file1").click();
        }
        function fileSearch2() {
            document.getElementById("fl_file2").click();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>외국인 등록</span>
                <asp:HiddenField ID="hdn_idx" runat="server" />
                <asp:HiddenField ID="hdn_file1" runat="server" />
                <asp:HiddenField ID="hdn_file2" runat="server" />
            </div>
            <table class="itable_1">
                <tbody>
                    <tr>
                        <th>이름<span class="red vam"> *</span></th>
                        <td>
                            <asp:TextBox ID="tb_name" runat="server"></asp:TextBox>
                        </td>
                        <th>Full Name</th>
                        <td>
                            <asp:TextBox ID="tb_fullName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>생년월일</th>
                        <td>
                            <asp:TextBox ID="tb_birthDate" CssClass="w80p" runat="server"></asp:TextBox>
                        </td>
                        <th>등록번호</th>
                        <td>
                            <asp:TextBox ID="tb_registNo" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>입사일</th>
                        <td>
                            <asp:TextBox ID="tb_startDate" CssClass="w80p" runat="server"></asp:TextBox>
                        </td>
                        <th>국적</th>
                        <td>
                            <asp:TextBox ID="tb_country" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>보험가입1</th>
                        <td>
                            <asp:TextBox ID="tb_insurance1" runat="server"></asp:TextBox>
                        </td>
                        <th>보험가입2</th>
                        <td>
                            <asp:TextBox ID="tb_insurance2" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>비자만기일</th>
                        <td>
                            <asp:TextBox ID="tb_visaendDate" runat="server" CssClass="w80p"></asp:TextBox>
                        </td>
                        <th>연락처</th>
                        <td>
                            <asp:TextBox ID="tb_phoneNumber" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>통장사본</th>
                        <td class="tac">
                            <asp:Button ID="btn_copyBank" runat="server" CssClass="btn_black btn_100_30" Text="업로드" OnClientClick="fileSearch1(); return false;" />
                            <asp:FileUpload ID="fl_file1" runat="server" CssClass="hidden" />
                        </td>
                        <th>ID Card</th>
                        <td class="tac">
                            <asp:Button ID="btn_idCard" runat="server" CssClass="btn_black btn_100_30" Text="업로드" OnClientClick="fileSearch2(); return false;" />
                            <asp:FileUpload ID="fl_file2" runat="server" CssClass="hidden" />
                        </td>
                    </tr>
                    <tr>
                        <th class="auto-style1">메모</th>
                        <td colspan="3" class="auto-style1">
                            <asp:TextBox ID="tb_memo" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </tbody>
            </table>
            <div class="mt20">
                <asp:Button ID="btn_del" runat="server" CssClass="btn_150_40 btn_red" Text="삭제" OnClick="btn_del_Click" />
                <asp:Button ID="btn_close" runat="server" CssClass="btn_150_40 btn_gray ft_right" Text="닫기" OnClientClick="window.close();" />
                <asp:Button ID="btn_save" runat="server" CssClass="btn_150_40 btn_black ft_right mr10" Text="저장" OnClick="btn_save_Click" />
            </div>
        </div>
    </form>
</body>
</html>
<script>
    fDatePickerById("tb_birthDate");
    fDatePickerById("tb_startDate");
    fDatePickerById("tb_visaendDate");
</script>

