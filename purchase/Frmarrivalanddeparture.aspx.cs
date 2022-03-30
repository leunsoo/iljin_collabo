using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PublicLibsManagement;
using MysqlLib;
using les;

namespace iljin
{
    public partial class Frmarrivalanddeparture : ApplicationRoot
    {
        DB_mysql km;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                cb_divCode_Setting();
                cb_divCode2_Setting();
                cb_averagemonth_Setting();
                cb_forecastmonth_Setting();
            }
        }

        //조회
        private void Search()
        {
            if (km == null) km = new DB_mysql();

            string date1 = DateTime.Now.AddMonths(-int.Parse(cb_averagemonth.SelectedValue)).ToString("yyyy-MM-dd");
            string date2 = DateTime.Now.ToString("yyyy-MM-dd");

            object[] objs = { cb_divCode1,cb_divCode2,date1,date2,
                              txt_thickness.Text == ""? "0" : txt_thickness.Text,
                              txt_thickness2.Text == ""? "0" : txt_thickness2.Text,
                              txt_width,txt_width2 };

            DataTable dt = PROCEDURE.SELECT("SP_warehousing_prediction",objs, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            txt_month1.InnerHtml = $"최근 {cb_averagemonth.SelectedValue}개월 평균 출고량";
            txt_month2.InnerHtml = $"{cb_forecastmonth.SelectedValue}개월 후 재고";

            //평균 출고량
            double avgQty;
           
            //현재고
            int currentQty;
            //입고예정
            int predicQty;

            for(int i = 0; i < grdTable.Items.Count; i++)
            {
                grdTable.Items[i].Cells[0].Text = dt.Rows[i][0].ToString();

                if (dt.Rows[i][1].ToString() != "")
                {
                    //avgQty = Math.Round(float.Parse(dt.Rows[i][1].ToString()) / int.Parse(cb_averagemonth.SelectedValue), 0);

                    avgQty = Math.Ceiling(double.Parse(dt.Rows[i][1].ToString()));
            
                   
                }
                else
                {
                    avgQty = 0;
                }

                grdTable.Items[i].Cells[1].Text = avgQty.ToString();

                currentQty = int.Parse(dt.Rows[i][2].ToString());

                grdTable.Items[i].Cells[2].Text = currentQty.ToString();

                if (dt.Rows[i][3].ToString() != "")
                {
                    predicQty = int.Parse(dt.Rows[i][3].ToString());
                }
                else
                {
                    predicQty = 0;
                }

                grdTable.Items[i].Cells[3].Text = predicQty.ToString();

                grdTable.Items[i].Cells[4].Text = (currentQty + predicQty - (avgQty * int.Parse(cb_forecastmonth.SelectedValue))).ToString();

                Tool_UI.NegativeText_Set_RedColor(grdTable.Items[i].Cells[4]);
            }
        }

        

        //제품구분1 셋팅
        private void cb_divCode_Setting()
        {
            if (km == null) km = new DB_mysql();

            km.GetCbDT(ConstClass.ITEM_DIV1_CODE,cb_divCode1);
        }

        //제품구분2 셋팅
        private void cb_divCode2_Setting()
        {
            if (km == null) km = new DB_mysql();

            km.GetCbDT(cb_divCode1.SelectedValue, cb_divCode2);
        }

        //평균 출고 개월
        private void cb_averagemonth_Setting()
        {
            cb_averagemonth.Items.Clear();

            for(int i = 1; i < 13; i++)
            {
                cb_averagemonth.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            cb_averagemonth.SelectedValue = "4";
        }

        //n개월 후 재고
        private void cb_forecastmonth_Setting()
        {
            cb_forecastmonth.Items.Clear();

            for (int i = 1; i < 7; i++)
            {
                cb_forecastmonth.Items.Add(new ListItem(i.ToString(), i.ToString()));
            }

            cb_forecastmonth.SelectedValue = "2";
        }

        protected void cb_divCode1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            km.GetCbDT(cb_divCode1.SelectedValue, cb_divCode2);
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }
    }
}