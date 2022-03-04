<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popcollectmoney.aspx.cs" Inherits="iljin.popUp.popcollectmoney" %>

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
</head>
<body>
    <form id="form1" runat="server">
        <div class="pop_wrap">
            <div class="pop_title">
                <span>수금등록</span>
                <asp:HiddenField ID="hdn_selectedRow" runat="server" />
                <asp:HiddenField ID="hdn_cusCode" runat="server" />
                <asp:Button ID="btn_update_hdn" runat="server" CssClass="hidden" OnClick="btn_update_hdn_Click" />
                <asp:Button ID="btn_delete_hdn" runat="server" CssClass="hidden" OnClick="btn_delete_hdn_Click" />
                </div> 
            </div>
        <table class="itable_1 mt10">
            <tobody>
                <tr>
                    <th>수금일자<span class="red vam">*</span></th>
                    <td>
                     <asp:TextBox ID="txt_colletdate" runat="server" CssClass="w80p"></asp:TextBox>
                    </td>
                    <th>수금액<span class="red vam">*</span></th>
                       <td>
                       <asp:TextBox ID="txt_price" runat="server"></asp:TextBox>
                    </td> 
                    
                </tr>    
        </table>
        <div class="tac mt10">
            <asp:Button ID="btn_registration" runat="server" CssClass="btn_100_30 btn_navy" Text="등록" OnClick="btn_registration_Click" ></asp:Button>
        </div>
         <div class ="fixed_hs_300 mt10" style="width:600px; overflow:hidden;">
            <table class ="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt10p">NO.</th>
                        <th class="mWt32p">수금일자</th>
                        <th class="mWt28p">수금액</th>
                        <th class="mWt30p">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan ="4">
                             <div style=" height:250px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;" class="auto-style1">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="600">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText ="">                   
                                            <HeaderStyle HorizontalAlign="Center" />                                    
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <ItemTemplate>
                                                <asp:Label ID="lb_date" runat="server"></asp:Label>
                                                <asp:TextBox ID="txt_date" runat="server" CssClass="w80p" Visible="false"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="30%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <ItemTemplate>
                                                <asp:Label ID="lb_price" runat="server"></asp:Label>
                                                <asp:TextBox ID="txt_price" runat="server" Visible="false"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="25%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <ItemTemplate>
                                             <asp:Button ID="btn_correction" runat="server" CssClass="btn_60_25 btn_navy" Text="수정" ></asp:Button>
                                             <asp:Button ID="btn_del" runat="server" CssClass="btn_60_25 btn_red ml10" Text="삭제" ></asp:Button>
                                             <asp:HiddenField ID="hdn_idx" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="30%" CssClass="" />
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
       <script>
           fDatePickerById("txt_colletdate");
           fDatePickerById2("grdTable_txt_date");

           function updateFunc(row) {
               document.getElementById('<%= hdn_selectedRow.ClientID%>').value = row;
               document.getElementById('<%= btn_update_hdn.ClientID %>').click();
           }

           function deleteFunc(row) {
               document.getElementById('<%= hdn_selectedRow.ClientID%>').value = row;
               document.getElementById('<%= btn_delete_hdn.ClientID %>').click();
           }
       </script>
    </form>
</body>
</html>

