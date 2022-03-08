using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;
using les;
using PublicLibsManagement;

namespace iljin
{
    public partial class Frmstockstatus : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                km.GetCbDT(ConstClass.ITEM_DIV1_CODE, cb_divCode1, "전체");
                km.GetCbDT(cb_divCode1.SelectedValue, cb_divCode2, "전체");

            }
        }

        private void Search()
        {
            //if (hidden_itemCode.Value == "")
            //{
            //    Response.Write("<script>alert('제품을 선택해 주십시오.');</script>");
            //    return;
            //}
            
            if (km == null) km = new DB_mysql();

            object[] objs = { tb_itemname,cb_divCode1,cb_divCode2 };

            DataTable dt = PROCEDURE.SELECT("SP_warehousing_Search_IncomeStatus", objs, km);

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable, dt, 0);
        }

       
        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }

        protected void cb_divCode1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();
            km.GetCbDT(cb_divCode1.SelectedValue, cb_divCode2, "전체");
        }
    }
}