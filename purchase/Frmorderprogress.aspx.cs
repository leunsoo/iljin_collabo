using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;
using PublicLibsManagement;
using les;

namespace iljin
{
    public partial class Frmorderprogress : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (km == null) km = new DB_mysql();
                //set_date();
                //les_Tool.Set_TextBoxes_Period_MM_01_To_Now(tb_registrationdate, tb_registrationdate2);
                les_Tool.Set_TextBox_Period_AddMonth_MM_01_To_Now(tb_registrationdate, tb_registrationdate2);
                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { tb_registrationdate, tb_registrationdate2, txt_cusName };

            DataTable dt = PROCEDURE.SELECT("SP_container_info_GetProgressStatus",objs, km);

            les_DataGridSystem.Set_Merge_DataGrid_From_Dt(grdTable, dt, 2, 0, 3, 1);
        }

       /* private void set_date()
        {
           
            DateTime schDate1 = DateTime.Now.AddMonths(-3);
            DateTime schDate2 = DateTime.Now;

           tb_registrationdate.Text = schDate1.ToString("yyyy-MM-dd");
            tb_registrationdate2.Text = schDate2.ToString("yyyy-MM-dd");
        }*/

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }
    }
}