using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;
using PublicLibsManagement;

namespace iljin.popUp
{
    public partial class popItem : ApplicationRoot
    {
        private DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hdn_code.Value = Request.Params.Get("code");

                km.GetCbDT(ConstClass.ITEM_UNIT_CODE, cb_unit);
                km.GetCbDT(ConstClass.ITEM_DIV1_CODE, cb_itemType1);
                km.GetCbDT(cb_itemType1.SelectedValue, cb_itemType2);

                tb_itemName.Attributes.Add("readonly", "readonly");

                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            if(hdn_code.Value !="")
            {
                object[] obj = { hdn_code.Value };

                hdn_overlapChk.Value = "1";

                DataTable dt = PROCEDURE.SELECT("SP_item_GetByCode", obj, km);

                tb_itemCode.Text = dt.Rows[0]["itemCode"].ToString();
                cb_itemType1.SelectedValue = dt.Rows[0]["divCode1"].ToString();
                cb_itemType2.SelectedValue = dt.Rows[0]["divCode2"].ToString();
                tb_thickness.Text = dt.Rows[0]["thickness"].ToString();
                tb_width.Text = dt.Rows[0]["width"].ToString();
                tb_length.Text = dt.Rows[0]["length"].ToString();
                tb_itemName.Text = dt.Rows[0]["fullName"].ToString();
                tb_unitprice.Text = dt.Rows[0]["unitprice"].ToString();
                tb_weight.Text = dt.Rows[0]["weight"].ToString();
                cb_unit.SelectedValue = dt.Rows[0]["unitCode"].ToString();
                tb_memo.Text = dt.Rows[0]["memo"].ToString();
            }
            else
            {
                tb_itemCode.Text = PublicLibs.SetCode("tb_item", "itemCode", ConstClass.ITEM_CODE_PREFIX, km);

                btn_del.Visible = false;
                btn_del.Enabled = false;

                tb_itemName.Text = cb_itemType1.SelectedItem.Text + "_" + cb_itemType2.SelectedItem.Text;

                hdn_overlapChk.Value = "0";
            }
        }

        protected void cb_itemType1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();
            km.GetCbDT(cb_itemType1.SelectedValue, cb_itemType2);
            ClientScript.RegisterStartupScript(this.GetType(), "test", "onChange();",true);
        }

        protected void btn_del_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { hdn_code };

            km.BeginTran();

            try
            {
                PROCEDURE.CUD_TRAN("SP_item_Delete", objs, km);

                km.Commit();
                Response.Write("<script>alert('삭제되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>window.close();</script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>alert('삭제실패.');</script>");
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (hdn_overlapChk.Value != "1")
            {
                Response.Write("<script> alert('제품명 중복 확인을 해주십시오.'); </script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            try
            {
                km.BeginTran();

                float weight = float.Parse(tb_weight.Text);

                tb_weight.Text = (Math.Truncate(weight * 1000) / 1000).ToString();

                if (hdn_code.Value != "") //수정
                {
                    object[] obj = { hdn_code,cb_itemType1,cb_itemType2,tb_thickness,tb_width,tb_length,
                                 tb_itemName,tb_unitprice,tb_weight,cb_unit,tb_memo};

                    PROCEDURE.CUD_TRAN("SP_item_Update", obj, km);
                }
                else //저장
                {
                    object[] obj = { PublicLibs.SetCode_Tran("tb_item", "itemCode", ConstClass.ITEM_CODE_PREFIX, km),cb_itemType1
                            ,cb_itemType2,tb_thickness,tb_width,tb_length,tb_itemName,tb_unitprice,tb_weight,cb_unit,tb_memo};

                    PROCEDURE.CUD_TRAN("SP_item_Add", obj, km);
                }

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

        protected void btn_overlap_Click(object sender, EventArgs e)
        {
            if(tb_itemName.Text == "")
            {
                Response.Write("<script>alert('제품정보를 입력해 주십시오.');</script>");
                return;
            }

            if (km == null) km = new DB_mysql();

            string sql = $"SELECT * FROM tb_item WHERE fullName = '{tb_itemName.Text}' AND isUse = '1';";

            if (km.GetDTa(sql).Rows.Count > 0)
            {
                Response.Write("<script>alert('이미 등록된 제품입니다.');</script>");
                hdn_overlapChk.Value = "0";
            }
            else
            {
                Response.Write("<script>alert('등록가능한 제품입니다.');</script>");
                hdn_overlapChk.Value = "1";

                float _decimal;

                if (cb_itemType1.SelectedIndex == 0) _decimal = 1.4f;
                else if (cb_itemType1.SelectedIndex == 1) _decimal = 0.91f;
                else _decimal = 2.71f;

                float weight = float.Parse(tb_thickness.Text) * float.Parse(tb_width.Text) *
                    float.Parse(tb_length.Text) * _decimal * 0.001f * 0.001f;

                tb_weight.Text = (Math.Truncate(weight * 1000) / 1000).ToString();
            }
        }
    }
}