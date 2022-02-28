using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PublicLibsManagement;
using MysqlLib;

namespace iljin
{
    public partial class popcus : ApplicationRoot
    {
        private DB_mysql km;
        private DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            //Page.MaintainScrollPositionOnPostBack = true;

            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_code.Value = Request.Params.Get("code");
                tb_cusCode.Attributes.Add("readonly", "readonly");

                km.GetCbDT(ConstClass.CUSTOMER_TYPE_CODE, cb_cusType);
                km.GetCbDT(ConstClass.CUSTOMER_PAY_CODE, cb_payMonth);
                km.GetCbDT(ConstClass.CUSTOMER_DECIMAL_CODE, cb_decimal);



                if (hdn_code.Value != "") //수정
                {
                    km.GetCbDT_FromSql("SELECT userCode,empName FROM tb_emp WHERE isUse ='1';", cb_manage, "선택안함");
                    Search_Customer();
                    Search_Manager(true);
                    Search_Address(true);
                }
                else
                {
                    tb_cusCode.Text = PublicLibs.SetCode("tb_customer", "cusCode", ConstClass.CUSTOMER_CODE_PREFIX, km);
                    btn_delete.Visible = false;
                    btn_delete.Enabled = false;
                    km.GetCbDT_FromSql("SELECT userCode,empName FROM tb_emp WHERE isUse ='1';", cb_manage, "선택안함");
                }

            }
        }

        //거래처정보 검색
        private void Search_Customer()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { hdn_code };

            dt = PROCEDURE.SELECT("SP_customer_GetByCode", objs, km);

            cb_cusType.SelectedValue = dt.Rows[0]["cusDivCode"].ToString();
            tb_cusCode.Text = dt.Rows[0]["cusCode"].ToString();
            tb_cusName.Text = dt.Rows[0]["cusName"].ToString();
            tb_ceo.Text = dt.Rows[0]["cusBossName"].ToString();
            tb_tel.Text = dt.Rows[0]["tel"].ToString();
            tb_email.Text = dt.Rows[0]["email"].ToString();
            tb_fax.Text = dt.Rows[0]["fax"].ToString();
            cb_manage.SelectedValue = dt.Rows[0]["empCode"].ToString();
            chk_black.Checked = dt.Rows[0]["isBlack"].ToString() == "1" ? true : false;
            chk_mainCus.Checked = dt.Rows[0]["isMain"].ToString() == "1" ? true : false;
            cb_payMonth.SelectedValue = dt.Rows[0]["payCode"].ToString();
            tb_payDay.Text = dt.Rows[0]["payDay"].ToString();
            tb_registration.Text = dt.Rows[0]["registration"].ToString();
            tb_business.Text = dt.Rows[0]["business"].ToString();
            tb_businessItem.Text = dt.Rows[0]["businessItem"].ToString();
            tb_bankName.Text = dt.Rows[0]["account_bank"].ToString();
            tb_accountHolder.Text = dt.Rows[0]["account_holder"].ToString();
            tb_bankNo.Text = dt.Rows[0]["account_no"].ToString();
            tb_zipCode.Text = dt.Rows[0]["zipcode"].ToString();
            tb_address1.Text = dt.Rows[0]["address1"].ToString();
            tb_address2.Text = dt.Rows[0]["address2"].ToString();
            tb_memo.Text = dt.Rows[0]["memo"].ToString();

            cb_decimal.SelectedValue = dt.Rows[0]["decimalCode"].ToString();
            tb_weight_pet.Text = dt.Rows[0]["weight_pet"].ToString();
            tb_weight_pp.Text = dt.Rows[0]["weight_pp"].ToString();
            tb_weight_al.Text = dt.Rows[0]["weight_al"].ToString();
            tb_weight1.Text = dt.Rows[0]["weight1"].ToString();
            tb_weight2.Text = dt.Rows[0]["weight2"].ToString();
        }

        //담당자정보 검색
        private void Search_Manager(bool isSearch)
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { hdn_code };

            if (isSearch)
            {
                dt = PROCEDURE.SELECT("SP_customer_manager_GetByCusCode", objs, km);
                dt.Columns.Add("cud");
            }

            grdTable_manager.DataSource = dt;
            grdTable_manager.DataBind();

            TextBox tb;

            for (int i = 0; i < grdTable_manager.Items.Count; i++)
            {
                grdTable_manager.Items[i].Cells[0].Text = dt.Rows[i][0].ToString();

                tb = grdTable_manager.Items[i].FindControl("grd_tb_managerName") as TextBox;
                tb.Text = dt.Rows[i]["managerName"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_manager_hdn_cud_{i.ToString()}');");

                tb = grdTable_manager.Items[i].FindControl("grd_tb_class") as TextBox;
                tb.Text = dt.Rows[i]["class"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_manager_hdn_cud_{i.ToString()}');");

                tb = grdTable_manager.Items[i].FindControl("grd_tb_department") as TextBox;
                tb.Text = dt.Rows[i]["department"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_manager_hdn_cud_{i.ToString()}');");

                tb = grdTable_manager.Items[i].FindControl("grd_tb_tel1") as TextBox;
                tb.Text = dt.Rows[i]["tel1"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_manager_hdn_cud_{i.ToString()}');");

                tb = grdTable_manager.Items[i].FindControl("grd_tb_tel2") as TextBox;
                tb.Text = dt.Rows[i]["tel2"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_manager_hdn_cud_{i.ToString()}');");

                tb = grdTable_manager.Items[i].FindControl("grd_tb_email") as TextBox;
                tb.Text = dt.Rows[i]["email"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_manager_hdn_cud_{i.ToString()}');");

                tb = grdTable_manager.Items[i].FindControl("grd_tb_memo") as TextBox;
                tb.Text = dt.Rows[i]["memo"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_manager_hdn_cud_{i.ToString()}');");

                ((Button)grdTable_manager.Items[i].FindControl("grd_btn_delete")).Attributes.Add("onclick", $"delete_manager('{i.ToString()}','{ dt.Rows[i][0].ToString()}');return false;");
                ((HiddenField)grdTable_manager.Items[i].FindControl("hdn_cud")).Value = dt.Rows[i]["cud"].ToString();
            }
        }

        //배송지정보 검색
        private void Search_Address(bool isSearch)
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { hdn_code };

            if (isSearch)
            {
                dt = PROCEDURE.SELECT("SP_customer_address_GetByCusCode", objs, km);
                dt.Columns.Add("cud");
            }

            grdTable_address.DataSource = dt;
            grdTable_address.DataBind();

            TextBox tb;

            for (int i = 0; i < grdTable_address.Items.Count; i++)
            {
                tb = grdTable_address.Items[i].FindControl("tb_address_name") as TextBox;
                tb.Text = dt.Rows[i]["addressName"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_address_hdn_cud_{i.ToString()}');");

                tb = grdTable_address.Items[i].FindControl("tb_address_zipCode") as TextBox;
                tb.Text = dt.Rows[i]["zipCode"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_address_hdn_cud_{i.ToString()}');");

                tb = grdTable_address.Items[i].FindControl("tb_address_1") as TextBox;
                tb.Text = dt.Rows[i]["address1"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_address_hdn_cud_{i.ToString()}');");

                tb = grdTable_address.Items[i].FindControl("tb_address_2") as TextBox;
                tb.Text = dt.Rows[i]["address2"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_address_hdn_cud_{i.ToString()}');");

                tb = grdTable_address.Items[i].FindControl("tb_address_tel") as TextBox;
                tb.Text = dt.Rows[i]["tel"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_address_hdn_cud_{i.ToString()}');");

                tb = grdTable_address.Items[i].FindControl("tb_address_memo") as TextBox;
                tb.Text = dt.Rows[i]["memo"].ToString();
                tb.Attributes.Add("onchange", $"change_cud('grdTable_address_hdn_cud_{i.ToString()}');");

                ((Button)grdTable_address.Items[i].FindControl("btn_delete_address")).Attributes.Add("onclick", $"delete_address('{i.ToString()}','{dt.Rows[i]["idx"].ToString()}'); return false;");
                ((Button)grdTable_address.Items[i].FindControl("btn_find_address")).Attributes.Add("onclick", $"OpenZipcode('{i.ToString()}'); return false;");
                ((HiddenField)grdTable_address.Items[i].FindControl("hdn_cud")).Value = dt.Rows[i]["cud"].ToString();
                ((HiddenField)grdTable_address.Items[i].FindControl("hdn_idx")).Value = dt.Rows[i]["idx"].ToString();
            }
        }

        //담당자 추가
        protected void btn_add_manager_Click(object sender, EventArgs e)
        {
            dt = Dt_From_ManagerGrd();

            DataRow dr;

            dr = dt.NewRow();
            dr["cud"] = "c";
            dt.Rows.InsertAt(dr, 0);

            Search_Manager(false);
        }

        //배송지 추가
        protected void btn_add_address_Click(object sender, EventArgs e)
        {
            dt = Dt_From_AddressGrd();

            DataRow dr;

            dr = dt.NewRow();
            dr["cud"] = "c";
            dt.Rows.InsertAt(dr, 0);

            Search_Address(false);
        }

        //담당자 삭제
        protected void btn_manager_remover_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            string sql = "";
            int rowIdx = int.Parse(hdn_delete_row.Value);
            string idx = grdTable_manager.Items[rowIdx].Cells[0].Text;
            km.BeginTran();

            try
            {
                //불러온 데이터인 경우
                if (idx != "")
                {
                    object[] objs = { idx };

                    PROCEDURE.CUD_TRAN("SP_customer_manager_Delete", objs, km);
                }

                dt = Dt_From_ManagerGrd();

                dt.Rows.RemoveAt(rowIdx);

                km.Commit();
                Search_Manager(false);
                Alert("삭제되었습니다.");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Alert("삭제실패.");
            }
        }

        //배송지 삭제
        protected void btn_address_remover_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            string sql = "";
            int rowIdx = int.Parse(hdn_delete_row.Value);
            string idx = ((HiddenField)grdTable_address.Items[rowIdx].FindControl("hdn_idx")).Value;

            km.BeginTran();

            try
            {
                //불러온 데이터인 경우
                if (idx != "")
                {
                    object[] objs = { idx };

                    PROCEDURE.CUD_TRAN("SP_customer_address_Delete", objs, km);
                }

                dt = Dt_From_AddressGrd();

                dt.Rows.RemoveAt(rowIdx);

                km.Commit();
                Search_Address(false);
                Alert("삭제되었습니다.");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Alert("삭제실패.");
            }
        }

        //담당자Grid DT로 변환
        private DataTable Dt_From_ManagerGrd()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("idx", typeof(string));
            dt.Columns.Add("managerName", typeof(string));
            dt.Columns.Add("class", typeof(string));
            dt.Columns.Add("department", typeof(string));
            dt.Columns.Add("tel1", typeof(string));
            dt.Columns.Add("tel2", typeof(string));
            dt.Columns.Add("email", typeof(string));
            dt.Columns.Add("memo", typeof(string));
            dt.Columns.Add("cud", typeof(string));


            DataRow dr;

            for (int i = 0; i < grdTable_manager.Items.Count; i++)
            {
                dr = dt.NewRow();

                dr["idx"] = grdTable_manager.Items[i].Cells[0].Text;
                dr["managerName"] = ((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_managerName")).Text;
                dr["class"] = ((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_class")).Text;
                dr["department"] = ((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_department")).Text;
                dr["tel1"] = ((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_tel1")).Text;
                dr["tel2"] = ((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_tel2")).Text;
                dr["email"] = ((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_email")).Text;
                dr["memo"] = ((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_memo")).Text;

                dr["cud"] = ((HiddenField)grdTable_manager.Items[i].FindControl("hdn_cud")).Value;

                dt.Rows.Add(dr);
            }

            return dt;
        }

        //배송지Grid DT로 변환
        private DataTable Dt_From_AddressGrd()
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("idx", typeof(string));
            dt.Columns.Add("addressName", typeof(string));
            dt.Columns.Add("zipCode", typeof(string));
            dt.Columns.Add("address1", typeof(string));
            dt.Columns.Add("address2", typeof(string));
            dt.Columns.Add("tel", typeof(string));
            dt.Columns.Add("memo", typeof(string));
            dt.Columns.Add("cud", typeof(string));

            DataRow dr;

            for (int i = 0; i < grdTable_address.Items.Count; i++)
            {
                dr = dt.NewRow();

                dr["addressName"] = ((TextBox)grdTable_address.Items[i].FindControl("tb_address_name")).Text;
                dr["zipCode"] = ((TextBox)grdTable_address.Items[i].FindControl("tb_address_zipCode")).Text;
                dr["address1"] = ((TextBox)grdTable_address.Items[i].FindControl("tb_address_1")).Text;
                dr["address2"] = ((TextBox)grdTable_address.Items[i].FindControl("tb_address_2")).Text;
                dr["tel"] = ((TextBox)grdTable_address.Items[i].FindControl("tb_address_tel")).Text;
                dr["memo"] = ((TextBox)grdTable_address.Items[i].FindControl("tb_address_memo")).Text;

                dr["cud"] = ((HiddenField)grdTable_address.Items[i].FindControl("hdn_cud")).Value;
                dr["idx"] = ((HiddenField)grdTable_address.Items[i].FindControl("hdn_idx")).Value;

                dt.Rows.Add(dr);
            }

            return dt;
        }

        //전부 저장
        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (tb_cusName.Text.Trim() == "")
            {
                Response.Write("<script>alert('거래처명을 입력해 주십시오.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            km.BeginTran();

            try
            {
                Save_Customer();
                Save_Manager();
                Save_Address();
                km.Commit();

                Response.Write("<script>alert('저장되었습니다.'); </script>");
                Response.Write("<script>window.opener.refresh(); </script>");
                Response.Write("<script>window.close(); </script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                if (ex.Message == "manageNameEmpty")
                {
                    Response.Write("<script>alert('담당자명을 입력해 주십시오.');</script>");
                }
                else if (ex.Message == "addressNameEmpty")
                {
                    Response.Write("<script>alert('배송지명을 입력해 주십시오.');</script>");
                }
                else
                {
                    Response.Write("<script>alert('저장 실패.');</script>");
                }
            }
        }

        //거래처 저장
        private void Save_Customer()
        {
            string pet = tb_weight_pet.Text.Trim() == "" ? "1.4" : tb_weight_pet.Text;
            string pp = tb_weight_pp.Text.Trim() == "" ? "0.91" : tb_weight_pp.Text;
            string al = tb_weight_al.Text.Trim() == "" ? "2.71" : tb_weight_al.Text;

            if (hdn_code.Value != "") //수정
            {
                object[] objs = { hdn_code,tb_cusName,cb_cusType,tb_ceo,tb_tel,tb_email,tb_fax,cb_manage,chk_black,chk_mainCus,
                                      cb_payMonth,tb_payDay,tb_registration,tb_business,tb_businessItem,tb_bankName,tb_accountHolder,
                                      tb_bankNo,tb_zipCode,tb_address1,tb_address2,tb_memo,cb_decimal,pet,pp,al,tb_weight1,tb_weight2};

                PROCEDURE.CUD_TRAN("SP_customer_Update", objs, km);
            }
            else //추가
            {
                hdn_code.Value = PublicLibs.SetCode_Tran("tb_customer", "cusCode", ConstClass.CUSTOMER_CODE_PREFIX, km);

                object[] objs = { hdn_code,tb_cusName,cb_cusType,tb_ceo,tb_tel,tb_email,tb_fax,cb_manage,chk_black,chk_mainCus,
                                      cb_payMonth,tb_payDay,tb_registration,tb_business,tb_businessItem,tb_bankName,tb_accountHolder,
                                      tb_bankNo,tb_zipCode,tb_address1,tb_address2,tb_memo,cb_decimal,pet,pp,al,tb_weight1,tb_weight2};

                PROCEDURE.CUD_TRAN("SP_customer_Add", objs, km);
            }

        }

        //담당자 저장
        private void Save_Manager()
        {
            string sql = "";

            for (int i = 0; i < grdTable_manager.Items.Count; i++)
            {
                string cud = ((HiddenField)grdTable_manager.Items[i].FindControl("hdn_cud")).Value;

                if (cud == "c") //추가
                {
                    if (((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_managerName")).Text == "")
                    {
                        throw new Exception("manageNameEmpty");
                    }

                    sql += $"CALL SP_customer_manager_Add('{hdn_code.Value}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_managerName")).Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_class")).Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_department")).Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_tel1")).Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_tel2")).Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_email")).Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_memo")).Text}');";
                }
                else if (cud == "u") //수정
                {
                    sql += $"CALL SP_customer_manager_Update('{grdTable_manager.Items[i].Cells[0].Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_managerName")).Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_class")).Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_department")).Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_tel1")).Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_tel2")).Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_email")).Text}'," +
                        $"'{((TextBox)grdTable_manager.Items[i].FindControl("grd_tb_memo")).Text}');";
                }
            }

            if (sql != "")
            {
                km.tran_ExSQL_Ret(sql);
            }
        }

        //배송지 저장
        private void Save_Address()
        {
            string sql = "";

            for (int i = 0; i < grdTable_address.Items.Count; i++)
            {
                string cud = ((HiddenField)grdTable_address.Items[i].FindControl("hdn_cud")).Value;

                if (cud == "c") //추가
                {
                    if (((TextBox)grdTable_address.Items[i].FindControl("tb_address_name")).Text == "")
                    {
                        throw new Exception("addressNameEmpty");
                    }

                    sql += $"CALL SP_customer_address_Add('{hdn_code.Value}'," +
                        $"'{((TextBox)grdTable_address.Items[i].FindControl("tb_address_name")).Text}'," +
                        $"'{((TextBox)grdTable_address.Items[i].FindControl("tb_address_zipCode")).Text}'," +
                        $"'{((TextBox)grdTable_address.Items[i].FindControl("tb_address_1")).Text}'," +
                        $"'{((TextBox)grdTable_address.Items[i].FindControl("tb_address_2")).Text}'," +
                        $"'{((TextBox)grdTable_address.Items[i].FindControl("tb_address_tel")).Text}'," +
                        $"'{((TextBox)grdTable_address.Items[i].FindControl("tb_address_memo")).Text}');";
                }
                else if (cud == "u") //수정
                {
                    sql += $"CALL SP_customer_address_Update('{((HiddenField)grdTable_address.Items[i].FindControl("hdn_idx")).Value}'," +
                        $"'{((TextBox)grdTable_address.Items[i].FindControl("tb_address_name")).Text}'," +
                        $"'{((TextBox)grdTable_address.Items[i].FindControl("tb_address_zipCode")).Text}'," +
                        $"'{((TextBox)grdTable_address.Items[i].FindControl("tb_address_1")).Text}'," +
                        $"'{((TextBox)grdTable_address.Items[i].FindControl("tb_address_2")).Text}'," +
                        $"'{((TextBox)grdTable_address.Items[i].FindControl("tb_address_tel")).Text}'," +
                        $"'{((TextBox)grdTable_address.Items[i].FindControl("tb_address_memo")).Text}');";
                }
            }

            if (sql != "")
            {
                km.tran_ExSQL_Ret(sql);
            }
        }

        //거래처 삭제
        protected void btn_delete_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            km.BeginTran();

            try
            {
                object[] objs = { hdn_code };

                PROCEDURE.CUD_TRAN("SP_customer_Delete", objs, km);

                km.Commit();
                Response.Write("<script>alert('삭제되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh(); window.self.close(); </script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Response.Write("<script>alert('삭제 실패.');</script>");
            }
        }

        private void Alert(string msg)
        {
            ScriptManager.RegisterClientScriptBlock(this.Page, this.Page.GetType(), "alert", $"alert('{msg}');", true);
        }
    }
}