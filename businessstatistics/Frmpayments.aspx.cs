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
    public partial class Frmpayments : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();
                grdTable_ColumnName_Change();
                Search();
            }
        }

        //그리드 컬럼명 현재월을 기준으로 바꿔주기
        private void grdTable_ColumnName_Change()
        {
            //우리가 바꿔야하는건 그리드의 필드명인데 이 그리드의 필드명은 <th>3월말<th> <= 이거를 해당 달에 따라서 바꿔줘야 함
            //html 태그의 텍스트를 코드로 바꿀 수 있나?

            txt_month0.InnerHtml = DateTime.Now.AddMonths(0).ToString("MM").Replace("0","") + "월말";
            txt_month1.InnerHtml = DateTime.Now.AddMonths(1).ToString("MM").Replace("0", "") + "월말";
            txt_month2.InnerHtml = DateTime.Now.AddMonths(2).ToString("MM").Replace("0", "") + "월말";
            txt_month3.InnerHtml = DateTime.Now.AddMonths(3).ToString("MM").Replace("0", "") + "월말";
            txt_month4.InnerHtml = DateTime.Now.AddMonths(4).ToString("MM").Replace("0", "") + "월말";
            txt_month5.InnerHtml = DateTime.Now.AddMonths(5).ToString("MM").Replace("0", "") + "월말";
            txt_month6.InnerHtml = DateTime.Now.AddMonths(6).ToString("MM").Replace("0", "") + "월말";
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { DateTime.Now.ToString("yyyy-MM-01"), txt_customer };

            DataTable dt = PROCEDURE.SELECT("SP_taxbill_GetMonth", objs, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int month_t0 = 0;
            int month_t1 = 0;
            int month_t2 = 0;
            int month_t3 = 0;
            int month_t4 = 0;
            int month_t5 = 0;
            int month_t6 = 0;

            for (int i = 0; i < grdTable.Items.Count; i++)
            {
                grdTable.Items[i].Cells[0].Text = dt.Rows[i][0].ToString();

                for(int j = 1; j < grdTable.Columns.Count; j++)
                {
                    grdTable.Items[i].Cells[j].Text = String.Format("{0:#,0}", dt.Rows[i][j]);
                }

                month_t0 += Convert.ToInt32(dt.Rows[i]["MONTH0"].ToString());
                month_t1 += Convert.ToInt32(dt.Rows[i]["MONTH1"].ToString());
                month_t2 += Convert.ToInt32(dt.Rows[i]["MONTH2"].ToString());
                month_t3 += Convert.ToInt32(dt.Rows[i]["MONTH3"].ToString());
                month_t4 += Convert.ToInt32(dt.Rows[i]["MONTH4"].ToString());
                month_t5 += Convert.ToInt32(dt.Rows[i]["MONTH5"].ToString());
                month_t6 += Convert.ToInt32(dt.Rows[i]["MONTH6"].ToString());
            }

            month0.InnerHtml = String.Format("{0:#,0}", month_t0);
            month1.InnerHtml = String.Format("{0:#,0}", month_t1);
            month2.InnerHtml = String.Format("{0:#,0}", month_t2);
            month3.InnerHtml = String.Format("{0:#,0}", month_t3);
            month4.InnerHtml = String.Format("{0:#,0}", month_t4);
            month5.InnerHtml = String.Format("{0:#,0}", month_t5);
            month6.InnerHtml = String.Format("{0:#,0}", month_t6);
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }

        protected void btn_excel_Click(object sender, EventArgs e)
        {
            string filename = "매출통계" + DateTime.Now.ToString("yyMMdd") + "ExportExcel.xls";
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