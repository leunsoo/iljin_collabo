using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;
using PublicLibsManagement;

namespace iljin.popUp
{
    public partial class popcontaineritem : ApplicationRoot
    {
        private DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            string idx = Request.Params.Get("idx");

            object[] objs = { idx };

            DataTable dt = PROCEDURE.SELECT("SP_container_item_temp_GetByContainer", objs, km);

            grdTable1.DataSource = dt;
            grdTable1.DataBind();

            int rowCount = grdTable1.Items.Count;
            int colCount = grdTable1.Columns.Count;
            TextBox tb;

            for (int i = 0; i < rowCount; i++)
            {
                for (int j = 0; j < colCount; j++)
                {
                    if (dt.Rows[i][j].ToString() != "") grdTable1.Items[i].Cells[j].Text = dt.Rows[i][j].ToString();
                }
            }
        }
    }
}