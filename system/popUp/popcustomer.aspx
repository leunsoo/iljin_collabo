<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popcustomer.aspx.cs" Inherits="iljin.popUp.popcustomer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>iljin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <meta name="format-detection" content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/jquery-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/jquery-ui.structure.min.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/jquery-ui.theme.min.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/sub.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/ibuild.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/main.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/popUp.css"/>
    <script src="/webapp/js/jquery-1.11.1.min.js"></script>
    <script src="/webapp/js/skyblueUtil.js"></script>
    <script src="/webapp/js/jquery-ui.min.js"></script>
	<script src="/webapp/js/front.js"></script>
      
    </head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>거래처 등록</span>
            </div>

            <div class="tab_base">
                <span>거래처정보</span>
            </div>
              <table class="itable_1">
            <tbody>
                <tr>
                    <th>업체코드</th>
                    <td>
                       <asp:TextBox ID="txt_code" runat="server" ></asp:TextBox>
                    </td>
                    <th>등록일</th>
                    <td>
                     <asp:TextBox ID="txt_registrationdate" runat="server" ></asp:TextBox>   
                </tr>
                  <tr>
                    <th>업체명<span class="red vam"> *</span></th>
                    <td>
                       <asp:TextBox ID="txt_cusname" runat="server" required></asp:TextBox>
                    </td>
                    <th>대표자명</th>
                    <td>
                        <asp:TextBox ID="txt_cusbossname" runat="server" ></asp:TextBox>
                        </td>
                      </tr>
                  <tr>
                    <th>업태</th>
                    <td>
                       <asp:TextBox ID="txt_cusbusiness" runat="server" MaxLength="12" TextMode="Password"></asp:TextBox>
                    </td>
                    <th>사업자번호</th>
                    <td>
                     <asp:TextBox ID="txt_registration" runat="server" MaxLength="12" TextMode="Password"></asp:TextBox>   
                </tr>
                 <tr>
                    <th>업종</th>
                    <td>
                       <asp:TextBox ID="txt_comType" runat="server" ></asp:TextBox>
                    </td>
                    <th>전화</th>
                    <td>
                       <asp:TextBox ID="txt_cusTel" runat="server" ></asp:TextBox>
                    </td>
                </tr>
                 <tr>
                    <th>이메일</th>
                    <td>
                       <asp:TextBox ID="txt_commail" runat="server" ></asp:TextBox>
                    </td>
                    <th>팩스</th>
                    <td>
                        <asp:TextBox ID="txt_comFax" runat="server" ></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>인보이스 코드</th>
                    <td>
                       <asp:TextBox ID="txt_cusinvoicecode" runat="server" ></asp:TextBox>
                    </td>
                    <th>비고</th>
                    <td>
                       <asp:TextBox ID="txt_memo" runat="server" ></asp:TextBox>
                    </td>
                </tr>
                 
                <tr>
                    <th>마스터 아이디<span class="red vam"> *</span></th>
                    <td>
                       <asp:TextBox ID="txt_cusmasterId" CssClass="w70p" runat="server" required></asp:TextBox> <asp:Button ID="btn_overlap" CssClass="btn_black btn_80_30" runat="server" Text="중복확인"></asp:Button>
                    </td>
                    <th>비밀번호<span class="red vam"> *</span></th>
                    <td>
                        <asp:TextBox ID="txt_cuspassword" runat="server" required></asp:TextBox>
                    </td>
                </tr>
                
                <tr>
                    <th>주소</th>
                    <td colspan="3">
                        <div>
                            <asp:TextBox ID="txt_zipcode" runat="server" CssClass="w15p" placeholder="우편번호"></asp:TextBox>
                            <button type="button" class="btn_black btn_80_30" onclick="OpenZipcode()">주소찾기</button>
                        </div>
                        <div class="mt7">
                            <asp:TextBox ID="txt_address1" runat="server" CssClass="w60p" placeholder="기본주소"></asp:TextBox>
                            <asp:TextBox ID="txt_address2" runat="server" CssClass="w35p ml0" placeholder="상세주소"></asp:TextBox>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>사용유무</th>
                    <td>
                        <asp:DropDownList ID="cb_isuse2" runat="server"></asp:DropDownList>
                    </td>
                    <th>정산기준일</th>
                    <td>
                        <asp:DropDownList ID="cb_SettlementCode" runat="server"></asp:DropDownList>
                    </td>
                </tr> 
            </tbody>
        </table> <!-- itable_1 -->
            <div class="tac mt20">
            <button type="button" class="btn_150_40 btn_gray" onclick="self.close()">닫기</button>
            <asp:Button ID="btn_save" CssClass="btn_150_40 btn_black ml5" runat="server" Text="저장"></asp:Button>
                </div>

        </div>
      <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script src="//spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
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
            $("input[name='txt_zipcode']").val(data.zonecode);
            $("input[name='txt_address1']").val(fullRoadAddr);
            $("input[name='txt_address2']").val(extraRoadAddr);
        } catch (e) { }

    };
	// 주소관련 끝
</script>
    </form>
</body>
</html>
