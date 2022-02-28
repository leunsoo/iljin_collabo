<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmgroup.aspx.cs" Inherits="iljin.system.Frmgroup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner">
        <h2 class="conts_tit">
            <asp:Label ID="m_title" runat="server" Text="시스템관리 ::> 그룹권한설정"></asp:Label>
            <asp:Button ID="btn_sch" runat="server" CssClass="hidden" OnClick="btn_sch_Click" />
            <asp:Button ID="btn_select" runat="server" CssClass="hidden" OnClick="btn_select_Click" />
        </h2>
        <div class="left_right_con">
            <div class="left_con40">
                <div class="buttonLeft mb10">
                    <button type="button" class="btn_navy btn_150_40" onclick="menu_auth_reg('')">권한추가</button>
                </div>
                <div class="fixed_hs_300" style="height: 700px; overflow: hidden; width: 480px;">
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt35p">권한명</th>
                                <th class="mWt30p">사용유무</th>
                                <th class="mWt35p">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="3">
                                    <div style="height: 600px; overflow-x: hidden; overflow-y: auto;">
                                        <asp:DataGrid ID="grdTable1" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="480">
                                            <HeaderStyle Height="25px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="35%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="30%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btn_edit" runat="server" CssClass="btn_60_30 btn_gray" Text="수정" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="35%" CssClass="" />
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
            </div>

            <div class="right_con58">
                <div class="buttonRight mb10">
                    <asp:Button ID="btn_save" runat="server" CssClass="btn_black btn_150_40" OnClick="btn_save_Click" Text="저장" />
                </div>
                <div class="fixed_hs_300" style="width: 690px; overflow: hidden; height: 700px;">
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt40p">1대메뉴</th>
                                <th class="mWt40p">2소메뉴</th>
                                <th class="mWt20p">접근</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="3">
                                    <div style="width: 690px; height: 600px; overflow-y: auto; overflow-x: hidden">
                                        <asp:DataGrid ID="grdTable2" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="690">
                                            <HeaderStyle Height="25px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="40%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="40%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chk_approach" runat="server" />
                                                        <asp:HiddenField ID="hidden_updated" runat="server" />
                                                        <asp:HiddenField ID="hidden_setId" runat="server" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="" />
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
            </div>
        </div>
        <asp:HiddenField ID="hidden_selectedRow" runat="server" />
        <asp:HiddenField ID="scroll1" runat="server" />
        <asp:HiddenField ID="scroll2" runat="server" />
    </article>
    <script type="text/javascript">
        function menu_auth_reg(code) {
            var url = "/system/popUp/popauthority.aspx?code=" + code;
            var name = "_blank"
            var popupX = (window.screen.width / 2) - (500 / 2);
            var popupY = (window.screen.height / 2) - (250 / 2);
            window.open(url, name, 'status=no, width=500, height=250, left=' + popupX + ',top=' + popupY);
        }

        function authority_select(selectedId, row) {
            var selectedRow = document.getElementById("<%=hidden_selectedRow.ClientID%>");
                selectedRow.value = row;
                __doPostBack('<%=btn_select.UniqueID%>', selectedId);
        }

        function refresh() {
            __doPostBack('<%=btn_sch.UniqueID%>', '');
        }

        function chk_changed(row) {
            var updated = document.getElementById("ContentPlaceHolder2_grdTable2_hidden_updated_" + row);
            updated.value = "1";
        }
    </script>
</asp:Content>
