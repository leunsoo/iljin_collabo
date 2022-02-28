<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popcusregistation.aspx.cs" Inherits="iljin.popUp.popcusregistation" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>iljin</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta http-equiv="X-UA-Compatible" content="ie=edge"/>
    <meta name="format-detection" content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/ibuild.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="/webapp/css/login.css"/>
    <script src="/webapp/js/jquery-3.3.1.min.js"></script>    
    <script src="/js/nissi.js"></script>
    </head>
<body>
    <form id="form1" runat="server">
        <div class="pw_wrap">
            <div class="pw_title">
                <span>거래처 등록</span>
            </div>
            </div>
       <div class="pw_wrap">
            <div class="pw_title">
                <span>해당 거래처의 가입상태를 변경하시겠습니까?</span>
            </div>
            </div> 
        <div class="tac">
        
            <asp:Button ID="btn_approved" CssClass="btn_150_40 btn_navy" runat="server" Text="승인완료"></asp:Button>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <asp:Button ID="btn_reject" CssClass="btn_150_40 btn_gray" runat="server" Text="승인거절"></asp:Button>
            &nbsp;
            </div>

    </form>
</body>
</html>
