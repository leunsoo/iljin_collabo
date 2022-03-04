<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="popfinal.aspx.cs" Inherits="iljin.popUp.popfinal" %>

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
    <script src="/webapp/js/jquery-1.11.1.min.js"></script>
    <script src="/webapp/js/skyblueUtil.js"></script>
    <script src="/webapp/js/jquery-ui.min.js"></script>
    <script src="/webapp/js/front.js"></script>
    <style>
        body {
            background-image: url('/webapp/img/doc.jpg');
            background-repeat: no-repeat;
            background-size: cover;
            padding: 0;
        }

        .BodyDiv {
            height: 297mm;
            width: 210mm;
        }

        .TopDiv {
            position:relative;
            left:15.4mm;
            top:3.5mm;
            width: 174mm;
            height: 126mm;
        }
        .TopDiv > span {
            position:relative;
        }

        table {
            position:relative;
            top:43.5mm;
        }

        .TopDiv > span
        {
            position:relative;
        }

        table > tr 
        {
            position:relative;
        }

        table > tr > td
        {
            position:relative;
        }

        .testTd {
            height: 9.5mm;
        }

        .BottomDiv {
            position:relative;
            left:15.4mm;
            top:25.3mm;
            width: 174mm;
            height: 126mm;
        }
        .BottomDiv > span {
            position:relative;
        }

        .BottomDiv > span
        {
            position:relative;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HiddenField ID="hidden_code" runat="server" />
            <asp:HiddenField ID="hidden_div" runat="server" />
        </div>
        <div style="top:5mm; left:3mm; position:relative">
        <div id="testDiv">
        <div class="BodyDiv">
            <div class="TopDiv">
                <span id ="tradeDt" runat="server"></span>
                <span id ="sender" runat="server"></span>
                <span id="registration" runat="server"></span>
                <span id="companyName" runat="server"></span>
                <span id="managerName" runat="server"></span>
                <span id="address" runat="server"></span>
                <span id="business" runat="server"></span>
                <span id="businessType" runat="server"></span>
                <span id="email" runat="server"></span>
                <span id="managerTel" runat="server"></span>
                <span id="fax" runat="server"></span>
<%--                <span style="top:18mm;left:18.5mm;">2021-08-06(금)</span>
                <span style="left:88mm;">123-45-6789</span>--%>
        <div>
            <table>
                <thead>
                    <tr>
                        <th>No.</th>
                        <th>품 목 - 규 격</th>
                        <th>단위</th>
                        <th>수량</th>
                        <th>단가</th>
                        <th>공급가액</th>
                        <th>세액</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan="7">
                            <div style="height: 225px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                <asp:DataGrid ID="grdTable" runat="server" AllowCustomPaging="True" ShowHeader="False" AutoGenerateColumns="False" GridLines="both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="650">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="5%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="20%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="35%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="15%" CssClass="" />
                                        </asp:TemplateColumn>
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
            </div>
    <%--        <div class="BottomDiv">
                <span style="top:18mm;left:18.5mm;">2021-08-06(금)</span>
                <span style="left:88mm;">123-45-6789</span>
                <table>
                    <tr>
                        <td class="testTd">테스트1</td>
                    </tr>
                    <tr>
                        <td class="testTd">테스트2</td>
                    </tr>
                    <tr>
                        <td class="testTd">테스트3</td>
                    </tr>
                    <tr>
                        <td class="testTd">테스트4</td>
                    </tr>
                    <tr>
                        <td class="testTd">테스트5</td>
                    </tr>
                    <tr>
                        <td class="testTd">테스트6</td>
                    </tr>

                </table>
            </div>--%>
        </div>
            </div>
        </div>

        <%-- <table style="border-style: solid;" >
    <tr>
     <td style="border:1px solid" colspan="3" rowspan="2">거래명세표(공급자 보관용)</td>
     <td style="border:1px solid" rowspan="6">공<br />
         급<br />
         자</td>
     <td style="border:1px solid">등록번호</td>
     <td style="border:1px solid"colspan="3"> </td>

    </tr>
    <tr>
     <td style="border:1px solid" >상호<br />
         (법인명)</td>
     <td style="border:1px solid"> &nbsp;</td>
     <td style="border:1px solid" > 성명<br />
         (대표자)</td>
    <td style="border:1px solid"> &nbsp;</td> 
    </tr>
     <tr>
     <td  style="border:1px solid" rowspan="2">거래일:<br /> 귀하</td>
     <td  style="border:1px solid"> 전잔액</td>
    <td  style="border:1px solid" ></td>
     <td  style="border:1px solid">사업장 
         <br />주소</td>
     <td  style="border:1px solid" colspan="3"></td>
</tr>
 
   
   
     <tr>
    <td  style="border:1px solid" >전잔액<br />
        +출고액</td>
    <td  style="border:1px solid" ></td>
    <td  style="border:1px solid" >업태</td>
    <td  style="border:1px solid"></td>
   <td  style="border:1px solid">종<br />
       목</td>
 <td  style="border:1px solid" ></td>
</tr>
           
  <tr>
     <td  style="border:1px solid" rowspan="2">합계금액</td>
     <td  style="border:1px solid">입금액 </td>
     <td  style="border:1px solid"> </td>
     <td  style="border:1px solid"> E-mail </td>
        <td  style="border:1px solid" colspan="3"> </td>
    </tr>
     <tr>
     <td  style="border:1px solid" >현잔액</td>
     <td  style="border:1px solid" > </td>
     <td  style="border:1px solid" > 담당연락처</td>
     <td  style="border:1px solid" > </td>
     <td  style="border:1px solid"> 팩<br />
         스</td>
     <td  style="border:1px solid"> </td>
    </tr>
           
    <tr>
     <td  style="border:1px solid">NO</td>
     <td  style="border:1px solid"  colspan="2"> 품목-규격</td>
        <td  style="border:1px solid" >단위</td>
        <td  style="border:1px solid" >수량</td>
        <td  style="border:1px solid" >단가</td>
        <td  style="border:1px solid" >공급가액</td>
        <td  style="border:1px solid" >새액</td>
    </tr>
<tr>
<td  style="border:1px solid" >1</td>
     <td  style="border:1px solid"  colspan="2"></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
    </tr>
  <tr>
<td  style="border:1px solid" >2</td>
  <td  style="border:1px solid" " colspan="2"></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid"></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
    </tr>
   <tr>
<td  style="border:1px solid">3</td>
     <td  style="border:1px solid"  colspan="2"></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid"></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
    </tr>
             <tr>
<td  style="border:1px solid" >4</td>
     <td  style="border:1px solid" colspan="2"></td>
        <td  style="border:1px solid"></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
    </tr>
<tr>
<td  style="border:1px solid" rowspan="3">참<br />
    고<br />
    사<br />
    항</td>
 <td  style="border:1px solid" colspan="2" rowspan="3"></td>
        <td  style="border:1px solid">합계</td>
        <td  style="border:1px solid" >100</td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
</tr>
 <tr>
       <td  style="border:1px solid"></td>
        <td  style="border:1px solid" >10</td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
        <td  style="border:1px solid" ></td>
 </tr>   
             <tr>
       <td  style="border:1px solid" colspan="3"></td>
        <td  style="border:1px solid" >인<br />
            수<br />
            자</td>
        <td  style="border:1px solid" ></td>
 </tr>            
</table>--%>
        <div>
            <button id="finish" onclick="content_print()" style="position: absolute; left: 640px; top: 1075px;" class="btn_black btn_150_40">출고완료</button>
        </div>
        <script type="text/javascript">
            function printDiv() {
                var divToPrint = document.getElementById('testDiv');
                //var newWin = window.open('', 'Print-Window');
                //document.open();
                document.write('<html><body onload="window.print()">' + divToPrint.innerHTML + '</body></html>');
                //document.close();
                setTimeout(function () { newWin.close(); }, 10);
            }

            function content_print() {

                var initBody = document.body.innerHTML;
                window.onbeforeprint = function () {
                    document.body.innerHTML = document.getElementById('testDiv').innerHTML;
                    var tset = document.body.innerHTML;
                }
                window.onafterprint = function () {
                    document.body.innerHTML = initBody;
                }
                window.print();
            }
        </script>
    </form>
</body>
</html>
