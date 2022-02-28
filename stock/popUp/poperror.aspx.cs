using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PublicLibsManagement;
using MysqlLib;

namespace iljin.popUp
{
    public partial class poperror : ApplicationRoot
    {
        DB_mysql km;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hidden_code.Value = Request.Params.Get("code");

                if (hidden_code.Value == "") //등록
                {
                    BaseSetting();
                }
                else //수정
                {
                    Search();
                }
            }
        }

        private void BaseSetting()
        {
            if (km == null) km = new DB_mysql();

            txt_registrationdate.Text = DateTime.Now.ToString("yyyy-MM-dd");

            hidden_empCode.Value = Session["userCode"].ToString();

            txt_register.Text = km.GetDTa($"SELECT empName FROM tb_emp WHERE userCode = '{hidden_empCode.Value}';").Rows[0][0].ToString();
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_error_GetByIdx", hidden_code.Value, km);

            txt_registrationdate.Text = dt.Rows[0][0].ToString();
            hidden_empCode.Value = dt.Rows[0][1].ToString();
            txt_register.Text = dt.Rows[0][2].ToString();
            hidden_cusCode.Value = dt.Rows[0][3].ToString();
            txt_customer.Text = dt.Rows[0][4].ToString();
            hidden_itemCode.Value = dt.Rows[0][5].ToString();
            txt_itemname.Text = dt.Rows[0][6].ToString();
            txt_errortype.Text = dt.Rows[0][7].ToString();
            txt_errorQty.Text = dt.Rows[0][8].ToString();
            txt_requestdate.Text = dt.Rows[0][9].ToString();
            txt_checkdate.Text = dt.Rows[0][10].ToString();
            //txt_returndate.Text = dt.Rows[0][11].ToString();
            txt_incomedate.Text = dt.Rows[0][12].ToString();
            txt_transactiondate.Text = dt.Rows[0][13].ToString();
            txt_memo.Text = dt.Rows[0][14].ToString();

        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (hidden_cusCode.Value == "")
            {
                Response.Write("<script>alert('거래처를 입력해 주십시오.');</script>");
                return;
            }
            else if (hidden_itemCode.Value == "")
            {
                Response.Write("<script>alert('제품을 선택해 주십시오.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            try
            {
                if (hidden_code.Value != "") //수정
                {
                    object[] objs = { hidden_code,hidden_cusCode,hidden_itemCode,txt_errortype,txt_errorQty,
                    txt_requestdate,txt_checkdate,/*txt_returndate*/txt_incomedate,txt_transactiondate,txt_memo};

                    PROCEDURE.CUD("SP_error_Update", objs, km);
                }
                else //저장
                {
                    object[] objs = { txt_registrationdate,hidden_empCode,hidden_cusCode,hidden_itemCode,txt_errortype,txt_errorQty,
                    txt_requestdate,txt_checkdate,/*txt_returndate*/txt_incomedate,txt_transactiondate,txt_memo};

                    PROCEDURE.CUD("SP_error_Add", objs, km);
                }

                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('저장 실패.');</script>");
            }
        }
    }
}