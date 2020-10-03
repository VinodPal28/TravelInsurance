using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_BenifitMaster : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
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
                bool Authenticate = bl.CheckAuthority("Masters", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                bind_Benifitsmaster();
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "CheckName")
                {
                    CheckName(Request.Params["name"].ToString());
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

    public void CheckName(string BenifitName)
    {
        string message = string.Empty;
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_CheckBenifitName", new object[] { BenifitName });
        message = ds.Tables[0].Rows.Count > 0 ? "F" : "NF";
        Response.Write(message);
        Response.End();
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        Submit_Details("Add");
        bind_Benifitsmaster();
    }

    protected void btnreset_Click(object sender, EventArgs e)
    {
        Clear();
    }

    protected void GV_Benifits_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_Benifits.PageIndex = e.NewPageIndex;
        bind_Benifitsmaster();
    }

    protected void GV_Benifits_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridViewRow row = GV_Benifits.SelectedRow;
        Label lblbenifitname = row.FindControl("lblBenifitsname") as Label;
        txtBenifits.Text = lblbenifitname.Text;
        Label lblID = row.FindControl("lblID") as Label;
        HiddenField_Id.Value = lblID.Text;
    }

    protected void bind_Benifitsmaster()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_BenifitManagement", new object[] { "Get", "", Session["UserId"], 0, 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                GV_Benifits.DataSource = ds;
                GV_Benifits.DataBind();
            }
            else
            {
                GV_Benifits.DataSource = ds;
                GV_Benifits.DataBind();
            }
        }
        catch { }
    }

    protected void Submit_Details(string Option)
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_BenifitManagement", new object[] { Option, txtBenifits.Text.Trim(), Session["UserId"], 0, HiddenField_Id.Value });
            if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "I")
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMsg();", true);

                Clear();
            }
            else
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMsgErr();", true);
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void Clear()
    {
        txtBenifits.Text = "";
        HiddenField_Id.Value = "0";
    }

    protected void GV_Benifits_RowDataBound(object sender, GridViewRowEventArgs e)
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
            }
            else if (outlookid == "1")
            {
                btnDeactive.Enabled = true;
                btnactive.Enabled = false;
                btnactive.CssClass = "btn btn-sm round btn-outline-fade";
                btnDeactive.CssClass = "btn btn-sm round btn-outline-danger";
            }

        }
    }

    protected void GV_Benifits_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Deactive")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblBenifitsname = (GV_Benifits.Rows[rowIndex].FindControl("lblBenifitsname") as Label).Text;
            Button Deactive = (GV_Benifits.Rows[rowIndex].FindControl("btndeactive") as Button);
            //int index = Convert.ToInt32(e.CommandArgument.ToString());
            //GridViewRow row = GV_Benifits.Rows[index];
            //string lblBenifitsname = (row.FindControl("lblBenifitsname") as Label).Text;
            //Button Deactive = (row.FindControl("btndeactive") as Button);
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_BenifitManagement", new object[] { "Deactive", lblBenifitsname, Session["UserId"], 0, HiddenField_Id.Value });
            bind_Benifitsmaster();
        }
        else if (e.CommandName == "Active")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblBenifitsname = (GV_Benifits.Rows[rowIndex].FindControl("lblBenifitsname") as Label).Text;
            Button active = (GV_Benifits.Rows[rowIndex].FindControl("btnActive") as Button);
            //int index = Convert.ToInt32(e.CommandArgument.ToString());
            //GridViewRow row = GV_Benifits.Rows[index];
            //string lblBenifitsname = (row.FindControl("lblBenifitsname") as Label).Text;
            //Button active = (row.FindControl("btnActive") as Button);
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_BenifitManagement", new object[] { "Active", lblBenifitsname, Session["UserId"], 1, HiddenField_Id.Value });
            bind_Benifitsmaster();
        }
    }
}