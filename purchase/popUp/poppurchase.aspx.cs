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
    public partial class poppurchase : ApplicationRoot
    {
        DB_mysql km = new DB_mysql();
        DataTable itemDt = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_idx.Value = Request.Params.Get("idx");
                km.GetCbDT_FromSql("SELECT userCode,empName FROM tb_emp WHERE isUse = '1';", cb_manager, "없음");

                if (hdn_idx.Value != "") //수정
                {
                    UpdatableCheck();
                    Search_ContractInfo();
                    Search_ItemInfo(true);
                }
                else //추가
                {
                    btn_delete.Visible = false;
                    btn_delete.Enabled = false;

                    txt_registrationdate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                    txt_contractdate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                }
            }
        }

        //수정,삭제 가능한지 확인
        private void UpdatableCheck()
        {
            if (km == null) km = new DB_mysql();

            string sql = "SELECT b.idx,c.idx FROM tb_purchase_contract a " +
                         "LEFT OUTER JOIN tb_container_info b ON a.idx = b.contractId " +
                         "LEFT OUTER JOIN tb_warehousing c ON b.idx = c.containerId " +
                        $"WHERE a.idx = '{hdn_idx.Value}' " +
                         "GROUP BY a.idx; ";

            DataTable dt = km.tran_GetDTa(sql);

            //등록된 컨테이너가 있을 시
            if (dt.Rows.Count > 0)
            { 
                if(dt.Rows[0][1].ToString() != "")
                {
                    txt_warning.InnerHtml = " ( 입고처리된 건입니다 )";
                    hidden_chkUpdate.Value = "1";
                    btn_add.Visible = false;
                    btn_save.Visible = false;
                    btn_delete.Visible = false;
                }
                else if(dt.Rows[0][0].ToString() != "")
                {
                    txt_warning.InnerHtml = " ( 등록된 컨테이너가 존재합니다 )";
                    hidden_chkUpdate.Value = "1";
                    btn_add.Visible = false;
                    btn_save.Visible = false;
                    btn_delete.Visible = false;
                }
            }
        }

        //계약정보 검색
        private void Search_ContractInfo()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { hdn_idx };

            DataTable dt = PROCEDURE.SELECT("SP_purchase_contract_GetByIdx", objs, km);

            txt_cusname.Text = dt.Rows[0]["cusName"].ToString();
            txt_contractno.Text = dt.Rows[0]["contractNo"].ToString();
            txt_lcNo.Text = dt.Rows[0]["lcNo"].ToString();
            txt_contractdate.Text = dt.Rows[0]["contractDate"].ToString();
            txt_title.Text = dt.Rows[0]["title"].ToString();
            txt_price.Text = dt.Rows[0]["price"].ToString();
            hidden_cusCode.Value = dt.Rows[0]["cusCode"].ToString();
            txt_arrivaldate.Text = dt.Rows[0]["eta"].ToString();
            txt_qty.Text = dt.Rows[0]["qty"].ToString();
            cb_manager.SelectedValue = dt.Rows[0]["manager"].ToString();
            chk_tt.Checked = dt.Rows[0]["isTT"].ToString() == "1" ? true : false;
            chk_sample.Checked = dt.Rows[0]["isSample"].ToString() == "1" ? true : false;
            if (dt.Rows[0]["document"].ToString() != "")
                hdn_filePath.Value = ConstClass.PURCHASE_FILE_PATH + dt.Rows[0]["document"].ToString();
            txt_contractprice.Text = dt.Rows[0]["contractPrice"].ToString();
            txt_registrationdate.Text = dt.Rows[0]["registrationDate"].ToString();
            txt_memo.Text = dt.Rows[0]["memo"].ToString();
            txt_totalQty.Text = dt.Rows[0]["totalQty"].ToString();
            txt_totalWeight.Text = dt.Rows[0]["totalWeight"].ToString();
            txt_totalPrice.Text = dt.Rows[0]["totalPrice"].ToString();

        }

        //구매품목정보 검색
        private void Search_ItemInfo(bool isSearch)
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { hdn_idx };

            if (isSearch)
            {
                itemDt = PROCEDURE.SELECT("SP_purchase_item_GetByContractNo", objs, km);
                itemDt.Columns.Add("cud");
            }

            grdTable1.DataSource = itemDt;
            grdTable1.DataBind();

            int rowCount = grdTable1.Items.Count;
            int colCount = grdTable1.Columns.Count;
            TextBox tb;

            for (int i = 0; i < rowCount; i++)
            {
                grdTable1.Items[i].Cells[0].Text = itemDt.Rows[i]["idx"].ToString();

                string itemCode = itemDt.Rows[i]["itemCode"].ToString();
                ((HiddenField)grdTable1.Items[i].FindControl("hidden_itemCode")).Value = itemCode;

                tb = grdTable1.Items[i].FindControl("txt_itemname") as TextBox;
                tb.Text = itemDt.Rows[i]["fullName"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}');");
                tb.Attributes.Add("onkeypress", $"KeyPressEvent('{i.ToString()}');");
                tb.Attributes.Add("onkeydown", $"KeyDownEvent('{i.ToString()}');");
                tb.Attributes.Add("onclick", $"visibleChk('{i.ToString()}','1');");

                if (itemCode != "")
                {
                    //((TextBox)grdTable1.Items[i].FindControl("t1")).Text = itemDt.Rows[i]["div1"].ToString();
                    //((TextBox)grdTable1.Items[i].FindControl("t2")).Text = itemDt.Rows[i]["div2"].ToString();
                    //((TextBox)grdTable1.Items[i].FindControl("t3")).Text = itemDt.Rows[i]["thickness"].ToString();
                    //((TextBox)grdTable1.Items[i].FindControl("t4")).Text = itemDt.Rows[i]["width"].ToString();
                    // ((TextBox)grdTable1.Items[i].FindControl("t5")).Text = itemDt.Rows[i]["length"].ToString();DIKR
                    grdTable1.Items[i].Cells[2].Text = itemDt.Rows[i]["div1"].ToString();
                    grdTable1.Items[i].Cells[3].Text = itemDt.Rows[i]["div2"].ToString();
                    grdTable1.Items[i].Cells[4].Text = itemDt.Rows[i]["thickness"].ToString();
                    grdTable1.Items[i].Cells[5].Text = itemDt.Rows[i]["width"].ToString();
                    grdTable1.Items[i].Cells[6].Text = itemDt.Rows[i]["length"].ToString();
                }
                else
                {
                    //((TextBox)grdTable1.Items[i].FindControl("t1")).Text = "";
                    //((TextBox)grdTable1.Items[i].FindControl("t2")).Text = "";
                    //((TextBox)grdTable1.Items[i].FindControl("t3")).Text = "";
                    //((TextBox)grdTable1.Items[i].FindControl("t4")).Text = "";
                    // ((TextBox)grdTable1.Items[i].FindControl("t5")).Text = "";
                    grdTable1.Items[i].Cells[2].Text = "";
                    grdTable1.Items[i].Cells[3].Text = "";
                    grdTable1.Items[i].Cells[4].Text ="";
                    grdTable1.Items[i].Cells[5].Text ="";
                    grdTable1.Items[i].Cells[6].Text = "";
                }

                grdTable1.Items[i].Cells[7].Text = itemDt.Rows[i]["leftQty"].ToString();

                tb = grdTable1.Items[i].FindControl("txt_count") as TextBox;
                tb.Text = itemDt.Rows[i]["qty"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}'); Sum_Count();");

                tb = grdTable1.Items[i].FindControl("txt_unitprice") as TextBox;
                tb.Text = itemDt.Rows[i]["unitprice"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}');");

                ((HiddenField)grdTable1.Items[i].FindControl("hdn_cud")).Value = itemDt.Rows[i]["cud"].ToString();

                if(hidden_chkUpdate.Value == "1")
                {
                    ((Button)grdTable1.Items[i].FindControl("btn_del")).Visible = false;
                }
                else
                {
                    ((Button)grdTable1.Items[i].FindControl("btn_del")).Attributes.Add("onclick", $"deleterow('{i.ToString()}'); return false;");
                }
            }
        }

        //품목 추가 
        protected void btn_add_Click(object sender, EventArgs e)
        {
            itemDt = Dt_From_ItemGrd();

            DataRow dr;

            dr = itemDt.NewRow();
            dr["cud"] = "c";
            itemDt.Rows.InsertAt(dr, 0);

            Search_ItemInfo(false);
        }

        //품목 삭제
        protected void btn_grd_delete_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            string sql = "";
            int rowIdx = int.Parse(hdn_selectedRow.Value);
            string idx = grdTable1.Items[rowIdx].Cells[0].Text;

            km.BeginTran();

            try
            {
                //불러온 데이터인 경우
                if (idx != "")
                {
                    object[] objs = { idx };

                    km.tran_ExSQL_Ret($"DELETE FROM tb_purchase_item WHERE idx = {idx}");
                }

                itemDt = Dt_From_ItemGrd();

                itemDt.Rows.RemoveAt(rowIdx);

                km.Commit();
                Search_ItemInfo(false);
                Alert("삭제되었습니다.");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Alert("삭제 실패");
            }
        }

        //구매품목Grid DT로 변환
        private DataTable Dt_From_ItemGrd()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("idx", typeof(string));
            dt.Columns.Add("itemCode", typeof(string));
            dt.Columns.Add("fullName", typeof(string));
            dt.Columns.Add("div1", typeof(string));
            dt.Columns.Add("div2", typeof(string));
            dt.Columns.Add("thickness", typeof(string));
            dt.Columns.Add("width", typeof(string));
            dt.Columns.Add("length", typeof(string));
            dt.Columns.Add("leftQty", typeof(string));
            dt.Columns.Add("qty", typeof(string));
            dt.Columns.Add("unitprice", typeof(string));
            dt.Columns.Add("cud", typeof(string));

            DataRow dr;

            for (int i = 0; i < grdTable1.Items.Count; i++)
            {
                dr = dt.NewRow();

                dr["idx"] = grdTable1.Items[i].Cells[0].Text;
                dr["itemCode"] = ((HiddenField)grdTable1.Items[i].FindControl("hidden_itemCode")).Value;
                dr["fullName"] = ((TextBox)grdTable1.Items[i].FindControl("txt_itemname")).Text;
                dr["div1"] = grdTable1.Items[i].Cells[2].Text;//((TextBox)grdTable1.Items[i].FindControl("t1")).Text;
                dr["div2"] = grdTable1.Items[i].Cells[3].Text;//((TextBox)grdTable1.Items[i].FindControl("t2")).Text;
                dr["thickness"] = grdTable1.Items[i].Cells[4].Text;//((TextBox)grdTable1.Items[i].FindControl("t3")).Text;
                dr["width"] = grdTable1.Items[i].Cells[5].Text;//((TextBox)grdTable1.Items[i].FindControl("t4")).Text;
                dr["length"] = grdTable1.Items[i].Cells[6].Text;// ((TextBox)grdTable1.Items[i].FindControl("t5")).Text;
                dr["leftQty"] = grdTable1.Items[i].Cells[7].Text;
                dr["qty"] = ((TextBox)grdTable1.Items[i].FindControl("txt_count")).Text;
                dr["unitprice"] = ((TextBox)grdTable1.Items[i].FindControl("txt_unitprice")).Text;
                dr["cud"] = ((HiddenField)grdTable1.Items[i].FindControl("hdn_cud")).Value;

                dt.Rows.Add(dr);
            }

            return dt;
        }

        //저장
        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (hidden_cusCode.Value == "")
            {
                txt_cusname.Focus();
                Response.Write("<script>alert('거래처를 선택해주십시오.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            km.BeginTran();

            if (txt_contractno.Text == "")
            {
                txt_contractno.Focus();
                Response.Write("<script>alert('계약번호를 입력해주십시오.');</script>");
                return;
            }

            if (hdn_idx.Value == "")
            {
                string sql = $"SELECT * FROM tb_purchase_contract WHERE contractNo = '{txt_contractno.Text}'";

                if (km.tran_GetDTa(sql).Rows.Count > 0)
                {
                    km.Commit();
                    txt_contractno.Focus();
                    Response.Write("<script>alert('이미 존재하는 계약번호입니다.');</script>");
                    return;
                }
            }

            try
            {
                Add_ContractInfo();
                Add_ItemInfo();

                km.Commit();

                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script> window.opener.refresh();</script>");
                Response.Write("<script> self.close();</script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                if (ex.Message == "제품미선택")
                {
                    Response.Write("<script>alert('제품을 선택해 주십시오.');</script>");
                }
                else if (ex.Message == "계약건에 등록된 컨테이너 미삭제 오류")
                {
                    Response.Write("<script>alert('해당 계약에 등록된 컨테이너가 존재합니다.');</script>");
                }
                else
                {
                    Response.Write("<script>alert('저장 실패.');</script>");
                }
            }
        }

        //계약정보 저장
        private void Add_ContractInfo()
        {
            string fileName = "";

            if (hdn_filePath.Value != "")
            {
                fileName = hdn_filePath.Value;
                fileName = txt_contractno.Text + fileName.Substring(fileName.LastIndexOf("."));

                string oldFilePath = HttpContext.Current.Request.PhysicalApplicationPath + hdn_filePath.Value;
                string newFilePath = HttpContext.Current.Request.PhysicalApplicationPath + ConstClass.PURCHASE_FILE_PATH + fileName;

                byte[] b2 = File.ReadAllBytes(oldFilePath);

                File.WriteAllBytes(newFilePath, b2);

                //if (File.Exists(newFilePath))
                //{
                //    File.Delete(newFilePath);
                //}

                //File.Move(oldFilePath, newFilePath);
            }

            if (hdn_idx.Value != "") //수정
            {
                object[] objs = { hdn_idx,txt_contractno, hidden_cusCode,txt_lcNo,txt_contractdate,txt_title,txt_price,txt_arrivaldate,txt_qty,
                cb_manager,chk_tt,chk_sample,fileName,txt_contractprice,txt_registrationdate,txt_memo,txt_totalQty,txt_totalWeight,txt_totalPrice};

                PROCEDURE.CUD_TRAN("SP_purchase_contract_Update", objs, km);
            }
            else //추가
            {
                object[] objs = {  txt_contractno, hidden_cusCode,txt_lcNo,txt_contractdate,txt_title,txt_price,txt_arrivaldate,txt_qty,
                cb_manager,chk_tt,chk_sample,fileName,txt_contractprice,txt_registrationdate,txt_memo,txt_totalQty,txt_totalWeight,txt_totalPrice};

                hdn_idx.Value = PROCEDURE.CUD_ReturnID("SP_purchase_contract_Add", objs, km);
            }
        }

        //구매품목정보 저장
        private void Add_ItemInfo()
        {
            string sql = "";

            for (int i = 0; i < grdTable1.Items.Count; i++)
            {
                string cud = ((HiddenField)grdTable1.Items[i].FindControl("hdn_cud")).Value;
                string itemCode = ((HiddenField)grdTable1.Items[i].FindControl("hidden_itemCode")).Value;
                if (itemCode == "")
                {
                    throw new Exception("제품미선택");
                }

                if (cud == "c") //추가
                {
                    sql += "CALL SP_purchase_item_Add(" +
                        $"'{hdn_idx.Value}'," +
                        $"'{itemCode}'," +
                        $"'{((TextBox)grdTable1.Items[i].FindControl("txt_count")).Text}'," +
                        $"'{((TextBox)grdTable1.Items[i].FindControl("txt_unitprice")).Text}');";
                }
                else if (cud == "u") //수정
                {
                    sql += "CALL SP_purchase_item_Update(" +
                        $"'{grdTable1.Items[i].Cells[0].Text}'," +
                        $"'{itemCode}'," +
                        $"'{((TextBox)grdTable1.Items[i].FindControl("txt_count")).Text}'," +
                        $"'{((TextBox)grdTable1.Items[i].FindControl("txt_unitprice")).Text}');";
                }
            }

            if (sql != "")
            {
                if (km.tran_GetDTa($"SELECT * FROM tb_container_info WHERE contractId = '{hdn_idx.Value}'").Rows.Count > 0)
                {
                    throw new Exception("계약건에 등록된 컨테이너 미삭제 오류");
                }

                km.tran_ExSQL_Ret(sql);
            }
        }

        //계약 삭제
        protected void btn_delete_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            km.BeginTran();

            try
            {
                string sql = $"DELETE FROM tb_purchase_contract WHERE idx = '{hdn_idx.Value}';";

                km.tran_ExSQL_Ret(sql);

                km.Commit();

                Response.Write("<script>alert('삭제되었습니다.');</script>");
                Response.Write("<script> window.opener.refresh();</script>");
                Response.Write("<script> self.close();</script>");
            }
            catch(Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Response.Write("<script>alert('삭제 실패.');</script>");
            }
        }

        //선택한 제품정보 불러오기
        protected void btn_itemInfoSetting_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            int row = int.Parse(hdn_selectedRow.Value);
            string itemCode = ((HiddenField)grdTable1.Items[row].FindControl("hidden_itemCode")).Value;

            if (itemCode == "")
            {
                grdTable1.Items[row].Cells[2].Text = "";   //구분1
                grdTable1.Items[row].Cells[3].Text = "";   //구분2
                grdTable1.Items[row].Cells[4].Text = "";   //두께
                grdTable1.Items[row].Cells[5].Text = "";   //폭
                grdTable1.Items[row].Cells[6].Text = "";   //길이

                ((TextBox)grdTable1.Items[row].FindControl("txt_count")).Text = "";  //개수
                ((TextBox)grdTable1.Items[row].FindControl("txt_unitprice")).Text = "";  //단가
                return;
            }

            string sql = "SELECT b.code_name, c.code_name,thickness,width,length FROM tb_item a " +
                         "INNER JOIN tb_code b ON a.divCode1 = b.code_id " +
                         "LEFT OUTER JOIN tb_code c ON a.divCode2 = c.code_id " +
                         $"WHERE a.itemCode = '{itemCode}'";

            DataTable dt = km.GetDTa(sql);

            //((TextBox)grdTable1.Items[row].FindControl("t1")).Text = dt.Rows[0][0].ToString();   //구분1
            //((TextBox)grdTable1.Items[row].FindControl("t2")).Text = dt.Rows[0][1].ToString();   //구분2
            //((TextBox)grdTable1.Items[row].FindControl("t3")).Text = dt.Rows[0][2].ToString();   //두께
            //((TextBox)grdTable1.Items[row].FindControl("t4")).Text = dt.Rows[0][3].ToString();   //폭
            //((TextBox)grdTable1.Items[row].FindControl("t5")).Text = dt.Rows[0][4].ToString();   //길이
            grdTable1.Items[row].Cells[2].Text = dt.Rows[0][0].ToString();
            grdTable1.Items[row].Cells[3].Text = dt.Rows[0][1].ToString();
            grdTable1.Items[row].Cells[4].Text = dt.Rows[0][2].ToString();
            grdTable1.Items[row].Cells[5].Text = dt.Rows[0][3].ToString();
            grdTable1.Items[row].Cells[6].Text = dt.Rows[0][4].ToString();
        }

        private void Alert(string msg)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", $"alert('{msg}');", true);
        }

        //보여주기용 임시파일저장
        protected void btn_imgTemp_Click(object sender, EventArgs e)
        {
            string fileName = fl_document_input.FileName;
            string temp = "_temp" + fileName.Substring(fileName.LastIndexOf("."));
            fl_document_input.SaveAs(HttpContext.Current.Request.PhysicalApplicationPath + ConstClass.PURCHASE_FILE_PATH + temp);
            hdn_filePath.Value = ConstClass.PURCHASE_FILE_PATH + temp;
        }
    }
}