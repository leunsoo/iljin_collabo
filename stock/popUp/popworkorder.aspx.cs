using MysqlLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;

namespace iljin.popUp
{
    public partial class popworkorder : ApplicationRoot
    {
        DB_mysql km;
        string code;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                code = Request.Params.Get("code");

                Search_Info();
                Search_Item_Info();
            }
        }

        private void Search_Info()
        {
            if (km == null) km = new DB_mysql();

            DataTable Mdt = PROCEDURE.SELECT("SP_item_remake_GetbyCode", code, km);

            if (Mdt.Rows.Count < 1)
                return;

            lbl_serialNo.Text = code;
            lbl_registrationDate.Text = Mdt.Rows[0]["registrationDate"].ToString();
            lbl_workDate.Text = Mdt.Rows[0]["workdate"].ToString();
            lbl_foreignIdx.Text = Mdt.Rows[0]["name"].ToString();
            lbl_machineNo.Text = Mdt.Rows[0]["machineName"].ToString();
            lbl_empCode.Text = Mdt.Rows[0]["empName"].ToString();
            lbl_workItem.Text = Mdt.Rows[0]["workI"].ToString();
            lbl_workItemQty.Text = Mdt.Rows[0]["workItemQty"].ToString();
        }

        //생산제품 정보
        private void Search_Item_Info()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_item_remake_detail_GetBySerialNo", code, km);

            grdTable1.DataSource = dt;
            grdTable1.DataBind();

            for (int i = 0; i < grdTable1.Items.Count; i++)
            {
                grdTable1.Items[i].Cells[0].Text = "품목";
                grdTable1.Items[i].Cells[1].Text = dt.Rows[i][1].ToString();
                grdTable1.Items[i].Cells[2].Text = "수량";
                grdTable1.Items[i].Cells[3].Text = dt.Rows[i][2].ToString();
            }

        }
    }
}
