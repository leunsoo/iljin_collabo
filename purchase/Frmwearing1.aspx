<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmwearing.aspx.cs" Inherits="iljin.FrmUserList" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        //팝업창 호출
        function sub_disp(code) {
            var popupX = (window.screen.width / 2) - (1000 / 2);
            var url = "popUp/popuser.aspx?code=" + code;
            window.open(url, '', 'left=' + popupX + ',top=100,width=1000,height=750,resizable=no,menubar=no,directories=no,location=no,toolbar=no,status=no,scrollbars=yes');
        }  //팝업에서 리턴했을때
        function return_save() {
            __doPostBack('<%= btn_ck.UniqueID  %>', '');
        }
    </script>
   </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">    
    <article class="conts_inner">
        <h2 class="conts_tit"><asp:Label ID="m_title" runat="server" Text="기초정보 ::>사용자리스트 "></asp:Label></h2>
          <asp:LinkButton ID="btn_ck" runat="server" Width="0px" BackColor="Transparent" BorderStyle="None"></asp:LinkButton>
        <div class="search_box">
            <div class="box_row">
                <span>이름</span>
                <asp:TextBox ID="txt_name" runat="server" CssClass="mWt100"></asp:TextBox>
                <span class="ml20">ID</span>
                <asp:TextBox ID="txt_id" runat="server" CssClass="mWt100"></asp:TextBox>
                <span class="ml20">부서</span>
                <asp:DropDownList ID="cb_office" runat="server" CssClass="mWt100"></asp:DropDownList>
                <span class="ml20">팀</span>
                <asp:DropDownList ID="cb_team" runat="server" CssClass="mWt100"></asp:DropDownList>
                <span class="ml20">메뉴권한</span>
                <asp:DropDownList ID="cb_menuLimit" runat="server" CssClass="mWt100"></asp:DropDownList>
                <asp:Button ID="btn_sch" CssClass="btn_navy btn_80_30 ml20" runat="server" Text="조회"></asp:Button>
                <asp:Button ID="btn_schreset" CssClass="btn_red btn_80_30" runat="server" Text="초기화"></asp:Button>
            </div>
        </div>
        <div class="tar">
            <asp:Button ID="btn_userregister" CssClass="btn_black btn_100_30" runat="server" Text="사용자 등록"></asp:Button>
        </div>

      <div class="fixed_hs_500 mt10">
            <table class="grtable_th">                
                <thead>
                    <tr>
                        <th class="mWt7p">이름</th>
                        <th class="mWt10p">부서</th>
                        <th class="mWt7p">팀</th>
                        <th class="mWt7p">직급</th>
                        <th class="mWt7p">ID</th>
                        <th class="mWt15p">이메일</th>
                        <th class="mWt10p">휴대폰</th>
                        <th class="mWt10p">메뉴권한</th>
                        <th class="mWt10p">사용자구분</th>
                        <th class="mWt10p">재직구분</th>
                        <th class="mWt10p">계정상태</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="11">
                            <div style="overflow:auto;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False"  AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="7%" CssClass=""/>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="7%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="7%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="7%" CssClass=""/>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass=""/>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass=""/>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass=""/>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass=""/>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass=""/>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass=""/>
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
                                       
                   
              
</article>
</asp:Content>
  