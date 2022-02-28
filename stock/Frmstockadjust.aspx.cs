using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using PublicLibsManagement;
using les;
using System.Data;

namespace iljin
{
    public partial class Frmstockadjust : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                // les_Tool.Set_TextBoxes_Period_MM_01_To_Now(txt_registrationdate1, txt_registrationdate2);

                SetBasic();
                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { txt_registrationdate1,txt_registrationdate2,txt_itemname };

            DataTable dt = PROCEDURE.SELECT("SP_inventory_adjust_GetBySearch", objs, km);

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable, dt, 1);
        }

        private void SetBasic()
        {
            string date1 = DateTime.Now.AddMonths(-1).ToString("yyyy-MM-01");
            string date2 = DateTime.Now.ToString("yyyy-MM-dd");

            txt_registrationdate1.Text = date1;
            txt_registrationdate2.Text = date2;

        }

        protected void btn_serch_Click(object sender, EventArgs e)
        {
            Search();
        }
    }
}