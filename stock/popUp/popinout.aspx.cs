using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PublicLibsManagement;
using les;
using MysqlLib;

namespace iljin.popUp
{
    public partial class popinout : ApplicationRoot
    {
        private DB_mysql km;
        private string itemCode;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            txt_itemName.InnerText = Request.Params.Get("name");
            itemCode = Request.Params.Get("code");

            Search_Grid1();
            Search_Grid2();
            Search_Grid3();
        }

        //입출고 내역
        private void Search_Grid1()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = km.tran_GetDTa($"SELECT qty FROM tb_inventory WHERE itemCode = '{itemCode}';");

            int currentQty = 0;

            if (dt.Rows.Count > 0)
            {
                currentQty = int.Parse(dt.Rows[0][0].ToString());
            }
            else
            {
                return;
            }

            dt = PROCEDURE.SELECT("SP_warehousing_GetList",itemCode,km);

            grdTable1.DataSource = dt;
            grdTable1.DataBind();

            int rCount = grdTable1.Items.Count;
            int cCount = grdTable1.Columns.Count;

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable1, dt, 0, cCount - 1, 0);

            for(int i = 0; i < rCount; i++)
            {
                grdTable1.Items[i].Cells[cCount - 1].Text = currentQty.ToString();

                string sQty = grdTable1.Items[i].Cells[cCount - 2].Text;
                int iQty = int.Parse(sQty);

                if(iQty > 0) //입고,출고 시 +,-로 표시
                {
                    if(grdTable1.Items[i].Cells[4].Text == "출고")
                    {
                        iQty *= -1; 
                        grdTable1.Items[i].Cells[cCount - 2].Text = sQty.Insert(0, "- ");
                    }
                    else
                    {
                        grdTable1.Items[i].Cells[cCount - 2].Text = sQty.Insert(0, "+ ");
                    }
                }
                else //재고조정시 +,- 판별용
                {
                    grdTable1.Items[i].Cells[cCount - 2].Text = sQty.Insert(0, "-");
                }

                currentQty -= iQty;
            }
        }

        //입고 확정
        private void Search_Grid2()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_warehousing_GetIncome", itemCode, km);

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable2, dt, 0);
        }

        //입항 예정
        private void Search_Grid3()
        {
            if (km == null) km = new DB_mysql();
            DataTable dt = PROCEDURE.SELECT("SP_warehousing_GetIncome_Predic", itemCode, km);
            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable3, dt, 0);
        }
    }
}