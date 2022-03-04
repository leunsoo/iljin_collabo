<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="poperror.aspx.cs" Inherits="iljin.popUp.poperror" %>

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
    <script src="/webapp/js/httpRequest.js"></script>
    <script>
        var listId = 'li_itemlist';
        var txtId = '';
        var param = '';
        var div = '';

        function isExist(value) {
            if (div == '1') {
                param = 'keyward=' + value + '&div=item';
            }
            else {
                param = 'keyward=' + value + '&div=customer&caseNo=전체';
            }

            sendRequest("/Scripts/autocomplete_list.aspx", param, 'GET', XHRcallback);
        }

        //리스트에 넣기
        function XHRcallback() {
            if (XHR.readyState == 4) {
                if (XHR.status == 200) {
                    var result = JSON.parse(XHR.responseText);
                    var list = document.getElementById(listId);
                    var txt = document.getElementById(txtId);
                    var i;

                    for (var optCnt = list.options.length - 1; optCnt >= 0; optCnt--) {
                        list.options.remove(optCnt);
                    }

                    for (i = 0; i < result.length; i++) {
                        var element = document.createElement("option");

                        element.text = result[i].name;
                        element.value = result[i].code;
                        list.add(element);

                        element.addEventListener("click", function (e) {
                            txt.value = e.target.innerHTML;
                            list.style.visibility = "hidden";
                            if (txtId.includes('txt_customer')) {
                                document.getElementById('<%= hidden_cusCode.ClientID %>').value = e.target.value;
                            }
                            else {
                                document.getElementById('<%= hidden_itemCode.ClientID %>').value = e.target.value;
                            }
                        }
                        );

                        if (i != result.length - 1) element.style.borderBottom = "1px solid #cbcbcb";

                    }

                    listBoxOn(list);
                }
            }
        }

        function list_Focus_Out_Event() {
            window.addEventListener("click", function (e) {
                var txt = document.getElementById(txtId);
                var li = document.getElementById(listId);

                if (!li) return;

                if (li.style.visibility == "visible") {
                    var target = e.target;
                    if (target.parentElement != li && target != txt) {
                        li.style.visibility = "hidden"
                    }
                }
            }
            )
        }

        function listBoxOn(list) {

            var itemCount = list.options.length;
            var itemHeight = (list.options[0].clientHeight + 1);
            var txt = document.getElementById(txtId);

            list.style.visibility = "visible";

            if (itemCount > 10) itemCount = 10;

            var height = (itemHeight * itemCount + 1) + "px";
            list.style.height = height;
            var listTop = (txt.getBoundingClientRect().top + 30) + "px";
            var listLeft = txt.getBoundingClientRect().left + "px";
            list.style.top = listTop;
            list.style.left = listLeft;
            list.style.width = txt.offsetWidth + "px";
        }

        function visibleChk(_div) {
            var hidden_keyWord = document.getElementById('<%= hidden_keyWord.ClientID%>');

            if (div != _div) {
                hidden_keyWord.value = '';
            }

            div = _div;
            if (div == '1') //제품
            {
                txtId = 'txt_itemname';
            }
            else //거래처
            {
                txtId = 'txt_customer';
            }

            var txt = document.getElementById(txtId);
            var li = document.getElementById('<%=li_itemlist.ClientID%>');

            //var lastChar = txt.value.charAt(txt.value.length - 1);

            if (hidden_keyWord.value != "") {
                txt.value = hidden_keyWord.value;
                isExist(txt.value);
            }
            else {
                //if (lastChar != "|" && lastChar != '' && !txt.value.includes("_")) {
                //    txt.value += "|";
                //    hidden_keyWord.value = txt.value;
                //}
                isExist(txt.value);
            }
        }

        function KeyPressEvent() {
            if (event.keyCode == 13) {
                var txt = document.getElementById(txtId);
                var hidden_keyWord = document.getElementById('<%= hidden_keyWord.ClientID%>');
                var lastChar = txt.value.charAt(txt.value.length - 1);

                if (lastChar != "|") {
                    txt.value += "|";
                    hidden_keyWord.value = txt.value;
                    isExist(txt.value);
                }
            }
        }

        function KeyDownEvent() {
            if (event.keyCode == 8) {
                var txt = document.getElementById(txtId);
                var hidden_keyWord = document.getElementById('<%= hidden_keyWord.ClientID%>');

                if (txtId.includes('txt_customer')) {
                    document.getElementById('<%= hidden_cusCode.ClientID %>').value = '';
                }
                else {
                    document.getElementById('<%= hidden_itemCode.ClientID %>').value = '';
                }

                //문자가 없는데 입력 시 return
                if (txt.value.length == 0) {
                    return false;
                }

                //입력&저장된 키워드가 없을 시 한글자씩 삭제 가능하게 한다.
                if (hidden_keyWord.value == "") {
                    if (txt.value.includes("_")) {
                        txt.value = "";
                        isExist(txt.value);
                    }
                    else if (txtId.includes('txt_customer')) {
                        txt.value = "";
                        isExist(txt.value);
                    }
                    return false;
                }

                //마지막 글자 가져오기
                var lastChar = txt.value.charAt(txt.value.length - 1);

                //마지막 글자가 |이 아닐때 => 키워드 삭제가 아닌 입력하고 있던 글자 삭제
                if (lastChar != "|") return false;

                //마지막 글자가 |일때 => 키워드가 있다는 것, hidden_keyWord에서 저장된 키워드 1개 삭제 후 txt.value로 전달
                // case => 2
                // case:1 => 키워드가 1개 일 시 하나만 공란으로 만들어 주기
                // case:2 => 키워드가 n개 일 시 이전 | 이후 문자열 삭제 아니면 split? 후??
                if (lastChar == "|") {
                    var txtArr = hidden_keyWord.value.split('|');
                    txt.value = "";
                    var i = 0;

                    if (txtArr.length > 2) {
                        for (i = 0; i < txtArr.length - 2; i++) {
                            txt.value += (txtArr[i] + "|");
                        }
                    }

                    hidden_keyWord.value = txt.value;
                    txt.value += "|";

                    isExist(txt.value);
                    return false;
                }
            }
        }
        list_Focus_Out_Event();
    </script>
</head>
<body>
    <form id="form1" runat="server">
<asp:Panel ID="defaultPanel1" runat="server" DefaultButton="btn_default">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>불량등록</span>
                <asp:HiddenField ID="hidden_code" runat="server" />
                <asp:HiddenField ID="hidden_empCode" runat="server" />
                <asp:HiddenField ID="hidden_keyWord" runat="server" />
                <asp:HiddenField ID="hidden_itemCode" runat="server" />
                <asp:HiddenField ID="hidden_cusCode" runat="server" />
                <asp:ListBox ID="li_itemlist" runat="server" CssClass="autoComplete_list" Style="top:0px; left:0px; visibility: hidden;"></asp:ListBox>
            </div>
        </div>
        <table class="itable_1 mt10">
            <tr>
                <th>등록일</th>
                <td>
                    <asp:Label ID="txt_registrationdate" runat="server"></asp:Label>
                </td>
                <th>등록자</th>
                <td>
                    <asp:Label ID="txt_register" runat="server"></asp:Label>
                </td>
                <th>거래처<span class="red vam">*</span></th>
                <td>
                    <asp:TextBox ID="txt_customer" runat="server" onkeydown="KeyDownEvent();" onclick="visibleChk('2');" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>제품명<span class="red vam">*</span></th>
                <td>
                    <asp:TextBox ID="txt_itemname" runat="server" onkeydown="KeyDownEvent();" onclick="visibleChk('1');" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                </td>
                <th>불량유형</th>
                <td>
                    <asp:TextBox ID="txt_errortype" runat="server"></asp:TextBox>
                </td>
                <th>불량수량</th>
                <td>
                    <asp:TextBox ID="txt_errorQty" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>반품요청일</th>
                <td>
                    <asp:TextBox ID="txt_requestdate" runat="server" CssClass="w85p" autocomplete="off"></asp:TextBox>
                </td>
                <th>담당확인일</th>
                <td>
                    <asp:TextBox ID="txt_checkdate" runat="server" CssClass="w85p" autocomplete="off"></asp:TextBox>
                </td>
                <th>회수일</th>
                <td>
                    <asp:TextBox ID="txt_returndate" runat="server" CssClass="w85p" autocomplete="off"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <th>재입고일</th>
                <td>
                    <asp:TextBox ID="txt_incomedate" runat="server" CssClass="w85p" autocomplete="off"></asp:TextBox>
                </td>
                <th>계산서변경일</th>
                <td>
                    <asp:TextBox ID="txt_transactiondate" runat="server" CssClass="w85p" autocomplete="off"></asp:TextBox>
                </td>
                <th></th>
                <td></td>
            </tr>
            <tr>
                <th>비고</th>
                <td colspan="5">
                    <asp:TextBox ID="txt_memo" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>
        <div class="tar mt20">
            <asp:Button ID="btn_save" Text="저장" runat="server" CssClass="btn_150_40 btn_black" OnClick="btn_save_Click" />
            <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">닫기</button>
        </div>
        <script>
            fDatePickerById("txt_requestdate");
            fDatePickerById("txt_checkdate");
            fDatePickerById("txt_returndate");
            fDatePickerById("txt_incomedate");
            fDatePickerById("txt_transactiondate");
        </script>
          <asp:Button ID="btn_default" runat="server" OnClientClick="return false;"  CssClass="hidden"/>
</asp:Panel>
    </form>
</body>
</html>
