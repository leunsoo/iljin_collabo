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

namespace iljin.Menu.accounting
{
    public partial class Frmshippingfee : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                tb_date.Text = DateTime.Now.AddDays(-3).ToString("yyyy-MM-dd");
                tb_date2.Text = DateTime.Now.ToString("yyyy-MM-dd");

                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            string date = DateTime.Parse(tb_date2.Text).AddDays(1).ToString("yyyy-MM-dd");

            object[] objs = { tb_date, date };

            DataTable dt = PROCEDURE.SELECT("SP_shipment_GetBySearch2",objs , km);

            grdTable.DataSource = dt;
            grdTable.DataBind();
            grdtable_copy2.DataSource = dt;
            grdtable_copy2.DataBind();



            for (int i = 0;i < grdTable.Items.Count; i++)
            {
                grdTable.Items[i].Cells[0].Text = (i + 1).ToString();

                for(int j = 1; j < grdTable.Columns.Count - 2; j++)
                {
                    grdTable.Items[i].Cells[j].Text = dt.Rows[i][j].ToString();
                }

                for (int k = 0; k < dt.Rows.Count; k++)
                {
                    grdtable_copy2.Items[k].Cells[0].Text = (k + 1).ToString();
                    grdtable_copy2.Items[k].Cells[1].Text = dt.Rows[k]["releaseDate"].ToString();
                    grdtable_copy2.Items[k].Cells[2].Text = dt.Rows[k]["cusName"].ToString();
                    grdtable_copy2.Items[k].Cells[3].Text = dt.Rows[k]["addressName"].ToString();
                    grdtable_copy2.Items[k].Cells[4].Text = dt.Rows[k]["shipmentCusName"].ToString();
                    grdtable_copy2.Items[k].Cells[5].Text = dt.Rows[k]["tel"].ToString();
                    grdtable_copy2.Items[k].Cells[6].Text = dt.Rows[k]["registration"].ToString();
                    grdtable_copy2.Items[k].Cells[7].Text = dt.Rows[k]["price"].ToString();
                    grdtable_copy2.Items[k].Cells[8].Text = dt.Rows[k]["totalprice"].ToString();
                    grdtable_copy2.Items[k].Cells[9].Text = dt.Rows[k]["bank"].ToString();
                    grdtable_copy2.Items[k].Cells[10].Text = dt.Rows[k]["accountNo"].ToString();
                    grdtable_copy2.Items[k].Cells[11].Text = dt.Rows[k]["payDate"].ToString();
                }



                    ((TextBox)grdTable.Items[i].FindControl("txt_paymentdate")).Text = dt.Rows[i]["payDate"].ToString();
                ((Button)grdTable.Items[i].FindControl("btn_update")).Attributes.Add("onclick", $"update_payDate('{i.ToString()}'); return false;");
                ((HiddenField)grdTable.Items[i].FindControl("hdn_idx")).Value = dt.Rows[i][0].ToString();
            }
        }

      
        
           
    protected void btn_update_hdn_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            int row = int.Parse(hdn_selectedRow.Value);

            string sql = $"UPDATE tb_shipment SET " +
                         $"payDate = '{((TextBox)grdTable.Items[row].FindControl("txt_paymentDate")).Text}' " +
                         $"WHERE idx = {((HiddenField)grdTable.Items[row].FindControl("hdn_idx")).Value};";

            try
            {
                km.ExSQL_Ret(sql);

                Response.Write("<script>alert('수정되었습니다.');</script>");
            }
            catch(Exception ex)
            {
                PROCEDURE.ERROR(ex.Message,km);
                Response.Write("<script>alert('수정 실패.');</script>");
            }
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            Search();
        }

        protected void btn_excel_Click(object sender, EventArgs e)
        {
            string filename = "출하용달료관리" + DateTime.Now.ToString("yyMMdd") + "ExportExcel.xls";
            System.IO.StringWriter tw = new System.IO.StringWriter();
            System.Web.UI.HtmlTextWriter hw = new System.Web.UI.HtmlTextWriter(tw);

            exceldiv3.RenderControl(hw);
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