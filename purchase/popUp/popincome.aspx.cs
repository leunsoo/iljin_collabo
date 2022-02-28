using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using PublicLibsManagement;
using System.Data;
using les;

namespace iljin.popUp
{
    public partial class popincome : ApplicationRoot
    {
        DataTable Mdt;
        DB_mysql km;

        string[] strList = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12" };
        string[] controlNameList = { "hidden_keyWord", "hidden_itemCode", "txt_itemname", "txt_count", "txt_weight", "txt_unitprice", "txt_price", "btn_del" };


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                LoadCustomerInfo();
            }
        }

        private void LoadCustomerInfo()
        {
            cb_cusname.Items.Clear();

            if (km == null) km = new DB_mysql();

            DataTable dt = km.GetDTa("SELECT cusName,cusCode FROM tb_customer ORDER BY cusName;");

            int rowCount = dt.Rows.Count;

            cb_cusname.Items.Add(new ListItem("선택", ""));

            for (int i = 0; i < rowCount; i++)
            {
                cb_cusname.Items.Add(new ListItem(dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString()));
            }
        }

        protected void btn_add_Click(object sender, EventArgs e)
        {
            Mdt = les_DataGridSystem.Get_Dt_From_DataGrid(grdTable1, strList);

            DataRow dr = Mdt.NewRow();

            Mdt.Rows.InsertAt(dr, 0);

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable1, Mdt, controlNameList);

            int rowCount = grdTable1.Items.Count;
            TextBox tb;

            for (int i = 0; i < rowCount; i++)
            {
                tb = ((TextBox)grdTable1.Items[i].FindControl("txt_itemname"));
                tb.Attributes.Add("onkeypress", $"KeyPressEvent('{i.ToString()}');");
                tb.Attributes.Add("onkeydown", $"KeyDownEvent('{i.ToString()}');");
                tb.Attributes.Add("onclick", $"visibleChk('{i.ToString()}');");

                ((Button)grdTable1.Items[i].FindControl("btn_del")).Attributes.Add("onclick", $"deleteRow('{i.ToString()}'); return false;");
            }
        }

        protected void cb_cusname_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = km.GetDTa($"SELECT tel,email,fax FROM tb_customer WHERE cusCode = '{cb_cusname.SelectedValue}';");

            if (dt.Rows.Count == 0)
            {
                txt_bosstel.Text = "";
                txt_bossmail.Text = "";
                txt_fax.Text = "";
            }
            else
            {
                txt_bosstel.Text = dt.Rows[0][0].ToString();
                txt_bossmail.Text = dt.Rows[0][1].ToString();
                txt_fax.Text = dt.Rows[0][2].ToString();
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (cb_cusname.SelectedValue == "")
            {
                Response.Write("<script>alert('거래처를 선택해 주십시오.');</script>");
                return;
            }

            int rowCount = grdTable1.Items.Count;
            int itemCount = 0;

            for (int i = 0; i < rowCount; i++)
            {
                if (((HiddenField)grdTable1.Items[i].FindControl("hidden_itemCode")).Value != "")
                {
                    itemCount++;
                }
            }

            if (itemCount == 0)
            {
                Response.Write("<script>alert('제품을 입력해 주십시오.');</script>");
                return;
            }

            string title = ((TextBox)grdTable1.Items[0].FindControl("txt_itemname")).Text;

            if(itemCount > 1)
            {
                title += $" 외 {itemCount - 1}개";
            }

            if (km == null) km = new DB_mysql();


            string date = DateTime.Now.ToString("yyyy-MM-dd");
            string sql = "";
            string emp = Session["userCode"].ToString();

            km.BeginTran();

            string idx = km.GetDTa("SELECT (MAX(idx) + 1) FROM tb_warehousing_Exception_Income").Rows[0][0].ToString();
            
            try
            {
                for (int i = 0; i < rowCount; i++)
                {
                    if (((HiddenField)grdTable1.Items[i].FindControl("hidden_itemCode")).Value != "")
                    {
                           sql += "CALL SP_warehousing_Exception_Income_Add(" +
                            $"'{idx}'" +
                            $",'{cb_cusname.SelectedValue}'" +
                            $",'{title}'" +
                            $",'{((HiddenField)grdTable1.Items[i].FindControl("hidden_itemCode")).Value}'" +
                            $",'{((TextBox)grdTable1.Items[i].FindControl("txt_count")).Text}'" +
                            $",'{((TextBox)grdTable1.Items[i].FindControl("txt_weight")).Text}'" +
                            $",'{((TextBox)grdTable1.Items[i].FindControl("txt_unitprice")).Text}'" +
                            $",'{((TextBox)grdTable1.Items[i].FindControl("txt_price")).Text}'" +
                            $",'{date}'" +
                            $",'{emp}');";
                    }
                }

                if(sql != "")
                {
                    km.tran_ExSQL_Ret(sql);
                }

                km.Commit();
                Response.Write("<script>alert('입고되었습니다.');</script>");
                Response.Write("<script>opener.refresh();</script>");
                Response.Write("<script>self.close();</script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>alert('입고 실패');</script>");
            }

        }

        protected void btn_delete_Click(object sender, EventArgs e)
        {
            Mdt = les_DataGridSystem.Get_Dt_From_DataGrid(grdTable1, strList);

            Mdt.Rows.RemoveAt(int.Parse(hidden_selectedRow.Value));

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable1, Mdt, controlNameList);

            int rowCount = grdTable1.Items.Count;

            TextBox tb;

            for (int i = 0; i < rowCount; i++)
            {
                tb = ((TextBox)grdTable1.Items[i].FindControl("txt_itemname"));
                tb.Attributes.Add("onkeypress", $"KeyPressEvent('{i.ToString()}');");
                tb.Attributes.Add("onkeydown", $"KeyDownEvent('{i.ToString()}');");
                tb.Attributes.Add("onclick", $"visibleChk('{i.ToString()}');");

                ((Button)grdTable1.Items[i].FindControl("btn_del")).Attributes.Add("onclick", $"deleteRow('{i.ToString()}'); return false;");
            }
        }

        protected void btn_itemInfoSetting_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            int row = int.Parse(hidden_selectedRow.Value);
            string itemCode = ((HiddenField)grdTable1.Items[row].FindControl("hidden_itemCode")).Value;

            if (itemCode == "") return;

            string sql = "SELECT b.code_name,c.code_name,thickness,width,length FROM tb_item a " +
                         "LEFT OUTER JOIN tb_code b ON a.divCode1 = b.code_id " +
                         "LEFT OUTER JOIN tb_code c ON a.divCode2 = c.code_id " +
                         $"WHERE a.itemCode = '{itemCode}'";

            DataTable dt = km.GetDTa(sql);

            grdTable1.Items[row].Cells[1].Text = dt.Rows[0][0].ToString();
            grdTable1.Items[row].Cells[2].Text = dt.Rows[0][1].ToString();
            grdTable1.Items[row].Cells[3].Text = dt.Rows[0][2].ToString();
            grdTable1.Items[row].Cells[4].Text = dt.Rows[0][3].ToString();
            grdTable1.Items[row].Cells[5].Text = dt.Rows[0][4].ToString();
        }
    }
}