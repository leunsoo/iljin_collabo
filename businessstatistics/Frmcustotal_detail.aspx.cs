using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MysqlLib;
using PublicLibsManagement;

namespace iljin
{
    public partial class Frmcustotal_detail : ApplicationRoot
    {
        DB_mysql km;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                txt_deliveryDate.Text = Request.Params.Get("sdt").ToString();
                txt_deliveryDate2.Text = Request.Params.Get("edt").ToString();
                hdn_cusCode.Value = Request.Params.Get("code").ToString();

                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            string tdate = DateTime.Parse(txt_deliveryDate2.Text).AddMonths(1).ToString("yyyy-MM");

            object[] objs = { txt_deliveryDate, tdate, hdn_cusCode };

            DataTable dt = PROCEDURE.SELECT("SP_taxbill_GetByCustomer_detail", objs, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int price = 0;
            int total = 0;

            for(int i = 0; i<grdTable.Items.Count; i++)
            {
                grdTable.Items[i].Cells[0].Text = (i + 1).ToString();
                grdTable.Items[i].Cells[1].Text = dt.Rows[i][0].ToString();
                grdTable.Items[i].Cells[2].Text = dt.Rows[i][1].ToString();
                grdTable.Items[i].Cells[3].Text = dt.Rows[i][2].ToString();
                grdTable.Items[i].Cells[4].Text = dt.Rows[i][3].ToString();
                grdTable.Items[i].Cells[5].Text = String.Format("{0:#,0}", dt.Rows[i][4]); 
                grdTable.Items[i].Cells[6].Text = String.Format("{0:#,0}", dt.Rows[i][5]);

                price += int.Parse(dt.Rows[i][4].ToString());
                total += int.Parse(dt.Rows[i][5].ToString());

            }

            txt_price.InnerHtml = String.Format("{0:#,0}", price);
            txt_total.InnerHtml = String.Format("{0:#,0}", total);
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }

        protected void btn_excel_Click(object sender, EventArgs e)
        {
            string filename = "거래처별집계(상세)" + DateTime.Now.ToString("yyMMdd") + ".xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            exceldiv2.RenderControl(hw);
            Response.ContentType = "application/vnd.ms-excel";
            Response.Charset = "euc-kr";
            Response.ContentEncoding = System.Text.Encoding.GetEncoding("euc-kr");
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "");
            this.EnableViewState = false;
            Response.Write(tw.ToString());
            Response.End();
        }
    }
}