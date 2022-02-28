<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popworkorder.aspx.cs" Inherits="iljin.popUp.popworkorder" %>

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
    <style type="text/css">
    </style>
    <style>
        .order_table {
            border-style: solid;
        }

        table.order_table > tbody > tr > td {
            border: 1px solid;
            height:30px;
        }
    </style>
    <script>
        function print_page() {
            document.getElementById("<%=btn_print.ClientID%>").style.visibility = "hidden";
            document.getElementById('btn_close').style.visibility = "hidden";
            window.print();
            document.getElementById("<%=btn_print.ClientID%>").style.visibility = "visible";
            window.opener.updateStatus();
            window.close();
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap" style="width:210mm;margin-left:auto;margin-right:auto;">
        </div>
        <div class="tar mt15">
            <asp:Button ID="btn_print" runat="server" CssClass="btn_gray btn_150_40" Text="인쇄" OnClientClick="print_page();"  />
           <button type="button" id="btn_close" class="btn_150_40 btn_gray ml10" onclick="self.close()">취소</button>

        </div>
        <table class="order_table mt35">
            <tr>
                <td rowspan="3" style="text-align:center;">로고</td>
                <td rowspan="3" style="text-align:center;">작업지시서</td>
                <td style="text-align:center;">문서번호</td>
                <td style="text-align:center;">
                    <asp:Label ID="lbl_serialNo" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align:center;">작성자</td>
                <td style="text-align:center;"></td>
            </tr>
            <tr>
                <td style="text-align:center;">작성일자</td>
                <td style="text-align:center;">
                    <asp:Label ID="lbl_registrationDate" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <div class="mt20">
            <table class="order_table">
                <tr>
                    <td style="text-align:center;">작업일자</td>
                    <td style="text-align:center;">
                        <asp:Label ID="lbl_workDate" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">작업자</td>
                    <td style="text-align:center;">
                        <asp:Label ID="lbl_foreignIdx" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">작업기계</td>
                    <td style="text-align:center;">
                        <asp:Label ID="lbl_machineNo" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">지시자</td>
                    <td style="text-align:center;">
                        <asp:Label ID="lbl_empCode" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>

        <div class="mt20">
            <table class="order_table">
                <tr>
                    <td colspan="3" style="text-align:center;">작업지시내용</td>
                </tr>
                <tr>
                    <td rowspan="2" style="text-align:center;">작업전</td>
                    <td style="text-align:center;">품목</td>
                    <td style="text-align:center;">
                        <asp:Label ID="lbl_workItem" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">수량</td>
                    <td style="text-align:center;">
                        <asp:Label ID="lbl_workItemQty" runat="server"></asp:Label>
                    </td>

                </tr>
                <tr>
                    <td rowspan="2" style="text-align:center;">작업후</td>
                    <td style="text-align:center;">품목</td>
                    <td style="text-align:center;">
                        <asp:Label ID="lbl_produceItem" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="text-align:center;">수량</td>
                    <td style="text-align:center;">
                        <asp:Label ID="lbl_produceItemQty" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="mt20">
            <table class="order_table">

                <tr>
                    <td colspan="3" style="text-align:center;">작업결과</td>
                </tr>
                <tr>
                    <td rowspan="2" style="text-align:center;">작업후</td>
                    <td style="text-align:center;">품목</td>
                    <td style="text-align:center;"></td>
                </tr>
                <tr>
                    <td style="text-align:center;">수량</td>
                    <td style="text-align:center;"></td>

                </tr>
            </table>
        </div>
        <div class="mt10">
            <table class="order_table">
                <tr>
                    <td colspan="3" style="text-align:center;">비고
    <br />
                        <br />
                       
                        <asp:TextBox ID="txt_memo" runat="server" style="overflow:hidden" TextMode="MultiLine" Rows="5" ></asp:TextBox>
                       <%-- <textarea id="ta_memo" runat="server" style="height:70px"></textarea> --%>
                        <br />

                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <br />
                        <br />
                        <br />
                    </td>
                    <td style="text-align:center;">작업지시자<br />
                        (서명)
      <br />
                        <br />
                        <br />
                        <br />
                    </td>
                    <td style="text-align:center;">작업자<br />
                        (서명)<br />
                        <br />
                        <br />
                    </td>
                </tr>
            </table>
        </div>
        <br />
    </form>
</body>
</html>
