using MysqlLib;
using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;
using System.Drawing;
using les;

namespace iljin
{
    public partial class Frmdepositandwithdrawal : ApplicationRoot
    {
        DB_mysql km;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql(); //db연결

                txt_cusCode.Attributes.Add("readonly", "readonly");

                set_date();
                Search();
            }

        }

        private void Search()
        {
            if (km == null) km = new DB_mysql(); //db연결

            object[] obj = { tb_tradedt, tb_tradedt2, txt_cusCode };

            //dt에 프로시저의 결과물을 넣어주는 부분
            DataTable dt = PROCEDURE.SELECT("SP_withdrawal_GetbySearch", obj, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;

            int price = 0;

            Button btn;
            string div;

            //grdTable 에 dt의 값을 넣어주는 for문
            for (int i = rowCount - 1; i >= 0; i--)
            {
                for(int j = 0; j < colCount - 1; j++)
                {
                    grdTable.Items[rowCount - 1 - i].Cells[j].Text = dt.Rows[i][j].ToString();
                }

                div = dt.Rows[i][6].ToString();

                btn = grdTable.Items[rowCount - 1 - i].FindControl("btn_check") as Button;

                if(div == "")
                {
                    btn.Attributes.Add("onclick", "return false;");
                }
                else if(div.Contains("TB"))
                {
                    btn.Attributes.Add("onclick", "return false;");
                    btn.BackColor = Color.Red;
                    btn.Text = "발행";
                }
                else
                {
                    btn.Attributes.Add("onclick", $"withdrawal('{div}'); return false;");
                    btn.BackColor = Color.Green;
                    btn.Text = "수정";
                }
            }
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            Search();
        }

        private void set_date() //날짜를 불러올때 쓰이는 함수
        {
            tb_tradedt.Text = DateTime.Now.AddYears(-1).ToString("yyyy-01-01");
            tb_tradedt2.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }

        protected void btn_excel_Click(object sender, EventArgs e)
        {
            string filename = "매출/입금관리" + DateTime.Now.ToString("yyMMdd") + "ExportExcel.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            exceldiv.RenderControl(hw);
            Response.ContentType = "application/vnd.ms_excel";
            Response.Charset = "euc-kr";
            Response.ContentEncoding = System.Text.Encoding.GetEncoding("euc-kr");
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "");
            this.EnableViewState = false;
            Response.Write(tw.ToString());
            Response.End();
        }
    }
}