using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;
using MysqlLib;
using System.Data;
using les;

namespace iljin.popUp
{
    public partial class popwork : ApplicationRoot
    {
        DB_mysql km;
        private DataTable Mdt;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_serialNo.Value = Request.Params.Get("code");
                km.GetCbDT(ConstClass.CUTTING_MACHINE_CODE, cb_machineNo);

                if (hdn_serialNo.Value != "") //수정
                {
                    Search_Info();
                    Search_Item_Info(true);
                }
                else //추가
                {
                    txt_serialNo.Text = PublicLibs.SetCode("tb_item_remake", "serialNo", ConstClass.REMAKE_CODE_PREFIX, km);

                    string date = DateTime.Now.ToString("yyyy-MM-dd");
                    txt_registrationdate.Text = date;

                    UserSetting();
                    btn_add_Click(null, null);
                }
            }
        }

        //로그인한 사람 정보 자동 입력
        private void UserSetting()
        {
            if (km == null) km = new DB_mysql();

            hidden_userCode.Value = Session["userCode"].ToString();

            string sql = $"SELECT empName FROM tb_emp WHERE userCode = '{hidden_userCode.Value}'; ";

            tb_emp.Text = km.GetDTa(sql).Rows[0][0].ToString();
        }

        //작업정보 && 작업제품 정보
        private void Search_Info()
        {
           if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_item_remake_GetbyCode", hdn_serialNo.Value, km);

            if (dt.Rows.Count < 1)
                return;

            txt_serialNo.Text = hdn_serialNo.Value;
            txt_registrationdate.Text = dt.Rows[0]["registrationdate"].ToString();
            txt_workdate.Text = dt.Rows[0]["workdate"].ToString();
            tb_foreign.Text = dt.Rows[0]["name"].ToString();
            hidden_idx.Value =  dt.Rows[0]["foreignIdx"].ToString();
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
                Mdt = PROCEDURE.SELECT("SP_item_remake_detail_GetBySerialNo", hdn_serialNo.Value, km);
            }

            table_ItemInfo.DataSource = Mdt;
            table_ItemInfo.DataBind();

            TextBox tb;

            for (int i = 0; i < table_ItemInfo.Items.Count; i++)
            {
                ((HiddenField)table_ItemInfo.Items[i].FindControl("hidden_itemCode2")).Value = Mdt.Rows[i][0].ToString();
                ((TextBox)table_ItemInfo.Items[i].FindControl("txt_produceitemQty")).Text = Mdt.Rows[i][2].ToString();

                tb = ((TextBox)table_ItemInfo.Items[i].FindControl("txt_produceitem"));
                tb.Text = Mdt.Rows[i][1].ToString();
                tb.Attributes.Add("onkeypress", $"KeyPressEvent('{i.ToString()}');");
                tb.Attributes.Add("onkeydown", $"KeyDownEvent('{i.ToString()}');");
                tb.Attributes.Add("onclick", $"visibleChk('{i.ToString()}','1');");

                ((Button)table_ItemInfo.Items[i].FindControl("btn_delete")).Attributes.Add("onclick", $"DeleteItem('{i.ToString()}'); return false;");
            }
        }

        //저장
        protected void btn_save_Click(object sender, EventArgs e)
        {
            int count = 0;

            for (int i = 0; i < table_ItemInfo.Items.Count; i++)
            {
                if (((HiddenField)table_ItemInfo.Items[i].FindControl("hidden_itemCode2")).Value != "") count++;
            }

            if(count == 0)
            {
                Response.Write("<script>alert('최소 1개 이상의 제품을 등록하셔야 합니다.');</script>");
                return;
            }

            string serialNo = "";

            if (km == null) km = new DB_mysql();

            try
            {
                km.BeginTran();

                serialNo = hdn_serialNo.Value;

                if (hdn_serialNo.Value == "") serialNo = PublicLibs.SetCode_Tran("tb_item_remake", "serialNo", ConstClass.REMAKE_CODE_PREFIX, km);

                Save_WorkInfo(serialNo);
                Save_ItemInfo(serialNo);

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

        //작업정보 저장
        private void Save_WorkInfo(string serialNo)
        {
            if (hdn_serialNo.Value != "") //수정
            {
                object[] obj = { serialNo, txt_registrationdate, txt_workdate,hidden_idx,hidden_userCode,cb_machineNo,
                    hidden_itemCode,txt_workitemQty};
                PROCEDURE.CUD_TRAN("SP_item_remake_Update", obj, km);
            }
            else // 추가
            {
                object[] obj = {serialNo,txt_registrationdate,txt_workdate,hidden_idx,hidden_userCode,cb_machineNo,
                    hidden_itemCode,txt_workitemQty};
                PROCEDURE.CUD_TRAN("SP_item_remake_Add", obj, km);
            }
        }

        //생산제품 저장
        private void Save_ItemInfo(string serialNo)
        {
            //제품저장시 기존 제품 삭제 후 덮어 쓰기
            string sql = $"DELETE FROM tb_item_remake_detail WHERE serialNo = '{serialNo}';";

            for (int i = 0; i < table_ItemInfo.Items.Count; i++)
            {
                string itemCode = ((HiddenField)table_ItemInfo.Items[i].FindControl("hidden_itemCode2")).Value;

                if (itemCode != "")
                {
                    sql += " CALL SP_item_remake_detail_Add(" +
                          $"'{serialNo}'," +
                          $"'{((HiddenField)table_ItemInfo.Items[i].FindControl("hidden_itemCode2")).Value}'," +
                          $"'{((TextBox)table_ItemInfo.Items[i].FindControl("txt_produceitemQty")).Text}');";
                }
            }

            km.tran_ExSQL_Ret(sql);
        }

        //삭제 버튼 클릭
        //그리드 row삭제
        protected void hdn_btn_delete_Click(object sender, EventArgs e)
        {
            string[] fieldArr = { "itemCode", "fullName", "qty" };

            Mdt = les_DataGridSystem.Get_Dt_From_DataGrid(table_ItemInfo, fieldArr);

            Mdt.Rows.RemoveAt(int.Parse(hdn_deleteRow.Value));

            Search_Item_Info(false);
        }

        //추가 버튼 클릭
        //그리드 row삽입
        protected void btn_add_Click(object sender, EventArgs e)
        {
            string[] fieldArr = { "itemCode", "fullName", "qty" };

            Mdt = les_DataGridSystem.Get_Dt_From_DataGrid(table_ItemInfo, fieldArr);

            DataRow dr = Mdt.NewRow();

            Mdt.Rows.Add(dr);

            Search_Item_Info(false);
        }
    }
}
