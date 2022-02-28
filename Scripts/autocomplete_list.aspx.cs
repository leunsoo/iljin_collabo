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
    public partial class autocomplete_list : ApplicationRoot
    {
        DB_mysql km;

        public string result = "";
        private string keyward = "";
        private string div = "";
        private string caseNo = "";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (km == null) km = new DB_mysql();

            keyward = Request.Params.Get("keyward");
            div = Request.Params.Get("div");
            caseNo = Request.Params.Get("caseNo");

            Search();
        }

        private void Search()
        {
            switch(div)
            {
                case "item":
                    ItemSearch();
                    break;
                case "customer":
                    customerSearch();
                    break;
                case "emp":
                    EmpSearch();
                    break;
                case "foreigner":
                    ForeignerSearch();
                    break;
            }
        }

        private void customerSearch()
        {
            string whereSQL = "";

            switch (caseNo)
            {
                case "전체":
                    whereSQL = "WHERE isUse = '1'";
                    break;
                case "매입":
                    whereSQL = "INNER JOIN tb_code b ON a.cusDivCode = b.code_id AND b.code_name LIKE '%매입%' " +
                               "WHERE a.isUse = '1'";
                    break;
                case "매출":
                    whereSQL = "INNER JOIN tb_code b ON a.cusDivCode = b.code_id AND b.code_name LIKE '%매출%' " +
                               "WHERE a.isUse = '1'";
                    break;
                case "용차":
                    whereSQL = "INNER JOIN tb_code b ON a.cusDivCode = b.code_id AND b.code_name LIKE '%용차%' " +
                               "WHERE a.isUse = '1'";
                    break;
                case "기타":
                    whereSQL = "INNER JOIN tb_code b ON a.cusDivCode = b.code_id AND b.code_name LIKE '%기타%' " +
                               "WHERE a.isUse = '1'";
                    break;
                case "매출기타":
                    whereSQL = "INNER JOIN tb_code b ON a.cusDivCode = b.code_id AND (b.code_name LIKE '%기타%' OR b.code_name LIKE '%매출%' )" +
                               "WHERE a.isUse = '1'";
                    break;
            }

            if (keyward != "")
            {
                string[] itemNameSplit = keyward.Split('|');

                for (int i = 0; i < itemNameSplit.Length; i++)
                {
                    if (itemNameSplit[i].Trim() != "")
                    {
                        whereSQL += $" AND cusName LIKE '%{itemNameSplit[i]}%'";
                    }
                }
            }

            DataTable dt = km.GetDTa($"SELECT cusName,cusCode FROM tb_customer a {whereSQL};");

            List<Dictionary<string, string>> li = new List<Dictionary<string, string>>();
            JavaScriptSerializer jss = new JavaScriptSerializer();
            Dictionary<string, string> ja;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ja = new Dictionary<string, string>();
                ja.Add("name", dt.Rows[i][0].ToString());
                ja.Add("code", dt.Rows[i][1].ToString());
                li.Add(ja);
            }

            if (dt.Rows.Count == 0)
            {
                ja = new Dictionary<string, string>();
                ja.Add("name", "조회된 결과가 없습니다.");
                ja.Add("code", "");
                li.Add(ja);
            }

            result = jss.Serialize(li);
        }

        private void ItemSearch()
        {
            string whereSQL = "";
            DataTable dt = new DataTable();

            switch (caseNo)
            {
                case "재고":
                    {
                        whereSQL = "WHERE b.isUse = 1 AND a.qty > 0";

                        if (keyward != "")
                        {
                            string[] itemNameSplit = keyward.Split('|');

                            for (int i = 0; i < itemNameSplit.Length; i++)
                            {
                                if (itemNameSplit[i].Trim() != "")
                                {
                                    whereSQL += $" AND fullName LIKE '%{itemNameSplit[i]}%'";
                                }
                            }
                        }

                        dt = km.GetDTa($"SELECT b.fullName, a.itemCode FROM tb_inventory a INNER JOIN tb_item b ON a.itemCode = b.itemCode { whereSQL};");
                    }
                    break;
                default:
                    {
                        whereSQL = "WHERE isUse = '1'";

                        if (keyward != "")
                        {
                            string[] itemNameSplit = keyward.Split('|');

                            for (int i = 0; i < itemNameSplit.Length; i++)
                            {
                                if (itemNameSplit[i].Trim() != "")
                                {
                                    whereSQL += $" AND fullName LIKE '%{itemNameSplit[i]}%'";
                                }
                            }
                        }

                        dt = km.GetDTa($"SELECT fullName,itemCode FROM tb_item {whereSQL};");

                    }
                    break;
            }

            List<Dictionary<string, string>> li = new List<Dictionary<string, string>>();
            JavaScriptSerializer jss = new JavaScriptSerializer();
            Dictionary<string, string> ja;

            for(int i = 0; i < dt.Rows.Count; i++)
            {
                ja = new Dictionary<string, string>();
                ja.Add("name", dt.Rows[i][0].ToString());
                ja.Add("code", dt.Rows[i][1].ToString());
                li.Add(ja);
            }

            if (dt.Rows.Count == 0)
            {
                ja = new Dictionary<string, string>();
                ja.Add("name", "조회된 결과가 없습니다.");
                ja.Add("code", "");
                li.Add(ja);
            }

            result = jss.Serialize(li);
        }

        private void EmpSearch()
        {
            string whereSQL = "WHERE isUse = '1'";
            if (keyward != "")
            {
                string[] itemNameSplit = keyward.Split('|');

                for (int i = 0; i < itemNameSplit.Length; i++)
                {
                    if (itemNameSplit[i].Trim() != "")
                    {
                        whereSQL += $" AND empName LIKE '%{itemNameSplit[i]}%'";
                    }
                }
            }

            DataTable dt = km.GetDTa($"SELECT empName,userCode FROM tb_emp {whereSQL};");

            List<Dictionary<string, string>> li = new List<Dictionary<string, string>>();
            JavaScriptSerializer jss = new JavaScriptSerializer();
            Dictionary<string, string> ja;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ja = new Dictionary<string, string>();
                ja.Add("name", dt.Rows[i][0].ToString());
                ja.Add("code", dt.Rows[i][1].ToString());
                li.Add(ja);
            }

            if (dt.Rows.Count == 0)
            {
                ja = new Dictionary<string, string>();
                ja.Add("name", "조회된 결과가 없습니다.");
                ja.Add("code", "");
                li.Add(ja);
            }

            result = jss.Serialize(li);
        }

        private void ForeignerSearch()
        {
            string whereSQL = "WHERE isUse = '1'";
            if (keyward != "")
            {
                string[] itemNameSplit = keyward.Split('|');

                for (int i = 0; i < itemNameSplit.Length; i++)
                {
                    if (itemNameSplit[i].Trim() != "")
                    {
                        whereSQL += $" AND name LIKE '%{itemNameSplit[i]}%'";
                    }
                }
            }

            DataTable dt = km.GetDTa($"SELECT name,idx FROM tb_foreigner {whereSQL};");

            List<Dictionary<string, string>> li = new List<Dictionary<string, string>>();
            JavaScriptSerializer jss = new JavaScriptSerializer();
            Dictionary<string, string> ja;

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                ja = new Dictionary<string, string>();
                ja.Add("name", dt.Rows[i][0].ToString());
                ja.Add("code", dt.Rows[i][1].ToString());
                li.Add(ja);
            }

            if (dt.Rows.Count == 0)
            {
                ja = new Dictionary<string, string>();
                ja.Add("name", "조회된 결과가 없습니다.");
                ja.Add("code", "");
                li.Add(ja);
            }

            result = jss.Serialize(li);
        }
    }
}