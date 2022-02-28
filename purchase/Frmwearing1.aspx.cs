using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Forms;
using System.Data;
using MysqlLib;
using MySql.Data.MySqlClient;
using PublicLibsManagement;
using BasicManagement;
using System.Drawing;


namespace iljin
{
    public partial class FrmUserList : System.Web.UI.Page
    {

        DataTable Mdt = new DataTable();
        string idd = "";
        DB_mysql km = new DB_mysql();

        protected void Page_Load(object sender, EventArgs e)
        {
            btn_userregister.Attributes["onclick"] = "{sub_disp('');return false;}";



        }

        private void search()
        {

        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            search();
        }

        protected void btn_ck_Click(object sender, EventArgs e)
        {
            search();
        }

       
    }
}
