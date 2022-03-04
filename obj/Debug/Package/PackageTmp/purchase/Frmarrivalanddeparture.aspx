<%@ Page Title="" Language="C#" MasterPageFile="~/iljin.Master" AutoEventWireup="true" CodeBehind="Frmarrivalanddeparture.aspx.cs" Inherits="iljin.Frmarrivalanddeparture" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
    <asp:UpdatePanel runat="server">
        <ContentTemplate>
            <asp:ScriptManager runat="server"></asp:ScriptManager>
            <article class="conts_inner">
                <h2 class="conts_tit">
                    <asp:Label ID="m_title" runat="server" Text="매입관리 ::> 입출고예측관리"></asp:Label></h2>
                <div class="search_box">
                    <div class="box_row">
                        <span class="mWt110 tac">제품구분1</span>
                        <asp:DropDownList ID="cb_divCode1" runat="server" CssClass="mWt150" AutoPostBack="true" OnSelectedIndexChanged="cb_divCode1_SelectedIndexChanged"></asp:DropDownList>
                        <span class="ml20 mWt110 tac">제품구분2</span>
                        <asp:DropDownList ID="cb_divCode2" runat="server" CssClass="mWt150"></asp:DropDownList>
                        <span class="ml20">두께</span>
                        <asp:TextBox ID="txt_thickness" runat="server" CssClass="mWt100"></asp:TextBox>
                        &nbsp~&nbsp
                <asp:TextBox ID="txt_thickness2" runat="server" CssClass="mWt100"></asp:TextBox>
                        <span class="ml20">폭</span>
                        <asp:TextBox ID="txt_width" runat="server" CssClass="mWt100"></asp:TextBox>
                        &nbsp~&nbsp
                <asp:TextBox ID="txt_width2" runat="server" CssClass="mWt100"></asp:TextBox>

                    </div>
                    <div class="box_row mt10">
                        <span class="mWt110 tac">평균 개월 수</span>
                        <asp:DropDownList ID="cb_averagemonth" runat="server" CssClass="mWt150"></asp:DropDownList>
                        <span class="ml20 mWt110 tac">예측 개월 수</span>
                        <asp:DropDownList ID="cb_forecastmonth" runat="server" CssClass="mWt150"></asp:DropDownList>
                        <asp:Button ID="btn_search" runat="server" CssClass="btn_navy btn_100_30 ft_right" Text="검색" OnClick="btn_search_Click" />
                    </div>
                </div>
                <div class="fixed_hs_650 mt10" style="width: 1190px; overflow: hidden;">
                    <table class="grtable_th">
                        <thead>
                            <tr>
                                <th class="mWt30p">제품명</th>
                                <th class="mWt15p" id="txt_month1" runat="server">최근 m개월 평균 출고량</th>
                                <th class="mWt20p">현재고</th>
                                <th class="mWt20p">입고예정</th>
                                <th class="mWt15p" id="txt_month2" runat="server">n개월 후 재고</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="5">
                                    <div style="height: 600px; overflow-x: hidden; overflow-y: auto; margin: 0px; padding: 0px;">
                                        <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff" Width="1190">
                                            <HeaderStyle Height="25px" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <Columns>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="30%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="15%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="20%" CssClass="" />
                                                </asp:TemplateColumn>
                                                <asp:TemplateColumn HeaderText="">
                                                    <HeaderStyle HorizontalAlign="Center" />
                                                    <ItemStyle Width="15%" CssClass="" />
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
                <%--     <div class ="fixed_hs_500 mt10">
            <table class ="grtable_th">
                <thead>
                    <tr>
                        <th class="mWt10p"rowspan="3">폭</th>
                        <th class="mWt20p" colspan="2">최근M개월평균출고량</th>
                        <th class="mWt20p" colspan="2">현재고</th>
                        <th class="mWt20p" colspan="2">입고예정</th>
                        <th class="mWt20p" colspan="2">N개월 후 재고</th>    
                    </tr>
                    <tr>
                        <th class="mWt20p" colspan="2" >길이</th>
                        <th class="mWt20p" colspan="2" >길이</th>
                        <th class="mWt20p" colspan="2" >길이</th>
                         <th class="mWt20p" colspan="2">길이</th>  
                    </tr>
                      <tr>
                        <th class="mWt10p">6000</th>
                        <th class="mWt10p">12000</th>
                        <th class="mWt10p">6000</th>
                         <th class="mWt10p">12000</th> 
                          <th class="mWt10p">6000</th> 
                          <th class="mWt10p">12000</th> 
                          <th class="mWt10p">6000</th> 
                          <th class="mWt10p">12000</th> 
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td colspan ="9">
                            <div style="overflow:auto;">
                                <asp:DataGrid ID="grdTable" CssClass="grtable_td" runat="server" AllowCustomPaging="true" ShowHeader="false" AutoGenerateColumns="false" GridLines="Both" PageSize="2" SelectedItemStyle-BackColor="#ccffff">
                                    <HeaderStyle Height="25px" />
                                    <ItemStyle HorizontalAlign="Center" />
                                    <Columns>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle Width="10%" CssClass="" />
                                        </asp:TemplateColumn>
                                        <asp:TemplateColumn HeaderText ="">
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
        </div>--%>
            </article>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
