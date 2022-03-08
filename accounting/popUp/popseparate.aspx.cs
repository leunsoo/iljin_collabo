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

namespace iljin.popUp
{
    public partial class popseparate : ApplicationRoot
    {
        DB_mysql km;

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
                cb_billtypecode.Items.Add(new ListItem("청구", "0"));
                cb_billtypecode.Items.Add(new ListItem("영수", "1"));

                Search_Company();
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
        }

        //품목정보
        private void Search_TaxbillInfo()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT_TRAN("SP_taxbil_pop_GetByNo", hdn_serialNo.Value, km);

            txt_registrationdate.Text = dt.Rows[0]["registrationDate"].ToString();
            txt_wholePrice.Text = dt.Rows[0]["producePrice"].ToString();
            cb_billtypecode.SelectedValue = dt.Rows[0]["billTypeCode"].ToString();
            hdn_cusCode.Value = dt.Rows[0]["cusCode"].ToString();

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

                    object[] cusObjs = { serialNo, txt_registration2, txt_cusName2, txt_businessNo2, txt_bossname2, txt_address2, txt_business2, txt_businessitem2, txt_email2 };

                    PROCEDURE.CUD_TRAN("SP_taxbill_cusinfo_Add", cusObjs, km);

                    object[] objs = { serialNo, hdn_cusCode.Value, cb_billtypecode, chk_taxfree, txt_registrationdate, "", hdn_wpPrice, hdn_wtPrice };

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
                    object[] cusObjs = { hdn_serialNo, txt_registration2, txt_cusName2, txt_businessNo2, txt_bossname2, txt_address2, txt_business2, txt_businessitem2, txt_email2 };

                    PROCEDURE.CUD_TRAN("SP_taxbill_cusinfo_Update", cusObjs, km);

                    object[] objs = { hdn_serialNo, hdn_cusCode, cb_billtypecode, chk_taxfree, txt_registrationdate, hdn_wpPrice, hdn_wtPrice };

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

    }
}