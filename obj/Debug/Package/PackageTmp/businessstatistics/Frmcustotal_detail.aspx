<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmcustotal_detail.aspx.cs" Inherits="iljin.Frmcustotal_detail" %>

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
            <asp:Label ID="m_title" runat="server" Text="경영통계 ::> 거래처별집계(상세보기)"></asp:Label>
            <asp:HiddenField ID="hdn_cusCode" runat="server" />
        </h2>
        <div class="search_box">
            <div class="box_row">
                <span>기간</span>
                <asp:TextBox ID="txt_deliveryDate" runat="server" CssClass="mWt100" autocomplete="off"></asp:TextBox>
                &nbsp~&nbsp
                <asp:TextBox ID="txt_deliveryDate2" runat="server" CssClass="mWt100" autocomplete="off"></asp:TextBox>
                <asp:Button ID="btn_search" runat="server" CssClass="btn_navy btn_100_30 ml20" Text="조회" OnClick="btn_search_Click" />
                <asp:Button ID="btn_close" runat="server" CssClass="btn_100_30 btn_gray ft_right ml10" Text="닫기" OnClientClick="formClose(); return false;"></asp:Button>
            <asp:Button ID="btn_excel" runat="server" CssClass="btn_100_30 btn_green ft_right" Text="엑셀 다운로드" OnClick="btn_excel_Click"></asp:Button>
            </div>
        </div>
        <div id="exceldiv2" runat="server" class="fixed_hs_650 mt10" style="width: 1190px; overflow: hidden;">
            <table class="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt10p">No</th>
                        <th class="mWt20p">거래처</th>
                        <th class="mWt10p">거래명세서번호</th>
                        <th class="mWt10p">발행일</th>
                        <th class="mWt10p">거래일</th>
                        <th class="mWt20p">공급가액</th>
                        <th class="mWt20p">총매출액(부가세포함)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="7">
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
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
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
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <th class="mWt30p" colspan="2">총합계</th>
                        <th class="mWt10p" ></th>
                        <th class="mWt10p" ></th>
                        <th class="mWt10p" ></th>
                        <th class="mWt20p" id="txt_price" runat="server"></th>
                        <th class="mWt20p" id="txt_total" runat="server"></th>
                    </tr>
                </tfoot>
            </table>
        </div>
    </article>
        <script>
            fDatePickerById_yyyy_MM("ContentPlaceHolder2_txt_deliveryDate");
            fDatePickerById_yyyy_MM("ContentPlaceHolder2_txt_deliveryDate2");

            function formClose() {
                location.href = '/businessstatistics/Frmcustotal.aspx?top=32&midx=3';
            }
        </script>
</asp:Content>


