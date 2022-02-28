<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmtaxbillwrite.aspx.cs" Inherits="iljin.Frmtaxbillwrite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class ="conts_inner">
        <h2 class="conts_tit"><asp:Label ID="m_title" runat="server" Text="경리업무 ::> 세금계산서 작성"></asp:Label></h2>
        <div class ="search_box">
            <div class ="box_row">
                <span>주문일자</span>
                <asp:TextBox ID="tb_orderdate" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                ~
                <asp:TextBox ID="tb_orderdate2" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                <span class="ml20">거래처</span>
                <asp:DropDownList ID ="tb_customer" runat="server" CssClass="mWt150"></asp:DropDownList>
                
                
                 <asp:Button ID ="btn_sch" runat="server" CssClass="btn_navy btn_100_30 ml10" Text="조회" />
                 <button type="button" runat="server" class="btn_black btn_100_30 ml10" onclick="taxbill()">세금계산서 발행</button> 
                 <button type="button" runat="server" class="btn_black btn_100_30 ml10" onclick="separate()">별도발행</button>     
                                                                                                                      
         </div>
            </div>
        <div class ="fixed_hs_800 mt10" style="width:1190px; overflow:hidden;">
            <table class ="grtable_th">
                <thead>
                    <tr>
                       
                        <th class="mWt9p">
                       <asp:CheckBox ID="CheckBox1" runat="server" /></th>
                        <th class="mWt9p">거래처명</th>
                        <th class="mWt9p">주문일</th>
                        <th class="mWt9p">주문번호</th>
                        <th class="mWt9p">제품명</th>
                        <th class="mWt9p">수량</th>
                        <th class="mWt9p">단가</th>
                        <th class="mWt9p">공급가액</th>
                        <th class="mWt9p">부가세</th>
                        <th class="mWt9p">합계액</th>
                        <th class="mWt9p">발행</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan ="11">
                             <div style=" height:400px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
               
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText ="">
                                            <ItemTemplate>
                                            <asp:CheckBox ID="CheckBox1" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />             
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                             <ItemTemplate>
                                              <button type="button" runat="server" class="btn_gray btn_100_30">발행완료</button>                                       
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="9%" CssClass="" />
                                        </asp:TemplateColumn>
                                       
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
       <div class="tar">
      <asp:Button ID ="btn_previous" runat="server" CssClass="btn_black btn_100_30 ml10" Text="이전화면" OnClientClick="move_to_previous();return false;" />

       </div>   
    </article>
    <script>
        fDatePickerById("ContentPlaceHolder2_tb_orderdate");
        fDatePickerById("ContentPlaceHolder2_tb_orderdate2");
    </script>
     <script>
         function taxbill() {
             var url = "/accounting/popUp/poptaxbill.aspx";
             var name = "_blank"
             var popupX = (window.screen.width / 2) - (730 / 2);
             var popupY = (window.screen.height / 2) - (500 / 2);
             window.open(url, name, 'status=no, width=730, height=500, left=' + popupX + ',top=' + popupY);

         }
         function separate() {
             var url = "/accounting/popUp/popseparate.aspx";
             var name = "_blank"
             var popupX = (window.screen.width / 2) - (730 / 2);
             var popupY = (window.screen.height / 2) - (500 / 2);
             window.open(url, name, 'status=no, width=730, height=500, left=' + popupX + ',top=' + popupY);

         }
         function move_to_previous() {
             location.href = 'accounting/Frmtaxbill/aspx';
         }
     </script>
</asp:Content>

