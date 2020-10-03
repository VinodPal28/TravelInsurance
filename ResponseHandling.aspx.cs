using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ResponseHandling : System.Web.UI.Page
{
   // clsBL clsbl = new clsBL();
    ConnectionToSql ConSql = new ConnectionToSql();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            string[] merc_hash_vars_seq;
            string merc_hash_string = string.Empty;
            string merc_hash = string.Empty;
            string order_id = string.Empty;
            string Name = string.Empty;
            string EmailId = string.Empty;
            string hash_seq = "key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5|udf6|udf7|udf8|udf9|udf10|udf11";

            order_id = Request.Form["txnid"];
            Name = Request.Form["firstname"];
            EmailId = Request.Form["email"];

            if (Request.Form["status"] == "success")
            {
                merc_hash_vars_seq = hash_seq.Split('|');
                Array.Reverse(merc_hash_vars_seq);
                merc_hash_string = ConfigurationManager.AppSettings["SALT"] + "|" + Request.Form["status"];
                foreach (string merc_hash_var in merc_hash_vars_seq)
                {
                    merc_hash_string += "|";
                    merc_hash_string = merc_hash_string + (Request.Form[merc_hash_var] != null ? Request.Form[merc_hash_var] : "");

                }
                merc_hash = Generatehash512(merc_hash_string).ToLower();
                
                if (merc_hash != Request.Form["hash"])
                {                                     
                    if (Session["PartnerCode"] != null)
                    {
                        try
                        {
                            DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_OnlinePayment", new object[] { "InsertPartnerDetails", Name, Session["number"], EmailId, order_id, Session["Amt"], Session["UserId"],0, Request.Form["status"], Session["PolicyNo"].ToString()});                           
                            if (ds.Tables[0].Rows.Count > 0)
                            {
                            }
                        }
                        catch (Exception ex)
                        {
                        }
                    }
                    else if (Session["UserId"] != null && Session["PartnerCode"] == null)
                    {
                        try
                        {
                            DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_OnlinePayment", new object[] { "InsertUserDetails", Name, Session["number"], EmailId, order_id, Session["Amt"], Session["UserId"], 0, Request.Form["status"], Session["PolicyNo"].ToString() });
                            if (ds.Tables[0].Rows.Count > 0)
                            {
                            }

                        }
                        catch (Exception ex)
                        {
                        }
                    }
              
                     Response.Redirect("~/Admin/BuyPolicy.aspx?Action=PaymentTOSucc&orderid=" + order_id + "&PolicyNumber="+ BusinessLogic.QueryStringEncode(Session["PolicyNo"].ToString()));
                    //Response.Redirect("~/Admin/BuyPolicy.aspx?Action=PaymentTOSucc&orderid=" + order_id);
                }
                
            }
            else
            {                
                if (Session["PartnerCode"] != null)
                {
                    try
                    {
                        DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_OnlinePayment", new object[] { "InsertPartnerDetails", Name, Session["number"], EmailId, order_id, Session["Amt"], Session["UserId"], 0, Request.Form["status"], Session["PolicyNo"].ToString() });
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                        }
                    }
                    catch (Exception ex)
                    {
                    }
                }
                else if (Session["UserId"] != null && Session["PartnerCode"] == null)
                {
                    try
                    {
                        DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_OnlinePayment", new object[] { "InsertUserDetails", Name, Session["number"], EmailId, order_id, Session["Amt"], Session["UserId"], 0, Request.Form["status"], Session["PolicyNo"].ToString() });
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                        }

                    }
                    catch (Exception ex)
                    {
                    }
                }

                Response.Redirect("/Admin/BuyPolicy.aspx?Action=PaymentTO&orderid=" + order_id + "&PolicyNumber=" + BusinessLogic.QueryStringEncode(Session["PolicyNo"].ToString()));
            }
        }

        catch (Exception ex)
        {
            Response.Write("<span style='color:red'>" + ex.Message + "</span>");

        }
    }
    /// <summary>
    /// Generate HASH for encrypt all parameter passing while transaction
    /// </summary>
    /// <param name="text"></param>
    /// <returns></returns>
    public string Generatehash512(string text)
    {
        byte[] message = Encoding.UTF8.GetBytes(text);
        UnicodeEncoding UE = new UnicodeEncoding();
        byte[] hashValue;
        SHA512Managed hashString = new SHA512Managed();
        string hex = "";
        hashValue = hashString.ComputeHash(message);
        foreach (byte x in hashValue)
        {
            hex += String.Format("{0:x2}", x);
        }
        return hex;

    }
}