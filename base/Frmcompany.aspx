<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmcompany.aspx.cs" Inherits="iljin.Frmcompany" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class="conts_inner mWt1000">
        <h2 class="conts_tit">
            <asp:Label ID="m_title" runat="server" Text="기준정보관리 ::> 회사정보"></asp:Label></h2>
        <asp:HiddenField ID="hidden_comid" runat="server" />
        <div class="buttonRight mt10 ">

            <asp:Button ID="btn_save" CssClass="btn_150_40 btn_black" runat="server" Text="저장" OnClick="btn_save_Click"></asp:Button>
        </div>
        <table class="itable_1 mt10">
            <tbody>
                <tr>
                    <th class="mWt150">회사명</th>
                    <td class="mWt300">
                        <asp:TextBox ID="txt_com_name" runat="server" required></asp:TextBox>
                    </td>
                    <th class="mWt150">법인번호</th>
                    <td class="mWt300">
                        <asp:TextBox ID="txt_corporate_no" runat="server" required></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>대표자명</th>
                    <td>
                        <asp:TextBox ID="txt_ceo_name" runat="server" required></asp:TextBox>
                    </td>
                    <th>사업자번호</th>
                    <td>
                        <asp:TextBox ID="txt_com_no" runat="server" required></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>업태</th>
                    <td>
                        <asp:TextBox ID="txt_com_business_conditions" runat="server" required></asp:TextBox>
                    </td>
                    <th>종목</th>
                    <td>
                        <asp:TextBox ID="txt_com_business_type" runat="server" required></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>전화</th>
                    <td>
                        <asp:TextBox ID="txt_com_tel" runat="server" required></asp:TextBox>
                    </td>
                    <th>휴대폰</th>
                    <td>
                        <asp:TextBox ID="txt_com_hp" runat="server" required></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>팩스</th>
                    <td>
                        <asp:TextBox ID="txt_com_fax" runat="server" required></asp:TextBox>
                    </td>
                    <th>이메일</th>
                    <td>
                        <asp:TextBox ID="txt_com_email" runat="server" required></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>업체로고<br />
                        (투명(PNG)이미지 300&times;100 권장)</th>
                    <td>
                        <div class="logo_photo_reg">
                            <div class="lpr_photo">
                                <img src="../webapp/img/logo_photo.jpg" id="logo_prev" alt="logo" runat="server"/></div>
                            <div class="lpr_button">
                                <div><button type="button" class="btn_black btn_80_30" onclick="logo_reg();">찾아보기</button></div>
                                <div><button type="button" id="btn_del_logo"  class="btn_text" runat="server" onserverclick="btn_del_logo_ServerClick">삭제</button></div>
                            </div>
                            <asp:FileUpload ID="fl_logo_input" runat="server" class="hidden" />
                        </div>
                        <!-- logo_photo_reg -->
                    </td>
                    <th>업체도장<br />
                        (투명(PNG)이미지 150&times;150 권장)</th>
                    <td>
                        <div class="stamp_photo_reg">
                            <div class="lpr_photo">
                                <img src="../webapp/img/stamp_photo.jpg" id="stamp_prev" alt="stamp" runat="server"/></div>
                            <div class="lpr_button">
                                <div><button type="button" class="btn_black btn_80_30" onclick="stamp_reg();">찾아보기</button></div>
                                <div><button type="button" id="btn_del_stamp"   class="btn_text" runat="server" onserverclick="btn_del_stamp_ServerClick">삭제</button></div>
                            </div>
                            <asp:FileUpload ID="fl_stamp_input" runat="server" class="hidden" />
                        </div>
                        <!-- stamp_photo_reg -->
                    </td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td colspan="3">
                        <div>
                            <asp:TextBox ID="txt_com_post" runat="server" CssClass="mWt45p" placeholder="우편번호" required></asp:TextBox>
                            <button type="button" class="btn_black btn_80_30 ml10" onclick="OpenZipcode()">주소찾기</button>
                        </div>
                        <div class="mt7">
                            <asp:TextBox ID="txt_com_addr" runat="server" CssClass="mWt45p" placeholder="기본주소" required></asp:TextBox>
                            <asp:TextBox ID="txt_com_addr2" runat="server" CssClass="mWt45p ml15" placeholder="상세주소" required></asp:TextBox>
                        </div>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="title_1">※ 세금계산서 업무 담당자</div>
        <table class="itable_1">
            <tbody>
                <tr>
                    <th class="mWt150">담당자명</th>
                    <td class="mWt300">
                        <asp:TextBox ID="txt_manager" runat="server" required></asp:TextBox>
                    </td>
                    <th class="mWt150">담당 전화</th>
                    <td class="mWt300">
                        <asp:TextBox ID="txt_manager_tel" runat="server" required></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>담당 이메일</th>
                    <td>
                        <asp:TextBox ID="txt_manager_email" runat="server" required></asp:TextBox>
                    </td>
                    <th>담당 휴대폰</th>
                    <td>
                        <asp:TextBox ID="txt_manager_hp" runat="server" required></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <th>메모</th>
                    <td colspan="3">
                        <textarea id="ta_memo" class="txa_base" runat="server"></textarea></td>
                </tr>
            </tbody>
        </table>
        <!-- itable_1 -->
    </article>

    <%--<script src="https://dmaps.daum.net/map_js_init/postcode.v2.js"></script>--%>
    <script src="//spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
    <script type="text/javascript">
        // 로고 미리보기
        function readURL_logo(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ContentPlaceHolder2_logo_prev').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        // 로고 이미지 변경
        $("#ContentPlaceHolder2_fl_logo_input").on("change", function () {
            readURL_logo(this);
        });

        // 로고 찾아보기 클릭
        function logo_reg() {
            $("#ContentPlaceHolder2_fl_logo_input").click();
        }

        // 로고 삭제
        function logo_del() {
            $('#ContentPlaceHolder2_logo_prev').attr('src', '../webapp/img/logo_photo.jpg');
            $("#ContentPlaceHolder2_fl_logo_input").val("");
        }
        // 도장 미리보기
        function readURL_stamp(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#ContentPlaceHolder2_stamp_prev').attr('src', e.target.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        // 도장 이미지 변경
        $("#ContentPlaceHolder2_fl_stamp_input").on("change", function () {
            readURL_stamp(this);
        });

        // 도장 찾아보기 클릭
        function stamp_reg() {
            $("#ContentPlaceHolder2_fl_stamp_input").click();
        }

        // 도장 삭제
        function stamp_del() {
            $('#ContentPlaceHolder2_stamp_prev').attr('src', '../webapp/img/stamp_photo.jpg');
            $("#ContentPlaceHolder2_fl_stamp_input").val("");
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
                $("input[name='ctl00$ContentPlaceHolder2$txt_com_post']").val(data.zonecode);
                $("input[name='ctl00$ContentPlaceHolder2$txt_com_addr']").val(fullRoadAddr);
                $("input[name='ctl00$ContentPlaceHolder2$txt_com_addr2']").val(extraRoadAddr);
            } catch (e) { }

        };
	// 주소관련 끝

    </script>
</asp:Content>


