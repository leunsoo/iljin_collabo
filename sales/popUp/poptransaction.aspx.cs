using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using PublicLibsManagement;
using System.Data;
using les;

namespace iljin.popUp
{
    public partial class poptransaction : ApplicationRoot
    {
        private DB_mysql km;
        private string date = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hidden_ordCode.Value = Request.Params.Get("code");
                hidden_tranCode.Value = Request.Params.Get("tcode");

                Search();
                Search_Detail();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_transaction_Get_order_master", hidden_ordCode.Value, km);

            txt_ordernum.Text = dt.Rows[0][0].ToString();
            txt_cusname.Text = dt.Rows[0][1].ToString();
            txt_customeraddress.Text = dt.Rows[0][2].ToString();
            hidden_cusCode.Value = dt.Rows[0][3].ToString();
            hidden_cusAddressIdx.Value = dt.Rows[0][4].ToString();

            if (hidden_tranCode.Value != "")
            {
                txt_transactionnum.Text = dt.Rows[0]["transactionCode"].ToString();
                txt_publisheddate.Text = dt.Rows[0]["publishDate"].ToString();
                txt_memo.Text = dt.Rows[0]["tmemo"].ToString();
                txt_transactionDate.Text = dt.Rows[0]["transactionDate"].ToString();

                if(dt.Rows[0]["releaseDate"].ToString() != "")
                {
                    hidden_releaseChk.Value = "1";

                    txt_transactionDate.Visible = false;
                    txt_memo.Visible = false;
                    lb_transactionDate.Visible = true;
                    lb_memo.Visible = true;

                    lb_transactionDate.Text = dt.Rows[0]["transactionCode"].ToString();
                    lb_memo.Text = dt.Rows[0]["tmemo"].ToString();

                    btn_save.Visible = false;
                }
            }
            else
            {
                date = DateTime.Now.ToString("yyyy-MM-dd");
                txt_publisheddate.Text = date;
                txt_transactionnum.Text = les_Tool_DB.SetCode("tb_transaction", "transactionCode", ConstClass.TRANSACTION_CODE_PREFIX, km);
                txt_memo.Text = dt.Rows[0]["memo"].ToString();
            }
        }

        private void Search_Detail()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_transaction_Get_order_detail", hidden_ordCode.Value, km);

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable, dt, 0);
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (txt_transactionDate.Text == "")
            {
                Response.Write("<script>alert('거래일을 입력해 주십시오.');</script>");
                return;
            }

            if (DateTime.Compare(DateTime.Parse(txt_publisheddate.Text), DateTime.Parse(txt_transactionDate.Text)) > 0)
            {
                Response.Write("<script>alert('거래일을 미래 일자로 지정해 주십시오.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            km.BeginTran();

            try
            {
                if(hidden_tranCode.Value == "") //추가
                {
                    string tranNo = les_Tool_DB.SetCode_Tran("tb_transaction", "transactionCode", ConstClass.TRANSACTION_CODE_PREFIX, km);

                    object[] objs = { tranNo, txt_ordernum, hidden_cusCode, hidden_cusAddressIdx, txt_transactionDate, txt_publisheddate, txt_memo };

                    PROCEDURE.CUD_TRAN("SP_transaction_Add_FromOrder", objs, km);

                    km.tran_ExSQL_Ret($"Update tb_order_master SET state = '1' WHERE orderCode = '{hidden_ordCode.Value}';");
                }
                else //수정
                {
                    object[] objs = { txt_transactionnum, txt_transactionDate, txt_memo};

                    PROCEDURE.CUD_TRAN("SP_transaction_Update_FromOrder", objs, km);

                }
                km.Commit();

                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Response.Write("<script>alert('저장 실패.');</script>");
            }
        }
    }
}