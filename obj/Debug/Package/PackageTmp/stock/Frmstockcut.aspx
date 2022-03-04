<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmstockcut.aspx.cs" Inherits="iljin.Frmstockcut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
 <article class ="conts_inner">
       <h2 class="conts_tit"><asp:Label ID="m_title" runat="server" Text="재고관리 ::> 제품자르기(작업지시)"></asp:Label></h2>
        <div class ="search_box">
            <div class ="box_row">
                <span>등록일</span>
                <asp:TextBox ID="tb_registrationdate" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                ~
                <asp:TextBox ID="tb_registrationdate2" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                <span class="ml20">제품명</span>
 
                <asp:TextBox ID ="tb_item" runat="server" CssClass="mWt100"></asp:TextBox>
                 <asp:Button ID ="btn_sch" runat="server" CssClass="btn_navy btn_100_30 ml10" Text="조회" OnClick="btn_sch_Click" />
               
              
                <button type="button" runat="server" class="btn_black btn_100_30 ml10" onclick="work('')">작업등록</button>
                 <button type="button" runat="server" class="btn_black btn_100_30 ml10" onclick="workorder('')">작업지시</button>
                 <button type="button" runat="server" class="btn_black btn_100_30 ml10" onclick="workcomplete('')">작업완료</button>
                <asp:Button ID ="btn_correction" runat="server" CssClass="btn_green btn_60_30 ml10" Text="수정"  OnClientClick="work('1'); return false;"/>
            <asp:Button ID ="btn_del" runat="server" CssClass="btn_red btn_60_30 ml10" Text="삭제" OnClick="btn_del_Click"  OnClientClick="return deleteCheck();" />
                    <asp:Button ID="btn_update" runat="server" CssClass="hidden" OnClick="btn_update_Click" />
                   
            </div>
            </div>
        <div class ="fixed_hs_600 mt10" style="width:1190px; overflow:hidden;">
            <table class ="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt4p"> <asp:CheckBox ID="checkbox"  runat="server" /></th>
                        <th class="mWt10p">일련번호</th>
                        <th class="mWt10p">등록일</th>
                        <th class="mWt10p">작업일</th>
                        <th class="mWt20p">작업제품</th>
                        <th class="mWt4p">수량</th>
                        <th class="mWt20p">생산제품</th>
                        <th class="mWt4p">수량</th>
                        <th class="mWt8p">작업자</th>
                        <th class="mWt10p">작업상태</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan ="10">
                             <div style=" height:550px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
               
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemTemplate>
                                               <asp:HiddenField ID="hidden_serialNo" runat="server"/>
                                                <asp:CheckBox ID="grd_checkBox" runat="server" />
                                        </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="4%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="20%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="4%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="20%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="4%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        
    </article>
    <script>
        fDatePickerById("ContentPlaceHolder2_tb_registrationdate");
        fDatePickerById("ContentPlaceHolder2_tb_registrationdate2");
     
    </script>
     <script type="text/javascript">
         function work(div) {
             var grd = document.getElementById('<%= grdTable.ClientID%>'); //그리드의 클라이언트ID로 그리드 가져옴
             var rowCount = grd.rows.length; // 그리드의 row의 개수
             var chkCount = 0; //체크된 체크박스 개수
             var serialNo = ''; //일련번호 값을 넣어줄 변수

             if (div == '1') {
                 //그리드 row탐색
                 for (var i = 0; i < rowCount; i++) {
                     //그리드의 checkbox 클라이언트ID로 찾아온뒤 checked라는 값을 가져온가(true,false) 
                     var checkValue = document.getElementById('ContentPlaceHolder2_grdTable_grd_checkBox_' + i).checked;

                     //체크가 되어있으면
                     if (checkValue == true) {
                         chkCount++; //체크된 체크박스 개수를 1 더해준다
                         serialNo = grd.rows[i].cells[1].innerHTML; //일련번호 변수에 체크된 row의 일련번호 값을 가져온다.

                         if (grd.rows[i].cells[9].innerHTML == '완료') {
                             alert('이미 작업완료된 건입니다.');
                             return false;
                         }

                     }
                 }

                 if (chkCount > 1) {
                     alert('하나의 작업만 선택해 주십시오.');
                     return false;
                 }

                 if (chkCount == 0) {
                     alert('작업을 선택해 주십시오.');
                     return false;
                 }
             }

             var url = "/stock/popUp/popwork.aspx?code=" + serialNo;
             var name = "_blank"
             var popupX = (window.screen.width / 2) - (800 / 2);
             var popupY = (window.screen.height / 2) - (500 / 2);
             window.open(url, name, 'status=no, width=800, height=550, left=' + popupX + ',top=' + popupY);
         }

         function workorder() {
             var grd = document.getElementById('<%= grdTable.ClientID%>'); //그리드의 클라이언트ID로 그리드 가져옴
             var rowCount = grd.rows.length; // 그리드의 row의 개수
             var i = 0; // for문에 쓰일 i 
             var chkCount = 0; //체크된 체크박스 개수
             var serialNo; //일련번호 값을 넣어줄 변수

             //그리드 row탐색
             for (i = 0; i < rowCount; i++)
             {
                 //그리드의 checkbox 클라이언트ID로 찾아온뒤 checked라는 값을 가져온가(true,false) 
                 var checkValue = document.getElementById('ContentPlaceHolder2_grdTable_grd_checkBox_' + i).checked;

                 //체크가 되어있으면
                 if (checkValue == true) {
                     chkCount++; //체크된 체크박스 개수를 1 더해준다
                     serialNo = grd.rows[i].cells[1].innerHTML; //일련번호 변수에 체크된 row의 일련번호 값을 가져온다.

                 }
             }

             if (chkCount > 1) {
                 alert('하나의 작업만 선택해 주십시오.');
                 return false;
             }

             if (chkCount == 0) {
                 alert('작업을 선택해 주십시오.');
                 return false;
             }

             var url = "/stock/popUp/popworkorder.aspx?code=" + serialNo;
             var name = "_blank"
             var popupX = (window.screen.width / 2) - (800 / 2);
             var popupY = (window.screen.height / 2) - (940 / 2);
             window.open(url, name, 'status=no, width=800, height=940 left=' + popupX + ',top=' + popupY);
         }

         function deleteCheck() {
             var grd = document.getElementById('<%= grdTable.ClientID%>');//그리드의 클라이언트 아이디로 그리드를 가져옴
             var rowCount = grd.rows.length; //그리드 row의 개수
             var i = 0; // for문에 쓰일 i
             var chkCount = 0; //체크된 체크박스 개수

             //grid row 탐색
             for (i = 0; i < rowCount; i++) {
                 //그리드의 checkbox 클라이언트 ID로 찾아온뒤 checked라는 값을 가져오는가(true,false)
                 var checkValue = document.getElementById('ContentPlaceHolder2_grdTable_grd_checkBox_' + i).checked;

                 //체크가 되어있으면
                 if (checkValue == true) {
                     chkCount++; //체크된 체크박스 개수를 1 더해준다.

                     if (grd.rows[i].cells[9].innerHTML == '완료') {
                         alert('이미 작업완료된 건입니다.');
                         return false;
                     }

                 }
             }

             // 체크 된 체크박스 개수가 0개이면
             if (chkCount == 0) {
                 alert('작업을 선택해 주십시오.');
                 return false;
             }

             return true;
         }

         function workcomplete() {
             var grd = document.getElementById('<%= grdTable.ClientID%>');//그리드의 클라이언트 아이디로 그리드를 가져옴
             var rowCount = grd.rows.length; //그리드 row의 개수
             var i = 0; // for문에 쓰일 i
             var chkCount = 0; //체크된 체크박스 개수
             var serialNo; //일련번호 값을 넣어줄 변수

             //grid row 탐색
             for (i = 0; i < rowCount; i++)
             {
                 //그리드의 checkbox 클라이언트 ID로 찾아온뒤 checked라는 값을 가져오는가(true,false)
                 var checkValue = document.getElementById('ContentPlaceHolder2_grdTable_grd_checkBox_' + i).checked;

                 //체크가 되어있으면
                 if (checkValue == true) {
                     chkCount++; //체크된 체크박스 개수를 1 더해준다.
                     serialNo = grd.rows[i].cells[1].innerHTML; //일련번호 변수에 체크된 row의 일련번호 값을 가져온다.

                     if (grd.rows[i].cells[9].innerHTML == '완료') {
                         alert('이미 작업완료된 건입니다.');
                         return false;
                     }

                 }
             }
             //체크 된 체크박스 개수가 하나 이상이면 
             if (chkCount > 1) {
                 alert('하나의 작업만 선택해 주십시오.');
                 return false;
             }

             // 체크 된 체크박스 개수가 0개이면
             if (chkCount == 0) {
                 alert('작업을 선택해 주십시오.');
                 return false;
             }

             var url = "/stock/popUp/popworkcomplete.aspx?code=" + serialNo;
             var name = "_blank"
             var popupX = (window.screen.width / 2) - (800 / 2);
             var popupY = (window.screen.height / 2) - (500 / 2);
             window.open(url, name, 'status=no, width=800, height=550, left=' + popupX + ',top=' + popupY);

         }
         function refresh() {
             __doPostBack('<%= btn_sch.UniqueID %>', '');
         }

         function updateStatus() {
             document.getElementById('<%=btn_update.ClientID%>').click();
         }
        
     </script>
</asp:Content>

