<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmitemtotal.aspx.cs" Inherits="iljin.Frmitemtotal" %>

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
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ScriptManager runat="server"></asp:ScriptManager>
            <article class="conts_inner">
                <h2 class="conts_tit">
                    <asp:Label ID="m_title" runat="server" Text="경영통계 ::> 품목별집계"></asp:Label></h2>
                <div class="search_box">
                    <div class="box_row">
                        <span>기간</span>
                        <asp:TextBox ID="txt_deliveryDate" runat="server" CssClass="mWt100" autocomplete="off"></asp:TextBox>
                        &nbsp~&nbsp
                        <asp:TextBox ID="txt_deliveryDate2" runat="server" CssClass="mWt100" autocomplete="off"></asp:TextBox>
                        <span class="ml20">제품구분1</span>
                        <asp:DropDownList ID="cb_divCode1" runat="server" CssClass="mWt100" AutoPostBack="true" OnSelectedIndexChanged="cb_divCode1_SelectedIndexChanged"></asp:DropDownList>
                        <span>제품구분2</span>
                        <asp:DropDownList ID="cb_divCode2" runat="server" CssClass="mWt100"></asp:DropDownList>
                        <asp:Button ID="btn_search" runat="server" CssClass="btn_navy btn_100_30 ft_right" Text="조회" OnClick="btn_search_Click" />
                    </div>
                    <div class="box_row mt10">
                        <span>두께</span>
                        <asp:TextBox ID="txt_thickness" runat="server" CssClass="mWt100"></asp:TextBox>
                        <span class="ml20">정렬기준</span>
                        <asp:DropDownList ID="cb_sort" runat="server" CssClass="mWt100"></asp:DropDownList>
                    </div>
                </div>

                <div class="fixed_hs_660 mt10" style="width: 1190px; overflow: hidden;">
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt10p">No</th>
                                <th class="mWt26p">제품명</th>
                                <th class="mWt10p">매출수량</th>
                                <th class="mWt17p">공급가액</th>
                                <th class="mWt17p">총매출액</th>
                                <th class="mWt20p">비고</th>
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
                                                    <ItemStyle Width="26%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="10%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="17" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="17%" CssClass="" />
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
                                <th class="mWt30p" colspan="2">합계</th>
                                <th class="mWt10p" id="txt_qty" runat="server"></th>
                                <th class="mWt20p" id="txt_price" runat="server"></th>
                                <th class="mWt20p" id="txt_total" runat="server"></th>
                                <th class="mWt20p"></th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </article>
        </ContentTemplate>
    </asp:UpdatePanel>
    <script>
        let prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_pageLoaded(panelLoaded);
        function panelLoaded(sender, args) {
            fDatePickerById_yyyy_MM("ContentPlaceHolder2_txt_deliveryDate");
            fDatePickerById_yyyy_MM("ContentPlaceHolder2_txt_deliveryDate2");
        }
    </script>
</asp:Content>

