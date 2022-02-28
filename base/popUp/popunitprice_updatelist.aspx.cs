using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using PublicLibsManagement;
using System.Data;

namespace iljin.popUp
{
    public partial class popunitprice_updatelist : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_itemCode.Value = Request.Params.Get("code");

                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { hdn_itemCode };

            DataTable dt = PROCEDURE.SELECT("SP_unitprice_GetByItemCode",objs,km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;

            for(int i = 0; i < rowCount; i ++)
            {
                grdTable.Items[i].Cells[0].Text = (rowCount - i).ToString();

                for(int j = 1; j < colCount; j++)
                {
                    if(dt.Rows[i][j-1].ToString() != "") grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                }
            }
        }
    }
}