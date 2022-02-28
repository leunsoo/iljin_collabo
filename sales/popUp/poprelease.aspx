<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="poprelease.aspx.cs" Inherits="iljin.popUp.poprelease" %>

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
                <span>출고처리</span>
                <asp:HiddenField ID="hidden_codeList" runat="server" />
                <asp:HiddenField ID="hidden_addressList" runat="server" />
            </div>
        </div>
        <table class="itable_1 mt10">
            <tobody>
                <tr>
                    <th>배송지</th>
                    <td>
                        <asp:Label ID="txt_address" runat="server"></asp:Label>
                    </td>
                    <th>배송구분</th>
                    <td>
                        <asp:DropDownList ID="cb_divCode" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cb_divCode_SelectedIndexChanged"></asp:DropDownList>
                    </td>
                </tr>
        </table>
        <div id="hiddenfield" runat="server">
            <div class="title_1 mt20">
                배송정보
            </div>
            <asp:CheckBox ID="chk_selfwrite" runat="server" Text="배송업체 직접입력" AutoPostBack="true" CssClass="ft_right mr10" OnCheckedChanged="chk_selfwrite_CheckedChanged" />
            <table class="itable_1 mt10">
                <tobody>
                    <tr>
                        <th>거래명세표번호</th>
                        <td>
                            <asp:DropDownList ID="cb_transactionNo" runat="server"></asp:DropDownList>
                        </td>
                        <th>배송업체</th>
                        <td>
                            <asp:DropDownList ID="cb_company" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cb_company_SelectedIndexChanged"></asp:DropDownList>
                            <asp:TextBox ID="txt_company" runat="server" Visible="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td>
                            <asp:TextBox ID="txt_tel" runat="server"></asp:TextBox>
                        </td>
                        <th>사업자번호</th>
                        <td>
                            <asp:TextBox ID="txt_registration" runat="server"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <th>은행명</th>
                        <td>
                            <asp:TextBox ID="txt_bank" runat="server"></asp:TextBox>
                        </td>
                        <th>계좌번호</th>
                        <td>
                            <asp:TextBox ID="txt_account" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>공급가액</th>
                        <td>
                            <asp:TextBox ID="txt_price" runat="server" Width="200px"></asp:TextBox>
                            원
                        </td>
                        <th>총액</th>
                        <td>
                            <asp:TextBox ID="txt_totalprice" runat="server" Width="200px"></asp:TextBox>
                            원
                        </td>
                    </tr>
            </table>
        </div>
        <div class="tar mt20">
            <%--OnClick="btn_releaseComplate_Click" --%>
            <asp:Button ID="btn_release" runat="server" CssClass="btn_150_40 btn_black ml10" Text="미리보기" OnClientClick="final()" />
            <asp:Button ID="btn_releaseComplate" runat="server" CssClass="btn_150_40 btn_black ml10" Text="출고완료" OnClick="btn_releaseComplate_Click" />
            <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">닫기</button>
        </div>
        <script type="text/javascript">
            function cb_divCode_OnSelectedChanged() {
                var cb_div = document.getElementById('cb_divCode');
                var hiddenfield = document.getElementById('hiddenfield');

                if (cb_div.value == '용차') {
                    hiddenfield.style.visibility = "visible";
                }
                else {
                    hiddenfield.style.visibility = "hidden";
                }
            }

            function complete() {
                document.getElementById('<%= btn_releaseComplate.ClientID%>').click();
            }

            function final() {
                var hiddenCode = document.getElementById('<%=hidden_codeList.ClientID%>').value;

                var code = hiddenCode.substr(2, hiddenCode.length - 3);
                var date = new Date();

                let yyyy = date.getFullYear();
                let mm = parseInt(date.getMonth()) + 1;
                let dd = date.getDate();

                if (mm < 10) mm = '0' + mm;
                if (dd < 10) dd = '0' + dd;

                var nowDate = yyyy + '-' + mm + '-' + dd;

                var url = "http://print.ibuild.kr/ClipReport4/dunggi/iljin_transaction.jsp?orderCode=" + code + "&date=" + nowDate + "&div=1";
                var name = "_blank"
                var popupX = (window.screen.width / 2) - (890 / 2);
                var popupY = (window.screen.height / 2) - (990 / 2);
                window.open(url, name, 'status=no,width=890,height=1120,left=' + popupX + ',top=' + popupY);
            }
        </script>
    </form>
</body>
</html>
