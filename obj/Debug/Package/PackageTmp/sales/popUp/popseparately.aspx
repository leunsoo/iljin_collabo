<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popseparately.aspx.cs" Inherits="iljin.popUp.popseparately" %>

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
                <asp:HiddenField ID="hdn_tcode" runat="server" />
                <span>거래명세표 별도 발행</span>
            </div>
        </div>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:ScriptManager runat="server"></asp:ScriptManager>
                <table class="itable_1 mt10">
                    <tobody>
                        <tr>
                            <th>발행일</th>
                            <td>
                                <asp:Label ID="txt_publisheddate" runat="server" Width="200px"></asp:Label>
                            </td>
                            <th>거래명세표번호</th>
                            <td>
                                <asp:Label ID="txt_transactionnum" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th>거래처명</th>
                            <td>
                                <asp:DropDownList ID="cb_cusname" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cb_cusname_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                            <th>배송지</th>
                            <td>
                                <asp:DropDownList ID="cb_customeraddress" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cb_customeraddress_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <th>제품명</th>
                            <td>
                                <asp:TextBox ID="tb_itemname" runat="server"></asp:TextBox>
                            </td>
                            <th>수량</th>
                            <td>
                                <asp:TextBox ID="txt_Qty" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th>거래일</th>
                            <td>
                                <asp:TextBox ID="txt_transactionDate" autocomplete="off" runat="server" Width="200"></asp:TextBox>
                            </td>
                            <th>가격 표시</th>
                            <td class="tac">
                                <asp:CheckBox ID="chk_isShow" runat="server" ></asp:CheckBox>
                            </td>
                        </tr>
                        <tr>
                            <th>공급가액</th>
                            <td>
                                <asp:TextBox ID="txt_price" autocomplete="off" runat="server" Width="200"></asp:TextBox>
                            </td>
                            <th>총 금액</th>
                            <td>
                                <asp:TextBox ID="txt_totalPrice" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th>참고사항</th>
                            <td colspan="3">
                                <asp:TextBox ID="txt_note" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>

        <div class="tar mt20">
            <button type="button" class="btn_150_40 btn_black ml10" onclick="final();">인쇄</button>
            <asp:Button ID="btn_save" Text="저장" runat="server" CssClass="btn_150_40 btn_black ml10" OnClick="btn_save_Click" />
            <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">닫기</button>
        </div>
        <script>
            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_pageLoaded(panelLoaded);
            function panelLoaded(sender, args) {
                fDatePickerById("txt_transactionDate");
            }

            function final() {
                var code = document.getElementById('<%= txt_transactionnum.ClientID%>').innerHTML;
                var publishDate = document.getElementById('<%= txt_publisheddate.ClientID%>').innerHTML;
                var customer = document.getElementById('<%= cb_cusname.ClientID%>');
                var cusAddress = document.getElementById('<%= cb_customeraddress.ClientID%>').value;
                var itemname = document.getElementById('<%= tb_itemname.ClientID%>').value;
                var qty = document.getElementById('<%= txt_Qty.ClientID%>').value;
                var transactionDt = document.getElementById('<%= txt_transactionDate.ClientID%>').value;
                var memo = document.getElementById('<%= txt_note.ClientID%>').value;
                var chkValue = document.getElementById('<%= chk_isShow.ClientID%>').checked;
                var price = document.getElementById('<%= txt_price.ClientID%>').value;
                var totalprice = document.getElementById('<%= txt_totalPrice.ClientID%>').value;

                if (transactionDt.trim() == "") {
                    alert('거래일을 지정해 주십시오.');
                    return false;
                }

                if (!chkValue) {
                    price = '';
                    totalprice = '';
                }


                var url = "http://print.ibuild.kr/ClipReport4/dunggi/iljin_transaction_separate.jsp";
                var params = "?code=" + code + "&tdate=" + transactionDt + "&customerName=" + customer.options[customer.selectedIndex].text + "&itemName=" + itemname +
                    "&qty=" + qty + "&memo=" + memo + "&price=" + price + "&totalprice=" + totalprice;
                var name = "print_transaction_separate"
                var popupX = (window.screen.width / 2) - (890 / 2);
                var popupY = (window.screen.height / 2) - (990 / 2);
                window.open(url + params, name, 'status=no,width=890,height=1120,left=' + popupX + ',top=' + popupY);
            }
        </script>
    </form>

</body>
</html>
