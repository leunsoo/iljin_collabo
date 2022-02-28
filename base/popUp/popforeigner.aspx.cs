using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;
using MysqlLib;
using System.Data;
using System.IO;

namespace iljin.popUp
{
    public partial class popforeigner : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_idx.Value = Request.Params.Get("idx");

                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] obj = { hdn_idx };

            if (hdn_idx.Value != "")
            {
                DataTable dt = PROCEDURE.SELECT("SP_foreigner_GetByIdx", obj, km);

                tb_name.Text = dt.Rows[0]["name"].ToString();
                tb_fullName.Text = dt.Rows[0]["fullName"].ToString();
                tb_birthDate.Text = dt.Rows[0]["birthDate"].ToString();
                tb_registNo.Text = dt.Rows[0]["registNo"].ToString();
                tb_startDate.Text = dt.Rows[0]["startDate"].ToString();
                tb_country.Text = dt.Rows[0]["country"].ToString();
                tb_insurance1.Text = dt.Rows[0]["insurance1"].ToString();
                tb_insurance2.Text = dt.Rows[0]["insurance2"].ToString();
                tb_visaendDate.Text = dt.Rows[0]["visaendDate"].ToString();
                tb_phoneNumber.Text = dt.Rows[0]["phoneNumber"].ToString();
                tb_memo.Text = dt.Rows[0]["memo"].ToString();

                hdn_file1.Value = dt.Rows[0]["filePath_bank"].ToString();
                hdn_file2.Value = dt.Rows[0]["filePath_IDCard"].ToString();
            }
            else
            {
                btn_del.Visible = false;
                btn_del.Enabled = false;
            }
        }

        protected void btn_del_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { hdn_idx };

            km.BeginTran();

            try
            {
                PROCEDURE.CUD_TRAN("SP_foreigner_Delete", objs, km);

                km.Commit();
                Response.Write("<script>alert('삭제되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch(Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>alert('삭제실패.');</script>");
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if(tb_name.Text.Trim() == "")
            {
                Response.Write("<script>alert('이름을 입력해 주십시오.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            int result = 0;
            string filePath1 = "";
            string filePath2 = "";

            if (fl_file1.HasFile) filePath1 = hdn_idx.Value + "_1" + fl_file1.FileName.Substring(fl_file1.FileName.LastIndexOf("."));
            else filePath1 = hdn_file1.Value;

            if (fl_file2.HasFile) filePath2 = hdn_idx.Value + "_2" + fl_file2.FileName.Substring(fl_file2.FileName.LastIndexOf("."));
            else filePath2 = hdn_file2.Value;

            km.BeginTran();

            try
            {
                if (hdn_idx.Value != "") //수정
                {
                    object[] obj = { hdn_idx.Value, tb_name, tb_fullName, tb_birthDate, tb_registNo, tb_startDate, tb_country,tb_insurance1,
                    tb_insurance2,tb_visaendDate,tb_phoneNumber,filePath1,filePath2,tb_memo};
                    PROCEDURE.CUD_TRAN("SP_foreigner_Update",obj, km);
                }
                else // 추가
                {
                    object[] obj = { tb_name, tb_fullName, tb_birthDate, tb_registNo, tb_startDate, tb_country,tb_insurance1,
                    tb_insurance2,tb_visaendDate,tb_phoneNumber,filePath1,filePath2,tb_memo};
                   
                    hdn_idx.Value = PROCEDURE.CUD_ReturnID("SP_foreigner_Add", obj, km);
                }

                if (fl_file1.HasFile)
                {
                    fl_file1.SaveAs(HttpContext.Current.Request.PhysicalApplicationPath + ConstClass.FOREIGNER_FILE_PATH + filePath1);
                }
                if (fl_file2.HasFile)
                {
                    fl_file2.SaveAs(HttpContext.Current.Request.PhysicalApplicationPath + ConstClass.FOREIGNER_FILE_PATH + filePath2);
                }
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Response.Write("<script>alert('저장 실패');</script>");
                return;
            }

            km.Commit();
            Response.Write("<script>alert('저장되었습니다.'); window.opener.refresh(); self.close();</script>");
        }
    }
}