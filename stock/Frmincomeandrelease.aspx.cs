using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PublicLibsManagement;
using les;
using MysqlLib;

namespace iljin
{
    public partial class Frmincomeandrelease : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if(km == null) km = new DB_mysql();

                les_Tool.Set_TextBoxes_Period_MM_01_To_Now(tb_releasedate, tb_releasedate2);

                Search(0);
            }
        }

        private void Search(int state = -1)
        {
            if (km == null) km = new DB_mysql();
            DataTable dt = new DataTable();

            DateTime dateT;

            if(!DateTime.TryParse(tb_releasedate.Text,out dateT) || !DateTime.TryParse(tb_releasedate2.Text, out dateT))
            {
                Response.Write("<script>alert('정확한 날짜를 입력해 주십시오.');</script>");
            }

            string date = dateT.AddDays(1).ToString("yyyy-MM-dd");

            if (state == -1)
            {
                object[] objs = { tb_releasedate,date,tb_itemname,tb_customer };

                dt = PROCEDURE.SELECT("SP_warehousing_GetBySearch", objs,km);
            }
            else
            {
                dt = PROCEDURE.SELECT("SP_warehousing_GetByState", state.ToString(), km);
            }

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable, dt, 1);

            /*
            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rCount = grdTable.Items.Count;
            int cCount = grdTable.Columns.Count;
            string mergeValue = "";
            int rowSpan = 1;

            for (int i = 0; i < rCount; i++)
                {
                    mergeValue = dt.Rows[i]["orderCode"].ToString();
                    grdTable.Items[i].Cells[0].Text = (i+1).ToString();

                    if (i < rCount - 1 && mergeValue == dt.Rows[i + 1]["orderCode"].ToString())
                    {
                        rowSpan++;

                        for (int j = 1; j < 4; j++)
                        {
                            grdTable.Items[i - rowSpan + 2].Cells[j].RowSpan = rowSpan;
                            grdTable.Items[i - rowSpan + 2].Cells[j].Text = dt.Rows[i][j -1].ToString();

                            grdTable.Items[i + 1].Cells[j].Visible = false;
                        }
                    }
                    else
                    {
                        for (int j = 1; j <4; j++)
                        {
                             grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                        }

                        rowSpan = 1;
                    }

                    for (int j = 4; j < cCount; j++)
                    {
                        grdTable.Items[i].Cells[j].Text = dt.Rows[i][j-1].ToString();
                    }

                    if (i == rCount - 1)
                    {
                        for (int j = 1; j < 4; j++)
                        {
                            if (grdTable.Items[i].Cells[j].Visible && j != 0)
                            {
                                grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                            }
                        }
                    }
                }*/
        }

        protected void rb_release_CheckedChanged(object sender, EventArgs e)
        {
            Search(0);
        }

        protected void rb_income_CheckedChanged(object sender, EventArgs e)
        {
            Search(1);
        }

        protected void rb_all_CheckedChanged(object sender, EventArgs e)
        {
            Search(2);
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            Search();

            rb_release.Checked = true;
            rb_income.Checked = false;
            rb_all.Checked = false;
        }
    }
}