using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;
using System.Web.Script.Serialization;

namespace iljin
{
    public partial class Mobile_Get_ItemDiv : System.Web.UI.Page
    {
        DB_mysql km;

        private string itemDivCode = "";

        public string Result { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            SELECT_ItemDiv_to_Json();
        }

        //쿼리 실행결과 Json으로 변환
        private void SELECT_ItemDiv_to_Json()
        {
            DataTable dt = km.GetDTa(SELECT_Stock_SQL());

            List<Dictionary<string, string>> li = new List<Dictionary<string, string>>();
            JavaScriptSerializer jss = new JavaScriptSerializer();
            Dictionary<string, string> ja;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ja = new Dictionary<string, string>();
                ja.Add("ItemDivCode", dt.Rows[i][0].ToString());
                ja.Add("ItemDivName", dt.Rows[i][1].ToString());
                li.Add(ja);
            }

            Result = jss.Serialize(li);
        }
        
        //쿼리문 반환
        private string SELECT_Stock_SQL()
        {
            string sql = "SELECT " +
                         "code_id, " +
                         "code_name " +
                         "FROM tb_code " +
                        $"WHERE upper_id = '{itemDivCode}';";
           
            return sql;
        }
    }
}