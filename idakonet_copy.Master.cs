using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using MySql.Data.MySqlClient;
using System.Data;

namespace idakonet
{
    public partial class idakonet_copy : System.Web.UI.MasterPage
    {
        DB_mysql km = new DB_mysql();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string top = Request.QueryString["top"];
                try
                {
                    if (top == "") top = "1";
                    menu_top_name();
                    sub_disp_T();
                    sub_disp_L();
                }
                catch (Exception ex)
                { }
            }
        }

        private void menu_top_name()
        {
            object[] array_menu_name = { btn_01, btn_02, btn_03, btn_04, btn_05, btn_06, btn_07, btn_08, btn_09, btn_10, btn_11 };
            object[] array_menu_name1 = { btn_01_1, btn_02_1, btn_03_1, btn_04_1, btn_05_1, btn_06_1, btn_07_1, btn_08_1, btn_09_1, btn_10_1, btn_11_1 };
            Label tmp1, tmp2;
            DataTable dt = new DataTable();
            string SQL = "SELECT koreanText,menuid FROM tb_menu where uppermenuid is null order by menuord";
            km.Fill(SQL, dt);//메인 메뉴

            int Rcnt = array_menu_name.Length;
            if (dt.Rows.Count >= 1)
            {
                for (int i = 0; i < Rcnt; i++)
                {
                    if (dt.Rows[i][0] != null)
                    {
                        tmp1 = (Label)array_menu_name[i];
                        tmp2 = (Label)array_menu_name1[i];
                        tmp1.Text = dt.Rows[i][0].ToString();
                        tmp2.Text = dt.Rows[i][0].ToString();
                    }
                }
            }
            dt.Clone();
            km.dbClose();
        }

        private void sub_disp_T()
        {
            string SQL = "";
            DataTable dt = new DataTable();
            string pag = "";

            HyperLink catLink = new HyperLink();
            object[] array_table = { dl_Submenu0_1, dl_Submenu1_1, dl_Submenu2_1, dl_Submenu3_1, dl_Submenu4_1, dl_Submenu5_1, dl_Submenu6_1, dl_Submenu7_1, dl_Submenu8_1, dl_Submenu9_1, dl_Submenu10_1 };
            string[] array_tit = { "l_tit0_1", "l_tit1_1", "l_tit2_1", "l_tit3_1", "l_tit4_1", "l_tit5_1", "l_tit6_1", "l_tit7_1", "l_tit8_1", "l_tit9_1", "l_tit10_1" };
            DataList tmp1 = new DataList();
            string tit = "";
            string top1 = "";
            string path = "";
            try
            {
                for (int k = 0; k < array_table.Length; k++)
                {
                    dt = new DataTable();
                    top1 =Config.array_txt[k].ToString();   //상위메뉴
                    path = Config.array_path[k].ToString();  //경로

                    SQL = "select koreanText,FormName,UpperMenuId,menuid from tb_menu " +
                        "where UpperMenuId ='" + top1 + "' order by menuid";
                    tmp1 = (DataList)array_table[k];
                    tit = array_tit[k];
                    km.Fill(SQL, dt);
                    tmp1.DataSource = dt;
                    tmp1.DataBind();
                    int Cnt = dt.Rows.Count - 1;
                    for (int i = 0; i <= Cnt; i++)
                    {
                        pag = "";
                        if (dt.Rows[i][1] != "") pag = dt.Rows[i][1].ToString();
                        if (dt.Rows[i][0] != "")
                        {
                            catLink = (HyperLink)tmp1.Items[i].FindControl(tit);
                            catLink.Text = "     " + dt.Rows[i][0];
                            if (dt.Rows[i][1] != "" && pag != "")
                            {
                                pag = pag + ".aspx";
                                catLink.Attributes.Add("style", "cursor:pointer;width:136px;");
                                catLink.Attributes.Add("onclick", "tsdisp('" + path + "','" + pag + "','" + dt.Rows[i][2].ToString() + "','" + dt.Rows[i][3].ToString() + "','" + i.ToString() + "');return false;");
                            }
                        }
                    }
                    km.dbClose();
                }
            }
            catch (Exception ex)
            { }
        }

        private void sub_disp_L()
        {
            string SQL = "";
            string pag;
            DataTable dt = new DataTable();
            HyperLink catLink = new HyperLink();
            Object[] array_table = { dl_Submenu0, dl_Submenu1, dl_Submenu2, dl_Submenu3, dl_Submenu4, dl_Submenu5, dl_Submenu6, dl_Submenu7, dl_Submenu8, dl_Submenu9, dl_Submenu10 };
            string[] array_tit = { "l_tit0", "l_tit1", "l_tit2", "l_tit3", "l_tit4", "l_tit5", "l_tit6", "l_tit7", "l_tit8", "l_tit9", "l_tit10" };
            DataList tmp1 = new DataList();
            string tit = "";
            string top1 = "";
            string path = "";
            TextBox temp1 = new TextBox();
            try
            {
                for (int k = 0; k < array_table.Length; k++)
                {
                    top1 = Config.array_txt[k];
                    path = Config.array_path[k].ToString();  //경로
                    //SQL = "SELECT  mt.m_idx, mm.bottomcate_name, mm.bottomcate_page, mm.bottomcate_no, mt.m_path " +
                    //    " FROM menu_top AS mt " +
                    //    "INNER JOIN menu_main As mm On mt.m_idx = mm.m_idx  and use_yn='Y'" +
                    //    "where mt.m_idx='" + top1 + "' order by Bottomcate_No asc";
                    SQL = "select koreanText,FormName,UpperMenuId,menuid from tb_menu " +
                        "where UpperMenuId ='" + top1 + "' order by menuid";

                    tmp1 = (DataList)array_table[k];
                    tit = array_tit[k];
                    km.Fill(SQL, dt);
                    tmp1.DataSource = dt;
                    tmp1.DataBind();
                    int Cnt = dt.Rows.Count - 1;

                    for (int i = 0; i <= Cnt; i++)
                    {
                        pag = "";
                        if (dt.Rows[i][1] != "") pag = dt.Rows[i][1].ToString();
                        if (dt.Rows[i][0] != "")
                        {
                            catLink = (HyperLink)tmp1.Items[i].FindControl(tit);
                            catLink.Text = "     " + dt.Rows[i][0].ToString().Trim();
                            if (dt.Rows[i][1] != "" && pag != "")
                            {
                                pag = pag + ".aspx";
                                catLink.Attributes.Add("style", "cursor:pointer;width:200px;");
                                catLink.Attributes.Add("onclick", "tsdisp('" + path + "','" + pag + "','" + dt.Rows[i][2].ToString() + "','" + dt.Rows[i][3].ToString() + "','" + i.ToString() + "');return false;");
                            }
                        }
                    }
                    km.dbClose();
                }
            }
            catch (Exception ex)
            { }
        }
    }
}