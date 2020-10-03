﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text;

public partial class Admin_ChangePassword : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] == null || Session["UserId"].ToString() == "0")
            {
                Response.Redirect("../Home.aspx");
            }
           

            if (!IsPostBack)
            {

            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "ChangePswd")
                {
                    GetPassword(Request.Params["OldPswd"].ToString(), Request.Params["NewPswd"].ToString());
                }

            }
        }
        catch (SqlException ex)
        {
            lblerrorMsg.Text = "Error occured : " + ex.Message.ToString();
        }
        catch (Exception ex)
        {
            lblerrorMsg.Text = "Error occured : " + ex.Message.ToString();
        }
    }

    //void Page_PreInit(Object sender, EventArgs e)
    //{
    //    if (Session["UserId"] != null)
    //    {
    //        if (Session["UserTypeId"].ToString() == "1" && Session["UserTypeId"].ToString() == "2")
    //        {
    //            this.MasterPageFile = "~/Admin/AdminMaster.master";
    //        }
    //        else if (Session["UserTypeId"].ToString() == "4")
    //        {
    //            this.MasterPageFile = "~/Partner/PartnerMaster.master";
    //        }

    //    }
    //    else
    //    {
    //        Session.Abandon();
    //        Response.Redirect("~/Home.aspx");
    //    }


    //}
    public void GetPassword(string OldPswd, string NewPswd)
    {
        string msg = string.Empty;
        if (Session["PartnerCode"].ToString()!="")
        {           
            string Partner_OldPassword = BusinessLogic.QueryStringEncode(OldPswd);
            string Partner_NewPassword = BusinessLogic.QueryStringEncode(NewPswd);
            ds = con.ExecuteReader("Allianz_Travel", "USP_ChangePassword", new object[] { "Partner_ChangePswd", Partner_OldPassword, Partner_NewPassword, Session["UserId"] });
            if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "F")
            {
                msg = "F";
            }
            else if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "NA")
            {
                msg = "NA";
            }
            Response.Write(msg);
            Response.End();
        }
        else if (Session["UserTypeId"].ToString() == "100")
        {
            int Id = Convert.ToInt32(Session["UserId"].ToString().Substring(4));
            string Emp_OldPassword = BusinessLogic.QueryStringEncode(OldPswd);
            string Emp_NewPassword = BusinessLogic.QueryStringEncode(NewPswd);
            ds = con.ExecuteReader("Allianz_Travel", "USP_ChangePassword", new object[] { "PartnerEmp_ChangePswd", Emp_OldPassword, Emp_NewPassword, Id });
            if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "F")
            {
                msg = "F";
            }
            else if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "NA")
            {
                msg = "NA";
            }
            Response.Write(msg);
            Response.End();
        }
        else
        {
            string OldPassword = BusinessLogic.QueryStringEncode(OldPswd);
            string NewPassword = BusinessLogic.QueryStringEncode(NewPswd);
            ds = con.ExecuteReader("Allianz_Travel", "USP_ChangePassword", new object[] { "ChangePswd", OldPassword, NewPassword, Session["UserId"] });
            if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "F")
            {
                msg = "F";
            }
            else if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "NA")
            {
                msg = "NA";
            }
        }        
        Response.Write(msg);
        Response.End();
    }


}