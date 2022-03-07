<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="poptransactionlist.aspx.cs" Inherits="iljin.popUp.poptransactionlist" %>

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
                <span>거래명세표 목록</span>
                <asp:Button ID="btn_delete_hdn" runat="server" CssClass="hidden" OnClick="btn_delete_hdn_Click" />
                <asp:HiddenField ID="hdn_isSeparate" runat="server" />
                <asp:HiddenField ID="hdn_orderCode" runat="server" />
                <asp:HiddenField ID="hdn_deleteCode" runat="server" />
                </div>
            </div>
       <div class="fixed_hs_450 mt10" style="width:945px">
            <table class="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt10p">NO</th>
                        <th class="mWt20p">거래명세표번호</th>
                        <th class="mWt20p">발행일</th>
                        <th class="mWt15p">주문번호</th>
                        <th class="mWt15p">출고여부</th>
                        <th class="mWt20p">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="6">
                            <div style="height: 400px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="945">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                         <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
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
                                            <ItemStyle Width="15%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass="" />
                                        </asp:TemplateColumn>                      
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:Button ID="btn_update" runat="server" CssClass="btn_60_25 btn_navy" Text="보기" />
                                                <asp:Button ID="btn_delete" runat="server" CssClass="btn_60_25 btn_red ml20" Text="삭제" />
                                            </ItemTemplate> 
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="20%" CssClass="" />
                                        </asp:TemplateColumn>                                                                                                                                            
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="tar mt20">
            <button type="button" class="btn_150_40 btn_navy ml10 hidden" onclick="print()" >인쇄</button>
            <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">닫기</button>
        </div>
    </form>
    <script type="text/javascript">
        function transaction_update(code,tcode, div) {
            if (div == '0') //거래명세표 발행
            {
                var url = "/sales/popUp/poptransaction.aspx?tcode=" + tcode + "&code=" + code;
                var name = "pop_transaction"
                var popupX = (window.screen.width / 2) - (770 / 2);
                var popupY = (window.screen.height / 2) - (600 / 2);
                window.open(url, name, 'status=no, width=770, height=600, left=' + popupX + ',top=' + popupY);
            }
            else // 거래명세표 별도 발행
            {
                var url = "/sales/popUp/popseparately.aspx?tcode=" + tcode;
                var name = "pop_transaction_separate"
                var popupX = (window.screen.width / 2) - (800 / 2);
                var popupY = (window.screen.height / 2) - (650 / 2);
                window.open(url, name, 'status=no, width=800, height=400, left=' + popupX + ',top=' + popupY);
            }
        }

        function transaction_delete(code,tcode, div, chk) {
            if (chk == "O") {
                alert('출고처리된 건은 삭제하실 수 없습니다.');
                return false;
            }
            else {
                document.getElementById('<%= hdn_orderCode.ClientID%>').value = code;
                document.getElementById('<%= hdn_deleteCode.ClientID%>').value = tcode;
            document.getElementById('<%= hdn_isSeparate.ClientID%>').value = div;
                document.getElementById('<%= btn_delete_hdn.ClientID%>').click();
            }
        }
    </script>
</body>   
</html>
