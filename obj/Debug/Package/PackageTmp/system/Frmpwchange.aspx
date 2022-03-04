<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmpwchange.aspx.cs" Inherits="iljin.system.Frmpwchange" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner">
        <h2 class="conts_tit">
            <asp:Label ID="m_title" runat="server" Text="시스템관리 ::> 암호변경"></asp:Label></h2>
        <table class="itable_1 mt10">
            <tbody>
                <tr>
                    <th class="mWt430">현재 암호</th>
                    <td>
                        <asp:TextBox ID="txt_currentpw" runat="server" TextMode="Password" MaxLength="30"></asp:TextBox>
                        <asp:HiddenField ID="hdn_userCode" runat="server" />
                    </td>

                </tr>
                <tr>
                    <th class="mWt430">변경 암호</th>
                    <td>
                        <asp:TextBox ID="txt_changepw" runat="server" TextMode="Password" MaxLength="30"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th class="mWt430">변경암호 확인</th>
                    <td>
                        <asp:TextBox ID="txt_changepwcheck" runat="server" TextMode="Password" MaxLength="30"></asp:TextBox>
                    </td>
            </tbody>
        </table>
        <div class="tac mt10">
            <asp:Button ID="btn_save" CssClass="btn_150_40 btn_gray ml5" runat="server" Text="변경" OnClientClick="return pswChk();" OnClick="btn_save_Click"></asp:Button>
        </div>
        <script>
            function pswChk() {
                var p = document.getElementById('<%= txt_currentpw.ClientID%>').value;
                var cp1 = document.getElementById('<%= txt_changepw.ClientID%>').value;
                var cp2 = document.getElementById('<%= txt_changepwcheck.ClientID%>').value;

                if (cp1.length < 8) {
                    alert('비밀번호는 최소 8글자 이상이여야 합니다.');
                    return false;
                }
                else if (cp1.includes(" ")) {
                    alert('비밀번호에 공란을 포함하실 수 없습니다.');
                    return false;
                }
                else if (cp1 != cp2) {
                    alert('비밀번호를 다시 확인해 주십시오.');
                    return false;
                }

                return true;
            }
        </script>
    </article>
</asp:Content>
