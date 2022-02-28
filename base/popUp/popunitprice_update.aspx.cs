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
    public partial class popunitprice_update : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_itemCode.Value = Request.Params.Get("code");
                hdn_empCode.Value = Session["userCode"].ToString();
                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            tb_itemName.Text = km.GetDTa($"Select fullName From tb_item WHERE itemCode = '{hdn_itemCode.Value}'").Rows[0]["fullName"].ToString();
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if(DateTime.Compare(DateTime.Now,DateTime.Parse(tb_adjustDate.Text)) > 0)
            {
                Response.Write("<script>alert('적용일자는 현재일보다 미래여야 합니다.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            try
            {
                object[] objs = { hdn_itemCode, tb_changeUnitprice, tb_adjustDate, hdn_empCode };
                PROCEDURE.CUD("SP_unitprice_Add", objs, km);
                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('저장실패.');</script>");
            }
        }
    }
}