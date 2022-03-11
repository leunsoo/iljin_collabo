using MysqlLib;
using System;
using System.Data;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;
using les;

namespace iljin
{
    public partial class Frmstockcut : ApplicationRoot
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
        private void Search()//조회
        {

            if (km == null) km = new DB_mysql();

            object[] obj = { tb_registrationdate, tb_registrationdate2, tb_item };

            DataTable dt = PROCEDURE.SELECT("SP_item_remake_GetBySearch", obj, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            //그리드테이블의 컬럼의 개수
            int colCount = grdTable.Columns.Count;

            int rowSpan = 1;
            string mergeValue = "";

            for (int i = 0; i < rowCount; i++)
            {
                mergeValue = dt.Rows[i][0].ToString();

                if (i < rowCount - 1 && mergeValue == dt.Rows[i + 1][0].ToString())
                {
                    rowSpan++;

                    grdTable.Items[i - rowSpan + 2].Cells[0].RowSpan = rowSpan;
                    grdTable.Items[i + 1].Cells[0].Visible = false;

                    for (int j = 1; j < 6; j++)
                    {
                        //((CheckBox)grdTable.Items[i].FindControl("grd_checkBox")).Visible = false;

                        grdTable.Items[i - rowSpan + 2].Cells[j].RowSpan = rowSpan;
                        grdTable.Items[i - rowSpan + 2].Cells[j].Text = dt.Rows[i][j-1].ToString();

                        grdTable.Items[i + 1].Cells[j].Visible = false;
                    }
                }
                else
                {
                    for (int j = 1; j < 6; j++)
                    {
                        grdTable.Items[i].Cells[j].Text = dt.Rows[i][j-1].ToString();
                    }
                    rowSpan = 1;
                }

                for (int j = 6; j < grdTable.Columns.Count; j++)
                {
                    grdTable.Items[i].Cells[j].Text = dt.Rows[i][j-1].ToString();
                }

                if (i == rowCount - 1)
                {
                    for (int j = 1; j < 6; j++)
                    {
                        if (grdTable.Items[i].Cells[j].Visible)
                        {
                            grdTable.Items[i].Cells[j].Text = dt.Rows[i][j-1].ToString();
                        }
                    }
                }
            }
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            Search();
        }

        private void set_date()
        {
            tb_registrationdate.Text = DateTime.Now.AddDays(-5).ToString("yyyy-MM-dd");
            tb_registrationdate2.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }

        protected void btn_del_Click(object sender, EventArgs e) //삭제
        {
            //db연결
            if (km == null) km = new DB_mysql();

            string serialNo = "";
            int rowCount = grdTable.Items.Count;
            int chkCount = 0;

            for (int i = 0; i < rowCount; i++)
            {
                if (((CheckBox)grdTable.Items[i].FindControl("grd_checkBox")).Checked)
                {
                    serialNo += ",'" + grdTable.Items[i].Cells[1].Text + "'";
                    chkCount++;
                }
            }

            if (chkCount == 0) return;
            serialNo = serialNo.Substring(1);

            string sql = $"DELETE FROM tb_item_remake WHERE serialNo IN ({serialNo}); " +
                         $"DELETE FROM tb_item_remake_detail WHERE serialNo IN ({serialNo});";

            km.ExSQL_Ret(sql);
            Response.Write("<script>alert('삭제되었습니다.')</script>");
            Search();
        }

        protected void btn_update_Click(object sender, EventArgs e)
        {
            string code = ""; // 일련번호를 저장할 code 명을 가진 string 타입 변수
            if (km == null) km = new DB_mysql(); // DB 연결 (DB에서 UPDATE를 해야하니깐)

            //그리드의 모든 row를 탐색
            for(int i = 0; i < grdTable.Items.Count;i++)
            {
                //만약 i번째 row의 체크박스가 체크되어있으면
                if(((CheckBox)grdTable.Items[i].FindControl("grd_checkBox")).Checked)
                {
                    //해당 row의 1번째 cell에 있는 값(일련번호)를 code에 저장한다.
                    code = grdTable.Items[i].Cells[1].Text;
                    //찾으면 break를 통해서 for문에서 빠져나온다. or for문을 중단한다
                    //why? 우리는 하나의 선택되어 있는 체크박스만 찾으면 되기 때문에
                    // => 우리는 작업지시서를 출력한 작업의 작업상태를 변경해주어야 하는데
                    //    이때,, 작업지시서는 하나의 작업만 출력가능하기 때문에
                    //          체크박스는 작업지시서를 출력한 작업(오직 하나) 체크되어 있기 때문이다.
                    break;
                }
            }

            //체크되어 있는 row를 찾고 그 row의 cell의 1번째 값(일련번호)를 code에 저장했으면
            //밑에 작성된 query 문을 통해 체크박스가 선택되어 있던 작업의 작업상태를 변경해준다.
            km.ExSQL_Ret("UPDATE tb_item_remake SET workStatus = '1' WHERE serialNo = '" + code + "' AND workStatus = '0'");

            //변경해주었다는걸 시각적으로 나타내기 위해 Search() 함수를 실행해준다.
            Search();
        }
    }
}

    



