<%@ Page Title="" Language="C#" MasterPageFile="~/idakconet.Master" AutoEventWireup="true" CodeBehind="board_write.aspx.cs" Inherits="idakconet.board_write" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <script type="text/javascript">
function sub_disp(bno,rcnt)
{
	    document.getElementById('<%= Str_no.ClientID %>').value = bno;
	    document.getElementById('<%= row_idx.ClientID %>').value = rcnt;
	    __doPostBack('<%= btn_ck.UniqueID  %>', '');
    }
<%--    function ymd_date1(dat1) {
	    document.getElementById('<%= Str_date.ClientID %>').value = dat1;
    }    
   function ent_event(no)
   {
        document.getElementById('<%= e_no.ClientID %>').value = no ;
	    __doPostBack('<%= btn_ck10.UniqueID  %>', '');
            }--%>
</script>
    
    <footer class="footer cf">
      <ul class="ft_left">
        <li><img src="/webapp/img/ft_ico01.png" alt="검색">
            <asp:Button ID="btn_search" runat="server" style="cursor:pointer; height: 17px;" Text="검색" OnClick="btn_search_Click" /></li>
        <li><img src="/webapp/img/ft_ico02.png" alt="추가"><asp:Button ID="btn_new" runat="server" style="cursor:pointer" Text="추가" OnClick="btn_new_Click" /></li>
        <li><img src="/webapp/img/ft_ico03.png" alt="저장"><asp:Button ID="btn_save" runat="server" style="cursor:pointer" Text="저장" OnClick="btn_save_Click" /></li>
      </ul>
      <ul class="ft_right">
        <li><img src="/webapp/img/ft_ico04.png" alt="삭제"><asp:Button ID="btn_del" runat="server" style="cursor:pointer" Text="삭제" OnClick="btn_del_Click" /></li>
        <li><img src="/webapp/img/ft_ico05.png" alt="취소"><asp:Button ID="btn_cancel" runat="server" style="cursor:pointer" Text="취소" OnClick="btn_cancel_Click" /></li>
        <li><img src="/webapp/img/ft_ico05.png" alt="닫기"><asp:Button ID="btn_close" runat="server" style="cursor:pointer" Text="닫기" OnClick="btn_close_Click" /></li>
      </ul>
    </footer>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">         
    <article class="conts_inner cf">
    <h2 class="conts_tit"><asp:Label ID="m_title" runat="server" Text=""></asp:Label></h2>
    <div>
        <table style="width:1300px" class="conts_tbl">
            <tr class="Ktd_tit">
                <td style="width:100px; height:30px; padding-right:10px; text-align:right; background-color:InactiveCaption">제 목</td>
                <td style=" width:500px; text-align:left;">
                    <asp:TextBox ID="t_ser" runat="server" Width="300px" Height="23px" BorderWidth="1px"></asp:TextBox>
                </td>
                <td>
                    <asp:LinkButton ID="btn_ck" runat="server" Width="0px" BackColor="Transparent" BorderStyle="None" OnClick="btn_ck_Click"></asp:LinkButton>
                    <asp:LinkButton ID="btn_ck1" runat="server" Width="0px" BackColor="Transparent" BorderStyle="None"></asp:LinkButton>
                    <asp:LinkButton ID="btn_ck10" runat="server" Width="0px" BackColor="Transparent" BorderStyle="None"></asp:LinkButton>
                    <asp:TextBox ID="row_idx" runat="server"  Width="0px" BackColor="Transparent" BorderStyle="None"></asp:TextBox>
                    <asp:TextBox ID="txt_no" runat="server" Width="0px" BackColor="Transparent" BorderStyle="None"></asp:TextBox>               
                    <asp:TextBox ID="e_no" runat="server" Width="0px" BackColor="Transparent" BorderStyle="None"></asp:TextBox>
                    <asp:TextBox ID="msg_gu" runat="server" Width="0px" BackColor="Transparent" BorderStyle="None"></asp:TextBox> 
                    <asp:TextBox ID="c_posi" runat="server" Width="0px" BackColor="Transparent" BorderStyle="None"></asp:TextBox> 
                </td>
            </tr>
        </table>
    </div>      
    <table style="width:1300px">
        <tr>
            <td style="width:600px"> 
                <table class="conts_tbl" style="width:600px">                
                    <tr class="GDTITLE">
                        <td style="width:16.66%;height:25px">번호</td>
                        <td style="width:50.00%;">제목</td>
                        <td style="width:16.66%;">작성자</td>
                        <td style="width:16.66%;">작성일자</td>
                    </tr>                    
                    <tr>
                        <td style="text-align:left" colspan="4" class="GRID_STY">
                        <div style="height:600px; overflow:auto;text-align:left"> 
                            <asp:DataGrid ID="grid_code" runat="server" AllowCustomPaging="True" ShowHeader="false"  AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="600px">
                                <ItemStyle Height="22px" HorizontalAlign="Center" />
                                <Columns>
                                    <asp:TemplateColumn HeaderText="번호">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle Width="16.66%" CssClass="conts_tbl_center"/>
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="제목">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle Width="50.00%" CssClass="conts_tbl_left" />
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="작성자">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle Width="16.66%" CssClass="conts_tbl_center" />
                                    </asp:TemplateColumn>
                                    <asp:TemplateColumn HeaderText="작성일자">
                                        <HeaderStyle HorizontalAlign="Center" />
                                        <ItemStyle Width="16.66%" CssClass="conts_tbl_center" />
                                    </asp:TemplateColumn>
                                </Columns>
                            </asp:DataGrid>
                        </div>
                        </td>
                    </tr>
                </table>
            </td>
            <td style="width:10px; vertical-align:top; background-color:white"></td>
            <td style="width:690px;margin-left:10px; vertical-align:top; text-align:center; background-color:#dee4eb">
                <table>
                    <tr>
                        <td class="Ktd_tit" style="width:100px">제목</td>
                        <td style="width:590px; text-align:left;padding-left:10px">
                            <asp:TextBox ID="Str_tit" runat="server" Width="500px" class="temple_input" Height="20px"></asp:TextBox>
                            <asp:TextBox ID="Str_no" runat="server" Width="0px" BorderStyle="None"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="Ktd_tit">작성자</td>
                        <td style="width:600px; text-align:left;padding-left:10px">
                            <asp:TextBox ID="Str_wname" runat="server" Width="150px" class="temple_input" Height="21px"></asp:TextBox></td>
                    </tr>
                    <tr> 
                        <td class="Ktd_tit">작성일자</td>
                        <td style="text-align:left; width:130px">                    
                            <table class="conts_tbl temple_tbl" style="width: 130px">           
                              <tr>
                                <td>
                                  <div class="input_wrap">
                                      <asp:TextBox ID="calendar_type01" runat="server" CssClass="temple_input calendar_type01 calendar" Width="90px"></asp:TextBox>
                                    <button class="calendar_btn" type="button" onclick="$('.calendar_type01').datepicker('show');"></button>
                                 </div>
                                </td> 
                              </tr>        
                            </table>
                        </td> 
                    </tr>
                    <tr>
                        <td class="Ktd_tit">내용</td>
                        <td style="width:590px; text-align:left;padding-left:10px">
                            <asp:TextBox ID="Str_cont" class="temple_input" runat="server" style="Width:570px; height:430px; padding:5px 5px 5px 5px;" TextMode="MultiLine"></asp:TextBox></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    </article>
    <div id="mesDP" style="top:450px; position:fixed; left:700px" runat="server" visible="false">
       <table style="width:250px; height:100px; background-color:cornflowerblue; color: black; border-width:thick">
            <tr>
                <td style="width:200px; height:30px; text-align:center; padding-top:10px; padding-bottom:10px" colspan="2">
                    <asp:Label ID="Msg" runat="server" Text="" ForeColor="#ffffff" BorderStyle="None" BackColor="Transparent"></asp:Label> 
                </td>
            </tr>
            <tr>
                <td style="width:100px;text-align:center; padding-left:30px">
                    <asp:Button ID="Yes_BT" runat="server" Text="확 인" style="background-color:#497199; width:70px;height:30px;border-width: 1px;border-color: white; color: white; cursor: pointer;" OnClick="Yes_BT_Click" /></td>
                <td style="width:100px;text-align:center; padding-right:30px">
                    <asp:Button ID="No_BT" runat="server" Text="취 소" style="background-color:#497199; width:70px;height:30px;border-width: 1px; border-color: white; color: white; cursor: pointer;" OnClick="No_BT_Click" /></td>
            </tr>
    </table>
    </div>
    </asp:Content>