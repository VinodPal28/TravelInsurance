using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AdminMaster : System.Web.UI.MasterPage
{
    ConnectionToSql con = new ConnectionToSql();
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

                if (Session["UserId"] != null)
                {
                    if (Session["UserTypeId"].ToString() == "1")
                    {
                        Page.Title = "Allianz-Travel : SuperAdmin";
                    }
                    else if (Session["UserTypeId"].ToString() == "2")
                    {
                        Page.Title = "Allianz-Travel : Admin";
                    }
                    else if (Session["UserTypeId"].ToString() == "3")
                    {
                        Page.Title = "Allianz-Travel : Partner";
                    }
                    else if (Session["UserTypeId"].ToString() == "4")
                    {
                        Page.Title = "Allianz-Travel : Sub-Partner";
                    }
                    else if (Session["UserTypeId"].ToString() == "5")
                    {
                        Page.Title = "Allianz-Travel : Business Development";
                    }
                    else if (Session["UserTypeId"].ToString() == "6")
                    {
                        Page.Title = "Allianz-Travel : Sales Support";
                    }
                    else if (Session["UserTypeId"].ToString() == "7")
                    {
                        Page.Title = "Allianz-Travel : Under Writer";
                    }
                   

                    lastlogin.InnerHtml = Session["Lastlogindate"].ToString();
                    UserName.InnerText = Session["UserName"].ToString();
                    Authority();
                    EmpAuthority();
                    Notification();

                }
                else
                {
                    Session.Abandon();
                    Response.Redirect("~/Home.aspx");
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    public void EmpAuthority()
    {
        if (Session["UserTypeId"].ToString() == "99")
        {
            StringBuilder sb = new StringBuilder();
            if (Session["WalletType"].ToString().Contains("WalletRequest"))
            {
                sb.Append("<a class='dropdown-item' href='../Admin/WalletRequest.aspx'><i class='ft-message-square'></i>Wallet Requests</a>");
            }
            if (Session["WalletType"].ToString().Contains("WalletStatement"))
            {
                sb.Append("<a class='dropdown-item' href='../Admin/WalletStatement.aspx'><i class='ft-message-square'></i>Wallet Statement</a>");
            }
            sb.Append("<a class='dropdown-item' href='../Admin/ChangePassword.aspx'><i class='ft-message-square'></i>Change Password</a>");
            sb.Append("<div class='dropdown-divider'></div>");
            sb.Append("<a class='dropdown-item' href='../Default.aspx'><i class='ft-power'></i>Logout</a>");
            MenuWallet.InnerHtml = Convert.ToString(sb);
        }

    }
    public void Authority()
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sb1 = new StringBuilder();
            ds = con.ExecuteReader("Allianz_Travel", "USP_Authority", new object[] { Session["UserTypeId"] });
            if (ds.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (Session["PartnerId"].ToString() != "0" && Session["WalletType"].ToString() == "WalletPooling")
                    {
                        if (dr["Menu_Name"].ToString() == "Wallet Statement")
                        {
                            sb1.Append("<a class='dropdown-item' href='" + dr["Url"].ToString() + "'><i class='ft-check-square'></i>" + dr["Menu_Name"].ToString() + "</a>");
                        }
                        else if (dr["Menu_Name"].ToString() == "Wallet Request")
                        {
                            //sb1.Append("<a class='dropdown-item' href='" + dr["Url"].ToString() + "'><i class='ft-check-square'></i>" + dr["Menu_Name"].ToString() + "</a>");
                        }
                        else if (dr["Menu_Name"].ToString() == "Edit Profile")
                        {
                            sb1.Append("<a class='dropdown-item' href='" + dr["Url"].ToString() + "'><i class='ft-check-square'></i>" + dr["Menu_Name"].ToString() + "</a>");
                        }

                        else if (dr["Menu_Name"].ToString() == "Masters")
                        {
                            sb.Append("<li class='nav-item'><a href='javascript: void(0); '><i class='la la-support'></i><span class='menu-title' data-i18n='nav.dash.main'>Masters</span></a>");
                            sb.Append("<ul class='menu-content'>");
                            sb.Append("<li><a class='menu-item' href='PlanMaster.aspx' data-i18n='nav.dash.ecommerce'>Plan Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='GeographyMaster.aspx' data-i18n='nav.dash.ecommerce'>Geography Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='AgeGroupMaster.aspx' data-i18n='nav.dash.ecommerce'>Age Group Master</a></li>");
                            //sb.Append("<li><a class='menu-item' href='BenifitMaster.aspx' data-i18n='nav.dash.ecommerce'>Benefits Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='ValueAddedService.aspx' data-i18n='nav.dash.ecommerce'>Value Added Service Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='InsurerMaster.aspx' data-i18n='nav.dash.ecommerce'>Insurer Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='Tax_Slab.aspx' data-i18n='nav.dash.ecommerce'>Tax Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='PassengersType.aspx' data-i18n='nav.dash.ecommerce'>Passenger Type</a></li>");
                            sb.Append("<li><a class='menu-item' href='RoleMaster.aspx' data-i18n='nav.dash.ecommerce'>Role Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='FaqMaster.aspx' data-i18n='nav.dash.ecommerce'>FAQ Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='PromoCodeUpload.aspx' data-i18n='nav.dash.ecommerce'>PromoCode Upload</a></li>");
                            sb.Append("<li><a class='menu-item' href='LuggageTrackerQRCode.aspx' data-i18n='nav.dash.ecommerce'>LuggageTracker QRCode</a></li>");
                            sb.Append("</ul>");
                            sb.Append("</li>");
                        }
                        else if (dr["Menu_Name"].ToString() == "Dashboard")
                        {
                            sb.Append("<li class='nav-item'><a href='Dashboard.aspx'><i class='la la-home'></i><span class='menu-title' data-i18n='nav.dash.main'>Dashboard</span></a></ li > ");

                        }
                        else
                        {
                            sb.Append("<li class='nav-item'><a href='" + dr["Url"].ToString() + "'><i class='la la-support'></i><span class='menu-title' data-i18n='nav.dash.main'>" + dr["Menu_Name"].ToString() + "</span></a></ li > ");
                        }
                    }
                    else if (Session["PartnerId"].ToString() != "0")
                    {
                        if (Session["UserTypeId"].ToString() != "99")
                        {
                            if (dr["Menu_Name"].ToString() == "Wallet Request" || dr["Menu_Name"].ToString() == "Wallet Statement")
                            {
                                sb1.Append("<a class='dropdown-item' href='" + dr["Url"].ToString() + "'><i class='ft-check-square'></i>" + dr["Menu_Name"].ToString() + "</a>");
                            }
                            else if (dr["Menu_Name"].ToString() == "Edit Profile")
                            {
                                sb1.Append("<a class='dropdown-item' href='" + dr["Url"].ToString() + "'><i class='ft-check-square'></i>" + dr["Menu_Name"].ToString() + "</a>");
                            }
                            else if (dr["Menu_Name"].ToString() == "Masters")
                            {
                                sb.Append("<li class='nav-item'><a href='javascript: void(0); '><i class='la la-support'></i><span class='menu-title' data-i18n='nav.dash.main'>Masters</span></a>");
                                sb.Append("<ul class='menu-content'>");
                                sb.Append("<li><a class='menu-item' href='PlanMaster.aspx' data-i18n='nav.dash.ecommerce'>Plan Master</a></li>");
                                sb.Append("<li><a class='menu-item' href='GeographyMaster.aspx' data-i18n='nav.dash.ecommerce'>Geography Master</a></li>");
                                sb.Append("<li><a class='menu-item' href='AgeGroupMaster.aspx' data-i18n='nav.dash.ecommerce'>Age Group Master</a></li>");
                                //sb.Append("<li><a class='menu-item' href='BenifitMaster.aspx' data-i18n='nav.dash.ecommerce'>Benefits Master</a></li>");
                                sb.Append("<li><a class='menu-item' href='ValueAddedService.aspx' data-i18n='nav.dash.ecommerce'>Value Added Service Master</a></li>");
                                sb.Append("<li><a class='menu-item' href='InsurerMaster.aspx' data-i18n='nav.dash.ecommerce'>Insurer Master</a></li>");
                                sb.Append("<li><a class='menu-item' href='Tax_Slab.aspx' data-i18n='nav.dash.ecommerce'>Tax Master</a></li>");
                                sb.Append("<li><a class='menu-item' href='PassengersType.aspx' data-i18n='nav.dash.ecommerce'>Passenger Type</a></li>");
                                sb.Append("<li><a class='menu-item' href='RoleMaster.aspx' data-i18n='nav.dash.ecommerce'>Role Master</a></li>");
                                sb.Append("<li><a class='menu-item' href='FaqMaster.aspx' data-i18n='nav.dash.ecommerce'>FAQ Master</a></li>");
                                sb.Append("<li><a class='menu-item' href='PromoCodeUpload.aspx' data-i18n='nav.dash.ecommerce'>PromoCode Upload</a></li>");
                                sb.Append("<li><a class='menu-item' href='LuggageTrackerQRCode.aspx' data-i18n='nav.dash.ecommerce'>LuggageTracker QRCode</a></li>");
                                sb.Append("</ul>");
                                sb.Append("</li>");
                            }
                            else
                            {
                                sb.Append("<li class='nav-item'><a href='" + dr["Url"].ToString() + "'><i class='la la-support'></i><span class='menu-title' data-i18n='nav.dash.main'>" + dr["Menu_Name"].ToString() + "</span></a></ li > ");
                            }
                        }
                        else if (Session["UserTypeId"].ToString() == "99")
                        {
                            if (dr["Menu_Name"].ToString() == "Wallet Request" || dr["Menu_Name"].ToString() == "Wallet Statement")
                            {
                                //sb1.Append("<a class='dropdown-item' href='" + dr["Url"].ToString() + "'><i class='ft-check-square'></i>" + dr["Menu_Name"].ToString() + "</a>");
                            }

                            else
                            {
                                sb.Append("<li class='nav-item'><a href='" + dr["Url"].ToString() + "'><i class='la la-support'></i><span class='menu-title' data-i18n='nav.dash.main'>" + dr["Menu_Name"].ToString() + "</span></a></ li > ");
                            }
                        }
                        else if (dr["Menu_Name"].ToString() == "Masters")
                        {
                            sb.Append("<li class='nav-item'><a href='javascript: void(0); '><i class='la la-support'></i><span class='menu-title' data-i18n='nav.dash.main'>Masters</span></a>");
                            sb.Append("<ul class='menu-content'>");
                            sb.Append("<li><a class='menu-item' href='PlanMaster.aspx' data-i18n='nav.dash.ecommerce'>Plan Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='GeographyMaster.aspx' data-i18n='nav.dash.ecommerce'>Geography Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='AgeGroupMaster.aspx' data-i18n='nav.dash.ecommerce'>Age Group Master</a></li>");
                            //sb.Append("<li><a class='menu-item' href='BenifitMaster.aspx' data-i18n='nav.dash.ecommerce'>Benefits Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='ValueAddedService.aspx' data-i18n='nav.dash.ecommerce'>Value Added Service Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='InsurerMaster.aspx' data-i18n='nav.dash.ecommerce'>Insurer Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='Tax_Slab.aspx' data-i18n='nav.dash.ecommerce'>Tax Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='PassengersType.aspx' data-i18n='nav.dash.ecommerce'>Passenger Type</a></li>");
                            sb.Append("<li><a class='menu-item' href='RoleMaster.aspx' data-i18n='nav.dash.ecommerce'>Role Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='FaqMaster.aspx' data-i18n='nav.dash.ecommerce'>FAQ Master</a></li>");
                            sb.Append("<li><a class='menu-item' href='PromoCodeUpload.aspx' data-i18n='nav.dash.ecommerce'>PromoCode Upload</a></li>");
                            sb.Append("<li><a class='menu-item' href='LuggageTrackerQRCode.aspx' data-i18n='nav.dash.ecommerce'>LuggageTracker QRCode</a></li>");
                            sb.Append("</ul>");
                            sb.Append("</li>");
                        }
                        else if (dr["Menu_Name"].ToString() == "Dashboard")
                        {
                            sb.Append("<li class='nav-item'><a href='Dashboard.aspx'><i class='la la-home'></i><span class='menu-title' data-i18n='nav.dash.main'>Dashboard</span></a></ li > ");

                        }
                        else
                        {
                            sb.Append("<li class='nav-item'><a href='" + dr["Url"].ToString() + "'><i class='la la-support'></i><span class='menu-title' data-i18n='nav.dash.main'>" + dr["Menu_Name"].ToString() + "</span></a></ li > ");
                        }
                    }
                    else if (Session["UserTypeId"].ToString() == "99")
                    {
                        if (dr["Menu_Name"].ToString() == "Dashboard")
                        {
                            sb.Append("<li class='nav-item'><a href='Dashboard.aspx'><i class='la la-home'></i><span class='menu-title' data-i18n='nav.dash.main'>Dashboard</span></a></ li > ");

                        }
                        else if (dr["Menu_Name"].ToString() == "Wallet Statement")
                        {
                            //sb1.Append("<a class='dropdown-item' href='" + dr["Url"].ToString() + "'><i class='ft-check-square'></i>" + dr["Menu_Name"].ToString() + "</a>");
                        }
                        else if (dr["Menu_Name"].ToString() == "Wallet Request")
                        {
                            //sb1.Append("<a class='dropdown-item' href='" + dr["Url"].ToString() + "'><i class='ft-check-square'></i>" + dr["Menu_Name"].ToString() + "</a>");
                        }
                        else
                        {
                            sb.Append("<li class='nav-item'><a href='" + dr["Url"].ToString() + "'><i class='la la-support'></i><span class='menu-title' data-i18n='nav.dash.main'>" + dr["Menu_Name"].ToString() + "</span></a></ li > ");
                        }
                    }



                }

                sb1.Append("<a class='dropdown-item' href='../Admin/ChangePassword.aspx'><i class='ft-message-square'></i>Change Password</a>");
                sb1.Append("<div class='dropdown-divider'></div>");
                sb1.Append("<a class='dropdown-item' href='../Default.aspx'><i class='ft-power'></i>Logout</a>");

                main_menu_navigation.InnerHtml = Convert.ToString(sb);
                MenuWallet.InnerHtml = Convert.ToString(sb1);

            }


        }
        catch (Exception ex)
        { }
    }

    #region Notification
    public void Notification()
    {
        DivCount.Visible = false;
        DataTable dt = new DataTable();
        DataSet ds = new DataSet();
        StringBuilder sb = new StringBuilder();
        if (Session["PartnerCode"].ToString() != "")
        {
          
            //-------------Notification -----------------------------
            ds = con.ExecuteReader("Allianz_Travel", "USP_Notification", new object[] { "BindNotificationData", "", 0, Session["UserId"] });
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[1].Rows.Count > 0)
                {
                    DivCount.Visible = true;
                    // sbNotifCount.Append("<span class='note - point'>" + ds.Tables[1].Rows[0]["Count"].ToString() + "</span>");
                    Count.InnerHtml = ds.Tables[1].Rows[0]["Count"].ToString();
                }
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    sb.Append("<a href='javascript: void(0)' runat='server' id='Notification'" + i + "'>");
                    sb.Append("<div class='media'>");
                    sb.Append("<div class='media-body'>");
                    sb.Append("<h6 class='media-heading'>" + ds.Tables[0].Rows[i]["NotificationType"].ToString() + "</h6>");
                    // sb.Append("<p class='notification-text font-small-3 text-muted'><b>Policy No : </b>" + ds.Tables[0].Rows[i]["Policy_No"].ToString() + "</p>");
                    if (ds.Tables[0].Rows[i]["Policy_No"].ToString() != "")
                    {
                        sb.Append("<p class='notification-text font-small-3 text-muted'><b>Policy No : </b>" + ds.Tables[0].Rows[i]["Policy_No"].ToString() + "</p>");
                    }
                    else
                    {
                        sb.Append("<p class='notification-text font-small-3 text-muted'><b>Wallet Amount : </b>" + ds.Tables[0].Rows[i]["WalletAmount"].ToString() + "</p>");
                    }
                    if(ds.Tables[0].Rows[i]["Remarks"].ToString()!="")
                    {
                        sb.Append("<p class='notification-text font-small-3 text-muted'><b>Reason : </b>" + ds.Tables[0].Rows[i]["Remarks"].ToString() + "</p>");
                    }                   
                    sb.Append("<p class='notification-text font-small-3 text-muted'><b>User Name : </b>" + ds.Tables[0].Rows[i]["UserName"].ToString() + "</p>");
                    sb.Append("<p class='notification-text font-small-3 text-muted'><b>Date : </b>" + ds.Tables[0].Rows[i]["ApproveDate"].ToString() + "</p>");
                    //sb.Append("<small><time class='media-meta text-muted'>30 minutes ago</time></small>");

                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</a>");

                }
                DivBindNotification.InnerHtml = sb.ToString();
            }
        }
        else
        {
            ds = con.ExecuteReader("Allianz_Travel", "USP_Notification", new object[] { "UserWise", "", 0, 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[1].Rows.Count > 0)
                {
                    DivCount.Visible = true;
                    // sbNotifCount.Append("<span class='note - point'>" + ds.Tables[1].Rows[0]["Count"].ToString() + "</span>");
                    Count.InnerHtml = ds.Tables[1].Rows[0]["Count"].ToString();
                }
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    sb.Append("<a href='javascript: void(0)' runat='server' id='Notification'" + i + "'>");
                    sb.Append("<div class='media'>");
                    sb.Append("<div class='media-body'>");
                    sb.Append("<h6 class='media-heading'>" + ds.Tables[0].Rows[i]["NotificationType"].ToString() + "</h6>");
                    if(ds.Tables[0].Rows[i]["Policy_No"].ToString()!="")
                    {
                        sb.Append("<p class='notification-text font-small-3 text-muted'><b>Policy No : </b>" + ds.Tables[0].Rows[i]["Policy_No"].ToString() + "</p>");
                    }
                    else
                    {
                        sb.Append("<p class='notification-text font-small-3 text-muted'><b>Wallet Amount : </b>" + ds.Tables[0].Rows[i]["WalletAmount"].ToString() + "</p>");
                    }
                   if(ds.Tables[0].Rows[i]["RequestedRemarks"].ToString() != "")
                    {
                        sb.Append("<p class='notification-text font-small-3 text-muted'><b>Reason : </b>" + ds.Tables[0].Rows[i]["RequestedRemarks"].ToString() + "</p>");
                    }
                   else if(ds.Tables[0].Rows[i]["Remarks"].ToString() != "")
                    {
                        sb.Append("<p class='notification-text font-small-3 text-muted'><b>Reason : </b>" + ds.Tables[0].Rows[i]["Remarks"].ToString() + "</p>");
                    }
                    
                    sb.Append("<p class='notification-text font-small-3 text-muted'><b>User Name : </b>" + ds.Tables[0].Rows[i]["UserName"].ToString() + "</p>");
                    sb.Append("<p class='notification-text font-small-3 text-muted'><b>Date : </b>" + ds.Tables[0].Rows[i]["RequestedDate"].ToString() + "</p>");
                    //sb.Append("<small><time class='media-meta text-muted'>30 minutes ago</time></small>");

                    sb.Append("</div>");
                    sb.Append("</div>");
                    sb.Append("</a>");

                }
                DivBindNotification.InnerHtml = sb.ToString();
            }
        }
    }
    #endregion
}
