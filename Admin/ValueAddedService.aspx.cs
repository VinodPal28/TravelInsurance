using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ValueAddedService : System.Web.UI.Page
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
                bind_VASMaster();
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "CheckName")
                {
                    CheckVASNAme(Request.Params["name"].ToString());
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

    public void CheckVASNAme(string name)
    {
        string message = string.Empty;
      
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_CheckVASName", new object[] { name });
            message = ds.Tables[0].Rows.Count > 0 ? "F" : "NF";
            Response.Write(message);
            Response.End();
       
    }
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        Submit_Details("Add");
        bind_VASMaster();
    }

    protected void btnreset_Click(object sender, EventArgs e)
    {
        Clear();
    }

    protected void GV_VAS_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Deactive")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblVASname = (GV_VAS.Rows[rowIndex].FindControl("lblVASname") as Label).Text;
            string lblVASsupplier = (GV_VAS.Rows[rowIndex].FindControl("lblVASSupplier") as Label).Text;
            Button Deactive = (GV_VAS.Rows[rowIndex].FindControl("btndeactive") as Button);        
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_VASManagement", new object[] { "Deactive", lblVASname, lblVASsupplier, Session["UserId"], 0,HiddenField_Id.Value,"" });
            bind_VASMaster();

        }
        else if (e.CommandName == "Active")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblVASname = (GV_VAS.Rows[rowIndex].FindControl("lblVASname") as Label).Text;
            string lblVASsupplier = (GV_VAS.Rows[rowIndex].FindControl("lblVASSupplier") as Label).Text;
            Button active = (GV_VAS.Rows[rowIndex].FindControl("btnActive") as Button);            
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_VASManagement", new object[] { "Active", lblVASname, lblVASsupplier, Session["UserId"], 1, HiddenField_Id.Value,"" });
            bind_VASMaster();
        }
    }

    protected void GV_VAS_RowDataBound(object sender, GridViewRowEventArgs e)
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

    protected void GV_VAS_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridViewRow row = GV_VAS.SelectedRow;
        Label lblVAS = row.FindControl("lblVASname") as Label;
        txtVASName.Text = lblVAS.Text;
        Label lblSupplier = row.FindControl("lblVASSupplier") as Label;
        txtVASSupplier.Text = lblSupplier.Text;
        Label lblPrice = row.FindControl("lblVASPrice") as Label;
        txtVASPrice.Text = lblPrice.Text;
        Label lblID = row.FindControl("lblID") as Label;
        HiddenField_Id.Value = lblID.Text;
    }

    protected void GV_VAS_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_VAS.PageIndex = e.NewPageIndex;
        bind_VASMaster();
    }

    protected void bind_VASMaster()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_VASManagement", new object[] { "Get", "", "", Session["UserId"], 0, 0,"" });
            if (ds.Tables[0].Rows.Count > 0)
            {
                GV_VAS.DataSource = ds;
                GV_VAS.DataBind();
            }
            else
            {
                GV_VAS.DataSource = ds;
                GV_VAS.DataBind();
            }
        }
        catch { }
    }

    protected void Submit_Details(string Option)
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_VASManagement", new object[] { Option, txtVASName.Text.Trim(), txtVASSupplier.Text.Trim(), Session["UserId"], 1, HiddenField_Id.Value,txtVASPrice.Text });
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
        txtVASName.Text = "";
        txtVASSupplier.Text = "";
        txtVASPrice.Text = "";
        HiddenField_Id.Value = "0";
    }
}