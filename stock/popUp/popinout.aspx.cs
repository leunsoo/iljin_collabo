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
        }

        //입출고 내역
        private void Search_Grid1()
        {
            // db 연결
            if (km == null) km = new DB_mysql();

            // dt(데이터테이블)= km.tran_GetDTa($"수량을 고른다 tb_inventory itemcode='{itemCode}에서'")
             DataTable dt = km.tran_GetDTa($"SELECT qty FROM tb_inventory WHERE itemCode = '{itemCode}';");

            //int 현재수량 = 0;
             int currentQty = 0;

            //만약 (dt.열.숫자(개수)가 0보다 크면)
            if (dt.Rows.Count > 0)
              {
            //현재수량 = int. 바꿔준다(dt.열[0][0].문자열로())
              currentQty = int.Parse(dt.Rows[0][0].ToString());
             }
             else //또는
             {
            //반환(돌려준다)
              return;
             }

            //dt = 프로시저.고른다("SP_warehousing_GetList"에서 ,itemCode,km);
            dt = PROCEDURE.SELECT("SP_warehousing_GetList", itemCode, km);

            //gridTable1.데이터소스 = dt
            grdTable1.DataSource = dt;
            grdTable1.DataBind();

            //int 열의개수 = grdtable1.아이템.개수(숫자)
            int rCount = grdTable1.Items.Count;
            //int 행의개수 = gridtable1.행.개수(숫자)
            int cCount = grdTable1.Columns.Count;

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable1, dt, 5);//지우면 날짜가 뜨지 않음

            //int i = 0 i 가 아이템개수보다 작으면 i를 더해준다
            for (int i = 0; i < rCount; i++)
            {
                grdTable1.Items[i].Cells[0].Text = dt.Rows[i]["_date"].ToString();
                grdTable1.Items[i].Cells[1].Text = dt.Rows[i]["_name"].ToString();
                grdTable1.Items[i].Cells[2].Text = dt.Rows[i]["_adjust"].ToString();
                grdTable1.Items[i].Cells[3].Text = dt.Rows[i]["_income"].ToString();
                grdTable1.Items[i].Cells[4].Text = dt.Rows[i]["_release"].ToString();
                grdTable1.Items[i].Cells[5].Text = currentQty.ToString();
              


                if (dt.Rows[i]["_adjust"].ToString() != "")
                {
                    currentQty -= Convert.ToInt32(dt.Rows[i]["_adjust"].ToString());
                }

                if (dt.Rows[i]["_income"].ToString() != "")
                {
                    currentQty -= Convert.ToInt32(dt.Rows[i]["_income"].ToString());
                }

                if (dt.Rows[i]["_release"].ToString() != "")
                {
                    currentQty += Convert.ToInt32(dt.Rows[i]["_release"].ToString());
                }

            }
        }

        //입고 확정,입항예정
        private void Search_Grid2()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT("SP_warehousing_Getincome_income_predic", itemCode, km);

            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable2, dt, 0);
        }

    }
}