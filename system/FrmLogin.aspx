<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="FrmLogin.aspx.cs" Inherits="iljin.FrmLogin" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner">
        <h2 class="conts_tit"><asp:Label ID="m_title" runat="server" Text="시스템관리 ::> 로그이력관리"></asp:Label></h2>
        <div class="search_box">
            <div class="box_row">
                <span>검색기간</span>
                <asp:TextBox ID="txt_sch_date1" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                ~
                <asp:TextBox ID="txt_sch_date2" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                <span class="ml20">이름</span>
                <asp:TextBox ID="txt_name" runat="server" CssClass="mWt200"></asp:TextBox>
                <span class="ml20">ID</span>
                <asp:TextBox ID="txt_id" runat="server" CssClass="mWt200"></asp:TextBox>
                <asp:Button ID="btn_sch" CssClass="btn_navy ml20 btn_80_30" runat="server" Text="조회" OnClick="btn_sch_Click"></asp:Button>
                <asp:Button ID="btn_refresh" CssClass="btn_red btn_80_30" runat="server" Text="초기화" OnClick="btn_refresh_Click"></asp:Button>
            </div>
        </div>
        <div class="fixed_hs_500 mt10">
            <table class="grtable_th">                
                <thead>
                    <tr>
                        <th class="mWt20p">날짜</th>
                        <th class="mWt20p">시간</th>
                        <th class="mWt20p">IP</th>
                        <th class="mWt20p">ID</th>
                        <th class="mWt20p">사용자</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="5">
                            <div style="overflow:auto;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False"  AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="20%" CssClass=""/>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="20%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="20%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="20%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="20%" CssClass=""/>
                                        </asp:TemplateColumn>
                                    </Columns>
                                    <SelectedItemStyle BackColor="#00CCFF"></SelectedItemStyle>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </article>

<script>
    fDatePickerById("ContentPlaceHolder2_txt_sch_date1");
    fDatePickerById("ContentPlaceHolder2_txt_sch_date2");

</script>
</asp:Content>
