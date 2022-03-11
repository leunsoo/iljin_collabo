using MysqlLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;
using les;

namespace iljin.popUp
{
    public partial class popworkcomplete : ApplicationRoot
    {
        DB_mysql km;
        private DataTable Mdt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack) //  포스트백이 아닐때 ( 해당 페이지가 처음 열렸을떄)
            {
                if (km == null) km = new DB_mysql();
                hidden_code.Value = Request.Params.Get("code");

                km.GetCbDT(ConstClass.CUTTING_MACHINE_CODE, cb_machineNo);

                Search_Info();
                Search_Item_Info(true);
            }
        }

        //작업정보 && 작업제품 정보
        private void Search_Info()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_item_remake_GetbyCode", hidden_code.Value, km);

            if (dt.Rows.Count < 1)
                return;

            txt_serialNo.Text = hidden_code.Value;
            lbl_registrationdate.Text = dt.Rows[0]["registrationdate"].ToString();
            txt_workdate.Text = dt.Rows[0]["workdate"].ToString();
            tb_foreign.Text = dt.Rows[0]["name"].ToString();
            hidden_idx.Value = dt.Rows[0]["foreignIdx"].ToString();
            tb_emp.Text = dt.Rows[0]["empName"].ToString();
            hidden_userCode.Value = dt.Rows[0]["empCode"].ToString();
            cb_machineNo.SelectedValue = dt.Rows[0]["machineNo"].ToString();
            txt_workitem.Text = dt.Rows[0]["workI"].ToString();
            hidden_itemCode.Value = dt.Rows[0]["workitem"].ToString();
            txt_workitemQty.Text = dt.Rows[0]["workitemQty"].ToString();
        }

        //생산제품 정보
        private void Search_Item_Info(bool isSearch)
        {
            if (km == null) km = new DB_mysql();

            if (isSearch)
            {
                Mdt = PROCEDURE.SELECT("SP_item_remake_detail_GetBySerialNo", hidden_code.Value, km);
            }

            grdTable1.DataSource = Mdt;
            grdTable1.DataBind();

            TextBox tb;

            for (int i = 0; i < grdTable1.Items.Count; i++)
            {
                ((HiddenField)grdTable1.Items[i].FindControl("hidden_itemCode2")).Value = Mdt.Rows[i][0].ToString();
                ((TextBox)grdTable1.Items[i].FindControl("txt_produceitemQty")).Text = Mdt.Rows[i][2].ToString();

                tb = ((TextBox)grdTable1.Items[i].FindControl("txt_produceitem"));
                tb.Text = Mdt.Rows[i][1].ToString();
                tb.Attributes.Add("onkeypress", $"KeyPressEvent('{i.ToString()}');");
                tb.Attributes.Add("onkeydown", $"KeyDownEvent('{i.ToString()}');");
                tb.Attributes.Add("onclick", $"visibleChk('{i.ToString()}','1');");

                ((Button)grdTable1.Items[i].FindControl("btn_delete")).Attributes.Add("onclick", $"DeleteItem('{i.ToString()}'); return false;");
            }
        }

        //작업완료
        protected void btn_complete_Click(object sender, EventArgs e)
        {
            int count = 0;

            for (int i = 0; i < grdTable1.Items.Count; i++)
            {
                if (((HiddenField)grdTable1.Items[i].FindControl("hidden_itemCode2")).Value != "") count++;
            }

            if (count == 0)
            {
                Response.Write("<script>alert('최소 1개 이상의 제품을 등록하셔야 합니다.');</script>");
                return;
            }

            string serialNo = "";

            if (km == null) km = new DB_mysql();

            try
            {
                km.BeginTran();

                Save_WorkInfo();
                Save_ProdInfo();

                km.Commit();
                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>alert('저장실패');</script>");
            }
        }

        //작업정보 저장
        private void Save_WorkInfo()
        {
            if (km == null) km = new DB_mysql(); //DB 연결

            object[] objs = { hidden_code, txt_workdate, hidden_idx, hidden_userCode, cb_machineNo, hidden_itemCode, txt_workitemQty };

            PROCEDURE.CUD_TRAN("SP_item_remake_Update_final", objs, km);
        }

        //생산제품 저장
        private void Save_ProdInfo()
        {
            //제품저장시 기존 제품 삭제 후 덮어 쓰기
            string sql = $"DELETE FROM tb_item_remake_detail WHERE serialNo = '{hidden_code.Value}';";

            for (int i = 0; i < grdTable1.Items.Count; i++)
            {
                string itemCode = ((HiddenField)grdTable1.Items[i].FindControl("hidden_itemCode2")).Value;

                if (itemCode != "")
                {
                    sql += " CALL SP_item_remake_detail_Add(" +
                          $"'{hidden_code.Value}'," +
                          $"'{((HiddenField)grdTable1.Items[i].FindControl("hidden_itemCode2")).Value}'," +
                          $"'{((TextBox)grdTable1.Items[i].FindControl("txt_produceitemQty")).Text}');";
                }
            }

            km.tran_ExSQL_Ret(sql);
        }

        //삭제 버튼 클릭
        //그리드 row삭제
        protected void hdn_btn_delete_Click(object sender, EventArgs e)
        {
            string[] fieldArr = { "itemCode", "fullName", "qty" };

            Mdt = les_DataGridSystem.Get_Dt_From_DataGrid(grdTable1, fieldArr);

            Mdt.Rows.RemoveAt(int.Parse(hdn_deleteRow.Value));

            Search_Item_Info(false);
        }

        //추가 버튼 클릭
        //그리드 row삽입
        protected void btn_add_Click(object sender, EventArgs e)
        {
            string[] fieldArr = { "itemCode", "fullName", "qty" };

            Mdt = les_DataGridSystem.Get_Dt_From_DataGrid(grdTable1, fieldArr);

            DataRow dr = Mdt.NewRow();

            Mdt.Rows.Add(dr);

            Search_Item_Info(false);
        }
    }
}