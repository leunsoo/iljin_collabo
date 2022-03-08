<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmsample.aspx.cs" Inherits="iljin.Frmsample" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner">
        <h2 class="conts_tit">
            <asp:Label ID="m_title" runat="server" Text="재고관리 ::> 샘플관리"></asp:Label></h2>
                <asp:HiddenField ID="hdn_idx" runat="server" />

        <div class="search_box">
            <div class="box_row">
                <span>등록일</span>
                <asp:TextBox ID="tb_registrationdate" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                ~
                <asp:TextBox ID="tb_registrationdate2" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                <span class="ml20">샘플명</span>
                <asp:TextBox ID="tb_samplename" runat="server" CssClass="mWt150"></asp:TextBox>
                <asp:Button ID="btn_sch" runat="server" CssClass="btn_navy btn_100_30 ml10" Text="조회" OnClick="btn_search_Click" />
                <asp:Button ID="btn_deleteFunc" runat="server" CssClass="hidden" OnClick="btn_deleteFunc_Click" />

                <button type="button" runat="server" class="btn_black btn_100_30 ml10" onclick="sample('')">샘플등록</button>


            </div>
        </div>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:ScriptManager runat="server"></asp:ScriptManager>
                <div class="fixed_hs_800 mt10" style="width: 1190px; overflow: hidden;">
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt5p">NO</th>
                                <th class="mWt10p">등록일자</th>
                                <th class="mWt20p">샘플명</th>
                                <th class="mWt15p">거래처</th>
                                <th class="mWt5p">샘플수량</th>
                                <th class="mWt10p">등록자</th>
                                <th class="mWt20p">비고</th>
                                <th class="mWt15p">관리</th>


                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="8">
                                    <div style="height: 400px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">

                                        <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                            <HeaderStyle Height="25px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="5%" CssClass="" />
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
                                                    <ItemStyle Width="15%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="5%" CssClass="" />
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
                                                    <ItemTemplate>
                                                        <asp:Button ID="btn_correction" runat="server" CssClass="btn_green btn_60_25 ml10" Text="수정" />
                                                        <asp:Button ID="btn_del" runat="server" CssClass="btn_red btn_60_25 ml10" Text="삭제"  />

                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="15%" CssClass="" />
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
        fDatePickerById("ContentPlaceHolder2_tb_registrationdate");
        fDatePickerById("ContentPlaceHolder2_tb_registrationdate2");

    </script>
    <script type="text/javascript">
        function sample(idx) {
            var url = "/stock/popUp/popsample.aspx?idx=" + idx;
            var name = "_blank"
            var popupX = (window.screen.width / 2) - (800 / 2);
            var popupY = (window.screen.height / 2) - (300 / 2);
            window.open(url, name, 'status=no, width=800, height=300, left=' + popupX + ',top=' + popupY);
        }

        function remove(idx) {
            document.getElementById('<%= hdn_idx.ClientID%>').value = idx;
            document.getElementById('<%= btn_deleteFunc.ClientID %>').click();
        }

        function refresh() {
            __doPostBack('<%= btn_sch.UniqueID %>', '');
        }
    </script>
</asp:Content>


