using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;
using System.Drawing;
using System.Diagnostics;
using PublicLibsManagement;
using BasicManagement;
using MySql.Data.MySqlClient;

namespace idakconet
{
    public partial class board_write : System.Web.UI.Page
    {
        DB_mysql km = new DB_mysql();
        protected void Page_Load(object sender, EventArgs e)
        {
            t_ser.Attributes["onkeypress"] = " if (event.keyCode==13) {" + Page.ClientScript.GetPostBackEventReference(btn_ck1, "") + ";return false;}";
            if (!IsPostBack)
            {   //HttpContext.Current.Request
                if (Request.Cookies["empidd"].ToString() != null)
                {
                    string idd = Request.Cookies["empidd"].Value;
                }
                calendar_type01.Attributes["onkeyup"] = "{make_date(this); return false;}";
                calendar_type01.Text = string.Format("{0:0000-00-00}", DateTime.Now.ToShortDateString()); //.Get_CUDate;
                search("");
            }
        }

        private void search(string tit)
        {
            km.dbOpen();
            string strSQL = String.Format("usp_board_S '{0}'", tit);
            DataTable dt = new DataTable();
            dt = km.GetDTa(strSQL);
            this.grid_code.DataSource = dt;
            this.grid_code.DataBind();
            int rCnt = dt.Rows.Count;


            for (int i = 0; i < rCnt; i++)
            {
                for (int k = 0; k < dt.Columns.Count; k++)
                {
                    if (dt.Rows[i][k] != "") this.grid_code.Items[i].Cells[k].Text = dt.Rows[i][k].ToString();
                    this.grid_code.Items[i].Attributes.Add("style", "cursor:pointer");
                    this.grid_code.Items[i].Attributes.Add("onclick", "sub_disp('" + dt.Rows[i][0].ToString() + "','"+ i.ToString() +"')");
                }
            }

            km.dbClose();
            //text_clear();
        }

        protected void btn_new_Click(object sender, EventArgs e)
        {
            text_clear();
            string idx = Str_no.Text;
            if (idx == "")
            {
                string table = "board";
                string keyval = "idx";
                string whe1 = "''";
                Str_no.Text = Seq(table, keyval, whe1); //번호 증가
            }
            Str_tit.Focus();
        }

        public string Seq(string table, string key, string whe)
        {
            string Ret = "";
            km.dbOpen();
            string ret_sql = "exec USP_SEQ '" + table + "','" + key + "'," + whe;
            MySqlDataReader hr = km.ExecuteReader(ret_sql);

            if (hr.Read())
            {
                if (hr[0] != "") Ret = hr[0].ToString();
            }
            hr.Dispose();
            km.dbClose();
            hr.Close();
            return Ret;
        }

        protected void btn_cancel_Click(object sender, EventArgs e)
        {
            text_clear();
        }

        private void text_clear()
        {
            t_ser.Text = ""; Str_cont.Text = ""; Str_no.Text = "";
            Str_tit.Text = ""; Str_wname.Text = "";
        }

        protected void btn_search_Click(object sender, EventArgs e)
        {
            string tit = t_ser.Text;
            search(tit);
        }

        protected void btn_ck_Click(object sender, EventArgs e)
        {
            km.dbOpen();
            string midx = this.Str_no.Text;
            string asql = "select * from board where idx='" + midx + "'";
            //string sql = string.Format("exec SP_emp_GeyByParent '{0}'", txt_code.Text);
            //Sdt = DBOPEN.GetDT(sql);
            //object[] obj = {txt_code,txt_name,dt_birth,txt_tel,txt_movetel,dt_entry,dt_retire,cb_office1,cb_department1,cb_type1
            //    ,txt_zip,txt_address,txt_email,txt_bigo,txt_pwd};
            //PublicLibs.DataMove(Sdt, obj);
            MySqlDataReader hr = km.ExecuteReader(asql);
            if (hr.Read())
            {
                if (hr[0] != "") Str_no.Text = hr[0].ToString();
                if (hr[1] != "") Str_tit.Text = hr[1].ToString();
                if (hr[2] != "") Str_wname.Text = hr[2].ToString();
                if (hr[3] != "") calendar_type01.Text = hr[3].ToString();
                if (hr[4] != "") Str_cont.Text = hr[4].ToString();

            }
            hr.Close();
            for (int i = 0; i < this.grid_code.Items.Count; i++)
            {
                grid_code.Items[i].BackColor = Color.White;
            }
            int rcnt = Int32.Parse(row_idx.Text);
            grid_code.Items[rcnt].BackColor = Color.AntiqueWhite;
            km.dbClose();
        }

        protected void btn_del_Click(object sender, EventArgs e)
        {
            if (Str_no.Text != "")
            {
                Msg.Text = "삭제하시겠습니까  ????";
                mesDP.Visible = true;
                msg_gu.Text = "Del";
            }
        }

        private void del_proc()
        {
            string idx = Str_no.Text;
            if (idx != "")
            {
                km.Open();
                string sql = "delete from board where idx='" + idx + "'"; ;
                km.ExSQL_Ret(sql);
                km.dbClose();
                search("");
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (Str_tit.Text != "")
            {
                Msg.Text = "저장하시겠습니까  ????";
                mesDP.Visible = true;
                msg_gu.Text = "Sav";
            }
        }

        private void save_proc()
        {
            int idx = Int32.Parse(Str_no.Text);
            if (idx > 0)
            {
                object[] obj = { Str_no, Str_tit, Str_wname, calendar_type01, Str_cont };
                string[] data = PublicLibs.DataArrayMove(obj);

                BoardLib lib = new BoardLib();
                int ret = DB_RECYN(idx);
                switch (ret)
                {
                    case 0:  //insert
                        lib.Add(data);
                        break;
                    default:  //update
                        lib.Update(data);
                        break;
                }
                search("");
            }
        }


        public int DB_RECYN(int idx)  //'조건에 의한 자료 확인
        {
            km.dbOpen();
            int ret = 0;
            string ret_sql = "select count(idx) from board where idx='" + idx + "'";
           MySqlDataReader hr = km.ExecuteReader(ret_sql);
            if (hr.Read())
            {
                if (hr[0] != "") ret = Int16.Parse(hr[0].ToString());
            }
            hr.Dispose();
            hr.Close();
            km.dbClose();
            return ret;
        }

        protected void btn_close_Click(object sender, EventArgs e)
        {
            Response.Redirect("/board/board.aspx?top=1000&idx=1");

        }

        protected void No_BT_Click(object sender, EventArgs e)
        {
            msg_gu.Text = "";
            mesDP.Visible = false;
        }

        protected void Yes_BT_Click(object sender, EventArgs e)
        {
            mesDP.Visible = false;
            switch (msg_gu.Text)
            {
                case "Del":
                    del_proc();
                    break;
                case "Sav":
                    save_proc();
                    break;
            }
        msg_gu.Text = "";
        }
    }
}