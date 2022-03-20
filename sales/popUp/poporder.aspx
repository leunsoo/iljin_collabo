<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="poporder.aspx.cs" Inherits="iljin.popUp.poporder" %>

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
    <script type="text/javascript">
        var listId = 'li_itemlist';
        var txtId = null;
        var hdnId = null;
        var selectRow = null;
        var hdnkeyward = null;

        function isExist(value) {
            var param = "keyward=" + value + "&div=item";

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
                            document.getElementById('hidden_selectedRow').value = selectRow;
                            document.getElementById(hdnId).value = list.value;
                            if (hdnId.includes('virtual')) {
                                document.getElementById('btn_itemInfoSetting').click();
                            }

                            var cud = document.getElementById('grdTable_hdn_cud_' + selectRow);
                            if (cud.value != "c" && cud.value != "u") cud.value = "u";
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

            if (itemCount > 7) itemCount = 7;

            var height = (itemHeight * itemCount + 1) + "px";
            //list.setAttribute("style", "height:" + height + " visibility:visible; width:200px; padding:0px 0px; background:white; position:absolute;left:101px;top:108px;z-index:10;");
            list.style.height = height;
            var listTop = (txt.getBoundingClientRect().top + 30) + "px";
            var listLeft = txt.getBoundingClientRect().left + "px";
            list.style.top = listTop;
            list.style.left = listLeft;
            list.style.width = txt.offsetWidth + "px";
        }

        function visibleChk(row, div) {

            if (div == '1') {
                txtId = 'grdTable_grd_txt_itemName_' + row;
                hdnId = 'grdTable_grd_hdn_virtualItemCode_' + row;
                hdnkeyward = 'grdTable_hidden_keyWord1_' + row;
            }
            else {
                txtId = 'grdTable_grd_txt_itemName2_' + row;
                hdnId = 'grdTable_grd_hdn_actualItemCode_' + row;
                hdnkeyward = 'grdTable_hidden_keyWord2_' + row;
            }

            selectRow = row;

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

        function KeyPressEvent() {
            if (event.keyCode == 13) {
                var txt = document.getElementById(txtId);
                var hidden_keyWord = document.getElementById(hdnkeyward);
                var lastChar = txt.value.charAt(txt.value.length - 1);

                if (txt.value.trim() == '') {
                    return;
                    isExist('');
                }

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
                // document.getElementById(hdnId).value = '';

                var hidden_keyWord = document.getElementById(hdnkeyward);

                //문자가 없는데 입력 시 return
                if (txt.value.length == 0) {
                    return false;
                }

                //입력&저장된 키워드가 없을 시 한글자씩 삭제 가능하게 한다.
                if (hidden_keyWord.value == "") {
                    if (txt.value.includes("_")) {
                        txt.value = "";
                        isExist('');
                        itemInit();
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

                    itemInit();
                    isExist(txt.value);
                    return false;
                }
            }
        }

        function itemInit() {
            if (!txtId.includes('grdTable_grd_txt_itemName_')) return;

            var grid = document.getElementById('<%= grdTable.ClientID%>');

            document.getElementById('grdTable_grd_hdn_virtualItemCode_' + selectRow).value = '';
            //document.getElementById('grdTable_hidden_keyWord1_' + selectRow).value = '';
            document.getElementById('grdTable_grd_txt_itemName2_' + selectRow).value = '';
            document.getElementById('grdTable_grd_hdn_actualItemCode_' + selectRow).value = '';
            //document.getElementById('grdTable_hidden_keyWord2_' + selectRow).value = '';
            document.getElementById('grdTable_grd_txt_orderQty_' + selectRow).value = '';
            document.getElementById('grdTable_grd_txt_unitprice_' + selectRow).value = '';
            document.getElementById('grdTable_hdn_weight_' + selectRow).value = '';
            document.getElementById('grdTable_grd_txt_totalWeight_' + selectRow).value = '';

            grid.rows[selectRow].cells[0].innerHTML = '';
            grid.rows[selectRow].cells[3].innerHTML = '';
            grid.rows[selectRow].cells[4].innerHTML = '';
            grid.rows[selectRow].cells[8].innerHTML = '0';

            totalSum();
        }


        list_Focus_Out_Event();
    </script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btn_default">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>주문등록</span>
                <asp:HiddenField ID="hdn_value" runat="server" />
                <asp:Button ID="btn_default" runat="server" OnClientClick="return false;" CssClass="hidden" />
            </div>
        </div>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:ScriptManager runat="server"></asp:ScriptManager>
                <asp:HiddenField ID="hidden_weight_Al" runat="server" />
                <asp:HiddenField ID="hidden_weight_Pet" runat="server" />
                <asp:HiddenField ID="hidden_weight_Pp" runat="server" />
                <asp:HiddenField ID="hidden_cus_Decimal" runat="server" />
                <asp:Button ID="btn_itemInfoSetting" runat="server" CssClass="hidden" OnClick="btn_itemInfoSetting_Click" />
                <table class="itable_1 mt10">
                    <tobody>
                        <tr>
                            <th>주문번호</th>
                            <td>
                                <asp:Label ID="txt_ordernum" runat="server" CssClass="ml10"></asp:Label>
                            </td>
                            <th>주문일<span class="red vam"> *</span></th>
                            <td>
                                <asp:TextBox ID="txt_orderdate" autocomplete="off" runat="server" CssClass="w80p"></asp:TextBox>
                            </td>
                            <th>납기일<span class="red vam"> *</span></th>
                            <td>
                                <asp:TextBox ID="txt_deliverydate" autocomplete="off" runat="server" CssClass="w80p"></asp:TextBox>
                            </td>
                            <th>오전납기</th>
                            <td class="tac">
                                <asp:CheckBox ID="chk_morning" runat="server"></asp:CheckBox>
                            </td>
                        </tr>
                        <tr>
                            <th>거래처명<span class="red vam"> *</span></th>
                            <td>
                                <asp:DropDownList ID="cb_cusname" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cb_cusname_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                            <th>대표연락처</th>
                            <td>
                                <asp:Label CssClass="ml5" ID="txt_bosscall" runat="server"></asp:Label>
                            </td>
                            <th>대표이메일</th>
                            <td>
                                <asp:Label CssClass="ml5" ID="txt_bossmail" runat="server"></asp:Label>
                            </td>
                            <th>팩스</th>
                            <td>
                                <asp:Label CssClass="ml5" ID="txt_fax" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th>담당자</th>
                            <td>
                                <asp:DropDownList ID="cb_manager" runat="server"></asp:DropDownList>
                            </td>
                            <th>배송지</th>
                            <td>
                                <asp:DropDownList ID="cb_address" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cb_address_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                            <th colspan="3">거래명세표 가격표시</th>
                            <td class="tac">
                                <asp:CheckBox ID="chk_taxbill" runat="server"></asp:CheckBox>
                            </td>
                        </tr>
                        <tr>
                            <th>참고사항</th>
                            <td colspan="7">
                                <asp:TextBox ID="txt_memo" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                </table>
                <div class="title_1 mt20">
                    주문품목
                <asp:ListBox ID="li_itemlist" runat="server" CssClass="autoComplete_list" Style="top:0px; left:0px; visibility: hidden;"></asp:ListBox>

                    <div class="tar">
                        <asp:Button ID="tb_itemadd" runat="server" CssClass="btn_150_40 btn_navy" Text="품목추가" OnClientClick="if(!cusCodeChk()) return false;" OnClick="tb_itemadd_Click"></asp:Button>
                        <asp:Button ID="btn_delete" runat="server" CssClass="hidden" OnClick="btn_delete_Click" />
                        <asp:HiddenField ID="hidden_deleteIdx" runat="server" />
                        <asp:HiddenField ID="hidden_selectedRow" runat="server" />
                    </div>
                </div>
                <div class="fixed_hs_300 mt10" style="width: 1317px;">
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt7p">제품코드</th>
                                <th class="mWt20p">제품명</th>
                                <th class="mWt20p">실제품명</th>
                                <th class="mWt5p">단위</th>
                                <th class="mWt5p">재고</th>
                                <th class="mWt8p">주문수량</th>
                                <th class="mWt7p">중량</th>
                                <th class="mWt10p">단가</th>
                                <th class="mWt8p">금액</th>
                                <th class="mWt4p">영세</th>
                                <th class="mWt6p">삭제</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="11">
                                    <div style="height: 225px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                        <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1317">
                                            <HeaderStyle Height="25px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="" Visible="false">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="0%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="" Visible="false">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="0%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="7%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hidden_keyWord1" runat="server" />
                                                        <asp:TextBox ID="grd_txt_itemName" runat="server" autocomplete="off"></asp:TextBox>
                                                        <asp:HiddenField ID="grd_hdn_virtualItemCode" runat="server" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hidden_keyWord2" runat="server" />
                                                        <asp:TextBox ID="grd_txt_itemName2" runat="server" autocomplete="off"></asp:TextBox>
                                                        <asp:HiddenField ID="grd_hdn_actualItemCode" runat="server" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="5%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="5%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="grd_txt_orderQty" runat="server"  CssClass="tar"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="8%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="grd_txt_totalWeight" runat="server"  CssClass="tar"></asp:TextBox>
                                                        <asp:HiddenField ID="hdn_weight" runat="server" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="7%" CssClass="tar" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="grd_txt_unitprice" runat="server" CssClass="tar"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="10%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="8%" CssClass="tar" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:CheckBox ID="chk_taxFree" runat="server" CssClass="tac"/>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="4%"/>
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemTemplate>
                                                        <asp:Button ID="grd_btn_del" runat="server" CssClass="btn_50_20 btn_red" Text="삭제"></asp:Button>
                                                        <asp:HiddenField ID="hdn_cud" runat="server" />
                                                    </ItemTemplate>
                                                    <ItemStyle Width="6%" CssClass="" />
                                                </asp:TemplateColumn>
                                            </Columns>
                                        </asp:DataGrid>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <table class="itable_1 mt10">
                    <tobody>
                        <tr>
                            <th>공급가</th>
                            <td>
                                <asp:TextBox ID="txt_supplyprice" runat="server" CssClass="lblTextBox"></asp:TextBox>
                            </td>
                            <th>부가세</th>
                            <td>
                                <asp:TextBox ID="txt_vat" runat="server" CssClass="lblTextBox"></asp:TextBox>
                            </td>
                            <th>총중량</th>
                            <td>
                                <asp:TextBox ID="txt_totalWeight" runat="server" CssClass="lblTextBox"></asp:TextBox>
                            </td>
                            <th>총금액</th>
                            <td>
                                <asp:TextBox ID="txt_totalamount" runat="server" CssClass="lblTextBox"></asp:TextBox>
                            </td>
                        </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="tar mt20">
            <asp:Button ID="btn_save" Text="저장" CssClass="btn_150_40 btn_black" runat="server" OnClick="btn_save_Click" />
            <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">목록</button>
        </div>
        <script>
            fDatePickerById("txt_orderdate");
            fDatePickerById("txt_deliverydate");

            var prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_pageLoaded(panelLoaded);
            function panelLoaded(sender, args) {
                fDatePickerById("txt_orderdate");
                fDatePickerById("txt_deliverydate");
                calcTotalPrice_All();
            }

            function cusCodeChk() {
                var select = document.getElementById('<%= cb_cusname.ClientID %>');
                var option = select.options[select.selectedIndex];

                if (option.value == '') {
                    alert('거래처를 선택해 주십시오.');
                    return false;
                }
                else {
                    return true;
                }
            }

            //중량계산
            function calcweight(row) {
                var grd = document.getElementById('<%= grdTable.ClientID%>');
                var originWeigth = document.getElementById('grdTable_hdn_weight_' + row).value;
                var qty = document.getElementById('grdTable_grd_txt_orderQty_' + row).value;
                var weight = document.getElementById('grdTable_grd_txt_totalWeight_' + row);

                var result = parseFloat(qty) * parseFloat(originWeigth);
                if (!qty || !originWeigth) result = 0;

                weight.value = (result).toFixed(2);
            }

            //합계계산 - 모든 row 
            function calcTotalPrice_All() {
                var grd = document.getElementById('<%= grdTable.ClientID%>');

                if (!grd) return false;

                var rowCount = grd.rows.length;

                if (rowCount == 0) return false;

                for (var i = 0; i < rowCount; i++) {
                    var qty = document.getElementById('grdTable_grd_txt_orderQty_' + i).value;
                    var unitprice = document.getElementById('grdTable_grd_txt_unitprice_' + i).value;
                    var weight = document.getElementById('grdTable_grd_txt_totalWeight_' + i).value;
                    let taxfree = document.getElementById('grdTable_chk_taxFree_' + i);
                    let tax = 0;

                    var result = 0;

                    if (!qty || !unitprice || !weight) {
                        result = 0;
                    }
                    else {
                        if (!taxfree.checked) {
                            tax = parseFloat(weight) * parseFloat(unitprice) / 10;
                        }

                        result = parseFloat(weight) * parseFloat(unitprice) + tax;
                    }

                    grd.rows[i].cells[8].innerHTML = Math.trunc(result);
                }

                totalSum();
            }


            //합계계산
            function calcTotalPrice(row) {
                var grd = document.getElementById('<%= grdTable.ClientID%>');
                var originWeigth = document.getElementById('grdTable_grd_txt_totalWeight_' + row).value;
                var qty = document.getElementById('grdTable_grd_txt_orderQty_' + row).value;
                var unitprice = document.getElementById('grdTable_grd_txt_unitprice_' + row).value
                let taxfree = document.getElementById('grdTable_chk_taxFree_' + row);
                let tax = 0;

                var result = 0;

                if (!qty || !unitprice) {
                    result = 0;
                }
                else {
                    if (!taxfree.checked) {
                        tax = parseFloat(originWeigth) * parseFloat(unitprice) / 10;
                    }

                    result = parseFloat(originWeigth) * parseFloat(unitprice) + tax;
                }

                grd.rows[row].cells[8].innerHTML = Math.trunc(result);

                totalSum();
            }

            //하단 공급가,부가세,총중량,총금액 계산
            function totalSum() {
                var grd = document.getElementById('<%= grdTable.ClientID%>');
                var rowCount = grd.rows.length;
                var totalWeight = 0;
                var totalPrice = 0;
                let totalVat = 0;

                for (var i = 0; i < rowCount; i++) {
                    var weight = document.getElementById('grdTable_grd_txt_totalWeight_' + i).value;
                    let taxfree = document.getElementById('grdTable_chk_taxFree_' + i);

                    var price = grd.rows[i].cells[8].innerHTML;

                    if (weight != "") {
                        totalWeight += parseFloat(weight)
                    }

                    if (!taxfree.checked) {
                        totalVat += parseFloat(price / 11);
                        totalPrice += parseFloat(price) / 1.1;
                    }
                    else {
                        totalPrice += parseFloat(price);
                    }
                }

                var supply = Math.round(totalPrice);
                var tax = Math.round(totalVat);

                var total = totalPrice + tax;

                document.getElementById('<%= txt_supplyprice.ClientID%>').value = supply;
                document.getElementById('<%= txt_vat.ClientID%>').value = tax;
                document.getElementById('<%= txt_totalWeight.ClientID%>').value = totalWeight.toFixed(2);
                document.getElementById('<%= txt_totalamount.ClientID%>').value = total;
            }

            function change_cud(num) {
                var cud = document.getElementById('grdTable_hdn_cud_' + num);
                if (cud.value != "c" && cud.value != "u") cud.value = "u";
            }

            function deleteRow(row) {
                document.getElementById('<%= hidden_selectedRow.ClientID%>').value = row;
                document.getElementById('<%= btn_delete.ClientID%>').click();
            }

        </script>
    </form>
</body>
</html>
