using PublicLibsManagement;
using MysqlLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace iljin.popUp
{
    public partial class popgroup : ApplicationRoot
    {

        DB_mysql km;

        private void select()
        {
            if (km == null) km = new DB_mysql();
            DataTable dt = PROCEDURE.SELECT("SP_authority_GetById", hidden_authId.Value, km);
            if (dt.Rows.Count == 0)
            {
                Response.Write("<script>alert('존재하지 않는 데이터입니다.');</script>");
                return;
            }
            txt_authName.Text = dt.Rows[0]["authName"].ToString();
            hidden_authId.Value = dt.Rows[0]["authId"].ToString();
            if (dt.Rows[0]["IsUse"].ToString() == "1")
            {
                rd_use_y.Checked = true;
            }
            else
            {
                rd_use_n.Checked = true;
            }
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                hidden_authId.Value = Request.Params.Get("code");
                hidden_doubleChecked.Value = "0";
                rd_use_y.Checked = true;
                if (hidden_authId.Value != "")
                {
                    select();
                    hidden_doubleChecked.Value = "1";
                }
                txt_authName.Attributes.Add("onchange", "set_doubleChecked_false();");

            }
        }



        protected void btn_overlap_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            if (km.GetDTa($"SELECT authName FROM tb_authority WHERE authName = '{txt_authName.Text}';").Rows.Count == 0)
            {
                Response.Write("<script>alert('사용가능한 권한명입니다.');</script>");
                hidden_doubleChecked.Value = "1";
                return;
            }
            else
            {
                Response.Write("<script>alert('이미 사용중인 권한명입니다.');</script>");
                hidden_doubleChecked.Value = "0";
                return;
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (hidden_doubleChecked.Value != "1")
            {
                Response.Write("<script>alert('중복검사를 하여 주십시오.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();
            string isuse = rd_use_y.Checked ? "1" : "0";

            try
            {
                km.BeginTran();

                if (hidden_authId.Value == "") //추가
                {
                    object[] obj = { txt_authName, isuse };
                    string authId = PROCEDURE.CUD_ReturnID("SP_authority_Add", obj, km);
                    
                    PROCEDURE.CUD_TRAN("SP_authoritysetting_Add", authId, km);
                }
                else //수정
                {
                    object[] obj = { hidden_authId, txt_authName, isuse };
                    int result = PROCEDURE.CUD_TRAN("`SP_authority_Update`", obj, km);
                    if (result < 1) throw new Exception();
                }

                km.Commit();
                Response.Write("<script>alert('저장되었습니다.');opener.refresh();window.close();</script>");
                return;
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Response.Write("<script>alert('저장 실패.');</script>");
                return;
            }

        }
    }
}