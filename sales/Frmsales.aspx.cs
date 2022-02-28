using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PublicLibsManagement;
using les;
using MysqlLib;

namespace iljin.Menu.sales
{
    public partial class Frmsales : ApplicationRoot
    {
        DB_mysql km = new DB_mysql();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                txt_deliveryDate.Text = DateTime.Now.AddMonths(-6).ToString("yyyy-MM");
                txt_deliveryDate2.Text = DateTime.Now.ToString("yyyy-MM");

                cb_manager_Setting();
                Search();
            }
        }

        private void cb_manager_Setting()
        {
            if (km == null) km = new DB_mysql();

            km.GetCbDT_FromSql("SELECT userCode,empName FROM tb_emp WHERE isUse = '1';", cb_manager, "전체");
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            string date = DateTime.Parse(txt_deliveryDate2.Text).AddMonths(1).ToString("yyyy-MM");

            object[] objs = { txt_deliveryDate, date, cb_manager };

            DataTable dt = PROCEDURE.SELECT("SP_order_master_GetSalesCost_ByUserCode", objs, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int iprice = 0;
            int itotal = 0;
            int icost = 0;

            string sprice = "";
            string stotal = "";
            string scost = "";

            for(int i = 0; i < grdTable.Items.Count; i ++)
            {
                grdTable.Items[i].Cells[0].Text = (i + 1).ToString();
                grdTable.Items[i].Cells[1].Text = dt.Rows[i]["empName"].ToString();

                grdTable.Items[i].Cells[2].Text = sprice = dt.Rows[i]["price"].ToString();
                grdTable.Items[i].Cells[3].Text = stotal = dt.Rows[i]["totalPrice"].ToString();
                grdTable.Items[i].Cells[4].Text = scost = dt.Rows[i]["cost"].ToString();

                iprice += sprice == "" ? 0 : int.Parse(sprice);
                itotal += stotal == "" ? 0 : int.Parse(stotal);
                icost += scost == "" ? 0 : int.Parse(scost);

                ((HiddenField)grdTable.Items[i].FindControl("grd_hdn_code")).Value = dt.Rows[i][0].ToString();
                ((Button)grdTable.Items[i].FindControl("grd_btn_detail")).Attributes.Add("onclick", $"move_to_detail('{dt.Rows[i][0].ToString()}','{txt_deliveryDate.Text}','{date}'); return false;");
            }

            txt_sumPrice.InnerHtml = string.Format("{0:#,0}", iprice);
            txt_sumTotal.InnerHtml = string.Format("{0:#,0}", itotal);
            txt_sumCost.InnerHtml = string.Format("{0:#,0}", icost);
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }
    }
}