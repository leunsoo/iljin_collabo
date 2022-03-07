using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;
using MysqlLib;
using System.Data;

namespace iljin.popUp
{
    public partial class popwork : ApplicationRoot
    {
        DB_mysql km;
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

        //기존에 저희가 저장했던 작업 데이터 검색
        //Request.Params.Get("code")로 가져온 일련번호로 
        //DB에서 SELECT 해서 해당 일련번호의 데이터들을 가져온다,(등록일,작업일~~)
        //프로시져 만들어라! SP_item_remake_GetByCode('') <= serialNo <= PrimaryKey
        private void Select()
        {
           if (km == null) km = new DB_mysql();

            DataTable Mdt = PROCEDURE.SELECT("SP_item_remake_GetbyCode", hdn_serialNo.Value, km);

            if (Mdt.Rows.Count < 1)
                return;

            txt_serialNo.Text = hdn_serialNo.Value;
            txt_registrationdate.Text = Mdt.Rows[0]["registrationdate"].ToString();
            txt_workdate.Text = Mdt.Rows[0]["workdate"].ToString();
            tb_foreign.Text = Mdt.Rows[0]["name"].ToString();
            hidden_idx.Value =  Mdt.Rows[0]["foreignIdx"].ToString();
            tb_emp.Text = Mdt.Rows[0]["empName"].ToString();
            hidden_userCode.Value = Mdt.Rows[0]["empCode"].ToString();
            cb_machineNo.SelectedValue = Mdt.Rows[0]["machineNo"].ToString();
            txt_workitem.Text = Mdt.Rows[0]["workI"].ToString();
            hidden_itemCode.Value = Mdt.Rows[0]["workitem"].ToString();
            txt_workitemQty.Text = Mdt.Rows[0]["workitemQty"].ToString();
            txt_produceitem.Text = Mdt.Rows[0]["prodI"].ToString();
            hidden_itemCode2.Value = Mdt.Rows[0]["produceitem"].ToString();
            txt_produceitemQty.Text = Mdt.Rows[0]["produceitemQty"].ToString();
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            try
            {
                 km.BeginTran();

                if (hdn_serialNo.Value != "") //수정
                {
                    object[] obj = { hdn_serialNo.Value, txt_registrationdate, txt_workdate,hidden_idx,hidden_userCode,cb_machineNo,
                    hidden_itemCode,txt_workitemQty,hidden_itemCode2,txt_produceitemQty};
                   PROCEDURE.CUD_TRAN("SP_item_remake_Update", obj, km);
                }
                else // 추가
                {
                    string serialNo = PublicLibs.SetCode_Tran("tb_item_remake", "serialNo", ConstClass.REMAKE_CODE_PREFIX, km);

                    object[] obj = {txt_serialNo,txt_registrationdate,txt_workdate,hidden_idx,hidden_userCode,cb_machineNo,
                    hidden_itemCode,txt_workitemQty,hidden_itemCode2,txt_produceitemQty};
                   PROCEDURE.CUD_TRAN("SP_item_remake_Add", obj, km);
                }

                km.Commit();
                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch(Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>('저장실패');</script>");
            }
        }

      


    }
}
