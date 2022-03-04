<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popsample.aspx.cs" Inherits="iljin.popUp.popsample" %>

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
                <span>샘플등록</span>
                <asp:HiddenField ID="hdn_idx" runat="server" />
                <asp:HiddenField ID="hdn_userCode" runat="server" />
                </div>
            </div>
        <table class="itable_1 mt10">
            <tobody>
                <tr>
                    <th>등록일</th>
                    <td>
                     <asp:Label ID="txt_registrationdate" runat="server" ></asp:Label>
                    </td>
                    <th>등록자</th>
                       <td>
                       <asp:Label ID="txt_register" runat="server"></asp:Label>
                    </td>
                      <th>샘플명</th>
                       <td>
                       <asp:TextBox ID="txt_samplename" runat="server"></asp:TextBox>
                    </td>
                </tr>                                        
                <tr>
                     <th>거래처</th>
                    <td> 
                        <asp:TextBox ID="txt_customer" runat="server"></asp:TextBox>
                    </td>
                    <th>샘플수량</th>
                    <td>
                    <asp:TextBox ID="txt_sampleQty" runat="server"></asp:TextBox>
                    </td>
                     <th></th>
                    <td></td>
                </tr>
                
                <tr>
                    <th>비고</th>
                    <td colspan="5">
                  <asp:TextBox ID="txt_memo" runat="server"></asp:TextBox>
                    </td>
                </tr>
        </table>
        <div class="tar mt20">
            <asp:Button ID="btn_save" Text="저장" CssClass="btn_150_40 btn_black" runat="server" OnClick="btn_save_Click"/>
            <button type="button" class="btn_150_40 btn_gray ml10" onclick="self.close()">목록</button>
        </div>
    </form>
</body>
    
</html>
