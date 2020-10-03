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
using System.Globalization;
using System.Drawing;
public partial class ManageContent : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Allianz_Travel"].ConnectionString);
    string connstring = ConfigurationManager.ConnectionStrings["Allianz_Travel"].ConnectionString;
    public string formValue;

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
                bool Authenticate = bl.CheckAuthority("ManageContent.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                Bind_ManageContent();
            }
            btnSave.Attributes.Add("onclick", "return validateBanner();");
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
    protected void Bind_ManageContent()
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ManageContent", new object[] { "Bind", "", "", "", "", 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            gv_ContentType.DataSource = ds;
            gv_ContentType.DataBind();
        }
        else
        {
            gv_ContentType.DataSource = ds;
            gv_ContentType.DataBind();
        }
    }

    protected void gv_ContentType_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Change")
            {
                GridViewRow row = (GridViewRow)(((ImageButton)e.CommandSource).NamingContainer);
                Label lblContentType = (Label)row.FindControl("lblContentType");
                DataSet rslt = con.ExecuteReader("Allianz_Travel", "USP_ManageContent", new object[] { "GetData", lblContentType.Text, "", "", "", 0 });
                if (rslt.Tables.Count > 0)
                {
                    hdnType.Value = rslt.Tables[0].Rows[0]["ContentType"].ToString();
                    txtName.Text = rslt.Tables[0].Rows[0]["ContentName"].ToString();
                    txtSubject.Text = rslt.Tables[0].Rows[0]["Content_Desc"].ToString();
                    hdntext.Value = rslt.Tables[0].Rows[0]["ContentBody"].ToString();                    
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "messageshow();", true);
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ManageContent", new object[] { "UPDATE", hdnType.Value, txtName.Text, txtSubject.Text, hdntext.Value.ToString(), Session["UserId"] });
            if(ds.Tables[0].Rows.Count>0)
            {
                Bind_ManageContent();

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "SuccessMsg();", true);
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


    protected void gv_ContentType_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gv_ContentType.PageIndex = e.NewPageIndex;
        Bind_ManageContent();
    }

   
}