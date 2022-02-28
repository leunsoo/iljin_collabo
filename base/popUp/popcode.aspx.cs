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
    public partial class popcode : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_code.Value = Request.Params.Get("code");
                hdn_rowIdx.Value = Request.Params.Get("rowIdx");
                Search();
            }
        }

        private void Search()
        {
            object[] objs = { hdn_code.Value.Substring(0,5) };

            tb_upperCode.Text = PROCEDURE.SELECT("SP_code_SearchUpperName", objs, km).Rows[0][0].ToString();
            
            if (hdn_code.Value.Length > 6) // 수정
            {
                objs = new object[] { hdn_code };

                DataTable dt = PROCEDURE.SELECT("SP_code_GetByCode", objs, km);

                tb_code_name.Text = dt.Rows[0]["code_name"].ToString();
                tb_orderIdx.Text = dt.Rows[0]["order_idx"].ToString();
                chk_use.Checked = dt.Rows[0]["Isuse"].ToString() == "1" ? true : chk_non_use.Checked = true; 
            }
            else
            {
                chk_use.Checked = true;
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            try
            {
                if (hdn_code.Value.Length > 6) // 수정
                {
                    string chkValue = chk_use.Checked ? "1" : "0";

                    object[] objs = { tb_code_name, tb_orderIdx, chkValue, "", hdn_code };

                    DataTable dt = PROCEDURE.SELECT("SP_code_Update", objs, km);
                }
                else //추가
                {
                    string chkValue = chk_use.Checked ? "1" : "0";

                    object[] objs = { tb_code_name, tb_orderIdx, chkValue, "", hdn_code };

                    DataTable dt = PROCEDURE.SELECT("SP_code_Add", objs, km);
                }

                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write($"<script>window.opener.sub_disp('{hdn_code.Value.Substring(0, 5)}','{hdn_rowIdx.Value}');</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch(Exception ex)
            {
                Response.Write("<script>alert('저장실패');</script>");
            }
        }
    }
}