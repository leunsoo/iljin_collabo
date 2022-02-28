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
    public partial class Frmdepositandwithdrawal : ApplicationRoot
    {
        DB_mysql km;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql(); //db연결

                cb_withdrawaldiv_Setting();
                set_date();

                Search();
            }

        }

        private void cb_withdrawaldiv_Setting()
        {
            cb_withdrawaldiv.Items.Clear();

            cb_withdrawaldiv.Items.Add(new ListItem("전체", ""));
            cb_withdrawaldiv.Items.Add(new ListItem("입금", "0"));
            cb_withdrawaldiv.Items.Add(new ListItem("출금", "1"));
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql(); //db연결

            object[] obj = { tb_withdrawaldate, tb_withdrawaldate2, txt_customer, cb_withdrawaldiv };

            //dt에 프로시저의 결과물을 넣어주는 부분
            DataTable dt = PROCEDURE.SELECT("SP_withdrawal_GetbySearch",obj,km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;

            //grdTable 에 dt의 값을 넣어주는 for문
            for( int i = 0; i < rowCount;  i++)
            {
                grdTable.Items[i].Cells[0].Text = (i + 1).ToString();

                for (int j = 1; j < colCount -1; j++)
                {
                    if (dt.Rows[i][j].ToString() != "") grdTable.Items[i].Cells[j].Text = dt.Rows[i][j].ToString();
                }

                ((Button)grdTable.Items[i].FindControl("btn_check")).Attributes.Add("onclick", $"withdrawal('{dt.Rows[i][0].ToString()}'); return false;");
                ((Button)grdTable.Items[i].FindControl("btn_del")).Attributes.Add("onclick",$"remove('{dt.Rows[i][0].ToString()}','{i.ToString()}'); return false;");
            }
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            Search();
        }

        private void set_date() //날짜를 불러올때 쓰이는 함수
        {
            //해당년도 1월 1일
            DateTime schDate1 = new DateTime(DateTime.Now.Year, 1, 1);
            //해당년도 현재일
            DateTime schDate2 = DateTime.Now;

            tb_withdrawaldate.Text = schDate1.ToString("yyyy-MM-dd");
            tb_withdrawaldate2.Text = schDate2.ToString("yyyy-MM-dd");
        }

        //삭제 버튼을 클릭하였을때 db를 연결하여 삭제를 시도한다.
        // object 가 hdn_idx 일때, 프로시저 withdrawal_delete 연동, 삭제 성공하면 (search) 삭제 되었는지 확인한다.
        // 삭제 실패시 삭제 실패 창을 띄운다. (데이터 삭제 되지 않음)
        protected void btn_deleteFunc_Click(object sender,  EventArgs e)
        {
            if (km == null) km = new DB_mysql(); //db연결

            try //삭제 버튼 클릭시 삭제 시도
            {
                km.BeginTran();

                object[] obj = { hdn_idx }; //object가 hdn_idx일때 <= ?? idx를 찾아서(no = 1, 2, 3, 4, ,5 ,6 ,. .. ) 삭제시키는 로직

                PROCEDURE.CUD_TRAN("SP_withdrawal_Delete", obj, km); //프로시저 withdrawal_Delete 연동 ( obj의 값을 받아서 어떻게 실행되는가? ) 
                //히든 idx의 no가 1일때
                //DElete proc에서 1인 idx를 찾아서 idx = 1 ?-? 1인 idx란게
                //히든idx와 deleteproc의 idx와 일치하면
                //삭제해준다.

                //아! 프로시져에서 저장된건 테이블에도 저장되는구나!

                //DELETE FROM tb_a~ WHERE column field = _idx;

                km.Commit(); //삭제 성공
                Response.Write("<script>alert('삭제되었습니다.');</script>"); //삭제 되었습니다. 창 띄우기

                // <=\???????????????????????????????
                //Response.Write("<script>window.opener.refresh();</script>"); //<=? 윈도우창을 열어주고 새로고침
                //opener <= open + er <= er ? er open <= 열다 opener 열어주는사람 refresh(); .~~~(); <= 95% 기능을 말하는겁니다.

                //Response.Write("<script>window.close();</script>"); //삭제 창 닫기

                Search(); // 삭제후 조회하여 삭제 되었는지 확인
            }
            catch (Exception ex) //삭제 실패시 
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message,km); //에러메세지

                Response.Write("<script>alert('삭제실패');</script>"); //삭제 실패 창 띄우기
            }
        }
    }
}