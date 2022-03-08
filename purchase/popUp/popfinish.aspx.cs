using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MysqlLib;
using PublicLibsManagement;

namespace iljin.popUp
{
    public partial class popfinish : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hidden_idx.Value = Request.Params.Get("idx");
                hidden_div.Value = Request.Params.Get("div");

                if (hidden_div.Value == "0")
                {
                    Search_Exception_Info();
                    Search_Exception_Item();
                }
                else
                {
                    Search_Info();
                    Search_Item();
                }
            }
        }

        //정보검색
        private void Search_Exception_Info()
        {
            if (km == null) km = new DB_mysql();

            string sql = "SELECT b.cusName, a.incomeDate FROM tb_warehousing_Exception_Income a " +
                         "LEFT OUTER JOIN tb_customer b ON a.cusCode = b.cusCode " +
                        $"WHERE a.idx = {hidden_idx.Value}";

            DataTable dt = km.GetDTa(sql);

            txt_purchase.Text = dt.Rows[0][0].ToString();
            txt_incomedate.Text = dt.Rows[0][1].ToString();

            // txt
        }

        //정보검색
        private void Search_Exception_Item()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_warehousing_Exception_Income_GetInfo", hidden_idx.Value, km);

            grdTable1.DataSource = dt;
            grdTable1.DataBind();

            int totalQty = 0;
            float totalWeigth = 0;
            float totalPrice = 0;

            int row = grdTable1.Items.Count;
            int col = grdTable1.Columns.Count;

            for (int i = 0; i < row; i++)
            {
                for (int j = 0; j < col; j++)
                {
                    grdTable1.Items[i].Cells[j].Text = dt.Rows[i][j].ToString();
                }

                totalQty += int.Parse(dt.Rows[i]["qty"].ToString());
                totalWeigth += float.Parse(dt.Rows[i]["weight"].ToString());
                totalPrice += float.Parse(dt.Rows[i]["price"].ToString());
            }

            txt_totalQty.Text = totalQty.ToString();
        }

        //정보검색
        private void Search_Info()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_container_info_Get_Income", hidden_idx.Value, km);

            txt_purchase.Text = dt.Rows[0][0].ToString();
            txt_contractno.Text = dt.Rows[0][1].ToString();
            txt_lcNo.Text = dt.Rows[0][2].ToString();
            txt_blno.Text = dt.Rows[0][3].ToString();
            txt_containerno.Text = dt.Rows[0][4].ToString();
            txt_arrivaldate.Text = dt.Rows[0][5].ToString();
            txt_manager.Text = dt.Rows[0][6].ToString();

            txt_incomedate.Text = Get_IncomeDate();

            // txt
        }

        //입고일자 가져오기
        private string Get_IncomeDate()
        {
            if (km == null) km = new DB_mysql();

            string sql = $"SELECT warehousingDate FROM tb_warehousing WHERE containerId = {hidden_idx.Value.ToString()};";


            return km.GetDTa(sql).Rows[0][0].ToString();
        }

        //품목검색
        private void Search_Item()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_container_item_Get_Income", hidden_idx.Value, km);

            grdTable1.DataSource = dt;
            grdTable1.DataBind();

            int rowCount = grdTable1.Items.Count;
            int colCount = grdTable1.Columns.Count;

            int totalQty = 0;
            float totalWeigth = 0;
            float totalPrice = 0;

            for (int i = 0; i < rowCount; i++)
            {
                for (int j = 0; j < colCount; j++)
                {
                    grdTable1.Items[i].Cells[j].Text = dt.Rows[i][j + 1].ToString();
                }

                totalQty += int.Parse(dt.Rows[i]["qty"].ToString());
            }

            txt_totalQty.Text = totalQty.ToString();
        }
    }
}