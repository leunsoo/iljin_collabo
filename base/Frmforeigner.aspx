<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmforeigner.aspx.cs" Inherits="iljin.Frmforeigner" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        function sub_disp(idx) {
            var url = "/base/popUp/popforeigner.aspx?idx=" + idx;
            var name = "_blank"
            var popupX = (window.screen.width / 2) - (800 / 2);
            var popupY = (window.screen.height / 2) - (600 / 2);
            window.open(url, name, 'status=no, width=800, height=600, left=' + popupX + ',top=' + popupY);
        }
        function imagePop(url) {
            if (url == '/FRGN/') {
                alert('파일이 존재하지 않습니다.');
                return;
            }

            var popupX = (window.screen.width / 2) - (1000 / 2);
            var popupY = (window.screen.height / 2) - (700 / 2);
            window.open(url, '_blank', 'status=no,width=1000,height=700, left=' + popupX + ',top=' + popupY);
        }
        function refresh() {
            __doPostBack('<%= btn_search.UniqueID%>','');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class ="conts_inner">
        <h2 class="conts_tit"><asp:Label ID="menu_title" runat="server" Text="기준정보관리 ::> 외국인관리"></asp:Label></h2>
        <asp:LinkButton ID="btn_ck" runat="server" Width="0px" BackColor="Transparent" BorderStyle="None" ></asp:LinkButton>
        <div class ="search_box">
            <div class="box_row">
                <span>이름</span>
                <asp:TextBox ID="tb_name" runat="server" CssClass="mWt150"></asp:TextBox>
                <asp:Button ID="btn_search" CssClass="btn_navy btn_100_30 ml10" runat="server" Text="조회" OnClick="btn_search_Click" />
                <asp:Button ID="btn_add" CssClass="btn_black btn_100_30 ft_right" runat="server" Text="외국인 등록" OnClientClick="sub_disp(''); return false;"/>
            </div>
        </div>
        <div class="fixed_hs_500 mt10">
            <table class="grtable_th">
                <thead>
                    <tr>
                        <th class ="mWt5p">No</th>
                        <th class="mWt10p">이름</th>
                        <th class ="mWt17p">Full name</th>
                        <th class ="mWt13p">국적</th>
                        <th class ="mWt12p">생년월일</th>
                        <th class ="mWt22p">외국인등록번호</th>
                        <th class ="mWt7p">통장사본</th>
                        <th class ="mWt7p">ID card</th>
                        <th class ="mWt7p">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="9">
                            <div style="overflow:auto;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns ="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff">
                                    <HeaderStyle Height ="25px" />
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
                                            <ItemStyle Width="17%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="13%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="12%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="22%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:Button ID="grd_btn_bankCopy" runat="server" CssClass="btn_50_20 btn_black" Text="보기" /> 
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="7%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:Button ID="grd_btn_idCard" runat="server" CssClass="btn_50_20 btn_black" Text="보기" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="7%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:Button ID="grd_btn_update" runat="server" CssClass="btn_50_20 btn_black" Text="수정" />
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
