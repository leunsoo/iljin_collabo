<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popwarehouse.aspx.cs" Inherits="iljin.popUp.popwarehouse" %>

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
                <span>입고처리</span>
                <asp:HiddenField ID="hidden_idx" runat="server" />
                <asp:HiddenField ID="hidden_cusCode" runat="server" />
            </div>
        </div>
        <div class="title_1 mt20">
            기본정보
        </div>
        <table class="itable_1 mt10">
            <tobody>
                <tr>
                    <th>매입처</th>
                    <td>
                        <asp:Label ID="txt_purchase" runat="server"></asp:Label>
                    </td>
                    <th>계약번호</th>
                    <td>
                        <asp:Label ID="txt_contractno" runat="server"></asp:Label>
                    </td>
                    <th>L/C번호</th>
                    <td>
                        <asp:Label ID="txt_lcNo" runat="server"></asp:Label>
                    </td>
                    <th>BL번호</th>
                    <td>
                        <asp:Label ID="txt_blno" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <th>컨테이너번호</th>
                    <td>
                        <asp:Label ID="txt_containerno" runat="server"></asp:Label>
                    </td>
                    <th>도착예정일</th>
                    <td>
                        <asp:Label ID="txt_arrivaldate" runat="server"></asp:Label>
                    </td>
                    <th></th>
                    <td></td>
                    <th>담당자</th>
                    <td>
                        <asp:Label ID="txt_manager" runat="server"></asp:Label>
                    </td>
                </tr>
        </table>
        <div class="title_1 mt20">입고품목 </div>
        <div class="search_box tar">
            <div class="box_row">
                <span>입고일자</span>
                <asp:TextBox ID="tb_incomedate" runat="server" CssClass="mWt100 txac"></asp:TextBox>
            </div>
        </div>
        <div class="fixed_hs_300 mt10" style="width: 1315px;">
            <table class="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt20p">제품명</th>
                        <th class="mWt10p">제품구분1</th>
                        <th class="mWt10p">제품구분2</th>
                        <th class="mWt5p">두께</th>
                        <th class="mWt5p">폭</th>
                        <th class="mWt5p">길이</th>
                        <th class="mWt5p">개수</th>
                        <th class="mWt10p">중량(kg)</th>
                        <th class="mWt10p">단가($)</th>
                        <th class="mWt20p">가격(USD)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="11">
                            <div style="height: 240px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                <asp:DataGrid ID="grdTable1" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1315">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="" Visible="false">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="0%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="20%" CssClass="" />
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
                                            <ItemStyle Width="5%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass="" />
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
                                            <ItemStyle Width="20%" CssClass="" />
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
                        <th class="mWt55p" colspan="6">Total</th>
                        <th class="mWt5p"><asp:Label ID="txt_totalQty" runat="server"></asp:Label></th>
                        <th class="mWt10p"><asp:Label ID="txt_totalWeigth" runat="server" ></asp:Label></th>
                        <th class="mWt10p"></th>
                        <th class="mWt20p"><asp:Label ID="txt_totalPrice" runat="server" ></asp:Label></th>
                    </tr>
                </tfoot>
            </table>
        </div>
        <div class="tar mt20">
            <asp:Button ID="btn_save" Text="입고저장" runat="server" CssClass="btn_150_40 btn_black" OnClick="btn_save_Click" />
            <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">닫기</button>
        </div>
        <script>
            fDatePickerById("tb_incomedate");

        </script>
    </form>
</body>
</html>
