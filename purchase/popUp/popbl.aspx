<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popbl.aspx.cs" Inherits="iljin.popUp.popbl" %>

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
</head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>BL등록</span><span id="txt_warning" runat="server" style="color:red"></span>
                <asp:HiddenField ID="hidden_chkUpdate" runat="server" />
                <asp:HiddenField ID="hdn_no" runat="server" />
                <asp:HiddenField ID="hdn_user" runat="server" />
                <asp:Button ID="defaultBtn" runat="server" CssClass="hidden" OnClientClick="return false;"/>
            </div>
        </div>
        <div class="title_1 mt20">
            * BL 정보 등록
        </div>
        <table class="itable_1 mt10">
            <tobody>
                <tr>
                    <th>BL번호<span class="red vam"> *</span></th>
                    <td>
                        <asp:TextBox ID="txt_blnum" runat="server"></asp:TextBox>
                    </td>
                    <th>BL접수일</th>
                    <td>
                        <asp:TextBox ID="txt_registrationdate" runat="server" CssClass="w85p" autocomplete="off"></asp:TextBox>
                    </td>
                    <th>신고번호</th>
                    <td>
                        <asp:TextBox ID="txt_declarationNo" runat="server"></asp:TextBox>
                    </td>
                    <th>원본</th>
                    <td class="tac">
                        <asp:Button ID="btn_look" runat="server" CssClass="btn_navy btn_80_30" Text="보기" OnClientClick="showimage(); return false;" />
                        <asp:Button ID="btn_upload" runat="server" CssClass="btn_gray btn_80_30 ml10" Text="업로드" OnClientClick="document_reg(); return false;" />
                        <asp:HiddenField ID="hdn_filePath" runat="server" />
                        <asp:Button ID="btn_imgTemp" runat="server" CssClass="hidden" OnClick="btn_imgTemp_Click" />
                        <asp:FileUpload ID="fl_document_input" runat="server" class="hidden" accept="image/*" />
                    </td>
                </tr>
                <tr>
                    <th>수량</th>
                    <td>
                        <asp:TextBox ID="txt_qty" runat="server" CssClass="w85p"></asp:TextBox>
                        &nbsp;개
                    </td>
                    <th>중량</th>
                    <td>
                        <asp:TextBox ID="txt_weight" runat="server" CssClass="w85p"></asp:TextBox>
                        &nbsp;Kg</td>
                    <th>ETD</th>
                    <td>
                        <asp:TextBox ID="txt_etd" runat="server" CssClass="w85p" autocomplete="off"></asp:TextBox>
                    </td>
                    <th>ETA</th>
                    <td>
                        <asp:TextBox ID="txt_eta" runat="server" CssClass="w85p" autocomplete="off"></asp:TextBox>
                    </td>
                </tr>
        </table>
        <div class="mt20">
            <span class="title_1">* 컨테이너 등록</span>
            <asp:Button ID="btn_add" runat="server" CssClass="btn_navy btn_100_30 ft_right" Text="컨테이너 추가" OnClick="btn_add_Click" />
            <asp:HiddenField ID="hdn_container_state" runat="server" />
            <asp:HiddenField ID="hdn_container_selectedRow" runat="server" />
            <asp:HiddenField ID="hdn_autoDecsIdx" runat="server" />
            <asp:Button ID="btn_container_open" runat="server" CssClass="hidden" OnClick="btn_container_open_Click" />
            <%--<asp:Button ID="btn_container_overlap" runat="server" CssClass="hidden" OnClick="btn_container_overlap_Click" />--%>
            <asp:Button ID="btn_container_remover" runat="server" CssClass="hidden" OnClick="btn_container_remover_Click" />
        </div>
        <div class="fixed_hs_200 mt20" style="width: 1325px;">
            <table class="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt14p">계약번호<span class="red vam"> *</span></th>
                        <th class="mWt25p">Container<span class="red vam"> *</span></th>
                        <th class="mWt14p">배차일</th>
                        <th class="mWt14p">배차시간</th>
                        <th class="mWt14p">품목<span class="red vam"> *</span></th>
                        <th class="mWt19p">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="7">
                            <div style="height: 160px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                <asp:DataGrid ID="grdTable1" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1325">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="" Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="0%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:DropDownList ID="cb_contractno" runat="server"></asp:DropDownList>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="14%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txt_container" runat="server"></asp:TextBox>
                                                <%--<asp:Button ID="btn_overlap" runat="server" CssClass="btn_navy btn_80_30" Text="중복확인" />--%>
                                                <asp:HiddenField ID="hdn_overlapchk" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="25%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txt_dispatchdate" runat="server" autocomplete="off"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="14%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txt_dispatchtime" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="14%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:Button ID="btn_itemselect" runat="server" CssClass="btn_100_30" Text="제품선택" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="14%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <ItemTemplate>
                                                <asp:Button ID="btn_correction" runat="server" CssClass="btn_navy btn_80_30" Text="수정" />
                                                <asp:Button ID="btn_del" runat="server" CssClass="btn_red btn_80_30 ml10" Text="삭제" />
                                                <asp:HiddenField ID="hdn_cud" runat="server" />
                                                <asp:HiddenField ID="hdn_deleteChk" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="19%" CssClass="" />
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
        <div id="visiblity" runat="server" visible="false">
            <div class="title_1 mt20">
                * 제품선택 
            </div>
            <div class="fixed_hs_300 mt10" style="width: 1325px;">
                <table class="grtable_th">
                    <thead>
                        <tr>
                            <th class="mWt5p">
                                <asp:CheckBox ID="chk_itemAll" runat="server" /></th>
                            <th class="mWt25p">제품명</th>
                            <th class="mWt10p">제품구분1</th>
                            <th class="mWt10p">제품구분2</th>
                            <th class="mWt10p">두께</th>
                            <th class="mWt10p">폭</th>
                            <th class="mWt10p">길이</th>
                            <th class="mWt10p">남은수량</th>
                            <th class="mWt10p">수량</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td colspan="9">
                                <div style="height: 225px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                    <asp:DataGrid ID="grdTable2" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1325">
                                        <HeaderStyle Height="25px" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chk_item" runat="server" onchange="Sum_CheckedQty();" />
                                                    <asp:HiddenField ID="hdn_idx" runat="server" />
                                                    <asp:HiddenField ID="hdn_itemCode" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="5%" CssClass="" />
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
                                                <ItemStyle Width="10%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="txt_qty" runat="server" TextMode="Number" CssClass="w100p"></asp:TextBox>
                                                    <asp:HiddenField ID="hdn_originWeight" runat="server" />
                                                    <asp:HiddenField ID="hdn_originQty" runat="server" />
                                                    <asp:HiddenField ID="hdn_currentWeight" runat="server" />
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
                            <th colspan="7">Total</th>
                            <th id="txt_totalQty_left" runat="server"></th>
                            <th id="txt_totalQty" runat="server"></th>
                        </tr>
                    </tfoot>
                </table>
            </div>
            <div class="ft_left">
                <asp:Button ID="btn_container_save" runat="server" CssClass="btn_black btn_150_40" Text="선택완료" OnClick="btn_container_save_Click" />
                <asp:Button ID="btn_container_close" runat="server" CssClass="btn_black btn_150_40 ml10" Text="선택취소" OnClick="btn_container_close_Click" />
            </div>
        </div>
        <div class="ft_right">
            <asp:Button ID="btn_save" runat="server" CssClass="btn_150_40 btn_black ml10" Text="저장" OnClick="btn_save_Click" />
            <asp:Button ID="btn_delete" runat="server" CssClass="btn_150_40 btn_red ml10" Text="삭제" OnClick="btn_delete_Click" />
            <asp:Button ID="btn_close" runat="server" CssClass="btn_150_40 btn_gray ml10" Text="취소"/>
        </div>
        <div class="mt30" />
        &nbsp
        <script>
            fDatePickerById("txt_registrationdate");
            fDatePickerById("txt_etd");
            fDatePickerById("txt_eta");
            fDatePickerById2("grdTable1_txt_dispatchdate");

            function Sum_CheckedQty() {
                let grid = document.getElementById('<%= grdTable2.ClientID%>');
                let totalQty = 0;

                for (let i = 0; i < grid.rows.length; i++) {
                    let chkValue = document.getElementById('grdTable2_chk_item_' + i).checked;

                    if (chkValue) {
                        let qty = document.getElementById('grdTable2_txt_qty_' + i).value;

                        if (!parseInt(qty)) continue;

                        totalQty += parseInt(qty);
                    }
                }

                if (totalQty == 0) totalQty = "";

                document.getElementById('<%= txt_totalQty.ClientID %>').innerText = totalQty;
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

            function showcontainer(row, stateidx) {
                document.getElementById('<%= hdn_container_selectedRow.ClientID%>').value = row;
                document.getElementById('<%= hdn_container_state.ClientID%>').value = stateidx;

                document.getElementById('<%=btn_container_open.ClientID%>').click();
            }

            function qtyValidateCheck(row, value) {
                var currentQty = document.getElementById('grdTable2_txt_qty_' + row).value;

                if (parseInt(currentQty) > parseInt(value)) {
                    alert('수량이 초과 입력 되었습니다.');

                    document.getElementById('grdTable2_txt_qty_' + row).value = value;
                }
            }

            function grdTable2_checkAll() {
                var chk = document.getElementById('<%= chk_itemAll.ClientID %>').checked;
                var grid = document.getElementById('<%= grdTable2.ClientID %>');

                var checkBox;
                for (var i = 0; i < grid.rows.length; i++) {
                    checkBox = document.getElementById("grdTable2_chk_item_" + i.toString());
                    checkBox.checked = chk;
                }
                Sum_CheckedQty();
            }

            function container_delete(row) {
                document.getElementById('<%= hdn_container_selectedRow.ClientID%>').value = row;

                document.getElementById('<%=btn_container_remover.ClientID%>').click();
            }

            function overlapinit(row) {
                document.getElementById('grdTable1_hdn_overlapchk_' + row).value = '0';
            }

            function containeritem(idx) {
                var url = "/purchase/popUp/popcontaineritem.aspx?idx=" + idx;
                var name = "_blank"
                var popupX = (window.screen.width / 2) - (900 / 2);
                var popupY = (window.screen.height / 2) - (600 / 2);
                window.open(url, name, 'status=no, width=900, height=600, left=' + popupX + ',top=' + popupY);

            }

            function readURL_document(input) {
                if (input.files && input.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('<%=btn_imgTemp.ClientID%>').click();
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
