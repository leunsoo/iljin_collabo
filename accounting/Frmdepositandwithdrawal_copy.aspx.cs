using MysqlLib;
using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;

namespace iljin
{
    public partial class Frmdepositandwithdrawal_copy : ApplicationRoot
    {
        DB_mysql km;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (km == null) km = new DB_mysql(); //db연결

                //cb_withdrawaldiv_Setting();
                //set_date();

                //Search();
            }

        }

        private void Search()
        {
            //if (km == null) km = new DB_mysql(); //db연결

            //object[] obj = { tb_withdrawaldate, tb_withdrawaldate2, txt_customer, cb_withdrawaldiv };

            ////dt에 프로시저의 결과물을 넣어주는 부분
            //DataTable dt = PROCEDURE.SELECT("SP_withdrawal_GetbySearch",obj,km);

            //grdTable.DataSource = dt;
            //grdTable.DataBind();

            //int rowCount = grdTable.Items.Count;
            //int colCount = grdTable.Columns.Count;

            ////grdTable 에 dt의 값을 넣어주는 for문
            //for( int i = 0; i < rowCount;  i++)
            //{
            //    grdTable.Items[i].Cells[0].Text = (i + 1).ToString();

            //    for (int j = 1; j < colCount -1; j++)
            //    {
            //        if (dt.Rows[i][j].ToString() != "") grdTable.Items[i].Cells[j].Text = dt.Rows[i][j].ToString();
            //    }

            //    ((Button)grdTable.Items[i].FindControl("btn_check")).Attributes.Add("onclick", $"withdrawal('{dt.Rows[i][0].ToString()}'); return false;");
            //    ((Button)grdTable.Items[i].FindControl("btn_del")).Attributes.Add("onclick",$"remove('{dt.Rows[i][0].ToString()}','{i.ToString()}'); return false;");
            //}
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            //Search();
        }

        private void set_date() //날짜를 불러올때 쓰이는 함수
        {
            //해당년도 1월 1일
            //DateTime schDate1 = new DateTime(DateTime.Now.Year, 1, 1);
            ////해당년도 현재일
            //DateTime schDate2 = DateTime.Now;

            //tb_withdrawaldate.Text = schDate1.ToString("yyyy-MM-dd");
            //tb_withdrawaldate2.Text = schDate2.ToString("yyyy-MM-dd");
        }

    }
}