<%@ Page Title="" Language="C#" EnableEventValidation="false" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmitem.aspx.cs" Inherits="iljin.Frmitem
    " %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <script type="text/javascript">
        var listId = 'ContentPlaceHolder2_li_itemlist';
        var txtId = 'ContentPlaceHolder2_tb_itemName';

        function sub_disp(code) {
            var url = "/base/popUp/popitem.aspx?code=" + code;
            var name = "_blank"
            var popupX = (window.screen.width / 2) - (750 / 2);
            var popupY = (window.screen.height / 2) - (500 / 2);
            window.open(url, name, 'status=no, width=750, height=500, left=' + popupX + ',top=' + popupY);
        }
        function refresh() {
            __doPostBack('<%= btn_sch.UniqueID%>', '');
        }

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
            var txt = document.getElementById('ContentPlaceHolder2_tb_itemName');
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
                var txt = document.getElementById('ContentPlaceHolder2_tb_itemName');
                var hidden_keyWord = document.getElementById('<%= hidden_keyWord.ClientID%>');
                var lastChar = txt.value.charAt(txt.value.length -1);

                if (lastChar != "|")
                {
                    txt.value += "|";
                    hidden_keyWord.value = txt.value;
                    isExist(txt.value);
                }
            }
        }

        function KeyDownEvent() {
            if (event.keyCode == 8) {
                var txt = document.getElementById('ContentPlaceHolder2_tb_itemName');
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
            <asp:Label ID="m_title" runat="server" Text="기준정보관리 ::> 제품관리"></asp:Label>
            <asp:HiddenField ID="hidden_keyWord" runat="server" />
        </h2>
       <%-- <div style="width:222px; height:200px;background-color:none;position:absolute;left:108px; top:400px;" >--%>
            <asp:ListBox ID="li_itemlist" runat="server" CssClass="autoComplete_list" Style="top:0px; left:0px; visibility: hidden;"></asp:ListBox>
        <%--</div>--%>
        <div class="search_box">
            <div class="box_row">
                
                <span>제품명</span>
                <asp:TextBox ID="tb_itemName" runat="server" CssClass="mWt200" onkeydown="KeyDownEvent();" onclick="visibleChk();" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                <span class="ml15">제품구분1</span>
                <asp:DropDownList ID="cb_itemdiv1" runat="server" CssClass="mWt150" OnSelectedIndexChanged="cb_itemdiv1_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                <span class="ml15">제품구분2</span>
                <asp:DropDownList ID="cb_itemdiv2" runat="server" CssClass="mWt150"></asp:DropDownList>
            </div>
            <div class="box_row mt7" style="left: 0px; top: 0px">
                <span>두께</span>
                <asp:TextBox ID="tb_thickness" runat="server" CssClass="mWt100"></asp:TextBox>
                <span class="ml15">폭</span>
                <asp:TextBox ID="tb_width1" runat="server" CssClass="mWt70 mr5"></asp:TextBox>
                ~
                <asp:TextBox ID="tb_width2" runat="server" CssClass="mWt70 ml5"></asp:TextBox>
                <span class="ml15">길이</span>
                <asp:TextBox ID="tb_length1" runat="server" CssClass="mWt70 mr5"></asp:TextBox>
                ~
                <asp:TextBox ID="tb_length2" runat="server" CssClass="mWt70 ml5"></asp:TextBox>

                <asp:Button ID="btn_add" CssClass="btn_black btn_100_30 ml10 ft_right" runat="server" Text="제품 등록" OnClientClick="sub_disp('');return false;"></asp:Button>
                <asp:Button ID="btn_sch" CssClass="btn_navy btn_100_30 ft_right" runat="server" Text="조회" OnClick="btn_sch_Click"></asp:Button>
            </div>
        </div>
        <div class="fixed_hs_550 mt10" style="width: 1190px; overflow:hidden;">
            <table class="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt5p">NO</th>
                        <th class="mWt12p">제품코드</th>
                        <th class="mWt25p">품명</th>
                        <th class="mWt10p">제품구분1</th>
                        <th class="mWt10p">제품구분2</th>
                        <th class="mWt8p">두께(mm)</th>
                        <th class="mWt8p">폭(mm)</th>
                        <th class="mWt8p">길이(mm)</th>
                        <th class="mWt8p">중량(kg)</th>
                        <th class="mWt6p">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="10">
                            <div style="height:500px; overflow-x:hidden;overflow-y:auto; margin:0px;padding:0px;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
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
                                            <ItemStyle Width="25%" CssClass="" />
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
                                            <ItemStyle Width="8%" CssClass="" />
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
                                            <ItemStyle Width="8%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:Button ID="grd_btn_update" CssClass="btn_50_20 btn_black" Text="수정" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="6%" CssClass="" />
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
                    <asp:Button ID="btn_default" runat="server" OnClientClick="return false;"  CssClass="hidden"/>

    </asp:Panel>
    </article>
</asp:Content>
