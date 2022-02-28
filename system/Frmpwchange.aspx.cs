using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MysqlLib;
using PublicLibsManagement;
using System.Text.RegularExpressions;

namespace iljin.system
{
    public partial class Frmpwchange : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();
                hdn_userCode.Value = Session["userCode"].ToString();
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            try
            {
                string sql = $"SELECT * FROM tb_emp WHERE userCode = '{hdn_userCode.Value}' AND password = PASSWORD('{txt_currentpw.Text}');";

                if (km.GetDTa(sql).Rows.Count < 1)
                {
                    Response.Write("<script> alert('현재 비밀번호가 일치하지 않습니다.');</script>");
                    return;
                }

                Regex rxPassword = new Regex(@"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

                if (!rxPassword.IsMatch(txt_changepw.Text))
                {
                    Response.Write("<script> alert('비밀번호는 하나 이상의 문자와 숫자를 포함해야 합니다.'); </script>");
                    return;
                }

                if (km == null) km = new DB_mysql();

                sql = $"UPDATE tb_emp SET password = PASSWORD('{txt_changepw.Text}') WHERE userCode= '{hdn_userCode.Value}';";

                km.GetDTa(sql);

                Response.Write("<script> alert('비밀번호가 변경되었습니다.'); </script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script> alert('비밀번호 변경에 실패하셨습니다.'); </script>");
            }
        }
    }
}