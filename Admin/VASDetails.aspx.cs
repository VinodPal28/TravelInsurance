
//-- =============================================
//-- Author:		<Vinod Pal>
//-- Create date:   <02-07-2018>
//-- Description:	<get only vas policies>
//-- =============================================
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_VASDetails : System.Web.UI.Page
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
                bool Authenticate = bl.CheckAuthority("VASDetails.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
               // BindCityMaster();
                BindCountry();
                BindMonth();
                bindYear();
                this.SearchCustomers();
                Bind_VasDetails();
            }
            if (Request.QueryString["Action"] == "Country1" || Request.QueryString["Action"] == "Country2" || Request.QueryString["Action"] == "Country3")
            {
                if (Request.QueryString["id"].ToString() != "" && Request.QueryString["id"].ToString() != null)
                {
                    string CountryCode = Request.QueryString["id"].ToString();

                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Clear();
                    Response.Write(GetCity(CountryCode));
                    Response.End();
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


    public string GetCity(string CountryCode)
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_VASCountryMaster", new object[] { "Get_City", CountryCode });

        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            row = new Dictionary<string, object>();

            foreach (DataColumn col in ds.Tables[0].Columns)
            {
                row.Add(col.ColumnName, dr[col]);
            }
            rows.Add(row);
        }

        return serializer.Serialize(rows);
    }
    public void BindCountry()
    {
        DataTable dtR = con.ExecuteReaderDt("Allianz_Travel", "USP_VASCountryMaster", new object[] { "Get_Country", "" });
        if (dtR.Rows.Count > 0)
        {
            ddlCountry1.DataSource = dtR;
            ddlCountry1.DataTextField = "Country";
            ddlCountry1.DataValueField = "Country_Code";
            ddlCountry1.DataBind();

            ddlCountry2.DataSource = dtR;
            ddlCountry2.DataTextField = "Country";
            ddlCountry2.DataValueField = "Country_Code";
            ddlCountry2.DataBind();

            ddlCountry3.DataSource = dtR;
            ddlCountry3.DataTextField = "Country";
            ddlCountry3.DataValueField = "Country_Code";
            ddlCountry3.DataBind();

        }
    }

    public void BindCityMaster()
    {
        DataTable dtR = con.ExecuteReaderDt("Allianz_Travel", "USP_VASCountryMaster", new object[] { "CityMaster", "" });
        if (dtR.Rows.Count > 0)
        {
            ddlCity1.DataSource = dtR;
            ddlCity1.DataTextField = "City";
            ddlCity1.DataValueField = "Country_Code";
            ddlCity1.DataBind();

            ddlCity2.DataSource = dtR;
            ddlCity2.DataTextField = "City";
            ddlCity2.DataValueField = "Country_Code";
            ddlCity2.DataBind();

            ddlCity3.DataSource = dtR;
            ddlCity3.DataTextField = "City";
            ddlCity3.DataValueField = "Country_Code";
            ddlCity3.DataBind();

        }
    }

    protected void bindYear()
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_VASEndorse", new object[] { "BindYear", "" });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlRegistrationYear1.DataSource = ds;
            ddlRegistrationYear1.DataValueField = "Id";
            ddlRegistrationYear1.DataTextField = "RegistrationYear";
            ddlRegistrationYear1.DataBind();
           
            //View
            ddlViewRegYear1.DataSource = ds;
            ddlViewRegYear1.DataValueField = "Id";
            ddlViewRegYear1.DataTextField = "RegistrationYear";
            ddlViewRegYear1.DataBind();

           
        }
    }

    protected void BindMonth()
    {
        DataSet ds = new DataSet();
        
        ds = con.ExecuteReader("Allianz_Travel", "USP_VASEndorse", new object[] { "BindMonth", "" });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlExpMonth.DataSource = ds;
            ddlExpMonth.DataValueField = "Id";
            ddlExpMonth.DataTextField = "ExpiryMonth";
            ddlExpMonth.DataBind();

            ddlViewExpMonth.DataSource = ds;
            ddlViewExpMonth.DataValueField = "Id";
            ddlViewExpMonth.DataTextField = "ExpiryMonth";
            ddlViewExpMonth.DataBind();
        }

        ds = con.ExecuteReader("Allianz_Travel", "USP_VASEndorse", new object[] { "BindCardYear", "" });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlExpYear.DataSource = ds;
            ddlExpYear.DataValueField = "Id";
            ddlExpYear.DataTextField = "ExpiryYear";
            ddlExpYear.DataBind();

            ddlViewExpYear.DataSource = ds;
            ddlViewExpYear.DataValueField = "Id";
            ddlViewExpYear.DataTextField = "ExpiryYear";
            ddlViewExpYear.DataBind();
        }
    }
    public void Bind_VasDetails()
    {
        ds = con.ExecuteReader("Allianz_Travel", "USP_VASEndorse", new object[] { "Bind", Session["UserId"].ToString() });
        if (ds.Tables[0].Rows.Count > 0)
        {
            GV_VASPolicy.DataSource = ds;
            GV_VASPolicy.DataBind();
        }
        else
        {
            GV_VASPolicy.DataSource = ds;
            GV_VASPolicy.DataBind();
        }
    }

    protected void GV_VASPolicy_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            string listOfCity = string.Empty;
            if (e.CommandName == "View")
            {

                Div_TrackNo.Visible = false;
                Div_Weather.Visible = false;
                Div_CardInfo.Visible = false;
                Div_RSA.Visible = false;

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

                    if (ds.Tables[0].Rows[0]["Bank_name"].ToString() != "" && ds.Tables[0].Rows[0]["Bank_name"].ToString() != null)
                    {
                        Div_CardInfo.Visible = true;
                        txtBankName.Text = ds.Tables[0].Rows[0]["Bank_name"].ToString();
                        ddlCardType.SelectedIndex = ddlCardType.Items.IndexOf(ddlCardType.Items.FindByText(ds.Tables[0].Rows[0]["Card_Type"].ToString()));
                        txtNameOfCardHolder.Text = ds.Tables[0].Rows[0]["Name_of_cardHolder"].ToString();
                        txtcardNo.Text = BusinessLogic.QueryStringDecode(ds.Tables[0].Rows[0]["card_number"].ToString());
                        ddlExpMonth.SelectedIndex = ddlExpMonth.Items.IndexOf(ddlExpMonth.Items.FindByText(ds.Tables[0].Rows[0]["Expiry_Month"].ToString()));
                        ddlExpYear.SelectedIndex = ddlExpYear.Items.IndexOf(ddlExpYear.Items.FindByText(ds.Tables[0].Rows[0]["Expiry_Year"].ToString()));
                    }

                    if (ds.Tables[0].Rows[0]["country"].ToString() != "" && ds.Tables[0].Rows[0]["country"].ToString() != null)
                    {
                        Div_Weather.Visible = true;
                        string[] country = ds.Tables[0].Rows[0]["country"].ToString().Split(',');
                        if(country.Length==1)
                        {
                            ddlCountry1.SelectedIndex = ddlCountry1.Items.IndexOf(ddlCountry1.Items.FindByText(country[0].ToString()));
                        }
                        else if (country.Length == 2)
                        {
                            ddlCountry1.SelectedIndex = ddlCountry1.Items.IndexOf(ddlCountry1.Items.FindByText(country[0].ToString()));
                            ddlCountry2.SelectedIndex = ddlCountry2.Items.IndexOf(ddlCountry2.Items.FindByText(country[1].ToString()));
                        }
                        else if (country.Length == 3)
                        {
                            ddlCountry1.SelectedIndex = ddlCountry1.Items.IndexOf(ddlCountry1.Items.FindByText(country[0].ToString()));
                            ddlCountry2.SelectedIndex = ddlCountry2.Items.IndexOf(ddlCountry2.Items.FindByText(country[1].ToString()));
                            ddlCountry3.SelectedIndex = ddlCountry3.Items.IndexOf(ddlCountry3.Items.FindByText(country[2].ToString()));
                        }

                        string[] City = ds.Tables[0].Rows[0]["City"].ToString().Split(',');
                        if (City.Length == 1)
                        {
                            ddlCity1.Items.Add(City[0].ToString());
                            hdnCity1.Value = City[0].ToString();


                        }
                        else if (City.Length == 2)
                        {
                            ddlCity1.Items.Add(City[0].ToString());
                            ddlCity2.Items.Add(City[1].ToString());
                            hdnCity1.Value = City[0].ToString();
                            hdnCity2.Value = City[1].ToString();

                        }
                        else if (City.Length == 3)
                        {                         
                            ddlCity1.Items.Add(City[0].ToString());
                            ddlCity2.Items.Add(City[1].ToString());
                            ddlCity3.Items.Add(City[2].ToString());
                            hdnCity1.Value = City[0].ToString();
                            hdnCity2.Value = City[1].ToString();
                            hdnCity3.Value = City[2].ToString();
                        }

                    }
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        Div_TrackNo.Visible = true;
                        txtTrackerNo1.Text = ds.Tables[1].Rows[0]["Luggage_TrackerNo"].ToString();
                        //if (ds.Tables[1].Rows.Count == 1)
                        //{
                        //    txtTrackerNo1.Text = ds.Tables[1].Rows[0]["Luggage_TrackerNo"].ToString();

                        //}
                        //if (ds.Tables[1].Rows.Count == 2)
                        //{
                        //    txtTrackerNo1.Text = ds.Tables[1].Rows[0]["Luggage_TrackerNo"].ToString();
                        //    txtTrackerNo2.Text = ds.Tables[1].Rows[1]["Luggage_TrackerNo"].ToString();

                        //}
                        //if (ds.Tables[1].Rows.Count == 3)
                        //{
                        //    txtTrackerNo1.Text = ds.Tables[1].Rows[0]["Luggage_TrackerNo"].ToString();
                        //    txtTrackerNo2.Text = ds.Tables[1].Rows[1]["Luggage_TrackerNo"].ToString();
                        //    txtTrackerNo3.Text = ds.Tables[1].Rows[2]["Luggage_TrackerNo"].ToString();

                        //}

                    }


                    if (ds.Tables[2].Rows.Count > 0)
                    {
                        Div_RSA.Visible = true;
                        txtMake1.Text = ds.Tables[2].Rows[0]["make"].ToString();
                        txtModle1.Text = ds.Tables[2].Rows[0]["Model"].ToString();
                        txtRegistrationNumber1.Text = ds.Tables[2].Rows[0]["RegistrationNo"].ToString();
                        ddlRegistrationYear1.SelectedIndex = ddlRegistrationYear1.Items.IndexOf(ddlRegistrationYear1.Items.FindByText(ds.Tables[2].Rows[0]["RegistrationYear"].ToString()));

                        //if (ds.Tables[2].Rows.Count == 1)
                        //{
                        //    txtMake1.Text = ds.Tables[2].Rows[0]["make"].ToString();
                        //    txtModle1.Text = ds.Tables[2].Rows[0]["Model"].ToString();
                        //    txtRegistrationNumber1.Text = ds.Tables[2].Rows[0]["RegistrationNo"].ToString();
                        //    ddlRegistrationYear1.SelectedIndex = ddlRegistrationYear1.Items.IndexOf(ddlRegistrationYear1.Items.FindByText(ds.Tables[2].Rows[0]["RegistrationYear"].ToString()));

                        //}
                        //if (ds.Tables[2].Rows.Count == 2)
                        //{
                        //    txtMake1.Text = ds.Tables[2].Rows[0]["make"].ToString();
                        //    txtModle1.Text = ds.Tables[2].Rows[0]["Model"].ToString();
                        //    txtRegistrationNumber1.Text = ds.Tables[2].Rows[0]["RegistrationNo"].ToString();
                        //    ddlRegistrationYear1.SelectedIndex = ddlRegistrationYear1.Items.IndexOf(ddlRegistrationYear1.Items.FindByText(ds.Tables[2].Rows[0]["RegistrationYear"].ToString()));

                        //    txtMake2.Text = ds.Tables[2].Rows[1]["make"].ToString();
                        //    txtModle2.Text = ds.Tables[2].Rows[1]["Model"].ToString();
                        //    txtRegistrationNumber2.Text = ds.Tables[2].Rows[1]["RegistrationNo"].ToString();
                        //    ddlRegistrationYear2.SelectedIndex = ddlRegistrationYear2.Items.IndexOf(ddlRegistrationYear2.Items.FindByText(ds.Tables[2].Rows[1]["RegistrationYear"].ToString()));

                        //}
                        //if (ds.Tables[2].Rows.Count == 3)
                        //{
                        //    txtMake1.Text = ds.Tables[2].Rows[0]["make"].ToString();
                        //    txtModle1.Text = ds.Tables[2].Rows[0]["Model"].ToString();
                        //    txtRegistrationNumber1.Text = ds.Tables[2].Rows[0]["RegistrationNo"].ToString();
                        //    ddlRegistrationYear1.SelectedIndex = ddlRegistrationYear1.Items.IndexOf(ddlRegistrationYear1.Items.FindByText(ds.Tables[2].Rows[0]["RegistrationYear"].ToString()));

                        //    txtMake2.Text = ds.Tables[2].Rows[1]["make"].ToString();
                        //    txtModle2.Text = ds.Tables[2].Rows[1]["Model"].ToString();
                        //    txtRegistrationNumber2.Text = ds.Tables[2].Rows[1]["RegistrationNo"].ToString();
                        //    ddlRegistrationYear2.SelectedIndex = ddlRegistrationYear2.Items.IndexOf(ddlRegistrationYear2.Items.FindByText(ds.Tables[2].Rows[1]["RegistrationYear"].ToString()));

                        //    txtMake3.Text = ds.Tables[2].Rows[2]["make"].ToString();
                        //    txtModle3.Text = ds.Tables[2].Rows[2]["Model"].ToString();
                        //    txtRegistrationNumber3.Text = ds.Tables[2].Rows[2]["RegistrationNo"].ToString();
                        //    ddlRegistrationYear3.SelectedIndex = ddlRegistrationYear2.Items.IndexOf(ddlRegistrationYear2.Items.FindByText(ds.Tables[2].Rows[2]["RegistrationYear"].ToString()));

                        //}

                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ViewMsg();", true);
                }
            }

            if (e.CommandName == "ViewPolicy")
            {
                View_Luggage.Visible = false;
                View_RSA.Visible = false;
                View_Card.Visible = false;
                View_WeatherInfo.Visible = false;

                GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                Label lblPolicy_No = (Label)row.FindControl("lblPolicy_No");
                ds = con.ExecuteReader("Allianz_Travel", "USP_VASEndorse", new object[] { "Details", lblPolicy_No.Text.Trim() });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtViewPolicyNo.Text = ds.Tables[0].Rows[0]["Policy_Number"].ToString();
                    txtViewSDate.Text = ds.Tables[0].Rows[0]["travel_StartDate"].ToString();
                    txtViewEDate.Text = ds.Tables[0].Rows[0]["travel_Enddate"].ToString();
                    txtViewName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                    txtViewContactNo.Text = ds.Tables[0].Rows[0]["Contact_Number"].ToString();
                    txtViewEmail.Text = ds.Tables[0].Rows[0]["Email_ID"].ToString();

                    if (ds.Tables[0].Rows[0]["Bank_name"].ToString() != "" && ds.Tables[0].Rows[0]["Bank_name"].ToString() != null)
                    {
                        View_Card.Visible = true;
                        txtViewBankName.Text = ds.Tables[0].Rows[0]["Bank_name"].ToString();
                        ddlViewCardtype.SelectedIndex = ddlViewCardtype.Items.IndexOf(ddlViewCardtype.Items.FindByText(ds.Tables[0].Rows[0]["Card_Type"].ToString()));
                        txtViewCardName.Text = ds.Tables[0].Rows[0]["Name_of_cardHolder"].ToString();
                        txtViewCardNo.Text = BusinessLogic.QueryStringDecode(ds.Tables[0].Rows[0]["card_number"].ToString());
                        ddlViewExpMonth.SelectedIndex = ddlViewExpMonth.Items.IndexOf(ddlViewExpMonth.Items.FindByText(ds.Tables[0].Rows[0]["Expiry_Month"].ToString()));
                        ddlViewExpYear.SelectedIndex = ddlViewExpYear.Items.IndexOf(ddlViewExpYear.Items.FindByText(ds.Tables[0].Rows[0]["Expiry_Year"].ToString()));
                    }

                    if (ds.Tables[0].Rows[0]["country"].ToString() != "" && ds.Tables[0].Rows[0]["country"].ToString() != null)
                    {
                        View_WeatherInfo.Visible = true;
                        string ViewlistOfCity = string.Empty;
                       
                        lblCountry.Text = ds.Tables[0].Rows[0]["country"].ToString();
                        lblCity.Text = ds.Tables[0].Rows[0]["City"].ToString();
                      

                    }
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        View_Luggage.Visible = true;
                        txtViewTracker1.Text = ds.Tables[1].Rows[0]["Luggage_TrackerNo"].ToString();
                        //if (ds.Tables[1].Rows.Count == 1)
                        //{
                        //    txtViewTracker1.Text = ds.Tables[1].Rows[0]["Luggage_TrackerNo"].ToString();

                        //}
                        //if (ds.Tables[1].Rows.Count == 2)
                        //{
                        //    txtViewTracker1.Text = ds.Tables[1].Rows[0]["Luggage_TrackerNo"].ToString();
                        //    txtViewTracker2.Text = ds.Tables[1].Rows[1]["Luggage_TrackerNo"].ToString();

                        //}
                        //if (ds.Tables[1].Rows.Count == 3)
                        //{
                        //    txtViewTracker1.Text = ds.Tables[1].Rows[0]["Luggage_TrackerNo"].ToString();
                        //    txtViewTracker2.Text = ds.Tables[1].Rows[1]["Luggage_TrackerNo"].ToString();
                        //    txtViewTracker3.Text = ds.Tables[1].Rows[2]["Luggage_TrackerNo"].ToString();

                        //}

                    }


                    if (ds.Tables[2].Rows.Count > 0)
                    {
                        View_RSA.Visible = true;
                        txtViewMake1.Text = ds.Tables[2].Rows[0]["make"].ToString();
                        txtViewModel1.Text = ds.Tables[2].Rows[0]["Model"].ToString();
                        txtViewRegNo1.Text = ds.Tables[2].Rows[0]["RegistrationNo"].ToString();
                        ddlViewRegYear1.SelectedIndex = ddlViewRegYear1.Items.IndexOf(ddlViewRegYear1.Items.FindByText(ds.Tables[2].Rows[0]["RegistrationYear"].ToString()));
                        //if (ds.Tables[2].Rows.Count == 1)
                        //{
                        //    txtViewMake1.Text = ds.Tables[2].Rows[0]["make"].ToString();
                        //    txtViewModel1.Text = ds.Tables[2].Rows[0]["Model"].ToString();
                        //    txtViewRegNo1.Text = ds.Tables[2].Rows[0]["RegistrationNo"].ToString();
                        //    ddlViewRegYear1.SelectedIndex = ddlViewRegYear1.Items.IndexOf(ddlViewRegYear1.Items.FindByText(ds.Tables[2].Rows[0]["RegistrationYear"].ToString()));

                        //}
                        //if (ds.Tables[2].Rows.Count == 2)
                        //{
                        //    txtViewMake1.Text = ds.Tables[2].Rows[0]["make"].ToString();
                        //    txtViewModel1.Text = ds.Tables[2].Rows[0]["Model"].ToString();
                        //    txtViewRegNo1.Text = ds.Tables[2].Rows[0]["RegistrationNo"].ToString();
                        //    ddlViewRegYear1.SelectedIndex = ddlViewRegYear1.Items.IndexOf(ddlViewRegYear1.Items.FindByText(ds.Tables[2].Rows[0]["RegistrationYear"].ToString()));

                        //    txtViewMake2.Text = ds.Tables[2].Rows[1]["make"].ToString();
                        //    txtViewModel2.Text = ds.Tables[2].Rows[1]["Model"].ToString();
                        //    txtViewRegNo2.Text = ds.Tables[2].Rows[1]["RegistrationNo"].ToString();
                        //    ddlViewRegYear2.SelectedIndex = ddlRegistrationYear2.Items.IndexOf(ddlRegistrationYear2.Items.FindByText(ds.Tables[2].Rows[1]["RegistrationYear"].ToString()));

                        //}
                        //if (ds.Tables[2].Rows.Count == 3)
                        //{
                        //    txtViewMake1.Text = ds.Tables[2].Rows[0]["make"].ToString();
                        //    txtViewModel1.Text = ds.Tables[2].Rows[0]["Model"].ToString();
                        //    txtViewRegNo1.Text = ds.Tables[2].Rows[0]["RegistrationNo"].ToString();
                        //    ddlViewRegYear1.SelectedIndex = ddlViewRegYear1.Items.IndexOf(ddlViewRegYear1.Items.FindByText(ds.Tables[2].Rows[0]["RegistrationYear"].ToString()));

                        //    txtViewMake2.Text = ds.Tables[2].Rows[1]["make"].ToString();
                        //    txtViewModel2.Text = ds.Tables[2].Rows[1]["Model"].ToString();
                        //    txtViewRegNo2.Text = ds.Tables[2].Rows[1]["RegistrationNo"].ToString();
                        //    ddlViewRegYear2.SelectedIndex = ddlRegistrationYear2.Items.IndexOf(ddlRegistrationYear2.Items.FindByText(ds.Tables[2].Rows[1]["RegistrationYear"].ToString()));

                        //    txtViewMake3.Text = ds.Tables[2].Rows[2]["make"].ToString();
                        //    txtViewModel3.Text = ds.Tables[2].Rows[2]["Model"].ToString();
                        //    txtViewRegNo3.Text = ds.Tables[2].Rows[2]["RegistrationNo"].ToString();
                        //    ddlViewRegYear3.SelectedIndex = ddlViewRegYear3.Items.IndexOf(ddlViewRegYear3.Items.FindByText(ds.Tables[2].Rows[2]["RegistrationYear"].ToString()));

                        //}

                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ViewData();", true);
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

    protected void btnVAS_Save_Click(object sender, EventArgs e)
    {
        try
        {           
            string Country = string.Empty;
            string City = string.Empty;

            if(ddlCountry1.SelectedItem.Text=="--Select--" && ddlCountry2.SelectedItem.Text == "--Select--" && ddlCountry3.SelectedItem.Text == "--Select--")
            {
                Country = "";
            }
            else if (ddlCountry1.SelectedItem.Text != "--Select--" && ddlCountry2.SelectedItem.Text != "--Select--" && ddlCountry3.SelectedItem.Text != "--Select--")
            {
                Country = ddlCountry1.SelectedItem.Text+','+ ddlCountry2.SelectedItem.Text+','+ ddlCountry1.SelectedItem.Text;
            }
            else if (ddlCountry1.SelectedItem.Text != "--Select--" && ddlCountry2.SelectedItem.Text == "--Select--" && ddlCountry3.SelectedItem.Text == "--Select--")
            {
                Country = ddlCountry1.SelectedItem.Text ;
            }
            else if (ddlCountry1.SelectedItem.Text != "--Select--" && ddlCountry2.SelectedItem.Text != "--Select--" && ddlCountry3.SelectedItem.Text == "--Select--")
            {
                Country = ddlCountry1.SelectedItem.Text+','+ ddlCountry2.SelectedItem.Text;
            }

            if (hdnCity1.Value == "" && hdnCity2.Value == "" && hdnCity3.Value == "")
            {
                City = "";
            }
            else if (hdnCity1.Value != "" && hdnCity2.Value != "" && hdnCity3.Value != "")
            {
                City = hdnCity1.Value + ',' + hdnCity2.Value + ',' + hdnCity3.Value;
            }
            else if (hdnCity1.Value != "" && hdnCity2.Value == "" && hdnCity3.Value == "")
            {
                City = hdnCity1.Value;
            }
            else if (hdnCity1.Value != "" && hdnCity2.Value != "" && hdnCity1.Value == "")
            {
                City = hdnCity1.Value + ',' + hdnCity2.Value;
            }


            string CardNo = BusinessLogic.QueryStringEncode(txtcardNo.Text.Trim());
            ds = con.ExecuteReader("Allianz_Travel", "USP_InsertVasDetails", new object[] { "Insert", txtPolicyNo.Text.ToString().Trim(), txtMake1.Text.Trim(), txtModle1.Text.Trim(), txtRegistrationNumber1.Text.Trim(), ddlRegistrationYear1.SelectedItem.Text.Trim(), "", "", "", "","", "","", "", txtBankName.Text.Trim(), ddlCardType.SelectedItem.Text.Trim(), txtNameOfCardHolder.Text.Trim(), CardNo.Trim(), ddlExpMonth.SelectedItem.Text, ddlExpYear.SelectedItem.Text, txtTrackerNo1.Text.Trim(), "", "", Country, City, Session["UserId"] });
            if (ds.Tables[0].Rows.Count > 0)
            {
                Bind_VasDetails();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMsg();", true);               
               
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

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        SearchCustomers();
    }

    private void SearchCustomers()
    {
        try
        {
            DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_SearchVasPolicies", new object[] { "Search", txtSearch.Text.Trim(), 0 });
            if (dt.Rows.Count > 0)
            {
                GV_VASPolicy.DataSource = dt;
                GV_VASPolicy.DataBind();
            }
            else
            {
                GV_VASPolicy.DataSource = dt;
                GV_VASPolicy.DataBind();
            }


        }
        catch (Exception ex)
        { }
    }

    protected void GV_VASPolicy_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_VASPolicy.PageIndex = e.NewPageIndex;
        Bind_VasDetails();
    }
}