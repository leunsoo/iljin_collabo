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
    public partial class Frmsample : ApplicationRoot
    {
        DB_mysql km;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                set_date();

                Search();
            }
        }

        //조회
        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] obj = { tb_registrationdate, tb_registrationdate2, tb_samplename };

            //dt에 프로시저의 결과물을 넣어주는 부분
            DataTable dt = PROCEDURE.SELECT("SP_sample_GetBySearch", obj, km);
            

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;

            //grdTable에 dt의 값을 넣어주는 for문 
            for (int i = 0; i < rowCount; i++)
            {
                grdTable.Items[i].Cells[0].Text = (i + 1).ToString();

                for (int j = 1; j < colCount - 1; j++)
                {
                    if (dt.Rows[i][j].ToString() != "") grdTable.Items[i].Cells[j].Text = dt.Rows[i][j].ToString();
                }

                 ((Button)grdTable.Items[i].FindControl("btn_correction")).Attributes.Add("onclick", $"sample('{dt.Rows[i][0].ToString()}');");
                 ((Button)grdTable.Items[i].FindControl("btn_del")).Attributes.Add("onclick", $"remove('{dt.Rows[i][0].ToString()}');");
            }

        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }

        private void set_date()// 날짜를 불러올때(설정) 쓰이는 함수
        {
            
            DateTime schDate1 =  DateTime.Now.AddYears(-1);
            //해당년도 현재일
            DateTime schDate2 = DateTime.Now;

            tb_registrationdate.Text = schDate1.ToString("yyyy-01-01");
            tb_registrationdate2.Text = schDate2.ToString("yyyy-MM-dd");

        }

        protected void btn_deleteFunc_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();


            try
            {
                km.BeginTran();

                object[] objs = { hdn_idx };

                PROCEDURE.CUD_TRAN("SP_sample_Delete", objs, km);

                km.Commit();
                Response.Write("<script>alert('삭제되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");

                Search();
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>alert('삭제실패');</script>");
            }
        }
    }
}

