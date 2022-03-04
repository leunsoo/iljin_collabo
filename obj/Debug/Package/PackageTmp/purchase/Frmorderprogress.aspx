<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmorderprogress.aspx.cs" Inherits="iljin.Frmorderprogress" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class ="conts_inner">
        <h2 class="conts_tit"><asp:Label ID="m_title" runat="server" Text="매입관리 ::> 발주진척현황"></asp:Label></h2>
        <div class ="search_box">
            <div class ="box_row">
                <span>등록일</span>
                <asp:TextBox ID="tb_registrationdate" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                ~
                <asp:TextBox ID="tb_registrationdate2" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                <asp:Button ID ="btn_search" runat="server" CssClass="btn_navy btn_100_30 ml20" Text="조회" OnClick="btn_search_Click" />
            </div>
        </div>
        <div class ="fixed_hs_650 mt10" style="width: 1190px; overflow:hidden;">
            <table class ="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt5p">NO.</th>
                        <th class="mWt10p">거래처</th>
                        <th class="mWt10p">계약번호</th>
                        <th class="mWt10p">제목</th>
                        <th class="mWt20p">BL번호</th>
                        <th class="mWt5p">수량</th>
                        <th class="mWt10p">계약일</th>
                        <th class="mWt10p">출발예정</th>
                        <th class="mWt10p">입항예정</th>
                        <th class="mWt10p">입고예정</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan ="10">
                            <div style=" height:600px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;"> 
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="20%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </article>
         <script>
        fDatePickerById("ContentPlaceHolder2_tb_registrationdate");
        fDatePickerById("ContentPlaceHolder2_tb_registrationdate2");
         </script>
</asp:Content>
