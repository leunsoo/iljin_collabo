<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmnotice.aspx.cs" Inherits="iljin.system.Frmnotice" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner">
        <h2 class="conts_tit">
            <asp:Label ID="m_title" runat="server" Text="시스템관리 ::> 공지등록"></asp:Label></h2>
        <table class="itable_1 mt10">
            <tbody>
                <tr>
                    <th class="mWt100 tac">공지</th>
                    <td>
                        <asp:TextBox ID="txt_notice" runat="server"></asp:TextBox>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="tac mt10">
            <asp:Button ID="btn_save" CssClass="btn_150_40 btn_black ml5" runat="server" Text="등록" OnClick="btn_save_Click"></asp:Button>
        </div>
    </article>
</asp:Content>
