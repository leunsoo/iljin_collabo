using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using les;
using PublicLibsManagement;
using MysqlLib;
using System.Drawing;

namespace iljin
{
    public partial class Frmtaxbill : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                les_Tool.Set_TextBoxes_Period_MM_01_To_Now(tb_registrationdate, tb_registrationdate2);
                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { tb_registrationdate, tb_registrationdate2, txt_customer };
            DataTable dt = PROCEDURE.SELECT("SP_taxbill_GetBySearch", objs, km);

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable, dt, 0, grdTable.Columns.Count - 1, 1);

            Button btn;

            for (int i = 0; i < grdTable.Items.Count; i++)
            {
                btn = grdTable.Items[i].FindControl("btn_send") as Button;

                if (dt.Rows[i]["sendDate"].ToString() != "")
                {
                    btn.Text = "발행완료";
                    btn.BackColor = Color.Green;
                }
                else
                {
                }

                if (dt.Rows[i]["taxDiv"].ToString() == "0")
                {
                    btn.Attributes.Add("onclick", $"notsent('{dt.Rows[i]["serialNo"].ToString()}'); return false;");
                }
                else
                {
                    btn.Attributes.Add("onclick", $"notsent_separate('{dt.Rows[i]["serialNo"].ToString()}'); return false;");
                }
            }
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            Search();
        }
    }
}