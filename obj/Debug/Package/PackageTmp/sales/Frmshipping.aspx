<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmshipping.aspx.cs" Inherits="iljin.Frmshipping" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner">
        <h2 class="conts_tit">
            <asp:Label ID="m_title" runat="server" Text="매출관리 ::> 배송처별 현황"></asp:Label></h2>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:ScriptManager runat="server"></asp:ScriptManager>
                <div class="search_box">
                    <div class="box_row">
                        <span>거래처</span>
                        <asp:DropDownList ID="cb_customer" runat="server" AutoPostBack="true" CssClass="mWt170" OnSelectedIndexChanged="cb_customer_SelectedIndexChanged"></asp:DropDownList>

                        <span class="ml10">배송지</span>
                        <asp:DropDownList ID="cb_address" runat="server" CssClass="mWt150"></asp:DropDownList>
                        <span class="ml10">배송일 </span>
                        <asp:TextBox ID="tb_deliverydate" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                        ~
                <asp:TextBox ID="tb_deliverydate2" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                        <span class="ml10">배송구분</span>
                        <asp:DropDownList ID="cb_adressdiv" runat="server" CssClass="mWt100"></asp:DropDownList>
                        <asp:Button ID="btn_serch" runat="server" CssClass="btn_navy btn_100_30 ml10" Text="조회" OnClick="btn_serch_Click" />
                    </div>
                </div>
                <button type="button" runat="server" class="btn_black btn_100_30 ft_right mr10 mb10" onclick="transaction()">거래명세표 목록</button>
                <div class="fixed_hs_650 mt10" style="width: 1190px; overflow: hidden;">
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt11p">배송일자</th>
                                <th class="mWt11p">거래처명</th>
                                <th class="mWt11p">배송지</th>
                                <th class="mWt11p">주문번호</th>
                                <th class="mWt11p">주문수량</th>
                                <th class="mWt11p">총중량</th>
                                <th class="mWt11p">배송구분</th>
                                <th class="mWt11p">배송업체</th>
                                <th class="mWt11p">연락처</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="9">
                                    <div style="height: 600px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                        <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                            <HeaderStyle Height="25px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="11%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="11%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="11%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="11%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="11%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="11%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="11%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="11%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="11%" CssClass="" />
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </article>
    <script>
        fDatePickerById("ContentPlaceHolder2_tb_deliverydate");
        fDatePickerById("ContentPlaceHolder2_tb_deliverydate2");

        var prm = Sys.WebForms.PageRequestManager.getInstance();
        prm.add_pageLoaded(panelLoaded);
        function panelLoaded(sender, args) {
            fDatePickerById("ContentPlaceHolder2_tb_deliverydate");
            fDatePickerById("ContentPlaceHolder2_tb_deliverydate2");
        }

        function transaction() {
            var url = "/sales/popUp/poptransactionlist.aspx";
            var name = "pop_transactionList"
            var popupX = (window.screen.width / 2) - (1000 / 2);
            var popupY = (window.screen.height / 2) - (650 / 2);
            window.open(url, name, 'status=no, width=1000, height=650, left=' + popupX + ',top=' + popupY);

        }

    </script>
</asp:Content>
