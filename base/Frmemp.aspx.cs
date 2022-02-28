using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MysqlLib;
using PublicLibsManagement;
using System.Drawing;

namespace iljin
{
    public partial class Frmemp : Page
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                km.GetCbDT(ConstClass.EMP_DEPARTMENT_CODE, cb_belong,"전체");

                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { tb_empname, tb_empid, cb_belong };

            DataTable dt = PROCEDURE.SELECT("SP_emp_GetBySearch", objs, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;

            for(int i = 0; i < rowCount; i++)
            {
                grdTable.Items[i].Cells[0].Text = (i+1).ToString();

                for(int j = 1; j < colCount - 1; j++)
                {
                    if(dt.Rows[i][j].ToString() != "") grdTable.Items[i].Cells[j].Text = dt.Rows[i][j].ToString();
                }

                ((Button)grdTable.Items[i].FindControl("grd_btn_update")).Attributes.Add("onclick", $"sub_disp('{dt.Rows[i][0].ToString()}'); return false;");
            }
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }
    }
}
