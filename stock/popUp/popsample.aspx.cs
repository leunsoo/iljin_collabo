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
    public partial class popsample : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_idx.Value = Request.Params.Get("idx");
                hdn_userCode.Value = Session["userCode"].ToString();

                if(hdn_idx.Value != "")
                {
                    Search();
                }
                else
                {
                    txt_registrationdate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                    txt_register.Text = km.GetDTa($"SELECT empName FROM tb_emp WHERE userCode = '{hdn_userCode.Value}'; ").Rows[0][0].ToString();
                }
            }
        }

        //수정할떄만 발생함
        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] obj = { hdn_idx };

            if (hdn_idx.Value != "")
            {
                DataTable dt = PROCEDURE.SELECT("SP_sample_GetByIdx", obj, km);

                txt_registrationdate.Text = dt.Rows[0]["registrationdate"].ToString();
                hdn_userCode.Value = dt.Rows[0]["register"].ToString();
                txt_register.Text = dt.Rows[0]["empName"].ToString();
                txt_samplename.Text = dt.Rows[0]["samplename"].ToString();
                txt_customer.Text = dt.Rows[0]["customer"].ToString();
                txt_sampleQty.Text = dt.Rows[0]["Qty"].ToString();
                txt_memo.Text = dt.Rows[0]["memo"].ToString();
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();
            string idx = "";

            try
            {
                km.BeginTran();

                if (hdn_idx.Value != "")
                {
                    object[] obj = { hdn_idx.Value, txt_registrationdate, hdn_userCode, txt_samplename, txt_customer, txt_sampleQty, txt_memo };
                    PROCEDURE.CUD_TRAN("SP_sample_Update", obj, km);
                }
                else
                {
                    object[] obj = { txt_registrationdate, hdn_userCode, txt_samplename, txt_customer, txt_sampleQty, txt_memo };

                    PROCEDURE.CUD_TRAN("SP_sample_Add", obj, km);

                    ////구매현황을 저장했어요
                    //idx = PROCEDURE.CUD_ReturnID("SP_sample_Add", obj, km); // 그래서 새로 저장된 구매현황의 idx가 나왔어요
                     
                    ////그래서 저는 이 idx를 가지고 구매현황 제품에서 statusIdx = idx를 넣어줄거에요

                    //object[] objs = { 0, idx,itemName,txt_sampleQty,delte }
                }

                km.Commit();
                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>alert('저장실패');</script>");

            }

        }
    }
}
    
