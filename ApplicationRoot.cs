using MysqlLib;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace iljin
{
    public class ApplicationRoot : System.Web.UI.Page
    {
        protected DB_mysql km;

        protected void SetDBConnection()
        {
            if (km == null) km = new DB_mysql();
        }

        protected void redirect(string message)
        {
            Response.Write("<script>alert('"+message+"');location.href='/index.aspx'</script>");
            Response.End();
        }

        protected void warning(string message)
        {
            Response.Write("<script>alert('" + message + "');</script>");
        }

        protected override void OnPreLoad(EventArgs e)
        {
            if (Session["userCode"] == null)
            {
                redirect("세션이 만료되었습니다.");
            }
        }

    }
}