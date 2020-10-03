using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class PartnerRegistration : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    DataSet ds = new DataSet();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                Bind_State();
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
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "CheckEMail")
                {
                    CheckEMail(Request.Params["Email"].ToString());
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

    public string GetCity(int id)
    {
        ds = con.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "Get_City", id });

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
    protected void Bind_State()
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "Get_State", 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlPartnerState.DataSource = ds;
            ddlPartnerState.DataTextField = "name";
            ddlPartnerState.DataValueField = "id_state";
            ddlPartnerState.DataBind();

            //ddlCompState.DataSource = ds;
            //ddlCompState.DataTextField = "name";
            //ddlCompState.DataValueField = "id_state";
            //ddlCompState.DataBind();
        }
    }

    public void CheckEMail(string Email)
    {
        string msg = "";
        DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_CheckEmail", new object[] { "CheckEmail", Email, "" });
        msg = dt.Rows.Count > 0 ? "F" : "NF";
        Response.Write(msg);
        Response.End();
    }

    #region Rename File Name
    public string RenameFile(string FileName)
    {
        string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(FileName);
        string fileExtension = Path.GetExtension(FileName);
        return fileNameWithoutExtension + DateTime.Now.ToString("mmddyyHHmmssffff") + fileExtension;
    }
    #endregion
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            string FilePancard = string.Empty, FileCancelCheque = string.Empty, FileAddrProof = string.Empty, FileGst = string.Empty, Password = string.Empty;
            if (fileUploadPanCard.HasFile)
            {
                FilePancard = RenameFile(fileUploadPanCard.FileName);
                if (!File.Exists("~/Upload/" + FilePancard))
                {
                    fileUploadPanCard.SaveAs(Server.MapPath("~/Upload/" + FilePancard));
                }
            }
            if (fileUploadCancelCheque.HasFile)
            {
                FileCancelCheque = RenameFile(fileUploadCancelCheque.FileName);
                if (!File.Exists("~/Upload/" + FileCancelCheque))
                {
                    fileUploadCancelCheque.SaveAs(Server.MapPath("~/Upload/" + FileCancelCheque));
                }
            }
            if (fileUploadAddrProof.HasFile)
            {
                FileAddrProof = RenameFile(fileUploadAddrProof.FileName);
                if (!File.Exists("~/Upload/" + FileAddrProof))
                {
                    fileUploadAddrProof.SaveAs(Server.MapPath("~/Upload/" + FileAddrProof));
                }
            }
            if (fileUploadGstReg.HasFile)
            {
                FileGst = RenameFile(fileUploadGstReg.FileName);
                if (!File.Exists("~/Upload/" + FileGst))
                {
                    fileUploadGstReg.SaveAs(Server.MapPath("~/Upload/" + FileGst));
                }
            }
            string Password1 = "Ptr@" + txtPartnerMobNo.Text.Substring(6);
            Password = BusinessLogic.QueryStringEncode(Password1);
            ds = con.ExecuteReader("Allianz_Travel", "USP_PartnerReg", new object[] { "INSERT", Password, txtPartnerName.Text.Trim(), txtPartnerEmail.Text.Trim(), txtPartnerMobNo.Text.Trim(), txtGstNo.Text.Trim(), txtPanCard.Text.Trim(), ddlPartnerState.SelectedValue, hdnPartnerCity.Value, txtPinCode.Text.Trim(), txtPartnerAddr.Text.Trim(), txtContactPerson.Text.Trim(), txtContactNoOfContPerson.Text.Trim(), txtEmailIdOfContperson.Text.Trim(), "", txtAccountNo.Text.Trim(), txtBankName.Text.Trim(), txtIfscCode.Text.Trim(), txtBeneficiaryName.Text.Trim(), txtBranchAddr.Text.Trim(), FilePancard, FileCancelCheque, FileAddrProof, FileGst, 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Msg();", true);
                clear();
            }
        }
        catch (SqlException ex)
        {
            lblErrorshowMessage.Text = "Error occured : " + ex.Message.ToString();
        }
        catch (Exception ex)
        {
            lblErrorshowMessage.Text = "Error occured : " + ex.Message.ToString();
            //ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('"+ex.Message.ToString()+"')", true);
        }
    }

    public void clear()
    {
        txtPartnerName.Text = "";
        txtPartnerEmail.Text = "";
        txtPartnerMobNo.Text = "";
        txtGstNo.Text = "";
        txtPanCard.Text = "";
        ddlPartnerState.SelectedIndex = -1;
        ddlPartnerCity.SelectedIndex = -1;
        txtPinCode.Text = "";
        txtPartnerAddr.Text = "";
        txtContactPerson.Text = "";
        txtContactNoOfContPerson.Text = "";
        txtEmailIdOfContperson.Text = "";
      //  ddlRegion.SelectedIndex = -1;
        txtAccountNo.Text = "";
        txtBankName.Text = "";
        txtIfscCode.Text = "";
        txtBeneficiaryName.Text = "";
        txtBranchAddr.Text = "";

    }
}