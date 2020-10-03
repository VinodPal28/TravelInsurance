using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Ajax_PaymentGateway : System.Web.UI.Page
{

    // clsBL clsbl = new clsBL();
    ConnectionToSql ConSql = new ConnectionToSql();
    public string action1 = string.Empty;
    public string hash1 = string.Empty;
    public string txnid1 = string.Empty;

    public string name = string.Empty;
    public string number = string.Empty;
    public string email = string.Empty;
    public string Amt = string.Empty;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            key.Value = ConfigurationManager.AppSettings["MERCHANT_KEY"];
           
            if (Request.QueryString["Action"] != "")
            {
                if (Request.QueryString["Action"].ToString() == "PaymentGateway")
                {
                    decimal Price = 0;
                    if (Request.QueryString["Price"].ToString() != "")
                    {
                        Price = Convert.ToDecimal(Request.QueryString["Price"].ToString());
                        if (Session["PartnerCode"] != null)
                        {
                            DataTable dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_OnlinePayment", new object[] { "Get_PartnerDetails", "", "", "", "", 0, 0, Session["UserId"], "", "" });
                            if (dt.Rows.Count > 0)
                            {
                                name = dt.Rows[0]["Partner_Name"].ToString();
                                email = dt.Rows[0]["Partner_Email"].ToString();
                                number = dt.Rows[0]["PartnerContactNo"].ToString();
                            }
                        }
                        if (Session["UserId"] != null && Session["PartnerCode"] == null)
                        {
                            DataTable dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_OnlinePayment", new object[] { "Get_UserDetails", "", "", "", "", 0, 0, Session["UserId"], "", "" });
                            if (dt.Rows.Count > 0)
                            {
                                name = dt.Rows[0]["First_Name"].ToString();
                                email = dt.Rows[0]["EmailId"].ToString();
                                number = dt.Rows[0]["Contact_Number"].ToString();
                            }
                        }
                        Random random = new Random();
                        txnid.Value = Convert.ToString(random.Next(10000, 20000));
                        txnid.Value = txnid.Value.ToString();
                        txnid1 = txnid.Value.ToString();
                        Amt = Math.Round(Convert.ToDecimal(Price), 2).ToString();
                        PaymentGateway(Amt, name, number, email, txnid1);
                        
                        Session["Amt"] = Amt;
                        Session["number"] = number;
                        Session["txnid1"] = txnid1;
                        Session["PolicyNo"] = Request.QueryString["PolicyNo"].ToString();
                    }
                }
            }
        }
        catch (SqlException ex)
        {
            lblErrorshowMessage.Text = "Error occured : " + ex.Message.ToString();
        }
        catch (Exception ex)
        {
            lblErrorshowMessage.Text = "Error occured : " + ex.Message.ToString();
        }
    }

    #region PaymentGateway
    private void PaymentGateway(string Amt, string name, string number, string email, string txnid1)
    {
        string status = txnid1;
        try
        {
            string url = ConfigurationManager.AppSettings["virtualpathHome"] + "ResponseHandling.aspx";
            string[] hashVarsSeq;
            string hash_string = string.Empty;
 
            if (string.IsNullOrEmpty(hash.Value)) // generating hash value
            {
                if (
                    string.IsNullOrEmpty(ConfigurationManager.AppSettings["MERCHANT_KEY"]) ||
                    string.IsNullOrEmpty(txnid1) ||
                    string.IsNullOrEmpty(Amt) ||
                    string.IsNullOrEmpty(name) ||
                    string.IsNullOrEmpty(email) ||
                    string.IsNullOrEmpty(number) ||
                    string.IsNullOrEmpty("test") ||
                    string.IsNullOrEmpty(url) ||
                    string.IsNullOrEmpty(url) ||
                    string.IsNullOrEmpty("payu_paisa"))
                {
                }
                else
                {

                    hashVarsSeq = ConfigurationManager.AppSettings["hashSequence"].Split('|'); // spliting hash sequence from config
                    hash_string = "";
                    foreach (string hash_var in hashVarsSeq)
                    {
                        if (hash_var == "key")
                        {
                            hash_string = hash_string + ConfigurationManager.AppSettings["MERCHANT_KEY"];
                            hash_string = hash_string + '|';
                        }
                        else if (hash_var == "txnid")
                        {
                            hash_string = hash_string + txnid1;
                            hash_string = hash_string + '|';
                        }
                        else if (hash_var == "amount")
                        {
                            hash_string = hash_string + Convert.ToDecimal(Amt).ToString("g29");
                            hash_string = hash_string + '|';
                        }
                        else if (hash_var == "firstname")
                        {
                            hash_string = hash_string + name.ToString();
                            hash_string = hash_string + '|';
                        }
                        else if (hash_var == "email")
                        {
                            hash_string = hash_string + email.ToString();
                            hash_string = hash_string + '|';
                        }

                        //else if (hash_var == "phone")
                        //{
                        //    hash_string = hash_string + number.ToString();
                        //    hash_string = hash_string + '|';
                        //}
                        else if (hash_var == "productinfo")
                        {
                            hash_string = hash_string + "test".ToString();
                            hash_string = hash_string + '|';
                        }
                        else
                        {
                            hash_string = hash_string + (Request.Form[hash_var] != null ? Request.Form[hash_var] : "");// isset if else
                            hash_string = hash_string + '|';
                        }
                    }
                    hash_string += ConfigurationManager.AppSettings["SALT"];// appending SALT

                    hash1 = Generatehash512(hash_string).ToLower();         //generating hash
                    action1 = ConfigurationManager.AppSettings["PAYU_BASE_URL"] + "/_payment";// setting URL
                }
            }
            else if (!string.IsNullOrEmpty(hash.Value))
            {
                hash1 = hash.Value;
                action1 = ConfigurationManager.AppSettings["PAYU_BASE_URL"] + "/_payment";
            }
            if (!string.IsNullOrEmpty(hash1))
            {
                hash.Value = hash1;
                //txnid.Value = txnidval;
                System.Collections.Hashtable data = new System.Collections.Hashtable(); // adding values in gash table for data post
                data.Add("hash", hash1);
                data.Add("key", key.Value);
                data.Add("txnid", txnid1);
                string AmountForm = Convert.ToDecimal(Amt.Trim()).ToString("g29");// eliminating trailing zeros 


                data.Add("amount", AmountForm);
                data.Add("firstname", name.Trim());
                data.Add("email", email.Trim());
                data.Add("productinfo", "test".Trim());
                data.Add("phone", number.Trim());
                data.Add("surl", url.Trim());
                data.Add("furl", url.Trim());
                data.Add("lastname", "".Trim());
                data.Add("curl", "".Trim());
                data.Add("address1", "".Trim());
                data.Add("address2", "".Trim());
                data.Add("city", "".Trim());
                data.Add("state", "".Trim());
                data.Add("country", "".Trim());
                data.Add("zipcode", "".Trim());
                data.Add("udf1", "".Trim());
                data.Add("udf2", "".Trim());
                data.Add("udf3", "".Trim());
                data.Add("udf4", "".Trim());
                data.Add("udf5", "".Trim());
                data.Add("pg", hash.Value);

                data.Add("service_provider", "payu_paisa");
                string strForm = PreparePOSTForm(action1, data);
                Page.Controls.Add(new LiteralControl(strForm));

            }
            else
            {

            }
        }
        catch (Exception ex)
        {

        }

    }
    #endregion

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
    private string PreparePOSTForm(string url, System.Collections.Hashtable data)      //post form
    {
        //Set a name for the form
        string formID = "PostForm";
        //Build the form using the specified data to be posted.
        StringBuilder strForm = new StringBuilder();
        strForm.Append("<form id=\"" + formID + "\" name=\"" +
                       formID + "\" action=\"" + url +
                       "\" method=\"POST\">");

        foreach (System.Collections.DictionaryEntry key in data)
        {

            strForm.Append("<input type=\"hidden\" name=\"" + key.Key +
                           "\" value=\"" + key.Value + "\">");
        }


        strForm.Append("</form>");
        //Build the JavaScript which will do the Posting operation.
        StringBuilder strScript = new StringBuilder();
        strScript.Append("<script language='javascript'>");
        strScript.Append("var v" + formID + " = document." +
                         formID + ";");
        strScript.Append("v" + formID + ".submit();");
        strScript.Append("</script>");
        //Return the form and the script concatenated.
        //(The order is important, Form then JavaScript)
        return strForm.ToString() + strScript.ToString();
    }

}