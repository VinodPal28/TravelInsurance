using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : Page
{
    //ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            //bool status = bl.sendmail("Meeting Invite", "Hi," + "\r\n" + "please sit together to discuss about travel insurance portal.\r\n\r\nThanks & Regards,\r\nManish", "", "", "jamal6857@gmail.com", "vinod.pal@evolutionco.com,jamal@evolutionco.com", "", "");
            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();
            Request.Cookies.Clear();
            Response.BufferOutput = true;
            Response.Cache.SetExpires(DateTime.Now);
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();

            Response.Redirect("Home.aspx");
        }
        catch(Exception ex)
        {
            bl.LogError(ex, "DefaultPage");
            Response.Redirect("Home.aspx");
        }
    }
}