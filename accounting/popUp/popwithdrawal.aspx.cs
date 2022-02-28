using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;
using MysqlLib;
using System.Data;
using System.IO;

namespace iljin.popUp
{
    public partial class popwithdrawal : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql(); //db연결

                hdn_idx.Value = Request.Params.Get("code");
                km.GetCbDT(ConstClass.WITHDRAWAL_CODE, cb_paymentType);

                if (hdn_idx.Value != "")
                {
                    Search();
                }
                else
                {
                    txt_registrationdate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    btn_delete.Visible = false;
                }
            }
        }

        // 수정할 때만 발생함
        private void Search()
        {
            if (km == null) km = new DB_mysql(); //db 연결

            object[] obj = { hdn_idx };

            if (hdn_idx.Value !="")
            {
                DataTable dt = PROCEDURE.SELECT("SP_withdrawal_GetByIdx", obj, km);

                txt_registrationdate.Text = dt.Rows[0]["registrationdate"].ToString();
                txt_cusname.Text = dt.Rows[0]["cusName"].ToString();
                hidden_cusCode.Value = dt.Rows[0]["cusCode"].ToString();
                txt_price.Text = dt.Rows[0]["price"].ToString();
                cb_paymentType.SelectedValue = dt.Rows[0]["paymentType"].ToString();
                txt_manager.Text = dt.Rows[0]["manager"].ToString();
                txt_memo.Text = dt.Rows[0]["memo"].ToString();
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if(hidden_cusCode.Value == "")
            {
                Response.Write("<script>alert('거래처를 입력해 주십시오.');</script>");
                return;
            }


            if (km == null) km = new DB_mysql();

            try
            {
                km.BeginTran();

                if (hdn_idx.Value != "")
                {
                    object[] obj = {hdn_idx.Value,txt_registrationdate,hidden_cusCode,txt_price,cb_paymentType,txt_manager,txt_memo};
                    PROCEDURE.CUD_TRAN("SP_withdrawal_Update", obj, km);
                }
                else
                { 
                    object[] obj = {txt_registrationdate,hidden_cusCode,txt_price,cb_paymentType,txt_manager,txt_memo};
                    PROCEDURE.CUD_TRAN("SP_withdrawal_Add", obj, km);
                }

                km.Commit();
                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>('저장실패');</script>");
            }
        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();
            
            try
            {
                km.BeginTran();

                PROCEDURE.CUD_TRAN("SP_withdrawal_Delete", hdn_idx.Value, km);

                km.Commit();
                Response.Write("<script>alert('삭제되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>('삭제실패');</script>");
            }
        }
    }
}
