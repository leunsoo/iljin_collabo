using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;
using PublicLibsManagement;

namespace iljin.popUp
{
    public partial class poprelease : ApplicationRoot
    {
        DB_mysql km;

        string test = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hidden_codeList.Value = Request.Params.Get("code");
                hidden_addressList.Value = Request.Params.Get("address");
                
                BaseInfoSetting();
                cb_divCode_Setting(); 
            }

            if(cb_divCode.SelectedValue == "2")
            {
                hiddenfield.Visible = true;
            }
            else
            {
                hiddenfield.Visible = false;
            }
        }

        //배송구분 Setting
        private void cb_divCode_Setting()
        {
            cb_divCode.Items.Clear();

            cb_divCode.Items.Add(new ListItem("자차", "0"));
            cb_divCode.Items.Add(new ListItem("택배", "1"));
            cb_divCode.Items.Add(new ListItem("용차", "2"));
            cb_divCode.SelectedIndex = 0;
        }

        //기본정보 : 배송지명,거래명세표번호 Setting
        private void BaseInfoSetting()
        {
            if (km == null) km = new DB_mysql();

            string sql = "SELECT a.transactionCode FROM tb_transaction a " +
                         "LEFT OUTER JOIN tb_customer_address b ON a.cusAddressIdx = b.idx " +
                        $"WHERE orderCode IN ({hidden_codeList.Value.Substring(1)});";

            DataTable dt = km.tran_GetDTa(sql);

            int count = 0;
            string address = "";

            string[] addressArr = hidden_addressList.Value.Split(',');

            for(int i = 0; i < addressArr.Length; i++)
            {
                if(addressArr[i].Trim() != "")
                {
                    count++;
                    if(address == "")
                    {
                        address = addressArr[i];
                    }
                }
            }


            if(count > 1)
            {
                address += " 외 " + (count - 1).ToString() + "곳";
            }

            txt_address.Text = address;
            
            cb_transactionNo.Items.Clear();

            for(int i = 0; i < dt.Rows.Count; i++)
            {
                cb_transactionNo.Items.Add(new ListItem(dt.Rows[i][0].ToString(), dt.Rows[i][0].ToString()));
            }

            sql = "SELECT cusCode,cusName FROM tb_customer WHERE cusDivCode = 'C0001_03' ORDER BY isMain DESC;";

            km.GetCbDT_FromSql(sql, cb_company);
        }

        private void DeliveryInfoSetting()
        {
            if (km == null) km = new DB_mysql();

            if (cb_company.SelectedValue == "") return;

            string sql = $"SELECT tel, registration, account_bank, account_no FROM tb_customer WHERE cusCode = '{cb_company.SelectedValue}';";

            DataTable dt = km.GetDTa(sql);

            txt_tel.Text = dt.Rows[0][0].ToString();
            txt_registration.Text = dt.Rows[0][1].ToString();
            txt_bank.Text = dt.Rows[0][2].ToString();
            txt_account.Text = dt.Rows[0][3].ToString();
        }

        protected void cb_company_SelectedIndexChanged(object sender, EventArgs e)
        {
            DeliveryInfoSetting();
        }

        protected void chk_selfwrite_CheckedChanged(object sender, EventArgs e)
        {
            if(chk_selfwrite.Checked)
            {
                cb_company.Visible = false;
                txt_company.Visible = true;

                txt_tel.Text = "";
                txt_registration.Text = "";
                txt_bank.Text = "";
                txt_account.Text = "";
                txt_price.Text = "";
                txt_totalprice.Text = "";
            }
            else
            {
                cb_company.Visible = true;
                txt_company.Visible = false;
                cb_company.SelectedIndex = 0;
                DeliveryInfoSetting();
            }
        }

        protected void cb_divCode_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (cb_divCode.SelectedValue == "2")
            {
                hiddenfield.Visible = true;
                cb_company.SelectedIndex = 0;
                DeliveryInfoSetting();
            }
            else
            {
                hiddenfield.Visible = false;
            }
        }

        protected void btn_releaseComplate_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            km.BeginTran();

            try
            {
                string sql = "";
                string shipmentIdx = "";
                string releaseTime = DateTime.Now.ToString("yyyy-MM-dd (HH:mm)");

                if (chk_selfwrite.Checked)
                {
                    object[] objs = { txt_company, txt_tel, txt_registration, txt_bank, txt_account, txt_price, txt_totalprice, releaseTime };

                    shipmentIdx = PROCEDURE.CUD_ReturnID("SP_shipment_Add_Write_Customer", objs, km);
                }
                else
                {
                    object[] objs = { cb_divCode, cb_company, txt_tel, txt_registration, txt_bank, txt_account, txt_price, txt_totalprice,releaseTime };

                    shipmentIdx = PROCEDURE.CUD_ReturnID("SP_shipment_Add_Select_Customer", objs, km);
                }

                sql = "UPDATE tb_order_master SET " +
                     $"releaseDate = '{releaseTime}'," +
                     $"shipmentIdx = {shipmentIdx}," +
                      "state = '2' " +
                     $"WHERE orderCode IN ({hidden_codeList.Value.Substring(1)});";

                km.tran_ExSQL_Ret(sql);

                DataTable dt = km.tran_GetDTa($"SELECT actualItemCode,qty FROM tb_order_detail WHERE orderCode IN ({hidden_codeList.Value.Substring(1)});");

                sql = "";

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    sql += "UPDATE tb_inventory SET " +
                          $"rQty = rQty - {dt.Rows[0][1].ToString()} " +
                          $"WHERE itemCode = '{dt.Rows[0][0].ToString()}';";
                }

                km.tran_ExSQL_Ret(sql);

                km.Commit();

                Response.Write("<script>alert('출고처리되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.self.close();</script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>alert('저장 실패');</script>");
            }
        }
    }
}