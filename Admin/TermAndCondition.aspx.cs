using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text;
using System.IO;
public partial class Admin_TermAndCondition : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Allianz_Travel"].ConnectionString);
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
                bool Authenticate = bl.CheckAuthority("TermAndCondition.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                bind_termAndCondition();
                Clear();
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "GetTermCondition")
                {
                    T_Condition(Request.Params["FileName"].ToString());
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

    public void T_Condition(string FileName)
    {
        try
        {
            string msg = "";
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_TemAndCondition", new object[] { "CheckTerm", 0, FileName.Trim(), "", "", 0 });

            if (ds.Tables[0].Rows[0]["Name"].ToString() == "F")
            {
                msg = "F";
            }
            else if (ds.Tables[0].Rows[0]["Name"].ToString() == "NF")
            {
                msg = "NF";
            }

            Response.Write(msg);
            Response.End();
        }
        catch (Exception ex)
        { }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {        
        try
        {
            if (fileUpload1.HasFile)
            {
                if (fileUpload1.PostedFile.ContentType == "application/pdf")
                {
                    string _FileName = "";                                 
                    // string filename = Path.GetFileName(fileUpload1.PostedFile.FileName);
                    // fileUpload1.SaveAs(Server.MapPath("~/TermAndCondition/" + filename));
                    _FileName = RenameFile(fileUpload1.FileName);
                    if (!File.Exists("~/TermAndCondition/" + _FileName))
                    {                     
                        fileUpload1.SaveAs(Server.MapPath("~/TermAndCondition/" + _FileName));
                    }               
                    DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_TemAndCondition", new object[] { "Save", 0, txtDocumentName.Text.Trim(), "", _FileName.ToString().Trim(),0 });
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "messageshow();", true);
                        bind_termAndCondition();
                        Clear();
                    }
                }
            }
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Errmessageshow();", true);
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
    public void Clear()
    {
        txtDocumentName.Text = "";
    }
    protected void bind_termAndCondition()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_TemAndCondition", new object[] { "get_Termandcondition", 0, "", "", "",0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                GV_TermandCondition.DataSource = ds;
                GV_TermandCondition.DataBind();
            }
            else
            {
                GV_TermandCondition.DataSource = ds;
                GV_TermandCondition.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnReset_Click(object sender, EventArgs e)
    {
        Clear();
    }
    protected void GV_TermandCondition_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_TermandCondition.PageIndex = e.NewPageIndex;
        bind_termAndCondition();
    }
    protected void GV_TermandCondition_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Active")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblTerm_id = (GV_TermandCondition.Rows[rowIndex].FindControl("lbl_id") as Label).Text;                
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_TemAndCondition", new object[] { "Active", lblTerm_id.Trim(), "", "", "", Session["UserId"] });
            bind_termAndCondition();

        }
        if (e.CommandName == "Deactive")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblTerm_id = (GV_TermandCondition.Rows[rowIndex].FindControl("lbl_id") as Label).Text;                
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_TemAndCondition", new object[] { "Deactive", lblTerm_id.Trim(), "", "", "", Session["UserId"] });
            bind_termAndCondition();
        }
        if (e.CommandName == "download")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblTerm_id = (GV_TermandCondition.Rows[rowIndex].FindControl("lbl_id") as Label).Text;    
            Button Deactive = (GV_TermandCondition.Rows[rowIndex].FindControl("btndownload") as Button);     
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_TemAndCondition", new object[] { "Get_FilePath", lblTerm_id.Trim(), "", "", "", Session["UserId"] });
            string filename = ds.Tables[0].Rows[0]["Document_Path"].ToString();
            string url = "../TermAndCondition/" + filename + "";    
            if (filename != "")
            {
              
                try
                {
                    StringBuilder sb = new StringBuilder();
                    sb.Append("<script type = 'text/javascript'>");
                    sb.Append("window.open('");
                    sb.Append(url);
                    sb.Append("');");
                    sb.Append("</script>");
                    ClientScript.RegisterStartupScript(this.GetType(), "script", sb.ToString());                 
                }
                catch (Exception ex)
                { }         
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "NotFoundmessageshow();", true);       
            }
        }
    }
    protected void GV_TermandCondition_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Button btnDeactive = (Button)e.Row.FindControl("btndeactive");
            Button btnactive = (Button)e.Row.FindControl("btnActive");
            string outlookid = ((HiddenField)e.Row.FindControl("HiddenIsActive")).Value;

            if (outlookid == "0")
            {
                btnDeactive.Enabled = false;
                btnactive.Enabled = true;
                btnDeactive.CssClass = "btn btn-sm round btn-outline-fade";
                btnactive.CssClass = "btn btn-sm round btn-outline-danger";
                //btnDeactive.BackColor = System.Drawing.Color.Wheat;
            }
            else if (outlookid == "1")
            {
                btnDeactive.Enabled = true;
                btnactive.Enabled = false;
                btnDeactive.CssClass = "btn btn-sm round btn-outline-danger";
                btnactive.CssClass = "btn btn-sm round btn-outline-fade";
            }
        }
    }
}