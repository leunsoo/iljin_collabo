<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popinout.aspx.cs" Inherits="iljin.popUp.popinout" %>

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
                <span id="txt_itemName" runat="server">PET_단면_12_450_12000</span>
                </div>
            </div>
          <div class="float_title">
           <span>입출고 내역</span>
              </div>
        <div class="fixed_hs_200" style="width:600px;">
            <table class="grtable_th">                
                <thead>
                    <tr>
                        <th class="mWt30p">일자</th>
                        <th class="mWt15p">담당자</th>
                        <th class="mWt9p">조정</th>
                        <th class="mWt9p">입고</th>
                        <th class="mWt9p">출고</th>
                        <th class="mWt15p">재고</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="6">
                          <div style=" height:150px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
                                <asp:DataGrid ID="grdTable1" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False"  AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="600">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="30%" CssClass=""/>
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                         <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass="" />
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
            
                <div class="float_title">
                    <span>입항예정/입고 확정</span> 
                </div>
                <div class="fixed_hs_200" style="width:600px;">
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt20p">수량</th>
                                <th class="mWt20p">입항예정</th>
                                <th class="mWt20p">배차일</th>
                                  <th class="mWt20p">BLNO</th>
                                  <th class="mWt20p">컨테이너NO</th>
                               
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="5">
                                         <div style=" height:150px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
                                            <asp:DataGrid ID="grdTable2" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False"  AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="600">
                                            <HeaderStyle Height="25px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass=""/>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass=""/>
                                                </asp:TemplateColumn>  
                                                  <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="" />
                                                </asp:TemplateColumn>  
                                                 <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="" />
                                                </asp:TemplateColumn>
                                                 <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="" />
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
        <button type="button" class="btn_150_40 btn_gray mt10" onclick="self.close()">닫기</button>
        </div>
    </form>
</body>
</html>
