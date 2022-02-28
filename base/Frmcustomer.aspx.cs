using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MysqlLib;
using MySql.Data.MySqlClient;
using PublicLibsManagement;
using System.Drawing;


namespace iljin
{
    public partial class Frmcustomer : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                km.GetCbDT(ConstClass.CUSTOMER_TYPE_CODE,cb_cusType,"전체");

                cb_cusDiv.Items.Add(new ListItem("전체", ""));
                cb_cusDiv.Items.Add(new ListItem("관리대상", "1"));
                cb_cusDiv.Items.Add(new ListItem("주거래처", "2"));
                cb_cusDiv.SelectedIndex = 0;

                search();
            }
        }

        private void search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { txt_cusName, cb_cusType, txt_manager, cb_cusDiv };

            DataTable dt = PROCEDURE.SELECT("SP_customer_GetBySearch", objs, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            for(int i = 0; i < grdTable.Items.Count; i++)
            {
                grdTable.Items[i].Cells[0].Text = (i + 1).ToString();

                for(int j = 1; j < grdTable.Columns.Count - 1; j++)
                {
                    if (dt.Rows[i][j - 1].ToString() != "") grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                }

                ((Button)grdTable.Items[i].FindControl("grd_btn_update")).Attributes.Add("onclick", $"sub_disp('{dt.Rows[i][0].ToString()}'); return false;");
            }
        } 

        protected void btn_seacrh_Click(object sender, EventArgs e)
        {
            search();
        }
    }
}