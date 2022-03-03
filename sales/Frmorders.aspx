<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmorders.aspx.cs" Inherits="iljin.Frmorders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <script type="text/javascript">
        var listId = 'ContentPlaceHolder2_li_itemlist';
        var txtId = 'ContentPlaceHolder2_tb_customer';

        function refresh() {
            document.getElementById('<%= btn_reset.ClientID %>').click();
        }

        function isExist(value) {
            var param = "keyward=" + value + "&div=customer&caseNo=매출";

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
            var listTop = (txt.getBoundingClientRect().top - 67) + "px";
            var listLeft = (txt.getBoundingClientRect().left - 290) + "px";
            list.style.top = listTop;
            list.style.left = listLeft;
            list.style.width = txt.offsetWidth + "px";
        }

        function visibleChk() {
            var txt = document.getElementById(txtId);
            var hidden_keyWord = document.getElementById('<%= hidden_keyWord.ClientID%>');
            var li = document.getElementById('<%=li_itemlist.ClientID%>');

            if (li.style.visibility == "hidden") {

                if (hidden_keyWord.value != "") {
                    txt.value = hidden_keyWord.value;
                    isExist(txt.value);
                }
                else {
                    isExist(txt.value);
                }
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

                //문자가 없는데 입력 시 return
                if (txt.value.length == 0) {
                    return false;
                }

                //문자가 없는데 입력 시 return
                if (txt.value.length == 1) {
                    isExist('');
                    return false;
                }

                //입력&저장된 키워드가 없을 시 한글자씩 삭제 가능하게 한다.
                if (hidden_keyWord.value == "") {
                    if (txt.value.includes("_")) {
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
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner">
        <asp:Panel ID="defaultPanel1" runat="server" DefaultButton="btn_default">
            <h2 class="conts_tit">
                <asp:Label ID="m_title" runat="server" Text="매출관리 ::> 수주관리"></asp:Label>
                <asp:HiddenField ID="hidden_currentSearchState" runat="server" />
                <asp:HiddenField ID="hidden_keyWord" runat="server" />
                <asp:ListBox ID="li_itemlist" runat="server" Style="top: 0px; left: 0px; visibility: hidden;" CssClass="autoComplete_list"></asp:ListBox>
            </h2>
            <div class="search_box">
                <div class="box_row">
                    <span>주문일</span>
                    <asp:TextBox ID="tb_orderdate" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                    ~
                <asp:TextBox ID="tb_orderdate2" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                    <span class="ml10">거래처명</span>
                    <asp:TextBox ID="tb_customer" runat="server" CssClass="mWt150" onkeydown="KeyDownEvent();" onclick="visibleChk();" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                    <asp:Button ID="btn_sch" runat="server" CssClass="btn_navy btn_100_30 ml10" Text="조회" OnClick="btn_sch_Click" />
                    <asp:Button ID="btn_reset" runat="server" CssClass="btn_red btn_100_30 ml10" Text="초기화" OnClick="btn_reset_Click" />
                    <asp:Button ID="btn_order" runat="server" CssClass="btn_black btn_100_30 ml10" Text="주문등록" OnClientClick="order(''); return false;" />

                </div>
                <div class="box_row mt10">
                    <span>납기일</span>
                    <asp:TextBox ID="tb_deliverydate" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                    ~
                <asp:TextBox ID="tb_deliverydate2" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                </div>
            </div>
            <div class="mt20">
                <span class="span_checkbox">상태구분 </span>
                <span class="span_checkBoxList">
                    <asp:RadioButton ID="rb_incomplete" CssClass="ml10" Text="미출고" runat="server" GroupName="releaseState" Checked="true" AutoPostBack="true" OnCheckedChanged="rb_incomplete_CheckedChanged" />
                    <asp:RadioButton ID="rb_complete" CssClass="ml10" Text="출고완료" runat="server" GroupName="releaseState" AutoPostBack="true" OnCheckedChanged="rb_complete_CheckedChanged" />
                    <asp:RadioButton ID="rb_all" CssClass="ml10" Text="전체" runat="server" GroupName="releaseState" AutoPostBack="true" OnCheckedChanged="rb_all_CheckedChanged" />
                </span>
            </div>
            <div class="fixed_hs_450 mt10" style="width: 1190px; overflow: hidden;">
                <table class="grtable_th">
                    <thead>
                        <tr>
                            <th class="mWt4p">
                                <asp:CheckBox ID="checkbox" runat="server" onchange="onCheckedChange();" /></th>
                            <th class="mWt10p">주문번호</th>
                            <th class="mWt10p">주문일</th>
                            <th class="mWt10p">납기일</th>
                            <th class="mWt4p">오전</th>
                            <th class="mWt10p">거래처명</th>
                            <th class="mWt15p">제품명</th>
                            <th class="mWt4p">수량</th>
                            <th class="mWt10p">배송지</th>
                            <th class="mWt10p">상태</th>

                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="10">
                                <div style="height: 400px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">

                                    <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                        <HeaderStyle Height="25px" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="grd_checkBox" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="4%" CssClass="" />
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
                                                <ItemStyle Width="4%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="10%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="15%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="4%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="10%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="10%" CssClass="" />
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="mt20">
                <button type="button" runat="server" class="btn_black btn_150_40 ml10" onclick="publish()">거래명세표 발행</button>
                <button type="button" runat="server" class="btn_black btn_150_40 ml10" onclick="separately()">거래명세표별도발행</button>
                <button type="button" runat="server" class="btn_black btn_150_40 ml10" onclick="final()">출고처리</button>

                <asp:Button ID="btn_del" runat="server" CssClass="btn_red btn_150_40 ft_right ml10" Text="삭제" OnClientClick="return deleteOrder();" OnClick="btn_del_Click" />
                <asp:Button ID="btn_correction" runat="server" CssClass="btn_green btn_150_40 ft_right ml10" Text="수정" OnClientClick="order('1'); return false;" />
            </div>
            <asp:Button ID="btn_default" runat="server" OnClientClick="return false;" CssClass="hidden" />
        </asp:Panel>
    </article>
    <script>
        fDatePickerById("ContentPlaceHolder2_tb_orderdate");
        fDatePickerById("ContentPlaceHolder2_tb_orderdate2");
        fDatePickerById("ContentPlaceHolder2_tb_deliverydate");
        fDatePickerById("ContentPlaceHolder2_tb_deliverydate2");
    </script>
    <script type="text/javascript">
        AutoRefresh();

        function deleteOrder() {
            var count = 0;
            var grd = document.getElementById('<%= grdTable.ClientID%>');
            var rowCount = grd.rows.length;

            for (var i = 0; i < rowCount; i++) {
                var checkBox = document.getElementById('ContentPlaceHolder2_grdTable_grd_checkBox_' + i);

                if (checkBox) {
                    if (checkBox.checked == true) {
                        if (grd.rows[i].cells[9].innerHTML != '인쇄완료' && grd.rows[i].cells[9].innerHTML != '등록완료') {
                            alert('출고처리된 건은 삭제가 불가합니다.');
                            return false;
                        }
                        if (grd.rows[i].cells[9].innerHTML != '등록완료') {
                            alert('거래명세표가 발행된 건은 삭제가 불가합니다.');
                            return false;
                        }
                        count++;
                        orderNo = grd.rows[i].cells[1].innerHTML;
                    }
                }

            }

            if (count == 0) {
                alert('주문건을 선택해 주십시오.');
                return false;
            }

            return true;
        }

        function order(code) {
            var orderNo = '';
            if (code != '') {
                var count = 0;
                var grd = document.getElementById('<%= grdTable.ClientID%>');
                var rowCount = grd.rows.length;

                for (var i = 0; i < rowCount; i++) {
                    var checkBox = document.getElementById('ContentPlaceHolder2_grdTable_grd_checkBox_' + i);

                    if (checkBox) {
                        if (checkBox.checked == true) {
                            if (grd.rows[i].cells[9].innerHTML != '등록완료') {
                                alert('거래명세표가 발행된 건은 수정이 불가합니다.');
                                return false;
                            }
                            count++;
                            orderNo = grd.rows[i].cells[1].innerHTML;
                        }
                    }

                }

                if (count > 1) {
                    alert('하나의 주문만 수정가능합니다.');
                    return false;
                }

                if (count == 0) {
                    alert('주문건을 선택해 주십시오.');
                    return false;
                }
            }

            var url = "/sales/popUp/poporder.aspx?code=" + orderNo;
            var name = "pop_order"
            var popupX = (window.screen.width / 2) - (1370 / 2);
            var popupY = (window.screen.height / 2) - (900 / 2);
            window.open(url, name, 'status=no, width=1370, height=850, left=' + popupX + ',top=' + popupY);
        }

        function publish() {
            var orderNo = '';
            var count = 0;
            var grd = document.getElementById('<%= grdTable.ClientID%>');
            var rowCount = grd.rows.length;
            var selectRow = 0;

            for (var i = 0; i < rowCount; i++) {
                var checkBox = document.getElementById('ContentPlaceHolder2_grdTable_grd_checkBox_' + i);

                if (checkBox) {
                    if (checkBox.checked == true) {
                        count++;
                        orderNo = grd.rows[i].cells[1].innerHTML;
                        selectRow = i;
                    }
                }

            }

            if (count > 1) {
                alert('하나의 주문만 발행 가능합니다.');
                return false;
            }

            if (count == 0) {
                alert('주문건을 선택해 주십시오.');
                return false;
            }

            if (grd.rows[selectRow].cells[9].innerHTML.includes("인쇄완료")) {
                alert('이미 발행된 내역입니다.');
                return false;
            }

            var url = "/sales/popUp/poptransaction.aspx?code=" + orderNo;
            var name = "pop_transaction"
            var popupX = (window.screen.width / 2) - (770 / 2);
            var popupY = (window.screen.height / 2) - (700 / 2);
            window.open(url, name, 'status=no, width=770, height=700, left=' + popupX + ',top=' + popupY);
        }

        function separately(code) {
            var url = "/sales/popUp/popseparately.aspx";
            var name = "pop_transaction_separate"
            var popupX = (window.screen.width / 2) - (800 / 2);
            var popupY = (window.screen.height / 2) - (650 / 2);
            window.open(url, name, 'status=no, width=800, height=400, left=' + popupX + ',top=' + popupY);
        }

        function final() {
            var count = 0;
            var grd = document.getElementById('<%= grdTable.ClientID%>');
            var rowCount = grd.rows.length;
            var selectCodes = '';
            var addressName = '';

            for (var i = 0; i < rowCount; i++) {
                var checkBox = document.getElementById('ContentPlaceHolder2_grdTable_grd_checkBox_' + i);


                if (checkBox) {
                    if (checkBox.checked == true) {
                        selectCodes += ",'" + grd.rows[i].cells[1].innerHTML + "'";
                        addressName += "," + grd.rows[i].cells[8].innerHTML;
                        count++;


                        if (!grd.rows[i].cells[9].innerHTML.includes("발행완료") && !grd.rows[i].cells[9].innerHTML.includes("등록완료")) {
                            alert('이미 출고처리된 내역입니다.');
                            return false;
                        }

                        if (!grd.rows[i].cells[9].innerHTML.includes("발행완료")) {
                            alert('거래명세표를 발행해야 합니다.');
                            return false;
                        }
                        //}
                    }
                }

            }

            if (count == 0) {
                alert('주문건을 선택해 주십시오.');
                return false;
            }

            var url = "/sales/popUp/poprelease.aspx?code=" + selectCodes + '&address=' + addressName;
            var name = "pop_order_release"
            var popupX = (window.screen.width / 2) - (800 / 2);
            var popupY = (window.screen.height / 2) - (475 / 2);
            window.open(url, name, 'status=no, width=800, height=475, left=' + popupX + ',top=' + popupY);
        }

        function onCheckedChange() {
            var grid = document.getElementById('<%= grdTable.ClientID%>');
            var rowCount = grid.rows.length;
            var isCheck = document.getElementById('<%= checkbox.ClientID%>').checked;

            for (var i = 0; i < rowCount; i++) {
                let gridCheckBox = document.getElementById('ContentPlaceHolder2_grdTable_grd_checkBox_' + i);

                if (!gridCheckBox) continue;

                gridCheckBox.checked = isCheck;
            }

        }

        function AutoRefresh() {
            setTimeout('location.reload()', 600000);
        }
    </script>
</asp:Content>

