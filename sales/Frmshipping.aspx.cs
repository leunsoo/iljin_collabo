using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using les;
using PublicLibsManagement;
using System.Data;
using MysqlLib;

namespace iljin
{
    public partial class Frmshipping : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                Tool_Date.Set_TextBoxes_Period_MM_01_To_Now(tb_deliverydate, tb_deliverydate2);

                cb_customer_Setting();
                cb_adressdiv_Setting();
                cb_customer_SelectedIndexChanged(null,null);

                Search();
            }
        }

        private void cb_customer_Setting()
        {
            if (km == null) km = new DB_mysql();

            string sql = "SELECT cusName,cusCode FROM tb_customer a " +
                         "INNER JOIN tb_code b ON a.cusDivCode = b.code_id AND b.code_name LIKE '%매출%' " +
                         "WHERE a.isUse = '1'";
            DataTable dt = km.GetDTa(sql);

            cb_customer.Items.Clear();

            cb_customer.Items.Add(new ListItem("전체", ""));

            for(int i = 0; i< dt.Rows.Count; i++)
            {
                cb_customer.Items.Add(new ListItem(dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString()));
            }
        }

        //배송구분 콤보박스 셋팅
        private void cb_adressdiv_Setting()
        {
            cb_adressdiv.Items.Clear();

            cb_adressdiv.Items.Add(new ListItem("전체", ""));
            cb_adressdiv.Items.Add(new ListItem("자차", "0"));
            cb_adressdiv.Items.Add(new ListItem("택배", "1"));
            cb_adressdiv.Items.Add(new ListItem("용달", "2"));
        }

        //조회
        private void Search()
        {
            if (km == null) km = new DB_mysql();

            string date = DateTime.Parse(tb_deliverydate2.Text).AddDays(1).ToString("yyyy-MM-dd");

            object[] objs = { cb_customer, cb_address,tb_deliverydate, date, cb_adressdiv };
            DataTable dt = PROCEDURE.SELECT("SP_shipment_GetBySearch",objs, km);

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable, dt, 0);
        }

        protected void btn_serch_Click(object sender, EventArgs e)
        {
            Search();
        }

        //거래처 선택에 따른 배송지 변화
        protected void cb_customer_SelectedIndexChanged(object sender, EventArgs e)
        {
            cb_address.Items.Clear();
            cb_address.Items.Add(new ListItem("전체", ""));

            if (cb_customer.SelectedValue == "") return;

            if (km == null) km = new DB_mysql();

            string sql = $"SELECT addressName,idx FROM tb_customer_address WHERE cusCode = '{cb_customer.SelectedValue}';";

            DataTable dt = km.GetDTa(sql);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                cb_address.Items.Add(new ListItem(dt.Rows[i][0].ToString(), dt.Rows[i][1].ToString()));
            }
        }
    }
}