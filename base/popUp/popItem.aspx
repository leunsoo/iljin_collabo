<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popItem.aspx.cs" Inherits="iljin.popUp.popItem" %>

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
            height: 28px;
        }
    </style>
    <script type="text/javascript">
        function overlapReset() {
            var overlap = document.getElementById('<%=hdn_overlapChk.ClientID%>').value;

            if (overlap = 1) {
                document.getElementById('<%=hdn_overlapChk.ClientID%>').value = 0;
            }
        }
        function AutoCreateName() {
            var itemName = document.getElementById('<%= tb_itemName.ClientID %>');

            var cb_div1 = document.getElementById('<%= cb_itemType1.ClientID %>');
            var div1 = cb_div1.options[cb_div1.selectedIndex].text;
            var cb_div2 = document.getElementById('<%= cb_itemType2.ClientID %>');
            var div2 = cb_div2.options.length > 0 ? cb_div2.options[cb_div2.selectedIndex].text : '';

            var thickness = document.getElementById('<%= tb_thickness.ClientID %>').value;
            var width = document.getElementById('<%= tb_width.ClientID %>').value;
            var length = document.getElementById('<%= tb_length.ClientID %>').value;

            itemName.value = div1 + (div2 ? '_' + div2 : '') + (thickness ? '_' + thickness : '') + (width ? '_' + width : '') + (length ? '_' + length : '');
        }
        function onChange() {
            AutoCreateName();
            overlapReset();
        }
        function test() {
        }
    </script>
</head>
<body>
    <form id="form1" runat="server" defaultbutton="btn_save">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>제품등록</span>
                <asp:HiddenField ID="hdn_overlapChk" runat="server" />
                <asp:HiddenField ID="hdn_code" runat="server" />
            </div>
            <table class="itable_1 mt10">
                <tbody>
                    <tr>
                        <th class="w15p">제품코드</th>
                        <td class="w18p">
                            <asp:TextBox ID="tb_itemCode" ReadOnly="true" runat="server"></asp:TextBox>
                        </td>
                        <th class="w15p">제품구분1</th>
                        <td class="w19p">
                            <asp:DropDownList ID="cb_itemType1" runat="server" OnSelectedIndexChanged="cb_itemType1_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                        </td>
                        <th class="w15p">제품구분2</th>
                        <td class="w18p">
                            <asp:DropDownList ID="cb_itemType2" runat="server" onchange="javascript:onChange();"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <th>두께<span class="red vam"> *</span></th>
                        <td>
                            <asp:TextBox ID="tb_thickness" runat="server" onchange="javascript:onChange();" CssClass="w100p" required></asp:TextBox>
                        </td>
                        <th>폭<span class="red vam"> *</span></th>
                        <td>
                            <asp:TextBox ID="tb_width" runat="server" onchange="javascript:onChange();" TextMode="Number" CssClass="w100p" required></asp:TextBox>
                        </td>
                        <th>길이<span class="red vam"> *</span></th>
                        <td>
                            <asp:TextBox ID="tb_length" runat="server" onchange="javascript:onChange();" TextMode="Number" CssClass="w100p" required></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <th>단가</th>
                        <td>
                            <asp:TextBox ID="tb_unitprice" runat="server" TextMode="Number" CssClass="w100p"></asp:TextBox>
                        </td>
                        <th></th>
                        <td class="tac">
                        </td>
                        <th></th>
                        <td></td>
                    </tr>
                    <tr>
                        <th>제품명</th>
                        <td colspan="5">
                            <asp:TextBox ID="tb_itemName" runat="server" CssClass="w70p"></asp:TextBox>
                            <asp:Button ID="btn_overlap" runat="server" CssClass="btn_black btn_80_30 ml15" Text="중복확인" OnClick="btn_overlap_Click" />
                        </td>
                    </tr>
                    <tr>
                        <th>중량</th>
                        <td>
                            <asp:TextBox ID="tb_weight" runat="server" CssClass="w100p"></asp:TextBox>
                        </td>
                        <th>단위</th>
                        <td>
                            <asp:DropDownList ID="cb_unit" runat="server"></asp:DropDownList>
                        </td>
                        <th></th>
                        <td></td>
                    </tr>
                    <tr>
                        <th>비고</th>
                        <td colspan="5">
                            <asp:TextBox ID="tb_memo" runat="server"></asp:TextBox>
                        </td>
                    </tr>
                </tbody>
            </table>
            <br />
            <div class="mt20">
                <asp:Button ID="btn_del" runat="server" CssClass="btn_150_40 btn_red" Text="삭제" OnClick="btn_del_Click" />
                <asp:Button ID="btn_close" runat="server" CssClass="btn_150_40 btn_gray ml15 ft_right" OnClientClick="window.close();" Text="닫기" />
                <asp:Button ID="btn_save" runat="server" CssClass="btn_150_40 btn_black ft_right" Text="저장" OnClick="btn_save_Click" />
            </div>
        </div>
    </form>
</body>
</html>

