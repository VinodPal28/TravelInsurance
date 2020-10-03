using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Globalization;
using SelectPdf;
using System.Web;
using System.Text;
using System.Configuration;

public partial class Admin_ManagePolicy : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    string canceltype = ""; string policyNo = "";
    decimal WalletBalance = 0;
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
                bool Authenticate = bl.CheckAuthority("ManagePolicy.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "GetExtendPrice")
                {
                    GetExtendedPrice(Request.Params["EndDate"].ToString(), Request.Params["ExtendStartDate"].ToString(), Request.Params["ExtendEndDate"].ToString(), Request.Params["PlanCode"].ToString(), Request.Params["DOB"].ToString(), Request.Params["Country"].ToString());
                }

            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "SaveExtendData")
                {
                    SaveExtendedData(Request.Params["Policy_No"].ToString(), Request.Params["PolicyEnd_dtt"].ToString(), Request.Params["PolicyExtend_Enddate"].ToString(), Request.Params["PolicyExtendStartdate"].ToString(), Request.Params["PolicyStartDate"].ToString(), Request.Params["Total_Price"].ToString(), Request.Params["Extend_Price"].ToString(), Request.Params["Email"] == null ? "" : Request.Params["Email"].ToString(), Request.Params["CompEmail"] == null ? "" : Request.Params["CompEmail"].ToString(), Request.Params["CompName"] == null ? "" : Request.Params["CompName"].ToString(), Request.Params["CustName"] == null ? "" : Request.Params["CustName"].ToString());
                }
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "CheckDOB")
                {
                    CheckDOB(Request.Params["PlanCode"].ToString(), Request.Params["NewDOB"].ToString(), Request.Params["GeoGraphy"].ToString(), Request.Params["ExistingDOB"].ToString(), Request.Params["TravelSDate"].ToString(), Request.Params["TravelEDate"].ToString());
                }
            }
            if (!IsPostBack)
            {
                this.SearchCustomers();
                Bind_WalletBalance();
                Bind_City();
                Bind_State();
                Bind_ManagePolicy();
                Bind_Reason();
                Bind_Relation();
                CalendarExtDOB.EndDate = DateTime.Today;
                Bind_Title();
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

    public void CheckDOB(string PlanCode, string NewDOB, string Geography, string ExistingDOB, string TravelSDate, string TravelEDate)
    {
        string msg = string.Empty;
        DateTime A = DateTime.ParseExact(TravelSDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        DateTime B = DateTime.ParseExact(TravelEDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        TimeSpan tspan = B.Subtract(A);
        string days = ((int)tspan.TotalDays + 1).ToString();

        DateTime dtt = DateTime.Now;
        string dateAsString = dtt.ToString("MM/dd/yyyy");
        string dtString = NewDOB;
        DateTime dtTarget;
        if (DateTime.TryParseExact(dtString, "dd/MM/yyyy", System.Globalization.CultureInfo.CurrentCulture, System.Globalization.DateTimeStyles.None, out dtTarget))
        {
            dtString = dtTarget.ToString("MM/dd/yyyy");
        }
        DateTime dob = Convert.ToDateTime(dtString);
        DateTime now = DateTime.Now;
        TimeSpan ts = now - dob;
        int NewAge = ts.Days / 365;
        int NewChildAge = 0;
        if (NewAge == 0)
        {
            NewChildAge = ts.Days / 30;
        }

        DateTime dtt1 = DateTime.Now;
        string dateAsString1 = dtt1.ToString("MM/dd/yyyy");
        string dtString1 = ExistingDOB;
        DateTime dtTarget1;
        if (DateTime.TryParseExact(dtString1, "dd/MM/yyyy", System.Globalization.CultureInfo.CurrentCulture, System.Globalization.DateTimeStyles.None, out dtTarget1))
        {
            dtString1 = dtTarget1.ToString("MM/dd/yyyy");
        }
        DateTime dob1 = Convert.ToDateTime(dtString1);
        DateTime now1 = DateTime.Now;
        TimeSpan ts1 = now1 - dob1;
        int ExistingAge = ts1.Days / 365;
        int ExistingChildAge = 0;
        if (ExistingAge == 0)
        {
            ExistingChildAge = ts.Days / 30;
        }

        DataTable dtp = con.ExecuteReaderDt("Allianz_Travel", "USP_CheckDOB", new object[] { "GetDOB", PlanCode, Geography, days, ExistingAge, NewAge, ExistingChildAge, NewChildAge });
        if (dtp.Rows.Count > 0)
        {
            if (dtp.Rows[0]["Code"].ToString() != "")
            {
                msg = "NF";
            }
            else
            {
                msg = "F";
            }
        }
        Response.Write(msg);
        Response.End();
    }
    protected void Bind_Relation()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_NomineeRelation", new object[] { "" });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlRelationNominee.DataSource = ds;
                ddlRelationNominee.DataTextField = "Relation";
                ddlRelationNominee.DataValueField = "ID";
                ddlRelationNominee.DataBind();
            }

        }
        catch (Exception ex)
        {

        }
    }
    public void Bind_WalletBalance()
    {
        int UserId = 0;
        if (Session["UserTypeId"] != null && Session["UserTypeId"].ToString() == "99")
        {
            UserId = Convert.ToInt32(Session["PartnerId"]);
        }
        else
        {
            UserId = Convert.ToInt32(Session["UserId"]);
        }
        DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_WalletStmt", new object[] { "Wallet_Balance", UserId, "" });
        WalletBalance = Convert.ToDecimal(dt.Rows[0]["Balance"].ToString());
        lblWalletBlnce.Text = dt.Rows[0]["Balance"].ToString();
    }
    protected void GV_ManagePolicy_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_ManagePolicy.PageIndex = e.NewPageIndex;
        Bind_ManagePolicy();
    }
    public void SaveExtendedData(string Policy_No, string PolicyEnd_dtt, string PolicyExtend_Enddate, string PolicyExtendStartdate, string PolicyStartDate, string Total_Price, string Extend_Price, string Email, string CompanyEmail, string CompName, string CustName)
    {

        DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_WalletStmt", new object[] { "Wallet_Balance", Session["Userid"], "" });
        WalletBalance = Convert.ToDecimal(dt.Rows[0]["Balance"].ToString());
        //lblWalletBlnce.Text = dt.Rows[0]["Balance"].ToString();

        string msg = string.Empty;
        if (WalletBalance >= Convert.ToDecimal(Extend_Price))
        {

            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ExtendInsert", new object[] { "Extend_Request", Policy_No, "", PolicyEnd_dtt, PolicyExtend_Enddate, Total_Price, Extend_Price, 6, Session["UserId"], "", PolicyStartDate, PolicyExtendStartdate });
            if (ds.Tables[0].Rows.Count > 0)
            {

                DataSet ds2 = con.ExecuteReader("Allianz_Travel", "USP_GeDocumentName", new object[] { "GetDoc", Policy_No });
                if (ds2.Tables[0].Rows.Count > 0)
                {
                    string url = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
                    url = url + "PolicyDownload.aspx?Policy_No=" + Policy_No;
                    HtmlToPdf converter = new HtmlToPdf();

                    SelectPdf.PdfDocument doc = converter.ConvertUrl(url);

                    string Path2 = Server.MapPath("~/TermAndCondition/");
                    string tc = ds2.Tables[0].Rows[0]["Document_Path"].ToString();
                    int idx = ds2.Tables[0].Rows[0]["Document_Path"].ToString().LastIndexOf("_");
                    tc = tc.Substring(0, idx) + ".pdf";

                    if (!File.Exists(Path2 + tc))
                    {
                        doc.Save(Path2 + tc);
                    }
                    string allachment1 = Path2 + tc;
                    string Path = Server.MapPath("~/PolicyCertificate/");
                    doc.Save(Path + "Policy No-" + Policy_No + ".pdf");

                    doc.Close();

                    string attachment = Path + "Policy No-" + Policy_No + ".pdf";
                    sendmail_User(Policy_No, attachment, allachment1, Email, CompanyEmail, CompName, CustName);

                }

                msg = "F";
            }
        }
        else
        {
            msg = "NF";
        }
        Response.Write(msg);
        Response.End();
    }
    public void GetExtendedPrice(string EndDate, string ExtendStartDate, string ExtendEnddate, string plancode, string DOB, string Country)
    {

        string msg = string.Empty;
        //DateTime A = DateTime.ParseExact(ExtendStartDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        DateTime A = DateTime.ParseExact(ExtendStartDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        DateTime B = DateTime.ParseExact(ExtendEnddate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
        TimeSpan tspan = B.Subtract(A);
        string days = ((int)tspan.TotalDays + 1).ToString();

        DateTime dtt = DateTime.Now;
        string dateAsString = dtt.ToString("MM/dd/yyyy");
        string dtString = DOB;
        DateTime dtTarget;
        if (DateTime.TryParseExact(dtString, "dd/MM/yyyy", System.Globalization.CultureInfo.CurrentCulture, System.Globalization.DateTimeStyles.None, out dtTarget))
        {
            dtString = dtTarget.ToString("MM/dd/yyyy");
        }
        DateTime dob = Convert.ToDateTime(dtString);
        DateTime now = DateTime.Now;
        TimeSpan ts = now - dob;
        int Age = ts.Days / 365;
        int ChildAge = 0;
        if (Age == 0)
        {
            ChildAge = ts.Days / 30;
        }


        DataTable dtp = con.ExecuteReaderDt("Allianz_Travel", "USP_GetPriceForExtend", new object[] { "Get_Price", plancode, Age, days, Country, ChildAge });
        if (dtp.Rows.Count > 0)
        {
            if (dtp.Rows[0]["Plan_Price"].ToString() != "")
            {
                decimal ExtendPrice = Convert.ToDecimal(dtp.Rows[0]["Plan_Price"].ToString());
                //decimal CGST = ExtendPrice;
                //decimal cgstAmount = (Convert.ToDecimal(CGST * 18) / 100);
                //decimal Extended_Price = cgstAmount + CGST;
                msg = "F#" + ExtendPrice;
            }
            else if (dtp.Rows[0]["Plan_Price"].ToString() == "")
            {
                msg = "NF";
            }
        }
        Response.Write(msg);
        Response.End();

    }
    protected void Bind_ManagePolicy()
    {
        try
        {
            DataSet ds = new DataSet();
            int UserId = 0;
            if (Session["UserTypeId"] != null && Session["UserTypeId"].ToString() == "99")
            {
                //UserId = Convert.ToInt32(Session["PartnerId"]);
                UserId = Convert.ToInt32(Session["UserId"]);
                ds = con.ExecuteReader("Allianz_Travel", "USP_ManagePolicy", new object[] { "PolicyDetailsByEmp", 0, "", "", 0, "", UserId });
            }
            else
            {
                UserId = Convert.ToInt32(Session["UserId"]);
                ds = con.ExecuteReader("Allianz_Travel", "USP_ManagePolicy", new object[] { "Policy_Details", 0, "", "", 0, "", UserId });
            }
            
            if (ds.Tables[0].Rows.Count > 0)
            {
                GV_ManagePolicy.DataSource = ds;
                GV_ManagePolicy.DataBind();
            }
            else
            {
                GV_ManagePolicy.DataSource = ds;
                GV_ManagePolicy.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }

    public int GetId()
    {
        int id;
        if (Session["PartnerId"].ToString() != "")
        {
            id = Convert.ToInt32(Session["PartnerId"]);
        }
        else
        {
            id = Convert.ToInt32(Session["UserId"]);
        }
        return id;
    }
    protected void Bind_Reason()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetReason", new object[] { "Get_Reason" });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlRegason.DataSource = ds;
                ddlRegason.DataTextField = "Reason";
                ddlRegason.DataValueField = "Id";
                ddlRegason.DataBind();

            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void btnSub_Click(object sender, EventArgs e)
    {
        int id = GetId();
        string _FileName = "";
        try
        {
            if (hdnpolicytype.Value.ToString().ToUpper() == "POST")
            {
                if (Upload_File.HasFile)
                {
                    if (Upload_File.PostedFile.ContentLength < 20728650)
                    {
                        _FileName = RenameFile(Upload_File.FileName);
                        if (!File.Exists("~/Upload/" + _FileName))
                        {
                            Upload_File.SaveAs(MapPath("~/Upload/" + _FileName));
                        }

                    }
                }
            }

            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_SaveCancelRequest", new object[] { "Save", Hiddpolicy.Value.ToString().Trim(), hdnpolicytype.Value.ToString().Trim(), ddlRegason.SelectedValue, _FileName.Trim(), txt_remarks.Text.ToString().Trim(), id });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMsgCancelReq();", true);
                Bind_ManagePolicy();
                ((Admin_AdminMaster)this.Master).Notification();
            }
        }
        catch (Exception ex)
        {
        }


    }

    protected void Bind_State()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "Get_State", 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlState.DataSource = ds;
                ddlState.DataTextField = "name";
                ddlState.DataValueField = "id_state";
                ddlState.DataBind();

                ddlCompState.DataSource = ds;
                ddlCompState.DataTextField = "name";
                ddlCompState.DataValueField = "id_state";
                ddlCompState.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void Bind_City()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetCity", new object[] { "" });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlCity.DataSource = ds;
                ddlCity.DataTextField = "name";
                ddlCity.DataValueField = "id_city";
                ddlCity.DataBind();

                ddlCompCity.DataSource = ds;
                ddlCompCity.DataTextField = "name";
                ddlCompCity.DataValueField = "id_city";
                ddlCompCity.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void Bind_Title()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_TitleSurname", new object[] { "Get_Title", "" });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlTitle.DataSource = ds;
                ddlTitle.DataTextField = "surname";
                ddlTitle.DataValueField = "Id";
                ddlTitle.DataBind();

                //ddlCompanySurname.DataSource = ds;
                //ddlCompanySurname.DataTextField = "surname";
                //ddlCompanySurname.DataValueField = "Id";
                //ddlCompanySurname.DataBind();

            }
        }
        catch (Exception ex)
        {
        }
    }

    #region Rename File Name
    public string RenameFile(string FileName)
    {
        string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(FileName);
        string fileExtension = Path.GetExtension(FileName);
        return fileNameWithoutExtension + DateTime.Now.ToString("mmddyyHHmmssffff") + fileExtension;
    }
    #endregion

    protected void GV_ManagePolicy_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "PolicyCancel")
            {
                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                Label lblPolicy_No = (Label)row.FindControl("lblPolicy_No");
                Label lblissues_dtt = (Label)row.FindControl("lblissues_dtt");
                Label lblTravel_Start_Date = (Label)row.FindControl("lblTravel_Start_Date");
                DateTime Startdtt = DateTime.ParseExact(lblTravel_Start_Date.Text.ToString(), "dd/MM/yyyy", CultureInfo.InvariantCulture);
                DateTime curdt = DateTime.ParseExact(DateTime.Now.ToString("dd/MM/yyyy"), "dd/MM/yyyy", CultureInfo.InvariantCulture);
                Hiddpolicy.Value = lblPolicy_No.Text;
                if (Startdtt >= curdt)
                {
                    canceltype = "pre";
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Showage();", true);
                    File2.Visible = false;
                }
                else
                {
                    canceltype = "post";
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Showage();", true);
                    File2.Visible = true;
                }
                hdnpolicytype.Value = canceltype;
            }
            if (e.CommandName == "PolicyModification")
            {
                CompInfo.Visible = false;
                CustInfo.Visible = false;
                PassID.Visible = false;
                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                Label lblPolicy_No = (Label)row.FindControl("lblPolicy_No");
                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ModificationRequest", new object[] { "Plan_Modifiy", 0, lblPolicy_No.Text });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtpolicyno.Text = ds.Tables[0].Rows[0]["Policy_No"].ToString();
                    txtDOB.Text = ds.Tables[0].Rows[0]["DOB"].ToString();
                    hdnDOB.Value = ds.Tables[0].Rows[0]["DOB"].ToString();
                    txtTravelStartDate.Text = ds.Tables[0].Rows[0]["Travel_Start_Date"].ToString();
                    hdnPolicySDate.Value = ds.Tables[0].Rows[0]["Travel_Start_Date"].ToString();
                    txtTravelEndDate.Text = ds.Tables[0].Rows[0]["Travel_End_Date"].ToString();
                    hdnPolicyEDate.Value = ds.Tables[0].Rows[0]["Travel_End_Date"].ToString();
                    txtPlanName.Text = ds.Tables[0].Rows[0]["Plan_Name"].ToString();
                    hdnPlanCode.Value = ds.Tables[0].Rows[0]["Plan_Code"].ToString();
                    txtPrice.Text = ds.Tables[0].Rows[0]["Price"].ToString();
                    //txtGeographyAskcountry.Text = ds.Tables[0].Rows[0]["Country_Code"].ToString();
                    if(ds.Tables[0].Rows[0]["CountryName"].ToString()!="India")
                    {
                        PassID.Visible = true;
                    }
                    txtGeographyAskcountry.Text = ds.Tables[0].Rows[0]["CountryName"].ToString();
                    if (ds.Tables[0].Rows[0]["First_Name"].ToString() != "")
                    {
                        CustInfo.Visible = true;
                        CheckInfo.Value = "1";
                        ddlTitle.SelectedIndex= ddlTitle.Items.IndexOf(ddlTitle.Items.FindByText(ds.Tables[0].Rows[0]["title"].ToString()));
                        txtFirstname.Text = ds.Tables[0].Rows[0]["First_Name"].ToString();
                        txtMiddlename.Text = ds.Tables[0].Rows[0]["Middle_Name"].ToString();
                        txtLastname.Text = ds.Tables[0].Rows[0]["Last_Name"].ToString();
                        txtContactNumber.Text = ds.Tables[0].Rows[0]["Contact_No"].ToString();
                        txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                        ddlState.SelectedIndex = ddlState.Items.IndexOf(ddlState.Items.FindByText(ds.Tables[0].Rows[0]["Nominee_State"].ToString()));
                        ddlCity.SelectedIndex = ddlCity.Items.IndexOf(ddlCity.Items.FindByText(ds.Tables[0].Rows[0]["Nominee_City"].ToString()));
                        hdnCustCity.Value = ds.Tables[0].Rows[0]["CityCode"].ToString();
                        txtPinCode.Text = ds.Tables[0].Rows[0]["Nominee_PIN"].ToString();
                        txtAadhaar.Text = ds.Tables[0].Rows[0]["Nominee_Aadhar"].ToString();
                        txtPanNo.Text = ds.Tables[0].Rows[0]["Nominee_PAN"].ToString();
                        txtNomineeAddres.Text = ds.Tables[0].Rows[0]["Nominee_Address"].ToString();
                        txtCustPassport.Text = ds.Tables[0].Rows[0]["PassportNo"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["CompanyName"].ToString() != "")
                    {
                        CompInfo.Visible = true;
                        CheckInfo.Value = "0";
                        txtCompName.Text = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                        txtCompEmailID.Text = ds.Tables[0].Rows[0]["Company_EmailId"].ToString();
                        txtCompGSTIN.Text = ds.Tables[0].Rows[0]["Company_GSTIN"].ToString();
                        txtCompPinCode.Text = ds.Tables[0].Rows[0]["Company_Pin"].ToString();
                        txtCompAddress.Text = ds.Tables[0].Rows[0]["ComapnyAddress"].ToString();
                        ddlCompState.SelectedIndex = ddlCompState.Items.IndexOf(ddlCompState.Items.FindByText(ds.Tables[0].Rows[0]["CompState"].ToString()));
                        ddlCompCity.SelectedIndex = ddlCompCity.Items.IndexOf(ddlCompCity.Items.FindByText(ds.Tables[0].Rows[0]["CompCity"].ToString()));
                        hdnCompCity.Value = ds.Tables[0].Rows[0]["CompCity"].ToString();

                        if (ds.Tables[1].Rows.Count > 0)
                        {
                            GV_MiceInfo.DataSource = ds.Tables[1];
                            GV_MiceInfo.DataBind();
                        }
                        else
                        {
                            GV_MiceInfo.DataSource = ds.Tables[1];
                            GV_MiceInfo.DataBind();
                        }

                    }
                    txtNomineename.Text = ds.Tables[0].Rows[0]["Nominee_Name"].ToString();
                    ddlRelationNominee.SelectedIndex = ddlRelationNominee.Items.IndexOf(ddlRelationNominee.Items.FindByText(ds.Tables[0].Rows[0]["NomineeRelation"].ToString()));
                    CalendarPolicySdate.StartDate = DateTime.ParseExact(hdnPolicyEDate.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture).AddDays(1);
                    CalendarPolicyEdate.StartDate = DateTime.ParseExact(hdnPolicyEDate.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture).AddDays(1);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Showage2();", true);
                }

            }
            if (e.CommandName == "Extend")
            {
                txtNewEndDate.Text = "";
                CompanyInfo.Visible = false;
                CustomerInfo.Visible = false;
                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                Label lblPolicy_No = (Label)row.FindControl("lblPolicy_No");
                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ModificationRequest", new object[] { "Plan_Modifiy", 0, lblPolicy_No.Text });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Hidden_PolicyNo.Value = ds.Tables[0].Rows[0]["Policy_No"].ToString();
                    hiddenFieldID.Value = ds.Tables[0].Rows[0]["Travel_End_Date"].ToString();
                    txtpolicyno.Text = ds.Tables[0].Rows[0]["Policy_No"].ToString();
                    txtdob2.Text = ds.Tables[0].Rows[0]["DOB"].ToString();
                    txtstartdtt.Text = ds.Tables[0].Rows[0]["Travel_Start_Date"].ToString();
                    hdnNewStartDate.Value = ds.Tables[0].Rows[0]["Travel_Start_Date"].ToString();
                    txtEnddtt.Text = ds.Tables[0].Rows[0]["Travel_End_Date"].ToString();
                    txtPlanNames.Text = ds.Tables[0].Rows[0]["Plan_Name"].ToString();
                    hiddenPlanCode.Value = ds.Tables[0].Rows[0]["Plan_Code"].ToString();
                    txtPrices.Text = ds.Tables[0].Rows[0]["Price"].ToString();
                    txtCountry.Text = ds.Tables[0].Rows[0]["CountryName"].ToString();
                    if (ds.Tables[0].Rows[0]["First_Name"].ToString() != "")
                    {
                        CustomerInfo.Visible = true;
                        txtNameFirst.Text = ds.Tables[0].Rows[0]["First_Name"].ToString();
                        txtNameMiddle.Text = ds.Tables[0].Rows[0]["Middle_Name"].ToString();
                        txtNameLast.Text = ds.Tables[0].Rows[0]["Last_Name"].ToString();
                        txtNumber.Text = ds.Tables[0].Rows[0]["Contact_No"].ToString();
                        txtEmailid.Text = ds.Tables[0].Rows[0]["Email"].ToString();

                        txtStates.Text = ds.Tables[0].Rows[0]["Nominee_State"].ToString();
                        txtCitys.Text = ds.Tables[0].Rows[0]["Nominee_City"].ToString();
                        txtPincodes.Text = ds.Tables[0].Rows[0]["Nominee_PIN"].ToString();
                        txtAdhaar.Text = ds.Tables[0].Rows[0]["Nominee_Aadhar"].ToString();
                        txtPan_number.Text = ds.Tables[0].Rows[0]["Nominee_PAN"].ToString();
                        txtNomineeAddress.Text = ds.Tables[0].Rows[0]["Nominee_Address"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["CompanyName"].ToString() != "")
                    {
                        CompanyInfo.Visible = true;
                        txtCompanyName.Text = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                        txtCompEmail.Text = ds.Tables[0].Rows[0]["Company_EmailId"].ToString();
                        txtComp_GSTIN.Text = ds.Tables[0].Rows[0]["Company_GSTIN"].ToString();
                        txtCompanyState.Text = ds.Tables[0].Rows[0]["CompState"].ToString();
                        txtCompanyCity.Text = ds.Tables[0].Rows[0]["CompCity"].ToString();
                        txtCompanyPin.Text = ds.Tables[0].Rows[0]["Company_Pin"].ToString();
                        txtCompanyAddress.Text = ds.Tables[0].Rows[0]["ComapnyAddress"].ToString();
                    }
                    txtNomineeNames.Text = ds.Tables[0].Rows[0]["Nominee_Name"].ToString();
                    txtNomineeRelation.Text = ds.Tables[0].Rows[0]["NomineeRelation"].ToString();
                    CalendarNewStartDate.StartDate = DateTime.ParseExact(hiddenFieldID.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture).AddDays(1);
                    //CalendarNewStartDate.EndDate = DateTime.ParseExact(hiddenFieldID.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture).AddDays(90);
                    Calendarenddtt.StartDate = DateTime.ParseExact(hiddenFieldID.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture).AddDays(1);
                    DateTime dt = DateTime.ParseExact(hiddenFieldID.Value, "dd/MM/yyyy", CultureInfo.InvariantCulture).AddDays(1);
                    txtNewStartDate.Text = dt.ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Showage3();", true);
                }

            }
            if (e.CommandName == "PolicyDownload")
            {
                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                Label PolicyNo = (Label)row.FindControl("lblPolicy_No");
                string url = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
                DataSet dsMxt = con.ExecuteReader("Allianz_Travel", "USP_CheckVAS", new object[] { "Check", PolicyNo.Text });
                if (dsMxt.Tables[0].Rows.Count > 0)
                {
                    if (dsMxt.Tables[0].Rows[0]["MatrixPath"].ToString() == "Matrix")
                    {
                        string Type = dsMxt.Tables[0].Rows[0]["type"].ToString();
                        url = url + "Download_MatrixPolicy.aspx?Policy_No=" + PolicyNo.Text + "&Type=" + Type;
                    }
                    else
                    {
                        url = url + "PolicyDownload.aspx?Policy_No=" + PolicyNo.Text;
                    }

                }

                string FooterUrl = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
                FooterUrl = FooterUrl + "Footer.aspx";

                bool showFooterOnFirstPage = true;
                bool showFooterOnOddPages = true;
                bool showFooterOnEvenPages = true;
                int footerHeight = 40;
                try
                {
                    footerHeight = Convert.ToInt32("40px");
                }
                catch { }
                // url = url + "PolicyDownload.aspx?Policy_No=" + PolicyNo.Text;
                HtmlToPdf converter = new HtmlToPdf();
                //create a new pdf document converting an url

                converter.Options.DisplayFooter = showFooterOnFirstPage || showFooterOnOddPages || showFooterOnEvenPages;
                converter.Footer.DisplayOnFirstPage = showFooterOnFirstPage;
                converter.Footer.DisplayOnOddPages = showFooterOnOddPages;
                converter.Footer.DisplayOnEvenPages = showFooterOnEvenPages;
                converter.Footer.Height = footerHeight;

                PdfHtmlSection footerHtml = new PdfHtmlSection(FooterUrl);
                footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
                converter.Footer.Add(footerHtml);

                SelectPdf.PdfDocument doc = converter.ConvertUrl(url);
                //save pdf document
                doc.Save(Response, false, "Policy No-" + PolicyNo.Text + ".pdf");
                //close pdf document
                doc.Close();

            }
            if (e.CommandName == "ExtendDetailsView")
            {
                GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                Label lblPolicy_No = (Label)row.FindControl("lblPolicy_No");
                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetExtendDetails", new object[] { "GET_DETAILS", lblPolicy_No.Text, 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    GV_Extend.DataSource = ds;
                    GV_Extend.DataBind();
                }
                else
                {
                    GV_Extend.DataSource = ds;
                    GV_Extend.DataBind();
                }
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "GetExtendDetails();", true);
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

    protected void btnPaymentMethod_Click(object sender, EventArgs e)
    {
        try
        {
            int id = GetId();
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ModificationInsert", new object[] { "Plan_Insert", txtpolicyno.Text.Trim(), txtFirstname.Text.Trim(), txtMiddlename.Text.Trim(), txtLastname.Text.Trim(), txtContactNumber.Text.Trim(), txtEmail.Text.Trim(), txtNomineename.Text.Trim(), ddlState.SelectedValue, hdnCustCity.Value, txtPinCode.Text.Trim(), txtPanNo.Text.Trim(), txtAadhaar.Text.Trim(), txtNomineeAddres.Text.Trim(), id, ddlRelationNominee.SelectedItem.Text, txtCompName.Text.Trim(), txtCompEmailID.Text.Trim(), txtCompGSTIN.Text.Trim(), txtCompAddress.Text.Trim(), txtCustPassport.Text.Trim(), txtDOB.Text.Trim(), txtTravelStartDate.Text.Trim(), txtTravelEndDate.Text.Trim(),ddlTitle.SelectedItem.Text });
            if (ds.Tables[0].Rows.Count > 0)
            {
                int index = 0;
                foreach (GridViewRow row in GV_MiceInfo.Rows)
                {
                    if (row.RowType == DataControlRowType.DataRow)
                    {
                        HiddenField MiceNo = GV_MiceInfo.Rows[index].FindControl("hdnMiceNo") as HiddenField;
                        TextBox name = GV_MiceInfo.Rows[index].FindControl("txtMiceName") as TextBox;
                        TextBox passportNo = GV_MiceInfo.Rows[index].FindControl("txtMicePassportNo") as TextBox;
                        TextBox MobNo = GV_MiceInfo.Rows[index].FindControl("txtMiceMobNo") as TextBox;
                        TextBox EmailID = GV_MiceInfo.Rows[index].FindControl("txtMiceEmailID") as TextBox;
                        DropDownList Gender = GV_MiceInfo.Rows[index].FindControl("ddlMiceGender") as DropDownList;

                        DataSet ds1 = con.ExecuteReader("Allianz_Travel", "USP_InsertMiceLog", new object[] { "insert", MiceNo.Value, name.Text, passportNo.Text, MobNo.Text, EmailID.Text, Gender.Text });
                    }
                    index++;
                }

                Bind_ManagePolicy();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMsgEndorseReq();", true);
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void GV_ManagePolicy_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label ExtendStatus = (Label)e.Row.FindControl("lblExtendStatus");
            Label Cancel_Count = (Label)e.Row.FindControl("lblCancelCount");
            Label Endorse_Count = (Label)e.Row.FindControl("lblEndorseCount");
            Label Extend_Count = (Label)e.Row.FindControl("lblExtendCount");
            //Label Status = (Label)e.Row.FindControl("lblStatus");

            Button btnCancel = (Button)e.Row.FindControl("btnCancel");
            Button btnEndorse = (Button)e.Row.FindControl("btnEndorse");
            Button btnExtend = (Button)e.Row.FindControl("btnExtend");
            //LinkButton linkbtnPolicyNo = (LinkButton)e.Row.FindControl("LinkPolicyNo");
            if (int.Parse(Cancel_Count.Text.ToString()) >= 6)
            {
                btnCancel.Enabled = true;
                btnCancel.Enabled = false;
                btnCancel.CssClass = "btn btn-sm round btn-outline-fade";
            }
            if (int.Parse(Endorse_Count.Text.ToString()) >= 6)
            {
                btnEndorse.Enabled = true;
                btnEndorse.Enabled = false;
                btnEndorse.CssClass = "btn btn-sm round btn-outline-fade";
            }
            if (int.Parse(Extend_Count.Text.ToString()) >= 6)
            {
                btnExtend.Enabled = true;
                btnExtend.Enabled = false;
                btnExtend.CssClass = "btn btn-sm round btn-outline-fade";
            }
            if (ExtendStatus.Text.ToString() == "Disabled")
            {
                btnExtend.Enabled = true;
                btnExtend.Enabled = false;
                btnExtend.CssClass = "btn btn-sm round btn-outline-fade";
            }
            //if (int.Parse(Status.Text.ToString()) != 6)
            //{
            //    linkbtnPolicyNo.Enabled = true;
            //    linkbtnPolicyNo.Enabled = false;
            //    linkbtnPolicyNo.CssClass = "btn btn-sm round btn-outline-fade";
            //}
        }
    }


    private void SearchCustomers()
    {
        try
        {
            DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "[USP_AllSearch]", new object[] { "Search", "", "", "", "", "", "", "", txtSearch.Text.Trim() });
            if (dt.Rows.Count > 0)
            {
                GV_ManagePolicy.DataSource = dt;
                GV_ManagePolicy.DataBind();
            }
            else
            {
                GV_ManagePolicy.DataSource = dt;
                GV_ManagePolicy.DataBind();
            }

        }
        catch (Exception ex)
        { }
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        SearchCustomers();

    }

    protected void GV_MiceInfo_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataRowView drv = e.Row.DataItem as DataRowView;
            DropDownList ddlCategories = e.Row.FindControl("DdlCategories") as DropDownList;


            if (ddlCategories != null)
            {
                //Get the data from DB and bind the dropdownlist
                ddlCategories.SelectedValue = drv["Gender"].ToString();
            }



        }
    }

    #region Send Mail
    private void sendmail_User(string policy_No, string attachment, string attachment1, string EmailId, string CompEmail, string CustName, string CompName)
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sblogo = new StringBuilder();
            string myTemplate = "", strSubject = "", strTo = "";
            if (EmailId != "")
            { strTo = EmailId; }
            if (CompEmail != "")
            { strTo = CompEmail; }

            string strFrom = ConfigurationManager.AppSettings["frommail"].ToString();
            DataSet dtvar = con.ExecuteReader("Allianz_Travel", "Get_Email", new object[] { "ExtendPolicy", 0, 0, "", "", "", "", "" });

            StringBuilder stb = new StringBuilder();

            if (dtvar.Tables[0].Rows.Count > 0)
            {
                strSubject = dtvar.Tables[0].Rows[0]["Subject"].ToString();
                stb.Append(dtvar.Tables[0].Rows[0]["Body"].ToString());
            }
            if (CustName != "")
            { stb.Replace("[Name]", CustName); }
            if (CompName != "")
            { stb.Replace("[Name]", CompName); }

            stb.Replace("[PolicyNo]", policy_No);

            DataSet ds1 = con.ExecuteReader("Allianz_Travel", "USP_GetTitleOfName", new object[] { "Get", policy_No });
            if (ds1.Tables[0].Rows.Count > 0)
            {
                stb.Replace("[Title]", ds1.Tables[0].Rows[0]["Title"].ToString());
            }
            string Link = ConfigurationManager.AppSettings["virtualpath"].ToString() + "Login.aspx";
            bl.sendmail(strSubject, stb.ToString(), attachment, attachment1, strFrom, strTo, "", "");

        }
        catch (Exception ex)
        {

        }
    }
    #endregion

    protected void GV_ManagePolicy_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        GV_ManagePolicy.PageIndex = e.NewPageIndex;
        Bind_ManagePolicy();
    }

    protected void btnExtendSave_Click(object sender, EventArgs e)
    {
       int id = GetId();
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ExtendInsert", new object[] { "Extend_Request", Hidden_PolicyNo.Value, "", txtEnddtt.Text.Trim(), txtNewEndDate.Text.Trim(), txtPrices.Text.Trim(), HiddenFieldPrice.Value.Trim(), 0, id, "", txtstartdtt.Text.Trim(), hdnNewStartDate.Value.Trim(), "" });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowExtendReqMsg();", true);
            Bind_ManagePolicy();
        }
    }
}