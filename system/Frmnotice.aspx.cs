using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MysqlLib;
using PublicLibsManagement;

namespace iljin.system
{
    public partial class Frmnotice : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            string notice = km.GetDTa("SELECT notice FROM tb_company;").Rows[0][0].ToString();

            txt_notice.Text = notice;
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            try
            {
                km.ExSQL_Ret($"UPDATE tb_company SET notice = '{txt_notice.Text}'; ");

                Response.Write("<script>alert('저장되었습니다');</script>");

                Search();
            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('저장실패');</script>");

                PROCEDURE.ERROR(ex.Message, km);
            }
        }
    }
}