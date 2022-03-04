<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/iljin.Master" CodeBehind="board.aspx.cs" Inherits="iljin.board" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        function sub_disp(bno)
        {
            var popupX = (window.screen.width / 2) - (800 / 2);
    var url = "/board/board_view.aspx?bno=" + bno;
            window.open(url, '', 'left=' + popupX +',top=100,width=830,height=530,resizable=no,menubar=no,directories=no,location=no,toolbar=no,status=no,scrollbars=yes');
}

</script> 
    <footer class="footer cf">
      <ul class="ft_left">
        <li><img src="/webapp/img/ft_ico01.png" alt="검색"><asp:Button ID="btn_search" runat="server" style="cursor:pointer;" Text="검색" OnClick="btn_search_Click" /></li>
        <li><img src="/webapp/img/ft_ico02.png" alt="추가"><asp:Button ID="btn_new" runat="server" style="cursor:pointer" Text="추가" OnClick="btn_new_Click" /></li>
      </ul>
      <ul class="ft_right">
        <li><img src="/webapp/img/ft_ico05.png" alt="취소"><asp:Button ID="btn_cancel" runat="server" style="cursor:pointer; height: 17px;" Text="취소" OnClick="btn_cancel_Click" /></li>
      </ul>
    </footer>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner cf">
        <h2 class="conts_tit"><asp:Label ID="m_title" runat="server" Text="공지사항"></asp:Label>
                            <asp:Button ID="ck_fol" runat="server" Text="" CssClass="blank" OnClick="ck_fol_Click" /></h2>
        <div class="left_box">
    <table style="width:1300px">
        <tr>
            <td style="text-align:left; height:30px; padding-bottom:3px; border-style:none">
                <table class="conts_tbl">
                    <tr class="Ktd_tit">
                        <td style="width:100px; text-align:center;">제 목</td>
                        <td style="text-align:left; padding-left:5px">
                            <asp:TextBox ID="Str_ser" runat="server" Width="495px" Height="25px" CssClass="conts_tbl_left"></asp:TextBox>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="td_tit">
            <td style="text-align:left; width:1300px; border-style:none">
                <table style="width:100%" class="conts_tbl">
                    <tr class="GDTITLE">
                        <td style="width:7.69%; text-align:center;Height:25px">번호</td>
                        <td style="width:23.08%; text-align:center;">제목</td>
                        <td style="width:7.69%; text-align:center;">작성자</td>
                        <td style="width:7.69%; text-align:center;">작성일자</td>
                        <td style="width:53.85%; text-align:center;">비고</td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style="border-style:none; text-align:left" class="GRID_STY">
            <div style="height:430px; width:1300px; overflow:auto;text-align:left"> 
                <asp:DataGrid ID="grid_code" runat="server" AllowCustomPaging="True" BorderColor=  "#CCCCCC" BorderWidth="1px"  AutoGenerateColumns="False" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="100%" ShowHeader="False">
                    <ItemStyle  Height="22px" HorizontalAlign="left" />
                    <Columns>
                        <asp:TemplateColumn HeaderText="번호">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle CssClass="conts_tbl_center" Width="7.69%"/>
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="제목">
                            <HeaderStyle HorizontalAlign="center" />
                            <ItemStyle CssClass="conts_tbl_left" Width="23.08%" />
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="작성자">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle CssClass="conts_tbl_center" Width="7.69%" />
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="작성일자">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle CssClass="conts_tbl_center" Width="7.69%" />
                        </asp:TemplateColumn>
                        <asp:TemplateColumn HeaderText="비고">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle CssClass="conts_tbl_center" Width="53.85%" />
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </div>
            </td>

    </table><!--테이블 영역 끝-->
</div>  
</article>
</asp:Content>