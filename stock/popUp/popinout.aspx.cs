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
            dt = PROCEDURE.SELECT("SP_warehousing_GetList",itemCode,km);

            //gridTable1.데이터소스 = dt
            grdTable1.DataSource = dt;
            //gridTable1에 데이터 연결
            grdTable1.DataBind();

            //int 열의개수 = grdtable1.아이템.개수(숫자)
            int rCount = grdTable1.Items.Count;
            //int 행의개수 = gridtable1.행.개수(숫자)
            int cCount = grdTable1.Columns.Count;
            
            les_DataGridSystem.Set_DataGrid_From_Dt(grdTable1, dt, 0);

            //int i = 0 i 가 아이템개수보다 작으면 i를 더해준다
            for(int i = 0; i < rCount; i++)
            {
                //grdTable1.아이템[i].행[행의개수 -1].문자 = 현재수량.문자열로()
                grdTable1.Items[i].Cells[cCount -1].Text = currentQty.ToString();

                //string sqty = gridtable1.아이템[i].셀[행의개수 -1].문자
                string sQty = grdTable1.Items[i].Cells[cCount -1].Text;
                //int iqty = sqty를 int로 바꿈
                int iQty = int.Parse(sQty);

                //만약(iqty가 0보다 크면)
                if(iQty > 0) //입고,출고 시 +,-로 표시
                {
                    //만약(gridtable1.아이템[i].셀[4].문자 == "출고")
                    if(grdTable1.Items[i].Cells[4].Text=="")//출고 X
                    {
                        //iqty *= -1
                        iQty = 0;
                        //gridtable1.아이템[i].셀[행의갯수 -2].문자 = sqty.넣는다(0,"-")
                        grdTable1.Items[i].Cells[cCount -2].Text = sQty.Insert(0,"-");
                    }
                    else //또는
                    {
                        //gridtable1.아이템[i].셀[행의갯수 -2].문자 = sqty.넣는다(0,"+")
                        grdTable1.Items[i].Cells[cCount -2].Text = sQty.Insert(0, "+ ");
                    }
                }
                else //재고조정시 +,- 판별용 //또는
                {
                    //grdtable.items[i].셀[행의갯수 -2].문자 = sqty.넣는다(0,"-");
                   // grdTable1.Items[i].Cells[cCount -2].Text = sQty.Insert(0, "-");
                }
             
                //현재수량 = iqty
                currentQty = iQty;
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