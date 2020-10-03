
//-- =============================================
//-- Author:		<Vinod Pal>
//-- Create date:   <02-07-2018>
//-- Description:	<get only vas policies>
//-- =============================================
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_VASRequest : System.Web.UI.Page
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
            else
            {
                bool Authenticate = bl.CheckAuthority("VASRequest.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }

            if (!IsPostBack)
            {
               // BindMonth();
                //BindYear();
                Bind_VasDetails();
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
    //protected void BindYear()
    //{
    //    DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_VASEndorse", new object[] { "BindYear", "" });
    //    if (ds.Tables[0].Rows.Count > 0)
    //    {
    //        ddlRegistrationYear1.DataSource = ds;
    //        ddlRegistrationYear1.DataValueField = "Id";
    //        ddlRegistrationYear1.DataTextField = "RegistrationYear";
    //        ddlRegistrationYear1.DataBind();       

    //    }
    //}

    //protected void BindMonth()
    //{
    //    DataSet ds = new DataSet();
      
    //    ds = con.ExecuteReader("Allianz_Travel", "USP_VASEndorse", new object[] { "BindMonth", "" });
    //    if (ds.Tables[0].Rows.Count > 0)
    //    {
    //        ddlExpMonth.DataSource = ds;
    //        ddlExpMonth.DataValueField = "Id";
    //        ddlExpMonth.DataTextField = "ExpiryMonth";
    //        ddlExpMonth.DataBind();


    //    }

    //    ds = con.ExecuteReader("Allianz_Travel", "USP_VASEndorse", new object[] { "BindCardYear", "" });
    //    if (ds.Tables[0].Rows.Count > 0)
    //    {
    //        ddlExpYear.DataSource = ds;
    //        ddlExpYear.DataValueField = "Id";
    //        ddlExpYear.DataTextField = "ExpiryYear";
    //        ddlExpYear.DataBind();

    //    }
    //}
    public void Bind_VasDetails()
    {
        ds = con.ExecuteReader("Allianz_Travel", "USP_VASEndorseRequest", new object[] { "Bind", "" });
        if (ds.Tables[0].Rows.Count > 0)
        {
            GV_VASRequest.DataSource = ds;
            GV_VASRequest.DataBind();
        }
        else
        {
            GV_VASRequest.DataSource = ds;
            GV_VASRequest.DataBind();
        }
    }

    protected void GV_VASRequest_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_VASRequest.PageIndex = e.NewPageIndex;
        Bind_VasDetails();
    }

    protected void GV_VASRequest_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "View")
            {
                string listOfCity = string.Empty;
                Div_TrackNo.Visible = false;
                Div_Weather.Visible = false;
                Div_CardInfo.Visible = false;
                Div_RSA.Visible = false;

                CardProtectionNews.Visible = false;
                WeatherNewW.Visible = false;
                ExistingInfo.Visible = false;
                RoadsideNew.Visible = false;

                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                Label lblPolicy_No = (Label)row.FindControl("lblPolicy_No");
                ds = con.ExecuteReader("Allianz_Travel", "USP_VASEndorse", new object[] { "Details", lblPolicy_No.Text.Trim() });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtPolicyNo.Text = ds.Tables[0].Rows[0]["Policy_Number"].ToString();
                    txtstartdtt.Text = ds.Tables[0].Rows[0]["travel_StartDate"].ToString();
                    txtEnddtt.Text = ds.Tables[0].Rows[0]["travel_Enddate"].ToString();
                    txtName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                    txtNumber.Text = ds.Tables[0].Rows[0]["Contact_Number"].ToString();
                    txtEmailid.Text = ds.Tables[0].Rows[0]["Email_ID"].ToString();
                }
                DataSet ds1 = con.ExecuteReader("Allianz_Travel", "USP_VASEndorseRequest", new object[] { "GetData", lblPolicy_No.Text.Trim() });
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    PolicyID.Value= ds1.Tables[0].Rows[0]["ID"].ToString();
                    if (ds1.Tables[0].Rows[0]["Bank_Name"].ToString() != "" && ds1.Tables[0].Rows[0]["Bank_Name"].ToString() != null)
                    {
                        Div_CardInfo.Visible = true;
                        txtBankName.Text = ds1.Tables[0].Rows[0]["Bank_Name"].ToString();
                       // ddlCardType.SelectedIndex = ddlCardType.Items.IndexOf(ddlCardType.Items.FindByText(ds1.Tables[0].Rows[0]["CardType"].ToString()));
                        txt_CardType.Text = ds1.Tables[0].Rows[0]["CardType"].ToString();
                        txtNameOfCardHolder.Text = ds1.Tables[0].Rows[0]["NameOfCardHolder"].ToString();
                        txtcardNo.Text = BusinessLogic.QueryStringDecode(ds1.Tables[0].Rows[0]["CardNo"].ToString());
                        //ddlExpMonth.SelectedIndex = ddlExpMonth.Items.IndexOf(ddlExpMonth.Items.FindByText(ds1.Tables[0].Rows[0]["Expiry_Month"].ToString()));
                       // ddlExpYear.SelectedIndex = ddlExpYear.Items.IndexOf(ddlExpYear.Items.FindByText(ds1.Tables[0].Rows[0]["Expiry_Year"].ToString()));
                        txt_ExpMonth.Text= ds1.Tables[0].Rows[0]["Expiry_Month"].ToString();
                        txtExpYear.Text = ds1.Tables[0].Rows[0]["Expiry_Year"].ToString();
                    }

                    if (ds1.Tables[0].Rows[0]["CountryName"].ToString() != "" && ds1.Tables[0].Rows[0]["CountryName"].ToString() != null)
                    {
                        Div_Weather.Visible = true;
                        lblCountry.Text = ds1.Tables[0].Rows[0]["CountryName"].ToString();
                        lblCity.Text = ds1.Tables[0].Rows[0]["City"].ToString();
                       

                    }
                    if (ds1.Tables[0].Rows[0]["LuggageTrackerNo1"].ToString() != "" && ds1.Tables[0].Rows[0]["LuggageTrackerNo1"].ToString() != null)
                    {
                        Div_TrackNo.Visible = true;
                        txtTrackerNo1.Text = ds1.Tables[0].Rows[0]["LuggageTrackerNo1"].ToString();
                        //txtTrackerNo2.Text = ds1.Tables[0].Rows[0]["LuggageTrackerNo2"].ToString();
                        //txtTrackerNo3.Text = ds1.Tables[0].Rows[0]["LuggageTrackerNo3"].ToString();
                    }


                    if (ds1.Tables[0].Rows[0]["Make1"].ToString() != "" && ds1.Tables[0].Rows[0]["Make1"].ToString() != null)
                    {
                        Div_RSA.Visible = true;
                        txtMake1.Text = ds1.Tables[0].Rows[0]["Make1"].ToString();
                        txtModle1.Text = ds1.Tables[0].Rows[0]["Model1"].ToString();
                        txtRegistrationNumber1.Text = ds1.Tables[0].Rows[0]["RegistrartionNo1"].ToString();
                      //  ddlRegistrationYear1.SelectedIndex = ddlRegistrationYear1.Items.IndexOf(ddlRegistrationYear1.Items.FindByText(ds1.Tables[0].Rows[0]["RegistrartionYear1"].ToString()));
                        txt_RegistrationYear1.Text= ds1.Tables[0].Rows[0]["RegistrartionYear1"].ToString();
                    }
                    //Start Changes 19-12-2018
                    if (ds1.Tables[0].Rows[0]["ExistingMake"].ToString() != "" && ds1.Tables[0].Rows[0]["ExistingMake"].ToString() != null)
                    {
                        CardProtectionNews.Visible = true;
                        txt_BankNameNew.Text = ds1.Tables[0].Rows[0]["ExistingBankName"].ToString();
                        //ddl_CardTypeNew.SelectedIndex = ddl_CardTypeNew.Items.IndexOf(ddl_CardTypeNew.Items.FindByText(ds1.Tables[0].Rows[0]["ExistingCardType"].ToString()));
                        txt_CardTypeNew.Text= ds1.Tables[0].Rows[0]["ExistingCardType"].ToString();
                        txtNameofCardholderNew.Text = ds1.Tables[0].Rows[0]["ExistingCardHolderName"].ToString();
                        txtCardNumberNew.Text = BusinessLogic.QueryStringDecode(ds1.Tables[0].Rows[0]["ExistingCardNumber"].ToString());
                       // ddl_ExpiryMonthNew.SelectedIndex = ddl_ExpiryMonthNew.Items.IndexOf(ddl_ExpiryMonthNew.Items.FindByText(ds1.Tables[0].Rows[0]["ExistingExpiry_Month"].ToString()));
                       // ddl_ExpiryYearNew.SelectedIndex = ddlExpYear.Items.IndexOf(ddlExpYear.Items.FindByText(ds1.Tables[0].Rows[0]["ExistingExpiry_Year"].ToString()));
                        txt_ExpiryMonthNew.Text= ds1.Tables[0].Rows[0]["ExistingExpiry_Month"].ToString();
                        txt_ExpiryYearNew.Text = ds1.Tables[0].Rows[0]["ExistingExpiry_Year"].ToString();

                    }
                    if (ds1.Tables[0].Rows[0]["ExistingCountry"].ToString() != "" && ds1.Tables[0].Rows[0]["ExistingCountry"].ToString() != null)
                    {
                        WeatherNewW.Visible = true;
                        lblCountryNameNew.Text = ds1.Tables[0].Rows[0]["ExistingCountry"].ToString();
                        lblCityNew.Text = ds1.Tables[0].Rows[0]["ExistingCity"].ToString();
                    }
                    if (ds1.Tables[0].Rows[0]["ExistingLuggageNo"].ToString() != "" && ds1.Tables[0].Rows[0]["ExistingLuggageNo"].ToString() != null)
                    {
                        ExistingInfo.Visible = true;
                        txt_TrackerNumberNew.Text = ds1.Tables[0].Rows[0]["ExistingLuggageNo"].ToString();
                       
                    }

                    if (ds1.Tables[0].Rows[0]["ExistingMake"].ToString() != "" && ds1.Tables[0].Rows[0]["ExistingMake"].ToString() != null)
                    {
                        RoadsideNew.Visible = true;
                        txt_MakeNew.Text = ds1.Tables[0].Rows[0]["ExistingMake"].ToString();
                        txt_ModelNew.Text = ds1.Tables[0].Rows[0]["ExistingModel"].ToString();
                        txt_RegistrationnoNew.Text = ds1.Tables[0].Rows[0]["ExistingRegistrationNo"].ToString();
                       // ddl_RegistrationYearNew.SelectedIndex = ddl_RegistrationYearNew.Items.IndexOf(ddl_RegistrationYearNew.Items.FindByText(ds1.Tables[0].Rows[0]["ExistingRegistrationYear"].ToString()));
                        txt_RegistrationYearNew.Text = ds1.Tables[0].Rows[0]["ExistingRegistrationYear"].ToString();
                    }
                    //End Chages 19-12-2018
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ViewMsg();", true);
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

    protected void btnPolicyEnorseDisapprove_Click(object sender, EventArgs e)
    {
        try
        {
            ds = con.ExecuteReader("Allianz_Travel", "USP_VASApproval", new object[] { "Disapprove", Convert.ToInt32(PolicyID.Value), txtPolicyNo.Text.ToString(), txtRemark.Text.ToString().Trim(),0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "DisApprove();", true);
                Bind_VasDetails();
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

    protected void btnPolicyEnorseApprove_Click(object sender, EventArgs e)
    {
        try
        {
            ds = con.ExecuteReader("Allianz_Travel", "USP_VASApproval", new object[] { "Approve", Convert.ToInt32(PolicyID.Value), txtPolicyNo.Text.ToString(), "", 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Approve();", true);
                Bind_VasDetails();
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
}