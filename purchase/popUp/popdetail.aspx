<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popdetail.aspx.cs" Inherits="iljin.popUp.popdetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>iljin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <meta name="format-detection" content="telephone=no" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/jquery-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/jquery-ui.structure.min.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/jquery-ui.theme.min.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/sub.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/main.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/ibuild.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/popUp.css" />
    <script src="/webapp/js/jquery-1.11.1.min.js"></script>
    <script src="/webapp/js/skyblueUtil.js"></script>
    <script src="/webapp/js/jquery-ui.min.js"></script>
    <script src="/webapp/js/front.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>계약 상세 내용</span>
                </div>
            </div>
         <div class="title_1 mt20"> 계약등록
            </div>
        <table class="itable_1 mt10">
            <tobody>
                <tr>
                    <th>거래처명</th>
                    <td>
                     <asp:DropDownList ID="cb_cusname" runat="server" ></asp:DropDownList>
                    </td>
                    <th>계약번호</th>
                       <td>
                       <asp:TextBox ID="txt_contractno" runat="server"></asp:TextBox>
                    </td>
                     <th>L/C번호</th>
                       <td>
                       <asp:TextBox ID="txt_lcNo" runat="server"></asp:TextBox>
                    </td>
                     <th>계약일</th>
                       <td>
                       <asp:TextBox ID="txt_contractdate" runat="server" Width="200"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td>
                <asp:TextBox ID="txt_title" runat="server"></asp:TextBox>
                    </td>
                    <th>가격</th>
                    <td>
                      <asp:TextBox ID="txt_price" runat="server"></asp:TextBox>
                        </td>
                    <th>도착예정일</th>
                    <td>
                      <asp:TextBox ID="txt_arrivaldate" runat="server" Width="200"></asp:TextBox>
                        </td> 
                    <th>수량</th>
                    <td>
                      <asp:TextBox ID="txt_qty" runat="server"></asp:TextBox>
                        </td> 
                </tr>
                <tr>
                    <th>담당직원</th>
                    <td> 
                        <asp:DropDownList ID="cb_manager" runat="server"></asp:DropDownList>
                    </td>
                    <th>T/T</th>
                    <td>
                        <asp:CheckBox ID="CheckBox1" runat="server" CssClass="ml100" />
                    </td> 
                     <th>샘플</th>
                    <td> 
                      <asp:CheckBox ID="CheckBox2" runat="server" CssClass="ml100" />   
                    </td>
                     <th>문서보기</th>
                    <td> 
                     <asp:Button ID ="btn_look" runat="server" CssClass="btn_navy btn_100_30" Text="보기" />
                     <asp:Button ID ="btn_upload" runat="server" CssClass="btn_gray btn_100_30 ml10" Text="업로드" />
                    </td>
                </tr>
                <tr>
                    <th>계약금액</th>
                    <td> 
                        <asp:TextBox ID="txt_contractprice" runat="server"></asp:TextBox>
                    </td>
                    <th>등록일</th>
                    <td>
                        <asp:TextBox ID="txt_registrationdate" runat="server" Width="200" />
                    </td> 
                     <th></th>
                    <td></td>
                     <th></th>
                    <td> </td>
                </tr>
                <tr>
                 <th>메모</th>
                 <td colspan="7"> 
                 <asp:TextBox ID="txt_memo" runat="server"></asp:TextBox>
                    </td>
                </tr>
                
        </table>
        <div class="title_1 mt20"> 구매품목 
            </div>
        <div class="tar">
 <asp:Button ID ="btn_add" runat="server" CssClass="btn_navy btn_100_30" Text="품목추가" />
        </div>
          <div class="fixed_hs_300 mt10" style="width:1315px;">
            <table class="grtable_th">                
                <thead>
                    <tr>
                        <th class="mWt15p">제품명</th>
                        <th class="mWt10p">제품구분1</th>
                        <th class="mWt10p">제품구분2</th>
                        <th class="mWt5p">두께</th>
                        <th class="mWt5p">폭</th>
                        <th class="mWt5p">길이</th>
                        <th class="mWt5p">개수</th>
                        <th class="mWt10p">중량(kg)</th>
                        <th class="mWt10p">단가($)</th>
                        <th class="mWt15p">가격(USD)</th>
                        <th class="mWt10p">관리</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="11">
                          <div style=" height:200px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
                                <asp:DataGrid ID="grdTable1" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False"  AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1315">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                          <asp:TextBox ID="txt_itemname" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass=""/>
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
                                            <ItemStyle Width="5%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                          <asp:TextBox ID="txt_count" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                               <ItemTemplate>
                                          <asp:TextBox ID="txt_weight" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                               <ItemTemplate>
                                          <asp:TextBox ID="txt_unitprice" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                               <ItemTemplate>
                                          <asp:TextBox ID="txt_price" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                            <asp:Button ID ="btn_del" runat="server" CssClass="btn_gray" Text="삭제" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                         
                                                                                  
                                    </Columns>
                                    <SelectedItemStyle BackColor="#00CCFF"></SelectedItemStyle>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                      <tr>
                        <th class="mWt50p" colspan="6">Total</th>
                        <th class="mWt5p"></th>
                        <th class="mWt10p"></th>
                        <th class="mWt10p"></th>
                        <th class="mWt15p"></th>
                        <th class="mWt10p"></th>  
                    </tr>
                </tfoot>
            </table>
        </div>
         <div class="title_1 mt20"> BL 정보 등록
            </div>
        <table class="itable_1 mt10">
            <tobody>
                <tr>
                    <th>BL번호</th>
                    <td>
                     <asp:TextBox ID="txt_blnum" runat="server"  ></asp:TextBox>
                    </td>
                    <th>BL접수일</th>
                       <td>
                       <asp:TextBox ID="TextBox1" runat="server" Width="200" ></asp:TextBox>
                    </td>
                     <th>신고번호</th>
                       <td>
                       <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    </td>
                     <th>원본</th>
                       <td>
                        <asp:Button ID ="Button1" runat="server" CssClass="btn_navy btn_100_30" Text="보기" />
                     <asp:Button ID ="Button2" runat="server" CssClass="btn_gray btn_100_30 ml10" Text="업로드" />
                    </td>
                </tr>
                <tr>
                    <th>수량</th>
                    <td>
                <asp:TextBox ID="TextBox3" runat="server" Width="200"></asp:TextBox>
                        &nbsp;개
                    </td>
                    <th>중량</th>
                    <td>
                      <asp:TextBox ID="txt_weight" runat="server" Width="200"></asp:TextBox>
                        &nbsp;Kg</td>
                    <th>ETD</th>
                    <td>
                      <asp:TextBox ID="txt_etd" runat="server" Width="200"></asp:TextBox>
                        </td> 
                    <th>ETA</th>
                    <td>
                      <asp:TextBox ID="txt_eta" runat="server" Width="200"></asp:TextBox>
                        </td> 
                </tr>         
        </table>
          <div class="title_1 mt20"> 컨테이너 등록
            </div>
        <div class="tar">
 <asp:Button ID ="Button3" runat="server" CssClass="btn_navy btn_100_30" Text="컨테이너 추가" />
        </div>
           <div class="fixed_hs_300 mt10" style="width:1190px;">
            <table class="grtable_th">                
                <thead>
                    <tr>
                        <th class="mWt14p">계약번호</th>
                        <th class="mWt30p">Container</th>
                        <th class="mWt14p">배차일</th>
                        <th class="mWt14p">배차시간</th>
                        <th class="mWt14p">품목</th>
                        <th class="mWt14p">관리</th>
                            
                    </tr>
                    </thead>
                 <tbody>
                    <tr>
                        <td colspan="6">
                          <div style=" height:200px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
                                <asp:DataGrid ID="DataGrid1" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False"  AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                          <asp:DropDownList ID="txt_contractno" runat="server"></asp:DropDownList>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="14%" CssClass=""/>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                             <ItemTemplate>
                                          <asp:TextBox ID="txt_container" runat="server" Width="100"></asp:TextBox>
                                          <asp:Button ID ="btn_overlap" runat="server" CssClass="btn_navy btn_100_30" Text="중복확인" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="30%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                      <asp:TextBox ID="txt_dispatchdate" runat="server" Width="100"></asp:TextBox>
                                             </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="14%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                               <ItemTemplate>
                                      <asp:TextBox ID="txt_dispatchtime" runat="server"></asp:TextBox>
                                             </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="14%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                               <ItemTemplate>          
                                          <asp:Button ID ="btn_itemselect" runat="server" CssClass="btn_green btn_100_30" Text="제품선택" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="14%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                             <ItemTemplate>
                                      <asp:Button ID ="btn_correction" runat="server" CssClass="btn_navy btn_60_40" Text="수정" />
                                      <asp:Button ID ="btn_del" runat="server" CssClass="btn_red btn_60_40 ml10" Text="삭제" />
                                             </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="14%" CssClass="" />
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
        
        <div class="title_1 mt20"> 제품선택 
            </div>
       
          <div class="fixed_hs_300 mt10" style="width:1190px;">
            <table class="grtable_th">                
                <thead>
                    <tr>
                        <th class="mWt5p">
                        <asp:CheckBox ID="CheckBox3" runat="server" /></th>
                        <th class="mWt25p">제품명</th>
                        <th class="mWt10p">제품구분1</th>
                        <th class="mWt10p">제품구분2</th>
                        <th class="mWt10p">두께</th>
                        <th class="mWt10p">폭</th>
                        <th class="mWt10p">길이</th>
                         <th class="mWt10p">개수</th>
                        <th class="mWt10p">중량(kg)</th>
                       
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="9">
                          <div style=" height:200px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
                                  <asp:DataGrid ID="DataGrid2" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False"  AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                         <asp:CheckBox ID="CheckBox1" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass=""/>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                             <ItemTemplate>
                                          <asp:TextBox ID="txt_itemname" runat="server" ></asp:TextBox>                 
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="25%" CssClass="" />
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
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                              <ItemTemplate>
                                          <asp:TextBox ID="txt_qty" runat="server" ></asp:TextBox>                 
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText=""> 
                                              <ItemTemplate>
                                          <asp:TextBox ID="txt_weight" runat="server" ></asp:TextBox>                 
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                                                                                
                                    </Columns>
                                    <SelectedItemStyle BackColor="#00CCFF"></SelectedItemStyle>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                      <tr>
                        <th class="mWt5p"></th>
                        <th class="mWt75p" colspan="6">Total</th>
                        <th class="mWt10p"></th>
                        <th class="mWt10p"></th>
                       </tr>
                </tfoot>
            </table>
        </div>
        <div class="tal mt20">
<asp:Button ID ="btn_finish" runat="server" CssClass="btn_black btn_150_40" Text="선택완료" />
<asp:Button ID ="btn_cancle" runat="server" CssClass="btn_black btn_150_40 ml10" Text="선택취소" />
   </div>
      
        


        <div class="tar mt20">
  <button type="button" class="btn_150_40 btn_gray" onclick="self.close()">취소</button>
  <input type="submit" name="btn_save" value="저장" id="btn_save" class="btn_150_40 btn_black ml10" />
           
        </div>
        <script>
            fDatePickerById("txt_contractdate");
            fDatePickerById("txt_arrivaldate");
            fDatePickerById("txt_registrationdate");
            fDatePickerById("txt_registrationdate");
            fDatePickerById("txt_etd");
            fDatePickerById("txt_eta");
            fDatePickerById("txt_dispatchdate");

        </script>


    </form>
</body>
</html>
