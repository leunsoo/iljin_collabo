using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using PublicLibsManagement;
using les;
using System.Data;

namespace iljin
{
    public partial class Frmorders : ApplicationRoot
    {
        DB_mysql km = new DB_mysql();

        protected void Page_Load(object sender, EventArgs e)
        {
            DB_mysql km = new DB_mysql();

            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                tb_orderdate.Text = DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd");
                tb_orderdate2.Text = DateTime.Now.ToString("yyyy-MM-dd");


                tb_deliverydate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                tb_deliverydate2.Text = DateTime.Now.AddDays(3).ToString("yyyy-MM-dd");

                Search(0);
                hidden_currentSearchState.Value = "0";
            }
        }

        private void Search(int checkState = -1)
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = new DataTable();

            if (checkState == -1) //조회버튼 검색
            {
                object[] objs = { tb_orderdate, tb_orderdate2, tb_deliverydate, tb_deliverydate2, tb_customer };
                dt = PROCEDURE.SELECT("SP_order_GetBySearch", objs, km);
            }
            else //체크박스 검색
            {
                dt = PROCEDURE.SELECT("SP_order_GetByStatus", checkState.ToString(), km);
            }

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;
            string orderCode = "";
            int rowSpan = 1;

            for (int i = 0; i < rowCount; i++)
            {
                orderCode = dt.Rows[i]["orderCode"].ToString();

                //0~5까지 merge
                if (i < rowCount - 1 && orderCode == dt.Rows[i + 1]["orderCode"].ToString())
                {
                    rowSpan++;

                    grdTable.Items[i - rowSpan + 2].Cells[0].RowSpan = rowSpan;
                    grdTable.Items[i + 1].Cells[0].Visible = false;
                    ((CheckBox)grdTable.Items[i + 1].FindControl("grd_checkBox")).Visible = false;
                    //grdTable.Items[i + 1].Cells[1].Visible = false;

                    for (int j = 1; j < 6; j++)
                    {

                        grdTable.Items[i - rowSpan + 2].Cells[j].RowSpan = rowSpan;
                        grdTable.Items[i - rowSpan + 2].Cells[j].Text = dt.Rows[i][j - 1].ToString();

                        grdTable.Items[i + 1].Cells[j].Visible = false;

                    }

                    for (int j = 8; j < colCount; j++)
                    {

                        grdTable.Items[i - rowSpan + 2].Cells[j].RowSpan = rowSpan;
                        grdTable.Items[i - rowSpan + 2].Cells[j].Text = dt.Rows[i][j - 1].ToString();

                        grdTable.Items[i + 1].Cells[j].Visible = false;

                    }
                }
                else
                {
                    for (int j = 1; j < 6; j++)
                    {
                        grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                    }
                    for (int j = 8; j < colCount; j++)
                    {
                        grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                    }
                    rowSpan = 1;
                }

                if (i == rowCount - 1)
                {
                    for (int j = 1; j < 6; j++)
                    {
                        if (grdTable.Items[i].Cells[j].Visible)
                        {
                            grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                        }
                    }
                    for (int j = 8; j < colCount; j++)
                    {
                        if (grdTable.Items[i].Cells[j].Visible)
                        {
                            grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                        }
                    }
                }

                for (int j = 6; j < 8; j++)
                {
                    if (dt.Rows[i][j - 1].ToString() != "") grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                }
            }
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            Search(-1);
            hidden_currentSearchState.Value = "-1";

            rb_incomplete.Checked = true;
            rb_complete.Checked = false;
            rb_all.Checked = false;
        }

        protected void rb_all_CheckedChanged(object sender, EventArgs e)
        {
            Search(2);
            hidden_currentSearchState.Value = "2";
        }

        protected void rb_complete_CheckedChanged(object sender, EventArgs e)
        {
            Search(1);
            hidden_currentSearchState.Value = "1";
        }

        protected void rb_incomplete_CheckedChanged(object sender, EventArgs e)
        {
            Search(0);
            hidden_currentSearchState.Value = "0";
        }

        protected void btn_reset_Click(object sender, EventArgs e)
        {
            Search(0);

            rb_complete.Checked = false;
            rb_incomplete.Checked = true;
            rb_all.Checked = false;
            checkbox.Checked = false;
        }

        //출고된 건에 대하여 예외처리 해주어야함
        protected void btn_del_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();


            string deleteIdx = "";

            for (int i = 0; i < grdTable.Items.Count; i++)
            {
                if (((CheckBox)grdTable.Items[i].FindControl("grd_checkBox")).Checked)
                {
                    deleteIdx += ",'" + grdTable.Items[i].Cells[1].Text + "'";
                }
            }

            try
            {
                string sql = $"DELETE FROM tb_order_master WHERE orderCode IN ({deleteIdx.Substring(1)});" +
                             $"DELETE FROM tb_order_detail WHERE orderCode IN ({deleteIdx.Substring(1)});" +
                             $"DELETE FROM tb_warehousing WHERE orderCode IN ({deleteIdx.Substring(1)});";

                km.ExSQL_Ret(sql);
                Response.Write("<script>alert('삭제되었습니다.');</script>");

                int no = int.Parse(hidden_currentSearchState.Value);

                Search(no);
            }
            catch(Exception ex)
            {
                PROCEDURE.ERROR(ex.Message, km);
                Response.Write("<script>alert('삭제 실패.');</script>");
            }

        }
    }
}