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

namespace iljin
{
    public partial class Frmpurchase : ApplicationRoot
    {

        DB_mysql km = new DB_mysql();
        DataTable Mdt;
        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (!IsPostBack)
            {
                set_date();/*;*/

             //  cb_progress_Setting();
                km.GetCbDT(ConstClass.PROGRESS_CODE, cb_progress, "전체");

                Search(true);

            }
        }

      // private void cb_progress_Setting()
      //  {
            //if (km == null) km = new DB_mysql();

            //cb_progress.Items.Clear();

           // cb_progress.Items.Add(new ListItem("전체", ""));
          //  cb_progress.Items.Add(new ListItem("협의중", "0"));
          //  cb_progress.Items.Add(new ListItem("계약완료", "1"));
          //  cb_progress.Items.Add(new ListItem("입고완료","2"));
          //  cb_progress.Items.Add(new ListItem("보류", "3"));
      //  }


        private void Search(bool isGetByDB)
        {
            if (km == null) km = new DB_mysql();

         
            object[] obj = { tb_requestdate, tb_requestdate2,cb_progress};

            if (isGetByDB)
            {
                Mdt = PROCEDURE.SELECT("SP_purchase_status_GetBySearch", obj, km);
            }
            grdTable.DataSource = Mdt;
            grdTable.DataBind();
           

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;

           // TextBox tb;

            for (int i = 0; i < rowCount; i++)
            {
                grdTable.Items[i].Cells[1].Text = (i + 1).ToString();
                grdTable.Items[i].Cells[2].Text = Mdt.Rows[i]["requestDate"].ToString();
                grdTable.Items[i].Cells[3].Text = Mdt.Rows[i]["registrant"].ToString();
                grdTable.Items[i].Cells[4].Text = Mdt.Rows[i]["requester"].ToString();
                grdTable.Items[i].Cells[5].Text = Mdt.Rows[i]["cusName"].ToString();
                grdTable.Items[i].Cells[6].Text = Mdt.Rows[i]["itemName"].ToString();
                grdTable.Items[i].Cells[7].Text = Mdt.Rows[i]["qty"].ToString();
                grdTable.Items[i].Cells[8].Text = Mdt.Rows[i]["deliveryDate"].ToString();
                grdTable.Items[i].Cells[9].Text = Mdt.Rows[i]["manufacturer"].ToString();
                grdTable.Items[i].Cells[10].Text = Mdt.Rows[i]["unitprice"].ToString();
                grdTable.Items[i].Cells[11].Text = Mdt.Rows[i]["progress"].ToString();
                grdTable.Items[i].Cells[12].Text = Mdt.Rows[i]["memo"].ToString();


                ((HiddenField)grdTable.Items[i].FindControl("hidden_idx")).Value = Mdt.Rows[i]["idx"].ToString();
                ((HiddenField)grdTable.Items[i].FindControl("hidden_idx_detail")).Value = Mdt.Rows[i]["detailIdx"].ToString();

                //tb = grdTable.Items[i].FindControl("txt_cusName") as TextBox;
                //tb.Text = Mdt.Rows[i]["cusName"].ToString();
                //tb.Attributes.Add("onchange", "change_cud('" + i + "')");

                //tb = grdTable.Items[i].FindControl("txt_itemName") as TextBox;
                //tb.Text = Mdt.Rows[i]["itemName"].ToString();
                //tb.Attributes.Add("onchange", "change_cud('" + i + "')");

                //tb = grdTable.Items[i].FindControl("txt_qty") as TextBox;
                //tb.Text = Mdt.Rows[i]["qty"].ToString();
                //tb.Attributes.Add("onchange", "change_cud('" + i + "')");

                //tb = grdTable.Items[i].FindControl("txt_deliveryDate") as TextBox;
                //tb.Text = Mdt.Rows[i]["deliveryDate"].ToString();
                //tb.Attributes.Add("onchange", "change_cud('" + i + "')");

                //tb = grdTable.Items[i].FindControl("txt_manufacturer") as TextBox;
                //tb.Text = Mdt.Rows[i]["manufacturer"].ToString();
                //tb.Attributes.Add("onchange", "change_cud('" + i + "')");

                //tb = grdTable.Items[i].FindControl("txt_unitprice") as TextBox;
                //tb.Text = Mdt.Rows[i]["unitprice"].ToString();
                //tb.Attributes.Add("onchange", "change_cud('" + i + "')");

                //tb = grdTable.Items[i].FindControl("txt_progress") as TextBox;
                //tb.Text = Mdt.Rows[i]["progress"].ToString();
                //tb.Attributes.Add("onchange", "change_cud('" + i + "')");

                //tb = grdTable.Items[i].FindControl("txt_memo") as TextBox;
                //tb.Text = Mdt.Rows[i]["memo"].ToString();


                /* DropDownList li = grdTable.Items[i].FindControl("cb_itemdiv") as DropDownList;
                 li.SelectedValue = dt.Rows[i]["itemdiv"].ToString();

                 string status = dt.Rows[i]["status"].ToString();

                 Button btn = grdTable.Items[i].FindControl("btn_cussch") as Button;

                 if(status == "1")//완료
                 {
                     btn.Text = "완료";
                     btn.BackColor = Color.Black;
                     btn.Attributes.Add("onclick", "copletePopUp();");
                 }
                 else //대기
                 {
                     btn.Text = "대기";
                     btn.BackColor = Color.Gray;
                     btn.Attributes.Add("onclick", "readyPopUp();");
                 }*/
            }
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search(true);
        }

        private void set_date()
        {

            tb_requestdate.Text = DateTime.Now.AddMonths(-3).ToString("yyyy-MM-01");
            tb_requestdate2.Text = DateTime.Now.ToString("yyyy-MM-dd");
        }



        //삭제
        protected void btn_del_Click(object sender, EventArgs e)
        {
            //DB연결
             if (km == null) km = new DB_mysql();

            //sql <= DB언어
            string sql = "";
            //결과개수 
            int result = 0;

            //List listIdx <= 체크박스 체크한 row(줄의) idx값을 저장하기 위한 list
            List<int> listIdx = new List<int>();

            // km.BeginTran();
            string idx = "";

            km.BeginTran();

            try
            {
                for (int i = 0; i < grdTable.Items.Count; i++)
                {
                    if (((CheckBox)grdTable.Items[i].FindControl("grd_checkBox")).Checked) // 그리드테이블1(체크박스)의.의. 
                    {
                        idx = ((HiddenField)grdTable.Items[i].FindControl("hidden_idx_detail")).Value;
                        //if (grdTable.Items[i].Cells[0].Text != "")
                        //{
                        sql += "DELETE FROM tb_purchase_status_detail WHERE idx =" + idx + ";";
                        ////}
                        //listIdx.Add(i);

                        //hidden_deleteIdxList.Value += "," + idx;
                    }
                
                }

                //아무것도 체크안됨
                if (sql == "")
                {
                    Response.Write("<script>alert('작업을 선택하여 주세요.');</script>");
                    return;
                }

                km.tran_ExSQL_Ret(sql);
                //이후에는~ 대충 저장한다는 뜻

                string checkSQl = "SELECT a.idx FROM tb_purchase_status a " +
                                  $"LEFT OUTER JOIN tb_purchase_status_detail b ON a.idx = b.statusIdx " +
                                  $"WHERE b.idx is null " +
                                  $"GROUP BY a.idx; ";

                DataTable dt = km.tran_GetDTa(checkSQl);

                sql = "";

                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sql += $"DELETE FROM tb_purchase_status WHERE idx = {dt.Rows[i][0].ToString()};";
                    }
                }

                if (sql != "")
                {
                    km.tran_ExSQL_Ret(sql);
                }

                km.Commit();
                Response.Write("<script>alert('삭제되었습니다.');</script>");
                Search(true);
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                  Response.Write("<script>alert('삭제실패.');</script>");
                return;
            }
        }

        

        //수정
        protected void btn_check_Click(object sender, EventArgs e)
        {
            
            if (km == null) km = new DB_mysql();

            string sql = "";
            int result = 0;

            km.BeginTran();

            try
            {
                for (int i = 0; i < grdTable.Items.Count; i++)
                {
                    string cud = ((HiddenField)grdTable.Items[i].FindControl("hdn_cud")).Value;

                    if (cud == "u") //update
                    {
                        sql += "CALL SP_purchase_status_Update(" +
                        $"'{((HiddenField)grdTable.Items[i].FindControl("hidden_idx")).Value}'," +
                        $"'{((TextBox)grdTable.Items[i].FindControl("txt_cusName")).Text}');";

                        sql += "CALL SP_purchase_status_detail_Update(" +
                        $"'{((HiddenField)grdTable.Items[i].FindControl("hidden_idx_detail")).Value}'," +
                        $"'{((TextBox)grdTable.Items[i].FindControl("txt_itemName")).Text}'," +
                        $"'{((TextBox)grdTable.Items[i].FindControl("txt_qty")).Text}'," +
                        $"'{((TextBox)grdTable.Items[i].FindControl("txt_deliveryDate")).Text}'," +
                        $"'{((TextBox)grdTable.Items[i].FindControl("txt_manufacturer")).Text}'," +
                        $"'{((TextBox)grdTable.Items[i].FindControl("txt_unitprice")).Text}'," +
                        $"'{((TextBox)grdTable.Items[i].FindControl("txt_progress")).Text}'," +
                        $"'{((TextBox)grdTable.Items[i].FindControl("txt_memo")).Text}');";
                    }

                }

               /* if(hidden_deleteIdxList.Value !="")
                {
                    string idxList = hidden_deleteIdxList.Value.Substring(1);
                    //idxList = 1,3,5,6

                    sql += $"DELETE FROM tb_purchase_status WHERE idx IN ({idxList}); ";
                    sql += $"DELETE FROM tb_purchase_status_detail WHERE statusIdx IN ({idxList});";
                }

                if (sql != "")
                {
                    km.tran_ExSQL_Ret(sql);

                    km.Commit();

                    Response.Write("<script>alert('수정되었습니다.');</script>");
                    Search(true);
                }
                else
                {
                    km.Commit();
                }*/
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Response.Write("<script>alert('수정 실패');</script>");
            }

        }
    }
}



