
//-- =============================================
//-- Author:		<Author,,JAMAL AHMAD>
//-- Create date: <Create Date,22-05-2018,>
//-- Description:	<Description,,Buy Plan>
//-- =============================================
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;
using System.Text;
using SelectPdf;
using System.IO;
using System.Web.UI.HtmlControls;
using System.Data.SqlTypes;
using Newtonsoft.Json;
using System.Net;

public partial class BuyPolicy : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    BajajJsonRequest bj = new BajajJsonRequest();
    List<familyparamlist> lst = new List<familyparamlist>();
    bjaztravelissue trv = new bjaztravelissue();
    familyparamlist fd = new familyparamlist();
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Allianz_Travel"].ConnectionString);
    decimal WalletBalance = 0;
    string TravelType = string.Empty;
    DataTable dt = new DataTable();

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
                bool Authenticate = bl.CheckAuthority("BuyPolicy.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "CheckNoOfpersons")
                {
                    CheckNoOfPersonsAllowed(Request.Params["NoOfpersons"].ToString(), Request.Params["planCode"].ToString(), Request.Params["StartDate"].ToString(), Request.Params["EndDate"].ToString());
                }

            }
            if (Request.QueryString["Action"] == "PostDetail" || Request.QueryString["Action"] == "PostDetailCompany")
            {
                if (Request.QueryString["id"].ToString() != "" && Request.QueryString["id"].ToString() != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["id"].ToString());

                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Clear();
                    Response.Write(GetCity(id));
                    Response.End();
                }

            }
            if (Request.QueryString["Action"] == "SaveData")
            {
                if (Request.QueryString["lb"] != "" && Request.QueryString["lb"] != null)
                {
                    string empdata = Request.QueryString["lb"];
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Clear();
                    Response.Write(SaveData(empdata));
                    Response.End();
                }
            }
            if (Request.QueryString["Action"] != "")
            {
                if (Request.QueryString["Action"] == "PaymentTOSucc")
                {
                    if (Request.QueryString["orderid"] != "" && Request.QueryString["PolicyNumber"] != "")
                    {
                        SuccessMethod(Request.QueryString["orderid"], BusinessLogic.QueryStringDecode(Request.QueryString["PolicyNumber"].ToString()));
                    }
                }
                else if (Request.QueryString["Action"] == "PaymentTO")
                {
                    if (Request.QueryString["orderid"] != "" && Request.QueryString["PolicyNumber"] != "")
                    {
                        DeletePolicy(Request.QueryString["orderid"].ToString(), BusinessLogic.QueryStringDecode(Request.QueryString["PolicyNumber"].ToString()));
                    }
                }
            }

            if (Request.QueryString["Success"] != null)
            {
                if (Request.QueryString["Success"].ToString() == "true")
                {
                    P_TrxId.Visible = true;
                    trxId.InnerHtml = Session["TranxId"].ToString();
                    PolicyNo.InnerHtml = Session["PolicyNo1"].ToString();
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "MsgSuccess();", true);
                }
                else if (Request.QueryString["Success"].ToString() == "false")
                {
                    lblorderid.Text = Session["Id"].ToString();
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "MsgFail();", true);
                }
            }

            //btnSummery.Attributes.Add("onclick", "this.disabled='true';"+ClientScript.GetPostBackEventReference(btnSummery,null)+";Please Wali...");

            if (!IsPostBack)
            {

                GridViewPlanDetails.Visible = false;
                CalendarDOB.EndDate = DateTime.Today;
                CalendarTravelSDate.StartDate = DateTime.Today;
                CalendarTravelSDate.EndDate = DateTime.Today.AddDays(89);
                CalendarTravelEDate.StartDate = DateTime.Today;
                Bind_PlanList();
                Bind_GeographyAskcountry();
                Bind_State();
                Bind_City();
                Bind_Relation();
                Bind_Title();
                //ddlProductname.Items.Add(new ListItem("Select", "0", true));
                if (Session["PartnerCode"] != null && Session["PartnerCode"].ToString() != "" && Session["UserTypeId"].ToString() != "100")
                {
                    div_PartnerName.Visible = false;
                    ddlPlanlist.SelectedValue = Session["UserId"].ToString();
                    ddlPlanlist.Enabled = false;
                    ddlPlanlist.CssClass = "form-control";

                }
                else if (Session["UserTypeId"] != null && Session["UserTypeId"].ToString() == "100")
                {

                    ddlPlanlist.SelectedValue = Session["PartnerId"].ToString();
                    ddlPlanlist.Enabled = false;
                    ddlPlanlist.CssClass = "form-control";

                }
                else
                {
                    div_PartnerName.Visible = true;
                    ddlPlanlist.Enabled = true;
                    ddlPlanlist.CssClass = "form-control";
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

    public class Mice
    {
        public string Name { get; set; }
        public string PassportNo { get; set; }
        public string MobNo { get; set; }
        public string EmailId { get; set; }
        public string gender { get; set; }
    }
    public string SaveData(string MiceData)//WebMethod to Save the data  
    {
        string result = "", MiceNo = "";
        var serializeData = JsonConvert.DeserializeObject<List<Mice>>(MiceData);
        using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetMiceNo", new object[] { "GetMiceNo" }))
        {
            MiceNo = ds.Tables[0].Rows[0]["MiceNo"].ToString();
        }
        foreach (var data in serializeData)
        {
            using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsertMiceDetails", new object[] { "Insert", "", data.Name, data.PassportNo, data.MobNo, data.EmailId, Session["UserId"], long.Parse(MiceNo), data.gender }))
            {
                result = "F#" + MiceNo;
            }

        }

        return JsonConvert.SerializeObject(result);
    }
    public string GetCity(int id)
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "Get_City", id });

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

    public int GetId()
    {
        int id;
        if (Session["PartnerId"].ToString() != "")
        {
            id = Convert.ToInt32(Session["PartnerId"]);
        }
        else
        {
            id = Convert.ToInt32(ddlPlanlist.SelectedValue);
        }
        return id;
    }
    public void CheckNoOfPersonsAllowed(string NoOfPersons, string PlanCode, string SDate, string EDate)
    {
        string msg = "";
        dt = con.ExecuteReaderDt("Allianz_Travel", "USP_checkMICE", new object[] { "CheckNoofPersons", PlanCode });
        if (dt.Rows.Count > 0)
        {

            if (int.Parse(NoOfPersons) <= int.Parse(dt.Rows[0]["NoofTraveller"].ToString()))
            {
                msg = "F";
                //DateTime dt1 = DateTime.ParseExact(SDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                //DateTime dt2 = DateTime.ParseExact(EDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                //int days = (dt2 - dt1).Days;
                //int NoOfmanDays = (days * int.Parse(NoOfPersons));
                //if (NoOfmanDays <= int.Parse(dt.Rows[0]["NoofManDays"].ToString()))
                //{
                //    DataTable dtp = con.ExecuteReaderDt("Allianz_Travel", "USP_GetPrice", new object[] { "Get_Price", PlanCode, 0, days, "" });
                //    if (dtp.Rows.Count > 0)
                //    {
                //    }
                //}
                //else
                //{
                //    msg = "NoOfManDaysExceded#" + dt.Rows[0]["NoofManDays"].ToString();
                //}
            }
            else
            {
                msg = "NoOftravelExceded#" + dt.Rows[0]["NoofTraveller"].ToString();
            }
        }
        Response.Write(msg);
        Response.End();
    }
    public void Bind_WalletBalance()
    {
        int ID = GetId();
        //dt = con.ExecuteReaderDt("Allianz_Travel", "USP_WalletStmt", new object[] { "Wallet_Balance", ddlPlanlist.SelectedValue, "" });
        dt = con.ExecuteReaderDt("Allianz_Travel", "USP_WalletStmt", new object[] { "Wallet_Balance", ID, "" });
        WalletBalance = Convert.ToDecimal(dt.Rows[0]["Balance"].ToString());
        lblWalletBalace.Text = dt.Rows[0]["Balance"].ToString();
    }
    protected void Bind_PlanList()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "Partner_Name", 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlPlanlist.DataSource = ds;
                ddlPlanlist.DataTextField = "name";
                ddlPlanlist.DataValueField = "id";
                ddlPlanlist.DataBind();
            }
            else
            {

            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void Bind_GeographyAskcountry()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "GeographyAskcountry", 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlGeographyAskcountry.DataSource = ds;
                ddlGeographyAskcountry.DataTextField = "name";
                ddlGeographyAskcountry.DataValueField = "id";
                ddlGeographyAskcountry.DataBind();
            }
            else
            {

            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void ddlProductname_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            DateTime dt1 = DateTime.ParseExact(txtTravelStartDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime dt2 = DateTime.ParseExact(txtTravelEndDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            int days = (dt2 - dt1).Days + 1;

            // txtNoOfDays.Text = Convert.ToString(days);
            //DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_GetTripDuration", new object[] { "Get", ddlProductname.SelectedValue.ToString() });
            //if (dt.Rows.Count > 0)
            //{
            //    DateTime dtt = DateTime.Now;
            //    string dateAsString = dtt.ToString("dd/MM/yyyy");
            //    string dtString = txtDOB.Text;
            //    DateTime dtTarget;
            //    if (DateTime.TryParseExact(dtString, "dd/MM/yyyy", System.Globalization.CultureInfo.CurrentCulture, System.Globalization.DateTimeStyles.None, out dtTarget))
            //    {
            //        dtString = dtTarget.ToString("MM/dd/yyyy");
            //    }
            //    DateTime dob = Convert.ToDateTime(dtString);
            //    DateTime now = DateTime.Now;
            //    TimeSpan ts = now - dob;
            //    int Age = ts.Days / 365;

            //    if (dt.Rows[0]["Duration_Basis"].ToString().ToUpper() != "MICE")
            //    {
            //        NoOfPerson.Visible = false;
            //        int mindays = int.Parse(dt.Rows[0]["mindays"].ToString());
            //        int maxdays = int.Parse(dt.Rows[0]["maxdays"].ToString());
            //        if (days >= mindays && days <= maxdays)
            //        {
            //            DataTable dtp = con.ExecuteReaderDt("Allianz_Travel", "USP_GetPrice", new object[] { "Get_Price", ddlProductname.SelectedValue.ToString(), Age, days, ddlGeographyAskcountry.SelectedItem.Text });
            //            if (dtp.Rows.Count > 0)
            //            {
            //                txtPrice.Text = dtp.Rows[0]["Plan_Price"].ToString();
            //                decimal CGST = Convert.ToDecimal(txtPrice.Text.ToString());
            //                decimal cgstAmount = (Convert.ToDecimal(CGST * 18) / 100);
            //                txtPaymentamount.Text = (cgstAmount + CGST).ToString();
            //            }
            //        }
            //        else
            //        {
            //            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Showage();", true);
            //        }
            //    }
            //    else
            //    {
            //        NoOfPerson.Visible = true;
            //    }


            // }

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

            //DataSet ds1 = con.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "Get_State", 0 });
            //if (ds1.Tables[0].Rows.Count > 0)
            //{
            //    ddlDomesticState.DataSource = ds1;
            //    ddlDomesticState.DataTextField = "name";
            //    ddlDomesticState.DataValueField = "id_state";
            //    ddlDomesticState.DataBind();
            //}
        }
        catch (Exception ex)
        {

        }
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
    protected void Bind_City()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "Get_City", 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlCity.DataSource = ds;
                ddlCity.DataTextField = "name";
                ddlCity.DataValueField = "id_city";
                ddlCity.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void btnPaymentMethod_Click(object sender, EventArgs e)
    {
        try
        {
            int ID = GetId();
            Session["MobNo"] = txtContactNumber.Text.Trim();
            Session["Name"] = txtFirstname.Text.Trim();
            Session["CustomerEmailId"] = txtEmail.Text.ToString();
            Session["CompanyEmail"] = txtCompEmailID.Text.ToString();
            Session["FromMail"] = ConfigurationManager.AppSettings["frommail"].ToString();

            string PaymentMethod = string.Empty;
            if (Request.Form["radioPaymentOption"] != null)
            {
                PaymentMethod = Request.Form["radioPaymentOption"].ToString();

            }

            if (PaymentMethod == "Wallet")
            {
                Bind_WalletBalance();
                if (WalletBalance >= Convert.ToDecimal(HiddenPlanPrice.Value))
                {
                    string PolicyNumber = string.Empty;
                    string title = string.Empty;
                    if (ddlCompanySurname.SelectedValue != "0")
                    {
                        title = ddlCompanySurname.SelectedItem.Text;
                    }
                    if (ddlsurname.SelectedValue != "0")
                    {
                        title = ddlsurname.SelectedItem.Text;
                    }

                    //DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_BuyPlan", new object[] { "Plan_Insert", 0, "", HiddenplanCodeOfPolicy.Value.ToString().Trim(), txtTravelStartDate.Text.Trim(), txtTravelEndDate.Text.Trim(), txtDOB.Text.Trim(), ddlGeographyAskcountry.SelectedValue.Trim(), HiddenPlanPrice.Value.ToString().Trim(), txtFirstname.Text.Trim(), txtMiddlename.Text.Trim(), txtLastname.Text.Trim(), txtContactNumber.Text.Trim(), txtEmail.Text.Trim(), txtNomineename.Text.Trim(), txtNomineeAddres.Text.Trim(), txtPinCode.Text.Trim(), txtPanNo.Text.Trim(), txtAadhaar.Text.Trim(), "", SqlDateTime.Null, "0", "", 0, ddlPlanlist.SelectedItem.Value.Trim(), Session["UserId"], ddlState.SelectedValue.Trim(), HiddenCity.Value.Trim(), "0", txtNoOfPersons.Text.Trim(), txtGstIn.Text.Trim(), txtCompanyName.Text.Trim(), ddlGender.SelectedItem.Text, HiddenTravelType.Value.Trim(), txtCompGSTIN.Text.Trim(), ddlCompState.SelectedValue, HiddenCompCity.Value.Trim(), txtCompPincode.Text.Trim(), txtCompAddt.Text.Trim(), ddlRelationNominee.SelectedItem.Text, HiddenMiceNo.Value, txtCompEmailID.Text.Trim(), txtPassportNo.Text.Trim(), title });
                    DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_BuyPlan", new object[] { "Plan_Insert", 0, "", HiddenplanCodeOfPolicy.Value.ToString().Trim(), txtTravelStartDate.Text.Trim(), txtTravelEndDate.Text.Trim(), txtDOB.Text.Trim(), ddlGeographyAskcountry.SelectedValue.Trim(), HiddenPlanPrice.Value.ToString().Trim(), txtFirstname.Text.Trim(), txtMiddlename.Text.Trim(), txtLastname.Text.Trim(), txtContactNumber.Text.Trim(), txtEmail.Text.Trim(), txtNomineename.Text.Trim(), txtNomineeAddres.Text.Trim(), txtPinCode.Text.Trim(), txtPanNo.Text.Trim(), txtAadhaar.Text.Trim(), "", SqlDateTime.Null, "0", "", 0, ID, Session["UserId"], ddlState.SelectedValue.Trim(), HiddenCity.Value.Trim(), "0", txtNoOfPersons.Text.Trim(), txtGstIn.Text.Trim(), txtCompanyName.Text.Trim(), ddlGender.SelectedItem.Text, HiddenTravelType.Value.Trim(), txtCompGSTIN.Text.Trim(), ddlCompState.SelectedValue, HiddenCompCity.Value.Trim(), txtCompPincode.Text.Trim(), txtCompAddt.Text.Trim(), ddlRelationNominee.SelectedItem.Text, HiddenMiceNo.Value, txtCompEmailID.Text.Trim(), txtPassportNo.Text.Trim(), title });
                    if (ds.Tables[0].Rows.Count > 0)
                    {

                        DataSet ds1 = con.ExecuteReader("Allianz_Travel", "USP_GetPolicyNo", new object[] { "POLICYNO", ID });
                        if (ds1.Tables[0].Rows.Count > 0)
                        {
                            PolicyNo.InnerHtml = ds1.Tables[0].Rows[0]["POLICY_NO"].ToString();
                            string url = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
                            DataSet ds2 = con.ExecuteReader("Allianz_Travel", "USP_GeDocumentName", new object[] { "GetDoc", PolicyNo.InnerHtml });
                            if (ds2.Tables[0].Rows.Count > 0)
                            {
                                DataSet dsMxt = con.ExecuteReader("Allianz_Travel", "USP_CheckVAS", new object[] { "Check", PolicyNo.InnerHtml });
                                if (dsMxt.Tables[0].Rows.Count > 0)
                                {
                                    if (dsMxt.Tables[0].Rows[0]["MatrixPath"].ToString() == "Matrix")
                                    {
                                        string Type = dsMxt.Tables[0].Rows[0]["type"].ToString();
                                        url = url + "Download_MatrixPolicy.aspx?Policy_No=" + PolicyNo.InnerHtml + "&Type=" + Type;
                                    }
                                    else
                                    {
                                        url = url + "PolicyDownload.aspx?Policy_No=" + PolicyNo.InnerHtml;
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

                                HtmlToPdf converter = new HtmlToPdf();
                                converter.Options.DisplayFooter = showFooterOnFirstPage || showFooterOnOddPages || showFooterOnEvenPages;
                                converter.Footer.DisplayOnFirstPage = showFooterOnFirstPage;
                                converter.Footer.DisplayOnOddPages = showFooterOnOddPages;
                                converter.Footer.DisplayOnEvenPages = showFooterOnEvenPages;
                                converter.Footer.Height = footerHeight;

                                PdfHtmlSection footerHtml = new PdfHtmlSection(FooterUrl);
                                footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
                                converter.Footer.Add(footerHtml);

                                SelectPdf.PdfDocument doc = converter.ConvertUrl(url);


                                string Path2 = Server.MapPath("~/TermAndCondition/");
                                // id = Convert.ToInt32(ddlPlanlist.SelectedValue);
                                //string UserWiseFolder = Path.Combine(Path2, ddlPlanlist.SelectedValue.ToString()+"/");
                                string UserWiseFolder = Server.MapPath("~/TermAndCondition/"+ ddlPlanlist.SelectedValue.ToString() + "/");
                                if (!Directory.Exists(UserWiseFolder))
                                {
                                    Directory.CreateDirectory(UserWiseFolder);
                                }
                                string tc = ds2.Tables[0].Rows[0]["Document_Path"].ToString();
                                int idx = ds2.Tables[0].Rows[0]["Document_Path"].ToString().LastIndexOf("_");
                                string tc1 = tc.Substring(0, idx) + ".pdf";

                                PdfDocument doc1 = new PdfDocument();


                                if (File.Exists(Path.Combine(UserWiseFolder + tc1)))
                                {
                                    File.Delete(Path.Combine(UserWiseFolder + tc1));
                                }
                                if (!File.Exists(Path.Combine(UserWiseFolder + tc1)))
                                {
                                    //doc1.Save(Path2 + tc);
                                    File.Copy(Path2 + tc, Path.Combine(UserWiseFolder + tc1));
                                }
                                string allachment1 = Path.Combine(UserWiseFolder + tc1);
                                string path = Server.MapPath("~/PolicyCertificate/");

                                if (Directory.Exists(path))
                                {
                                    foreach (string file in Directory.GetFiles(path))
                                    {
                                        File.Delete(file);
                                    }
                                }
                                doc.Save(path + "Policy No-" + PolicyNo.InnerHtml + ".pdf");

                                doc.Close();
                                doc1.Close();

                                string attachment = path + "Policy No-" + PolicyNo.InnerHtml + ".pdf";
                                sendsms(txtContactNumber.Text, PolicyNo.InnerHtml, txtFirstname.Text);
                                sendmail_User(PolicyNo.InnerHtml, attachment, allachment1);
                                //IssueBajajPolicy(PolicyNo.InnerHtml);
                                P_TrxId.Visible = false;
                                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "MsgSuccess();", true);
                                Clear();
                                GV_PlanName.Visible = false;
                            }
                        }
                    }
                }
                else
                {
                    Clear();
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "CheckWalletBalance();", true);
                }
            }
            else if (PaymentMethod == "Card")
            {
                SaveDetails();

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
    protected void SaveDetails()
    {
        int ID = GetId();
        string PolicyNumber = string.Empty;
        string title = string.Empty;
        if (ddlCompanySurname.SelectedValue != "0")
        {
            title = ddlCompanySurname.SelectedItem.Text;
        }
        if (ddlsurname.SelectedValue != "0")
        {
            title = ddlsurname.SelectedItem.Text;
        }

        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_BuyPlan", new object[] { "InsertByOnline", 0, "", HiddenplanCodeOfPolicy.Value.ToString().Trim(), txtTravelStartDate.Text.Trim(), txtTravelEndDate.Text.Trim(), txtDOB.Text.Trim(), ddlGeographyAskcountry.SelectedValue.Trim(), HiddenPlanPrice.Value.ToString().Trim(), txtFirstname.Text.Trim(), txtMiddlename.Text.Trim(), txtLastname.Text.Trim(), txtContactNumber.Text.Trim(), txtEmail.Text.Trim(), txtNomineename.Text.Trim(), txtNomineeAddres.Text.Trim(), txtPinCode.Text.Trim(), txtPanNo.Text.Trim(), txtAadhaar.Text.Trim(), "", SqlDateTime.Null, "0", "", 0, ID, Session["UserId"], ddlState.SelectedValue.Trim(), HiddenCity.Value.Trim(), "0", txtNoOfPersons.Text.Trim(), txtGstIn.Text.Trim(), txtCompanyName.Text.Trim(), ddlGender.SelectedItem.Text, HiddenTravelType.Value.Trim(), txtCompGSTIN.Text.Trim(), ddlCompState.SelectedValue, HiddenCompCity.Value.Trim(), txtCompPincode.Text.Trim(), txtCompAddt.Text.Trim(), ddlRelationNominee.SelectedItem.Text, HiddenMiceNo.Value, txtCompEmailID.Text.Trim(), txtPassportNo.Text.Trim(), title });
        if (ds.Tables[0].Rows.Count > 0)
        {

            DataSet ds1 = con.ExecuteReader("Allianz_Travel", "USP_GetPolicyNo", new object[] { "POLICYNO", ID });
            if (ds1.Tables[0].Rows.Count > 0)
            {
                // PolicyNo.InnerHtml = ds1.Tables[0].Rows[0]["POLICY_NO"].ToString();
                Session["PolicyNo1"] = ds1.Tables[0].Rows[0]["POLICY_NO"].ToString();
                IssueBajajPolicy(Session["PolicyNo1"].ToString());
                Response.Redirect("/Admin/PaymentGateway.aspx?Action=PaymentGateway&Price=" + HiddenPlanPrice.Value.ToString().Trim() + "&PolicyNo=" + ds1.Tables[0].Rows[0]["POLICY_NO"].ToString());

            }
        }
        // return PolicyNumber;
    }
    protected void DeletePolicy(string TranxId, string PolicNo)
    {
        Session["Id"] = TranxId;
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_OnlinePayment", new object[] { "DeletePolicy", "", "", "", "", 0, 0, 0, "", PolicNo });
        if (ds.Tables[0].Rows.Count > 0)
        {
            Response.Redirect("~/Admin/BuyPolicy.aspx?Success=false");
        }
    }
    protected void SuccessMethod(string TrxId, string PolicyNo)
    {

        //trxId.InnerHtml = TrxId;
        Session["TranxId"] = TrxId;
        string url = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
        DataSet ds2 = con.ExecuteReader("Allianz_Travel", "USP_GeDocumentName", new object[] { "GetDoc", PolicyNo });
        if (ds2.Tables[0].Rows.Count > 0)
        {
            DataSet dsMxt = con.ExecuteReader("Allianz_Travel", "USP_CheckVAS", new object[] { "Check", PolicyNo });
            if (dsMxt.Tables[0].Rows.Count > 0)
            {
                if (dsMxt.Tables[0].Rows[0]["MatrixPath"].ToString() == "Matrix")
                {
                    string Type = dsMxt.Tables[0].Rows[0]["type"].ToString();
                    url = url + "Download_MatrixPolicy.aspx?Policy_No=" + PolicyNo + "&Type=" + Type;
                }
                else
                {
                    url = url + "PolicyDownload.aspx?Policy_No=" + PolicyNo;
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

            HtmlToPdf converter = new HtmlToPdf();
            converter.Options.DisplayFooter = showFooterOnFirstPage || showFooterOnOddPages || showFooterOnEvenPages;
            converter.Footer.DisplayOnFirstPage = showFooterOnFirstPage;
            converter.Footer.DisplayOnOddPages = showFooterOnOddPages;
            converter.Footer.DisplayOnEvenPages = showFooterOnEvenPages;
            converter.Footer.Height = footerHeight;

            PdfHtmlSection footerHtml = new PdfHtmlSection(FooterUrl);
            footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
            converter.Footer.Add(footerHtml);

            SelectPdf.PdfDocument doc = converter.ConvertUrl(url);

            string Path2 = Server.MapPath("~/TermAndCondition/");
            string UserWiseFolder = Server.MapPath("~/TermAndCondition/" + ddlPlanlist.SelectedValue.ToString() + "/");
            string tc = ds2.Tables[0].Rows[0]["Document_Path"].ToString();
            int idx = ds2.Tables[0].Rows[0]["Document_Path"].ToString().LastIndexOf("_");
            string tc1 = tc.Substring(0, idx) + ".pdf";

            PdfDocument doc1 = new PdfDocument();

            if (File.Exists(Path.Combine(UserWiseFolder + tc1)))
            {
                File.Delete(Path.Combine(UserWiseFolder + tc1));
            }
            if (!File.Exists(Path.Combine(UserWiseFolder + tc1)))
            {
                //doc1.Save(Path2 + tc);
                File.Copy(Path2 + tc, Path.Combine(UserWiseFolder + tc1));
            }
            string allachment1 = Path.Combine(UserWiseFolder + tc1);
            string path = Server.MapPath("~/PolicyCertificate/");
            doc.Save(path + "Policy No-" + PolicyNo + ".pdf");

            doc.Close();
            doc1.Close();

            string attachment = path + "Policy No-" + PolicyNo + ".pdf";
            //sendsms(txtContactNumber.Text, PolicyNo, txtFirstname.Text);
            //sendmail_User(PolicyNo, attachment, allachment1);
            sendsms(Session["MobNo"].ToString(), PolicyNo, Session["Name"].ToString());
            sendmail_User(PolicyNo, attachment, allachment1);
            IssueBajajPolicy(PolicyNo);
            Response.Redirect("~/Admin/BuyPolicy.aspx?Success=true");

            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "MsgSuccess();", true);
            Clear();
            GV_PlanName.Visible = false;
        }
    }

    #region send SMS
    public void sendsms(string mobileno, string PolicyNo, string name)
    {
        try
        {
            string promocontent = string.Empty;
            string Policy = BusinessLogic.QueryStringEncode(PolicyNo);
            string xmlstring = string.Empty;
            string url = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
            url = url + "Customer_VAS.aspx?PolicyNumber=" + Policy;
            string VASUrl = "In order to activate your Value added services, please click on the below link " + url;


            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_CheckVAS", new object[] { "Check", PolicyNo });
            if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["VAS"].ToString() != "")
            {
                if (ds.Tables[0].Rows[0]["VAS"].ToString().ToUpper().Contains("TAXI ASSISTANCE"))
                {
                    DataSet dsQR = con.ExecuteReader("Allianz_Travel", "USP_GetQRPromocode", new object[] { "GetPromo", PolicyNo, "" });
                    if (dsQR.Tables[0].Rows.Count > 0)
                    {
                        string promocode = dsQR.Tables[0].Rows[0]["PromoCode"].ToString();
                        promocontent = "To book a Taxi, apply the promo(discount) code " + promocode;
                        DataSet dsupdtqr = con.ExecuteReader("Allianz_Travel", "USP_GetQRPromocode", new object[] { "UpdatePromo", PolicyNo, promocode });
                    }
                    else
                    {
                        promocontent = "";
                    }

                }
                xmlstring = "<?xml version=\"1.0\"?><a2wml version=\"2.0\"><request ACODE=\"AGASERVICES\" accId=\"516680\" pin=\"ags@1\"><fromAddress>AZTRVL</fromAddress><recipientList><destAddress>" + mobileno + "</destAddress></recipientList><message><messageType></messageType><port></port><udh></udh><messageTxt>Hi " + name + ", your travel policy has been issued. Your policy number is " + PolicyNo + ". " + VASUrl + "  </messageTxt ><odRequestId ></odRequestId><custref></custref><billref ></billref><splitAlgm></splitAlgm><scheduleTime></scheduleTime><expiryMinutes></expiryMinutes><dlrtype></dlrtype ><priority></priority></message></request></a2wml>";
            }
            else
            {
                xmlstring = "<?xml version=\"1.0\"?><a2wml version=\"2.0\"><request ACODE=\"AGASERVICES\" accId=\"516680\" pin=\"ags@1\"><fromAddress>AZTRVL</fromAddress><recipientList><destAddress>" + mobileno + "</destAddress></recipientList><message><messageType></messageType><port></port><udh></udh><messageTxt>Hi " + name + ", your travel policy has been issued. Your policy number is " + PolicyNo + ".  </messageTxt ><odRequestId ></odRequestId><custref></custref><billref ></billref><splitAlgm></splitAlgm><scheduleTime></scheduleTime><expiryMinutes></expiryMinutes><dlrtype></dlrtype ><priority></priority></message></request></a2wml>";
            }

            byte[] bytes = null;
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://luna.a2wi.co.in:7501/failsafe/HttpData_SS");
            //WebProxy myProxy = new WebProxy();
            //Uri newUri = new Uri("http://10.125.128.35:8080/");
            //Uri newUri = new Uri("http://172.30.251.13:8080");
            //myProxy.Address = newUri;
            ////myProxy.Credentials = new NetworkCredential("sandhyas", "Allianz@123");
            //request.Proxy = myProxy;
            bytes = System.Text.Encoding.ASCII.GetBytes(xmlstring);
            request.ContentType = "text/xml; charset='utf-8'";
            request.Accept = "text/xml";
            request.ContentLength = bytes.Length;
            request.Method = "POST";
            Stream requestStream = request.GetRequestStream();
            requestStream.Write(bytes, 0, bytes.Length);
            requestStream.Close();
            HttpWebResponse response;
            response = (HttpWebResponse)request.GetResponse();
            if (response.StatusCode == HttpStatusCode.OK)
            {
                Stream responseStream = response.GetResponseStream();
                string responseStr = new StreamReader(responseStream).ReadToEnd();
                //return responseStr;
            }
        }
        catch (Exception exsms) { }
    }
    #endregion
    protected void Clear()
    {
        ddlPlanlist.SelectedIndex = 0;
        //ddlProductname.SelectedIndex = 0;
        txtTravelStartDate.Text = "";
        txtTravelEndDate.Text = "";
        txtDOB.Text = "";
        ddlGeographyAskcountry.SelectedIndex = 0;
        // txtPrice.Text = "";
        txtFirstname.Text = "";
        txtMiddlename.Text = "";
        txtLastname.Text = "";
        txtContactNumber.Text = "";
        txtEmail.Text = "";
        txtNomineename.Text = "";
        txtNomineeAddres.Text = "";
        ddlState.SelectedIndex = 0;
        ddlCity.SelectedIndex = 0;
        txtPinCode.Text = "";
        txtAadhaar.Text = "";
        txtPanNo.Text = "";


    }
    protected void txtDOB_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Bind_WalletBalance();

            DateTime dt = DateTime.Now;
            string dateAsString = dt.ToString("dd/MM/yyyy");
            string dtString = txtDOB.Text;

            DateTime dtTarget;
            if (DateTime.TryParseExact(dtString, "dd/MM/yyyy", System.Globalization.CultureInfo.CurrentCulture, System.Globalization.DateTimeStyles.None, out dtTarget))
            {
                dtString = dtTarget.ToString("MM/dd/yyyy");

            }
            DateTime dob = Convert.ToDateTime(dtString);
            DateTime now = DateTime.Now;
            TimeSpan ts = now - dob;
            int Age = ts.Days / 365;


            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetPlan", new object[] { "Travel_Duration", Age });
            if (ds.Tables[0].Rows.Count > 0)
            {

                //ddlProductname.DataSource = ds;
                //ddlProductname.DataTextField = "name";
                //ddlProductname.DataValueField = "id";
                //ddlProductname.DataBind();

            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "messageshow();", true);
            }

        }
        catch (Exception ex)
        { }

    }

    #region Send Mail
    private void sendmail_User(string policy_No, string attachment, string attachment1)
    {
        try
        {
            string attachment3 = string.Empty;
            StringBuilder sb = new StringBuilder();
            StringBuilder sblogo = new StringBuilder();
            string myTemplate = "", strSubject = "", strTo = "";
            string PartnerEmailID = string.Empty;
            //if (txtEmail.Text.ToString() != "")
            //{ strTo = txtEmail.Text.ToString(); }
            //if (txtCompEmailID.Text.ToString() != "")
            //{ strTo = txtCompEmailID.Text.ToString(); }

            if (Session["CustomerEmailId"].ToString() != "")
            { strTo = Session["CustomerEmailId"].ToString(); }
            if (Session["CompanyEmail"].ToString() != "")
            { strTo = Session["CompanyEmail"].ToString(); }

            //string strFrom = ConfigurationManager.AppSettings["frommail"].ToString();
            string strFrom = Session["FromMail"].ToString();
            DataSet dtvar = con.ExecuteReader("Allianz_Travel", "Get_Email", new object[] { "BuyPolicy", 0, 0, "", "", policy_No, "", "" });
            string Policy = BusinessLogic.QueryStringEncode(policy_No);
            string url = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
            url = url + "Customer_VAS.aspx?PolicyNumber=" + Policy;
            string VASUrl = "Activate Value added services opted by you <a href=" + url + " target='_blank'>Click here</a>";
            string MatrixUrl = "<a href=" + url + " target='_blank'>Click here</a>";
            StringBuilder stb = new StringBuilder();

            if (dtvar.Tables[0].Rows.Count > 0)
            {
                strSubject = dtvar.Tables[0].Rows[0]["Subject"].ToString() + policy_No;
                stb.Append(dtvar.Tables[0].Rows[0]["Body"].ToString());
            }
            stb.Replace("[Name]", Session["Name"].ToString());
            stb.Replace("[PolicyNo]", policy_No);
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_CheckVAS", new object[] { "Check", policy_No });
            if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["MatrixPath"].ToString() != "")
            {
                stb.Replace("[URL]", MatrixUrl);
            }
            else if (ds.Tables[0].Rows[0]["MatrixPath"].ToString() == "" && ds.Tables[0].Rows[0]["VAS"].ToString() != "")
            {
                stb.Replace("[URL]", VASUrl);
            }
            if (ds.Tables[0].Rows[0]["VAS"].ToString().ToUpper().Contains("LUGGAGE TRACKER"))
            {
                DataSet dsQR = con.ExecuteReader("Allianz_Travel", "USP_GetQRPromocode", new object[] { "GetQR", policy_No, "" });
                if (dsQR.Tables[0].Rows.Count > 0)
                {
                    string QRPath = Server.MapPath("~/QRCodeFile/");
                    attachment3 = QRPath + dsQR.Tables[0].Rows[0]["FilePath"].ToString();
                    DataSet dsupdtqr = con.ExecuteReader("Allianz_Travel", "USP_GetQRPromocode", new object[] { "UpdateQR", policy_No, dsQR.Tables[0].Rows[0]["QR_Code"].ToString() });
                }
                else
                {
                    attachment3 = "";
                }
            }
            DataSet ds1 = con.ExecuteReader("Allianz_Travel", "USP_GetTitleOfName", new object[] { "Get", policy_No });
            if (ds1.Tables[0].Rows.Count > 0)
            {
                stb.Replace("[Title]", ds1.Tables[0].Rows[0]["Title"].ToString());
            }
            if (ds1.Tables[1].Rows.Count > 0)
            {
                PartnerEmailID = ds1.Tables[1].Rows[0]["PartnerEmail"].ToString();
            }
            string CC = PartnerEmailID + ",travel@allianz.com";
            string Link = ConfigurationManager.AppSettings["virtualpath"].ToString() + "Login.aspx";
            bl.sendmailattach(strSubject, stb.ToString(), attachment, attachment1, attachment3, strFrom, strTo, CC, "");

        }
        catch (Exception ex)
        {

        }
    }
    #endregion

    protected void btnPolicyDownload_ServerClick(object sender, EventArgs e)
    {
        string url = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
        DataSet dsMxt = con.ExecuteReader("Allianz_Travel", "USP_CheckVAS", new object[] { "Check", PolicyNo.InnerHtml });
        if (dsMxt.Tables[0].Rows.Count > 0)
        {
            if (dsMxt.Tables[0].Rows[0]["MatrixPath"].ToString() == "Matrix")
            {
                string Type = dsMxt.Tables[0].Rows[0]["type"].ToString();
                url = url + "Download_MatrixPolicy.aspx?Policy_No=" + PolicyNo.InnerHtml + "&Type=" + Type;
            }
            else
            {
                url = url + "PolicyDownload.aspx?Policy_No=" + PolicyNo.InnerHtml;
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

        HtmlToPdf converter = new HtmlToPdf();
        converter.Options.DisplayFooter = showFooterOnFirstPage || showFooterOnOddPages || showFooterOnEvenPages;
        converter.Footer.DisplayOnFirstPage = showFooterOnFirstPage;
        converter.Footer.DisplayOnOddPages = showFooterOnOddPages;
        converter.Footer.DisplayOnEvenPages = showFooterOnEvenPages;
        converter.Footer.Height = footerHeight;

        PdfHtmlSection footerHtml = new PdfHtmlSection(FooterUrl);
        footerHtml.AutoFitHeight = HtmlToPdfPageFitMode.AutoFit;
        converter.Footer.Add(footerHtml);
        //create a new pdf document converting an url
        SelectPdf.PdfDocument doc = converter.ConvertUrl(url);
        //save pdf document
        doc.Save(Response, false, "Policy No-" + PolicyNo.InnerHtml + ".pdf");
        //close pdf document
        doc.Close();

    }

    protected void btnGetprice_Click(object sender, EventArgs e)
    {
        try
        {

            Bind_WalletBalance();
            GridViewPlanDetails.Visible = true;
            DateTime dt1 = DateTime.ParseExact(txtTravelStartDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime dt2 = DateTime.ParseExact(txtTravelEndDate.Text, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            int days = (dt2 - dt1).Days + 1;


            if (Request.Form["radioFoo1"] != null)
            {
                TravelType = Request.Form["radioFoo1"].ToString();
                HiddenTravelType.Value = Request.Form["radioFoo1"].ToString();
            }

            DateTime dt = DateTime.Now;
            string dateAsString = dt.ToString("dd/MM/yyyy");
            string dtString = txtDOB.Text;

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

            if (TravelType == "International")
            {
                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetPlanAndPrice", new object[] { "Travel_Duration", TravelType, ddlGeographyAskcountry.SelectedItem.Text, Age, days, ChildAge });
                if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Price"].ToString() != "" && ds.Tables[0].Rows[0]["Price"].ToString() != "0.00")
                {
                    DataTable dtRow = ds.Tables[0];
                    foreach (DataRow dr in dtRow.Rows)
                    {
                        if (dr["Price"].ToString() == "0.00")
                            dr.Delete();
                    }
                    GV_PlanName.Visible = true;
                    // GV_PlanName.DataSource = ds;
                    GV_PlanName.DataSource = dtRow;
                    GV_PlanName.DataBind();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "messageshow();", true);
                }
            }
            else if (TravelType == "Domestic")
            {
                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetDomesticPlan", new object[] { "Travel_Duration", TravelType, "", "India", Age, days, ChildAge });
                if (ds.Tables[0].Rows.Count > 0 && ds.Tables[0].Rows[0]["Price"].ToString() != "")
                {
                    DataTable dtRow = ds.Tables[0];
                    foreach (DataRow dr in dtRow.Rows)
                    {
                        if (dr["Price"].ToString() == "0.00")
                            dr.Delete();
                    }
                    GV_PlanName.Visible = true;
                    GV_PlanName.DataSource = dtRow;
                    GV_PlanName.DataBind();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "messageshow();", true);
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

    protected void GV_PlanName_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "View")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            HiddenField PlanCode = (((e.CommandSource as LinkButton).Parent.FindControl("lblPlanCode")) as HiddenField);
            //string PlanCode = (GV_PlanName.Rows[rowIndex].FindControl("lblPlanCode") as Label).Text;
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetBenifits", new object[] { PlanCode.Value });
            if (ds.Tables[0].Rows.Count > 0)
            {
                BD.Visible = true;
                GV_Benifits.DataSource = ds.Tables[0];
                GV_Benifits.DataBind();
            }
            else
            {
                BD.Visible = false;
            }
            if (ds.Tables[1].Rows.Count > 0)
            {
                VAS.Visible = true;
                GV_vas.DataSource = ds.Tables[1];
                GV_vas.DataBind();
            }
            else
            {
                VAS.Visible = false;
            }
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ViewBenifits();", true);
        }
        //if (e.CommandName == "Price")
        //{
        //    CompanyDetails.Visible = false;
        //    GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
        //    int rowIndex = gvr.RowIndex;
        //    string PlanCode = (GV_PlanName.Rows[rowIndex].FindControl("lblPlanCode") as Label).Text;
        //    string Price = (GV_PlanName.Rows[rowIndex].FindControl("lblprice") as Label).Text;
        //    DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetDuratinBasis", new object[] { PlanCode });
        //    if(ds.Tables[0].Rows[0]["Duration_Basis"].ToString()== "MICE")
        //    {
        //        CompanyDetails.Visible = true;
        //    }
        //    StringBuilder sb = new StringBuilder();
        //    sb.Append("<script type = 'text/javascript'>");
        //    sb.Append("$('#tabs a[href='#Customer-Information']').tab('show');");
        //    sb.Append("$('#PD').removeClass('active');");
        //    sb.Append("$('#CI').addClass('active');");
        //    sb.Append("</script>");
        //    ClientScript.RegisterStartupScript(this.GetType(), "script", sb.ToString());

        //}
    }

    protected void ddlCompState_SelectedIndexChanged(object sender, EventArgs e)
    {
        int StateID = Convert.ToInt32(ddlCompState.SelectedValue);
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "Get_City", StateID });
        ddlCompCity.DataSource = ds;
        ddlCompCity.DataTextField = "name";
        ddlCompCity.DataValueField = "id_city";
        ddlCompCity.DataBind();
    }

    protected void Bind_Title()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_TitleSurname", new object[] { "Get_Title", "" });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlsurname.DataSource = ds;
                ddlsurname.DataTextField = "surname";
                ddlsurname.DataValueField = "Id";
                ddlsurname.DataBind();

                ddlCompanySurname.DataSource = ds;
                ddlCompanySurname.DataTextField = "surname";
                ddlCompanySurname.DataValueField = "Id";
                ddlCompanySurname.DataBind();

            }
        }
        catch (Exception ex)
        {
        }
    }

    protected bool IssueBajajPolicy(string policy_no)
    {
        bool success = false;
        try
        {
            //BajajJsonResponse resp = null;
            //BajajJsonRequest jsonreq = null;
            //API Code
            if (!Directory.Exists(Server.MapPath("~/BajajAPI/")))
            {
                Directory.CreateDirectory(Server.MapPath("~/BajajAPI/"));
            }
            string AckPath = Path.Combine(Server.MapPath("~/BajajAPI/"), "RT_PolicyIssueAck_" + DateTime.Now.ToString("ddMMyyyy") + ".txt");
            if (!File.Exists(AckPath))
            {
                string str1 = "PolicyNo\t" + "ErrorNo\t" + "Message";
                File.AppendAllText(AckPath, str1);
            }
            BajajJsonRequest jsonreq = GetJsonRequest(policy_no);
            if (jsonreq != null)
            {
                BajajJsonResponse resp = MakeRequest("http://webservicesdev.bajajallianz.com/BjazTravelWebServices/issuepolicy", jsonreq, "POST");
                if (resp.errorcode == 0)
                {
                    string policyno = resp.bjaztravelissue.policyno;
                    using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_UpdateOGPolicyNo", new object[] { policy_no, policyno, 1 }))
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            string str1 = "\r\n" + policy_no + "\t" + "0\t" + "Policy issued with OG No. " + policyno;
                            File.AppendAllText(AckPath, str1);
                        }
                    }
                    success = true;
                }
                else
                {
                    success = false;
                    List<errorlist> lst = resp.errorlist;
                    foreach (var errmsg in lst)
                    {
                        string str1 = "\r\n" + policy_no + "\t" + resp.errorcode.ToString() + "\t" + errmsg.errtext.ToString();
                        File.AppendAllText(AckPath, str1);
                    }
                }
            }
        }
        catch (WebException ex)
        {
            success = false;
        }
        catch (Exception ex)
        {

            success = false;
        }
        return success;
    }
    public BajajJsonRequest GetJsonRequest(string policy_no)
    {
        //bj = new BajajJsonRequest();
        //lst = new List<familyparamlist>();
        //trv = new bjaztravelissue();
        //fd = new familyparamlist();

        DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_GetBajajPolicyDetails", new object[] { "GetPolicyData", policy_no });
        if (dt.Rows.Count > 0)
        {
            try
            {

                bj.userid = "travel@allianz.com";
                bj.password = "newpas12";

                trv.pruralflag = "N";
                trv.plocationcode = "";
                trv.ppartnerid = "";
                trv.pdateofbirth = dt.Rows[0]["DOB"].ToString();
                trv.pintermediarycode = "10031022";//For Allianz, imdcode
                trv.psubagentcode = "";//PSubimdcode
                trv.pcovernoteno = "";
                trv.pfulltermpremium = "";
                trv.ptermstartdate = dt.Rows[0]["Travel_Start_Date"].ToString();
                trv.ptermenddate = dt.Rows[0]["Travel_End_Date"].ToString();
                trv.pcoorgunit = "";
                trv.pservicecharge = "";
                trv.pspdiscountamt = "";
                trv.pspdiscount = "";
                trv.pservicetaxamt = "";
                trv.ptotalpremium = "";
                trv.pproduct = "9910";//Product code for Bajaj
                trv.pdestination = "";
                trv.pspcondition = "";
                trv.ppassportno = dt.Rows[0]["PassportNo"].ToString();
                trv.passigneename = dt.Rows[0]["Nominee_Name"].ToString();
                trv.pusername = "travel@allianz.com";
                trv.pdealercode = "";
                trv.ppremiumpayerflag = "";
                trv.ppremiumpayerid = "";
                trv.ppaymentmode = "Agent Float";
                trv.pfamilyflag = "N";
                trv.ptravelplan = dt.Rows[0]["Plan_Name"].ToString();
                trv.pareaplan = dt.Rows[0]["geo_name"].ToString();
                trv.pfromdate = dt.Rows[0]["Travel_Start_Date"].ToString();
                trv.ploading = "";
                trv.pdiscount = "";
                trv.ptodate = dt.Rows[0]["Travel_End_Date"].ToString();
                trv.partid = "";
                trv.userid = "travel@allianz.com";
                trv.partnertype = "";
                trv.partnerref = "";
                trv.language = "";
                trv.addid = "";
                trv.regnumber = "";
                trv.maritalstatus = "";
                trv.aftertitle = dt.Rows[0]["Title"].ToString();
                trv.beforetitle = dt.Rows[0]["Title"].ToString();
                trv.contact1 = dt.Rows[0]["Contact_No"].ToString();
                trv.dateofbirth = dt.Rows[0]["DOB"].ToString();
                trv.employmentstatus = "";
                trv.notes = "";
                trv.nationalid = "";
                trv.sex = dt.Rows[0]["Gender"].ToString();
                trv.telephone = "";
                trv.telephone2 = "";
                trv.email = dt.Rows[0]["Email"].ToString();
                trv.fax = "";
                trv.quality = "";
                trv.taxid = "";
                trv.vatnumber = "";
                trv.firstname = dt.Rows[0]["First_Name"].ToString();
                trv.surname = dt.Rows[0]["Last_Name"].ToString();
                trv.institutionname = "";
                trv.middlename = dt.Rows[0]["Middle_Name"].ToString();
                trv.telephone3 = "";
                trv.postcode = "";
                trv.countrycode = "";
                trv.addressline1 = dt.Rows[0]["Nominee_Address"].ToString();
                trv.addressline2 = "";
                trv.addressline3 = dt.Rows[0]["City"].ToString();
                trv.addressline4 = dt.Rows[0]["Nominee_PIN"].ToString();
                trv.addressline5 = dt.Rows[0]["State"].ToString();
                trv.checkbox = "";
                trv.policyno = "";
                trv.pmasterpolicyno = "";
                trv.pcompref = "";
                trv.pempno = "";
                bj.bjaztravelissue = trv;
                fd.pvname = "pvname";
                fd.pvage = "";
                fd.pvrelation = "Parent";
                fd.pvsex = "Male";
                fd.pvpartnerid = "";
                fd.pvdob = "01-Jan-1960";
                fd.pvpassportno = "";
                fd.pvassignee = "pvassignee";
                lst.Add(fd);
                bj.familyparamlist = lst;
            }
            catch (Exception ex)
            {
                bj = null;
            }
        }
        else
        {
            bj = null;
        }
        return bj;
    }
    public static BajajJsonResponse MakeRequest(string requestUrl, BajajJsonRequest JSONRequest, string JSONmethod)
    {

        try
        {
            HttpWebRequest request = WebRequest.Create(requestUrl) as HttpWebRequest;
            //WebRequest WR = WebRequest.Create(requestUrl);   
            string sb = JsonConvert.SerializeObject(JSONRequest);
            request.Method = JSONmethod;
            // "POST";
            request.ContentType = "application/json";
            Byte[] bt = Encoding.UTF8.GetBytes(sb);
            Stream st = request.GetRequestStream();
            st.Write(bt, 0, bt.Length);
            st.Close();

            using (HttpWebResponse response = request.GetResponse() as HttpWebResponse)
            {
                if (response.StatusCode != HttpStatusCode.OK) throw new Exception(String.Format(
                    "Server error (HTTP {0}: {1}).", response.StatusCode,
                response.StatusDescription));

                //DataContractJsonSerializer jsonSerializer = new DataContractJsonSerializer(typeof(Response));
                //object objResponse = JsonConvert.DeserializeObject();
                Stream stream1 = response.GetResponseStream();
                StreamReader sr = new StreamReader(stream1);
                string strsb = sr.ReadToEnd();
                BajajJsonResponse objResponse = JsonConvert.DeserializeObject<BajajJsonResponse>(strsb);

                return objResponse;
            }
        }
        catch (Exception e)
        {
            //Console.WriteLine(e.Message);
            return null;
        }
    }


}