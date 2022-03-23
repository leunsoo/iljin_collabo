﻿<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="Frmorderprogress.aspx.cs" Inherits="iljin.Frmorderprogress" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <script type="text/javascript">
      var listId = 'ContentPlaceHolder2_li_itemlist';
      var txtId = 'ContentPlaceHolder2_txt_cusName';

      function refresh() {
          document.getElementById('<%= btn_search.ClientID %>').click();
      }

      function isExist(value) {
          var param = "keyward=" + value + "&div=customer&caseNo=매입";

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

                if (txt.value == "") return;

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
    <article class ="conts_inner">
        <asp:Panel ID="defaultPanel1" runat="server" DefaultButton="btn_default">
        <h2 class="conts_tit">
            <asp:Label ID="m_title" runat="server" Text="매입관리 ::> 발주진척현황"></asp:Label>
            <asp:HiddenField ID="hidden_keyWord" runat="server" />
            <asp:ListBox ID="li_itemlist" runat="server" Style="top: 0px; left: 0px; visibility: hidden;" CssClass="autoComplete_list"></asp:ListBox>
        </h2>
        <div class ="search_box">
            <div class ="box_row">
                <span>등록일</span>
                <asp:TextBox ID="tb_registrationdate" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                ~
                <asp:TextBox ID="tb_registrationdate2" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                <span class="ml10" >거래처명</span>
               <asp:TextBox ID="txt_cusName" runat="server" CssClass="mWt180" onkeydown="KeyDownEvent();" onclick="visibleChk();" onkeypress="KeyPressEvent();" autocomplete="off"></asp:TextBox>
                <asp:Button ID ="btn_search" runat="server" CssClass="btn_navy btn_100_30 ml20" Text="조회" OnClick="btn_search_Click" />
            </div>
        </div>
        <div class ="fixed_hs_650 mt10" style="width: 1600px; overflow:hidden;">
            <table class ="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt5p">NO.</th>
                        <th class="mWt10p">거래처</th>
                        <th class="mWt10p">계약번호</th>
                        <th class="mWt10p">제목</th>
                        <th class="mWt15p">BL번호</th>
                        <th class="mWt15p">컨테이너No</th>
                        <th class="mWt10p">계약일</th>
                        <th class="mWt10p">출발예정</th>
                        <th class="mWt10p">입항예정</th>
                        <th class="mWt10p">입고예정</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan ="10">
                            <div style=" height:600px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;"> 
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1600">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
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
            <asp:Button ID="btn_default" runat="server" OnClientClick="return false;" CssClass="hidden" />
        </asp:Panel>
    </article>
         <script>
        fDatePickerById("ContentPlaceHolder2_tb_registrationdate");
        fDatePickerById("ContentPlaceHolder2_tb_registrationdate2");
         </script>
</asp:Content>
