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
    public partial class poptaxbill : ApplicationRoot
    {
        string sendDate = "";
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_code.Value = Request.Params.Get("code");
                hdn_cusCode.Value = Request.Params.Get("cusCode");
                hdn_serialNo.Value = Request.Params.Get("serialNo");

                if (hdn_serialNo.Value == "")
                {
                    txt_serialNo.Text = les_Tool_DB.SetCode("tb_taxbill", "serialNo", ConstClass.TAXBILL_CODE_PREFIX, km);
                }
                else
                {
                    txt_serialNo.Text = hdn_serialNo.Value;
                }

                cb_billtypecode_Setting();
                cb_updateReason_Setting();
                Search_Company();
                Search_Customer();
                Search_Order();
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
            cb_updateReason.Items.Clear();

            if(hdn_serialNo.Value == "")
            {
                cb_updateReason.Items.Add(new ListItem("해당사항없음", ""));
            }
            else
            {
                cb_updateReason.Items.Add(new ListItem("선택", ""));
                cb_updateReason.Items.Add(new ListItem("기재사항 수정", "1"));
                cb_updateReason.Items.Add(new ListItem("공급가액 변동", "2"));
                cb_updateReason.Items.Add(new ListItem("재화의 환입", "3"));
                cb_updateReason.Items.Add(new ListItem("계약의 해제", "4"));
                cb_updateReason.Items.Add(new ListItem("내국신용장 사후개설", "5"));
                cb_updateReason.Items.Add(new ListItem("착오에 의한 이중발급", "6"));
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
            txt_business.Text = dt.Rows[0]["combusiness"].ToString();
            txt_businessitem.Text = dt.Rows[0]["comType"].ToString();
            txt_email.Text = dt.Rows[0]["commail"].ToString();
            txt_manager.Text = dt.Rows[0]["taxPerson"].ToString();
            txt_phone.Text = dt.Rows[0]["taxPersonmobile"].ToString();
        }

        //공급받는자 정보
        private void Search_Customer()
        {
            if (km == null) km = new DB_mysql();

            if (hdn_serialNo.Value == "")
            {
                DataTable dt = PROCEDURE.SELECT("SP_customer_GetByCode", hdn_cusCode.Value, km);

                txt_registration2.Text = dt.Rows[0]["registration"].ToString();
                txt_cusName2.Text = dt.Rows[0]["cusName"].ToString();
                txt_bossname2.Text = dt.Rows[0]["cusBossName"].ToString();
                txt_address2.Text = dt.Rows[0]["address1"].ToString() + " / " + dt.Rows[0]["address2"].ToString();
                txt_business2.Text = dt.Rows[0]["business"].ToString();
                txt_businessitem2.Text = dt.Rows[0]["businessItem"].ToString();
                txt_email2.Text = dt.Rows[0]["email"].ToString();
            }
            else
            {
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
        }

        //품목정보
        private void Search_Order()
        {
            if (km == null) km = new DB_mysql();

            if (hdn_serialNo.Value != "")
            {
                DataTable dt = PROCEDURE.SELECT("SP_taxbil_pop_GetByNo", hdn_serialNo.Value, km);

                txt_itemName.Text = dt.Rows[0]["itemName"].ToString();
                txt_registrationDate.Text = dt.Rows[0]["registrationDate"].ToString();
                txt_produceCost.Text = dt.Rows[0]["producePrice"].ToString();
                //txt_taxCost.Text = dt.Rows[0]["taxCost"].ToString();

                cb_billtypecode.SelectedValue = dt.Rows[0]["billTypeCode"].ToString();
                string chk = dt.Rows[0]["isTaxFree"].ToString();

                if (chk == "1")
                {
                    chk_taxfree.Checked = true;
                    txt_taxCost.Text = (int.Parse(txt_produceCost.Text ) / 10).ToString();
                    txt_taxCost.Attributes.Add("style", "visibility:hidden");
                    txt_totalCost.Text = txt_produceCost.Text;
                }
                else
                {
                    txt_taxCost.Text = (int.Parse(txt_produceCost.Text) / 10).ToString();
                    txt_totalCost.Text = (int.Parse(txt_produceCost.Text) + int.Parse(txt_taxCost.Text)).ToString();
                }
            }
            else
            {
                DataTable dt = PROCEDURE.SELECT_TRAN("SP_taxbill_GetOrderList", hdn_code.Value, km);

                txt_registrationDate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                string itemName = "";
                int prodCost = 0;
                int taxCost = 0;
                int totalCost = 0;
                
                itemName = dt.Rows[0][0].ToString();

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    prodCost += int.Parse(dt.Rows[i][3].ToString());
                    taxCost += int.Parse(dt.Rows[i][4].ToString());
                }

                if (dt.Rows.Count > 1) itemName += " 외";

                txt_itemName.Text = itemName;
                txt_produceCost.Text = prodCost.ToString();
                txt_taxCost.Text = taxCost.ToString();
                txt_totalCost.Text = (prodCost + taxCost).ToString();

            }

        }
        #endregion

        //저장
        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            try
            {
                km.BeginTran();

                string tax = txt_taxCost.Text;
                if (chk_taxfree.Checked) tax = "0";

                if (hdn_serialNo.Value == "") //추가
                {
                    string serialNo = les_Tool_DB.SetCode_Tran("tb_taxbill", "serialNo", ConstClass.TAXBILL_CODE_PREFIX, km);

                    object[] cusObjs = { serialNo, txt_registration2, txt_cusName2, txt_businessNo2, txt_bossname2, txt_address2, txt_business2, txt_businessitem2, txt_email2,txt_manager2,txt_phone2 };

                    PROCEDURE.CUD_TRAN("SP_taxbill_cusinfo_Add", cusObjs, km);

                    object[] objs = { serialNo, hdn_cusCode.Value, cb_billtypecode, chk_taxfree, txt_registrationDate, sendDate, txt_itemName, txt_produceCost, tax };

                    PROCEDURE.CUD_TRAN("SP_taxbill_Add", objs, km);

                    km.tran_ExSQL_Ret($"UPDATE tb_order_master SET taxbillserialNo = '{serialNo}' WHERE orderCode IN ({hdn_code.Value});");

                    km.Commit();

                    Response.Write("<script>alert('저장되었습니다.'); window.opener.refresh(); window.close();</script>");
                }
                else // 수정
                {
                    object[] cusObjs = { hdn_serialNo, txt_registration2, txt_cusName2, txt_businessNo2, txt_bossname2, txt_address2, txt_business2, txt_businessitem2, txt_email2, txt_manager2, txt_phone2 };

                    PROCEDURE.CUD_TRAN("SP_taxbill_cusinfo_Update", cusObjs, km);

                    object[] objs = { hdn_serialNo, cb_billtypecode, chk_taxfree, txt_itemName, tax };

                    PROCEDURE.CUD_TRAN("SP_taxbill_Update", objs, km);

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

        #region 세금계산서 내용

        //전송
        protected void btn_send_Click(object sender, EventArgs e)
        {
            BaroService_TISoapClient barobill = new BaroService_TISoapClient();

            //연동인증키
            string key = "A4A6B70C-2215-458F-9818-E0F194D3FAC5";

            TaxInvoice taxInvoice = new TaxInvoice();

            Tax_ProucerInfo(taxInvoice);
            Tax_RecipientInfo(taxInvoice);
            Tax_Info(taxInvoice);
            //Tax_Item_Info(taxIn
            //
            //voice);

            TaxInvoiceStateEX tt;

            tt = barobill.GetTaxInvoiceStateEX("", "", "");

           // tt.NTSSendKey

           // taxInvoice.
            int result;
            //세금계산서 전송
            if(hdn_serialNo.Value == "")
            {
                result = barobill.RegistAndIssueTaxInvoice(key, txt_registration1.Text.Replace("-", ""), taxInvoice, Convert.ToBoolean(hdn_isSend.Value), false, "");
            }
            else //세금계산서 수정 전송
            {
                if(cb_updateReason.SelectedValue == "")
                {
                    Response.Write("<script>alert('수정사유를 선택해주십시오.');</script>");
                    return;
                }

                result = barobill.UpdateTaxInvoiceEX(key,txt_registration1.Text.Replace("-",""),taxInvoice,1);
            }

            //전송이 완료됐으면 저장한다.
            if(result == 1)
            {
                sendDate = DateTime.Now.ToString("yyyy-MM-dd");
                //Response.Write($"<script>alert('완 ㅡ 벽');</script>");
                btn_save_Click(null, null);
            }
            else // 오류사항 출력
            {
                Response.Write($"<script>alert('{barobill.GetErrString(key, result)}');</script>");
            }
        }

        //공급자 정보 입력
        private void Tax_ProucerInfo(TaxInvoice tax)
        {
            if (km == null) km = new DB_mysql();

            string sql = "SELECT barobill_ID FROM tb_company;";

            string id = km.GetDTa(sql).Rows[0][0].ToString();

            tax.InvoicerParty = new InvoiceParty();
            tax.InvoicerParty.MgtNum = txt_serialNo.Text; //고유ID 자동채번 세금계산서번호
            tax.InvoicerParty.CorpNum = txt_registration1.Text.Replace("-",""); //사업자등록번호 -뺴고
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
        private void Tax_Info(TaxInvoice tax)
        {
            if(hdn_serialNo.Value != "")
            {
                tax.ModifyCode = cb_updateReason.SelectedValue; //수정사유
                tax.Remark1 = ""; // 국세청 승인번호,...?
            }

            tax.IssueDirection = 1;
            tax.TaxInvoiceType = 1;
            tax.TaxType = chk_taxfree.Checked == true ? 2 : 1;
            tax.TaxCalcType = 3;
            tax.PurposeType = int.Parse(cb_billtypecode.SelectedValue);
            tax.WriteDate = DateTime.Parse(txt_registrationDate.Text).ToString("yyyyMMdd");
            tax.AmountTotal = txt_produceCost.Text;
            tax.TaxTotal = chk_taxfree.Checked == true ? "0" : txt_taxCost.Text;
            tax.TotalAmount = chk_taxfree.Checked == true ? txt_produceCost.Text : txt_totalCost.Text;

            TaxInvoiceTradeLineItem item = new TaxInvoiceTradeLineItem();
            item.PurchaseExpiry = DateTime.Parse(txt_registrationDate.Text).ToString("yyyyMMdd");  //공급일자 (YYYYMMDD)
            item.Name = txt_itemName.Text; //품목명
            item.Amount = txt_produceCost.Text; // 공급가액
            item.Tax = chk_taxfree.Checked == true ? "0" : txt_taxCost.Text; //세액

            tax.TaxInvoiceTradeLineItems = new TaxInvoiceTradeLineItem[1];
            tax.TaxInvoiceTradeLineItems[0] = item;
        }

        ////세금계산서 품목 입력 <= 최대 99개까지 입력 가능
        //private void Tax_Item_Info(TaxInvoice tax)
        //{
        //    if (km == null) km = new DB_mysql();

        //    string sql = "SELECT " +
        //                 "REPLACE(LEFT(a.releaseDate, 10), '-', '') AS relaseDate, " +
        //                 "c.fullName, " +
        //                 "CAST((b.unitprice * b.totalWeight) AS integer) AS price, " +
        //                 "CAST((b.unitprice * b.totalWeight / 10) AS INTEGER) AS tax " +
        //                 "FROM tb_order_master a " +
        //                 "INNER JOIN tb_order_detail b ON a.orderCode = b.orderCode " +
        //                 "INNER JOIN tb_item c ON c.itemCode = b.itemCode ";

        //    if (hdn_serialNo.Value == "") // 초기 세금계산서 전송 시 orderCode로부터 품목 얻기
        //    {
        //        sql += $"WHERE a.orderCode IN({hdn_code.Value});";
        //    }
        //    else // 세금계산서 수정시 해당 세금계산서 번호로 품목 가져오기
        //    {
        //        sql += $"WHERE a.taxbillserialNo = '{hdn_serialNo.Value}';";
        //    }

        //    DataTable dt = km.GetDTa(sql);

        //    tax.TaxInvoiceTradeLineItems = new TaxInvoiceTradeLineItem[dt.Rows.Count];
            
        //    for(int i = 0; i < dt.Rows.Count;i ++)
        //    {
        //        TaxInvoiceTradeLineItem item = new TaxInvoiceTradeLineItem();
        //        item.PurchaseExpiry = DateTime.Parse(txt_registrationDate.Text).ToString("yyyyMMdd");  //공급일자 (YYYYMMDD)
        //        item.Name = dt.Rows[i][1].ToString();           //품목명
        //        item.Amount = dt.Rows[i][2].ToString();         //공급가액
        //        item.Tax = chk_taxfree.Checked == true ? "0" : dt.Rows[i][3].ToString();            //세액

        //        tax.TaxInvoiceTradeLineItems[i] = item;
        //    }
        //}

        #endregion
    }
}