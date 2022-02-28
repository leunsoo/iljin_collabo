using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;
using PublicLibsManagement;
using System.Drawing;
using les;

namespace iljin.Menu.purchase
{
    public partial class Frmwearing : ApplicationRoot
    {
        DB_mysql km = new DB_mysql();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();
                les_Tool.Set_TextBoxes_Period_MM_01_To_Now(tb_incomedate, tb_incomedate2);
                Search(0);
            }
        }

        private void Search(int checkState = -1)
        {
            if (km == null) km = new DB_mysql();
            
            DataTable dt = new DataTable();

            if(checkState == -1) //조회버튼 검색
            {
                object[] objs = { tb_incomedate, tb_incomedate2, tb_contractNo, tb_purchasername };
                dt = PROCEDURE.SELECT("SP_purchase_contract_IncomeInfo_GetBySearch", objs, km);
            }
            else //체크박스 검색
            {
                dt = PROCEDURE.SELECT("SP_purchase_contract_IncomeInfo_GetByState", checkState.ToString(), km);
            }

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;
            string contractNo = "";
            string blNo = "";
            int rowSpan = 1;
            int blNoRowSpan = 1;

            for (int i = 0; i < rowCount; i++)
            {
                contractNo = dt.Rows[i]["contractNo"].ToString();
                blNo = dt.Rows[i]["blNo"].ToString();

                grdTable.Items[i].Cells[0].Text = dt.Rows[i][0].ToString();
                grdTable.Items[i].Cells[1].Text = (i+1).ToString();

                //2~4까지 계약정보 merge
                if (i < rowCount - 1 && contractNo == dt.Rows[i + 1]["contractNo"].ToString() && contractNo != "")
                {
                    rowSpan++;

                    //grdTable.Items[i].Cells[1].RowSpan = rowSpan;
                    //grdTable.Items[i + 1].Cells[1].Visible = false;

                    for (int j = 2; j < 5; j++)
                    {
                        grdTable.Items[i - rowSpan + 2].Cells[j].RowSpan = rowSpan;
                        grdTable.Items[i - rowSpan + 2].Cells[j].Text = dt.Rows[i][j - 1].ToString();

                        grdTable.Items[i + 1].Cells[j].Visible = false;
                    }
                }
                else
                {
                    for (int j = 2; j < 5; j++)
                    {
                        grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                    }
                    rowSpan = 1;
                }

                //5 BL번호 merge
                if (i < rowCount - 1 && blNo == dt.Rows[i + 1]["blNo"].ToString()  && contractNo != "")
                {
                    blNoRowSpan++;

                    grdTable.Items[i - blNoRowSpan + 2].Cells[5].RowSpan = blNoRowSpan;
                    grdTable.Items[i - blNoRowSpan + 2].Cells[5].Text = dt.Rows[i]["blNo"].ToString();

                    grdTable.Items[i + 1].Cells[5].Visible = false;
                }
                else
                {
                    grdTable.Items[i].Cells[5].Text = dt.Rows[i]["blNo"].ToString();
                    blNoRowSpan = 1;
                }

                if(i == rowCount - 1)
                {
                    for (int j = 2; j < 6; j++)
                    {
                        if (grdTable.Items[i].Cells[j].Visible)
                        {
                            grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                        }
                    }
                }


                for (int j = 6; j < colCount - 1; j++)
                {
                    if (dt.Rows[i][j - 1].ToString() != "") grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                }

                if(dt.Rows[i]["warehousingDate"].ToString() != "")//입고완료상태
                {
                    Button btn = ((Button)grdTable.Items[i].FindControl("btn_income"));

                    if(contractNo == "") // 계약하지 않는 입고
                    {
                        btn.Attributes.Add("onclick", $"finish('{dt.Rows[i][0].ToString()}','0'); return false;");
                    }
                    else // 계약 입고
                    {
                        btn.Attributes.Add("onclick", $"finish('{dt.Rows[i][0].ToString()}','1'); return false;");
                    }
                    btn.Text = "입고완료";
                    btn.BackColor = Color.Red;
                }
                else //입고처리상태
                {
                    ((Button)grdTable.Items[i].FindControl("btn_income")).Attributes.Add("onclick", $"warehouse('{dt.Rows[i][0].ToString()}'); return false;");
                }
            }
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();

            rb_complete.Checked = false;
            rb_incomplete.Checked = false;
            rb_all.Checked = true;
        }

        protected void rb_all_CheckedChanged(object sender, EventArgs e)
        {
            Search(0);
        }

        protected void rb_complete_CheckedChanged(object sender, EventArgs e)
        {
            Search(1);
        }

        protected void rb_incomplete_CheckedChanged(object sender, EventArgs e)
        {
            Search(2);
        }

        protected void btn_reset_Click(object sender, EventArgs e)
        {
            Search(0);

            rb_complete.Checked = false;
            rb_incomplete.Checked = false;
            rb_all.Checked = true;
        }
    }
}