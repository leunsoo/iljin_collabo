using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MysqlLib;
using PublicLibsManagement;
using les;

namespace iljin.popUp
{
    public partial class poporder : ApplicationRoot
    {
        DB_mysql km;
        DataTable Mdt;

        string[] fieldArr = { "idx", "releaseIdx", "none1", "hidden_keyword1", "virtualItemName", "virtualItemCode", "hidden_keyword2", "actualItemName", "actualItemCode", "unit", "leftQty", "qty", "totalWeight", "weight", "unitprice", "taxFree", "none2", "cud" };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_value.Value = Request.Params.Get("code");
                km.GetCbDT_FromSql("SELECT cusCode,cusName FROM tb_customer WHERE cusDivCode = 'C0001_02' ORDER BY cusCode ASC;", cb_cusname, "선택");

                txt_supplyprice.Attributes.Add("readonly", "readonly");
                txt_vat.Attributes.Add("readonly", "readonly");
                txt_totalWeight.Attributes.Add("readonly", "readonly");
                txt_totalamount.Attributes.Add("readonly", "readonly");

                if (hdn_value.Value != "") //수정
                {
                    Search_Info();
                    Search_Item(true);
                }
                else
                {
                    txt_ordernum.Text = Tool_DB.SetCode("tb_order_master", "orderCode", ConstClass.ORDER_CODE_PREFIX, km);

                    txt_orderdate.Text = DateTime.Now.ToString("yyyy-MM-dd");
                }
            }
        }

        //기본정보 검색
        private void Search_Info()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_order_master_GetByCode", hdn_value.Value, km);

            txt_ordernum.Text = dt.Rows[0]["orderCode"].ToString();
            txt_orderdate.Text = dt.Rows[0]["orderDate"].ToString();
            txt_deliverydate.Text = dt.Rows[0]["deliveryDate"].ToString();
            chk_morning.Checked = dt.Rows[0]["isMorning"].ToString() == "0" ? false : true;

            string cusCode = cb_cusname.SelectedValue = dt.Rows[0]["cusCode"].ToString();

            CusInfoSetting(cusCode);
            cb_manager_Setting(cusCode);
            cb_address_Setting(cusCode);

            txt_bosscall.Text = dt.Rows[0]["tel"].ToString();
            txt_bossmail.Text = dt.Rows[0]["email"].ToString();
            txt_fax.Text = dt.Rows[0]["fax"].ToString();
            cb_manager.SelectedValue = dt.Rows[0]["manager"].ToString();
            cb_address.SelectedValue = dt.Rows[0]["address"].ToString();
            chk_taxbill.Checked = dt.Rows[0]["isShowPrice"].ToString() == "0" ? false : true;
            txt_memo.Text = dt.Rows[0]["memo"].ToString();
            string price = txt_supplyprice.Text = dt.Rows[0]["price"].ToString();
            string vat = txt_vat.Text = dt.Rows[0]["vat"].ToString();

            int iPrice = price == "" ? 0 : int.Parse(price);
            int iVat = vat == "" ? 0 : int.Parse(vat);

            txt_totalamount.Text = (iPrice + iVat).ToString();
        }

        //주문품목 검색
        private void Search_Item(bool isSearch)
        {
            if (km == null) km = new DB_mysql();

            if (isSearch)
            {
                Mdt = PROCEDURE.SELECT("SP_order_detail_GetByCode", hdn_value.Value, km);
                Mdt.Columns.Add("cud");
                Mdt.Columns.Add("hidden_keyword1");
                Mdt.Columns.Add("hidden_keyword2");
            }

            grdTable.DataSource = Mdt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;
            int qty = 0;
            int totalPrice = 0;
            float weight = 0;
            float unitprice = 0;

            int sumTotalPrice = 0;
            float sumTotalWeight = 0;

            TextBox tb;

            for (int i = 0; i < rowCount; i++)
            {
                grdTable.Items[i].Cells[0].Text = Mdt.Rows[i]["idx"].ToString();
                grdTable.Items[i].Cells[1].Text = Mdt.Rows[i]["releaseIdx"].ToString();

                grdTable.Items[i].Cells[2].Text = Mdt.Rows[i]["virtualItemCode"].ToString();
                tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_itemName"));
                tb.Text = Mdt.Rows[i]["virtualItemName"].ToString();
                tb.Attributes.Add("onkeypress", $"KeyPressEvent('{i.ToString()}');");
                tb.Attributes.Add("onkeydown", $"KeyDownEvent('{i.ToString()}');");
                tb.Attributes.Add("onclick", $"visibleChk('{i.ToString()}','1');");

                string itemCode = Mdt.Rows[i]["virtualItemCode"].ToString();


                ((HiddenField)grdTable.Items[i].FindControl("grd_hdn_virtualItemCode")).Value = itemCode;

                //기존에 제품이 선택되어있던 row
                if (itemCode != "")
                {
                    tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_itemName2"));
                    tb.Text = Mdt.Rows[i]["actualItemName"].ToString();
                    tb.Attributes.Add("onkeypress", $"KeyPressEvent('{i.ToString()}');");
                    tb.Attributes.Add("onkeydown", $"KeyDownEvent('{i.ToString()}');");
                    tb.Attributes.Add("onclick", $"visibleChk('{i.ToString()}','2');");
                    ((HiddenField)grdTable.Items[i].FindControl("grd_hdn_actualItemCode")).Value = Mdt.Rows[i]["actualItemCode"].ToString();

                    grdTable.Items[i].Cells[5].Text = Mdt.Rows[i]["unit"].ToString();
                    grdTable.Items[i].Cells[6].Text = Mdt.Rows[i]["leftQty"].ToString();

                    tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_orderQty"));
                    tb.Text = Mdt.Rows[i]["qty"].ToString();
                    qty = tb.Text == "" ? 0 : int.Parse(tb.Text);
                    tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}'); calcweight('{i.ToString()}'); calcTotalPrice('{i.ToString()}');");

                    if (isSearch)
                    {
                        ((HiddenField)grdTable.Items[i].FindControl("hdn_weight")).Value = Mdt.Rows[i]["weight"].ToString();
                        weight = Mdt.Rows[i]["totalWeight"].ToString() == "" ? 0 : float.Parse(Mdt.Rows[i]["totalWeight"].ToString());
                        tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_totalWeight"));
                        tb.Text = weight.ToString();
                        tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}'); calcTotalPrice('{i.ToString()}');");
                    }
                    else
                    {
                        ((HiddenField)grdTable.Items[i].FindControl("hdn_weight")).Value = Mdt.Rows[i]["weight"].ToString();
                        weight = Mdt.Rows[i]["totalWeight"].ToString() == "" ? 0 : float.Parse(Mdt.Rows[i]["totalWeight"].ToString());
                        tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_totalWeight"));
                        tb.Text = weight.ToString();
                        tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}'); calcTotalPrice('{i.ToString()}');");
                    }
                    sumTotalWeight += weight;
                    //tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_weight"));
                    //tb.Text = Mdt.Rows[i]["weight"].ToString();
                    //tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}'); calcTotalPrice('{i.ToString()}');");

                    tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_unitprice"));
                    tb.Text = Mdt.Rows[i]["unitprice"].ToString();
                    tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}'); calcTotalPrice('{i.ToString()}');");
                    unitprice = tb.Text == "" ? 0 : float.Parse(tb.Text);

                    ((CheckBox)grdTable.Items[i].FindControl("chk_taxFree")).Checked = Mdt.Rows[i]["taxFree"].ToString() == "1" ? true : false;

                    totalPrice = (int)(Math.Round(weight * unitprice, 2));
                    sumTotalPrice += totalPrice;
                    grdTable.Items[i].Cells[10].Text = totalPrice.ToString();
                }
                else // 기존에 제품이 선택되지 않은 row
                {
                    tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_itemName2"));
                    tb.Text = "";
                    tb.Attributes.Add("onkeypress", $"KeyPressEvent('{i.ToString()}');");
                    tb.Attributes.Add("onkeydown", $"KeyDownEvent('{i.ToString()}');");
                    tb.Attributes.Add("onclick", $"visibleChk('{i.ToString()}','2');");
                    ((HiddenField)grdTable.Items[i].FindControl("grd_hdn_actualItemCode")).Value = "";

                    grdTable.Items[i].Cells[5].Text = "";
                    grdTable.Items[i].Cells[6].Text = "";

                    tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_orderQty"));
                    tb.Text = "";
                    qty = tb.Text == "" ? 0 : int.Parse(tb.Text);
                    tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}'); calcweight('{i.ToString()}'); calcTotalPrice('{i.ToString()}');");

                    if (isSearch)
                    {
                        ((HiddenField)grdTable.Items[i].FindControl("hdn_weight")).Value = "";
                        weight = Mdt.Rows[i]["weight"].ToString() == "" ? 0 : qty * float.Parse(Mdt.Rows[i]["weight"].ToString());
                        tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_totalWeight"));
                        tb.Text = weight.ToString();
                        tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}'); calcTotalPrice('{i.ToString()}');");
                    }
                    else
                    {
                        string sWeight = ((HiddenField)grdTable.Items[i].FindControl("hdn_weight")).Value = "";
                        weight = sWeight == "" ? 0 : qty * float.Parse(sWeight);
                        tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_totalWeight"));
                        tb.Text = weight.ToString();
                        tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}'); calcTotalPrice('{i.ToString()}');");
                    }
                    sumTotalWeight += weight;
                    //tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_weight"));
                    //tb.Text = Mdt.Rows[i]["weight"].ToString();
                    //tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}'); calcTotalPrice('{i.ToString()}');");

                    tb = ((TextBox)grdTable.Items[i].FindControl("grd_txt_unitprice"));
                    tb.Text = "";
                    tb.Attributes.Add("onchange", $"change_cud('{i.ToString()}'); calcTotalPrice('{i.ToString()}');");
                    unitprice = tb.Text == "" ? 0 : float.Parse(tb.Text);

                    ((CheckBox)grdTable.Items[i].FindControl("chk_taxFree")).Checked = Mdt.Rows[i]["taxFree"].ToString() == "1" ? true : false;

                    totalPrice = (int)(Math.Round(weight * unitprice, 2));
                    sumTotalPrice += totalPrice;
                    grdTable.Items[i].Cells[10].Text = totalPrice.ToString();
                }

                ((Button)grdTable.Items[i].FindControl("grd_btn_del")).Attributes.Add("onclick", $"deleteRow('{i.ToString()}'); return false;");
                ((HiddenField)grdTable.Items[i].FindControl("hdn_cud")).Value = Mdt.Rows[i]["cud"].ToString();

                ((HiddenField)grdTable.Items[i].FindControl("hidden_keyWord1")).Value = Mdt.Rows[i]["hidden_keyWord1"].ToString();
                ((HiddenField)grdTable.Items[i].FindControl("hidden_keyWord2")).Value = Mdt.Rows[i]["hidden_keyWord2"].ToString();
            }

            txt_totalamount.Text = sumTotalPrice.ToString();
            txt_totalWeight.Text = sumTotalWeight.ToString();

            float supplyPrice = sumTotalPrice / 1.1f;
            txt_supplyprice.Text = Math.Round(supplyPrice).ToString();
            txt_vat.Text = Math.Round((supplyPrice * 0.1f)).ToString();
        }

        //품목추가
        protected void tb_itemadd_Click(object sender, EventArgs e)
        {
            Mdt = les_DataGridSystem.Get_Dt_From_DataGrid(grdTable, fieldArr);

            DataRow dr = Mdt.NewRow();
            dr["cud"] = "c";

            Mdt.Rows.InsertAt(dr, 0);

            Search_Item(false);
        }

        //저장
        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (cb_cusname.SelectedValue == "")
            {
                Response.Write("<script>alert('거래처를 선택해 주십시오.');</script>");
                return;
            }

            if (txt_deliverydate.Text.Trim() == "")
            {
                Response.Write("<script>alert('납기일을 입력해 주십시오.');</script>");
                return;
            }

            int rCount = grdTable.Items.Count;

            if (rCount == 0)
            {
                Response.Write("<script>alert('제품을 등록해 주십시오.');</script>");
                return;
            }

            for (int i = 0; i < rCount; i++)
            {
                if (((HiddenField)grdTable.Items[i].FindControl("grd_hdn_virtualItemCode")).Value == ""
                    ||
                    ((HiddenField)grdTable.Items[i].FindControl("grd_hdn_actualItemCode")).Value == "")
                {
                    Response.Write("<script>alert('제품을 선택해 주십시오.');</script>");
                    return;
                }
            }

            if (km == null) km = new DB_mysql();

            km.BeginTran();

            try
            {
                string no = Tool_DB.SetCode_Tran("tb_order_master", "orderCode", ConstClass.ORDER_CODE_PREFIX, km);
                Save_Info(no);
                Save_Item(no);

                km.Commit();
                Response.Write("<script>alert('저장되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.self.close();</script>");

            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);
                Response.Write("<script>alert('저장 실패');</script>");
            }
        }

        private void Save_Info(string no)
        {
            if (hdn_value.Value != "") //수정
            {
                object[] objs = { txt_ordernum,txt_orderdate,txt_deliverydate,chk_morning,cb_cusname,cb_manager,cb_address,
                chk_taxbill,txt_memo,txt_supplyprice,txt_vat};
                PROCEDURE.CUD_TRAN("SP_order_master_Update", objs, km);
            }
            else
            {
                object[] objs = { no,txt_orderdate,txt_deliverydate,chk_morning,cb_cusname,cb_manager,cb_address,
                chk_taxbill,txt_memo,txt_supplyprice,txt_vat};
                PROCEDURE.CUD_TRAN("SP_order_master_Add", objs, km);
            }
        }

        private void Save_Item(string no)
        {
            int rCount = grdTable.Items.Count;
            int cCount = grdTable.Columns.Count;
            string sql = "";
            if (hdn_value.Value != "") no = hdn_value.Value;

            for (int i = 0; i < rCount; i++)
            {
                string chkValue = ((CheckBox)grdTable.Items[i].FindControl("chk_taxFree")).Checked ? "1" : "0";

                string cud = ((HiddenField)grdTable.Items[i].FindControl("hdn_cud")).Value;
                if (cud == "c") //저장
                {
                    sql += $"CALL SP_order_detail_Add('{no}'" +
                          $",'{((HiddenField)grdTable.Items[i].FindControl("grd_hdn_virtualItemCode")).Value}'" +
                          $",'{((HiddenField)grdTable.Items[i].FindControl("grd_hdn_actualItemCode")).Value}'" +
                          $",'{((TextBox)grdTable.Items[i].FindControl("grd_txt_orderQty")).Text}'" +
                          $",'{((HiddenField)grdTable.Items[i].FindControl("hdn_weight")).Value}'" +
                          $",'{((TextBox)grdTable.Items[i].FindControl("grd_txt_totalWeight")).Text}'" +
                          $",'{((TextBox)grdTable.Items[i].FindControl("grd_txt_unitprice")).Text}'" +
                          $",'{chkValue}');";

                    sql += $"CALL SP_warehousing_release_Add(" +
                          $"'{((HiddenField)grdTable.Items[i].FindControl("grd_hdn_actualItemCode")).Value}'" +
                          $",'{cb_cusname.SelectedValue}'" +
                          $",'{((TextBox)grdTable.Items[i].FindControl("grd_txt_orderQty")).Text}'" +
                          $",'{no}');";
                }
                else if (cud == "u") //수정
                {
                    sql += $"CALL SP_order_detail_Update('{grdTable.Items[i].Cells[0].Text}'" +
                          $",'{((HiddenField)grdTable.Items[i].FindControl("grd_hdn_virtualItemCode")).Value}'" +
                          $",'{((HiddenField)grdTable.Items[i].FindControl("grd_hdn_actualItemCode")).Value}'" +
                          $",'{((TextBox)grdTable.Items[i].FindControl("grd_txt_orderQty")).Text}'" +
                          $",'{((HiddenField)grdTable.Items[i].FindControl("hdn_weight")).Value}'" +
                          $",'{((TextBox)grdTable.Items[i].FindControl("grd_txt_totalWeight")).Text}'" +
                          $",'{((TextBox)grdTable.Items[i].FindControl("grd_txt_unitprice")).Text}'" +
                          $",'{chkValue}');";

                    sql += $"CALL SP_warehousing_release_Update('{grdTable.Items[i].Cells[1].Text}'" +
                          $",'{((HiddenField)grdTable.Items[i].FindControl("grd_hdn_actualItemCode")).Value}'" +
                          $",'{((TextBox)grdTable.Items[i].FindControl("grd_txt_orderQty")).Text}');";
                }
            }

            if (hidden_deleteIdx.Value != "")
            {
                string delete = hidden_deleteIdx.Value.Substring(1);
                sql += $"DELETE FROM tb_order_detail WHERE idx IN ('{delete}');";
            }

            if (sql != "")
            {
                km.tran_ExSQL_Ret(sql);
            }
        }

        //삭제
        protected void btn_delete_Click(object sender, EventArgs e)
        {
            int row = int.Parse(hidden_selectedRow.Value);

            string idx = grdTable.Items[row].Cells[0].Text;

            //DB에서 불러온 data일 경우
            if (idx != "")
            {
                hidden_deleteIdx.Value += "," + idx;
            }

            Mdt = les_DataGridSystem.Get_Dt_From_DataGrid(grdTable, fieldArr);

            Mdt.Rows.RemoveAt(int.Parse(hidden_selectedRow.Value));

            Search_Item(false);
        }

        //거래처명 change
        protected void cb_cusname_SelectedIndexChanged(object sender, EventArgs e)
        {
            string cusCode = cb_cusname.SelectedValue;

            if (cusCode == "")
            {
                txt_memo.Text = "";
                cb_address.Items.Clear();
                cb_manager.Items.Clear();
                GridItemInit();
                return;
            }

            CusInfoSetting(cusCode);
            cb_manager_Setting(cusCode);
            cb_address_Setting(cusCode);
            cb_address_SelectedIndexChanged(null, null);
            GridItemInit();
        }

        //거래처 선택시 그리드 비워주고
        //기존에 DB에서 가져온 제품들은 Delete하기 위해 idx저장
        private void GridItemInit()
        {
            string releaseIdx = "";
            for (int i = 0; i < grdTable.Items.Count; i++)
            {
                releaseIdx = grdTable.Items[i].Cells[1].Text;
                if (releaseIdx != "")
                {
                    hidden_deleteIdx.Value += "," + releaseIdx;
                }
            }

            grdTable.DataSource = null;
            grdTable.DataBind();
        }

        //거래처 선택시 정보 Set
        private void CusInfoSetting(string cusCode)
        {
            if (km == null) km = new DB_mysql();
            DataTable dt = km.GetDTa($"SELECT a.tel,a.email,a.fax,a.weight_pet,a.weight_pp,a.weight_al,b.code_name FROM tb_customer a " +
                                     $"LEFT OUTER JOIN tb_code b ON a.decimalCode = b.code_id " +
                                     $"WHERE a.cusCode = '{cusCode}';");

            txt_bosscall.Text = dt.Rows[0][0].ToString();
            txt_bossmail.Text = dt.Rows[0][1].ToString();
            txt_fax.Text = dt.Rows[0][2].ToString();
            hidden_weight_Pet.Value = dt.Rows[0][3].ToString();
            hidden_weight_Pp.Value = dt.Rows[0][4].ToString();
            hidden_weight_Al.Value = dt.Rows[0][5].ToString();
            hidden_cus_Decimal.Value = dt.Rows[0][6].ToString();
        }

        //선택한 거래처에 따른 manager Set
        private void cb_manager_Setting(string cusCode)
        {
            if (km == null) km = new DB_mysql();
            km.GetCbDT_FromSql($"SELECT idx,managerName FROM tb_customer_manager WHERE cusCode = '{cusCode}' ORDER BY idx ASC;", cb_manager);
        }

        //선택한 거래처에 따른 배송지 Set
        private void cb_address_Setting(string cusCode)
        {
            if (km == null) km = new DB_mysql();
            km.GetCbDT_FromSql($"SELECT idx,addressName FROM tb_customer_address WHERE cusCode = '{cusCode}' ORDER BY idx ASC;", cb_address);
        }

        //배송지 선택 시 참고사항 변경
        protected void cb_address_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();
            string addr = "";
            string tel = "";

            DataTable dt = km.GetDTa($"SELECT addressName,address1,tel FROM tb_customer_address WHERE idx = '{cb_address.SelectedValue}'");

            if (dt.Rows.Count < 1)
            {
                txt_memo.Text = "";
                return;
            }

            txt_memo.Text = dt.Rows[0][0].ToString() + " : " + dt.Rows[0][1].ToString() + ", " + dt.Rows[0][2].ToString();
        }

        //제품선택후 정보 불러오기(제품명 선택시, 실제품명은 x)
        protected void btn_itemInfoSetting_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            int row = int.Parse(hidden_selectedRow.Value);
            string itemCode = ((HiddenField)grdTable.Items[row].FindControl("grd_hdn_virtualItemCode")).Value;

            if (itemCode == "") return;

            string sql = "SELECT a.itemCode,a.fullName,b.code_name,c.qty,a.unitprice,thickness,width,length,weight FROM tb_item a " +
                         "LEFT OUTER JOIN tb_code b ON a.unitCode = b.code_id " +
                         "LEFT OUTER JOIN tb_inventory c ON a.itemCode = c.itemCode " +
                         $"WHERE a.itemCode = '{itemCode}'";

            DataTable dt = km.GetDTa(sql);

            grdTable.Items[row].Cells[2].Text = dt.Rows[0][0].ToString();   //제품코드
            string itemName = ((TextBox)grdTable.Items[row].FindControl("grd_txt_itemName")).Text = dt.Rows[0][1].ToString();  //제품명

            ((TextBox)grdTable.Items[row].FindControl("grd_txt_itemName2")).Text = itemName;
            ((HiddenField)grdTable.Items[row].FindControl("grd_hdn_actualItemCode")).Value = dt.Rows[0][0].ToString();

            grdTable.Items[row].Cells[5].Text = dt.Rows[0][2].ToString();  //단위
            grdTable.Items[row].Cells[6].Text = dt.Rows[0][3].ToString();  //재고
            ((TextBox)grdTable.Items[row].FindControl("grd_txt_orderQty")).Text = "1";  //주문수량
            ((TextBox)grdTable.Items[row].FindControl("grd_txt_unitprice")).Text = dt.Rows[0][4].ToString();  //단가

            float itemWeight = float.Parse(dt.Rows[0]["weight"].ToString());
            //float itemWeight = float.Parse(dt.Rows[0]["thickness"].ToString()) * float.Parse(dt.Rows[0]["width"].ToString()) * 
            //                   float.Parse(dt.Rows[0]["length"].ToString()) * 0.001f * 0.001f;
            float weight = 0f;
            float initWeight = 0f;
            float unitprice = dt.Rows[0][4].ToString() == "" ? 0 : float.Parse(dt.Rows[0][4].ToString());
            //중량 = 두께 * 폭 * 길이 * 비중 
            //여기서 거래처별 비중과 적용소수점을 계산해주어야 한다.

            if (itemName.Contains("PET"))
            {
                weight = float.Parse(hidden_weight_Pet.Value);
                initWeight = 1.4f;
            }
            else if (itemName.Contains("PP"))
            {
                weight = float.Parse(hidden_weight_Pp.Value); ;
                initWeight = 0.91f;
            }
            else if (itemName.Contains("알미늄"))
            {
                weight = float.Parse(hidden_weight_Al.Value); ;
                initWeight = 2.71f;
            }

            float totalWeight = weight * itemWeight / initWeight;

            if (itemWeight == 1f) totalWeight = 1f;

            switch (hidden_cus_Decimal.Value.Trim())
            {
                case "소수3자리버림":
                    totalWeight = (float)Math.Truncate(totalWeight * 100) / 100;
                    break;
                case "소수3자리반올림":
                    totalWeight = (float)Math.Round(totalWeight, 3);
                    break;
                case "소수3자리올림":
                    totalWeight = (float)Math.Ceiling(totalWeight * 100) / 100;
                    break;
                case "소수2자리버림":
                    totalWeight = (float)Math.Truncate(totalWeight * 10) / 10;
                    break;
                case "소수2자리반올림":
                    totalWeight = (float)Math.Round(totalWeight, 2);
                    break;
                case "소수2자리올림":
                    totalWeight = (float)Math.Ceiling(totalWeight * 10) / 10;
                    break;
                default:
                    totalWeight = (float)Math.Truncate(totalWeight * 100) / 100;
                    break;
            }

            ((HiddenField)grdTable.Items[row].FindControl("hdn_weight")).Value = Math.Round(totalWeight, 2).ToString();

            float price = totalWeight * unitprice;

            ((TextBox)grdTable.Items[row].FindControl("grd_txt_totalWeight")).Text = totalWeight.ToString();
            grdTable.Items[row].Cells[10].Text = price.ToString();

            float tWeigth = 0f;
            float totalPrice = 0f;

            for (int i = 0; i < grdTable.Items.Count; i++)
            {
                float tw = float.Parse(((TextBox)grdTable.Items[row].FindControl("grd_txt_totalWeight")).Text);
                float p = float.Parse(grdTable.Items[i].Cells[10].Text);

                tWeigth += tw;
                totalPrice += p;
            }

            txt_totalWeight.Text = tWeigth.ToString();
            txt_totalamount.Text = totalPrice.ToString();

            float supplyPrice = totalPrice / 1.1f;
            txt_supplyprice.Text = Math.Round(supplyPrice).ToString();
            txt_vat.Text = Math.Round((supplyPrice * 0.1f)).ToString();
        }
    }
}