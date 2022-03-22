<%@ Page Language="C#" AutoEventWireup="true" EnableEventValidation ="false" CodeBehind="popincome.aspx.cs" Inherits="iljin.popUp.popincome" %>

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
        var selectRow = null;
        var chk = false;

        function isExist(value,row) {
            var param = "keyward=" + value + "&div=item";

            txtId = 'grdTable1_txt_itemname_' + row;
            selectRow = row;
            chk = true;

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
                            document.getElementById('grdTable1_hidden_itemCode_' + selectRow).value = list.value;
                            document.getElementById('btn_itemInfoSetting').click();
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

            if (itemCount > 10) itemCount = 10;

            var height = (itemHeight * itemCount + 1) + "px";
            list.style.height = height;
            var listTop = (txt.getBoundingClientRect().top + 30 + window.pageYOffset) + "px";
            var listLeft = (txt.getBoundingClientRect().left) + "px";
            list.style.top = listTop;
            list.style.left = listLeft;
            list.style.width = txt.offsetWidth + "px";
        }

        function visibleChk(row) {
            var txt = document.getElementById('grdTable1_txt_itemname_' + row);
            var hidden_keyWord = document.getElementById('grdTable1_hidden_keyWord_' + row);
            var li = document.getElementById('<%=li_itemlist.ClientID%>');
            //document.getElementById('grdTable1_hidden_itemCode_' + row).value = '';

                if (hidden_keyWord.value != "") {
                    txt.value = hidden_keyWord.value;
                    isExist(txt.value, row);
                }
                else {
                    isExist('', row);
                }
        }

        function KeyPressEvent(row) {
            if (event.keyCode == 13) {
                var txt = document.getElementById('grdTable1_txt_itemname_' + row);
                var hidden_keyWord = document.getElementById('grdTable1_hidden_keyWord_' + row);
                var lastChar = txt.value.charAt(txt.value.length - 1);

                if (lastChar != "|")
                {
                    txt.value += "|";
                    hidden_keyWord.value = txt.value;
                    isExist(txt.value, row);
                }
            }
        }

        function KeyDownEvent(row) {
            if (event.keyCode == 8) {
                var txt = document.getElementById('grdTable1_txt_itemname_' + row);
                var hidden_keyWord = document.getElementById('grdTable1_hidden_keyWord_' + row);
                document.getElementById('grdTable1_hidden_itemCode_' + row).value = '';

                //문자가 없는데 입력 시 return
                if (txt.value.length == 0) {
                    return false;
                }

                //입력&저장된 키워드가 없을 시 한글자씩 삭제 가능하게 한다.
                if (hidden_keyWord.value == "") {
                    if (txt.value.includes("_")) {
                        txt.value = "";
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
    <form id="form1" runat="server" defaultbutton="btn_default">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>입고등록</span>
                    <asp:Button ID="btn_default" runat="server" OnClientClick="return false;"  CssClass="hidden"/>
            </div>
        </div>
        <div class="title_1 mt20">
            기본정보
        </div>
        <asp:UpdatePanel runat="server">
            <ContentTemplate>
                <asp:ScriptManager runat="server"></asp:ScriptManager>
                <asp:Button ID="btn_itemInfoSetting" runat="server" CssClass="hidden" OnClick="btn_itemInfoSetting_Click" />
                <table class="itable_1 mt10">
                    <tobody>
                        <tr>
                            <th>거래처명<span class="red vam">*</span></th>
                            <td>
                                <asp:DropDownList ID="cb_cusname" runat="server" AutoPostBack="true" OnSelectedIndexChanged="cb_cusname_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                            <th>대표연락처</th>
                            <td>
                                <asp:Label ID="txt_bosstel" runat="server"></asp:Label>
                            </td>
                            <th>대표이메일</th>
                            <td>
                                <asp:Label ID="txt_bossmail" runat="server"></asp:Label>
                            </td>
                            <th>팩스</th>
                            <td>
                                <asp:Label ID="txt_fax" runat="server" Width="200"></asp:Label>
                            </td>
                        </tr>
                </table>
                <div class="title_1 mt20">
                    입고품목 
                    <asp:Button ID="btn_add" runat="server" CssClass="btn_navy btn_100_30 ft_right" Text="품목추가" OnClick="btn_add_Click" />
                    <asp:Button ID="btn_delete" runat="server" CssClass="hidden" OnClick="btn_delete_Click" />
                    <asp:HiddenField ID="hidden_selectedRow" runat="server" />
                </div>
                <div class="fixed_hs_350 mt20" style="width: 1315px;">
                <asp:ListBox ID="li_itemlist" runat="server" CssClass="autoComplete_list" Style="top:0px; left:0px; visibility: hidden;"></asp:ListBox>
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt19p">제품명</th>
                                <th class="mWt8p">제품구분1</th>
                                <th class="mWt8p">제품구분2</th>
                                <th class="mWt5p">두께</th>
                                <th class="mWt5p">폭</th>
                                <th class="mWt5p">길이</th>
                                <th class="mWt5p">개수</th>
                                <th class="mWt10p">중량(kg)</th>
                                <th class="mWt10p">단가($)</th>
                                <th class="mWt15p">가격(USD)</th>
                                <th class="mWt10p">관리</th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="11">
                                    <div style="height: 290px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                        <asp:DataGrid ID="grdTable1" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1315">
                                            <HeaderStyle Height="25px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:HiddenField ID="hidden_keyWord" runat="server" />
                                                        <asp:HiddenField ID="hidden_itemCode" runat="server" />
                                                        <asp:TextBox ID="txt_itemname" runat="server" autocomplete="off" style="height:22px"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="19%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="8%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="8%" CssClass="" />
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
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="5%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txt_count" runat="server" style="height:22px"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="5%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txt_weight" runat="server" style="height:22px"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="10%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txt_unitprice" runat="server" style="height:22px"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="10%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txt_price" runat="server" style="height:22px"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="15%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btn_del" runat="server" CssClass="btn_60_20 btn_red" Text="삭제" />
                                                    </ItemTemplate>
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="10%" CssClass="" />
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
                                <th class="mWt50p" colspan="6">Total</th>
                                <th class="mWt5p"></th>
                                <th class="mWt10p"></th>
                                <th class="mWt10p"></th>
                                <th class="mWt15p"></th>
                                <th class="mWt10p"></th>
                            </tr>
                        </tfoot>
                    </table>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
        <div class="tar mt20">
            <asp:Button ID="btn_save" runat="server" CssClass="btn_150_40 btn_black ml10" Text="입고저장" OnClick="btn_save_Click" />
            <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">목록</button>
        </div>
        <script type="text/javascript">
            function deleteRow(row) {
                document.getElementById('<%= hidden_selectedRow.ClientID%>').value = row;

                document.getElementById('<%= btn_delete.ClientID%>').click();
            }
        </script>
    </form>
</body>
</html>
