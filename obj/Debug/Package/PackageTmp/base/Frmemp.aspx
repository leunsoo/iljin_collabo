<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmemp.aspx.cs" Inherits="iljin.Frmemp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function sub_disp(code) {
            var url = "/base/popUp/popemp.aspx?code=" + code;
            var name = "_blank"
            var popupX = (window.screen.width / 2) - (850 / 2);
            var popupY = (window.screen.height / 2) - (500 / 2);
            window.open(url, name, 'status=no, width=850, height=500, left=' + popupX + ',top=' + popupY);
        }
        function refresh() {
            __doPostBack('<%= btn_search.UniqueID %>','');
        }
    </script>
</asp:Content> 
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner">
        <h2 class="conts_tit"><asp:Label ID="m_title" runat="server" Text="기준정보관리 ::> 사원관리"></asp:Label></h2>
        <div class="search_box">
            <div class="box_row">
                <span>이름</span>
                <asp:TextBox ID="tb_empname" runat="server" CssClass="mWt120"></asp:TextBox>
                <span class="ml10">아이디</span>
                <asp:TextBox ID="tb_empid" runat="server" CssClass="mWt120"></asp:TextBox>
                <span class="ml10">소속</span>
                <asp:DropDownList ID="cb_belong" runat="server" CssClass="mWt120"></asp:DropDownList>
                <asp:Button ID="btn_search" CssClass="btn_navy btn_100_30 ml10" runat="server" Text="조회" OnClick="btn_search_Click" />
                <asp:Button ID="btn_regist" CssClass="btn_black btn_100_30 ft_right" runat="server" Text="사원등록" OnClientClick="sub_disp(''); return false;" />
            </div>
        </div>
        <div class="fixed_hs_500 mt10">
            <table class="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt5p">No</th>
                        <th class="mWt10p">이름</th>
                        <th class="mWt10p">ID</th>
                        <th class="mWt10p">소속</th>
                        <th class="mWt10p">직책</th>
                        <th class="mWt19p">E-Mail</th>
                        <th class="mWt19p">전화</th>
                        <th class="mWt10p">메뉴권한</th>
                        <th class="mWt7p">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="9">
                            <div style="overflow:auto;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns ="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff">
                                    <HeaderStyle Height="25px" />
                                    <itemStyle HorizontalAlign="Center" />
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
                                            <ItemStyle Width="19%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="19%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:Button ID="grd_btn_update" runat="server" CssClass="btn_black btn_50_20" Text="수정" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="7%" CssClass="" />
                                        </asp:TemplateColumn>
                                    </Columns>
                                    <SelectedItemStyle BackColor="#00CCFF" />
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </article>
</asp:Content>

