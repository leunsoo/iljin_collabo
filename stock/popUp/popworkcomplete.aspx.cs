using MysqlLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using PublicLibsManagement;

namespace iljin.popUp
{
    //====================================================================주석 꼭 쓰기====================================================================
    public partial class popworkcomplete : ApplicationRoot
    {
        DB_mysql km;
        string code;

        private void Select()
        {
            if (km == null) km = new DB_mysql();

            DataTable Mdt = PROCEDURE.SELECT("SP_item_remake_GetbyCode", hidden_code.Value, km);

            if (Mdt.Rows.Count < 1)
                return;

            txt_serialNo.Text = hidden_code.Value;
            lbl_registrationdate.Text = Mdt.Rows[0]["registrationdate"].ToString();
            txt_workdate.Text = Mdt.Rows[0]["workdate"].ToString();
            tb_foreign.Text = Mdt.Rows[0]["name"].ToString();
            hidden_idx.Value = Mdt.Rows[0]["foreignIdx"].ToString();
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
        
        
        //================================================================주석 꼭 쓰기====================================================================
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack) //  포스트백이 아닐때 ( 해당 페이지가 처음 열렸을떄)
            {
                if (km == null) km = new DB_mysql();
                hidden_code.Value = Request.Params.Get("code");

                km.GetCbDT(ConstClass.CUTTING_MACHINE_CODE, cb_machineNo);
                Select();
            }
        }

        protected void btn_complete_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql(); //DB 연결

            object[] objs = { hidden_code,txt_workdate, hidden_idx, hidden_userCode, cb_machineNo, hidden_itemCode, txt_workitemQty, hidden_itemCode2, txt_produceitemQty };

            PROCEDURE.CUD("SP_item_remake_Update_final", objs, km);

            Response.Write("<script>alert('저장되었습니다.');</script>");
            Response.Write("<script>window.opener.refresh();</script>");
            Response.Write("<script>window.close();</script>");
        }
    }
        //================================================================주석 꼭 쓰기====================================================================
    }
    //====================================================================주석 꼭 쓰기====================================================================
