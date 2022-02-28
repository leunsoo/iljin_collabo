using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;
using MysqlLib;
using System.Data;

namespace iljin
{
    public partial class Frmforeigner : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] obj = { tb_name };
            DataTable mdt = PROCEDURE.SELECT("SP_foreigner_GetBySearch", obj, km);

            grdTable.DataSource = mdt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;

            for(int i = 0; i < rowCount; i++)
            {
                grdTable.Items[i].Cells[0].Text = (i + 1).ToString();

                for (int j = 1; j < colCount - 3; j++)
                {
                    if (mdt.Rows[i][j].ToString() != "") grdTable.Items[i].Cells[j].Text = mdt.Rows[i][j].ToString();
                }

                ((Button)grdTable.Items[i].FindControl("grd_btn_bankCopy")).Attributes.Add("onclick", $"imagePop('{ ConstClass.FOREIGNER_FILE_PATH + mdt.Rows[i]["filePath_bank"].ToString()}'); return false;");
                ((Button)grdTable.Items[i].FindControl("grd_btn_idCard")).Attributes.Add("onclick", $"imagePop('{ ConstClass.FOREIGNER_FILE_PATH + mdt.Rows[i]["filePath_IDCard"].ToString()}'); return false;");
                ((Button)grdTable.Items[i].FindControl("grd_btn_update")).Attributes.Add("onclick", $"sub_disp('{mdt.Rows[i][0].ToString()}'); return false;");
            }
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }
    }
}