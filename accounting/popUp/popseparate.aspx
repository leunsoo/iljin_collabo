<%@ Page Language="C#" EnableEventValidation="false" AutoEventWireup="true" CodeBehind="popseparate.aspx.cs" Inherits="iljin.popUp.popseparate" %>

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
    <style>
        table.taxTable > tbody > tr > td {
            padding: 6px;
            vertical-align: middle;
            text-align: center;
            color: #666;
            line-height: 1.2;
            font-size: 13px;
            font-weight: 300;
            border: 1px solid #dfdfdf;
            border-bottom: 1px solid #ccc;
            word-break: break-all;
        }
    </style>
    <script type="text/javascript">
        let listId = 'li_itemlist';
        let txtId = '';
        let param = '';
        let hdnId = '';
        let div = '';

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
                    let result = JSON.parse(XHR.responseText);
                    let list = document.getElementById(listId);
                    let txt = document.getElementById(txtId);
                    let i;

                    for (let optCnt = list.options.length - 1; optCnt >= 0; optCnt--) {
                        list.options.remove(optCnt);
                    }

                    for (i = 0; i < result.length; i++) {
                        let element = document.createElement("option");

                        element.text = result[i].name;
                        element.value = result[i].code;
                        list.add(element);

                        element.addEventListener("click", function (e) {
                            txt.value = e.target.innerHTML;
                            list.style.visibility = "hidden";
                            document.getElementById(hdnId).value = list.value;
                            if (hdnId.includes('hdn_cusCode')) {
                                document.getElementById('btn_customerInfoSetting').click();
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
                let txt = document.getElementById(txtId);
                let li = document.getElementById(listId);

                if (!li) return;

                if (li.style.visibility == "visible") {
                    let target = e.target;
                    if (target.parentElement != li && target != txt) {
                        li.style.visibility = "hidden"
                    }
                }
            }
            )
        }

        function listBoxOn(list) {

            let itemCount = list.options.length;
            let itemHeight = (list.options[0].clientHeight + 1);
            let txt = document.getElementById(txtId);

            list.style.visibility = "visible";

            if (itemCount > 10) itemCount = 10;

            let height = (itemHeight * itemCount + 1) + "px";
            list.style.height = height;
            let listTop = (txt.getBoundingClientRect().top + 30 + window.pageYOffset) + "px";
            let listLeft = (txt.getBoundingClientRect().left + window.pageXOffset) + "px";
            list.style.top = listTop;
            list.style.left = listLeft;
            list.style.width = txt.offsetWidth + "px";
        }

        function visibleChk(_div) {
            let hidden_keyWord = document.getElementById('<%= hidden_keyWord.ClientID%>');

            if (div != _div) {
                hidden_keyWord.value = '';
            }

            div = _div;
            if (div == '1') //제품
            {
                txtId = 'txt_itemName';
                hdnId = 'hdn_itemCode';
            }
            else //거래처
            {
                txtId = 'txt_customer';
                hdnId = 'hdn_cusCode';
            }

            let txt = document.getElementById(txtId);
            let li = document.getElementById('<%=li_itemlist.ClientID%>');

            let lastChar = txt.value.charAt(txt.value.length - 1);

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
                let txt = document.getElementById(txtId);
                let hidden_keyWord = document.getElementById('<%= hidden_keyWord.ClientID%>');
                let lastChar = txt.value.charAt(txt.value.length - 1);

                if (lastChar != "|") {
                    txt.value += "|";
                    hidden_keyWord.value = txt.value;
                    isExist(txt.value);
                }
            }
        }

        function KeyDownEvent() {
            if (event.keyCode == 8) {
                let txt = document.getElementById(txtId);
                let hidden_keyWord = document.getElementById('<%= hidden_keyWord.ClientID%>');
                document.getElementById(hdnId).value = '';

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
                let lastChar = txt.value.charAt(txt.value.length - 1);

                //마지막 글자가 |이 아닐때 => 키워드 삭제가 아닌 입력하고 있던 글자 삭제
                if (lastChar != "|") return false;

                //마지막 글자가 |일때 => 키워드가 있다는 것, hidden_keyWord에서 저장된 키워드 1개 삭제 후 txt.value로 전달
                // case => 2
                // case:1 => 키워드가 1개 일 시 하나만 공란으로 만들어 주기
                // case:2 => 키워드가 n개 일 시 이전 | 이후 문자열 삭제 아니면 split? 후??
                if (lastChar == "|") {
                    let txtArr = hidden_keyWord.value.split('|');
                    txt.value = "";
                    let i = 0;

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
    <form id="form1" runat="server" defaultbutton="btn_default" class="mb10">
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:ScriptManager runat="server"></asp:ScriptManager>
                <div class="pop_wrap">
                    <div class="pop_title">
                        <span>세금계산서 별도 발행</span>
                        <asp:HiddenField ID="hdn_serialNo" runat="server" />
                        <asp:HiddenField ID="hdn_cusCode" runat="server" />
                        <asp:HiddenField ID="hidden_keyWord" runat="server" />
                        <asp:HiddenField ID="hdn_itemCode" runat="server" />
                        <asp:HiddenField ID="hdn_selectedRow" runat="server" />
                        <asp:HiddenField ID="hdn_wpPrice" runat="server" />
                        <asp:HiddenField ID="hdn_wtPrice" runat="server" />
                        <asp:Button ID="btn_deleteRow" runat="server" CssClass="hidden" OnClick="btn_deleteRow_Click" />
                        <asp:Button ID="btn_customerInfoSetting" runat="server" OnClick="btn_customerInfoSetting_Click" CssClass="hidden" />
                        <asp:ListBox ID="li_itemlist" runat="server" CssClass="autoComplete_list" Style="top: 0px; left: 0px; visibility: hidden;"></asp:ListBox>
                    </div>
                </div>
                <table class="itable_1 mt10">
                    <tobody>
                        <tr>
                            <th>일련번호</th>
                            <td>
                                <asp:Label ID="txt_serialNo" runat="server"></asp:Label>
                            </td>
                            <th>작성일자</th>
                            <td>
                                <asp:TextBox ID="txt_registrationdate" runat="server" CssClass="w85p"></asp:TextBox>
                            </td>
                            <th>거래처</th>
                            <td>
                                <asp:TextBox ID="txt_customer" runat="server" onkeydown="KeyDownEvent();" onclick="visibleChk('2');" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <th>청구/영수</th>
                            <td>
                                <asp:DropDownList ID="cb_billtypecode" runat="server"></asp:DropDownList>
                            </td>
                            <th>영세</th>
                            <td class="tac">
                                <asp:CheckBox ID="chk_taxfree" runat="server" onchange="taxFree();" />
                            </td>
                            <th>수정사유</th>
                            <td>
                                <asp:DropDownList ID="cb_updateReason" runat="server"/>
                            </td>
                        </tr>
                </table>
                <div class="tar mt10">
                    <asp:Button ID="btn_itemadd" runat="server" CssClass="btn_150_40 btn_navy" Text="품목추가" OnClientClick="if(!itemCheck()) {return false;}" OnClick="btn_itemadd_Click" />
                </div>
                <div class="mt10" style="height: 90px;">
                    <table class="grtable_th taxTable">
                        <thead>
                            <tr>
                                <th class="mWt25p">품목</th>
                                <th class="mWt10p">수량</th>
                                <th class="mWt15p">단가</th>
                                <th class="mWt20p">공급가액</th>
                                <th class="mWt10p">세액</th>
                                <th class="mWt20p">합계</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txt_itemName" runat="server" onkeydown="KeyDownEvent();" onclick="visibleChk('1');" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_itemQty" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_unitprice" runat="server"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_producePrice" runat="server" onchange="calcPrice();"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_costPrice" runat="server" CssClass="lblTextBox"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:TextBox ID="txt_totalPrice" runat="server" CssClass="lblTextBox"></asp:TextBox>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <table class="itable_1 mt10">
                    <tbody>
                        <tr>
                            <th rowspan="7" style="background-color: lightpink; color: red" class="tar">공<br />
                                급<br />
                                자</th>
                            <th style="color: red">등록번호</th>
                            <td>
                                <asp:Label ID="txt_registration1" runat="server"></asp:Label></td>
                            <th style="color: red">종사업장번호</th>
                            <td>
                                <asp:Label ID="txt_businessNo1" runat="server"></asp:Label></td>
                            <th rowspan="7" style="background-color: skyblue; color: steelblue" class="tar">공<br />
                                급<br />
                                받<br />
                                는<br />
                                자<br />
                            </th>
                            <th style="color: steelblue; background-color: aliceblue">등록번호</th>
                            <td>
                                <asp:TextBox ID="txt_registration2" runat="server"></asp:TextBox></td>
                            <th style="color: steelblue; background-color: aliceblue">종사업장번호</th>
                            <td>
                                <asp:TextBox ID="txt_businessNo2" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th style="color: red">상호</th>
                            <td>
                                <asp:Label ID="txt_cusName1" runat="server"></asp:Label></td>
                            <th style="color: red">성명</th>
                            <td>
                                <asp:Label ID="txt_bossname1" runat="server"></asp:Label></td>
                            <th style="color: steelblue; background-color: aliceblue">상호</th>
                            <td>
                                <asp:TextBox ID="txt_cusName2" runat="server"></asp:TextBox></td>
                            <th style="color: steelblue; background-color: aliceblue">성명</th>
                            <td>
                                <asp:TextBox ID="txt_bossname2" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th style="color: red">사업장</th>
                            <td colspan="3">
                                <asp:Label ID="txt_address" runat="server"></asp:Label>
                            </td>
                            <th style="color: steelblue; background-color: aliceblue">사업장</th>
                            <td colspan="3">
                                <asp:TextBox ID="txt_address2" runat="server" CssClass="w75p"></asp:TextBox>
                                <asp:Button ID="btn_address2" runat="server" CssClass="btn_navy btn_80_30 ml10" Text="주소변경" OnClientClick="OpenZipcode(); return false;" />
                            </td>
                        </tr>
                        <tr>
                            <th style="color: red">업태</th>
                            <td>
                                <asp:Label ID="txt_business1" runat="server"></asp:Label>
                                <th style="color: red">종목</th>
                                <td>
                                    <asp:Label ID="txt_businessitem" runat="server"></asp:Label></td>
                                <th style="color: steelblue; background-color: aliceblue">업태</th>
                                <td>
                                    <asp:TextBox ID="txt_business2" runat="server"></asp:TextBox>
                                    <th style="color: steelblue; background-color: aliceblue">종목</th>
                                    <td>
                                        <asp:TextBox ID="txt_businessitem2" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th style="color: red">이메일</th>
                            <td colspan="3">
                                <asp:Label ID="txt_email" runat="server"></asp:Label></td>
                            <th style="color: steelblue; background-color: aliceblue">이메일</th>
                            <td colspan="3">
                                <asp:TextBox ID="txt_email2" runat="server"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <th style="color: red">담당자</th>
                            <td>
                                <asp:Label ID="txt_manager" runat="server"></asp:Label></td>
                            <th style="color: red">휴대폰</th>
                            <td>
                                <asp:Label ID="txt_phone" runat="server"></asp:Label></td>
                            <th style="color: steelblue; background-color: aliceblue">담당자<span class="red vam"> *</span></th>
                            <td>
                                <asp:TextBox ID="txt_manager2" runat="server"></asp:TextBox></td>
                            <th style="color: steelblue; background-color: aliceblue">휴대폰</th>
                            <td>
                                <asp:TextBox ID="txt_phone2" runat="server"></asp:TextBox></td>
                        </tr>
                    </tbody>
                </table>
                <div class="mt10">
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt8p">작성일자</th>
                                <th class="mWt20p">품목</th>
                                <th class="mWt12p">수량</th>
                                <th class="mWt12p">단가</th>
                                <th class="mWt14p">공급가액</th>
                                <th class="mWt12p">세액</th>
                                <th class="mWt14p">합계</th>
                                <th class="mWt8p"></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="8">
                                    <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff">
                                        <HeaderStyle Height="25px" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="" Visible="false">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="0%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="8%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="20%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="12%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="12%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="14%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="12%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="14%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                                    <asp:Button ID="btn_del" runat="server" Text="삭제" CssClass="btn_60_25 btn_red" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="8%" CssClass="" />
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <asp:Button ID="btn_default" runat="server" OnClientClick="return false;" CssClass="hidden" />
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="mt10">
            <span style="border: 1px solid black; padding: 1px 18px 1px 18px; font-size: 20px; vertical-align: middle; background-color: #f2f2f2">제품명</span>
            <asp:TextBox ID="txt_title" runat="server" Style="border: 1px solid black; border-radius: 0px; padding: 0px 10px 1px 10px; width: 600px; height: 33px; font-size: 20px;"></asp:TextBox>
            <span style="border: 1px solid black; padding: 1px 18px 1px 18px; font-size: 20px; vertical-align: middle; background-color: #f2f2f2; margin-left: 10px;">총금액</span>
            <asp:TextBox ID="txt_wholePrice" runat="server" Style="border: 1px solid black; border-radius: 0px; padding: 0px 10px 1px 10px; width: 300px; height: 33px; font-size: 20px;"></asp:TextBox>
        </div>
        <div class="tar mt15 mb10">       
            <button type="button" class="btn_150_40 btn_gray" onclick="self.close()">취소</button>
            <asp:Button ID="btn_save" runat="server" CssClass="btn_150_40 btn_black ml10" Text="저장" OnClick="btn_save_Click" />
            <asp:Button ID="btn_send" Text="전송" CssClass="btn_150_40 btn_navy ml10" runat="server" OnClick="btn_send_Click" /> 
        </div>
        <script src="//spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
        <script>
            // 우편번호 - 주소
            function OpenZipcode() {
                daumAPIFunc();
            }

            let prm = Sys.WebForms.PageRequestManager.getInstance();
            prm.add_pageLoaded(panelLoaded);
            function panelLoaded(sender, args) {
                fDatePickerById("txt_registrationdate");
                taxFree();
                calcTotalPrice();
            }

            // 주소관련 시작
            //팝업 위치를 지정(화면의 가운데 정렬)
            let width = 500; //팝업의 너비
            let height = 600; //팝업의 높이

            var daumAPIFunc = function () {
                new daum.Postcode({
                    width: width, //생성자에 크기 값을 명시적으로 지정해야 합니다.
                    height: height,
                    oncomplete: function (data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                        // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        let fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                        let extraRoadAddr = ''; // 도로명 조합형 주소 변수

                        // 법정동명이 있을 경우 추가한다.
                        if (data.bname !== '') {
                            extraRoadAddr += data.bname;
                        }
                        // 건물명이 있을 경우 추가한다.
                        if (data.buildingName !== '') {
                            extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                        if (extraRoadAddr !== '') {
                            extraRoadAddr = ' (' + extraRoadAddr + ')';
                        }
                        // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                        if (fullRoadAddr !== '') {
                            //fullRoadAddr += extraRoadAddr;
                        }

                        focusDdata(data, fullRoadAddr, extraRoadAddr);
                    }
                }).open({
                    left: (window.screen.width / 2) - (width / 2),
                    top: (window.screen.height / 2) - (height / 2),
                    popupName: 'Road_Search' //팝업 이름을 설정(영문,한글,숫자 모두 가능, 영문 추천)
                });
            };

            var focusDdata = function (data, fullRoadAddr, extraRoadAddr) {
                /* 새로운 우편번호로 인하여 추가(S) */
                /* 2015-08-01부터 시행될 우편번호 변수 처리 zonecode => 13494 */
                try {
                    document.getElementById('<%= txt_address2.ClientID%>').value = fullRoadAddr + " / " + extraRoadAddr;
                    //$("input[name='ctl00$ContentPlaceHolder2$txt_com_post']").val(data.zonecode);
                    //$("input[name='ctl00$ContentPlaceHolder2$txt_com_addr']").val(fullRoadAddr);
                    //$("input[name='ctl00$ContentPlaceHolder2$txt_com_addr2']").val(extraRoadAddr);
                } catch (e) { }

            };

            function itemCheck() {
                let code = document.getElementById('<%= hdn_itemCode.ClientID%>').value;
                if (!code) {
                    alert('제품을 선택해 주십시오.');
                    return false;
                }
                return true;
            }

            function calcPrice() {
                price = document.getElementById('<%= txt_producePrice.ClientID%>').value;
                tax = document.getElementById('<%= txt_costPrice.ClientID%>');
                total = document.getElementById('<%= txt_totalPrice.ClientID%>');


                if (!price) {
                    tax.value = '0';
                    total.value = '0';
                    return;
                }

                tax.value = parseInt(parseInt(price) / 10);
                total.value = parseInt(price) + parseInt(tax.value);
            }

            function deleteRow(selectedRow) {
                document.getElementById('<%= hdn_selectedRow.ClientID %>').value = selectedRow;
                document.getElementById('<%= btn_deleteRow.ClientID %>').click();
            }

            function taxFree() {
                let checkValue = document.getElementById('<%= chk_taxfree.ClientID%>').checked;
                let prodValue = document.getElementById('<%= txt_producePrice.ClientID%>').value;
                let tax = document.getElementById('<%= txt_costPrice.ClientID%>');
                let total = document.getElementById('<%= txt_totalPrice.ClientID%>');
                let grd = document.getElementById('<%= grdTable.ClientID %>');

                if (checkValue == true) {
                    tax.style.visibility = 'hidden';

                    total.value = prodValue;

                    if (!grd) return;
                    let rowCount = grd.rows.length;

                    for (let i = 0; i < rowCount; i++) {
                        grd.rows[i].cells[5].innerHTML = '';
                        grd.rows[i].cells[6].innerHTML = grd.rows[i].cells[4].innerHTML;
                    }
                }
                else {
                    tax.style.visibility = "visible";

                    if (!prodValue) {
                        tax.value = '';
                        total.value = '';
                    }
                    else {
                        tax.value = parseInt(parseInt(prodValue) / 10);
                        total.value = parseInt(prodValue) + parseInt(tax.value);
                    }

                    if (!grd) return;
                    let rowCount = grd.rows.length;

                    for (let i = 0; i < rowCount; i++) {
                        let grdPrice = grd.rows[i].cells[4].innerHTML;

                        if (!grdPrice) continue;

                        grd.rows[i].cells[5].innerHTML = parseInt(parseInt(grdPrice) / 10);
                        grd.rows[i].cells[6].innerHTML = parseInt(grdPrice) + parseInt(grd.rows[i].cells[5].innerHTML);
                    }
                }

                calcTotalPrice();
            }

            function calcTotalPrice() {
                let grid = document.getElementById('<%= grdTable.ClientID%>');
                if (!grid) return;

                let rowCount = grid.rows.length;
                let totalPrice = 0;
                let chk = document.getElementById('<%= chk_taxfree.ClientID%>').checked;
                let p = 0;
                let p1 = 0;
                let p2 = 0;

                for (let i = 0; i < rowCount; i++) {
                    p = parseInt(grid.rows[i].cells[6].innerHTML);
                    if (p) totalPrice += p;

                    p = parseInt(grid.rows[i].cells[4].innerHTML);
                    if (p) p1 += p;

                    p = parseInt(grid.rows[i].cells[5].innerHTML);
                    if (p) p2 += p;
                }

                document.getElementById('<%= hdn_wpPrice.ClientID%>').value = p1;
                document.getElementById('<%= hdn_wtPrice.ClientID%>').value = p2;
                document.getElementById('<%= txt_wholePrice.ClientID%>').value = totalPrice;
            }
	        // 주소관련 끝
        </script>
    </form>
</body>
</html>

