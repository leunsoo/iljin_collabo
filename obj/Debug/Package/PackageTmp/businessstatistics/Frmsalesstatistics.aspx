<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmsalesstatistics.aspx.cs" Inherits="iljin.Frmsalesstatics" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner">
     <h2 class="conts_tit"><asp:Label ID="m_title" runat="server" Text="경영통계 ::> 매출통계"></asp:Label></h2>
        <div class ="search_box">
            <div class ="box_row">
                <span>연도</span>
                <asp:DropDownList ID ="cb_year" runat="server" CssClass="mWt150"></asp:DropDownList>
                <span class="ml20">담당자</span>
                <asp:DropDownList ID ="cb_manager" runat="server" CssClass="mWt150"></asp:DropDownList>
                <asp:Button ID ="btn_search" runat="server" CssClass="btn_navy btn_100_30 ml20" Text="조회" OnClick="btn_search_Click" />
                <asp:Button ID="btn_excel" runat="server" CssClass="btn_100_30 btn_green ft_right" Text="엑셀 다운로드" OnClick="btn_excel_Click"></asp:Button>   
            </div>
        </div>
        <div class ="fixed_hs_650 mt10" style="width:1190px; overflow:hidden;" id="exceldiv" runat="server">
            <table class ="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt15p">월</th>
                        <th class="mWt25p">매출수량</th>
                        <th class="mWt30p">공급가액</th>
                        <th class="mWt30p">총매출액(부가세포함)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan ="5">
                             <div style=" max-height:600px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="25%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="30%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="30%" CssClass="" />
                                        </asp:TemplateColumn>                    
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                      <th class="mWt15p">합계</th>
                        <th class="mWt25p" id="txt_qty" runat="server"></th>
                        <th class="mWt30p" id="txt_price" runat="server"></th>
                        <th class="mWt30p" id="txt_total" runat="server"></th>
                    </tr>
                </tfoot>
            </table>
        </div>
        
    </article>
</asp:Content>
