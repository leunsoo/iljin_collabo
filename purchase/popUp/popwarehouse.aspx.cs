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
    public partial class popwarehouse : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hidden_idx.Value = Request.Params.Get("idx");

                tb_incomedate.Text = DateTime.Now.ToString("yyyy-MM-dd");

                Search_Info();
                Search_Item();
            }
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

            hidden_cusCode.Value = dt.Rows[0][7].ToString();
            // txt
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
                    grdTable1.Items[i].Cells[j].Text = dt.Rows[i][j].ToString();
                }

                totalQty += int.Parse(dt.Rows[i]["qty"].ToString());
                totalWeigth += float.Parse(dt.Rows[i]["weight"].ToString());
                totalPrice += float.Parse(dt.Rows[i]["price"].ToString());
            }

            txt_totalQty.Text = totalQty.ToString();
            txt_totalWeigth.Text = totalWeigth.ToString();
            txt_totalPrice.Text = totalPrice.ToString();
        }

        //저장
        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            int rowCount = grdTable1.Items.Count;
            int colCount = grdTable1.Columns.Count;
            string sql = "";

            string emp = Session["userCode"].ToString();

            km.BeginTran();

            try
            {
                for (int i = 0; i < rowCount; i++)
                {
                    //입출고 저장
                    sql += "CALL SP_warehousing_Income_Add(" +
                        $"'{tb_incomedate.Text}'" +
                        $",'{grdTable1.Items[i].Cells[0].Text}'" +
                        $",'{hidden_cusCode.Value}'" +
                        $",'{grdTable1.Items[i].Cells[7].Text}'" +
                        $",'{hidden_idx.Value}'" +
                        $",'{emp}');";

                    sql += "UPDATE tb_purchase_item a SET " +
                          $"a.leftQty = a.leftQty - {grdTable1.Items[i].Cells[7].Text} " +
                          $"WHERE a.itemCode = '{grdTable1.Items[i].Cells[0].Text}' " +
                          $"AND a.contractId = (SELECT b.contractId FROM tb_container_info b WHERE b.idx = {hidden_idx.Value});";
                    //sql += "CALL SP_inventory_Add_From_Income(" +
                    //    $"'{grdTable1.Items[i].Cells[0].Text}'" +
                    //    $",'{grdTable1.Items[i].Cells[7].Text}');";
                }

                if (sql != "")
                {
                    km.tran_ExSQL_Ret(sql);
                }
                km.Commit();

                Response.Write("<script>alert('입고처리되었습니다.');</script>");
                Response.Write("<script>window.opener.refresh();</script>");
                Response.Write("<script>self.close();</script>");
            }
            catch (Exception ex)
            {
                PROCEDURE.ERROR_ROLLBACK(ex.Message, km);

                Response.Write("<script>alert('입고 실패.')</script>");
            }
        }
    }
}