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
                    Select();
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
        private void Select()
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

        //저장
        protected void btn_save_Click(object sender, EventArgs e)
        {
            string serialNo = "";

            if (km == null) km = new DB_mysql();

            try
            {
                km.BeginTran();

                if(hdn_serialNo.Value != "")
                {
                    serialNo = hdn_serialNo.Value;
                }
                else
                {
                    serialNo = PublicLibs.SetCode_Tran("tb_item_remake", "serialNo", ConstClass.REMAKE_CODE_PREFIX, km);
                }

                Save_WorkInfo(serialNo);
                Save_ProdInfo(serialNo);

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
        private void Save_ProdInfo(string serialNo)
        {
            string sql = "";


        }

        //추가
        protected void btn_add_Click(object sender, EventArgs e)
        {
            Get_Dt_From_Grid();
            Set_Grid_From_Dt();
        }

        //그리드 정보로 DT복사 및 DT의 새로운 row 만들기
        private void Get_Dt_From_Grid()
        {
            Mdt = new DataTable();

            Mdt.Columns.Add("itemCode");
            Mdt.Columns.Add("itemName");
            Mdt.Columns.Add("qty");

            DataRow dr;

            for (int i = 0;  i < grdTable1.Items.Count; i++)
            { 
                dr = Mdt.NewRow();

                dr["itemCode"] = ((HiddenField)grdTable1.Items[i].FindControl("hidden_itemCode2")).Value;
                dr["itemName"] = ((TextBox)grdTable1.Items[i].FindControl("txt_produceitem")).Text;
                dr["qty"] = ((TextBox)grdTable1.Items[i].FindControl("txt_produceitemQty")).Text;

                Mdt.Rows.Add(dr);
            }

            dr = Mdt.NewRow();

            Mdt.Rows.Add(dr);
        }

        //그리드에 DT넣기
        private void Set_Grid_From_Dt()
        {
            grdTable1.DataSource = Mdt;
            grdTable1.DataBind();

            TextBox tb;

            for(int i = 0; i < grdTable1.Items.Count; i ++)
            {
                ((HiddenField)grdTable1.Items[i].FindControl("hidden_itemCode2")).Value = Mdt.Rows[i]["itemCode"].ToString();
                ((TextBox)grdTable1.Items[i].FindControl("txt_produceitemQty")).Text = Mdt.Rows[i]["qty"].ToString();

                tb = ((TextBox)grdTable1.Items[i].FindControl("txt_produceitem"));
                tb.Text = Mdt.Rows[i]["itemName"].ToString();
                tb.Attributes.Add("onkeypress", $"KeyPressEvent('{i.ToString()}');");
                tb.Attributes.Add("onkeydown", $"KeyDownEvent('{i.ToString()}');");
                tb.Attributes.Add("onclick", $"visibleChk('{i.ToString()}','1');");
            }
        }
    }
}
