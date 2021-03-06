﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Partner_WalletRequest : System.Web.UI.Page
{

    BusinessLogic bl = new BusinessLogic();
    ConnectionToSql ConSql = new ConnectionToSql();
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
                bool Authenticate = bl.CheckAuthority("WalletRequest.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                if (Session["UserId"] != null && Session["UserId"].ToString() != "0")
                {
                    Bind_WalletBalance();
                    BindGridview();
                }
                else
                {
                    Response.Redirect("../Partner/PartnerLogin.aspx");
                }
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "CheckBalance")
                {
                    CheckWalletBalance(Request.Params["Amount"].ToString());
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

    public void CheckWalletBalance(string amount)
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
        string message = string.Empty;
        DataTable dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_WalletStmt", new object[] { "Wallet_Balance", id, "" });
        decimal WalletBalance= Convert.ToDecimal(dt.Rows[0]["Balance"].ToString());
        DataTable dt1 = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_GetWalletLimit", new object[] { "Wallet_limit", id, "" });
        decimal CreditLimit= Convert.ToDecimal(dt1.Rows[0]["Credit_Limit"].ToString());
        decimal TotalAmount = WalletBalance + Convert.ToDecimal(amount);
        if(TotalAmount > CreditLimit)
        {
            message = "F#" + CreditLimit;
        }
        Response.Write(message);
        Response.End();

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
    public void Bind_WalletBalance()
    {
        int id = GetId();
        DataTable dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_WalletStmt", new object[] { "Wallet_Balance", id, "" });
       // WalletBalance = Convert.ToDecimal(dt.Rows[0]["Balance"].ToString());
        lblWalletBlnce.Text = dt.Rows[0]["Balance"].ToString();
    }
    public void BindGridview()
    {
        int id = GetId();
        DataTable dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_WalletDetails", new object[] { "TranxDetails", "", "", "", "", "", "", 0, 0, id });
        if (dt.Rows.Count > 0)
        {
            GV_TranxDetails.DataSource = dt;
            GV_TranxDetails.DataBind();
        }
        else
        {
            btnExportToExcel.Visible = false;
            DataTable dt1 = new DataTable();
            GV_TranxDetails.DataSource = dt1;
            GV_TranxDetails.DataBind();
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        SaveWalletDetails();
    }

    #region SaveWalletDetails
    private void SaveWalletDetails()
    {
        int id = GetId();
        string _FileName = "";
        try
        {
            if (FileUpload.HasFile)
            {
                if (FileUpload.PostedFile.ContentLength < 20728650)
                {
                    _FileName = RenameFile(FileUpload.FileName);
                    if (!File.Exists("~/Upload/" + _FileName))
                    {
                        FileUpload.SaveAs(MapPath("~/Upload/" + _FileName));
                    }

                }
            }
            //DateTime dtt = DateTime.Now;
            //string dateAsString = dtt.ToString("dd/MM/yyyy");
            //string dtString = txtTranxDate.Text;
            //DateTime dtTarget;
            //if (DateTime.TryParseExact(dtString, "dd/MM/yyyy", System.Globalization.CultureInfo.CurrentCulture, System.Globalization.DateTimeStyles.None, out dtTarget))
            //{
            //    dtString = dtTarget.ToString("MM/dd/yyyy");
            //}
            //DateTime TSartdtt = Convert.ToDateTime(dtString);

            ds = ConSql.ExecuteReader("Allianz_Travel", "USP_WalletDetails", new object[] { "Save", txtAmount.Text, txtTranxDate.Text.ToString(), ddlPaymentMethod.SelectedItem.Text, txtPayMethoDetails.Text, _FileName, txtRemarks.Text, id, id, 0 });
            if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "I")
            {
                ds = ConSql.ExecuteReader("Allianz_Travel", "USP_WalletDetails", new object[] { "GetId", "", "", "", "", "", "", 0, 0, 0 });
                Get_Notification(txtAmount.Text.ToString(), ds.Tables[0].Rows[0][0].ToString(), ddlPaymentMethod.SelectedItem.Text, txtRemarks.Text, _FileName, txtPayMethoDetails.Text);
                sendmail_User();
                Clear();              
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SuccessMsg();", true);
                BindGridview();
            }
        }
        catch (Exception ex)
        {

        }
    }
    #endregion

    private void Get_Notification(string amount, string fileNo,string PaymentMethod,string Remarks,string FileName,string PayMethoDetails)
    {
        //int id = Convert.ToInt32(Session["DealerId"].ToString());
        int id = GetId();
        ds = ConSql.ExecuteReader("Allianz_Travel", "USP_WalletDetails", new object[] { "GetUserDetails", "", "", "", "", "", "", 0, 0, id });
        if (ds.Tables[0].Rows.Count >= 0)
        {
            ds = ConSql.ExecuteReader("Allianz_Travel", "USP_TrnNotificationForWallet", new object[] { "Save", ds.Tables[0].Rows[0]["Partner_Code"].ToString(), ds.Tables[0].Rows[0]["Partner_Name"].ToString(), "", "", "", "", amount, "", "", id, fileNo, PaymentMethod, Remarks, FileName, PayMethoDetails });
            if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "I")
            {
            }
        }
    }

    #region Send Mail
    private void sendmail_User()
    {
        try
        {

            StringBuilder sb = new StringBuilder();
            StringBuilder sblogo = new StringBuilder();
            ds = ConSql.ExecuteReader("Allianz_Travel", "USP_WalletDetails", new object[] { "GetEmailId", "", "", "", "", "", "", 0, 0, 0 });
            string email = string.Empty;
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                email += "" + Convert.ToString(dr["EmailId"]) + ",";
            }
            if (email == "")
            {
                email = ",";
            }
            email = email.Substring(0, email.Length - 1);

            string myTemplate = "", strSubject = "";
            string strTo = email;

            string strFrom = ConfigurationManager.AppSettings["frommail"].ToString();
            // string password = (txtPassword.Text.ToString());
            DataSet dtvar = ConSql.ExecuteReader("Allianz_Travel", "Get_Email", new object[] { "WalletRequest", 0, 0, "", "", "", "", "" });
            StringBuilder stb = new StringBuilder();
            if (dtvar.Tables[0].Rows.Count > 0)
            {
                strSubject = dtvar.Tables[0].Rows[0]["Subject"].ToString();
                stb.Append(dtvar.Tables[0].Rows[0]["Body"].ToString());
            }
            stb.Replace("[Name]", "Sir/Madam");
            stb.Replace("[Dealer_Name]", Session["Partner_Name"]==null? UppercaseFirst(Session["UserName"].ToString()): UppercaseFirst(Session["Partner_Name"].ToString()));
            stb.Replace("[Amount]", txtAmount.Text.ToString());

            string Link = ConfigurationManager.AppSettings["virtualpath"].ToString() + "Login.aspx";
            bl.sendmail(strSubject, stb.ToString(), "", "", strFrom, "", "", strTo);

        }
        catch (Exception ex)
        {

        }
    }
    #endregion

    #region Rename File Name
    public string RenameFile(string FileName)
    {
        string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(FileName);
        string fileExtension = Path.GetExtension(FileName);
        return fileNameWithoutExtension + DateTime.Now.ToString("mmddyyHHmmssffff") + fileExtension;
    }
    #endregion

    #region Clear
    private void Clear()
    {
        txtAmount.Text = "";
        txtTranxDate.Text = "";
        txtPayMethoDetails.Text = "";
        txtRemarks.Text = "";
        ddlPaymentMethod.SelectedIndex = -1;

    }
    #endregion

    #region UppercaseFirst
    static string UppercaseFirst(string s)
    {
        // Check for empty string.
        if (string.IsNullOrEmpty(s))
        {
            return string.Empty;
        }
        // Return char and concat substring.
        return char.ToUpper(s[0]) + s.Substring(1);
    }
    #endregion

    protected void btnReset_Click(object sender, EventArgs e)
    {
        Clear();
    }

    protected void GV_TranxDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_TranxDetails.PageIndex = e.NewPageIndex;
        BindGridview();
    }

    protected void GV_TranxDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            HiddenField field = e.Row.FindControl("hdnUploadImg") as HiddenField;
            Button LinkButton = (Button)e.Row.FindControl("lnkView");
            if (field.Value == "NF")
            {
                LinkButton.Enabled = false;
                LinkButton.CssClass = "btn btn-sm round btn-outline";
            }

        }
    }

    protected void GV_TranxDetails_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "ViewImage")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_TranxDetails.Rows[rowIndex].FindControl("lblId") as Label).Text);
                ds = ConSql.ExecuteReader("Allianz_Travel", "USP_WalletDetails", new object[] { "GetImgId", "", "", "", "", "", "", 0, 0, Id });
                string filename = ds.Tables[0].Rows[0]["upload_Img"].ToString();
                string url = "../Upload/" + filename + "";
                imgFirst.ImageUrl = url;
              
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "messageshow();", true);
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

    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_ExportWalletStmt", new object[] { "Wallet_Transaction_History", 0, Session["UserId"] });
            if (ds.Tables[0].Rows.Count > 0)
            {
                string FileName = "TransactionDetails_" + DateTime.Now.ToString("dd-MM-yyyy");
                bl.DownloadXLS(ds.Tables[0], FileName);
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
}