<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmpurchase.aspx.cs" Inherits="iljin.Frmpurchase" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script>
        function checkChange() {
            var grd = document.getElementById('<%=grdTable.ClientID%>');
            var rowcount = grd.rows.length;
            var chkValue = document.getElementById('<%=CheckBox.ClientID%>').checked;

            for (var i = 0; i < rowcount; i++) {
                document.getElementById('ContentPlaceHolder2_grdTable_grd_checkBox_' + i).checked = chkValue;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">    <article class="conts_inner">
        <h2 class="conts_tit"><asp:Label ID="m_title" runat="server" Text="매입관리 ::> 구매현황"></asp:Label></h2>
    <asp:HiddenField ID="hidden_deleteIdxList" runat="server" />
        <div class="search_box">
            <div class ="box_row">
                <span>요청일</span>
                  <asp:TextBox ID="tb_requestdate" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                ~
                <asp:TextBox ID="tb_requestdate2" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                <asp:Button ID ="btn_search" runat="server" CssClass="btn_navy btn_100_30 ml10" Text="조회" OnClick="btn_search_Click" />
                <button type="button" runat="server" class="btn_black btn_100_30 ft_right ml10 " onclick="check()">수정</button>
                <button type="button" runat="server" class="btn_black btn_100_30 ft_right " onclick="purchaseenrollment('')">구매요청등록</button>
                
                 <asp:Button ID ="btn_del" runat="server" CssClass="btn_red btn_100_30" Text="삭제" OnClick="btn_del_Click" />
              
            </div>
        </div>
         <div class ="fixed_hs_600 mt10" style="width: 1190px; overflow:hidden;">
            <table class ="grtable_th">
                <thead>
                    <tr>
                        <th class ="mWt3p"><asp:CheckBox ID="CheckBox" runat="server" onchange="checkChange();" /></th>
                        <th class ="mWt3p">NO.</th>
                        <th class ="mWt8p">요청일</th>
                        <th class ="mWt5p">등록자</th>
                        <th class ="mWt5p">요청자</th>
                        <th class ="mWt8p">거래처명</th>
                        <th class ="mWt13p">제품명</th>
                        <th class ="mWt5p">수량</th>
                        <th class ="mWt8p">납기일</th>
                        <th class ="mWt8p">제조사</th>
                        <th class ="mWt8p">단가</th>
                        <th class ="mWt8p">진행상태</th>
                        <th class ="mWt8p">비고</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan ="13">
                          <div style=" height:565px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:HiddenField ID="hidden_idx" runat="server"/>
                                                <asp:HiddenField ID="hidden_idx_detail" runat="server" />
                                      <asp:CheckBox ID="grd_checkBox" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="3%" CssClass ="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="3%" CssClass ="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass ="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass ="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass ="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txt_cusName" runat ="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass ="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                   <asp:HiddenField ID="hdn_cud" runat="server" />
                                                <asp:TextBox ID="txt_itemName" runat ="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="13%" CssClass ="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txt_qty" runat ="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass ="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                              <asp:TextBox  ID="txt_deliverydate" runat ="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass ="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txt_manufacturer" runat ="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass ="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txt_unitprice"  runat ="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass ="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txt_progress" runat ="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass ="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txt_memo" runat ="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass ="" />
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
     <script>
         fDatePickerById("ContentPlaceHolder2_tb_requestdate");
         fDatePickerById("ContentPlaceHolder2_tb_requestdate2");
     </script>
     <script>


         function purchaseenrollment(code) {
             var url = "/purchase/popUp/poppurchaseenrollment.aspx?code=" + code;
             var name = "_blank"
             var popupX = (window.screen.width / 2) - (1220 / 2);
             var popupY = (window.screen.height / 2) - (850 / 2);
             window.open(url, name, 'status=no, width=1220, height=850, left=' + popupX + ',top=' + popupY);

         }

         function change_cud(num) {
             var cud = document.getElementById('ContentPlaceHolder2_grdTable_hdn_cud_' + num);
             if (cud.value != "c" && cud.value != "u") cud.value = "u";
         }

         function refresh() {
             document.getElementById('<%= btn_search.ClientID%>').click();
           }

         function check() {
               var grd = document.getElementById('<%= grdTable.ClientID%>'); //그리드의 클라이언트 ID로 그리드 가져옴
             var rowCount = grd.rows.length; // 그리드의 row의 개수
             var i = 0; //for문에 쓰일 i
             var chkCount = 0; //체크된 체크박스 개수
             var idx; //일련번호 값을 넣어줄 변수

             //그리드 row 탐색
             for (i = 0; i < rowCount; i++)
             {
                 //그리드의 checkbox 클라이언트ID로 찾아온뒤 checked 라는 값을 가져오는가(true,false)
                 var checkValue = document.getElementById('ContentPlaceHolder2_grdTable_grd_checkBox_' + i).checked;

                 //체크가 되어있으면
                 if (checkValue == true) {
                     chkCount++; //체크된 체크박스 개수를 1 더해준다.
                     idx = document.getElementById('ContentPlaceHolder2_grdTable_hidden_idx_' + i).value;
                 }
             }
             if (chkCount > 1) {
                 alert('하나의 작업만 선택해 주십시오.');
                 return false;
             }

             if (chkCount == 0) {
                 alert('작업을 선택해 주십시오');
                 return false;
             }
             var url = "/purchase/popUp/poppurchaseenrollment.aspx?code=" + idx;
             var name = "_blank"
            var popupX = (window.screen.width / 2) - (1220 / 2);
             var popupY = (window.screen.height / 2) - (850 / 2);
             window.open(url, name, 'status=no, width=1220, height=850, left=' + popupX + ',top=' + popupY);

         }
       
     </script>
</asp:Content>
