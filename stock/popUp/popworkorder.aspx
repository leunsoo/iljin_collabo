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
            border: 1px solid black;
            border-style: solid;
            height: 30px;
            text-align: center;
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
        <div class="pop_wrap" style="width: 210mm; margin-left: auto; margin-right: auto;">
        </div>
        <div class="tar mt15">
            <asp:Button ID="btn_print" runat="server" CssClass="btn_gray btn_150_40" Text="인쇄" OnClientClick="print_page();" />
            <button type="button" id="btn_close" class="btn_150_40 btn_gray ml10" onclick="self.close()">취소</button>

        </div>
        <table class="order_table mt35">
            <tr>
                <td rowspan="3">로고</td>
                <td rowspan="3" >작업지시서</td>
                <td >문서번호</td>
                <td >
                    <asp:Label ID="lbl_serialNo" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>작성자</td>
                <td></td>
            </tr>
            <tr>
                <td>작성일자</td>
                <td>
                    <asp:Label ID="lbl_registrationDate" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
        <div class="mt20">
            <table class="order_table">
                <tr>
                    <td>작업일자</td>
                    <td>
                        <asp:Label ID="lbl_workDate" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td >작업자</td>
                    <td>
                        <asp:Label ID="lbl_foreignIdx" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>작업기계</td>
                    <td>
                        <asp:Label ID="lbl_machineNo" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>지시자</td>
                    <td>
                        <asp:Label ID="lbl_empCode" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>

        <div class="mt20">
            <table class="order_table" style="table-layout:auto">
                <tr>
                    <td colspan="4">작업지시내용</td>
                </tr>
                <tr>
                    <td style="width:10%" >품목</td>
                    <td style="width:50%">
                        <asp:Label ID="lbl_workItem" runat="server"></asp:Label>
                    </td>
                    <td style="width:10%" >수량</td>
                    <td style="width:30%" >
                        <asp:Label ID="lbl_workItemQty" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <div class="mt20">
            <table class="order_table" style="border-bottom:0px;">
                <tr>
                    <td colspan="4" style="text-align: center;">작업결과</td>
                </tr>
                <asp:DataGrid ID="grdTable1" style="border-collapse:separate; border-style: solid; text-align: center; table-layout:auto" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff">
                    <Columns>
                        <asp:TemplateColumn HeaderText="" >
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle CssClass="w10p" />
                        </asp:TemplateColumn> 
                        <asp:TemplateColumn HeaderText="">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle CssClass="w50p" />
                        </asp:TemplateColumn> 
                        <asp:TemplateColumn HeaderText="">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle CssClass="w10p" />
                        </asp:TemplateColumn> 
                        <asp:TemplateColumn HeaderText="">
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle CssClass="w30p" />
                        </asp:TemplateColumn>
                    </Columns>
                </asp:DataGrid>
            </table>
        </div>
        <div class="mt30">
            <table class="order_table">
                <tr>
                    <td colspan="3" style="text-align: center;">비고
                        <br />
                        <br />
                        <asp:TextBox ID="txt_memo" runat="server" Style="overflow: hidden" TextMode="MultiLine" Rows="4"></asp:TextBox>
                        <br />
                    </td>
                </tr>
                <tr>
                    <td>
                        <br />
                        <br />
                        <br />
                    </td>
                    <td style="text-align: center;">작업지시자<br />
                        (서명)
                        <br />
                        <br />
                        <br />
                    </td>
                    <td style="text-align: center;">작업자<br />
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
