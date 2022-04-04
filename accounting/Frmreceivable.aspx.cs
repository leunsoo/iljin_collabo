using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PublicLibsManagement;
using MysqlLib;
using les;

namespace iljin
{
    public partial class Frmreceivable : ApplicationRoot
    {
        DB_mysql km;
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (km == null) km = new DB_mysql();


                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { tb_cusname, chk_isBlack };

            DataTable dt = PROCEDURE.SELECT("SP_collect_money_GetBySearch", objs, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();
            

            for(int i = 0; i < grdTable.Items.Count; i++)
            {
                grdTable.Items[i].Cells[0].Text =   dt.Rows[i][0].ToString();
                grdTable.Items[i].Cells[1].Text =  dt.Rows[i][1].ToString(); 
                grdTable.Items[i].Cells[2].Text = dt.Rows[i][2].ToString();
                grdTable.Items[i].Cells[3].Text = string.Format("{0:#,0}", dt.Rows[i][3]);//dt.Rows[i][3].ToString();





                // ((Button)grdTable.Items[i].FindControl("btn_regist")).Attributes.Add("onclick", $"collectmoney('{dt.Rows[i][0].ToString()}'); return false;");
            }
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            Search();
        }

        protected void btn_excel_Click(object sender, EventArgs e)
        {
            string filename = "미수금관리" + DateTime.Now.ToString("yyMMdd") + ".xls";
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