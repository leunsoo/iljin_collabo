<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popcustotaldetail.aspx.cs" Inherits="iljin.popUp.popcustotaldetail" %>

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
    <style type="text/css">
      
      
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>거래처별집계(상세보기)</span>
                </div>
            </div>
        <div class ="search_box">
            <div class ="box_row">
                <span>기간</span>
                <asp:DropDownList ID ="cb_year" runat="server" CssClass="mWt100"></asp:DropDownList>
                년
                <asp:DropDownList ID ="cb_month" runat="server" CssClass="mWt100"></asp:DropDownList>
                월~
                <asp:DropDownList ID ="cb_year2" runat="server" CssClass="mWt100"></asp:DropDownList>
                년
                <asp:DropDownList ID ="cb_month2" runat="server" CssClass="mWt100"></asp:DropDownList>
                월
                
                <asp:Button ID ="btn_search" runat="server" CssClass="btn_navy btn_100_30 ml20" Text="조회" />
            </div>  
        </div>
        <div class="tar">
          <asp:Button ID="btn_excel" runat="server" CssClass="btn_100_30 btn_green mt10" Text="엑셀 다운로드"></asp:Button>   
        </div>
        <div class ="fixed_hs_800 mt10" style="width:1190px; overflow:hidden;">
            <table class ="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt10p">No</th>
                        <th class="mWt20p">거래처</th>
                         <th class="mWt10p">주문번호</th>
                         <th class="mWt10p">주문일자</th>
                        <th class="mWt10p">공급가액</th>
                        <th class="mWt40p">총매출액(부가세포함)</th>
                                                                                         
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan ="6">
                             <div style=" height:400px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
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
                                            <ItemStyle Width="40%" CssClass="" />
                                        </asp:TemplateColumn> 
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                      <th class="mWt30p" colspan="2">합계</th>
                        <th class="mWt10p"></th>
                        <th class="mWt10p"></th>
                        <th class="mWt10p"></th>
                        <th class="mWt40p"></th>
                         
                    </tr>
                </tfoot>
            </table>
        </div>
        <div class="tar mt20">
            <button type="button" class="btn_150_40 btn_gray" onclick="self.close()">닫기</button>
        </div>
    </form>
</body>
</html>
