<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="poppurchaseenrollment.aspx.cs" Inherits="iljin.popUp.poppurchaseenrollment" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>kpump</title>
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
                <span>구매요청등록</span>
                  <asp:HiddenField ID="hdn_idx" runat="server" />
                <asp:HiddenField ID="hidden_empCode" runat="server" />
                </div>
            </div>
        
        <table class="itable_1 mt10">
            <tobody>
                <tr>
                    <th>요청일</th>
                    <td>
                     <asp:TextBox ID="txt_requestdate" runat="server" CssClass="w85p"></asp:TextBox>
                    </td>
                    <th>등록자</th>
                       <td>
                       <asp:Label ID="txt_registrant" runat="server" CssClass="ml10"></asp:Label>
                    </td>
                    </tr>
                    <tr>
                     <th>담당자</th>
                       <td>
                       <asp:DropDownList ID="cb_manager" runat="server"></asp:DropDownList>
                    </td>
                     <th>거래처명</th>
                       <td>
                       <asp:TextBox ID="txt_cusname" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                 <th>메모</th>
                       <td colspan="3">
                       <asp:TextBox ID="txt_memo" runat="server"></asp:TextBox>
                    </td>
                    </tr>
        </table>
        <div class="title_1 mt20"> 제품등록 
            </div>
        <div class="tar">
 <asp:Button ID ="btn_add" runat="server" CssClass="btn_navy btn_100_30" Text="제품추가" OnClick="btn_add_Click" />
        </div>
          <div class="fixed_hs_350 mt10" style="width:1060px;">
            <table class="grtable_th">                
                <thead>
                    <tr>
                      <th class="mWt28p">제품명<span class="red vam"> *</span></th>
                        <th class="mWt12p">수량</th>
                        <th class="mWt12p">납기일</th>
                        <th class="mWt12p">제조사</th>
                        <th class="mWt12p">단가</th>
                        <th class="mWt12p">진행상태</th>
                        <th class="mWt12p">비고</th>
                            
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="7">
                          <div style=" height:315px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
                                <asp:DataGrid ID="grdTable1" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False"  AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1060">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                             <asp:TextBox ID="txt_itemname" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="28%" CssClass=""/>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                              <ItemTemplate>
                                          <asp:TextBox ID="txt_qty" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="12%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                              <ItemTemplate>
                                          <asp:TextBox ID="txt_deliverydate" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="12%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                               <ItemTemplate>
                                          <asp:TextBox ID="txt_manufacturer" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="12%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                               <ItemTemplate>
                                          <asp:TextBox ID="txt_unitprice" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="12%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                               <ItemTemplate>
                                          <asp:TextBox ID="txt_progressCode" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="12%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                          <asp:TextBox ID="txt_memo" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="12%" CssClass="" />
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
        
        <div class="tar mt10">
       
      <asp:Button ID ="btn_save" runat="server" CssClass="btn_black btn_150_40 ml10" Text="저장" OnClick="btn_save_Click" />
  <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">닫기</button>       
        </div>
        <script>
            fDatePickerById("txt_requestdate");
        </script>
    </form>
</body>
</html>
