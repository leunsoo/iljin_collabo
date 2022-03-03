<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="poptaxbill.aspx.cs" Inherits="iljin.popUp.poptaxbill" %>

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
</head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>세금계산서 발행</span>
                <asp:HiddenField ID="hdn_cusCode" runat="server" />
                <asp:HiddenField ID="hdn_code" runat="server" />
                <asp:HiddenField ID="hdn_serialNo" runat="server" />
                <asp:HiddenField ID="hdn_isSend" runat="server" />
            </div>
        </div>
        <table class="itable_1 mt10">
            <tbody>
                <tr>
                    <th>일련번호</th>
                    <td>
                        <asp:Label ID="txt_serialNo" runat="server"></asp:Label>
                    </td>
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
            </tbody>
        </table>
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
                    <th style="color: steelblue; background-color: aliceblue">등록번호<span class="red vam"> *</span></th>
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
                    <th style="color: steelblue; background-color: aliceblue">상호<span class="red vam"> *</span></th>
                    <td>
                        <asp:TextBox ID="txt_cusName2" runat="server"></asp:TextBox></td>
                    <th style="color: steelblue; background-color: aliceblue">성명<span class="red vam"> *</span></th>
                    <td>
                        <asp:TextBox ID="txt_bossname2" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <th style="color: red">사업장</th>
                    <td colspan="3">
                        <asp:Label ID="txt_address" runat="server"></asp:Label>
                    </td>
                    <th style="color: steelblue; background-color: aliceblue">사업장<span class="red vam"> *</span></th>
                    <td colspan="3">
                        <asp:TextBox ID="txt_address2" runat="server" CssClass="w75p"></asp:TextBox>
                        <asp:Button ID="btn_address2" runat="server" CssClass="btn_navy btn_80_30 ml10" Text="주소변경" OnClientClick="OpenZipcode(); return false;" />
                    </td>
                </tr>
                <tr>
                    <th style="color: red">업태</th>
                    <td>
                        <asp:Label ID="txt_business" runat="server"></asp:Label></td>
                    <th style="color: red">종목</th>

                    <td>
                        <asp:Label ID="txt_businessitem" runat="server"></asp:Label></td>
                    <th style="color: steelblue; background-color: aliceblue">업태</th>
                    <td>
                        <asp:TextBox ID="txt_business2" runat="server"></asp:TextBox></td>
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
                    <td><asp:Label ID="txt_manager" runat="server"></asp:Label></td>
                    <th style="color: red">휴대폰</th>
                    <td><asp:Label ID="txt_phone" runat="server"></asp:Label></td>
                    <th style="color: steelblue; background-color: aliceblue">담당자<span class="red vam"> *</span></th>
                    <td><asp:TextBox ID="txt_manager2" runat="server"></asp:TextBox></td>
                    <th style="color: steelblue; background-color: aliceblue">휴대폰</th>
                    <td><asp:TextBox ID="txt_phone2" runat="server"></asp:TextBox></td>
                </tr>
            </tbody>
        </table>
        <div class="fixed_hs_250 mt10">
            <table class="grtable_th taxTable">
                <thead>
                    <tr>

                        <th class="mWt14p">작성일자</th>
                        <th class="mWt29p">품목</th>
                        <th class="mWt5p">수량</th>
                        <th class="mWt10p">단가</th>
                        <th class="mWt14p">공급가액</th>
                        <th class="mWt14p">세액</th>
                        <th class="mWt14p">합계금액</th>

                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <asp:Label ID="txt_registrationDate" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txt_itemName" runat="server"></asp:TextBox>
                        </td>
                        <td></td>
                        <td></td>
                        <td>
                            <asp:Label ID="txt_produceCost" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txt_taxCost" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="txt_totalCost" runat="server"></asp:Label>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>


        <div class="tar mt20">
            <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">취소</button>
            <asp:Button ID="btn_save" Text="저장" CssClass="btn_150_40 btn_black ml10" runat="server" OnClick="btn_save_Click" />
            <asp:Button ID="btn_send" Text="전송" CssClass="btn_150_40 btn_navy ml10" runat="server" OnClientClick="SendChk();" OnClick="btn_send_Click" />
        </div>
        <script src="//spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
        <script type="text/javascript">
            fDatePickerById2("txt_date");
            taxFree();

            //문자보낼지 체크
            function SendChk() {
                document.getElementById('<%= hdn_isSend.ClientID%>').value = confirm("문자알림을 받으시겠습니까?");
            }

            // 우편번호 - 주소
            function OpenZipcode() {
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
                    document.getElementById('<%= txt_address2.ClientID%>').value = fullRoadAddr + " / " + extraRoadAddr;
                    //$("input[name='ctl00$ContentPlaceHolder2$txt_com_post']").val(data.zonecode);
                    //$("input[name='ctl00$ContentPlaceHolder2$txt_com_addr']").val(fullRoadAddr);
                    //$("input[name='ctl00$ContentPlaceHolder2$txt_com_addr2']").val(extraRoadAddr);
                } catch (e) { }

            };

            function taxFree() {
                var checkValue = document.getElementById('<%= chk_taxfree.ClientID%>').checked;
                var prodValue = document.getElementById('<%= txt_produceCost.ClientID%>').innerHTML;
                var tax = document.getElementById('<%= txt_taxCost.ClientID%>');
                var total = document.getElementById('<%= txt_totalCost.ClientID%>');


                if (checkValue == true) {
                    tax.style.visibility = 'hidden';

                    total.innerHTML = prodValue;
                }
                else {
                    tax.style.visibility = "visible";

                    total.innerHTML = parseInt(prodValue) + parseInt(tax.innerHTML);
                }
            }
	        // 주소관련 끝
        </script>
    </form>
</body>
</html>

