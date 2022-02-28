using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;
using PublicLibsManagement;
using System.Drawing;
using System.Text.RegularExpressions;

namespace iljin.popUp
{
    public partial class popemp : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_code.Value = Request.Params.Get("code");

                fill_cb_authority();
                km.GetCbDT(ConstClass.EMP_DEPARTMENT_CODE, cb_depart);
                km.GetCbDT(ConstClass.EMP_CLASS_CODE, cb_class);
                cb_authority.Items.RemoveAt(0);
                cb_authority.SelectedIndex = 0;

                Search();
            }
        }

        private void fill_cb_authority()
        {
            if (km == null) km = new DB_mysql();
            string sql = "SELECT authId AS code_id,authName AS code_name FROM tb_authority WHERE IsUse = '1' ORDER BY authId; ";
            DataTable dt = km.GetDTa(sql);
            dt.Rows.InsertAt(dt.NewRow(), 0);
            cb_authority.DataSource = dt;
            cb_authority.DataTextField = "code_name";
            cb_authority.DataValueField = "code_id"; 
            cb_authority.DataBind();
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] obj = { hdn_code.Value };

            if(hdn_code.Value != "")
            {
                DataTable dt = PROCEDURE.SELECT("SP_emp_GetByCode", obj, km);

                tb_userCode.Text = dt.Rows[0]["userCode"].ToString();
                tb_empName.Text = dt.Rows[0]["empName"].ToString();
                tb_id.Text = dt.Rows[0]["id"].ToString();
                tb_password.Attributes.Add("value", dt.Rows[0]["password"].ToString());
                tb_email.Text = dt.Rows[0]["email"].ToString();
                cb_authority.SelectedValue = dt.Rows[0]["authorityCode"].ToString();
                cb_depart.SelectedValue = dt.Rows[0]["departmentCode"].ToString();
                cb_class.SelectedValue = dt.Rows[0]["classCode"].ToString();
                tb_tel.Text = dt.Rows[0]["tel"].ToString();
                tb_phone.Text = dt.Rows[0]["phoneNo"].ToString();
                tb_empCode.Text = dt.Rows[0]["empCode"].ToString();
                tb_innerCode.Text = dt.Rows[0]["extensionNo"].ToString();
                tb_memo.Text = dt.Rows[0]["memo"].ToString();

                tb_id.ReadOnly = true;
                tb_password.Visible = false;
                btn_overlap.Enabled = false;
                btn_overlap.BackColor = Color.Gray;

                hdn_overlapChk.Value = "1";
            }
            else
            {
                tb_userCode.Text = Set_empCode();
                tb_id.Attributes.Add("onchange", "overlapReset()");

                btn_delete.Visible = false;
                btn_delete.Enabled = false;

                hdn_overlapChk.Value = "0";
            }
        }

        private string Set_empCode()
        {
            if (km == null) km = new DB_mysql();

            string sql = "select ifnull(max(userCode),0) from tb_emp where userCode like '" + ConstClass.EMP_CODE_PREFIX + DateTime.Now.ToString("yyyy") + "%';";
            DataTable dt = km.tran_GetDTa(sql);
            string empCode = (Convert.ToInt32(dt.Rows[0][0].ToString().Replace(ConstClass.EMP_CODE_PREFIX, "")) + 1).ToString();
            string temp = DateTime.Now.ToString("yyyy") + "00000";
            empCode = ConstClass.EMP_CODE_PREFIX + temp.Substring(0, (temp.Length - empCode.Length)) + empCode;
            return empCode;
        }

        protected void btn_overlap_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            if (tb_id.Text == "")
            {
                tb_id.Focus();
                Response.Write("<script> alert('아이디를 입력해 주십시오.'); </script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            string sql = "SELECT * FROM tb_emp WHERE id = '" + tb_id.Text + "'";

            if (km.GetDTa(sql).Rows.Count > 0)
            {
                Response.Write("<script>alert('이미 사용중인 아이디입니다.');</script>");
                hdn_overlapChk.Value = "0";
            }
            else
            {
                Response.Write("<script>alert('사용가능한 아이디입니다.');</script>");
                hdn_overlapChk.Value = "1";
            }

            tb_empName.Attributes.Add("required", "true");
            tb_id.Attributes.Add("required", "true");
            tb_password.Attributes.Add("required", "true");
        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            try
            {
                km.BeginTran();

                object[] objs = { hdn_code };

                PROCEDURE.CUD_TRAN("SP_emp_Delete", objs, km);

                km.Commit();
                Response.Write("<script>alert('삭제되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch(Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>alert('삭제실패');</script>");
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (hdn_overlapChk.Value != "1")
            {
                Response.Write("<script> alert('아이디 중복 확인을 해주십시오.'); </script>");
                return;
            }

            //처음 등록시 비밀번호 유효성 검사
            if(hdn_code.Value == "")
            {
                if (tb_password.Text.Length < 8)
                {
                    Response.Write("<script> alert('비밀번호는 최소 8글자 이상이여야 합니다.'); </script>");
                    return;
                }
                else if (tb_password.Text.Contains(" "))
                {
                    Response.Write("<script> alert('비밀번호에 공란을 포함하실 수 없습니다.'); </script>");
                    return;
                }
                else
                {
                    Regex rxPassword = new Regex(@"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");

                    if (!rxPassword.IsMatch(tb_password.Text))
                    {
                        Response.Write("<script> alert('비밀번호는 하나 이상의 문자와 숫자를 포함해야 합니다.'); </script>");
                        return;
                    }

                }
            }

            if (km == null) km = new DB_mysql();

            try
            {
                km.BeginTran();

                if (hdn_code.Value != "") //수정
                {
                    object[] obj = { hdn_code,tb_empName,tb_id,tb_email,cb_authority,
                                 cb_depart,cb_class,tb_tel,tb_phone,tb_empCode,tb_innerCode,tb_memo};

                    PROCEDURE.CUD_TRAN("SP_emp_Update",obj, km);
                }
                else //저장
                {

                    object[] obj = { Set_empCode() ,tb_empName,tb_id,tb_password,tb_email,cb_authority,
                                 cb_depart,cb_class,tb_tel,tb_phone,tb_empCode,tb_innerCode,tb_memo};

                    PROCEDURE.CUD_TRAN("SP_emp_Add", obj, km);
                }

                km.Commit();
                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch(Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>alert('저장실패');</script>");
            }
        }
    }
}