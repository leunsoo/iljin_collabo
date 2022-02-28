using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MysqlLib;
using System.Data;

public class DefaultSet
{
    private static DB_mysql km;

    // test Table 참조
    // numberPos => test Table에서 가져온 값(ex: 1,2,3,..) 넣을 위치
    public static void DefaultGridSetting(DataGrid dataGrid, int numberPos)
    {
        if (km == null) km = new DB_mysql();

        DataTable dt = km.GetDTa("SELECT a from test");

        dataGrid.DataSource = dt;
        dataGrid.DataBind();
        int rowCount = dt.Rows.Count;

        for (int i = 0; i < rowCount; i++)
        {
            if (dt.Rows[i][0].ToString() != "") dataGrid.Items[i].Cells[numberPos].Text = dt.Rows[i][0].ToString();
        }
    }
}

public class Set
{
    private static DB_mysql km;

    //코드 콤보박스 세팅
    public static void Code_cb_Setting(DropDownList li, string code)
    {
        if (km == null) km = new DB_mysql();

        DataTable dt = km.GetCbDT(code);

        li.DataSource = dt;
        li.DataTextField = "code_name";
        li.DataValueField = "code_id";

        li.DataBind();
    }
}
