using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;
using PublicLibsManagement;
using les;

namespace iljin.popUp
{
    public partial class popfinal : ApplicationRoot
    {
        DB_mysql km;

        //div = 0 주문건에서 발행된 거래명세표
        //div = 1 별도 발행된 거래명세표
        //div = 2 여러주문건 발행 가능한 출고처리

        //if(div == 0 or 2) code = orderCode 1 or n
        //if(div == 1 ) code = info about separateTransaction
        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                hidden_code.Value = Request.Params.Get("code");
                hidden_div.Value = Request.Params.Get("div");

                Search_Producer_Info();

                if (hidden_div.Value == "0" || hidden_div.Value == "2") //주문
                {
                    Search_Grid_FromOrderCode();
                }
                else //별도발행
                {
                    Search_Grid_SeparateTrans();
                }
            }
        }

        //공급자 정보
        private void Search_Producer_Info()
        {
            if (km == null) km = new DB_mysql();

            DataTable dt = PROCEDURE.SELECT_TRAN("SP_company_Info", km);

            //tradeDt.InnerText = dt.Rows[0][""].ToString();
            sender.InnerText = "일진팩";
            registration.InnerText = dt.Rows[0]["comregistration"].ToString();
            companyName.InnerText = dt.Rows[0]["comName"].ToString();
            managerName.InnerText = dt.Rows[0]["comBossName"].ToString();
            address.InnerText = dt.Rows[0]["address1"].ToString() + "(" + dt.Rows[0]["address2"].ToString() + ")";
            business.InnerText = dt.Rows[0]["combusiness"].ToString();
            businessType.InnerText = dt.Rows[0]["comType"].ToString();
            email.InnerText = dt.Rows[0]["commail"].ToString();
            //managerTel.InnerText = dt.Rows[0][""]
            fax.InnerText = dt.Rows[0]["comFax"].ToString();
        }

        //주문번호
        private void Search_Grid_FromOrderCode()
        {
            if (km == null) km = new DB_mysql();

            string orderCode = "";

            string[] codeList = hidden_code.Value.Split(',');

            for(int i = 0; i < codeList.Length; i++)
            {
                if(codeList[i].Trim() != "")
                {
                    orderCode += ",'" + codeList[i] + "'";
                }
            }

            string sql = "SELECT b.fullName,c.fullName,SUM(a.qty) FROM tb_order_detail a " +
                         "INNER JOIN tb_item b ON a.itemCode = b.itemCode " +
                         "INNER JOIN tb_item c ON a.actualItemCode = c.itemCode " +
                        $"WHERE orderCode IN({orderCode.Substring(1)}) " +
                         "GROUP BY a.itemCode;";

            DataTable dt = km.GetDTa(sql);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;
            string itemName = "";

            for(int i = 0; i < rowCount; i++)
            {
                grdTable.Items[i].Cells[0].Text = (i + 1).ToString();

                //실제품과 등록된 제품명이 다른경우
                if(dt.Rows[i][0].ToString() != dt.Rows[i][1].ToString())
                {
                    itemName = dt.Rows[i][1].ToString() + "(대체)";
                }
                else
                {
                    itemName = dt.Rows[i][0].ToString();
                }

                grdTable.Items[i].Cells[1].Text = itemName;
                grdTable.Items[i].Cells[3].Text = dt.Rows[i][2].ToString();
            }
        }

        //별도발행
        private void Search_Grid_SeparateTrans()
        {
            string[] infoArr = hidden_code.Value.Split(',');

            tradeDt.InnerText = infoArr[5];

            DataTable dt = new DataTable();
            dt.Rows.Add();

            grdTable.DataSource = dt;
            grdTable.DataBind();

            grdTable.Items[0].Cells[0].Text = "1";
            grdTable.Items[0].Cells[1].Text = infoArr[3];
            grdTable.Items[0].Cells[2].Text = infoArr[4];
        }
    }
}