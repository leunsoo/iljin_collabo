<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popcus.aspx.cs" Inherits="iljin.popcus" %>

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
    <link rel="stylesheet" type="text/css" href="/webapp/css/ibuild.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/main.css" />
    <link rel="stylesheet" type="text/css" href="/webapp/css/popUp.css" />
    <script src="/webapp/js/jquery-1.11.1.min.js"></script>
    <script src="/webapp/js/skyblueUtil.js"></script>
    <script src="/webapp/js/jquery-ui.min.js"></script>
    <script src="/webapp/js/front.js"></script>
    <style type="text/css">
        .auto-style1 {
            height: 225px;
        }
    </style>
    <script type="text/javascript">
        function change_cud(name) {
            var cud = document.getElementById(name);
            if (cud.value != "c" && cud.value != "u") cud.value = "u";
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>거래처 등록</span>
                <asp:HiddenField ID="hdn_code" runat="server" />  
                <asp:HiddenField ID="hdn_delete_row" runat="server" />
                <asp:HiddenField ID="hdn_delete_rowIdx" runat="server" />
            </div>
            <div class="mt30"><span style="font-weight: bold; font-size: 20px">*기본정보</span></div>
            <table class="itable_1 mt10">
                <tbody>
                    <tr>
                        <th class="w10p">거래처구분<span class="red vam"> *</span></th>
                        <td class="w23p">
                            <asp:DropDownList ID="cb_cusType" runat="server" required></asp:DropDownList>
                        </td>
                        <th class="w10p">거래처코드</th>
                        <td class="w24p">
                            <asp:TextBox ID="tb_cusCode" runat="server" ReadOnly="true"></asp:TextBox>
                        </td>
                        <th class="w10p">거래처명<span class="red vam"> *</span></th>
                        <td class="w23p">
                            <asp:TextBox ID="tb_cusName" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>대표자명</th>
                        <td>
                            <asp:TextBox ID="tb_ceo" runat="server"></asp:TextBox>
                        </td>
                        <th>연락처</th>
                        <td>
                            <asp:TextBox ID="tb_tel" runat="server"></asp:TextBox>
                        </td>
                        <th>이메일</th>
                        <td>
                            <asp:TextBox ID="tb_email" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>팩스번호</th>
                        <td>
                            <asp:TextBox ID="tb_fax" runat="server"></asp:TextBox>
                        </td>
                        <th>담당직원</th>
                        <td>
                            <asp:DropDownList ID="cb_manage" runat="server"></asp:DropDownList>
                        </td>
                        <th>관리대상</th>
                        <td class="tac">
                            <asp:CheckBox ID="chk_black" runat="server"></asp:CheckBox>
                        </td>
                    </tr>
                    <tr>
                        <th>주거래처</th>
                        <td class="tac">
                            <asp:CheckBox ID="chk_mainCus" runat="server"></asp:CheckBox>
                        </td>
                        <th>결재조건</th>
                        <td colspan="3">
                            <asp:DropDownList ID="cb_payMonth" runat="server" CssClass="w40p"></asp:DropDownList>
                            <asp:TextBox ID="tb_payDay" runat="server" CssClass="w10p ml30"></asp:TextBox>
                            <span class="ml10">일</span>
                        </td>
                    </tr>
                    <tr>
                        <th>사업자등록번호</th>
                        <td>
                            <asp:TextBox ID="tb_registration" runat="server"></asp:TextBox>
                        </td>
                        <th>업태</th>
                        <td>
                            <asp:TextBox ID="tb_business" runat="server"></asp:TextBox>
                        </td>
                        <th>종목</th>
                        <td>
                            <asp:TextBox ID="tb_businessItem" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>계좌정보</th>
                        <td colspan="5">은행명
                            <asp:TextBox ID="tb_bankName" CssClass="mWt20p mr20" runat="server" />
                            예금주
                            <asp:TextBox ID="tb_accountHolder" CssClass="mWt15p mr20" runat="server" />
                            계좌번호
                            <asp:TextBox ID="tb_bankNo" CssClass="mWt40p" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td colspan="5">
                            <div>
                                <asp:TextBox ID="tb_zipCode" runat="server" CssClass="mWt45p" placeholder="우편번호"></asp:TextBox>
                                <button type="button" class="btn_black btn_80_30 ml10" onclick="OpenZipcode('')">주소찾기</button>
                            </div>
                            <div class="mt7">
                                <asp:TextBox ID="tb_address1" runat="server" CssClass="mWt48p" placeholder="기본주소"></asp:TextBox>
                                <asp:TextBox ID="tb_address2" runat="server" CssClass="mWt48p ml30" placeholder="상세주소"></asp:TextBox>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>메모</th>
                        <td colspan="5">
                                <asp:TextBox ID="tb_memo" runat="server" Height="100" TextMode="MultiLine"></asp:TextBox>
                            </td>
                    </tr>
                </tbody>
            </table>
            <div class="mt30"><span style="font-weight: bold; font-size: 20px">*추가정보</span></div>
            <table class="itable_1 mt10">
                <tbody>
                    <tr>
                        <th class="w10p">적용소수점</th>
                        <td class="w23p">
                            <asp:DropDownList ID="cb_decimal" runat="server"></asp:DropDownList>
                        </td>
                        <th class="w10p">비중값(PET)</th>
                        <td class="w24p">
                            <asp:TextBox ID="tb_weight_pet" runat="server" style="width:100%" ></asp:TextBox>
                        </td>
                        <th class="w10p">비중값(PP)</th>
                        <td class="w23p">
                            <asp:TextBox ID="tb_weight_pp" runat="server" style="width:100%" ></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th class="w10p">비중값(Al)</th>
                        <td class="w23p">
                            <asp:TextBox ID="tb_weight_al" runat="server" style="width:100%" ></asp:TextBox>
                        </td>
                        <th class="w10p">비중값1</th>
                        <td class="w24p">
                            <asp:TextBox ID="tb_weight1" runat="server" style="width:100%" ></asp:TextBox>
                        </td>
                        <th class="w10p">비중값2</th>
                        <td class="w23p">
                             <%--step="0.001" TextMode="Number"--%>
                            <asp:TextBox ID="tb_weight2" runat="server" style="width:100%"></asp:TextBox>
                        </td>
                    </tr>
                </tbody>
            </table>      
            <asp:UpdatePanel ID="updatePanel" runat="server">
                <ContentTemplate>
                    <asp:ScriptManager ID="scriptManager" runat="server"></asp:ScriptManager>
                    <div class="mt30">
                        <span style="font-weight: bold; font-size: 20px">*담당자정보</span>
                        <asp:Button ID="btn_add_manager" runat="server" Text="담당자추가" CssClass="btn_navy btn_100_30 ft_right" OnClick="btn_add_manager_Click" />
                        <asp:Button ID ="btn_manager_remover" runat="server" CssClass="hidden" OnClick="btn_manager_remover_Click"/>
                    </div>
                    <table class="grtable_th mt10">
                        <thead>
                            <tr>
                                <th class="mWt10p">담당자명<span class="red vam"> *</span></th>
                                <th class="mWt10p">직책</th>
                                <th class="mWt10p">부서</th>
                                <th class="mWt15p">연락처1</th>
                                <th class="mWt15p">연락처2</th>
                                <th class="mWt20p">이메일</th>
                                <th class="mWt14p">비고</th>
                                <th class="mWt6p">관리</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="8">
                                    <asp:DataGrid ID="grdTable_manager" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2">
                                        <HeaderStyle Height="25px" />
                                        <ItemStyle HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:TemplateColumn HeaderText="" Visible="false">
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="0%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="grd_tb_managerName" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="10%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="grd_tb_class" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="10%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="grd_tb_department" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="10%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="grd_tb_tel1" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="15%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="grd_tb_tel2" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="15%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="grd_tb_email" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="20%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                                    <asp:TextBox ID="grd_tb_memo" runat="server"></asp:TextBox>
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="14%" CssClass="" />
                                            </asp:TemplateColumn>
                                            <asp:TemplateColumn HeaderText="">
                                                <ItemTemplate>
                                                    <asp:Button ID="grd_btn_delete" runat="server" Text="삭제" CssClass="btn_60_25 btn_red"></asp:Button>
                                                    <asp:HiddenField ID="hdn_cud" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle HorizontalAlign="Center" />
                                                <ItemStyle Width="6%" CssClass="" />
                                            </asp:TemplateColumn>
                                        </Columns>
                                    </asp:DataGrid>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="mt30">
                        <span style="font-weight: bold; font-size: 20px">*배송지정보</span>           
                        <asp:Button ID="btn_add_address" runat="server" Text="배송지추가" CssClass="btn_navy btn_100_30 ft_right" OnClick="btn_add_address_Click" />
                        <asp:Button ID ="btn_address_remover" runat="server" CssClass="hidden" OnClick="btn_address_remover_Click"/>
                    </div>
                    <asp:DataGrid ID="grdTable_address" runat="server" CssClass="mt10" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2">
                        <Columns>
                            <asp:TemplateColumn HeaderText="">
                                <ItemTemplate>
                                    <asp:HiddenField ID="hdn_cud" runat="server" />
                                    <asp:HiddenField ID="hdn_idx" runat="server" />                                             
                                    <table class="itable_1">
                                        <tbody>
                                            <tr>
                                                <th class="w15p">
                                                    <asp:TextBox ID="tb_address_name" runat="server" CssClass="w90p"></asp:TextBox>
                                                    <span class="red vam">*</span>
                                                </th>
                                                <td class="w20p">
                                                    <asp:TextBox ID="tb_address_zipCode" runat="server" CssClass="mWt60p" placeholder="우편번호"></asp:TextBox>
                                                    <asp:Button ID="btn_find_address" runat="server" Text="주소찾기" CssClass="btn_black btn_80_30" />
                                                </td>
                                                <td class="w35p" colspan="2">
                                                    <asp:TextBox ID="tb_address_1" runat="server" placeholder="기본주소"></asp:TextBox>
                                                </td>
                                                <td class="w30p ml10">
                                                    <asp:TextBox ID="tb_address_2" runat="server" CssClass="mWt75p ml10" placeholder="상세주소"></asp:TextBox>
                                                    <asp:Button ID="btn_delete_address" runat="server" CssClass="btn_red btn_60_30 ml15" Text="삭제"/>
                                                </td>
                                            </tr>
                                            <tr>
                                                <th class="w15p">전화번호</th>
                                                <td>
                                                    <asp:TextBox ID="tb_address_tel" runat="server"></asp:TextBox>
                                                </td>
                                                <th>메모</th>
                                                <td colspan="2">
                                                    <asp:TextBox ID="tb_address_memo" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </ItemTemplate>
                            </asp:TemplateColumn>
                        </Columns>
                    </asp:DataGrid>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div class="mt10">
                <asp:Button ID="btn_delete" runat="server" CssClass="btn_150_40 btn_red" Text="삭제" OnClick="btn_delete_Click" />
                <asp:Button ID="btn_close" runat="server" CssClass="btn_150_40 btn_gray ft_right" Text="닫기" OnClientClick="window.close();" />
                <asp:Button ID="btn_save" runat="server" CssClass="btn_150_40 btn_black ft_right mr10" Text="저장" OnClick="btn_save_Click" />
                <br />
            </div>
            <div class="mt20">
                <br />
            </div>
        </div>
        <%--<script src="https://dmaps.daum.net/map_js_init/postcode.v2.js"></script>--%>
        <script src="//spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
        <script type="text/javascript">
            /*탭*/
            $(".tab_base > a").on('click', function (e) {
                var title = $(this).attr("title");
                $(this).parents(".pop_wrap").children(".tab_base_con").hide();
                $(this).parents(".pop_wrap").children("#" + title).fadeIn();
                $(this).parents(".pop_wrap").children(".tab_base").children("a").removeClass("active");
                $(this).addClass("active");
            });

            var idx;

            // 우편번호 - 주소
            function OpenZipcode(_idx) {
                idx = _idx;
                daumAPIFunc();
            }

            // 주소관련 시작
            //팝업 위치를 지정(화면의 가운데 정렬)
            var width = 500; //팝업의 너비
            var height = 600; //팝업의 높이

            var daumAPIFunc = function () {
                new daum.Postcode({
                    width: width, //생성자에 크기 값을 명시적으로 지정해야 합니다.
                    height: height,
                    oncomplete: function (data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                        // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                        var extraRoadAddr = ''; // 도로명 조합형 주소 변수

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
                    if (!idx) {
                        $("input[name='tb_zipCode']").val(data.zonecode);
                        $("input[name='tb_address1']").val(fullRoadAddr);
                        $("input[name='tb_address2']").val(extraRoadAddr);
                    }
                    else {
                        $("input[id='grdTable_address_tb_address_zipCode_" + idx + "']").val(data.zonecode);
                        $("input[id='grdTable_address_tb_address_1_" + idx + "']").val(fullRoadAddr);
                        $("input[id='grdTable_address_tb_address_2_" + idx + "']").val(extraRoadAddr);
                    }
                } catch (e) { }

            };
            // 주소관련 끝
            function delete_address(row,idx) {
                document.getElementById("<%= hdn_delete_row.ClientID %>").value = row;
                document.getElementById("<%= hdn_delete_rowIdx.ClientID %>").value = idx;

                __doPostBack('<%= btn_address_remover.UniqueID%>', '');
            }
            // 주소관련 끝
            function delete_manager(row,idx) {
                document.getElementById("<%= hdn_delete_row.ClientID %>").value = row;
                document.getElementById("<%= hdn_delete_rowIdx.ClientID %>").value = idx;

                __doPostBack('<%= btn_manager_remover.UniqueID%>', '');
            }

        </script>
    </form>
</body>
</html>
