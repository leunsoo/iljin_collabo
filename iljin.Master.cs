using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using MySql.Data.MySqlClient;
using System.Data;
//using System.Windows.Forms;

namespace iljin
{
    public partial class iljin : System.Web.UI.MasterPage
    {
        DB_mysql km = new DB_mysql();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["menuList"] == null || Session["authId"] == null)
                {
                    Response.Write("<script>alert('세션이 만료되었습니다. 다시 로그인하여 주십시오.');location.href='/';</script>");
                    return;
                }

                string test = "얄루";

                hide_menu();
                string top = Request.QueryString["top"];
                string sub = Request.Params.Get("midx");
                try
                {
                    set_top(top);
                    selectedSubItem.Value = sub;
                    //sub_disp_T();
                    sub_disp_Left(top);
                }
                catch (Exception ex)
                { }
            }
        }

        private void hide_menu() //권한에 따라 1차 메뉴 숨기기
        {
            string menuList = Session["menuLIst"].ToString();
            _menu01.Visible = menuList.Contains("01");
            _menu02.Visible = menuList.Contains("09");
            _menu03.Visible = menuList.Contains("16");
            _menu04.Visible = menuList.Contains("20");
            _menu05.Visible = menuList.Contains("27");
            _menu06.Visible = menuList.Contains("32");
            _menu07.Visible = menuList.Contains("37");
        }

        private void sub_disp_Left(string top, bool redirect = false)
        {
            string SQL = "";
            string pag;
            DataTable dt = new DataTable();
            HyperLink catLink = new HyperLink();
            Object array_table = dl_Submenu;
            string array_tit = "l_tit0"; //, "l_tit1", "l_tit2", "l_tit3", "l_tit4", "l_tit5", "l_tit6", "l_tit7", "l_tit8", "l_tit9", "l_tit10" };
            string tit = array_tit;
            DataList tmp1 = new DataList();
            //tmp1 = (DataList)array_table;
            tmp1 = dl_Submenu;
            string path = "";
            TextBox temp1 = new TextBox();
            try
            {
                //경로찾기
                path = km.Path_search(top); // 경로
                if(Session["authId"].ToString() == "100000")
                {
                    SQL = "select DISTINCT koreanText,FormName,UpperMenuId,menuid from tb_menu a " +
                             "inner JOIN tb_authoritysetting b ON a.menuid = b.lowMenu " +
                             "where UpperMenuId ='" + top + "' order BY a.menuid ";
                }
                else
                {
                    SQL = "select koreanText,FormName,UpperMenuId,menuid from tb_menu a " +
                             "inner JOIN tb_authoritysetting b ON a.menuid = b.lowMenu AND b.authId = " + Session["authId"].ToString() + " AND b.Isapproach = 1 " +
                             "where UpperMenuId ='" + top + "' order BY a.menuid ";
                }
                km.Fill(SQL, dt);
                if (redirect)
                {
                    string url = "/" + path + "/" + dt.Rows[0][1].ToString() + ".aspx?top=" + t_top.Text + "&idx=7&midx=0&selected_idx=0"; // "system/Frmworkplace.aspx";
                    Response.Redirect(url);
                    return;
                }
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
                            catLink.Attributes.Add("onclick", "tsdisp('" + path + "','" + pag + "','" + dt.Rows[i][2].ToString() + "','" + dt.Rows[i][3].ToString() + "','" + i.ToString() + "'," + i + ");return false;");
                        }
                    }
                }

            }
            catch (Exception ex)
            { }
        }

        protected void btn_ck_Click(object sender, EventArgs e)
        {
            if (Session["menuList"] == null || Session["authId"] == null)
            {
                Response.Write("<script>alert('세션이 만료되었습니다. 다시 로그인하여 주십시오.');location.href='/';</script>");
                return;
            }
            string top = t_top.Text;
            sub_disp_Left(top,true);
        }

        private void set_top(string top)
        {
            _menu01.Attributes.Remove("class");
            _menu01.Attributes.Add("class", "menu01");

            _menu02.Attributes.Remove("class");
            _menu02.Attributes.Add("class", "menu02");

            _menu03.Attributes.Remove("class");
            _menu03.Attributes.Add("class", "menu03");

            _menu04.Attributes.Remove("class");
            _menu04.Attributes.Add("class", "menu04");

            _menu05.Attributes.Remove("class");
            _menu05.Attributes.Add("class", "menu05");

            _menu06.Attributes.Remove("class");
            _menu06.Attributes.Add("class", "menu06");

            _menu07.Attributes.Remove("class");
            _menu07.Attributes.Add("class", "menu07");

            switch (top)
            {
                case "1": _menu01.Attributes.Add("class", "menu01 on"); break;
                case "9": _menu02.Attributes.Add("class", "menu02 on"); break;
                case "16": _menu03.Attributes.Add("class", "menu03 on"); break;
                case "20": _menu04.Attributes.Add("class", "menu04 on"); break;
                case "27": _menu05.Attributes.Add("class", "menu05 on"); break;
                case "32": _menu06.Attributes.Add("class", "menu06 on"); break;
                case "37": _menu07.Attributes.Add("class", "menu07 on"); break;
            }
        }
        //private void sub_disp_L()
        //{
        //    string SQL = "";
        //    string pag;
        //    DataTable dt = new DataTable();
        //    HyperLink catLink = new HyperLink();
        //  //  Object[] array_table = { dl_Submenu0, dl_Submenu1, dl_Submenu2, dl_Submenu3, dl_Submenu4, dl_Submenu5, dl_Submenu6, dl_Submenu7, dl_Submenu8, dl_Submenu9, dl_Submenu10 };
        //  //  string[] array_tit = { "l_tit0", "l_tit1", "l_tit2", "l_tit3", "l_tit4", "l_tit5", "l_tit6", "l_tit7", "l_tit8", "l_tit9", "l_tit10" };
        //    DataList tmp1 = new DataList();
        //    string tit = "";
        //    string top1 = "";
        //    string path = "";
        //    TextBox temp1 = new TextBox();
        //    try
        //    {
        //        for (int k = 0; k < array_tit.Length; k++)
        //        {
        //            top1 = Config.array_txt[k];
        //            path = Config.array_path[k].ToString();  //경로
        //            SQL = "select koreanText,FormName,UpperMenuId,menuid from tb_menu " +
        //                "where UpperMenuId ='" + top1 + "' order by menuid";

        //         //   tmp1 = (DataList)array_table[k];
        //            tit = array_tit[k];
        //            km.Fill(SQL, dt);
        //            tmp1.DataSource = dt;
        //            tmp1.DataBind();
        //            int Cnt = dt.Rows.Count - 1;

        //            for (int i = 0; i <= Cnt; i++)
        //            {
        //                pag = "";
        //                if (dt.Rows[i][1] != "") pag = dt.Rows[i][1].ToString();
        //                if (dt.Rows[i][0] != "")
        //                {
        //                    catLink = (HyperLink)tmp1.Items[i].FindControl(tit);
        //                    catLink.Text = "     " + dt.Rows[i][0].ToString().Trim();
        //                    if (dt.Rows[i][1] != "" && pag != "")
        //                    {
        //                        pag = pag + ".aspx";
        //                        catLink.Attributes.Add("style", "cursor:pointer;width:200px;");
        //                        catLink.Attributes.Add("onclick", "tsdisp('" + path + "','" + pag + "','" + dt.Rows[i][2].ToString() + "','" + dt.Rows[i][3].ToString() + "','" + i.ToString() + "');return false;");
        //                    }
        //                }
        //            }
        //            km.dbClose();
        //        }
        //    }
        //    catch (Exception ex)
        //    { }
        //} 
    }
}