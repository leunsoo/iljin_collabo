using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;
using PublicLibsManagement;

namespace iljin
{
    public partial class Frmunitprice : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                this.Form.DefaultButton = btn_sch.UniqueID;
                km.GetCbDT(ConstClass.ITEM_DIV1_CODE, cb_itemdiv1, "전체");
                km.GetCbDT(cb_itemdiv1.SelectedValue, cb_itemdiv2, "전체");
                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { tb_itemName, cb_itemdiv1, cb_itemdiv2, tb_thickness, tb_width1, tb_width2, tb_length1, tb_length2 };

            DataTable dt = PROCEDURE.SELECT("SP_unitprice_GetBySearch", objs, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;

            for (int i = 0; i < rowCount; i++)
            {
                grdTable.Items[i].Cells[0].Text = (rowCount - i).ToString();

                for (int j = 1; j < colCount - 1; j++)
                {
                    if (dt.Rows[i][j - 1].ToString() != "") grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                }

                ((Button)grdTable.Items[i].FindControl("grd_btn_regist")).Attributes.Add("onclick", $"sub_disp('{dt.Rows[i][0].ToString()}','0'); return false;");
                ((Button)grdTable.Items[i].FindControl("grd_btn_updateList")).Attributes.Add("onclick", $"sub_disp('{dt.Rows[i][0].ToString()}','1'); return false;");
            }
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            Search();
        }

        protected void cb_itemdiv1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();
            km.GetCbDT(cb_itemdiv1.SelectedValue, cb_itemdiv2, "전체");
        }
    }
}