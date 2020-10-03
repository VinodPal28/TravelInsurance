using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Test : System.Web.UI.Page
{
    ConnectionToSql ConSql = new ConnectionToSql();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserId"] != null && Session["UserId"].ToString() != "0")
            {
                BindGridview();
            }
            else
            {
                Response.Redirect("../Home.aspx");
            }

        }
    }

    public void BindGridview()
    {
        DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_ABC", new object[] { "Get_GeoName", "P01" });
        if (ds.Tables[0].Rows.Count > 0)
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sb1 = new StringBuilder();

            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                sb.Append("<td>" + Convert.ToString(ds.Tables[0].Rows[i]["Geo_Name"] + "</td>"));

            }
            for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
            {
                DataSet ds1 = ConSql.ExecuteReader("Allianz_Travel", "USP_ABC1", new object[] { "Get_GeoName", "P01", ds.Tables[0].Rows[0]["Geo_Name"].ToString() });
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    for (int j = 0; j < ds1.Tables[0].Rows.Count; j++)
                    {
                        sb1.Append("<td>" + Convert.ToString(ds1.Tables[0].Rows[j]["Age"] + "</td>"));
                    }
                }
            }
            Age.InnerHtml = Convert.ToString(sb1);
            GeoName.InnerHtml = Convert.ToString(sb);
            
        }
    }
}