<%@ Page Title="" EnableEventValidation="false" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmcustomer.aspx.cs" Inherits="iljin.Frmcustomer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        //팝업창 호출
        function sub_disp(code) {
            var popupX = (window.screen.width / 2) - (1400 / 2);
            var url = "popUp/popcus.aspx?code=" + code;
            window.open(url, '', 'left=' + popupX + ',top=100,width=1400,height=800,resizable=no,menubar=no,directories=no,location=no,toolbar=no,status=no,scrollbars=yes');
        }  //팝업에서 리턴했을때
        function refresh() {
            __doPostBack('<%= btn_seacrh.UniqueID  %>', '');
        }
        var listId = 'ContentPlaceHolder2_li_itemlist';
        var txtId = 'ContentPlaceHolder2_txt_cusName';

        function isExist(value) {
            var param = "keyward=" + value + "&div=customer&caseNo=전체";

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
                <asp:Label ID="m_title" runat="server" Text="기준정보관리 ::> 거래처관리"></asp:Label>
                <asp:HiddenField ID="hidden_keyWord" runat="server" />
                <asp:ListBox ID="li_itemlist" runat="server" CssClass="autoComplete_list" Style="top:0px; left:0px; visibility: hidden;"></asp:ListBox>
            </h2>
            <div class="search_box">
                <div class="box_row">
                    <span>거래처명</span>
                    <asp:TextBox ID="txt_cusName" runat="server" CssClass="mWt200" onkeydown="KeyDownEvent();" onclick="visibleChk();" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                    <span class="ml10">거래처구분</span>
                    <asp:DropDownList ID="cb_cusType" runat="server" CssClass="mWt100"></asp:DropDownList>
                    <span class="ml10">담당직원</span>
                    <asp:TextBox ID="txt_manager" runat="server" CssClass="mWt100"></asp:TextBox>
                    <span class="ml10">기타</span>
                    <asp:DropDownList ID="cb_cusDiv" runat="server" CssClass="mWt100"></asp:DropDownList>
                    <asp:Button ID="btn_seacrh" CssClass="btn_navy btn_100_30 ml10" runat="server" Text="조회" OnClick="btn_seacrh_Click"></asp:Button>
                    <asp:Button ID="btn_add" CssClass="btn_black btn_100_30 ft_right" runat="server" Text="거래처등록" OnClientClick="sub_disp(''); return false;" />
                </div>
            </div>
            <div class="fixed_hs_500 mt10">
                <table class="grtable_th">
                    <thead>
                        <tr>
                            <th class="mWt5p">NO</th>
                            <th class="mWt12p">거래처코드</th>
                            <th class="mWt23p">거래처명</th>
                            <th class="mWt8p">거래처구분</th>
                            <th class="mWt12p">연락처</th>
                            <th class="mWt20p">이메일</th>
                            <th class="mWt12p">담당직원</th>
                            <th class="mWt8p">관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="8">
                                <div style="overflow: auto;">
                                    <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff">
                                        <HeaderStyle Height="25px" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="5%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="12%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="23%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="8%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="12%" CssClass="" />
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
                                                <ItemTemplate>
                                                    <asp:Button ID="grd_btn_update" runat="server" CssClass="btn_60_25 btn_black" Text="확인" />
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
                </table>
            </div>
            <asp:Button ID="btn_default" runat="server" OnClientClick="return false;" CssClass="hidden" />
        </asp:Panel>
    </article>
</asp:Content>
