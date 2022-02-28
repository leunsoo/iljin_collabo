<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popunitprice_updatelist.aspx.cs" Inherits="iljin.popUp.popunitprice_updatelist" %>

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
</head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>변경이력</span>
                <asp:HiddenField ID="hdn_itemCode" runat="server" />
            </div>
        <div class="fixed_hs_200 mt10" style="width: 400px; overflow:hidden;">
            <table class="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt8p">NO</th>
                        <th class="mWt30p">변경판매단가</th>
                        <th class="mWt37p">적용일</th>
                        <th class="mWt25p">등록자</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="4">
                            <div style="height:160px; overflow-x:hidden;overflow-y:auto; margin:0px;padding:0px;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="400">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="30%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="37%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="25%" CssClass="" />
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
            <div class="tac mt10">
                <asp:Button ID="btn_close" runat="server" CssClass="btn_150_40 btn_gray" OnClientClick="window.close();" Text="닫기" />
            </div>
        </div>
    </form>
</body>
</html>

