using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using PublicLibsManagement;
using System.Data;
using System.IO;

namespace iljin.popUp
{
    public partial class poppurchaseenrollment : ApplicationRoot
    {
        DB_mysql km = new DB_mysql();
        DataTable itemDt = new DataTable();
        DataTable progressDt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();
                hdn_idx.Value = Request.Params.Get("code");
                hidden_empCode.Value = Session["userCode"].ToString();
                cb_manager_Setting();
               



                if (hdn_idx.Value != "")
                {
                    Search_purchase();
                    Search_ItemInfo(true);

                }
                else
                {
                    // btn_del.Visible = false;
                    //  btn_del.Enabled = false;

                    txt_requestdate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                    string empName = km.GetDTa($"SELECT empName FROM tb_emp WHERE userCode = '{hidden_empCode.Value}';").Rows[0][0].ToString();

                    txt_registrant.Text = empName;
                }

            }
        }

        //담당자 콤보박스 Setting
        private void cb_manager_Setting()
        {
            if (km == null) km = new DB_mysql();
            km.GetCbDT_FromSql("SELECT userCode,empName FROM tb_emp WHERE isUse='1';", cb_manager);
        }

       
        private void Search_purchase()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_purchase_status_GetByIdx", hdn_idx.Value, km);

            cb_manager.SelectedValue = dt.Rows[0]["requester"].ToString();
            txt_cusname.Text = dt.Rows[0]["cusName"].ToString();
            txt_registrant.Text = dt.Rows[0]["empName"].ToString();
            txt_requestdate.Text = dt.Rows[0]["requestdate"].ToString();
            txt_memo.Text = dt.Rows[0]["memo"].ToString();

        }

        private void Search_ItemInfo(bool isSearch)
        {
            if (km == null) km = new DB_mysql();

            getCodeDt();
            if (isSearch)
            {
                itemDt = PROCEDURE.SELECT("SP_purchase_status_detail_GetByIdx", hdn_idx.Value, km);
            }

            grdTable1.DataSource = itemDt;
            grdTable1.DataBind();
            

            int rowCount = grdTable1.Items.Count;
            int colCount = grdTable1.Columns.Count;

            TextBox tb;
            DropDownList cb;

            for (int i = 0; i < rowCount; i++)
            {

                tb = grdTable1.Items[i].FindControl("txt_itemname") as TextBox;
                tb.Text = itemDt.Rows[i]["itemName"].ToString();

                tb = grdTable1.Items[i].FindControl("txt_qty") as TextBox;
                tb.Text = itemDt.Rows[i]["qty"].ToString();

                tb = grdTable1.Items[i].FindControl("txt_deliverydate") as TextBox;
                tb.Text = itemDt.Rows[i]["deliveryDate"].ToString();

                tb = grdTable1.Items[i].FindControl("txt_manufacturer") as TextBox;
                tb.Text = itemDt.Rows[i]["manufacturer"].ToString();

                tb = grdTable1.Items[i].FindControl("txt_unitprice") as TextBox;
                tb.Text = itemDt.Rows[i]["unitprice"].ToString();

                // tb = grdTable1.Items[i].FindControl("txt_progressCode") as TextBox;
                //  tb.Text = itemDt.Rows[i]["progress"].ToString();

                cb = grdTable1.Items[i].FindControl("cb_progress") as DropDownList;
                bind_cb(cb, progressDt);
                cb.SelectedValue = itemDt.Rows[i]["progress"].ToString();

                tb = grdTable1.Items[i].FindControl("txt_memo") as TextBox;
                tb.Text = itemDt.Rows[i]["memo"].ToString();

            }
        }

        private void getCodeDt()
        {
            if (km == null) km = new DB_mysql();

           progressDt = km.GetCbDT(ConstClass.PROGRESS_CODE);
        }
      
        private void bind_cb(DropDownList cb, DataTable dt)
        {
            cb.DataSource = dt;
            cb.DataTextField = "code_name";
            cb.DataValueField = "code_id";

            cb.DataBind();
        }

        //저장
        protected void btn_add_Click(object sender, EventArgs e)
        {
            itemDt = Dt_From_ItemGrd();

            DataRow dr;

            dr = itemDt.NewRow();
            itemDt.Rows.InsertAt(dr, 0);

            Search_ItemInfo(false);

        }

        //ITEMGrid에서 DT를 뽑아낸다
        private DataTable Dt_From_ItemGrd()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("idx", typeof(string));
            dt.Columns.Add("itemName", typeof(string));
            dt.Columns.Add("qty", typeof(string));
            dt.Columns.Add("deliveryDate", typeof(string));
            dt.Columns.Add("manufacturer", typeof(string));
            dt.Columns.Add("unitprice", typeof(string));
            dt.Columns.Add("progress", typeof(string));
            dt.Columns.Add("memo", typeof(string));

            DataRow dr;

            for (int i = 0; i < grdTable1.Items.Count; i++)
            {
                dr = dt.NewRow();

                dr["idx"] = grdTable1.Items[i].Cells[0].Text;
                dr["itemName"] = ((TextBox)grdTable1.Items[i].FindControl("txt_itemName")).Text;
                dr["qty"] = ((TextBox)grdTable1.Items[i].FindControl("txt_qty")).Text;
                dr["deliveryDate"] = ((TextBox)grdTable1.Items[i].FindControl("txt_deliveryDate")).Text;
                dr["manufacturer"] = ((TextBox)grdTable1.Items[i].FindControl("txt_manufacturer")).Text;
                dr["progress"] = ((DropDownList)grdTable1.Items[i].FindControl("cb_progress")).Text;
                dr["memo"] = ((TextBox)grdTable1.Items[i].FindControl("txt_memo")).Text;

                dt.Rows.Add(dr);
            }

            return dt;
        }

        protected void btn_save_Click(object sender, EventArgs e)//저장
        {
            int count = 0;
            for (int i = 0; i < grdTable1.Items.Count; i++) // gridtable1의  row 개수만큼 반복
            {
                if (((TextBox)grdTable1.Items[i].FindControl("txt_itemName")).Text.Trim() != "") // gridtable1의. i번째row의.0번째cells의.글자의 스페이스를 지운 값이 공백이 아닐때 
                {
                    count++; //count 1씩 더해준다.
                }
            }

            if (count == 0)
            {
                Response.Write("<script>alert('제품 정보를 입력해주십시오.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            km.BeginTran();

            try
            {
                Add_purchase();
                Add_ItemInfo();

                km.Commit();

                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script> self.close();</script>");
            }

            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Response.Write("<script>alert('저장실패.');</script>");

            }
        }

        private void Add_purchase()
        {
            if (hdn_idx.Value != "") //수정
            {
                object[] obj = { hdn_idx, txt_cusname, cb_manager, txt_memo };

                PROCEDURE.CUD_TRAN("SP_purchase_status_Update", obj, km);

            }
            else // 추가
            {
                object[] obj = { txt_requestdate, hidden_empCode, cb_manager, txt_cusname, txt_memo };

                hdn_idx.Value = PROCEDURE.CUD_ReturnID("SP_purchase_status_Add", obj, km);

            }
        }

        private void Add_ItemInfo()
        {
            string sql = $"DELETE FROM tb_purchase_status_detail WHERE statusIdx = {hdn_idx.Value};";

            for (int i = 0; i < grdTable1.Items.Count; i++)
            {

                if (((TextBox)grdTable1.Items[i].FindControl("txt_itemname")).Text == "")
                    continue;

                sql += "CALL SP_purchase_status_detail_Add(" +
                    $"'{hdn_idx.Value}'," +
                    $"'{((TextBox)grdTable1.Items[i].FindControl("txt_itemname")).Text}'," +
                    $"'{((TextBox)grdTable1.Items[i].FindControl("txt_qty")).Text}'," +
                    $"'{((TextBox)grdTable1.Items[i].FindControl("txt_deliveryDate")).Text}'," +
                    $"'{((TextBox)grdTable1.Items[i].FindControl("txt_manufacturer")).Text}'," +
                    $"'{((TextBox)grdTable1.Items[i].FindControl("txt_unitprice")).Text}'," +
                    $"'{((DropDownList)grdTable1.Items[i].FindControl("cb_progress")).SelectedValue}'," +
                    $"'{((TextBox)grdTable1.Items[i].FindControl("txt_memo")).Text}');";
            }

            if (sql != "")
            {
                km.tran_ExSQL_Ret(sql);
            }
        }
    }
}


