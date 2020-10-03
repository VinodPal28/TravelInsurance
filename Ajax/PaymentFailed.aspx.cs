using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Ajax_PaymentFailed : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            
            if (Request.QueryString["Action"] != "")
            {
                if (Request.QueryString["Action"] == "PaymentTO")
                {
                    //int OrderId = 0;
                    if (Request.QueryString["orderid"] != "" )
                    {
                      string  OrderId =Request.QueryString["orderid"];
                        lblorderid.Text = OrderId.ToString();
                    }
                }
            }

        }
    }
}