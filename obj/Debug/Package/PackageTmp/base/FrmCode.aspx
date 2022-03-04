<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="FrmCode.aspx.cs" Inherits="iljin.FrmCode" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner">
        <h2 class="conts_tit">
            <asp:Label ID="m_title" runat="server" Text="시스템관리 ::> 코드관리"></asp:Label></h2>

        <div class="left_right_con">
            <div class="left_con40">
                <div class="float_title">
                    <span>1차코드</span>
                    <asp:HiddenField ID="hidden_code" runat="server" />
                    <asp:HiddenField ID="hidden_row_idx" runat="server" />
                    <asp:Button ID="btn_sub_disp" runat="server" Height="1px" Text="Button" Width="1px" OnClick="btn_sub_disp_Click" />
                </div>
                <div class="fixed_hs_650 mt30" style="width: 475px">
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt30p">코드번호</th>
                                <th class="mWt40p">코드명</th>
                                <th class="mWt30p">사용유무</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="3">
                            <div style=" height:600px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
                                        <asp:DataGrid ID="grdTable1" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="475">
                                            <HeaderStyle Height="25px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="30%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="40%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="30%" CssClass="" />
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
                <div class="float_title">
                    <span>2차코드</span>
                    <div>
                        <button type="button" class="btn_black btn_100_30 ft_right" onclick="code_reg('<%= hidden_code.Value %>')">2차코드등록</button>
                    </div>
                </div>
                <div class="warning">
                    <span>※ ‘수정’ 버튼이 없는 코드는 수정이 불가능한 코드입니다.</span>
                </div>
                <div class="fixed_hs_650 mt10" style="width: 690px">
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt20p">코드번호</th>
                                <th class="mWt20p">순번</th>
                                <th class="mWt20p">코드명</th>
                                <th class="mWt20p">사용유무</th>
                                <th class="mWt20p">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="5">
                                <div style=" height:600px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
                                        <asp:DataGrid ID="grdTable2" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="690">
                                            <HeaderStyle Height="25px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="conts_tbl_center" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="conts_tbl_center" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="conts_tbl_center" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="conts_tbl_center" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btn_update" runat="server" CssClass="btn_black btn_60_20" Text="수정" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="conts_tbl_center" />
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
    </article>

    <script type="text/javascript">
        function code_reg(code) {
            if (!code) {
                alert('1차코드를 선택해주십시오.');
                return;
            }

            var rowIdx = document.getElementById('<%= hidden_row_idx.ClientID %>').value;

            var url = "/base/popUp/popcode.aspx?code=" + code + "&rowIdx=" + rowIdx;
            var name = "_blank"
            var popupX = (window.screen.width / 2) - (500 / 2);
            var popupY = (window.screen.height / 2) - (400 / 2);
            window.open(url, name, 'status=no, width=500, height=400, left=' + popupX + ',top=' + popupY);
        }
        function sub_disp(code, idx) {
            document.getElementById('<%= hidden_code.ClientID %>').value = code;
            document.getElementById('<%= hidden_row_idx.ClientID %>').value = idx;
            __doPostBack('<%= btn_sub_disp.UniqueID  %>', '')
        }
    </script>
</asp:Content>
