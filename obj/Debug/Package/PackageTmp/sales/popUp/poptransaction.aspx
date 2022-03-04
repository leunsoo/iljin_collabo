<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="poptransaction.aspx.cs" Inherits="iljin.popUp.poptransaction" %>

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

    <script>

</script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>거래명세표 발행</span>
                <asp:HiddenField ID ="hidden_tranCode" runat="server" />
                <asp:HiddenField ID="hidden_ordCode" runat="server" />
                <asp:HiddenField ID="hidden_cusCode" runat="server" />
                <asp:HiddenField ID="hidden_cusAddressIdx" runat="server" />
                <asp:HiddenField ID="hidden_releaseChk" runat="server" />
            </div>
        </div>
        <table class="itable_1 mt10">
            <tobody>
                <tr>
                    <th>발행일</th>
                    <td>
                        <asp:Label ID="txt_publisheddate" runat="server"></asp:Label>
                    </td>
                    <th>거래명세표번호</th>
                    <td>
                        <asp:Label ID="txt_transactionnum" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th>주문번호</th>
                    <td>
                        <asp:Label ID="txt_ordernum" runat="server"></asp:Label>
                    </td>
                    <th>거래처명</th>
                    <td>
                        <asp:Label ID="txt_cusname" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th>배송지</th>
                    <td>
                        <asp:Label ID="txt_customeraddress" runat="server"></asp:Label>
                    </td>
                    <th>거래일<span class="red vam">*</span></th>
                    <td>
                        <asp:TextBox ID="txt_transactionDate" autocomplete="off" runat="server" CssClass="w80p"></asp:TextBox>
                        <asp:Label ID="lb_transactionDate" runat="server" Visible="false"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th>비고</th>
                    <td colspan="3">
                        <asp:TextBox ID="txt_memo" runat="server" Height="100" TextMode="MultiLine"></asp:TextBox>
                        <asp:Label ID="lb_memo" runat="server" Height="100" Visible="false" TextMode="MultiLine"></asp:Label>
                    </td>
                </tr>
        </table>
        <div class="title_1 mt20">
            주문품목
        </div>
        <div class="mt10" >
            <table class="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt25p">제품코드</th>
                        <th class="mWt35p">제품명</th>
                        <th class="mWt20p">단위</th>
                        <th class="mWt20p">수량</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="4">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="25%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="35%" CssClass="" />
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
                                </asp:DataGrid>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="tar mt20">
            <button type="button" class="btn_150_40 btn_black ml10" onclick="final()">인쇄</button>
            <asp:Button ID="btn_save" runat="server" Text="저장" CssClass="btn_150_40 btn_black ml10" OnClick="btn_save_Click" />
            <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">닫기</button>
        </div>
        <script>
            fDatePickerById("txt_transactionDate");

            function final() {
                var hiddenCode = document.getElementById('<%=hidden_ordCode.ClientID%>').value;
                var date = document.getElementById('<%= txt_publisheddate.ClientID%>').innerHTML;

                let memo;
                let tdate;

                //출고처리된 경우 라벨로 값을 넘겨줘야 한다. (asp로 Visible = false를 하면 객체를 못찾아옴)
                if (document.getElementById('<%= hidden_releaseChk.ClientID%>').value != '1')
                {
                    memo = document.getElementById('<%= txt_memo.ClientID%>').value;
                    tdate = document.getElementById('<%= txt_transactionDate.ClientID%>').value;
                }
                else
                {
                    memo = document.getElementById('<%= lb_memo.ClientID%>').innerHTML;
                    tdate = document.getElementById('<%= lb_transactionDate.ClientID%>').innerHTML;
                }


                if (tdate.trim() == "") {
                    alert('거래일을 지정해 주십시오.');
                    return false;
                }

                var url = "http://print.ibuild.kr/ClipReport4/dunggi/iljin_transaction.jsp?orderCode=" + hiddenCode + "&date=" + tdate + "&memo=" + memo + "&div=0";
                var name = "print_transaction"
                var popupX = (window.screen.width / 2) - (890 / 2);
                var popupY = (window.screen.height / 2) - (990 / 2);
                window.open(url, name, 'status=no,width=890,height=1120,left=' + popupX + ',top=' + popupY);
            }

       <%--     //하청업체 체크 이벤트
            function onCheckedChange() {
                let chkValue = document.getElementById('<%= chk_sub.ClientID%>').checked;
                let txt_sub = document.getElementById('<%= txt_sub.ClientID%>');

                if (chkValue) {
                    txt_sub.style.visibility = "visible";
                }
                else {
                    txt_sub.value = '';
                    txt_sub.style.visibility = "hidden";
                }
            }--%>
        </script>
    </form>

</body>
</html>
