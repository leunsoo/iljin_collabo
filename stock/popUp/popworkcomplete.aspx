<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popworkcomplete.aspx.cs" Inherits="iljin.popUp.popworkcomplete" EnableEventValidation="false" %>

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
        var txtId = null;
        var hdnId = null;
        var div = '';
        var hdnkeyward = 'hidden_keyWord';

        function isExist(value) {
            var param = '';

            if (div == '1') {
                param = 'keyward=' + value + '&div=&caseNo=재고';
            }
            else if (div == '2') {
                param = 'keyward=' + value + '&div=item';
            }
            else if (div == '3') {
                param = 'keyward=' + value + '&div=foreigner';
            }
            else {
                param = 'keyward=' + value + '&div=emp';
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
                            document.getElementById(hdnId).value = list.value;
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

            //$(this).focusout
            //list.addEventListener("clickoutside", clickEvent2)
            //$(this).bind("clickoutside",function (event) {
            //    clickEvent2();
            //})
            //list.addEventListener("focusout", clickEvent2);

            if (itemCount > 5) itemCount = 5;

            var height = (itemHeight * itemCount + 1) + "px";
            //list.setAttribute("style", "height:" + height + " visibility:visible; width:200px; padding:0px 0px; background:white; position:absolute;left:101px;top:108px;z-index:10;");
            list.style.height = height;
            var listTop = (txt.getBoundingClientRect().top + 30 + window.pageYOffset) + "px";
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
            //제품
            if (div == '1') {
                txtId = 'txt_workitem';
                hdnId = 'hidden_itemCode';
            }
            //생산제품
            else if (div == '2') {
                txtId = 'txt_produceitem';
                hdnId = 'hidden_itemCode2';
            }
            //작업자
            else if (div == '3') {
                txtId = 'tb_foreign';
                hdnId = 'hidden_idx';
            }
            //지시자
            else {
                txtId = 'tb_emp';
                hdnId = 'hidden_userCode';
            }

            var txt = document.getElementById(txtId);
            var hidden_keyWord = document.getElementById(hdnkeyward);
            var li = document.getElementById('<%=li_itemlist.ClientID%>');
            //document.getElementById(hdnId).value = '';

            if (hidden_keyWord.value != "") {
                txt.value = hidden_keyWord.value;
                isExist(txt.value);
            }
            else {
                isExist(txt.value);
            }
        }

        function KeyPressEvent(row) {
            if (event.keyCode == 13) {
                var txt = document.getElementById(txtId);
                var hidden_keyWord = document.getElementById(hdnkeyward);
                var lastChar = txt.value.charAt(txt.value.length - 1);

                if (lastChar != "|") {
                    txt.value += "|";
                    hidden_keyWord.value = txt.value;
                    isExist(txt.value, row);
                }
            }
        }

        function KeyDownEvent(row) {
            if (event.keyCode == 8) {
                var txt = document.getElementById(txtId);
                var hidden_keyWord = document.getElementById(hdnkeyward);
                document.getElementById(hdnId).value = '';

                //문자가 없는데 입력 시 return
                if (txt.value.length == 0) {
                    return false;
                }

                //입력&저장된 키워드가 없을 시 한글자씩 삭제 가능하게 한다.
                if (hidden_keyWord.value == "") {
                    if (txt.value.includes("_")) {
                        txt.value = "";
                        isExist('', row);
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

                    isExist(txt.value, row);
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
                    <span>작업 완료</span>
                    <asp:HiddenField ID="hidden_code" runat="server" />
                    <asp:HiddenField ID="hidden_keyWord" runat="server" />
                    <asp:HiddenField ID="hdn_deleteRow" runat="server" />
                    <asp:Button ID="hdn_btn_delete" runat="server" OnClick="hdn_btn_delete_Click" />
                    <asp:ListBox ID="li_itemlist" runat="server" CssClass="autoComplete_list" Style="top:0px; left:0px; visibility: hidden;"></asp:ListBox>
                </div>
            </div>
            <div class="title_1 mt20">
                기본정보
            </div>
            <table class="itable_1 mt10">
                <tobody>
                    <tr>
                        <th>등록일</th>
                        <td>
                            <asp:Label ID="lbl_registrationdate" runat="server"></asp:Label>
                        </td>
                        <th>작업일</th>
                        <td>
                            <asp:TextBox ID="txt_workdate" runat="server" CssClass="w80p"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>작업자</th>
                        <td>
                            <asp:TextBox ID="tb_foreign" runat="server" onkeydown="KeyDownEvent();" onclick="visibleChk('3');" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                            <asp:HiddenField ID="hidden_idx" runat="server" />
                        </td>
                        <th>지시자</th>
                        <td>
                            <asp:TextBox ID="tb_emp" runat="server" onkeydown="KeyDownEvent();" onclick="visibleChk('4');" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                            <asp:HiddenField ID="hidden_userCode" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <th>작업기계</th>
                        <td>
                            <asp:DropDownList ID="cb_machineNo" runat="server"></asp:DropDownList>
                        </td>
                        <th>일련번호</th>
                        <td>
                            <asp:Label ID="txt_serialNo" runat="server"></asp:Label>
                        </td>
                    </tr>
            </table>
            <div class="title_1 mt20">
                작업정보
            </div>
            <table class="itable_1 mt10">
                <tobody>
                    <tr>
                        <th>작업제품</th>
                        <td>
                            <asp:TextBox ID="txt_workitem" runat="server" onkeydown="KeyDownEvent();" onclick="visibleChk('1');" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                            <asp:HiddenField ID="hidden_itemCode" runat="server" />
                        </td>
                        <th>수량</th>
                        <td>
                            <asp:TextBox ID="txt_workitemQty" runat="server"></asp:TextBox>
                        </td>
                    </tr>
            </table>
            <div class="title_1 ">
                생산제품
                <asp:Button ID="btn_add" runat="server" CssClass="ft_right btn_navy btn_100_30" Text="추가" OnClick="btn_add_Click" />
            </div>
            <asp:DataGrid ID="grdTable1" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff">
                <Columns>
                    <asp:TemplateColumn HeaderText="">
                        <ItemTemplate>
                            <table class="itable_1">
                                <tbody>
                                    <tr>
                                        <th class="w10p">생산제품</th>
                                        <td class="w50p">
                                            <asp:HiddenField ID="hidden_itemCode2" runat="server" />
                                            <asp:TextBox ID="txt_produceitem" runat="server" autocomplete="off"></asp:TextBox>
                                        </td>
                                        <th class="w10p">수량</th>
                                        <td class="w20p">
                                            <asp:TextBox ID="txt_produceitemQty" runat="server" CssClass="w100p" TextMode="Number"></asp:TextBox>
                                        </td>
                                        <th class="w10p">
                                            <asp:Button ID="btn_delete" runat="server" CssClass="btn_60_25 btn_red" Text="삭제" />
                                        </th>
                                    </tr>
                                </tbody>
                            </table>
                        </ItemTemplate>
                    </asp:TemplateColumn>
                </Columns>
                <SelectedItemStyle BackColor="#00CCFF"></SelectedItemStyle>
            </asp:DataGrid>
            <div class="tar mt20">
                <asp:Button ID="btn_complete" runat="server" class="btn_150_40 btn_black" Text="완료" OnClientClick="return SaveValidChk();" OnClick="btn_complete_Click" />
                <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">취소</button>
            </div>
            <script>
                fDatePickerById("txt_registrationdate");
                fDatePickerById("txt_workdate");

                function SaveValidChk() {
                    let grid = document.getElementById('<%= grdTable1.ClientID %>');
                    if (!grid) {
                        alert('생산제품을 등록해 주십시오.');
                        return false;
                    }

                    for (let i = 0; i < grid.rows.length; i++) {
                        let itemCode = document.getElementById('grdTable1_hidden_itemCode2_' + i).value;

                        if (itemCode == '' || !itemCode) {
                            alert('제품을 선택해 주십시오.');
                            return false;
                        }
                    }

                    return true;
                }

                function DeleteItem(row) {
                    document.getElementById('<%= hdn_deleteRow.ClientID%>').value = row;
                    document.getElementById('<%= hdn_btn_delete.ClientID%>').click();
                }
            </script>
            <asp:Button ID="btn_default" runat="server" OnClientClick="return false;" CssClass="hidden" />
        </asp:Panel>
    </form>
</body>
</html>
