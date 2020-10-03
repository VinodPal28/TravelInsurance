using SelectPdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_PolicyModificationReq : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    DataSet ds = new DataSet();
    BusinessLogic bl = new BusinessLogic();
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
                bool Authenticate = bl.CheckAuthority("PolicyModificationReq.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                BindPolicyEndorseReq();

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

   
    public void BindPolicyEndorseReq()
    {
        ds = con.ExecuteReader("Allianz_Travel", "USP_PolicyEndorsementReq", new object[] { });
        if (ds.Tables[0].Rows.Count > 0)
        {
            GV_PolicyModReq.DataSource = ds;
            GV_PolicyModReq.DataBind();
        }
        else
        {
            GV_PolicyModReq.DataSource = ds;
            GV_PolicyModReq.DataBind();
        }
    }

    protected void GV_PolicyModReq_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "View")
            {
                CompInfo.Visible = false;
                CustInfo.Visible = false;
                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                Label lblPolicyNo = (Label)row.FindControl("lblPolicyNo");
                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_EnodrseDetails", new object[] { "Plan_Modifiy", 0, lblPolicyNo.Text.ToString() });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtPolicyNo.Text = ds.Tables[0].Rows[0]["Policy_No"].ToString();
                    txtPolicyEndorsementNo.Text = ds.Tables[0].Rows[0]["Endorsement_No"].ToString();
                    txtPolicyEndorseNumber.Text = ds.Tables[0].Rows[0]["Policy_No"].ToString();
                    txtIssuesDate.Text = ds.Tables[0].Rows[0]["Policy_IssuanceDate"].ToString();
                    txtPolicyStartdate.Text = ds.Tables[0].Rows[0]["Travel_Start_Date"].ToString();
                    txtPolicyEnddate.Text = ds.Tables[0].Rows[0]["Travel_End_Date"].ToString();
                    txtDOB.Text = ds.Tables[0].Rows[0]["DOB"].ToString();
                    txtTotalPrice.Text = ds.Tables[0].Rows[0]["Price"].ToString();
                    txtEndorseDOB.Text = ds.Tables[0].Rows[0]["EndorseDOB"].ToString();
                    txtEndorseSdate.Text= ds.Tables[0].Rows[0]["EndorsePolicySDate"].ToString();
                    txtEndorsEdate.Text = ds.Tables[0].Rows[0]["EndorsePolicyEDate"].ToString();
                    if (ds.Tables[0].Rows[0]["Fname"].ToString() != "" )
                    {
                        CustInfo.Visible = true;
                        txtTitle.Text= ds.Tables[0].Rows[0]["Title"].ToString();
                        txtname.Text = ds.Tables[0].Rows[0]["CustName"].ToString();
                        txtContactNumber.Text = ds.Tables[0].Rows[0]["Contact_No"].ToString();
                        txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                        txtNomineename.Text = ds.Tables[0].Rows[0]["Nominee_Name"].ToString();
                       // txtState.Text = ds.Tables[0].Rows[0]["Nominee_State"].ToString();
                       // txtCity.Text = ds.Tables[0].Rows[0]["Nominee_City"].ToString();
                        //txtPinCode.Text = ds.Tables[0].Rows[0]["Nominee_PIN"].ToString();
                        txtAadhaar.Text = ds.Tables[0].Rows[0]["Nominee_Aadhar"].ToString();
                        txtPanNo.Text = ds.Tables[0].Rows[0]["Nominee_PAN"].ToString();
                        txtNomineeAddres.Text = ds.Tables[0].Rows[0]["Nominee_Address"].ToString();
                        txtNomineeRelation.Text = ds.Tables[0].Rows[0]["NomineeRelation"].ToString();
                        txtPassportNo.Text = ds.Tables[0].Rows[0]["PassportNo"].ToString();

                        txtEndorseTitle.Text = ds.Tables[0].Rows[0]["EndorseTitle"].ToString();
                        txtEndorseName.Text = ds.Tables[0].Rows[0]["Endorse_CustName"].ToString();
                        txtEndorseMobNo.Text = ds.Tables[0].Rows[0]["Endorse_MobNo"].ToString();
                        txtEndorseEmail.Text = ds.Tables[0].Rows[0]["Endorse_email"].ToString();
                        txtEndorseNomiName.Text = ds.Tables[0].Rows[0]["endorse_NomineeName"].ToString();
                        //txtEndorseNomiState.Text = ds.Tables[0].Rows[0]["Endorse_state"].ToString();
                        //txtEndorseNomiCity.Text = ds.Tables[0].Rows[0]["Endorse_City"].ToString();

                        //txtEndorseNomiPin.Text = ds.Tables[0].Rows[0]["endorse_PIN"].ToString();
                        txtEndorseNomiPAN.Text = ds.Tables[0].Rows[0]["Endorse_PAN"].ToString();
                        txtEndorseNomiAdhar.Text = ds.Tables[0].Rows[0]["Endorse_Aadhar"].ToString();
                        txtEndorseNomiAddr.Text = ds.Tables[0].Rows[0]["Endorse_Addr"].ToString();
                        txtEndorseNomineeRelation.Text = ds.Tables[0].Rows[0]["Endorse_NomineeRelation"].ToString();
                        txtEndorsePassportNo.Text= ds.Tables[0].Rows[0]["EndorsePassportNo"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["CompanyName"].ToString() != "")
                    {
                        CompInfo.Visible = true;
                        txtCOmpName.Text = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                        txtCompEmail.Text = ds.Tables[0].Rows[0]["Company_EmailId"].ToString();
                        txtCompGSTIN.Text = ds.Tables[0].Rows[0]["Company_GSTIN"].ToString();
                        txtCompAddr.Text = ds.Tables[0].Rows[0]["ComapnyAddress"].ToString();
                        txtCompNomiName.Text= ds.Tables[0].Rows[0]["Nominee_Name"].ToString();
                        txtCompNomineeRelation.Text = ds.Tables[0].Rows[0]["NomineeRelation"].ToString();
                        
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


                        txtCompEndorseName.Text = ds.Tables[0].Rows[0]["Endorse_CompName"].ToString();
                        txtCompEndorseEmail.Text = ds.Tables[0].Rows[0]["Endorse_CompEmail"].ToString();
                        txtCompEndorseGSTIN.Text = ds.Tables[0].Rows[0]["Endorse_CompGSTIN"].ToString();
                        txtCompEndorseAddr.Text = ds.Tables[0].Rows[0]["Endorse_CompAddr"].ToString();
                        txtCompEndorseNomName.Text = ds.Tables[0].Rows[0]["endorse_NomineeName"].ToString();
                        txtCompEndorseNomRelation.Text = ds.Tables[0].Rows[0]["Endorse_NomineeRelation"].ToString();
                        if (ds.Tables[2].Rows.Count > 0)
                        {
                            GV_EndorseMiceDetails.DataSource = ds.Tables[2];
                            GV_EndorseMiceDetails.DataBind();
                        }
                        else
                        {
                            GV_EndorseMiceDetails.DataSource = ds.Tables[2];
                            GV_EndorseMiceDetails.DataBind();
                        }
                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "View();", true);
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
            ds = con.ExecuteReader("Allianz_Travel", "USP_SavePolicyEndorseDetails", new object[] { "Disapprove", txtPolicyNo.Text, "", "", "", "", "", "", "", "", "", "", "", "", "", txtRemark.Text, Session["UserId"] });
            if (ds.Tables[0].Rows.Count > 0)
            {
                BindPolicyEndorseReq();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Disapprove();", true);
                ((Admin_AdminMaster)this.Master).Notification();
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
            ds = con.ExecuteReader("Allianz_Travel", "USP_SavePolicyEndorseDetails", new object[] { "Approve", txtPolicyNo.Text, txtPolicyEndorsementNo.Text, "", "", "", "", "", "", "", "", "", "", "", "", txtRemark.Text, Session["UserId"] });
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataSet ds2 = con.ExecuteReader("Allianz_Travel", "USP_GeDocumentName", new object[] { "GetDoc", txtPolicyNo.Text });
                if (ds2.Tables[0].Rows.Count > 0)
                {
                    string url = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
                    DataSet dsMxt = con.ExecuteReader("Allianz_Travel", "USP_CheckVAS", new object[] { "Check", txtPolicyNo.Text });
                    if (dsMxt.Tables[0].Rows.Count > 0)
                    {
                        if (dsMxt.Tables[0].Rows[0]["MatrixPath"].ToString() == "Matrix")
                        {
                            string Type = dsMxt.Tables[0].Rows[0]["type"].ToString();
                            url = url + "Download_MatrixPolicy.aspx?Policy_No=" + txtPolicyNo.Text + "&Type=" + Type;
                        }
                        else
                        {
                            url = url + "PolicyDownload.aspx?Policy_No=" + txtPolicyNo.Text;
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

                    // url = url + "PolicyDownload.aspx?Policy_No=" + txtPolicyNo.Text;
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
                    string tc = ds2.Tables[0].Rows[0]["Document_Path"].ToString();
                    int idx = ds2.Tables[0].Rows[0]["Document_Path"].ToString().LastIndexOf("_");
                    tc = tc.Substring(0, idx) + ".pdf";

                    if (!File.Exists(Path2 + tc))
                    {
                        doc.Save(Path2 + tc);
                    }
                    string allachment1 = Path2 + tc;
                    string Path = Server.MapPath("~/PolicyCertificate/");
                    doc.Save(Path + "Policy No-" + txtPolicyNo.Text + ".pdf");

                    doc.Close();

                    string attachment = Path + "Policy No-" + txtPolicyNo.Text + ".pdf";
                    sendmail_User(txtPolicyNo.Text, attachment, allachment1);

                }


                BindPolicyEndorseReq();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Approve();", true);
                ((Admin_AdminMaster)this.Master).Notification();
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

    #region Send Mail
    private void sendmail_User(string policy_No, string attachment, string attachment1)
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sblogo = new StringBuilder();
            string myTemplate = "", strSubject = "", strTo = "";
            if (txtEndorseEmail.Text.ToString() != "")
            { strTo = txtEndorseEmail.Text.ToString(); }
            if (txtCompEndorseEmail.Text.ToString() != "")
            { strTo = txtCompEndorseEmail.Text.ToString(); }

            string strFrom = ConfigurationManager.AppSettings["frommail"].ToString();
            DataSet dtvar = con.ExecuteReader("Allianz_Travel", "Get_Email", new object[] { "EndorsePolicy", 0, 0, "", "", "", "", "" });

            StringBuilder stb = new StringBuilder();

            if (dtvar.Tables[0].Rows.Count > 0)
            {
                strSubject = dtvar.Tables[0].Rows[0]["Subject"].ToString();
                stb.Append(dtvar.Tables[0].Rows[0]["Body"].ToString());
            }
            if (txtEndorseName.Text.ToString() != "")
            { stb.Replace("[Name]", txtEndorseName.Text.ToString()); }
            if (txtCompEndorseName.Text.ToString() != "")
            { stb.Replace("[Name]", txtCompEndorseName.Text.ToString()); }

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
}