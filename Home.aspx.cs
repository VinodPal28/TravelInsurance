using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Xml;
using System.Text;
using System.Configuration;
using System.Security.Cryptography;
using System.Globalization;
using Newtonsoft.Json;

public partial class Home : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic BL = new BusinessLogic();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {

            }

            if (Request.QueryString["Action"] == "SaveData")
            {
                if (Request.QueryString["lb"] != "" && Request.QueryString["lb"] != null)
                {
                    string empdata = Request.QueryString["lb"];
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Clear();
                    Response.Write(Getlogin(empdata));
                    Response.End();
                }
            }
        }
        catch (SqlException ex)
        {
            errorMsg.Text = "Error occured : " + ex.Message.ToString();
        }
        catch (Exception ex)
        {
            errorMsg.Text = "Error occured : " + ex.Message.ToString();
        }

    }

    public class Login
    {
        public string User_Name { get; set; }
        public string password { get; set; }
    }
    public string Getlogin(string Login)
    {
        string msg = "";
        var serializeData = JsonConvert.DeserializeObject<List<Login>>(Login);
        foreach (var data in serializeData)
        {
            DataTable dt1 = con.ExecuteReaderDt("Allianz_Travel", "USP_Emplogin", new object[] { "EmpLogin", data.User_Name, data.password, 0, 0 });
            if (dt1.Rows.Count > 0 && dt1.Rows[0]["Name"].ToString() != "NA")
            {
                if (dt1.Rows[0]["Name"].ToString() != "ACCOUNT LOCKED")
                {
                    if (dt1.Rows[0]["Name"].ToString() != "ATTEMPT TIME")
                    {
                        if (dt1.Rows[0]["Name"].ToString() != "ID LOCKED")
                        {
                            if (dt1.Rows[0]["Name"].ToString() == "")
                            {
                                Session["UserId"] = "1000" + dt1.Rows[0]["Id"].ToString();
                                Session["UserName"] = dt1.Rows[0]["FirstName"].ToString();
                                Session["UserTypeId"] = dt1.Rows[0]["UserType"].ToString();
                                Session["PartnerId"] = dt1.Rows[0]["PartnerId"].ToString();
                                Session["WalletType"] = dt1.Rows[0]["WalletType"].ToString();
                                Session["PartnerCode"] = dt1.Rows[0]["PartnerId"].ToString();
                                int status = Convert.ToInt32(dt1.Rows[0]["IsActive"]);
                                string Lastlogindate = dt1.Rows[0]["LastLogin"].ToString();

                                Session["Lastlogindate"] = Lastlogindate;
                                if (status == 1)
                                {
                                    if (dt1.Rows[0]["UserType"].ToString() != "0")
                                    {
                                        msg = "2";
                                    }
                                    else
                                    {
                                        Response.Redirect("Home.aspx");
                                    }
                                }
                                else if (status == 3)
                                {
                                    msg = "3";
                                }
                                else
                                {
                                    msg = "NA";
                                }
                            }
                        }
                        else
                        {
                            msg = "EmaiID LOCKED";
                        }
                    }
                    else
                    {
                        msg = "Attempt#" + dt1.Rows[0]["COUNT"].ToString();
                    }
                }
                else
                {
                    msg = "ACCOUNT LOCKED";
                }
            }
            else
            {
                DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_UserCreation", new object[] { "LOGIN", "", "", data.User_Name, data.password, "", 0, 0 });
                if (dt.Rows.Count > 0)
                {
                    if (dt.Rows[0]["Name"].ToString() != "NA")
                    {
                        if (dt.Rows[0]["Name"].ToString() != "ACCOUNT LOCKED")
                        {
                            if (dt.Rows[0]["Name"].ToString() != "ATTEMPT TIME")
                            {
                                if (dt.Rows[0]["Name"].ToString() != "ID LOCKED")
                                {
                                    if (dt.Rows[0]["Name"].ToString() == "")
                                    {
                                        Session["UserId"] = dt.Rows[0]["UserId"].ToString();
                                        Session["UserName"] = dt.Rows[0]["First_Name"].ToString();
                                        Session["UserTypeId"] = dt.Rows[0]["UserTypeId"].ToString();
                                        Session["PartnerCode"] = dt.Rows[0]["Partner_Code"].ToString();
                                        Session["WalletType"] = dt.Rows[0]["Wallet_Type"].ToString() == "" ? "0" : dt.Rows[0]["Wallet_Type"].ToString();
                                        Session["PartnerId"] = dt.Rows[0]["Head_Partner_Id"].ToString() == "0" ? dt.Rows[0]["UserId"].ToString() : dt.Rows[0]["Head_Partner_Id"].ToString();
                                        int status = Convert.ToInt32(dt.Rows[0]["IsActive"]);
                                        string Lastlogindate = dt.Rows[0]["Lastlogindate"].ToString();

                                        Session["Lastlogindate"] = Lastlogindate;
                                        if (status == 1)
                                        {
                                            if (dt.Rows[0]["UserTypeId"].ToString() != "0")
                                            {
                                                msg = "2";
                                            }
                                            else
                                            {
                                                Response.Redirect("Home.aspx");
                                            }
                                        }
                                        else if (status == 3)
                                        {
                                            msg = "3";
                                        }
                                        else
                                        {
                                            msg = "NA";
                                        }
                                    }
                                }
                                else
                                {
                                    msg = "EmaiID LOCKED";
                                }
                            }
                            else
                            {
                                msg = "Attempt#" + dt.Rows[0]["COUNT"].ToString();
                            }
                        }
                        else
                        {
                            msg = "ACCOUNT LOCKED";
                        }
                    }
                    else
                    {
                        msg = "Not found";
                    }
                }
                else
                {
                    msg = "Invalid";

                }
            }
        }
        return JsonConvert.SerializeObject(msg);
    }

}


