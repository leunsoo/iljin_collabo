using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PublicLibsManagement;
using MysqlLib;

namespace iljin
{
    public partial class Frmsalesstatics : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (km == null) km = new DB_mysql();
                cb_year_Setting();
                cb_manager_Setting();
                Search();
            }
        }

        //검색년도 설정
        private void cb_year_Setting()
        {
            cb_year.Items.Clear();

            int year = int.Parse(DateTime.Now.ToString("yyyy"));

            for(int i = year; i > year - 3; i--)
            {
                cb_year.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            cb_year.SelectedIndex = 0;
        }

        //담당자 설정
        private void cb_manager_Setting()
        {
            if (km == null) km = new DB_mysql();

            cb_manager.Items.Clear();

            km.GetCbDT_FromSql("SELECT userCode,empName FROM tb_emp WHERE isUse = '1';", cb_manager, "전체");
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { cb_year,cb_manager };

            DataTable dt = PROCEDURE.SELECT("SP_Taxbill_GetYear", objs, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int qty = 0;
            int price = 0;
            int total = 0;

            for(int i = 0; i < grdTable.Items.Count; i++)
            {
                grdTable.Items[i].Cells[0].Text = (i + 1).ToString() + "월";
                for(int j = 1; j < grdTable.Columns.Count; j++)
                {
                    grdTable.Items[i].Cells[j].Text = String.Format("{0:#,0}", dt.Rows[i][j]);
                }

                qty += dt.Rows[i][1].ToString() == "" ? 0 : int.Parse(dt.Rows[i][1].ToString());
                price += dt.Rows[i][2].ToString() == "" ? 0 : int.Parse(dt.Rows[i][2].ToString());
                total += dt.Rows[i][3].ToString() == "" ? 0 : int.Parse(dt.Rows[i][3].ToString());
            }

            txt_qty.InnerHtml = String.Format("{0:#,0}", qty);
            txt_price.InnerHtml = String.Format("{0:#,0}", price);
            txt_total.InnerHtml = String.Format("{0:#,0}", total);
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }

        protected void btn_excel_Click(object sender, EventArgs e)
        {
            string filename = "수불집계" + DateTime.Now.ToString("yyMMdd") + "ExportExcel.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            exceldiv.RenderControl(hw);
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