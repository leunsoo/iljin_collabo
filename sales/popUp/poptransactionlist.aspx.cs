using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MysqlLib;
using les;
using PublicLibsManagement;

namespace iljin.popUp
{
    public partial class poptransactionlist : ApplicationRoot
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

            DataTable dt = PROCEDURE.SELECT("SP_transaction_GetBySearch", km);

            grdTable.DataSource = dt;
            grdTable.DataBind();
            //les_DataGridSystem.Set_CheckBox_DataGrid_From_Dt(grdTable, dt, 1);

            for(int i = 0; i < grdTable.Items.Count; i++)
            {
                grdTable.Items[i].Cells[0].Text = (i + 1).ToString();
                grdTable.Items[i].Cells[1].Text = dt.Rows[i][0].ToString();
                grdTable.Items[i].Cells[2].Text = dt.Rows[i][1].ToString();
                grdTable.Items[i].Cells[3].Text = dt.Rows[i][2].ToString();

                string isSeparate = grdTable.Items[i].Cells[3].Text == "별도발행" ? "1" : "0";

                grdTable.Items[i].Cells[4].Text = dt.Rows[i][3].ToString();
                
                ((Button)grdTable.Items[i].FindControl("btn_update")).Attributes.Add("onclick", $"transaction_update('{dt.Rows[i][2].ToString()}','{dt.Rows[i][0].ToString()}','{isSeparate}'); return false;");
                ((Button)grdTable.Items[i].FindControl("btn_delete")).Attributes.Add("onclick", $"transaction_delete('{dt.Rows[i][2].ToString()}','{dt.Rows[i][0].ToString()}','{isSeparate}','{dt.Rows[i][3].ToString()}'); return false;");
            }
        }

        //삭제
        protected void btn_delete_hdn_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            km.BeginTran();

            try
            {
                string sql = "";

                if (hdn_isSeparate.Value == "1") //별도발행된 건은 거래명세서 정보만 삭제하면 된다
                {
                    sql += $"DELETE FROM tb_transaction WHERE transactionCode = '{hdn_deleteCode.Value}';" +
                           $"DELETE FROM tb_transaction_exception WHERE transactionCode = '{hdn_deleteCode.Value}';";
                }
                else // 일반 발행된 건은 주문건에 대한 정보도 수정해주어야 한다.
                {
                    sql += $"DELETE FROM tb_transaction WHERE transactionCode = '{hdn_deleteCode.Value}';" +
                           $"UPDATE tb_order_master SET state = '0' WHERE orderCode = '{hdn_orderCode.Value}';";
                }

                km.tran_ExSQL_Ret(sql);

                km.Commit();

                Response.Write("<script>alert('삭제되었습니다.');</script>");
                Search();
            }
            catch(Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Response.Write("<script>alert('삭제 실패.');</script>");
            }
        }
    }
}