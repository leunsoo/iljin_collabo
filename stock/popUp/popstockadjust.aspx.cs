using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using PublicLibsManagement;

namespace iljin.popUp
{
    public partial class popstockadjust : ApplicationRoot
    {
        DB_mysql km;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                txt_adjustQty.Attributes.Add("readonly", "readonly");
                txt_beforeadjust.Attributes.Add("readonly", "readonly");
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if(hidden_itemCode.Value == "")
            {
                Response.Write("<script>alert('제품을 선택해 주십시오.');</script>");
                return;
            }

            int iQty = 0;
                
            if(!int.TryParse(txt_afteradjust.Text,out iQty))
            {
                Response.Write("<script>alert('조정후 재고를 정확히 입력해 주십시오.');</script>");
                return;
            }

            if (iQty < 0)
            {
                Response.Write("<script>alert('조정후 재고가 0보다 작을 수 없습니다.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            try
            {
                string empCode = Session["userCode"].ToString();
                string date = DateTime.Now.ToString("yyyy-MM-dd");

                object[] objs = { date,hidden_itemCode,txt_beforeadjust,txt_adjustQty,empCode };

                PROCEDURE.CUD("SP_inventory_adjust_Add", objs, km);

                Response.Write("<script>alert('저장되었습니다.'); window.opener.refresh();window.close();</script>");
            }
            catch(Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>alert('저장 실패');</script>");
            }
        }

        //제품 선택 시 현 재고 가져오기 <= 조정전 재고
        protected void btn_itemQtySetting_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            string sQty = km.GetDTa($"SELECT qty FROM tb_inventory WHERE itemCode = '{hidden_itemCode.Value}';").Rows[0][0].ToString();

            txt_beforeadjust.Text = sQty;

            txt_adjustQty.Text = "0";
            txt_afteradjust.Text = sQty;
        }
    }
}