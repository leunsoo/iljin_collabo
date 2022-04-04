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
    public partial class Mobile_Stock : System.Web.UI.Page
    {
        DB_mysql km;

        private string result        = "";

        private string itemName      = ""; //제품명
        private string itemDiv1      = ""; //제품구분1
        private string itemDiv2      = ""; //제품구분2
        private string itemThickness = ""; //제품두께
        private string itemWidth1    = ""; //제품폭1
        private string itemWidth2    = ""; //제품폭2
        private string itemMemo      = ""; //제품길이

        public string Result
        {
            get => result;
            set => result = value;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            SELECT_Stock_to_Json();
        }

        //쿼리 실행결과 Json으로 변환
        private void SELECT_Stock_to_Json()
        {
            DataTable dt = km.GetDTa(SELECT_Stock_SQL());

            List<Dictionary<string, string>> li = new List<Dictionary<string, string>>();
            JavaScriptSerializer jss = new JavaScriptSerializer();
            Dictionary<string, string> ja;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ja = new Dictionary<string, string>();
                ja.Add("ItemCode", dt.Rows[i][0].ToString());
                ja.Add("ItemDiv", dt.Rows[i][1].ToString());
                ja.Add("ItemThickness", dt.Rows[i][2].ToString());
                ja.Add("ItemWidth", dt.Rows[i][3].ToString());
                ja.Add("ItemLength", dt.Rows[i][4].ToString());
                ja.Add("ItemQty", dt.Rows[i][5].ToString());
                li.Add(ja);
            }

            Result = jss.Serialize(li);
        }
        
        //쿼리문 반환
        private string SELECT_Stock_SQL()
        {
            string sql = "SELECT " +
                         "a.itemCode, " +
                         "CONCAT(c.code_name, '_', d.code_name) AS itemDiv, " +
                         "b.thickness, " +
                         "b.width, b.length, " +
                         "a.qty, " +
                         "b.memo " +
                         "FROM tb_inventory a " +
                         "INNER JOIN tb_item b ON a.itemCode = b.itemCode " +
                         "INNER JOIN tb_code c ON b.divCode1 = c.code_id " +
                         "INNER JOIN tb_code d ON b.divCode2 = d.code_id ";

            string whereSql = "";

            string limitSql = "LIMIT 100;";

            //제품명
            if(itemName != "") {
                whereSql += $"b.fullName LIKE '%{itemName}%' AND ";
            }

            //제품구분1
            if (itemDiv1 != "") {
                whereSql += "";
            }

            //제품구분2
            if (itemDiv2 != "") {
                whereSql += "";
            }

            //제품 두께
            if (itemThickness != "") {
                whereSql += $"b.thickness = {itemThickness} AND ";
            }

            //제품 폭
            if (itemWidth1 != "" && itemWidth2 == "") {
                whereSql += $"b.width >= {itemWidth1} AND ";
            }
            else if (itemWidth1 == "" && itemWidth2 != ""){
                whereSql += $"b.width <= {itemWidth2} AND";
            }
            else if(itemWidth1 != "" && itemWidth2 != "") {
                whereSql += $"b.width BETWEEN {itemWidth1} AND {itemWidth2} AND ";
            }

            //비고
            if (itemMemo != "") {
                whereSql += $"b.memo LIKE '%{itemMemo}%' AND ";
            }

            //where 절이 있냐 없냐에 따라 다른 sql 반환
            if (whereSql != "")
            {
                whereSql.Insert(0, "WHERE ").Substring(0,whereSql.Length - 4);
                return sql + whereSql + limitSql;
            }
            else
            {
                return sql + limitSql;
            }
        }
    }
}