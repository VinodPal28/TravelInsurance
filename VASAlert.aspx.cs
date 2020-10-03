using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class VASAlert : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["Id"] != null)
        {
            int ID = Convert.ToInt32(Request.QueryString["Id"]);
            Get_VASMSG(ID);

        }
    }
    protected void Get_VASMSG(int ID)
    {
        if (ID == 1)
        {
            Div_Alert.Visible = true;
            Success.Visible = false;
            D_NotExist.Visible = false;
            travelstartdate.Visible = false;
        }
        else if (ID == 2)
        {
            Div_Alert.Visible = false;
            Success.Visible = true;
            D_NotExist.Visible = false;
            travelstartdate.Visible = false;
        }
        else if (ID == 3)
        {
            Div_Alert.Visible = false;
            Success.Visible = false;
            D_NotExist.Visible = true;
            travelstartdate.Visible = false;
        }

        else if (ID == 4)
        {
            Div_Alert.Visible = false;
            Success.Visible = false;
            D_NotExist.Visible = false;
            travelstartdate.Visible = true;
        }
    }
}