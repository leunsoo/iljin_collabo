using PublicLibsManagement;
using MysqlLib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;



namespace iljin.system
{
    public partial class Frmgroup : ApplicationRoot
    {
        DB_mysql km;
        private void search()
        {
            if (km == null) km = new DB_mysql();
            DataTable dt = PROCEDURE.SELECT("SP_authority_GetBySearch", km);
            grdTable1.DataSource = dt;
            grdTable1.DataBind();
            for (int i = 0; i < grdTable1.Items.Count; i++)
            {
                for (int j = 0; j < grdTable1.Columns.Count - 1; j++)
                {
                    grdTable1.Items[i].Cells[j].Text = dt.Rows[i][j].ToString();
                    grdTable1.Items[i].Cells[j].Attributes.Add("style", "cursor:pointer");
                    grdTable1.Items[i].Cells[j].Attributes.Add("onclick", "authority_select('" + dt.Rows[i]["authId"].ToString() + "','" + i.ToString() + "');");
                }
                ((Button)grdTable1.Items[i].FindControl("btn_edit")).Attributes.Add("onclick", "menu_auth_reg('" + dt.Rows[i]["authId"].ToString() + "'); return false;");
            }
        }

        private void setting_select(string authId)
        {
            if (km == null) km = new DB_mysql();
            DataTable dt = PROCEDURE.SELECT("SP_authoritysetting_GetByParent", authId, km);
            grdTable2.DataSource = dt;
            grdTable2.DataBind();
            for (int i = 0; i < grdTable2.Items.Count; i++)
            {
                for (int j = 0; j < grdTable2.Columns.Count - 1; j++)
                {
                    grdTable2.Items[i].Cells[j].Text = dt.Rows[i][j].ToString();
                }
                ((HiddenField)grdTable2.Items[i].FindControl("hidden_setId")).Value = dt.Rows[i]["setId"].ToString();
                ((CheckBox)grdTable2.Items[i].FindControl("chk_approach")).Checked = dt.Rows[i]["Isapproach"].ToString() == "1";
                ((CheckBox)grdTable2.Items[i].FindControl("chk_approach")).Attributes.Add("onchange", "chk_changed('" + i.ToString() + "');");
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                search();
            }
        }

        protected void btn_sch_Click(object sender, EventArgs e)
        {
            search();
        }

        protected void btn_select_Click(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string authId = Request["__EVENTARGUMENT"];
                setting_select(authId);
                for (int i = 0; i < grdTable1.Items.Count; i++)
                {
                    grdTable1.Items[i].BackColor = Color.White;
                }

                string selectedRow = hidden_selectedRow.Value;
                if (selectedRow != "")
                {
                    grdTable1.Items[Convert.ToInt32(selectedRow)].BackColor = Color.Cornsilk;
                }
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            HiddenField hdn;
            string sql = "";
            for (int i = 0; i < grdTable2.Items.Count; i++)
            {
                hdn = (HiddenField)grdTable2.Items[i].FindControl("hidden_updated");
                if (hdn.Value == "1")
                {

                    sql += $"UPDATE tb_authoritysetting SET " +
                           $"Isapproach = '{(((CheckBox)grdTable2.Items[i].FindControl("chk_approach")).Checked ? "1" : "0")}' " +
                           $"WHERE setId = '{ ((HiddenField)grdTable2.Items[i].FindControl("hidden_setId")).Value}';"; 
                }
            }

            int result = 1;
            if (sql != "")
            {
                if (km == null) km = new DB_mysql();
                result = km.ExSQL_Ret(sql);
            }

            if (result > 0)
            {
                Response.Write("<script>alert('저장되었습니다.');</script>");
            }
            else
            {
                Response.Write("<script>alert('저장 실패.');</script>");
            }


        }

    }
}