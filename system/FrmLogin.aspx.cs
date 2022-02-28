using MysqlLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;

namespace iljin
{
    public partial class FrmLogin : ApplicationRoot
    {
        DB_mysql km = new DB_mysql();
        private void search()
        {
            if (km == null) km = new DB_mysql();

            string start_date = txt_sch_date1.Text;
            string end_date = txt_sch_date2.Text;
            string id = txt_id.Text;
            string name = txt_name.Text;

            if (start_date != "" && end_date != "") ;
            {
                //시작일이 종료일보다 클경우 서로를 바꿔준다.
                if (DateTime.Parse(start_date) > DateTime.Parse(end_date))
                {
                    txt_sch_date1.Text = end_date;
                    txt_sch_date2.Text = start_date;

                    //temp는 중간다리 역할
                    string temp;
                    temp = start_date;
                    start_date = end_date;
                    end_date = temp;
                }
            }

            object[] objs = { start_date, end_date, name, id };
            DataTable Mdt = PROCEDURE.SELECT("SP_loginhistory_GetBySearch", objs, km);
            grdTable.DataSource = Mdt;
            this.grdTable.DataBind();
            int rCnt = grdTable.Items.Count;
            int cCnt = grdTable.Columns.Count;
            for (int i=0; i < rCnt; i++)
            {
                for (int k=0; k < cCnt; k++)
                {
                    if (Mdt.Rows[i][k].ToString() != "") grdTable.Items[i].Cells[k].Text = Mdt.Rows[i][k].ToString();
                }
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                //초기화
                refresh();
                search();

            }

        }

        private void refresh() //초기화 해주는 함수
        {
            txt_sch_date1.Text = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1).ToString("yyyy-MM-dd");
            txt_sch_date2.Text = DateTime.Now.ToString("yyyy-MM-dd");
            txt_id.Text = "";
            txt_name.Text = "";
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            search();//조회
        }

        protected void btn_refresh_Click(object sender, EventArgs e)
        {
            refresh();//초기화
        }
    }
}