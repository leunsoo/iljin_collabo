<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmsales.aspx.cs" Inherits="iljin.Menu.sales.Frmsales" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        table.ui-datepicker-calendar {
            display: none;
        }

        .ui-datepicker .ui-datepicker-buttonpane button {
            padding: 0em 0.6em 0em 0.6em;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner">
        <h2 class="conts_tit">
            <asp:Label ID="m_title" runat="server" Text="매출관리 ::> 매출관리"></asp:Label></h2>
        <div class="search_box">
            <div class="box_row">
                <span>납기년월</span>
                <asp:TextBox ID="txt_deliveryDate" runat="server" CssClass="mWt100"></asp:TextBox>
                &nbsp~&nbsp
                <asp:TextBox ID="txt_deliveryDate2" runat="server" CssClass="mWt100"></asp:TextBox>

                <span class="ml20">담당자</span>
                <asp:DropDownList ID="cb_manager" runat="server" CssClass="mWt150"></asp:DropDownList>
                <asp:Button ID="btn_search" runat="server" CssClass="btn_navy btn_100_30 ml20" Text="조회" OnClick="btn_search_Click" />
            </div>
        </div>

        <div class="fixed_hs_700 mt10" style="width: 1190px;">
            <table class="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt10p">NO.</th>
                        <th class="mWt20p">담당직원</th>
                        <th class="mWt20p">공급가액</th>
                        <th class="mWt20p">총매출액(부가세포함)</th>
                        <th class="mWt20p">미수금액</th>
                        <th class="mWt10p">상세보기</th>

                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="6">
                            <div style="max-height: 600px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
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
                                            <ItemStyle Width="20%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:Button ID="grd_btn_detail" runat="server" CssClass="btn_60_20 btn_black flr mr10" Text="상세보기"></asp:Button>
                                                <asp:HiddenField ID="grd_hdn_code" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <th class="mWt30p" colspan="2">합계</th>
                        <th class="mWt20p" id="txt_sumPrice" runat="server"></th>
                        <th class="mWt20p" id="txt_sumTotal" runat="server"></th>
                        <th class="mWt20p" id="txt_sumCost" runat="server"></th>
                        <th class="mWt10p"></th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </article>
    <script>
        fDatePickerById_yyyy_MM("ContentPlaceHolder2_txt_deliveryDate");
        fDatePickerById_yyyy_MM("ContentPlaceHolder2_txt_deliveryDate2");

        function move_to_detail(ucode, sdt, edt) {
            location.href = '/sales/Frmdetail.aspx?top=16&midx=1&ucode=' + ucode + '&sdt=' + sdt + '&edt=' + edt;
        }
    </script>
</asp:Content>
