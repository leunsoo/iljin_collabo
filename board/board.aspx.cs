using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using MysqlLib;
using System.Data;

namespace iljin
{
    public partial class board : ApplicationRoot
    {
        DB_mysql km = new DB_mysql();
        private void search()
        {
            string tit = Str_ser.Text;
             km.dbOpen();
            string strSQL = String.Format("exec USP_board_S '{0}'", tit);
            DataTable dt = new DataTable();
            dt = km.GetDTa(strSQL);
            grid_code.DataSource = dt;
            grid_code.DataBind();
             int rCnt = dt.Rows.Count;


            for (int i = 0; i < rCnt; i++)
            {
                for (int k = 0; k < dt.Columns.Count; k++)
                {
                    if (dt.Rows[i][k] != "") grid_code.Items[i].Cells[k].Text = dt.Rows[i][k].ToString();
                    grid_code.Items[i].Attributes.Add("style", "cursor:pointer");
                    grid_code.Items[i].Attributes.Add("onclick", "sub_disp('" + dt.Rows[i][0].ToString() + "')");
                }
            }
            km.dbClose();
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            search();
        }

        void Page_Load(object sender, EventArgs e)
        {
            Str_ser.Attributes["onkeypress"] = " if (event.keyCode==13) {" + Page.ClientScript.GetPostBackEventReference(ck_fol, "") + ";return false;}";
            if (!IsPostBack)
            {
                search();
            }
        }

        protected void ck_fol_Click(object sender, EventArgs e)
        {
            search();
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            Str_ser.Text = "";
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            Response.Redirect("board_write.aspx");
        }
    }
}