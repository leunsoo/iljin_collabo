using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MysqlLib;
using PublicLibsManagement;
using les;

namespace iljin
{
    public partial class Frmstock : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                km.GetCbDT(ConstClass.ITEM_DIV1_CODE, cb_divCode1, "전체");
                km.GetCbDT(cb_divCode1.SelectedValue, cb_divCode2, "전체");
                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            string nowDate = DateTime.Now.ToString("yyyy-MM-dd");

            object[] objs = { txt_itemname, cb_divCode1,cb_divCode2,txt_thickness,txt_width1,txt_width2,txt_memo,nowDate};

            DataTable dt = PROCEDURE.SELECT("SP_inventory_GetBySearch",objs, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;

            for(int i = 0; i < rowCount; i++)
            {
                grdTable.Items[i].Cells[0].Text = dt.Rows[i][0].ToString();
                grdTable.Items[i].Cells[1].Text = (rowCount - i).ToString();
                grdTable.Items[i].Cells[2].Text = dt.Rows[i][1].ToString();
               grdTable.Items[i].Cells[3].Text = dt.Rows[i][2].ToString();
               grdTable.Items[i].Cells[4].Text = dt.Rows[i][3].ToString();

                grdTable.Items[i].Cells[5].Text = dt.Rows[i][4].ToString()// == "" ? "0" : dt.Rows[i][4].ToString();
               // grdTable.Items[i].Cells[6].Text = dt.Rows[i][5].ToString() == "" ? "0" : dt.Rows[i][5].ToString();

              //  grdTable.Items[i].Cells[7].Text = dt.Rows[i][6].ToString();

                ((Button)grdTable.Items[i].FindControl("grd_btn_inout")).Attributes.Add("onclick", $"inout('{dt.Rows[i][0].ToString()}','{dt.Rows[i][2].ToString()}'); return false;");
            }
        }

        protected void btn_serch_Click(object sender, EventArgs e)
        {
            Search();
        }

        protected void cb_divCode1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();
            km.GetCbDT(cb_divCode1.SelectedValue, cb_divCode2, "전체");
        }
    }
}