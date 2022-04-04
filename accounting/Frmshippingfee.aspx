<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmshippingfee.aspx.cs" Inherits="iljin.Menu.accounting.Frmshippingfee" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <article class ="conts_inner">
        <h2 class="conts_tit"><asp:Label ID="m_title" runat="server" Text="경리업무 ::> 출하용달료관리"></asp:Label></h2>
        <div class ="search_box">
            <div class ="box_row">
                <span>일자</span>
                <asp:TextBox ID="tb_date" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                ~
                <asp:TextBox ID="tb_date2" runat="server" CssClass="mWt100 txac"></asp:TextBox>
                <asp:Button ID="btn_update_hdn" runat="server" CssClass="hidden" OnClick="btn_update_hdn_Click" />
                <asp:HiddenField ID="hdn_selectedRow" runat="server" />
                <asp:Button ID ="btn_sch" runat="server" CssClass="btn_navy btn_100_30 ml10" Text="조회" OnClick="btn_sch_Click" />
                 <asp:Button ID="btn_excel" runat="server" CssClass="btn_100_30 btn_green ml10" Text="엑셀다운로드" OnClick="btn_excel_Click" />
         </div>
            </div>
           <div class="fixed_hs_650 mt10" style="width: 1190px; overflow: hidden;">
            <table class ="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt4p">NO</th>
                        <th class="mWt8p">일자</th>
                        <th class="mWt10p">매출처</th>
                        <th class="mWt12p">입고처</th>
                        <th class="mWt6p">이름</th>
                        <th class="mWt8p">연락처</th>
                        <th class="mWt8p">사업자번호</th>
                        <th class="mWt7p">공급가액</th>
                        <th class="mWt7p">총액</th>
                        <th class="mWt6p">은행명</th>
                        <th class="mWt8p">계좌번호</th>
                        <th class="mWt10p">지급일</th>
                         <th class="mWt6p">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan ="13">
                             <div style=" height:600px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
               
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText ="">                       
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="4%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="12%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="6%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="7%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="7%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="6%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txt_paymentdate" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                             <ItemTemplate>
                                                 <asp:Button ID="btn_update" runat="server" CssClass="btn_60_25 btn_navy" Text="수정" />
                                                 <asp:HiddenField ID="hdn_idx" runat="server" />
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="6%" CssClass="" />
                                        </asp:TemplateColumn>
                                       
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    
              <div id="exceldiv3" runat="server" class="hidden"  style="width: 1190px; overflow: hidden;">
            <table class ="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt4p">NO</th>
                        <th class="mWt8p">일자</th>
                        <th class="mWt10p">매출처</th>
                        <th class="mWt12p">입고처</th>
                        <th class="mWt6p">이름</th>
                        <th class="mWt8p">연락처</th>
                        <th class="mWt8p">사업자번호</th>
                        <th class="mWt7p">공급가액</th>
                        <th class="mWt7p">총액</th>
                        <th class="mWt6p">은행명</th>
                        <th class="mWt8p">계좌번호</th>
                        <th class="mWt10p">지급일</th>
                        
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan ="13">
                             <div style=" height:600px; overflow-x:hidden; overflow-y:auto;margin: 0px;padding: 0px;">
               
                                <asp:DataGrid ID="grdtable_copy2" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText ="">                       
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="4%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="12%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="6%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="7%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="7%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="6%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="8%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <ItemTemplate>
                                            <asp:TextBox ID="txt_paymentdate" runat="server"></asp:TextBox>
                                            </ItemTemplate>
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                       
                                       
                                    </Columns>
                                </asp:DataGrid>
                            </div>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    

    </article>
    <script>
        fDatePickerById("ContentPlaceHolder2_tb_date");
        fDatePickerById("ContentPlaceHolder2_tb_date2");
        fDatePickerById2("ContentPlaceHolder2_grdTable_txt_paymentdate");

        function update_payDate(row) {
            document.getElementById('<%= hdn_selectedRow.ClientID%>').value = row;
            document.getElementById('<%= btn_update_hdn.ClientID%>').click();
        }
    </script>
</asp:Content>

