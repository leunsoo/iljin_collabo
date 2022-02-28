using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;
using PublicLibsManagement;
using System.Drawing;
using System.IO;

namespace iljin.popUp
{
    public partial class popbl : ApplicationRoot
    {
        DB_mysql km;
        DataTable containerDt;
        DataTable contractDt;
        string id = "";

        protected void Page_Load(object sender, EventArgs e)
        {

            ContractDtSetting();
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();


                Form.DefaultButton = defaultBtn.ClientID;
                hdn_no.Value = Request.Params.Get("no");
                hdn_user.Value = Session["userCode"].ToString();
                chk_itemAll.Attributes.Add("onchange", "grdTable2_checkAll(); return false;");

                object[] objs = { hdn_no, hdn_user };

                //기존 데이터 Temp 테이블로 복사 후 
                //Temp 테이블의 데이터로 작동 후
                //저장할 시 기존 테이블에 덮어쓰기
                PROCEDURE.CUD("SP_tempTable_Copy", objs, km);

                if (hdn_no.Value != "")
                {
                    UpdatableCheck();
                    Search_BLInfo();
                    Search_ContainerInfo(true);
                }
                else
                {
                    btn_add_Click(null, null);
                    btn_delete.Visible = false;
                }
            }

        }

        //수정,삭제 가능한지 확인
        private void UpdatableCheck()
        {
            if (km == null) km = new DB_mysql();

            string sql = "SELECT a.idx, b.idx,c.idx FROM tb_BLinfo a " +
                         "LEFT OUTER JOIN tb_container_info b ON a.idx = b.blId " +
                         "LEFT OUTER JOIN tb_warehousing c ON b.idx = c.containerId " +
                        $"WHERE c.idx is not NULL AND a.idx = '{hdn_no.Value}'" +
                        $"GROUP BY b.idx;";

            DataTable dt = km.tran_GetDTa(sql);

            //등록된 컨테이너가 있을 시
            if (dt.Rows.Count > 0)
            {
                txt_warning.InnerHtml = " ( 입고처리된 건입니다 )";
                hidden_chkUpdate.Value = "1";
                btn_add.Visible = false;
                btn_save.Visible = false;
                btn_delete.Visible = false;
            }
        }

        private void ContractDtSetting()
        {
            if (km == null) km = new DB_mysql();
            contractDt = PROCEDURE.SELECT("SP_purchase_contract_GetContractList", km);
        }

        private void bind_cb(DropDownList li, DataTable dt)
        {
            if (dt.Rows.Count > 0)
            {
                li.DataSource = dt;
                li.DataTextField = "code_name";
                li.DataValueField = "code_id";

                li.DataBind();
            }
            else
            {
                li.Items.Add(new ListItem("없음", ""));
            }
        }

        #region bl
        //BL 정보 불러오기
        private void Search_BLInfo()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { hdn_no };

            DataTable dt = PROCEDURE.SELECT("SP_BLInfo_GetByIdx", objs, km);

            txt_blnum.Text = dt.Rows[0]["blNo"].ToString();
            txt_registrationdate.Text = dt.Rows[0]["registrationDate"].ToString();
            txt_declarationNo.Text = dt.Rows[0]["declarationNo"].ToString();

            string fileName = dt.Rows[0]["original"].ToString();
            if (fileName != "")
            {
                fileName = hdn_no.Value + fileName.Substring(fileName.LastIndexOf("."));
                hdn_filePath.Value = ConstClass.BL_FILE_PATH + fileName;
            }
            txt_qty.Text = dt.Rows[0]["qty"].ToString();
            txt_weight.Text = dt.Rows[0]["weight"].ToString();
            txt_etd.Text = dt.Rows[0]["etd"].ToString();
            txt_eta.Text = dt.Rows[0]["eta"].ToString();
        }

        //BL 원본 보여주기용 임시파일
        protected void btn_imgTemp_Click(object sender, EventArgs e)
        {
            string fileName = fl_document_input.FileName;
            string temp = "_temp" + fileName.Substring(fileName.LastIndexOf("."));
            fl_document_input.SaveAs(HttpContext.Current.Request.PhysicalApplicationPath + ConstClass.BL_FILE_PATH + temp);
            hdn_filePath.Value = ConstClass.BL_FILE_PATH + temp;
        }
        #endregion

        #region container
        //컨테이너 정보 불러오기
        private void Search_ContainerInfo(bool isSearch)
        {
            if (km == null) km = new DB_mysql();

            if (isSearch)
            {
                object[] objs = { hdn_no };
                containerDt = PROCEDURE.SELECT_TRAN("SP_container_info_GetByBLIdx", objs, km);
                containerDt.Columns.Add("cud");
            }

            grdTable1.DataSource = containerDt;
            grdTable1.DataBind();

            TextBox tb;
            DropDownList cb;
            Button btn;
            string itemChk = "";
            string idx = "";

            for (int i = 0; i < grdTable1.Items.Count; i++)
            {
                idx = containerDt.Rows[i][0].ToString();
                grdTable1.Items[i].Cells[0].Text = idx;

                cb = grdTable1.Items[i].FindControl("cb_contractNo") as DropDownList;
                bind_cb(cb, contractDt);
                cb.SelectedValue = containerDt.Rows[i]["contractId"].ToString();

                tb = grdTable1.Items[i].FindControl("txt_container") as TextBox;
                tb.Text = containerDt.Rows[i]["containerNo"].ToString();
                tb.Attributes.Add("onchange", $"overlapinit('{i.ToString()}'); return false;");

                //btn = grdTable1.Items[i].FindControl("btn_overlap") as Button;
                //btn.Attributes.Add("onclick", $"container_overlapcheck('{i.ToString()}'); return false;");

                tb = grdTable1.Items[i].FindControl("txt_dispatchdate") as TextBox;
                tb.Text = containerDt.Rows[i]["dispatchDate"].ToString();

                tb = grdTable1.Items[i].FindControl("txt_dispatchtime") as TextBox;
                tb.Text = containerDt.Rows[i]["dispatchTime"].ToString();

                btn = grdTable1.Items[i].FindControl("btn_itemselect") as Button;

                if (km.tran_GetDTa($"SELECT * FROM tb_container_item_temp WHERE containerId = {idx} AND userCode = '{hdn_user.Value}';").Rows.Count > 0)
                {
                    btn.Text = "선택완료";
                    btn.BackColor = Color.Black;
                    btn.ForeColor = Color.White;
                    btn.Attributes.Add("onclick", $"containeritem('{containerDt.Rows[i][0].ToString()}'); return false;");
                }
                else
                {
                    if (hidden_chkUpdate.Value == "1") continue;

                    btn.Text = "제품선택";
                    btn.BackColor = Color.Green;
                    btn.ForeColor = Color.White;
                    btn.Attributes.Add("onclick", $"showcontainer('{i.ToString()}','0'); return false;");
                }

                //if (itemChk == "0" || itemChk == "")
                //{
                //    btn.Text = "제품선택";
                //    btn.BackColor = Color.Green;
                //    btn.ForeColor = Color.White;
                //    btn.Attributes.Add("onclick", $"showcontainer('{i.ToString()}','0'); return false;");
                //}
                //else
                //{
                //    btn.Text = "선택완료";
                //    btn.BackColor = Color.Black;
                //    btn.ForeColor = Color.White;
                //    btn.Attributes.Add("onclick", $"containeritem('{containerDt.Rows[i][0].ToString()}'); return false;");
                //}

                if(hidden_chkUpdate.Value == "1")
                {
                    btn = grdTable1.Items[i].FindControl("btn_correction") as Button;
                    btn.Visible = false;

                    btn = grdTable1.Items[i].FindControl("btn_del") as Button;
                    btn.Visible = false;
                }
                else
                {
                    btn = grdTable1.Items[i].FindControl("btn_correction") as Button;
                    btn.Attributes.Add("onclick", $"showcontainer('{i.ToString()}','1'); return false;");

                    btn = grdTable1.Items[i].FindControl("btn_del") as Button;
                    btn.Attributes.Add("onclick", $"container_delete('{i.ToString()}'); return false;");
                }

                km.dbClose();
            }
        }

        //컨테이너추가
        protected void btn_add_Click(object sender, EventArgs e)
        {
            containerDt = Dt_From_ContainerGrd();

            AutoDecreaseIdx();

            DataRow dr;

            dr = containerDt.NewRow();
            dr["idx"] = hdn_autoDecsIdx.Value;
            dr["cud"] = "c";
            containerDt.Rows.InsertAt(dr, 0);

            Search_ContainerInfo(false);
        }

        //컨테이너 삭제
        protected void btn_container_remover_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            string sql = "";
            int rowIdx = int.Parse(hdn_container_selectedRow.Value);
            string idx = grdTable1.Items[rowIdx].Cells[0].Text;

            km.BeginTran();

            try
            {
                km.tran_ExSQL_Ret($"DELETE FROM tb_container_item_temp WHERE containerId = {idx} AND userCode = '{hdn_user.Value}'");

                containerDt = Dt_From_ContainerGrd();

                containerDt.Rows.RemoveAt(rowIdx);

                km.Commit();
                Search_ContainerInfo(false);
                grdTable2.DataSource = null;
                visiblity.Visible = false;

                Response.Write("<script>alert('삭제되었습니다.');</script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Response.Write("<script>alert('삭제 실패');</script>");
            }
        }

        /*
        //컨테이너명 중복체크
        protected void btn_container_overlap_Click(object sender, EventArgs e)
        {
            int row = int.Parse(hdn_container_selectedRow.Value);
            string containerNo = ((TextBox)grdTable1.Items[row].FindControl("txt_container")).Text;

            if (containerNo == "")
            {
                Response.Write($"<script>alert('컨테이너 번호를 입력해 주십시오.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            string sql = $"SELECT containerNo FROM tb_container_info WHERE containerNo = '{containerNo}';";

            DataTable dt = km.tran_GetDTa(sql);

            if (dt.Rows.Count > 0) // 중복이 있는 경우
            {
                sql = $"SELECT containerNo FROM tb_container_info WHERE containerNo LIKE '%{containerNo}_%' ORDER BY idx DESC;";

                dt = km.tran_GetDTa(sql);

                if(dt.Rows.Count > 0)
                {
                    string temp = containerNo;
                    containerNo = dt.Rows[0][0].ToString();

                    string strNum = containerNo.Substring(containerNo.LastIndexOf("_")).Replace("_","");

                    int num = int.Parse(strNum);

                    containerNo = temp + "_" + (num+1).ToString();
                }
                else
                {
                    containerNo += "_1";
                }

                Response.Write($"<script>alert('{containerNo}으로 대체되었습니다.');</script>");
            }
            else
            {
                Response.Write($"<script>alert('사용가능한 번호입니다.');</script>");
            }

            ((TextBox)grdTable1.Items[row].FindControl("txt_container")).Text = containerNo;
            ((HiddenField)grdTable1.Items[row].FindControl("hdn_overlapchk")).Value = "1";

            km.dbClose();
        }
        */

        //컨테이너Grid DT로 변환
        private DataTable Dt_From_ContainerGrd()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("idx", typeof(string));
            dt.Columns.Add("contractId", typeof(string));
            dt.Columns.Add("containerNo", typeof(string));
            dt.Columns.Add("dispatchDate", typeof(string));
            dt.Columns.Add("dispatchTime", typeof(string));
            dt.Columns.Add("cud", typeof(string));
            DataRow dr;

            for (int i = 0; i < grdTable1.Items.Count; i++)
            {
                dr = dt.NewRow();

                dr["idx"] = grdTable1.Items[i].Cells[0].Text;
                dr["contractId"] = ((DropDownList)grdTable1.Items[i].FindControl("cb_contractNo")).SelectedValue;
                dr["containerNo"] = ((TextBox)grdTable1.Items[i].FindControl("txt_container")).Text;
                dr["dispatchDate"] = ((TextBox)grdTable1.Items[i].FindControl("txt_dispatchdate")).Text;
                dr["dispatchTime"] = ((TextBox)grdTable1.Items[i].FindControl("txt_dispatchtime")).Text;

                dr["cud"] = ((HiddenField)grdTable1.Items[i].FindControl("hdn_cud")).Value;

                dt.Rows.Add(dr);
            }

            return dt;
        }

        private void AutoDecreaseIdx()
        {
            if (hdn_autoDecsIdx.Value == "") hdn_autoDecsIdx.Value = "-1";
            else
            {
                int num = int.Parse(hdn_autoDecsIdx.Value);
                num--;
                hdn_autoDecsIdx.Value = num.ToString();
            }
        }

        #endregion

        #region container_item
        //컨테이너 품목 정보 불러오기-제품선택
        private void Search_Container_Item_FromContract()
        {
            if (km == null) km = new DB_mysql();

            int row = int.Parse(hdn_container_selectedRow.Value);

            //string containerId = grdTable1.Items[row].Cells[0].Text;
            string contractId = ((DropDownList)grdTable1.Items[row].FindControl("cb_contractNo")).SelectedValue;
            string containerId = grdTable1.Items[row].Cells[0].Text;
            object[] objs = { contractId, containerId,hdn_no };

            DataTable dt = PROCEDURE.SELECT("SP_container_item_temp_GetByContract", objs, km);

            grdTable2.DataSource = dt;
            grdTable2.DataBind();

            int rowCount = grdTable2.Items.Count;
            int colCount = grdTable2.Columns.Count;
            int currentWeight = 0;
            TextBox tb;

            for (int i = 0; i < rowCount; i++)
            {
                ((HiddenField)grdTable2.Items[i].FindControl("hdn_itemCode")).Value = dt.Rows[i]["itemCode"].ToString();

                for (int j = 1; j < colCount - 2; j++)
                {
                    if (dt.Rows[i][j].ToString() != "") grdTable2.Items[i].Cells[j].Text = dt.Rows[i][j].ToString();
                }

                tb = ((TextBox)grdTable2.Items[i].FindControl("txt_qty"));
                tb.Text = dt.Rows[i]["resultQty"].ToString();
                tb.Attributes.Add("onchange", $"qtyValidateCheck('{i.ToString()}','{dt.Rows[i]["resultQty"].ToString()}'); calcweight('{i.ToString()}'); return false;");

                ((HiddenField)grdTable2.Items[i].FindControl("hdn_originWeight")).Value = dt.Rows[i]["weight"].ToString();
                ((HiddenField)grdTable2.Items[i].FindControl("hdn_originQty")).Value = dt.Rows[i]["qty"].ToString();

                grdTable2.Items[i].Cells[9].Text = CalcWeight(dt.Rows[i]["resultQty"].ToString() , dt.Rows[i]["qty"].ToString(), dt.Rows[i]["weight"].ToString()) ;
                ((HiddenField)grdTable2.Items[i].FindControl("hdn_currentWeight")).Value = grdTable2.Items[i].Cells[9].Text;
            }
        }

        /*
        //컨테이너 품목 정보 불러오기-선택완료
        private void Search_Container_Item_Selected()
        {
            if (km == null) km = new DB_mysql();

            int row = int.Parse(hdn_container_selectedRow.Value);

            string containerId = grdTable1.Items[row].Cells[0].Text;
            string contractId = ((DropDownList)grdTable1.Items[row].FindControl("cb_contractNo")).SelectedValue;

            object[] objs = { containerId, contractId };

            DataTable dt = PROCEDURE.SELECT("SP_container_item_temp_GetByContainer", objs, km);

            grdTable2.DataSource = dt;
            grdTable2.DataBind();

            int rowCount = grdTable2.Items.Count;
            int colCount = grdTable2.Columns.Count;
            TextBox tb;

            for (int i = 0; i < rowCount; i++)
            {
                ((HiddenField)grdTable2.Items[i].FindControl("hdn_idx")).Value = dt.Rows[i]["idx"].ToString();
                ((HiddenField)grdTable2.Items[i].FindControl("hdn_itemCode")).Value = dt.Rows[i]["itemCode"].ToString();

                for (int j = 1; j < colCount - 2; j++)
                {
                    if (dt.Rows[i][j + 1].ToString() != "") grdTable2.Items[i].Cells[j].Text = dt.Rows[i][j + 1].ToString();
                }

                tb = ((TextBox)grdTable2.Items[i].FindControl("txt_qty"));
                tb.Text = dt.Rows[i]["leftQty"].ToString();
                tb.Attributes.Add("readonly", "readonly");

                tb = ((TextBox)grdTable2.Items[i].FindControl("txt_weight"));
                tb.Text = dt.Rows[i]["weight"].ToString();
                tb.Attributes.Add("readonly", "readonly");
            }
        }
        */

        //컨테이너 품목 정보 불러오기-수정
        private void Search_Container_Item_Update()
        {
            if (km == null) km = new DB_mysql();

            int row = int.Parse(hdn_container_selectedRow.Value);

            string containerId = grdTable1.Items[row].Cells[0].Text;
            string contractId = ((DropDownList)grdTable1.Items[row].FindControl("cb_contractNo")).SelectedValue;
            object[] objs = { contractId, containerId, hdn_no };

            DataTable dt = PROCEDURE.SELECT("SP_container_item_temp_GetCurrentInfo", objs, km);

            grdTable2.DataSource = dt;
            grdTable2.DataBind();

            int rowCount = grdTable2.Items.Count;
            int colCount = grdTable2.Columns.Count;
            TextBox tb;
            int chkCount = 0;

            for (int i = 0; i < rowCount; i++)
            {
                if(dt.Rows[i]["qty"].ToString() != "")
                {
                    ((CheckBox)grdTable2.Items[i].FindControl("chk_item")).Checked = true;
                    chkCount++;
                }
                ((HiddenField)grdTable2.Items[i].FindControl("hdn_idx")).Value = dt.Rows[i]["idx"].ToString();
                ((HiddenField)grdTable2.Items[i].FindControl("hdn_itemCode")).Value = dt.Rows[i]["itemCode"].ToString();

                for (int j = 1; j < colCount - 2; j++)
                {
                    if (dt.Rows[i][j + 1].ToString() != "") grdTable2.Items[i].Cells[j].Text = dt.Rows[i][j + 1].ToString();
                }

                string qty = dt.Rows[i]["qty"].ToString() != "" ? dt.Rows[i]["qty"].ToString() : dt.Rows[i]["resultQty"].ToString();


                tb = ((TextBox)grdTable2.Items[i].FindControl("txt_qty"));
                tb.Text = qty;
                tb.Attributes.Add("onchange", $"qtyValidateCheck('{i.ToString()}','{dt.Rows[i]["resultQty"].ToString()}'); calcweight('{i.ToString()}'); return false;");

                ((HiddenField)grdTable2.Items[i].FindControl("hdn_originWeight")).Value = dt.Rows[i]["weight"].ToString();
                ((HiddenField)grdTable2.Items[i].FindControl("hdn_originQty")).Value = dt.Rows[i]["originQty"].ToString();

                grdTable2.Items[i].Cells[9].Text = CalcWeight(qty, dt.Rows[i]["originQty"].ToString(), dt.Rows[i]["weight"].ToString());
                ((HiddenField)grdTable2.Items[i].FindControl("hdn_currentWeight")).Value = grdTable2.Items[i].Cells[9].Text;
            }

            if (chkCount == rowCount)
            {
                chk_itemAll.Checked = true;
            }
        }

        //현재 중량 계산
        private string CalcWeight(string qty1,string qty2, string weight)
        {
            float iqty1 = float.Parse(qty1);
            float iqty2 = float.Parse(qty2);

            float iweight = float.Parse(weight);

            float currentWeight = iqty1 / iqty2 * iweight;

            return Math.Round(currentWeight,2).ToString();
        }

        // 컨테이너 품목 보기 
        // 0 = 제품선택 <= 계약건에 등록된 품목 중에서 남은수량이 있는 품목들만 보여준다.
        // 1 = 수정 <= 계약건에 등록된 품목 중에서 남은 수량이 있는 품목 & 선택했던 품목들 전부 보여준다.
        protected void btn_container_open_Click(object sender, EventArgs e)
        {
            chk_itemAll.Checked = false;

            if (hdn_container_state.Value == "0") // 제품선택
            {
                Search_Container_Item_FromContract();
            }
            else if (hdn_container_state.Value == "1") // 수정
            {
                int row = int.Parse(hdn_container_selectedRow.Value);
                if(((Button)grdTable1.Items[row].FindControl("btn_itemselect")).Text == "제품선택")
                {
                    Response.Write("<script>alert('제품을 선택해 주십시오.');</script>");
                    return;
                }
                Search_Container_Item_Update();
            }

            visiblity.Visible = true;
        }

        //컨테이너 선택취소
        protected void btn_container_close_Click(object sender, EventArgs e)
        {
            visiblity.Visible = false;
        }

        //컨테이너 품목 저장 - 선택완료
        protected void btn_container_save_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();
            km.BeginTran();

            try
            {
                Container_Item_Add();

                Response.Write("<script>alert('저장되었습니다.');</script>");
                km.Commit();
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
            }

            visiblity.Visible = false;
        }

        //컨테이너 품목 저장
        private void Container_Item_Add()
        {
            int row = int.Parse(hdn_container_selectedRow.Value);

            //컨테이너 먼저 저장후
            string containerIdx = grdTable1.Items[row].Cells[0].Text;
            string contractIdx = ((DropDownList)grdTable1.Items[row].FindControl("cb_contractNo")).SelectedValue;
            string itemSql = "";
            string infoSql = "";

            //컨테이너 품목 저장
            for (int i = 0; i < grdTable2.Items.Count; i++)
            {
                if (((CheckBox)grdTable2.Items[i].FindControl("chk_item")).Checked)
                {
                    itemSql += "CALL SP_container_item_temp_Add(" +
                         $"'{containerIdx}'," +
                         $"'{contractIdx}'," +
                         $"'{((HiddenField)grdTable2.Items[i].FindControl("hdn_itemCode")).Value}'," +
                         $"'{((TextBox)grdTable2.Items[i].FindControl("txt_qty")).Text}'," +
                         $"'{((HiddenField)grdTable2.Items[i].FindControl("hdn_currentWeight")).Value}'," +
                         $"'{hdn_user.Value}');";
                }
            }

            if (hdn_container_state.Value == "1") // 수정 버튼 클릭 시 선택한 컨테이너의 제품을 비워준다
            {
                infoSql = $"DELETE FROM tb_container_item_temp WHERE containerId = {containerIdx} AND userCode = '{hdn_user.Value}';";
            }

            km.tran_ExSQL_Ret(infoSql + itemSql);

            Button btn = grdTable1.Items[row].FindControl("btn_itemselect") as Button;

            if(itemSql != "")
            {
                btn.Text = "선택완료";
                btn.BackColor = Color.Black;
                btn.ForeColor = Color.White;
                btn.Attributes.Add("onclick", $"containeritem('{containerIdx}','{hdn_user.Value}'); return false;");
            }
            else
            {
                btn.Text = "제품선택";
                btn.BackColor = Color.Green;
                btn.ForeColor = Color.White;
                btn.Attributes.Add("onclick", $"showcontainer('{row}','0'); return false;");
            }
        }

        #endregion

        #region 저장
        //모든정보저장
        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (txt_blnum.Text.Trim() == "")
            {
                Response.Write("<script>alert('BL번호를 입력해주십시오.');</script>");
                txt_blnum.Focus();
                return;
            }

            if (km == null) km = new DB_mysql();

            try
            {
                km.BeginTran();

                Save_BL();
                Save_Container();

                object[] objs = { hdn_user };
 
                PROCEDURE.CUD_TRAN("SP_tempTable_Delete", objs, km);

                km.Commit();

                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.self.close();</script>");
            }
            catch(Exception ex)
            {
                id = "";
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                if (ex.Message == "컨테이너 정보 미입력")
                {
                    Response.Write("<script>alert('컨테이너 정보를 입력해주십시오.');</script>");
                }
                else
                {
                    Response.Write("<script>alert('저장 실패.');</script>");
                }
            }
        }

        //BL 정보저장
        private void Save_BL()
        {
            string fileName = "";

            if (hdn_no.Value != "") // 수정
            {
                //기존에있던 컨테이너&제품 정보 삭제
                object[] objs = { hdn_no };
                PROCEDURE.CUD_TRAN("SP_container_DeleteByBLId", objs, km);

                objs = new object[] { hdn_no,txt_blnum,txt_registrationdate,txt_declarationNo, hdn_filePath, txt_qty,txt_weight,txt_etd,txt_eta };

                PROCEDURE.CUD_TRAN("SP_BLinfo_Update", objs, km);

                id = hdn_no.Value;
            }
            else // 추가
            {
                object[] objs = { txt_blnum, txt_registrationdate, txt_declarationNo, hdn_filePath, txt_qty, txt_weight, txt_etd, txt_eta };

                id = PROCEDURE.CUD_ReturnID("SP_BLinfo_Add", objs, km);
            }

            if (hdn_filePath.Value != "")
            {
                fileName = hdn_filePath.Value;

                fileName = hdn_no.Value + fileName.Substring(fileName.LastIndexOf("."));
                if (hdn_no.Value == "") fileName = id + fileName.Substring(fileName.LastIndexOf("."));

                string oldFilePath = HttpContext.Current.Request.PhysicalApplicationPath + hdn_filePath.Value;
                string newFilePath = HttpContext.Current.Request.PhysicalApplicationPath + ConstClass.BL_FILE_PATH + fileName;

                byte[] b2 = File.ReadAllBytes(oldFilePath);

                File.WriteAllBytes(newFilePath, b2);
            }
        }

        //컨테이너정보&품목 저장
        //Temp Table에 있는 데이터 덮어쓰기
        private void Save_Container()
        {
            string sql = "";
            string containerId = "";
            string lastInsertId = "";
            string containerNo = "";
            
            for(int i = 0; i < grdTable1.Items.Count; i++)
            {
                if (((TextBox)grdTable1.Items[i].FindControl("txt_container")).Text == "" || ((Button)grdTable1.Items[i].FindControl("btn_itemselect")).Text == "제품선택")
                {
                    throw new Exception("컨테이너 정보 미입력");
                }

                containerId = grdTable1.Items[i].Cells[0].Text;

                sql = "CALL SP_container_info_Add(" +
                    $"'{((TextBox)grdTable1.Items[i].FindControl("txt_container")).Text}'," +
                    $"'{((DropDownList)grdTable1.Items[i].FindControl("cb_contractNo")).SelectedValue}'," +
                    $"'{id}'," +
                    $"'{((TextBox)grdTable1.Items[i].FindControl("txt_dispatchdate")).Text}'," +
                    $"'{((TextBox)grdTable1.Items[i].FindControl("txt_dispatchtime")).Text}');";

                lastInsertId = km.tran_ExSQL_RetId(sql);

                sql = "SP_container_item_Add(" +
                    $"'{lastInsertId}'," +
                    $"'{containerId}'," +
                    $"'{hdn_user.Value}');";

                km.tran_ExSQL_Ret(sql);
            }
        }
        
        #endregion

        private void Alert(string msg)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", $"alert('{msg}');", true);
        }

        //닫기
        protected void btn_close_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { hdn_user };

            PROCEDURE.CUD("SP_tempTable_Delete", objs, km);

            Response.Write("<script>window.close();</script>");
        }

        //언로드 이벤트
        protected void btn_close_Unload(object sender, EventArgs e)
        {
        }

        //삭제 가능하면 true
        //불가능하면 false
        private bool DeleteCheck()
        {
            return true;
            return false;
        }

        //삭제
        protected void btn_delete_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            km.BeginTran();

            try
            {
                string sql = $"DELETE FROM tb_BLinfo WHERE idx = '{hdn_no.Value}';";

                km.tran_ExSQL_Ret(sql);

                km.Commit();

                Response.Write("<script>alert('삭제되었습니다.');</script>");
                Response.Write("<script> window.opener.refresh();</script>");
                Response.Write("<script> self.close();</script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Response.Write("<script>alert('삭제 실패.');</script>");
            }
        }
    }
}