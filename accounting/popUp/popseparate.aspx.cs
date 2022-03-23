using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PublicLibsManagement;
using MysqlLib;
using les;
using Barobill;

namespace iljin.popUp
{
    public partial class popseparate : ApplicationRoot
    {
        //바로빌 연동인증키 
        private static string key = "A4A6B70C-2215-458F-9818-E0F194D3FAC5";

        private string sendDate = "";
        private DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_serialNo.Value = Request.Params.Get("serialNo");
                txt_registrationdate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                if (hdn_serialNo.Value == "")
                {
                    txt_serialNo.Text = Tool_DB.SetCode("tb_taxbill", "serialNo", ConstClass.TAXBILL_CODE_PREFIX, km);
                }
                else
                {
                    txt_serialNo.Text = hdn_serialNo.Value;
                    Search_Customer_FromDB();
                    Search_TaxbillInfo();
                }

                txt_costPrice.Attributes.Add("readonly", "readonly");
                txt_totalPrice.Attributes.Add("readonly", "readonly");
                txt_wholePrice.Attributes.Add("readonly", "readonly");

                cb_billtypecode_Setting();
                cb_updateReason_Setting();
                Search_Company();
            }
        }

        #region 기본정보 불러오기

        //청구/영수 설정
        private void cb_billtypecode_Setting()
        {
            cb_billtypecode.Items.Clear();

            cb_billtypecode.Items.Add(new ListItem("청구", "2"));
            cb_billtypecode.Items.Add(new ListItem("영수", "1"));
        }

        //수정사유 설정
        private void cb_updateReason_Setting()
        {
            if (km == null) km = new DB_mysql();

            cb_updateReason.Items.Clear();

            if (hdn_serialNo.Value == "")
            {
                cb_updateReason.Items.Add(new ListItem("해당사항없음", "none"));
            }
            else
            {
                string sql = $"SELECT sendDate FROM tb_taxbill WHERE serialNo = '{hdn_serialNo.Value}';";

                if (km.GetDTa(sql).Rows[0][0].ToString() != "")
                {
                    cb_updateReason.Items.Add(new ListItem("선택", ""));
                    cb_updateReason.Items.Add(new ListItem("기재사항 수정", "1"));
                    cb_updateReason.Items.Add(new ListItem("공급가액 변동", "2"));
                    cb_updateReason.Items.Add(new ListItem("재화의 환입", "3"));
                    cb_updateReason.Items.Add(new ListItem("계약의 해제", "4"));
                    cb_updateReason.Items.Add(new ListItem("내국신용장 사후개설", "5"));
                    cb_updateReason.Items.Add(new ListItem("착오에 의한 이중발급", "6"));
                }
                else
                {
                    cb_updateReason.Items.Add(new ListItem("해당사항없음", "none"));
                }
            }
        }

        //공급자 정보
        private void Search_Company()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_company_Info", km);

            txt_registration1.Text = dt.Rows[0]["comregistration"].ToString();
            txt_cusName1.Text = dt.Rows[0]["comName"].ToString();
            txt_bossname1.Text = dt.Rows[0]["comBossName"].ToString();
            txt_address.Text = dt.Rows[0]["address1"].ToString() + " / " + dt.Rows[0]["address2"].ToString();
            txt_business1.Text = dt.Rows[0]["combusiness"].ToString();
            txt_businessitem.Text = dt.Rows[0]["comType"].ToString();
            txt_email.Text = dt.Rows[0]["commail"].ToString();
            txt_manager.Text = dt.Rows[0]["taxPerson"].ToString();
            txt_phone.Text = dt.Rows[0]["taxPersonmobile"].ToString();
        }

        //검색해서 가져오기
        private void Search_Customer_FromSelect()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_customer_GetByCode", hdn_cusCode.Value, km);

            txt_registration2.Text = dt.Rows[0]["registration"].ToString();
            txt_cusName2.Text = dt.Rows[0]["cusName"].ToString();
            txt_bossname2.Text = dt.Rows[0]["cusBossName"].ToString();
            txt_address2.Text = dt.Rows[0]["address1"].ToString() + " / " + dt.Rows[0]["address2"].ToString();
            txt_business2.Text = dt.Rows[0]["business"].ToString();
            txt_businessitem2.Text = dt.Rows[0]["businessItem"].ToString();
            txt_email2.Text = dt.Rows[0]["email"].ToString();
        }

        //DB에서 가져오기
        private void Search_Customer_FromDB()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_taxbill_cusinfo_pop_GetByNo", hdn_serialNo.Value, km);

            txt_registration2.Text = dt.Rows[0]["cus_registration"].ToString();
            txt_cusName2.Text = dt.Rows[0]["cus_name"].ToString();
            txt_businessNo2.Text = dt.Rows[0]["cus_employeeNo"].ToString();
            txt_bossname2.Text = dt.Rows[0]["cus_ceo"].ToString();
            txt_address2.Text = dt.Rows[0]["cus_address"].ToString();
            txt_business2.Text = dt.Rows[0]["cus_business"].ToString();
            txt_businessitem2.Text = dt.Rows[0]["cus_business_item"].ToString();
            txt_email2.Text = dt.Rows[0]["cus_email"].ToString();
            txt_manager2.Text = dt.Rows[0]["cus_taxperson"].ToString();
            txt_phone2.Text = dt.Rows[0]["cus_taxperson_mobile"].ToString();
        }

        //품목정보
        private void Search_TaxbillInfo()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT_TRAN("SP_taxbil_pop_GetByNo", hdn_serialNo.Value, km);

            int totalPrice = 0;
            int totalTax = 0;

            txt_registrationdate.Text = dt.Rows[0]["registrationDate"].ToString();
            cb_billtypecode.SelectedValue = dt.Rows[0]["billTypeCode"].ToString();
            hdn_cusCode.Value = dt.Rows[0]["cusCode"].ToString();
            txt_title.Text = dt.Rows[0]["itemName"].ToString();

            int.TryParse(dt.Rows[0]["producePrice"].ToString(), out totalPrice);
            hdn_wpPrice.Value = totalPrice.ToString();
            
            int.TryParse(dt.Rows[0]["taxCost"].ToString(), out totalTax);
            hdn_wtPrice.Value = totalTax.ToString();

            txt_wholePrice.Text = (totalPrice + totalTax).ToString();

            txt_customer.Text = km.tran_GetDTa($"SELECT cusName FROM tb_customer WHERE cusCode = '{hdn_cusCode.Value}'").Rows[0][0].ToString();

            string chk = dt.Rows[0]["isTaxFree"].ToString();

            dt = PROCEDURE.SELECT("SP_taxbill_item_GetByNo", hdn_serialNo.Value, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            for (int i = 0; i < grdTable.Items.Count; i++)
            {
                grdTable.Items[i].Cells[0].Text = dt.Rows[i][0].ToString();
                grdTable.Items[i].Cells[1].Text = txt_registrationdate.Text;
                grdTable.Items[i].Cells[2].Text = dt.Rows[i][1].ToString();
                grdTable.Items[i].Cells[3].Text = dt.Rows[i][2].ToString();
                grdTable.Items[i].Cells[4].Text = dt.Rows[i][3].ToString();
                grdTable.Items[i].Cells[5].Text = dt.Rows[i][4].ToString();
                if (chk == "1")
                {
                    chk_taxfree.Checked = true;
                    grdTable.Items[i].Cells[6].Text = "";
                    grdTable.Items[i].Cells[7].Text = dt.Rows[i][4].ToString();
                }
                else
                {
                    int price = int.Parse(dt.Rows[i][4].ToString());
                    int tax = price / 10;

                    grdTable.Items[i].Cells[6].Text = tax.ToString();
                    grdTable.Items[i].Cells[7].Text = (price + tax).ToString();
                }
            }
        }

        #endregion

        #region 내용 입력

        //제품추가
        protected void btn_itemadd_Click(object sender, EventArgs e)
        {

            int rowCount = grdTable.Items.Count;
            DataTable dt;
            DataRow dr;
            string[] field = { "0", "1", "2", "3", "4", "5", "6", "7" };

            if (rowCount > 0)
            {
                dt = les_DataGridSystem.Get_Dt_From_DataGrid(grdTable, field);

                dr = dt.NewRow();
            }
            else
            {
                dt = new DataTable();
                for (int i = 0; i < field.Length; i++)
                {
                    dt.Columns.Add(field[i]);
                }
                dr = dt.NewRow();
            }

            dr[0] = hdn_itemCode.Value;
            dr[1] = txt_registrationdate.Text;
            dr[2] = txt_itemName.Text;
            dr[3] = txt_itemQty.Text;
            dr[4] = txt_unitprice.Text;
            dr[5] = txt_producePrice.Text;
            dr[6] = txt_costPrice.Text;
            dr[7] = txt_totalPrice.Text;

            dt.Rows.InsertAt(dr, 0);

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable, dt, 0, grdTable.Columns.Count - 1, 0);

            for (int i = 0; i < grdTable.Items.Count; i++)
            {
                ((Button)grdTable.Items[i].FindControl("btn_del")).Attributes.Add("onclick", $"deleteRow('{i.ToString()}'); return false;");
            }

        }

        //거래처 선택시 정보 불러오기
        protected void btn_customerInfoSetting_Click(object sender, EventArgs e)
        {
            Search_Customer_FromSelect();
        }

        //주문품목 삭제
        protected void btn_deleteRow_Click(object sender, EventArgs e)
        {
            DataTable dt;
            string[] field = { "0", "1", "2", "3", "4", "5", "6", "7" };

            dt = les_DataGridSystem.Get_Dt_From_DataGrid(grdTable, field);
            dt.Rows.RemoveAt(int.Parse(hdn_selectedRow.Value));
            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable, dt, 0, grdTable.Columns.Count - 1, 0);

            int rowCount = grdTable.Items.Count;
            for (int i = 0; i < rowCount; i++)
            {
                ((Button)grdTable.Items[i].FindControl("btn_del")).Attributes.Add("onclick", $"deleteRow('{i.ToString()}'); return false;");
            }
        }

        #endregion

        #region 세금계산서 내용

        //전송
        protected void btn_send_Click(object sender, EventArgs e)
        {
            BaroService_TISoapClient barobill = new BaroService_TISoapClient();

            Tax_Set_NTS_Option(barobill);  //발급 시 바로 국세청 전송

            TaxInvoice taxInvoice = new TaxInvoice();

            Tax_ProucerInfo(taxInvoice);   //공급자 정보 입력
            Tax_RecipientInfo(taxInvoice); //공급받는자 정보 입력
            Tax_Info(taxInvoice, barobill);          //세금계산서 내용 입력

            int result;

            if (cb_updateReason.SelectedValue == "")
            {
                 Response.Write("<script>alert('수정사유를 선택해주십시오.');</script>");
                 return;
            }

            //세금계산서 전송
            result = barobill.RegistAndIssueTaxInvoice(key, txt_registration1.Text.Replace("-", ""), taxInvoice, false, true, "");

            //전송이 완료됐으면 저장한다.
            if (result == 1)
            {
                sendDate = DateTime.Now.ToString("yyyy-MM-dd");
                //Response.Write($"<script>alert('완 ㅡ 벽');</script>");
                btn_save_Click(null, null);
            }
            else // 오류사항 출력
            {
                Response.Write($"<script>alert('{barobill.GetErrString(key, result)}');</script>");
                return;
            }
        }

        //발급 시 바로 국세청 전송되게 Setting
        private void Tax_Set_NTS_Option(BaroService_TISoapClient barobill)
        {
            string corpNum = txt_registration1.Text.Replace("-", "");

            NTSSendOption nTSSendOption = barobill.GetNTSSendOption(key, corpNum);

            if (nTSSendOption.TaxationOption > 0)
            {
                //발급시 바로 국세청으로 전송되게 만드는 부분
                if (nTSSendOption.TaxationOption != 2)
                {
                    nTSSendOption.TaxationOption = 2;

                    barobill.ChangeNTSSendOption(key, corpNum, "iljin6834", nTSSendOption);
                }
            }
            else
            {
                Response.Write($"<script>alert('{barobill.GetErrString(key, nTSSendOption.TaxationOption)}');</script>");
                return;
            }
        }

        //수정세금계산서 관리번호 자동채번
        private string Get_UpdateSerialNo()
        {
            string serialNo = "";

            if (km == null) km = new DB_mysql();

            string sql = $"SELECT serialNo_Update FROM tb_taxbill WHERE serialNo = '{txt_serialNo.Text}';";

            serialNo = km.tran_GetDTa(sql).Rows[0][0].ToString();
            int updateNo = int.Parse(serialNo.Substring(serialNo.Length - 2));
            string strUpdateNo = (updateNo + 1).ToString();

            if (strUpdateNo.Length == 1) strUpdateNo = "0" + strUpdateNo;

            return serialNo = txt_serialNo.Text + "_" + strUpdateNo;
        }

        //공급자 정보 입력
        private void Tax_ProucerInfo(TaxInvoice tax)
        {
            string serialNo = txt_serialNo.Text;

            if (km == null) km = new DB_mysql();
            string sql = "SELECT barobill_ID FROM tb_company;";
            string id = km.GetDTa(sql).Rows[0][0].ToString();

            //세금계산서를 수정할 경우
            if (cb_updateReason.Items.Count > 3)
            {
                serialNo = Get_UpdateSerialNo();
            }

            tax.InvoicerParty = new InvoiceParty();
            tax.InvoicerParty.MgtNum = serialNo; //고유ID 자동채번 세금계산서번호
            tax.InvoicerParty.CorpNum = txt_registration1.Text.Replace("-", ""); //사업자등록번호 -뺴고
            tax.InvoicerParty.CorpName = txt_cusName1.Text; //업체명
            tax.InvoicerParty.CEOName = txt_bossname1.Text; //대표자명
            tax.InvoicerParty.Addr = txt_address.Text; //주소
            tax.InvoicerParty.ContactID = id; // 바로빌회원ID
            tax.InvoicerParty.HP = txt_phone.Text;
            tax.InvoicerParty.ContactName = txt_manager.Text; //담당자명
            tax.InvoicerParty.Email = txt_email.Text; //메일
        }

        //공급받는자 정보 입력
        private void Tax_RecipientInfo(TaxInvoice tax)
        {
            tax.InvoiceeParty = new InvoiceParty();
            tax.InvoiceeParty.CorpNum = txt_registration2.Text.Replace("-", ""); //사업자등록번호 -뺴고
            tax.InvoiceeParty.CorpName = txt_cusName2.Text; //업체명
            tax.InvoiceeParty.CEOName = txt_bossname2.Text; //대표자명
            tax.InvoiceeParty.Addr = txt_address2.Text; //주소
            tax.InvoiceeParty.ContactName = txt_manager2.Text; //담당자
            tax.InvoiceeParty.Email = txt_email2.Text; //메일
        }

        //세금계산서 내용 입력
        private void Tax_Info(TaxInvoice tax, BaroService_TISoapClient barobill)
        {
            string corpNum = txt_registration1.Text.Replace("-", "");

            //세금계산서를 수정할 경우
            if (cb_updateReason.Items.Count > 3)
            {
                TaxInvoiceStateEX taxEx = barobill.GetTaxInvoiceStateEX(key, corpNum, hdn_serialNo.Value);

                if (taxEx.BarobillState > 0)
                {
                    tax.ModifyCode = cb_updateReason.SelectedValue; //수정사유
                    tax.Remark1 = taxEx.NTSSendKey;
                }
                else
                {
                    Response.Write($"<script>alert('{barobill.GetErrString(key, taxEx.BarobillState)}');</script>");
                    return;
                }
            }

            tax.IssueDirection = 1;
            tax.TaxInvoiceType = 1;
            tax.TaxType = chk_taxfree.Checked == true ? 2 : 1;
            tax.TaxCalcType = 3;
            tax.PurposeType = int.Parse(cb_billtypecode.SelectedValue);
            tax.WriteDate = DateTime.Parse(txt_registrationdate.Text).ToString("yyyyMMdd");
            tax.AmountTotal = hdn_wpPrice.Value;
            tax.TaxTotal = chk_taxfree.Checked == true ? "0" : hdn_wtPrice.Value;
            tax.TotalAmount = txt_wholePrice.Text;

            //세금계산서 품목 입력
            TaxInvoiceTradeLineItem item = new TaxInvoiceTradeLineItem();
            item.PurchaseExpiry = DateTime.Parse(txt_registrationdate.Text).ToString("yyyyMMdd");  //공급일자 (YYYYMMDD)
            item.Name = txt_title.Text; //품목명
            item.Amount = hdn_wpPrice.Value; // 공급가액
            item.Tax = chk_taxfree.Checked == true ? "0" : hdn_wtPrice.Value; //세액

            tax.TaxInvoiceTradeLineItems = new TaxInvoiceTradeLineItem[1];
            tax.TaxInvoiceTradeLineItems[0] = item;
        }

        #endregion

        //저장
        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (hdn_cusCode.Value == "")
            {
                Response.Write("<script>alert('거래처를 선택해 주십시오.');</script>");
                return;
            }

            int rowCount = grdTable.Items.Count;

            if (rowCount == 0)
            {
                Response.Write("<script>alert('품목을 추가해 주십시오.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            try
            {
                km.BeginTran();

                string sql = "";
                //추가
                if (hdn_serialNo.Value == "")
                {
                    string serialNo = Tool_DB.SetCode_Tran("tb_taxbill", "serialNo", ConstClass.TAXBILL_CODE_PREFIX, km);

                    object[] cusObjs = { serialNo, txt_registration2, txt_cusName2, txt_businessNo2, txt_bossname2, txt_address2, txt_business2, txt_businessitem2, txt_email2, txt_manager2,txt_phone2 };

                    PROCEDURE.CUD_TRAN("SP_taxbill_cusinfo_Add", cusObjs, km);

                    object[] objs = { serialNo, hdn_cusCode.Value, cb_billtypecode, chk_taxfree, txt_registrationdate, sendDate, txt_title, hdn_wpPrice, hdn_wtPrice };

                    PROCEDURE.CUD_TRAN("SP_taxbill_Add", objs, km);

                    for (int i = 0; i < rowCount; i++)
                    {
                        sql += "CALL SP_taxbill_item_Add(" +
                            $"'{serialNo}'" +
                            $",'{grdTable.Items[i].Cells[0].Text}'" +
                            $",'{grdTable.Items[i].Cells[3].Text}'" +
                            $",'{grdTable.Items[i].Cells[4].Text}'" +
                            $",'{grdTable.Items[i].Cells[5].Text}');";
                    }

                    km.tran_ExSQL_Ret(sql);

                    km.Commit();

                    Response.Write("<script>alert('저장되었습니다.'); window.opener.refresh(); window.close();</script>");
                }
                // 수정
                else
                {
                    string updateSerialNo = "";
                    //수정세금계산서일 경우
                    if (cb_updateReason.Items.Count > 3 && sendDate != "")
                    {
                        updateSerialNo = Get_UpdateSerialNo();
                    }

                    object[] cusObjs = { hdn_serialNo, txt_registration2, txt_cusName2, txt_businessNo2, txt_bossname2, txt_address2, txt_business2, txt_businessitem2, txt_email2, txt_manager2, txt_phone2 };

                    PROCEDURE.CUD_TRAN("SP_taxbill_cusinfo_Update", cusObjs, km);

                    object[] objs = { hdn_serialNo, updateSerialNo, hdn_cusCode, cb_billtypecode, chk_taxfree, txt_registrationdate,txt_title, hdn_wpPrice, hdn_wtPrice,sendDate };

                    PROCEDURE.CUD_TRAN("SP_taxbill_Separate_Update", objs, km);

                    sql += $"DELETE FROM tb_taxbill_item WHERE serialNo = '{hdn_serialNo.Value}';";

                    for (int i = 0; i < rowCount; i++)
                    {
                        sql += "CALL SP_taxbill_item_Add(" +
                            $"'{hdn_serialNo.Value}'" +
                            $",'{grdTable.Items[i].Cells[0].Text}'" +
                            $",'{grdTable.Items[i].Cells[3].Text}'" +
                            $",'{grdTable.Items[i].Cells[4].Text}'" +
                            $",'{grdTable.Items[i].Cells[5].Text}');";
                    }

                    km.tran_ExSQL_Ret(sql);

                    km.Commit();

                    Response.Write("<script>alert('수정되었습니다.'); window.opener.refresh(); window.close();</script>");
                }
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>alert('저장 실패');</script>");
            }

        }

    }
}