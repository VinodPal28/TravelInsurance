using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text;

public partial class Admin_PartnerRegRequest : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    DataSet ds = new DataSet();
    string PartnerType = string.Empty;
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
                bool Authenticate = bl.CheckAuthority("PartnerRegRequest.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                Bind();
                Bind_Partner();
                Bind_ProductList();
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

    public void Bind()
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PartnerRegRequest", new object[] { "GetRequest", 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            GV_PartnerRegRequest.DataSource = ds;
            GV_PartnerRegRequest.DataBind();

        }
        else
        {
            GV_PartnerRegRequest.DataSource = ds;
            GV_PartnerRegRequest.DataBind();
        }
    }
    protected void Bind_Partner()
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetPartnerdetails", new object[] { "PartnerName" });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlHeadPartner.DataSource = ds;
            ddlHeadPartner.DataTextField = "Partner_Name";
            ddlHeadPartner.DataValueField = "ID";
            ddlHeadPartner.DataBind();
        }
    }
    protected void Bind_ProductList()
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetPartnerdetails", new object[] { "GetProductName" });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ListProductType.DataSource = ds;
            ListProductType.DataTextField = "Plan_Name";
            ListProductType.DataValueField = "Plan_Id";
            ListProductType.DataBind();
        }
    }

    protected void GV_PartnerRegRequest_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_PartnerRegRequest.PageIndex = e.NewPageIndex;
        Bind();
    }

    protected void GV_PartnerRegRequest_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Approve")
            {
                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                Label lblId = (Label)row.FindControl("lblID");
                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PartnerRegRequest", new object[] { "View", lblId.Text });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    PartnerId.Value = ds.Tables[0].Rows[0]["ID"].ToString();
                    hdnPartnerName.Value = ds.Tables[0].Rows[0]["Partner_Name"].ToString();
                    hdnPartnerEmailId.Value = ds.Tables[0].Rows[0]["Partner_Email"].ToString();
                    hdnPassword.Value = ds.Tables[0].Rows[0]["Password"].ToString();
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "View();", true);
                }
            }
            if (e.CommandName == "Disapprove")
            {
                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                Label lblId = (Label)row.FindControl("lblID");
                hdnPartnerId.Value = lblId.Text.ToString();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "View_Disapprove();", true);

            }
            if (e.CommandName == "View")
            {
                Div_GST.Visible = false;
                Div_Pan.Visible = false;
                Div_CancelCheque.Visible = false;
                Div_Addr.Visible = false;
                Div_AccNo.Visible = false;
                Div_BnkName.Visible = false;
                Div_IFSC.Visible = false;
                Div_BenefName.Visible = false;
                Div_BranchAddr.Visible = false;
                Div_GSTNo.Visible = false;
                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                Label lblId = (Label)row.FindControl("lblID");
                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PartnerRegRequest", new object[] { "View", lblId.Text });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    lblPartner_Name.Text = ds.Tables[0].Rows[0]["Partner_Name"].ToString();
                    lblEmailId.Text = ds.Tables[0].Rows[0]["Partner_Email"].ToString();
                    lblMobNo.Text = ds.Tables[0].Rows[0]["PartnerContactNo"].ToString();
                    if (ds.Tables[0].Rows[0]["Service_Tax_No"].ToString() != "")
                    {
                        Div_GSTNo.Visible = true;
                        lblGSTno.Text = ds.Tables[0].Rows[0]["Service_Tax_No"].ToString();
                    }
                    lblPancardNo.Text = ds.Tables[0].Rows[0]["PAN_No"].ToString();
                    lblState.Text = ds.Tables[0].Rows[0]["PartnerState"].ToString();
                    lblCity.Text = ds.Tables[0].Rows[0]["PartnerCity"].ToString();
                    lblPinCode.Text = ds.Tables[0].Rows[0]["PartnerPincode"].ToString();
                    lblAddress.Text = ds.Tables[0].Rows[0]["Partner_Address"].ToString();
                    lblContactPerson.Text = ds.Tables[0].Rows[0]["Contact_Person"].ToString();
                    lblContactPersonNo.Text = ds.Tables[0].Rows[0]["Contact_Person_No"].ToString();
                    lblContactPersonEmail.Text = ds.Tables[0].Rows[0]["Contact_Person_Email"].ToString();
                    if (ds.Tables[0].Rows[0]["Bank_Ac_No"].ToString() != "")
                    {
                        Div_AccNo.Visible = true;
                        lblBAnkAcctNo.Text = ds.Tables[0].Rows[0]["Bank_Ac_No"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["Bank_Nmae"].ToString() != "")
                    {
                        Div_BnkName.Visible = true;
                        lblBankName.Text = ds.Tables[0].Rows[0]["Bank_Nmae"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["IFSC_Code"].ToString() != "")
                    {
                        Div_IFSC.Visible = true;
                        lblIFSCCode.Text = ds.Tables[0].Rows[0]["IFSC_Code"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["Beneficiary_Name"].ToString() != "")
                    {
                        Div_BenefName.Visible = true;
                        lblBeneficiaryName.Text = ds.Tables[0].Rows[0]["Beneficiary_Name"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["Bank_Branch_Address"].ToString() != "")
                    {
                        Div_BranchAddr.Visible = true;
                        lblBranchAddress.Text = ds.Tables[0].Rows[0]["Bank_Branch_Address"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["PAN_Image"].ToString() != "")
                    {
                        Div_Pan.Visible = true;
                        string Panfile = Convert.ToString(ds.Tables[0].Rows[0]["PAN_Image"]);
                        string url = "../Upload/" + Panfile + "";
                        HyperLinkPancardImg.NavigateUrl = url;
                        // PancardImg.ImageUrl = url;
                        //imgFirst.ImageUrl = url;
                    }
                    if (ds.Tables[0].Rows[0]["Cheque_Image"].ToString() != "")
                    {
                        Div_CancelCheque.Visible = true;
                        string CancelChequefile = Convert.ToString(ds.Tables[0].Rows[0]["Cheque_Image"]);
                        string url1 = "../Upload/" + CancelChequefile + "";
                        HyperLinkCancelChequeImg.NavigateUrl = url1;
                        //CancelChequeImg.ImageUrl = url1;
                        //imgSecond.ImageUrl = url1;
                    }
                    if (ds.Tables[0].Rows[0]["AddrProofImg"].ToString() != "")
                    {
                        Div_Addr.Visible = true;
                        string AddrProoffile = Convert.ToString(ds.Tables[0].Rows[0]["AddrProofImg"]);
                        string url2 = "../Upload/" + AddrProoffile + "";
                        HyperLinkAddrImg.NavigateUrl = url2;
                        //AddrImg.ImageUrl = url2;
                        //imgThird.ImageUrl = url2;
                    }
                    if (ds.Tables[0].Rows[0]["GSTRegImg"].ToString() != "")
                    {
                        Div_GST.Visible = false;
                        string GSTfile = Convert.ToString(ds.Tables[0].Rows[0]["GSTRegImg"]);
                        string url3 = "../Upload/" + GSTfile + "";
                        HyperLinkGSTImg.NavigateUrl = url3;
                        //GSTImg.ImageUrl = url3;
                        //imgFourth.ImageUrl = url3;
                    }


                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "View_Details();", true);
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

    #region Rename File Name
    public string RenameFile(string FileName)
    {
        string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(FileName);
        string fileExtension = Path.GetExtension(FileName);
        return fileNameWithoutExtension + DateTime.Now.ToString("mmddyyHHmmssffff") + fileExtension;
    }
    #endregion
    protected void btnApprove_Click(object sender, EventArgs e)
    {
        try
        {
           
            if (Request.Form["radioFoo"] != null)
            {
                PartnerType = Request.Form["radioFoo"].ToString();
                // HiddenTravelType.Value = Request.Form["radioFoo1"].ToString();
            }
            string ProductType = "";
            if (ListProductType.Items.Count > 0)
            {
                for (int i = 0; i < ListProductType.Items.Count; i++)
                {
                    if (ListProductType.Items[i].Selected)
                    {
                        if (ProductType == "")
                            ProductType = ListProductType.Items[i].Value;
                        else
                            ProductType += "," + ListProductType.Items[i].Value;
                    }
                }
            }
            string SubPartnerType = string.Empty;
            if (txtKeypartner.Text.ToString() != "")
            {
                SubPartnerType = txtKeypartner.Text.ToString();
            }
            else
            {
                SubPartnerType = txtRetailPartner.Text.ToString();
            }

            string FileContract = string.Empty;
            if (FileuploadContract.HasFile)
            {
                FileContract = RenameFile(FileuploadContract.FileName);
                if (!File.Exists("~/Upload/" + FileContract))
                {
                    FileuploadContract.SaveAs(Server.MapPath("~/Upload/" + FileContract));
                }
            }
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PartnerRegReqApprove", new object[] { "Approve", PartnerId.Value, PartnerType, ddlHeadPartner.SelectedValue, ddlPaymentType.SelectedValue, ProductType, txtCreditLimit.Text.Trim(), SubPartnerType, ddlWalletType.SelectedValue, txtContractSDate.Text, txtContractEDate.Text, FileContract, hdnProductPrice.Value, txtNoOfPolicies.Text.Trim(), txtCommissionParcentage.Text.Trim(), txtAmount_Month.Text.Trim(), txtCommPercentage.Text.Trim(), ddlPartnerType.SelectedValue, Session["UserId"], "" });
            if (ds.Tables[0].Rows.Count > 0)
            {
                sendmail_User();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Approve();", true);
                Bind();
                // clear();
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
    private void sendmail_User()
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sblogo = new StringBuilder();
            string strSubject = "";
            string strTo = hdnPartnerEmailId.Value.ToString();
            string strFrom = ConfigurationManager.AppSettings["frommail"].ToString();
            //string password = BusinessLogic.QueryStringEncode(txtPassword.Text.ToString());
            string password = BusinessLogic.QueryStringDecode(hdnPassword.Value.ToString());
            DataSet dtvar = con.ExecuteReader("Allianz_Travel", "Get_Email", new object[] { "PartnerRegistration", 0, 0, "", "", "", "", "" });
            StringBuilder stb = new StringBuilder();
            if (dtvar.Tables[0].Rows.Count > 0)
            {
                strSubject = dtvar.Tables[0].Rows[0]["Subject"].ToString();
                stb.Append(dtvar.Tables[0].Rows[0]["Body"].ToString());
            }
            //stb.Replace("[User_Name]", txtFname.Text.ToString());
            stb.Replace("[Name]", hdnPartnerName.Value.ToString());
            stb.Replace("[EmailId]", hdnPartnerEmailId.Value.ToString());
            stb.Replace("[Password]", password.ToString());

            string Link = ConfigurationManager.AppSettings["virtualpath"].ToString() + "Login.aspx";
            bl.sendmail(strSubject, stb.ToString(), "", "", strFrom, strTo, "", "");

        }
        catch (Exception ex)
        {

        }
    }
    #endregion
    protected void btnDisApprove_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PartnerRegReqApprove", new object[] { "Disapprove", hdnPartnerId.Value, "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", 0, txtDisapproveRemark.Text.Trim() });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Disapprove();", true);
                Bind();
                // clear();
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