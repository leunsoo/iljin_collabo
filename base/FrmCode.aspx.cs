using MysqlLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;

namespace iljin
{
    public partial class FrmCode : ApplicationRoot
    {
        DB_mysql km;
        private void search()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_code_GetBySearch",km);

            grdTable1.DataSource = dt;
            grdTable1.DataBind();
            int rCnt = grdTable1.Items.Count;
            int cCnt = grdTable1.Columns.Count;
            
            for (int i = 0; i < rCnt; i++)
            {
                for (int k = 0; k < cCnt; k++)
                {
                    if (dt.Rows[i][k].ToString() != "") grdTable1.Items[i].Cells[k].Text = dt.Rows[i][k].ToString();
                    this.grdTable1.Items[i].Attributes.Add("style", "cursor:pointer");
                    this.grdTable1.Items[i].Attributes.Add("onclick", "sub_disp('" + dt.Rows[i][0].ToString() + "','" + i.ToString() + "');");
                }
            }
            for (int i = 0; i < rCnt; i++)
            {
                this.grdTable1.Items[i].BackColor = Color.White;
            }
        }

        private void search_sub()
        {
            if (km == null) km = new DB_mysql();

            string upper_id = hidden_code.Value;

            object[] objs = { hidden_code };

            DataTable dt = PROCEDURE.SELECT("SP_code_GetByParent", objs, km);

            grdTable2.DataSource = dt;
            grdTable2.DataBind();
            int rCnt = grdTable2.Items.Count;
            int cCnt = grdTable2.Columns.Count;
            for (int i = 0; i < rCnt; i++)
            {
                for (int k = 0; k < cCnt - 1; k++)
                {
                    if (dt.Rows[i][k].ToString() != "") grdTable2.Items[i].Cells[k].Text = dt.Rows[i][k].ToString();
                }

                ((Button)grdTable2.Items[i].FindControl("btn_update")).Attributes.Add("onclick", $"code_reg('{upper_id}_{dt.Rows[i][0]}'); return false;");
            }
            rCnt = grdTable1.Items.Count;
            for (int i = 0; i < rCnt; i++)
            {
                this.grdTable1.Items[i].BackColor = Color.White;
            }

            if (hidden_row_idx.Value != "")
            {
                int row_idx = Convert.ToInt16(hidden_row_idx.Value);
                grdTable1.Items[row_idx].BackColor = Color.Cornsilk;
            }

        }

        //-----------------------------이벤트핸들러------------------------------------------------------------
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (km == null) km = new DB_mysql();
                search();
            }
        }

        protected void btn_sub_disp_Click(object sender, EventArgs e)// 2차 코드 검색
        {
            search_sub();
        }
    }
}