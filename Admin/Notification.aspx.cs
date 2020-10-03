using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Notification : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                if (Session["UserId"] != null)
                {                  
                    Notification();
                }
                else
                {
                    Session.Abandon();
                    Response.Redirect("~/Home.aspx");
                }
            }
        }
        catch (SqlException ex)
        {
            lblErrorMsg.Text = "Error occured : " + ex.Message.ToString();
        }
        catch (Exception ex)
        {
            lblErrorMsg.Text = "Error occured : " + ex.Message.ToString();
        }
    }

    #region Notification
    public void Notification()
    {
        
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        StringBuilder sb = new StringBuilder();
        if (Session["PartnerCode"].ToString() != "")
        {

            //-------------Notification -----------------------------
            ds = con.ExecuteReader("Allianz_Travel", "USP_Notification", new object[] { "BindNotificationData", "", 0, Session["UserId"] });
            if (ds.Tables[0].Rows.Count > 0)
            {
                
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    sb.Append("<a href='javascript: void(0)' runat='server' id='Notification'" + i + "' style='margin: 2px;'>");
                    sb.Append("<div class='media'>");
                    sb.Append("<div class='media-body'>");
                    sb.Append("<h6 class='media-heading'>" + ds.Tables[0].Rows[i]["NotificationType"].ToString() + "</h6>");
                    sb.Append("<p class='notification-text font-small-3 text-muted'><b>Policy No : </b>" + ds.Tables[0].Rows[i]["Policy_No"].ToString() + "</p>");
                    sb.Append("<p class='notification-text font-small-3 text-muted'><b>Reason : </b>" + ds.Tables[0].Rows[i]["Remarks"].ToString() + "</p>");
                    sb.Append("<p class='notification-text font-small-3 text-muted'><b>User Name : </b>" + ds.Tables[0].Rows[i]["UserName"].ToString() + "</p>");
                    sb.Append("<p class='notification-text font-small-3 text-muted'><b>Date : </b>" + ds.Tables[0].Rows[i]["ApproveDate"].ToString() + "</p>");
                    //sb.Append("<small><time class='media-meta text-muted'>30 minutes ago</time></small>");

                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</a>");
                    

                }
                DivBindNotification.InnerHtml = sb.ToString();
            }
            else
            {
                SpnNotif.InnerHtml = "Notification not available !!!";
            }
        }
        else
        {
            ds = con.ExecuteReader("Allianz_Travel", "USP_Notification", new object[] { "UserWise", "", 0, 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
               
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    
                    sb.Append("<a href='javascript: void(0)' runat='server' id='Notification" + i + "'>");
                    sb.Append("<div class='media'>");
                    sb.Append("<div class='media-body'>");
                    sb.Append("<h6 class='media-heading'>" + ds.Tables[0].Rows[i]["NotificationType"].ToString() + "</h6>");
                    sb.Append("<p class='notification-text font-small-3 text-muted'><b>Policy No : </b>" + ds.Tables[0].Rows[i]["Policy_No"].ToString() + "</p>");
                    sb.Append("<p class='notification-text font-small-3 text-muted'><b>Reason : </b>" + ds.Tables[0].Rows[i]["RequestedRemarks"].ToString() + "</p>");
                    sb.Append("<p class='notification-text font-small-3 text-muted'><b>User Name : </b>" + ds.Tables[0].Rows[i]["UserName"].ToString() + "</p>");
                    sb.Append("<p class='notification-text font-small-3 text-muted'><b>Date : </b>" + ds.Tables[0].Rows[i]["RequestedDate"].ToString() + "</p>");
                    //sb.Append("<small><time class='media-meta text-muted'>30 minutes ago</time></small>");

                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</a>");

                }
                DivBindNotification.InnerHtml = sb.ToString();
            }
            else
            {
                SpnNotif.InnerHtml = "Notification not available !!!";
            }
        }
    }
    #endregion
}