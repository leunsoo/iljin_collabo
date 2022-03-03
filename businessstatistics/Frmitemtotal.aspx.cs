using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using PublicLibsManagement;
using System.Data;

namespace iljin
{
    public partial class Frmitemtotal : ApplicationRoot
    {
        DB_mysql km;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                txt_deliveryDate.Text = DateTime.Now.AddMonths(-6).ToString("yyyy-MM");
                txt_deliveryDate2.Text = DateTime.Now.ToString("yyyy-MM");

                cb_divCode1_Setting();
                cb_divCode2_Setting();
                cb_sort_Setting();

                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            string tdate = DateTime.Parse(txt_deliveryDate2.Text).AddMonths(1).ToString("yyyy-MM");

            object[] objs = { txt_deliveryDate, tdate, txt_thickness, cb_divCode1, cb_divCode2, cb_sort };

            DataTable dt = PROCEDURE.SELECT("SP_item_GetTotal",objs, km);
            grdTable.DataSource = dt;
            grdTable.DataBind();

            int qty = 0;
            int price = 0;
            int weight = 0;
            int total = 0;

            for(int i = 0;  i < grdTable.Items.Count; i ++)
            {
                grdTable.Items[i].Cells[0].Text = (i + 1).ToString();

                for(int j = 1; j < grdTable.Columns.Count; j++)
                {
                    grdTable.Items[i].Cells[j].Text = String.Format("{0:#,0}", dt.Rows[i][j-1]);
                }

                qty += int.Parse(dt.Rows[i][1].ToString());
                price += int.Parse(dt.Rows[i][2].ToString());
                total += int.Parse(dt.Rows[i][3].ToString());
            }

            txt_qty.InnerHtml = String.Format("{0:#,0}", qty);
            txt_price.InnerHtml = String.Format("{0:#,0}", price);
            txt_total.InnerHtml = String.Format("{0:#,0}", total);
        }

        //정렬기준 셋팅
        private void cb_sort_Setting()
        {
            cb_sort.Items.Clear();

            cb_sort.Items.Add(new ListItem("수량", "0"));
            cb_sort.Items.Add(new ListItem("금액", "1"));
            cb_sort.Items.Add(new ListItem("중량", "2"));
        }

        //제품구분1 셋팅
        private void cb_divCode1_Setting()
        {
            if (km == null) km = new DB_mysql();
            km.GetCbDT(ConstClass.ITEM_DIV1_CODE, cb_divCode1, "전체");
        }

        //제품구분2 셋팅
        private void cb_divCode2_Setting()
        {
            if (km == null) km = new DB_mysql();
            km.GetCbDT(cb_divCode1.SelectedValue, cb_divCode2, "전체");
        }

        protected void cb_divCode1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();
            km.GetCbDT(cb_divCode1.SelectedValue, cb_divCode2,"전체");
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }
    }
}