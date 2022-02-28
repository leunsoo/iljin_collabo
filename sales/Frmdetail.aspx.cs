using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using les;
using PublicLibsManagement;
using MysqlLib;

namespace iljin
{
    public partial class Frmdetail : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_ucode.Value = Request.Params.Get("ucode");
                hdn_sdt.Value = Request.Params.Get("sdt");
                hdn_edt.Value = Request.Params.Get("edt");
                SetManagerName();
                Search();
            }
        }

        private void SetManagerName()
        {
            if (km == null) km = new DB_mysql();

            hdn_uname.Value = km.GetDTa($"SELECT empName FROM tb_emp WHERE userCode = '{hdn_ucode.Value}';").Rows[0][0].ToString();
         
        }

        private void Search()
        {
            txt_manager.InnerHtml = "담당직원 : " + hdn_uname.Value;

            if (km == null) km = new DB_mysql();

            object[] objs = { hdn_sdt,hdn_edt,hdn_ucode,txt_cusName };

            DataTable dt = PROCEDURE.SELECT("SP_order_master_GetSalesCost_ByUserCode_detail", objs, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int iprice = 0;
            int itotal = 0;

            string sprice = "";
            string stotal = "";

            for (int i = 0; i < grdTable.Items.Count; i++)
            {
                grdTable.Items[i].Cells[0].Text = (i + 1).ToString();

                grdTable.Items[i].Cells[1].Text = dt.Rows[i]["orderDate"].ToString();
                grdTable.Items[i].Cells[2].Text = dt.Rows[i]["deliveryDate"].ToString();
                grdTable.Items[i].Cells[3].Text = dt.Rows[i]["orderCode"].ToString();
                grdTable.Items[i].Cells[4].Text = dt.Rows[i]["cusName"].ToString();
                grdTable.Items[i].Cells[5].Text = sprice = dt.Rows[i]["price"].ToString();
                grdTable.Items[i].Cells[6].Text = stotal = dt.Rows[i]["total"].ToString();

                iprice += sprice == "" ? 0 : int.Parse(sprice);
                itotal += stotal == "" ? 0 : int.Parse(stotal);
            }

            txt_sumprice.InnerHtml = string.Format("{0:#,0}", iprice);
            txt_sumtotal.InnerHtml = string.Format("{0:#,0}", itotal);
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }
    }
}