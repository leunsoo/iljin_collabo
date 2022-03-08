<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="poppurchase.aspx.cs" Inherits="iljin.popUp.poppurchase" %>

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
    <link rel="stylesheet" type="text/css" href="/webapp/css/popUp.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/ibuild.css" />
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
            var param = '';

            if (selectRow < 0) {
                param = "keyward=" + value + "&div=customer&caseNo=매입";
            }
            else {
                param = "keyward=" + value + "&div=item";
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
                            document.getElementById('hdn_selectedRow').value = selectRow;
                            document.getElementById(hdnId).value = list.value;

                            if (selectRow > -1) {
                                document.getElementById('btn_itemInfoSetting').click();
                                
                                var cud = document.getElementById('grdTable_hdn_cud_' + selectRow);
                                if (cud) {
                                    if (cud.value != "c" && cud.value != "u") cud.value = "u";
                                }
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
            var listTop = (txt.getBoundingClientRect().top + 31) + "px";
            var listLeft = txt.getBoundingClientRect().left + "px";

            list.style.top = listTop;
            list.style.left = listLeft;
            list.style.width = txt.offsetWidth + "px";
        }

        function visibleChk(row) {

            if (row < 0) {
                txtId = 'txt_cusname';
                hdnId = 'hidden_cusCode';
                hdnkeyward = 'hidden_keyWord';
            }
            else {
                txtId = 'grdTable1_txt_itemname_' + row;
                hdnId = 'grdTable1_hidden_itemCode_' + row;
                hdnkeyward = 'grdTable1_hidden_keyWord1_' + row;
            }

            selectRow = row;
             
            var txt = document.getElementById(txtId);
            var hidden_keyWord = document.getElementById(hdnkeyward);
            var li = document.getElementById('<%=li_itemlist.ClientID%>');
            //document.getElementById(hdnId).value = '';
            document.getElementById('hdn_selectedRow').value = selectRow;

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

                if (txt.value == '') {
                    isExist(txt.value);
                    return false;
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
                var hidden_keyWord = document.getElementById(hdnkeyward);
                document.getElementById(hdnId).value = '';
                itemInfoInit(selectRow, '');
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
                        isExist('');
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

        function itemInfoInit(row, text) {
            let grid = document.getElementById('<%= grdTable1.ClientID%>');

            if (row > -1) {

                grid.rows[row].cells[1].innerText = "";
                grid.rows[row].cells[2].innerText = "";
                grid.rows[row].cells[3].innerText = "";
                grid.rows[row].cells[4].innerText = "";
                grid.rows[row].cells[5].innerText = "";
                //if (text == '') {
                //    for (var i = 1; i < 5; i++) {
                //        var txt = document.getElementById('grdTable1_t' + i + '_' + row);
                //        txt.value = '';
                //    }
                //}
            }
        }

        list_Focus_Out_Event();
    </script>
</head>
<body style="height:auto">
    <form id="form1" runat="server" defaultbutton="btn_default">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>구매등록</span><span id="txt_warning" runat="server" style="color:red"></span>
                <asp:Button ID="btn_default" runat="server" OnClientClick="return false;"  CssClass="hidden"/>
                <asp:HiddenField ID="hdn_idx" runat="server" />
                <asp:HiddenField ID="hidden_keyWord" runat="server" />
                <asp:HiddenField ID="hidden_cusCode" runat="server" />
                <asp:HiddenField ID="hidden_chkUpdate" runat="server" />
                <asp:ListBox ID="li_itemlist" runat="server" Style="top: 0px; left: 0px; visibility: hidden;" CssClass="autoComplete_list"></asp:ListBox>
            </div>
        </div>
        <div class="title_1 mt20">
            * 계약정보
        </div>
        <table class="itable_1 mt10">
            <tobody>
                <tr>
                    <th>거래처명</th>
                    <td>
                        <asp:TextBox ID="txt_cusname" runat="server" onkeydown="KeyDownEvent();" onclick="visibleChk(-1);" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                    </td>
                    <th>계약번호<span class="red vam"> *</span></th>
                    <td>
                        <asp:TextBox ID="txt_contractno" runat="server"></asp:TextBox>
                    </td>
                    <th>L/C번호</th>
                    <td>
                        <asp:TextBox ID="txt_lcNo" runat="server"></asp:TextBox>
                    </td>
                    <th>계약일</th>
                    <td>
                        <asp:TextBox ID="txt_contractdate" runat="server" CssClass="w85p" autocomplete="off"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td>
                        <asp:TextBox ID="txt_title" runat="server"></asp:TextBox>
                    </td>
                    <th>가격</th>
                    <td>
                        <asp:TextBox ID="txt_price" runat="server" ></asp:TextBox>
                    </td>
                    <th>출발예정일</th>
                    <td>
                        <asp:TextBox ID="txt_arrivaldate" runat="server" CssClass="w85p" autocomplete="off"></asp:TextBox>
                    </td>
                    <th>수량</th>
                    <td>
                        <asp:TextBox ID="txt_qty" runat="server" onchange="Paste_TotalWeight();"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>담당직원</th>
                    <td>
                        <asp:DropDownList ID="cb_manager" runat="server"></asp:DropDownList>
                    </td>
                    <th>T/T</th>
                    <td>
                        <asp:CheckBox ID="chk_tt" runat="server" CssClass="ml100" />
                    </td>
                    <th>샘플</th>
                    <td>
                        <asp:CheckBox ID="chk_sample" runat="server" CssClass="ml100" />
                    </td>
                    <th>문서보기</th>
                    <td>
                        <asp:Button ID="btn_look" runat="server" CssClass="btn_navy btn_80_30 ml15" Text="보기" OnClientClick="showimage(); return false;" />
                        <asp:Button ID="btn_upload" runat="server" CssClass="btn_gray btn_80_30 ml10" Text="업로드" OnClientClick="document_reg(); return false;" />
                        <asp:HiddenField ID="hdn_filePath" runat="server" />
                        <asp:Button ID="btn_imgTemp" runat="server" CssClass="hidden" OnClick="btn_imgTemp_Click"/>
                        <asp:FileUpload ID="fl_document_input" runat="server" class="hidden" accept="image/*"/>
                    </td>
                </tr>
                <tr>
                    <th>계약금액</th>
                    <td>
                        <asp:TextBox ID="txt_contractprice" runat="server" onchange="Paste_TotalPrice();"></asp:TextBox>
                    </td>
                    <th>등록일</th>
                    <td>
                        <asp:TextBox ID="txt_registrationdate" runat="server"  CssClass="w85p"/>
                    </td>
                    <th></th>
                    <td></td>
                    <th></th>
                    <td></td>
                </tr>
                <tr>
                    <th>메모</th>
                    <td colspan="7">
                        <asp:TextBox ID="txt_memo" runat="server"></asp:TextBox>
                    </td>

                </tr>
        </table>
        <div class="title_1 mt20">
        </div>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:ScriptManager runat="server"></asp:ScriptManager>
                <div>
                    <span class=" title_1">* 구매품목</span>  
                    <asp:Button ID="btn_add" runat="server" CssClass="btn_navy ft_right btn_100_30" Text="품목추가" OnClick="btn_add_Click" />
                    <asp:Button ID="btn_grd_delete" runat="server" CssClass="hidden" OnClick="btn_grd_delete_Click" />
                    <asp:HiddenField ID="hdn_selectedRow" runat="server" />
                    <asp:Button ID="btn_itemInfoSetting" runat="server" CssClass="hidden" OnClick="btn_itemInfoSetting_Click" />
                </div>
                <div class="mt20" style="width:auto; height:auto;">
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt23p">제품명</th>
                                <th class="mWt9p">제품구분1</th>
                                <th class="mWt9p">제품구분2</th>
                                <th class="mWt8p">두께</th>
                                <th class="mWt8p">폭</th>
                                <th class="mWt8p">길이</th>
                                <th class="mWt9p">남은수량</th>
                                <th class="mWt9p">개수</th>
                                <th class="mWt9p">단가($)</th>
                                <th class="mWt8p">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="11">
                                    <div style="height: auto; width:auto; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                        <asp:DataGrid ID="grdTable1" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff">
                                            <HeaderStyle Height="25px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="" Visible="false">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="0%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txt_itemname" runat="server" autocomplete="off"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="23%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                            <%--        <ItemTemplate>
                                                        <asp:TextBox ID="t1" CssClass="lblTextBox" runat="server" ></asp:TextBox>
                                                    </ItemTemplate>--%>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="9%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                  <%--  <ItemTemplate>
                                                        <asp:TextBox ID="t2" CssClass="lblTextBox" runat="server" ></asp:TextBox>
                                                    </ItemTemplate>--%>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="9%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                             <%--       <ItemTemplate>
                                                        <asp:TextBox ID="t3" CssClass="lblTextBox" runat="server" ></asp:TextBox>
                                                    </ItemTemplate>--%>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="8%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                        <%--            <ItemTemplate>
                                                        <asp:TextBox ID="t4" CssClass="lblTextBox" runat="server" ></asp:TextBox>
                                                    </ItemTemplate>--%>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="8%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                          <%--                          <ItemTemplate>
                                                        <asp:TextBox ID="t5" CssClass="lblTextBox" runat="server"></asp:TextBox>
                                                    </ItemTemplate>--%>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="8%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="9%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txt_count" runat="server" CssClass="tar"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="9%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txt_unitprice" runat="server" CssClass="tar"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="9%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btn_del" runat="server" CssClass="btn_red btn_60_25" Text="삭제" />
                                                        <asp:HiddenField ID="hdn_cud" runat="server" />
                                                        <asp:HiddenField ID="hidden_keyWord1" runat="server" />
                                                        <asp:HiddenField ID="hidden_itemCode" runat="server" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="8%" CssClass="" />
                                                </asp:TemplateColumn>
                                            </Columns>
                                            <SelectedItemStyle BackColor="#00CCFF"></SelectedItemStyle>
                                        </asp:DataGrid>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                        <tfoot>
                            <tr>
                                <th colspan="7">Total</th>
                                <th >
                                    <asp:TextBox ID="txt_totalQty" runat="server" CssClass="mWt90p tar" placeholder="개수"></asp:TextBox>
                                </th>
                                <th >
                                    <asp:TextBox ID="txt_totalWeight" runat="server" CssClass="mWt90p tar"  placeholder="중량"></asp:TextBox>
                                </th>
                                <th>
                                    <asp:TextBox ID="txt_totalPrice" runat="server" CssClass="mWt90p tar"  placeholder="가격"></asp:TextBox></th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="tar mt20 mb30">
            <asp:Button ID="btn_delete" Text="삭제" runat="server" CssClass="btn_150_40 btn_red" OnClick="btn_delete_Click" />
            <asp:Button ID="btn_save" Text="저장" runat="server" CssClass="btn_150_40 btn_black ml10" OnClick="btn_save_Click" />
            <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">취소</button>
        </div>
        <script type="text/javascript">
            fDatePickerById("txt_contractdate");
            fDatePickerById("txt_arrivaldate");
            fDatePickerById("txt_registrationdate");

            //계약정보 가격 => 구매품목 그리드 가격
            function Paste_TotalPrice() {
                document.getElementById('<%= txt_totalPrice.ClientID %>').value = document.getElementById('<%= txt_contractprice.ClientID %>').value;
            }

            //계약정보 수량 => 구매품목 그리드 중량
            function Paste_TotalWeight() {
                document.getElementById('<%= txt_totalWeight.ClientID %>').value = document.getElementById('<%= txt_qty.ClientID%>').value;
            }

            //구매품목 수량 총합 계산
            function Sum_Count() {
                let grid = document.getElementById('<%= grdTable1.ClientID%>');
                let sum = 0;

                for (let i = 0; i < grid.rows.length; i++) {
                    let qty = document.getElementById('grdTable1_txt_count_' + i).value;

                    if (!parseInt(qty)) continue;

                    sum += parseInt(qty);
                }

                document.getElementById('<%= txt_totalQty.ClientID %>').value = sum;
            }

            function change_cud(num) {
                var cud = document.getElementById('grdTable1_hdn_cud_' + num);
                if (cud.value != "c" && cud.value != "u") cud.value = "u";
            }

            function deleterow(row) {
                document.getElementById('<%= hdn_selectedRow.ClientID %>').value = row;

                __doPostBack('<%=btn_grd_delete.UniqueID%>', '');
            }

            function showimage() {
                var imgurl = document.getElementById('<%= hdn_filePath.ClientID %>').value;

                if (!imgurl) {
                    alert("파일이 존재하지 않습니다.");
                    return false;
                }

                var url = "../.." + imgurl;
                var name = "_blank"
                var popupX = (window.screen.width / 2) - (1000 / 2);
                var popupY = (window.screen.height / 2) - (700 / 2);
                window.open(url, name, 'status=no, width=1000, height=700, left=' + popupX + ',top=' + popupY);
            }

            function readURL_document(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        __doPostBack('<%= btn_imgTemp.UniqueID %>', '');
                    }
                    reader.readAsDataURL(input.files[0]);
                }
            }

            //문서 선택
            $("#fl_document_input").on("change", function () {
                readURL_document(this);
            });

            //문서 찾아보기
            function document_reg() {
                $("#fl_document_input").click();
            }
        </script>
    </form>
</body>
</html>
