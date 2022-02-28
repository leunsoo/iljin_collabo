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

        private void Select()
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
            lbl_produceItem.Text = Mdt.Rows[0]["prodI"].ToString();
            lbl_produceItemQty.Text = Mdt.Rows[0]["produceItemQty"].ToString();
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                code = Request.Params.Get("code");

                Select();
            }


        }


    }
}
