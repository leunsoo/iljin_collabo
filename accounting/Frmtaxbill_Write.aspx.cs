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
using System.Drawing;

namespace iljin
{
    public partial class Frmtaxbill_Write : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                Tool_Date.Set_TextBoxes_Period_MM_01_To_Now(tb_orderdate, tb_orderdate2);
                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { tb_orderdate, tb_orderdate2, txt_customer };
            DataTable dt = PROCEDURE.SELECT("SP_taxbill_write_GetBySearch", objs, km);
            

            // les_DataGridSystem.Set_DataGrid_From_Dt(grdTable, dt, 1, grdTable.Columns.Count - 1, 0);
            string[] fields = { "hdn_code" };
            les_DataGridSystem.Set_DataGrid_From_Search_Dt(grdTable, dt, fields);
            // les_DataGridSystem.Set_DataGrid_From_Dt(DataGrid1, dt, 1, DataGrid1.Columns.Count -1, 1);

            DataGrid1.DataSource = dt;
            DataGrid1.DataBind();

            for (int i = 0; i < dt.Rows.Count; i++)
            {
               // DataGrid1.Items[i].Cells[0].Text = (i + 1).ToString();
                DataGrid1.Items[i].Cells[0].Text = dt.Rows[i]["cusName"].ToString();
                DataGrid1.Items[i].Cells[1].Text = dt.Rows[i]["transactionDate"].ToString();
                DataGrid1.Items[i].Cells[2].Text = dt.Rows[i]["deliverydate"].ToString();
                DataGrid1.Items[i].Cells[3].Text = dt.Rows[i]["orderCode"].ToString();
                DataGrid1.Items[i].Cells[4].Text = dt.Rows[i]["name"].ToString();
                DataGrid1.Items[i].Cells[5].Text = dt.Rows[i]["qty"].ToString();
                DataGrid1.Items[i].Cells[6].Text = dt.Rows[i]["price"].ToString();
                DataGrid1.Items[i].Cells[7].Text = dt.Rows[i]["vat"].ToString();
                DataGrid1.Items[i].Cells[8].Text = dt.Rows[i]["totalprice"].ToString();
            }

            Button btn;

          

            for (int i = 0; i < grdTable.Items.Count; i++)
            {
                btn = grdTable.Items[i].FindControl("btn_sent") as Button;

                if (dt.Rows[i]["taxbillserialNo"].ToString() != "")
                {
                    btn.Text = "발행완료";
                    btn.BackColor = Color.Green;
                    btn.Attributes.Add("onclick", "return false;");
                }
                else
                {
                    btn.Attributes.Add("onclick", "return false;");
                }
            }
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            Search();
        }

        protected void btn_excel_Click(object sender, EventArgs e)
        {
            string filename = "세금계산서작성" + DateTime.Now.ToString("yyMMdd") + ".xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            exceldiv5.RenderControl(hw);
            Response.ContentType = "application/vnd.ms-excel";
            Response.Charset = "euc-kr";
            Response.ContentEncoding = System.Text.Encoding.GetEncoding("euc-kr");
            Response.AppendHeader("Content-Disposition", "attachment; filename=" + filename + "");
            this.EnableViewState = false;
            Response.Write(tw.ToString());
            Response.End();
        }
    }
}