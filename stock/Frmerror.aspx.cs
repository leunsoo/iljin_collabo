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
    public partial class Frmerror : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                SetBasic();
                Search();
            }
        }

        private void SetBasic()
        {
            string date1 = DateTime.Now.AddYears(-1).ToString("yyyy-01-01");
            string date2 = DateTime.Now.ToString("yyyy-MM-dd");

            tb_registrationdate.Text = date1;
            tb_registrationdate2.Text = date2;

            km.GetCbDT(ConstClass.ITEM_DIV1_CODE, cb_itemdiv, "전체");
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { tb_registrationdate,tb_registrationdate2,cb_itemdiv,tb_itemname,tb_customerName };

            DataTable dt = PROCEDURE.SELECT("SP_error_GetBySearch", objs, km);

            les_DataGridSystem.Set_CheckBox_DataGrid_From_Dt(grdTable,dt,2);
        }

        protected void btn_del_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            int rowCount = grdTable.Items.Count;
            string idx = "";

            try
            {
                for (int i = 0; i < rowCount; i++)
                {
                    if (((CheckBox)grdTable.Items[i].FindControl("grd_checkBox")).Checked)
                    {
                        idx += "," + ((HiddenField)grdTable.Items[i].FindControl("hdn_code")).Value;
                    }
                }

                km.ExSQL_Ret($"DELETE FROM tb_error WHERE idx IN ({idx.Substring(1)})");

                Response.Write("<script>alert('삭제되었습니다.');</script>");
                Search();
            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('삭제 실패.');</script>");
            }
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            Search();
        }
    }
}