﻿using SelectPdf;
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


public partial class Admin_PolicyExtendReq : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    DataSet ds = new DataSet();
    BusinessLogic bl = new BusinessLogic();
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
                bool Authenticate = bl.CheckAuthority("PolicyExtendReq.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                BindPolicyExtendReq();

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

    public void BindPolicyExtendReq()
    {
        ds = con.ExecuteReader("Allianz_Travel", "USP_ExtendRequest", new object[] { "View", "", 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            GV_PolicyExtendReq.DataSource = ds;
            GV_PolicyExtendReq.DataBind();
        }
        else
        {
            GV_PolicyExtendReq.DataSource = ds;
            GV_PolicyExtendReq.DataBind();
        }
    }

    protected void GV_PolicyExtendReq_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "View")
            {
                CompInfo.Visible = false;
                CustInfo.Visible = false;
                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                Label lblPolicyNo = (Label)row.FindControl("lblPolicyNo");
                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ExtendRequest", new object[] { "ExtendDetails", lblPolicyNo.Text.ToString(), 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    PartnerId.Value = ds.Tables[0].Rows[0]["Extendby"].ToString();
                    lblPolicy_No.Text = ds.Tables[0].Rows[0]["Policy_No"].ToString();
                    lblGeoName.Text = ds.Tables[0].Rows[0]["Geography_Name"].ToString();
                    lblPlanName.Text = ds.Tables[0].Rows[0]["Plan_Name"].ToString();
                    lblDOB.Text = ds.Tables[0].Rows[0]["DOB"].ToString();
                    lblIssuedon.Text = ds.Tables[0].Rows[0]["IssuedOn"].ToString();
                    lblExPolicyStartdate.Text = ds.Tables[0].Rows[0]["PolicyStartDate"].ToString();
                    lblExPolicyEnddate.Text = ds.Tables[0].Rows[0]["PolicyEnddate"].ToString();
                    lblExTotalPrice.Text = ds.Tables[0].Rows[0]["TotalPrice"].ToString();
                    lblExtendSdate.Text = ds.Tables[0].Rows[0]["PolicyExtendStartDate"].ToString();
                    lblExtendEdate.Text = ds.Tables[0].Rows[0]["PolicyExtenddate"].ToString();
                    lblExtendTotalPremium.Text = ds.Tables[0].Rows[0]["ExtendPrice"].ToString();
                    if (ds.Tables[0].Rows[0]["Fname"].ToString() != "")
                    {
                        CustInfo.Visible = true;
                        txtname.Text = ds.Tables[0].Rows[0]["CustName"].ToString();
                        txtContactNumber.Text = ds.Tables[0].Rows[0]["Contact_No"].ToString();
                        txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                        txtNomineename.Text = ds.Tables[0].Rows[0]["Nominee_Name"].ToString();
                        txtAadhaar.Text = ds.Tables[0].Rows[0]["Nominee_Aadhar"].ToString();
                        txtPanNo.Text = ds.Tables[0].Rows[0]["Nominee_PAN"].ToString();
                        lblCustAddr.Text = ds.Tables[0].Rows[0]["Nominee_Address"].ToString();
                        txtNomineeRelation.Text = ds.Tables[0].Rows[0]["NomineeRelation"].ToString();
                        txtPassportNo.Text = ds.Tables[0].Rows[0]["PassportNo"].ToString();

                    }
                    if (ds.Tables[0].Rows[0]["CompanyName"].ToString() != "")
                    {
                        CompInfo.Visible = true;
                        txtCOmpName.Text = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                        txtCompEmail.Text = ds.Tables[0].Rows[0]["Company_EmailId"].ToString();
                        txtCompGSTIN.Text = ds.Tables[0].Rows[0]["Company_GSTIN"].ToString();
                        txtCompAddr.Text = ds.Tables[0].Rows[0]["ComapnyAddress"].ToString();
                        txtCompNomiName.Text = ds.Tables[0].Rows[0]["Nominee_Name"].ToString();
                        txtCompNomineeRelation.Text = ds.Tables[0].Rows[0]["NomineeRelation"].ToString();
                    }
                    DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_WalletStmt", new object[] { "Wallet_Balance", PartnerId.Value, "" });
                    lblWalletBlnce.Text = dt.Rows[0]["Balance"].ToString();
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
            ds = con.ExecuteReader("Allianz_Travel", "USP_ExtendInsert", new object[] { "DisApprove", lblPolicy_No.Text, "", "", "", "", "", 0, Session["UserId"], "", "", "",txtRemark.Text.Trim() });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "DisApprove();", true);
                BindPolicyExtendReq();
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
            DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_WalletStmt", new object[] { "Wallet_Balance", PartnerId.Value, "" });
            WalletBalance = Convert.ToDecimal(dt.Rows[0]["Balance"].ToString());
            if (WalletBalance >= Convert.ToDecimal(lblExtendTotalPremium.Text))
            {
                ds = con.ExecuteReader("Allianz_Travel", "USP_ExtendInsert", new object[] { "Approve", lblPolicy_No.Text, "", "", "", "", "", 0, Session["UserId"], "", "", "","" });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    DataSet ds2 = con.ExecuteReader("Allianz_Travel", "USP_GeDocumentName", new object[] { "GetDoc", lblPolicy_No.Text });
                    if (ds2.Tables[0].Rows.Count > 0)
                    {
                        string Email = string.Empty, Name = string.Empty;
                        if (txtEmail.Text.ToString() != "")
                        {
                            Email = txtEmail.Text.ToString();
                        }
                        else
                        {
                            Email = txtCompEmail.Text.ToString();
                        }
                        if (txtname.Text.ToString() != "")
                        {
                            Name = txtname.Text.ToString();
                        }
                        else
                        {
                            Name = txtCOmpName.Text.ToString();
                        }
                        string url = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
                        DataSet dsMxt = con.ExecuteReader("Allianz_Travel", "USP_CheckVAS", new object[] { "Check", lblPolicy_No.Text });
                        if (dsMxt.Tables[0].Rows.Count > 0)
                        {
                            if (dsMxt.Tables[0].Rows[0]["MatrixPath"].ToString() == "Matrix")
                            {
                                string Type = dsMxt.Tables[0].Rows[0]["type"].ToString();
                                url = url + "Download_MatrixPolicy.aspx?Policy_No=" + lblPolicy_No.Text + "&Type=" + Type;
                            }
                            else
                            {
                                url = url + "PolicyDownload.aspx?Policy_No=" + lblPolicy_No.Text;
                            }
                        }

                        //  url = url + "PolicyDownload.aspx?Policy_No=" + lblPolicy_No.Text;

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
                        doc.Save(Path + "Policy No-" + lblPolicy_No.Text + ".pdf");

                        doc.Close();

                        string attachment = Path + "Policy No-" + lblPolicy_No.Text + ".pdf";
                        sendmail_User(lblPolicy_No.Text, attachment, allachment1, Email, Name);
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Approve();", true);
                        BindPolicyExtendReq();
                        ((Admin_AdminMaster)this.Master).Notification();
                    }

                }
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Walletbalance();", true);
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
    private void sendmail_User(string policy_No, string attachment, string attachment1, string EmailId, string Name)
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sblogo = new StringBuilder();
            string myTemplate = "", strSubject = "", strTo = "";
            strTo = EmailId;

            string strFrom = ConfigurationManager.AppSettings["frommail"].ToString();
            DataSet dtvar = con.ExecuteReader("Allianz_Travel", "Get_Email", new object[] { "ExtendPolicy", 0, 0, "", "", "", "", "" });

            StringBuilder stb = new StringBuilder();

            if (dtvar.Tables[0].Rows.Count > 0)
            {
                strSubject = dtvar.Tables[0].Rows[0]["Subject"].ToString();
                stb.Append(dtvar.Tables[0].Rows[0]["Body"].ToString());
            }
            stb.Replace("[Name]", Name);
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