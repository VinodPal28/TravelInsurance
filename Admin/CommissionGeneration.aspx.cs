// ******************************************************************************************
// Author           : Vinod Pal
// Description      : To generate commission of partner
// Created On       : 07-08-2018 
// *******************************************************************************************
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Drawing;
using System.IO;
using System.Collections;
using System.Text.RegularExpressions;
using System.Globalization;
using System.Data.SqlClient;
public partial class Admin_CommissionGeneration : System.Web.UI.Page
{
    ConnectionToSql ConSql = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    DataTable dt = new DataTable();
    DataSet ds = new DataSet();
    string FDate = "", ToDate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] == null || Session["UserId"].ToString() == "0")
            {
                Response.Redirect("../Home.aspx");
            }
            else
            {
                bool Authenticate = bl.CheckAuthority("CommissionGeneration.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                if (Session["UserId"] != null && Session["UserId"].ToString() != "0")
                {
                    grid.Visible = false;
                    var currentYear = DateTime.Today.Year;
                    for (int i = 10; i >= 0; i--)
                    {
                        ddlYear.Items.Add((currentYear - i).ToString());
                    }
                }
                else
                {
                    Response.Redirect("../Home.aspx");
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string month = ddlMonth.SelectedValue;
            string year = ddlYear.SelectedValue;
            int leapYear = (int.Parse(year) % 4);
            if (leapYear == 0 && month == "02")
            {
                FDate = "01-" + month + "-" + year + "";
                ToDate = "29-" + month + "-" + year + "";
            }
            else
            {
                if (month == "02")
                {
                    FDate = "01-" + month + "-" + year + "";
                    ToDate = "28-" + month + "-" + year + "";
                }
                else if (month == "01" || month == "03" || month == "05" || month == "07" || month == "08" || month == "10" || month == "12")
                {
                    FDate = "01-" + month + "-" + year + "";
                    ToDate = "31-" + month + "-" + year + "";
                }
                else if (month == "04" || month == "06" || month == "09" || month == "11")
                {
                    FDate = "01-" + month + "-" + year + "";
                    ToDate = "30-" + month + "-" + year + "";
                }
                ds = ConSql.ExecuteReader("Allianz_Travel", "USP_CommGeneration", new object[] { "GetDetails",FDate, ToDate, Session["UserId"] });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    grid.Visible = true;
                    btnExportToexcel.Visible = true;
                    GV_Commision.DataSource = ds.Tables[0];
                    GV_Commision.DataBind();
                }
                else
                {
                    grid.Visible = true;
                    btnExportToexcel.Visible = false;
                    GV_Commision.DataSource = ds.Tables[0];
                    GV_Commision.DataBind();
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

    protected void btnExportToexcel_Click(object sender, EventArgs e)
    {
        string month = ddlMonth.SelectedValue;
        string year = ddlYear.SelectedValue;
        int leapYear = (int.Parse(year) % 4);
        if (leapYear == 0 && month == "02")
        {
            FDate = "01-" + month + "-" + year + "";
            ToDate = "29-" + month + "-" + year + "";
        }
        else
        {
            if (month == "02")
            {
                FDate = "01-" + month + "-" + year + "";
                ToDate = "28-" + month + "-" + year + "";
            }
            else if (month == "01" || month == "03" || month == "05" || month == "07" || month == "08" || month == "10" || month == "12")
            {
                FDate = "01-" + month + "-" + year + "";
                ToDate = "31-" + month + "-" + year + "";
            }
            else if (month == "04" || month == "06" || month == "09" || month == "11")
            {
                FDate = "01-" + month + "-" + year + "";
                ToDate = "30-" + month + "-" + year + "";
            }
        }
        Session["FDate"] = FDate;
        Session["ToDate"] = ToDate;
        Response.Redirect("ExportToExcel.aspx");
    }
}