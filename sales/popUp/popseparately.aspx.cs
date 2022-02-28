using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;
using les;
using MysqlLib;
using System.Data;

namespace iljin.popUp
{
    public partial class popseparately : ApplicationRoot
    {
        private DB_mysql km;
        private string date;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_tcode.Value = Request.Params.Get("tcode");
                km.GetCbDT_FromSql("SELECT cusCode,cusName FROM tb_customer ORDER BY cusCode ASC;", cb_cusname, "전체");

                if (hdn_tcode.Value == "")
                {
                    date = DateTime.Now.ToString("yyyy-MM-dd");
                    txt_publisheddate.Text = date;
                    txt_transactionnum.Text = les_Tool_DB.SetCode("tb_transaction", "transactionCode", ConstClass.TRANSACTION_CODE_PREFIX, km);
                }
                else
                {
                    Search();
                }
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_transaction_Get_Separate", hdn_tcode.Value, km);

            txt_publisheddate.Text = dt.Rows[0]["publishDate"].ToString();
            txt_transactionnum.Text = dt.Rows[0]["transactionCode"].ToString();
            cb_cusname.SelectedValue = dt.Rows[0]["cusCode"].ToString();
            tb_itemname.Text = dt.Rows[0]["itemName"].ToString();
            txt_Qty.Text = dt.Rows[0]["qty"].ToString();
            txt_transactionDate.Text = dt.Rows[0]["transactionDate"].ToString();
            chk_isShow.Checked = dt.Rows[0]["isShowPrice"].ToString() == "0" ? false : true;
            txt_price.Text = dt.Rows[0]["price"].ToString(); 
            txt_totalPrice.Text = dt.Rows[0]["totalPrice"].ToString();
            txt_note.Text = dt.Rows[0]["memo"].ToString();

            cb_address_Setting(cb_cusname.SelectedValue);
            cb_customeraddress.SelectedValue = dt.Rows[0]["cusAddressIdx"].ToString();
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (cb_cusname.SelectedValue == "")
            {
                Response.Write("<script>alert('거래처를 선택해 주십시오.');</script>");
                return;
            }

            if (txt_transactionDate.Text == "")
            {
                Response.Write("<script>alert('거래일을 입력해 주십시오.');</script>");
                return;
            }

            if (DateTime.Compare(DateTime.Parse(txt_publisheddate.Text), DateTime.Parse(txt_transactionDate.Text)) > 0)
            {
                Response.Write("<script>alert('거래일을 미래 일자로 지정해 주십시오.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            km.BeginTran();

            try
            {
                if(hdn_tcode.Value == "") // 추가
                {
                    string tranNo = les_Tool_DB.SetCode_Tran("tb_transaction", "transactionCode", ConstClass.TRANSACTION_CODE_PREFIX, km);

                    object[] objs = { tranNo, cb_cusname, cb_customeraddress, tb_itemname, txt_Qty, txt_transactionDate, txt_publisheddate, txt_note, txt_price, txt_totalPrice, chk_isShow };

                    PROCEDURE.CUD_TRAN("SP_transaction_exception_Add", objs, km);

                }
                else // 수정
                { 
                    object[] objs = { txt_transactionnum, cb_cusname, cb_customeraddress, tb_itemname, txt_Qty, txt_transactionDate, txt_note, txt_price, txt_totalPrice, chk_isShow };

                    PROCEDURE.CUD_TRAN("SP_transaction_exception_Update", objs, km);

                }

                km.Commit();

                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch(Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message,km);

                Response.Write("<script>alert('저장 실패.');</script>");
            }
        }

        protected void cb_cusname_SelectedIndexChanged(object sender, EventArgs e)
        {

            string cusCode = cb_cusname.SelectedValue;

            if (cusCode == "")
            {
                txt_note.Text = "";
                cb_customeraddress.Items.Clear();
                return;
            }

            cb_address_Setting(cusCode);
            cb_customeraddress_SelectedIndexChanged(null, null);
        }

        private void cb_address_Setting(string cusCode)
        {
            if (km == null) km = new DB_mysql();
            km.GetCbDT_FromSql($"SELECT idx,addressName FROM tb_customer_address WHERE cusCode = '{cusCode}' ORDER BY idx ASC;", cb_customeraddress);
        }

        protected void cb_customeraddress_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();
            string addr = "";
            string tel = "";

            DataTable dt = km.GetDTa($"SELECT address1,tel FROM tb_customer_address WHERE idx = '{cb_customeraddress.SelectedValue}'");
            if (dt.Rows.Count > 0)
            {
                addr = dt.Rows[0][0].ToString();
                tel = dt.Rows[0][1].ToString();
            }
            txt_note.Text = cb_cusname.SelectedItem.Text + " : " + addr + ", " + tel;
        }
    }
}