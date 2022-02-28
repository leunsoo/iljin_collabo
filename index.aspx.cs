using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using MysqlLib;
using System.Windows.Forms;
using System.Data;
using PublicLibsManagement;

namespace iljin
{
    public partial class index : System.Web.UI.Page
    {
        DB_mysql km = new DB_mysql();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string CURL = Server.MapPath("bin/");
                string URL1 = CURL + Config.cfgFile;

                if (Request.Cookies["empid"] != null)
                {
                    txt_ID.Text = HttpUtility.UrlDecode(Request.Cookies["empid"].Value);
                    txt_Pass.Attributes.Add("value", HttpUtility.UrlDecode(Request.Cookies["emppw"].Value));
                    chk_rememberInfo.Checked = true;
                }
    
                try
                {
                    km.dbOpen();
                    string SQL = "SELECT  menuid,path FROM tb_menu where uppermenuid is null order by menuord";
                    DataTable dt = new DataTable();
                    km.Fill(SQL, dt);
                    km.dbClose();
                }
                catch (Exception ex)
                {

                }
            }
        }

        protected void btn_login_Click(object sender, EventArgs e)
        {
            login_proc();
        }

        private void login_proc()
        {
            //string ComName = txt_com.Text;
            string username = txt_ID.Text;
            string password = txt_Pass.Text;
            string comCO = "";
            string comNM = "";
            DataTable dt = DB_mysql.UserLogin(username, password);

            if (dt.Rows.Count == 0)
            {
                Response.Write("<script>alert('등록되지 않은 아이디이거나 비밀번호가 일치하지 않습니다.');</script>");
            }
            else
            {
                if (km == null) km = new DB_mysql();
                string sql = "";

                if (dt.Rows[0]["userCode"].ToString() == "1")
                {
                    sql = "SELECT DISTINCT GROUP_CONCAT(DISTINCT LPAD(highMenu,2,0)) FROM tb_authoritysetting a GROUP BY a.authId;";
                }
                else
                {
                     sql = "SELECT GROUP_CONCAT(DISTINCT LPAD(highMenu,2,0)) FROM tb_authoritysetting a " +
                                 " WHERE a.authId = '" + dt.Rows[0]["authorityCode"].ToString() + "' AND a.Isapproach = 1 " +
                                 " GROUP BY a.authId;";
                }

                DataTable auth_dt = km.GetDTa(sql);

                if (auth_dt.Rows.Count == 0)
                {
                    Response.Write("<script>alert('해당 계정에 부여된 권한이 없습니다.');</script>");
                    return;
                }
                string menuList = auth_dt.Rows[0][0].ToString();

                Session["authId"] = dt.Rows[0]["authorityCode"].ToString(); //권한 ID
                Session["menuList"] = menuList; //1차메뉴 항목

                if (chk_rememberInfo.Checked)
                {
                    Response.Cookies["empid"].Value = HttpUtility.UrlEncode(username);
                    Response.Cookies["emppw"].Value = HttpUtility.UrlEncode(password);
                    Response.Cookies["empid"].Expires = DateTime.Now.AddMonths(1);
                    Response.Cookies["emppw"].Expires = DateTime.Now.AddMonths(1);
                }
                else
                {
                    Response.Cookies["empid"].Expires = DateTime.Now.AddDays(-1);
                    Response.Cookies["emppw"].Expires = DateTime.Now.AddDays(-1);
                }

                Session["userCode"] = dt.Rows[0]["userCode"].ToString();

                string ipaddr = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                if (string.IsNullOrEmpty(ipaddr))
                    ipaddr = Request.ServerVariables["REMOTE_ADDR"];

                object[] objs = { ipaddr, username };
                PROCEDURE.CUD("SP_loginhistory_Add", objs, km);

                UnitpriceUpdate();

                string url = "/stock/Frmstock.aspx?top=20&midx=0"; 
                Response.Redirect(url);
            }
        }

        //날짜별 단가 변경
        private void UnitpriceUpdate()
        {
            try
            {
                DataTable dt = PROCEDURE.SELECT("SP_unitprice_GetByUpdatable", DateTime.Now.ToString("yyyy-MM-dd"), km);

                string sql = "";

                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    sql += "UPDATE tb_item SET " +
                          $"unitprice = '{dt.Rows[i]["unitprice"].ToString()}' " +
                          $"WHERE itemCode = '{dt.Rows[i]["itemCode"]}';";

                    sql += "UPDATE tb_unitprice SET " +
                           "isChkUpdate = '1' " +
                          $"WHERE idx = '{dt.Rows[i]["idx"].ToString()}';";
                }

                if(sql!= "")
                {
                    km.ExSQL_Ret(sql);
                }
            }
            catch
            {

            }
        }
    }
}