<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmcustotal.aspx.cs" Inherits="iljin.Frmcustotal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        table.ui-datepicker-calendar {
            display: none;
        }

        .ui-datepicker .ui-datepicker-buttonpane button {
            padding: 0em 0.6em 0em 0.6em;
        }
    </style>
    <script>
        var listId = 'ContentPlaceHolder2_li_itemlist';
        var txtId = 'ContentPlaceHolder2_txt_customer';

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
            var listTop = (txt.getBoundingClientRect().top - 67 + window.pageYOffset) + "px";
            var listLeft = (txt.getBoundingClientRect().left - 290 + window.pageXOffset) + "px";
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
        <h2 class="conts_tit">
            <asp:Label ID="m_title" runat="server" Text="경영통계 ::> 거래처별집계"></asp:Label>
            <asp:HiddenField ID="hidden_keyWord" runat="server" />
            <asp:ListBox ID="li_itemlist" runat="server" Style="top: 0px; left: 0px; visibility: hidden;" CssClass="autoComplete_list"></asp:ListBox>
        </h2>
        <div class="search_box">
            <div class="box_row">
                <span>기간</span>
                <asp:TextBox ID="txt_deliveryDate" runat="server" CssClass="mWt100" autocomplete="off"></asp:TextBox>
                &nbsp~&nbsp
                <asp:TextBox ID="txt_deliveryDate2" runat="server" CssClass="mWt100" autocomplete="off"></asp:TextBox>
                <span class="ml20">거래처</span>
                <asp:TextBox ID="txt_customer" runat="server" CssClass="mWt200" onkeydown="KeyDownEvent();" onclick="visibleChk();" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                <asp:Button ID="btn_search" runat="server" CssClass="btn_navy btn_100_30 ml20" Text="조회" OnClick="btn_search_Click" />
            <asp:Button ID="btn_excel" runat="server" CssClass="btn_100_30 btn_green ft_right" Text="엑셀 다운로드" OnClick="btn_excel_Click"></asp:Button>
            </div>
        </div>
        <div class="fixed_hs_650 mt10" style="width: 1190px; overflow: hidden;">
            <table class="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt10p">No</th>
                        <th class="mWt20p">거래처</th>
                        <th class="mWt20p">공급가액</th>
                        <th class="mWt35p">총매출액(부가세포함)</th>
                        <th class="mWt15p">상세보기</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="5">
                            <div style="max-height: 600px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
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
                                            <ItemStyle Width="35%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:Button ID="btn_detail" runat="server" CssClass="btn_navy btn_60_25" Text="상세보기" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass="" />
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <th class="mWt30p" colspan="2">합계</th>
                        <th class="mWt20p" id ="txt_price" runat="server"></th>
                        <th class="mWt35p" id="txt_total" runat="server"></th>
                        <th class="mWt15p"></th>
                    </tr>
                </tfoot>
            </table>
        </div>
        <div id="exceldiv" runat="server" class="hidden" style="width: 1190px; overflow: hidden;">
            <table class="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt10p">No</th>
                        <th class="mWt25p">거래처</th>
                        <th class="mWt30p">공급가액</th>
                        <th class="mWt35p">총매출액(부가세포함)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="4">
                            <div style="overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                <asp:DataGrid ID="grdTable_Copy" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="25%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="30%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="35%" CssClass="" />
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <th class="mWt35p" colspan="2">합계</th>
                        <th class="mWt30p" id ="txt_price_hidden" runat="server"></th>
                        <th class="mWt35p" id="txt_total_hidden" runat="server"></th>
                    </tr>
                </tfoot>
            </table>
        </div>
        <script>
            fDatePickerById_yyyy_MM("ContentPlaceHolder2_txt_deliveryDate");
            fDatePickerById_yyyy_MM("ContentPlaceHolder2_txt_deliveryDate2");

            function detail(sdt, edt, code) {
                location.href = '/businessstatistics/Frmcustotal_detail.aspx?top=32&midx=3&code=' + code + '&sdt=' + sdt + '&edt=' + edt;
            }
        </script>
    </article>
</asp:Content>


