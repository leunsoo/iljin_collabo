using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using MysqlLib;
using PublicLibsManagement;
using System.IO;

namespace iljin
{
    public partial class Frmcompany : ApplicationRoot
    {
        DB_mysql km;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                if (km == null) km = new DB_mysql();
                select();
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            string comId;

            string logo_file_name = "";
            string stamp_file_name = "";

            if (fl_logo_input.HasFile)
            {
                logo_file_name = fl_logo_input.FileName;
                logo_file_name = "_logo" + logo_file_name.Substring(logo_file_name.LastIndexOf("."));
            }
            if (fl_stamp_input.HasFile)
            {
                stamp_file_name = fl_stamp_input.FileName;
                stamp_file_name = "_stamp" + stamp_file_name.Substring(stamp_file_name.LastIndexOf("."));
            }

            if (hidden_comid.Value != "") //수정
            {
                comId = hidden_comid.Value;
                object[] obj = {comId,txt_com_name,txt_ceo_name,txt_com_business_conditions,txt_com_business_type,txt_com_no,txt_corporate_no,
                txt_com_email,txt_com_tel,txt_com_hp,txt_com_fax,txt_com_post,txt_com_addr,txt_com_addr2,txt_manager,txt_manager_tel,txt_manager_hp,
                txt_manager_email,logo_file_name,stamp_file_name,ta_memo.Value};

                km.BeginTran();

                int result = PROCEDURE.CUD_TRAN("SP_company_Update", obj, km);

                if (result == 1)
                {
                    try
                    {
                        if (logo_file_name != "")
                        {
                            delete_file(comId, "_logo"); //기존 파일 삭제            
                            fl_logo_input.SaveAs(HttpContext.Current.Request.PhysicalApplicationPath + ConstClass.COMPANY_FILE_PATH + comId + logo_file_name);
                        }
                        if (stamp_file_name != "")
                        {
                            delete_file(comId, "_stamp"); //기존 파일 삭제            
                            fl_stamp_input.SaveAs(HttpContext.Current.Request.PhysicalApplicationPath + ConstClass.COMPANY_FILE_PATH + comId + stamp_file_name);
                        }

                        km.Commit();
                    }
                    catch (Exception ex)
                    {
                        km.Rollback();
                        Response.Write("<script>alert('저장 실패');</script>");
                        return;
                    }
                }
                else
                {
                    km.Rollback();
                    Response.Write("<script>alert('저장 실패');</script>");
                    return;
                }
            }
            //else //추가
            //{
            //    object[] obj = {ConstClass.CUSTOMER_CODE_PREFIX,txt_com_name,txt_ceo_name,txt_com_business_conditions,txt_com_business_type,txt_com_no,txt_corporate_no,
            //    txt_com_email,txt_com_tel,txt_com_hp,txt_com_fax,txt_com_post,txt_com_addr,txt_com_addr2,txt_manager,txt_manager_tel,txt_manager_hp,
            //    txt_manager_email,logo_file_name,stamp_file_name,ta_memo.Value};

            //    km.BeginTran();
            //    comId = lib.ADD(obj, km);

            //    if (comId != null)
            //    {
            //        try
            //        {
            //            if (logo_file_name != "") fl_logo_input.SaveAs(HttpContext.Current.Request.PhysicalApplicationPath + ConstClass.COMPANY_FILE_PATH + comId + logo_file_name);
            //            if (stamp_file_name != "") fl_stamp_input.SaveAs(HttpContext.Current.Request.PhysicalApplicationPath + ConstClass.COMPANY_FILE_PATH + comId + stamp_file_name);
            //            km.Commit();
            //        }
            //        catch (Exception ex)
            //        {
            //            km.Rollback();
            //            Response.Write("<script>alert('저장 실패');</script>");
            //            return;
            //        }
            //    }
            //    else
            //    {
            //        km.Rollback();
            //        Response.Write("<script>alert('저장 실패');</script>");
            //        return;
            //    }
            //}

            select();
            Response.Write("<script>alert('저장되었습니다.');</script");
        }

        private void select()
        {
            DataTable dt = PROCEDURE.SELECT("SP_company_Info", km);

            if (dt.Rows.Count != 0)
            {
                hidden_comid.Value = dt.Rows[0]["comid"].ToString();
                txt_com_name.Text = dt.Rows[0]["comName"].ToString();
                txt_ceo_name.Text = dt.Rows[0]["comBossName"].ToString();
                txt_com_business_conditions.Text = dt.Rows[0]["combusiness"].ToString();
                txt_com_business_type.Text = dt.Rows[0]["comType"].ToString();
                txt_com_no.Text = dt.Rows[0]["comregistration"].ToString();
                txt_corporate_no.Text = dt.Rows[0]["comregistre"].ToString();
                txt_com_email.Text = dt.Rows[0]["commail"].ToString();
                txt_com_tel.Text = dt.Rows[0]["comTel"].ToString();
                txt_com_hp.Text = dt.Rows[0]["comMobile"].ToString();
                txt_com_fax.Text = dt.Rows[0]["comFax"].ToString();
                txt_com_post.Text = dt.Rows[0]["zipcode"].ToString();
                txt_com_addr.Text = dt.Rows[0]["address1"].ToString();
                txt_com_addr2.Text = dt.Rows[0]["address2"].ToString();
                txt_manager.Text = dt.Rows[0]["taxPerson"].ToString();
                txt_manager_tel.Text = dt.Rows[0]["taxPersonTel"].ToString();
                txt_manager_hp.Text = dt.Rows[0]["taxPersonmobile"].ToString();
                txt_manager_email.Text = dt.Rows[0]["taxpersonMail"].ToString();
                string logofile = dt.Rows[0]["comLogo"].ToString();
                string stampfile = dt.Rows[0]["comStamp"].ToString();
                ta_memo.Value = dt.Rows[0]["comMemo"].ToString();

                if (logofile != "")
                {
                    logo_prev.Attributes.Add("src", ConstClass.COMPANY_FILE_PATH + logofile);// ConstClass.COMPANY_FILE_PATH + logofile);                               
                }
                if (stampfile != "")
                {
                    stamp_prev.Attributes.Add("src", ConstClass.COMPANY_FILE_PATH + stampfile);
                }
            }
        }

        private void delete_file(string id, string div)
        {
            DirectoryInfo path = new DirectoryInfo(Server.MapPath(ConstClass.COMPANY_FILE_PATH));

            FileInfo[] files = path.GetFiles(id + div + "*.*");

            for (int i = 0; i < files.Length; i++)
            {
                files[i].Delete();
            }
        }

        protected void btn_del_logo_ServerClick(object sender, EventArgs e)
        {
            string comid = hidden_comid.Value;
            if (km == null) km = new DB_mysql();
            km.BeginTran();
            int result;

            object[] obj = { hidden_comid.Value };

            try
            {
                result = PROCEDURE.CUD_TRAN("SP_company_DeleteLogo", obj, km);
                if (result != 1)
                {
                    km.Rollback();
                    Response.Write("<script>alert('삭제 실패');</script>");
                }
                delete_file(comid, "_logo");
            }
            catch (Exception ex)
            {
                km.Rollback();
                Response.Write("<script>alert('삭제 실패');</script>");
            }

            km.Commit();
            fl_logo_input.Dispose();
            logo_prev.Attributes.Add("src", "../webapp/img/logo_photo.jpg");
            Response.Write("<script>alert('삭제되었습니다.');</script>");
        }

        protected void btn_del_stamp_ServerClick(object sender, EventArgs e)
        {
            string comid = hidden_comid.Value;
            if (km == null) km = new DB_mysql();
            km.BeginTran();
            int result;

            object[] obj = { hidden_comid.Value };

            try
            {
                result = PROCEDURE.CUD_TRAN("SP_company_DeleteStamp", obj, km);
                if (result != 1)
                {
                    km.Rollback();
                    Response.Write("<script>alert('삭제 실패');</script>");
                }
                delete_file(comid, "_stamp");
            }
            catch (Exception ex)
            {
                km.Rollback();
                Response.Write("<script>alert('삭제 실패 : " + ex.Message + "');</script>");
            }

            km.Commit();
            fl_stamp_input.Dispose();
            stamp_prev.Attributes.Add("src", "../webapp/img/stamp_photo.jpg");
            Response.Write("<script>alert('삭제되었습니다');</script>");
        }
    }
}