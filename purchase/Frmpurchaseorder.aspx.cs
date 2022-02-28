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

namespace iljin
{
    public partial class Frmpurchaseorder : ApplicationRoot
    {
        DB_mysql km = new DB_mysql();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();

                txt_registrationdate.Text = DateTime.Now.AddMonths(-3).ToString("yyyy-MM-01");
                txt_registrationdate2.Text = DateTime.Now.ToString("yyyy-MM-dd");

                Search();
            }
        }

        private void Search()
        {
            if (km == null) km = new DB_mysql();

            object[] objs = { txt_customer, txt_contractNo, txt_registrationdate,txt_registrationdate2 };

            DataTable dt = PROCEDURE.SELECT("SP_purchase_contract_GetBySearch",objs, km);

            grdTable.DataSource = dt;
            grdTable.DataBind();

            int rowCount = grdTable.Items.Count;
            int colCount = grdTable.Columns.Count;
            int no = 1;
            string contractId = "";
            int rowSpan = 1;
            //0~5까지 merge

            for(int i = 0; i < rowCount; i ++)
            {
                contractId = dt.Rows[i][0].ToString();
                grdTable.Items[i].Cells[0].Text = contractId;
                grdTable.Items[i].Cells[1].Text = no.ToString();

                //병합조건
                if (i < rowCount - 1 && contractId == dt.Rows[i+1][0].ToString())
                {
                    rowSpan++;

                    grdTable.Items[i - rowSpan + 2].Cells[1].RowSpan = rowSpan;
                    grdTable.Items[i + 1].Cells[1].Visible = false;

                    for (int j = 2; j < 7; j++)
                    {
                        grdTable.Items[i - rowSpan + 2].Cells[j].RowSpan = rowSpan;
                        grdTable.Items[i - rowSpan + 2].Cells[j].Text = dt.Rows[i][j-1].ToString();

                        grdTable.Items[i + 1].Cells[j].Visible = false;
                    }
                }else
                {
                    for (int j = 2; j < 7; j++)
                    {
                        grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                    }

                    rowSpan = 1;
                    no++;
                }

                for (int j = 7; j < colCount - 1; j++)
                {
                    if (dt.Rows[i][j - 1].ToString() != "") grdTable.Items[i].Cells[j].Text = dt.Rows[i][j - 1].ToString();
                }

                if (i == rowCount - 1)
                {
                    for (int j = 2; j < 7; j++)
                    {
                        if (grdTable.Items[i].Cells[j].Visible)
                        {
                            grdTable.Items[i].Cells[j].Text = dt.Rows[i][j-1].ToString();
                        }
                    }
                }

                ((Button)grdTable.Items[i].FindControl("grd_btn_contract")).Attributes.Add("onclick", $"purchase('{contractId}'); return false;");
                ((Button)grdTable.Items[i].FindControl("grd_btn_bl")).Attributes.Add("onclick", $"bl('{dt.Rows[i]["blId"].ToString()}',''); return false;");
            }
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            Search();
        }
    }
}