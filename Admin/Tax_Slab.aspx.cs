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
public partial class Admin_Tax_Slab : System.Web.UI.Page
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
                bool Authenticate = bl.CheckAuthority("Masters", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                bind_Taxslabmaster();
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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        Submit("SaveDetail");
        bind_Taxslabmaster();
    }

    protected void Submit(string option)
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_TaxSlab", new object[] { option, HiddenField_ID.Value, "", txtCGST.Text.Trim(), txtSGCST.Text.Trim(), txtIGST.Text.Trim(), Session["UserId"] });
        if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "I"  )
       // if (ds.Tables[0].Rows.Count > 0)
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMessage();", true);
            bind_Taxslabmaster();
            Clear();
        }
        else
        {
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMsgErr();", true);
        }
    }


    protected void Clear()
    {

        txtCGST.Text = "";
        txtIGST.Text = "";
        txtSGCST.Text = "";
        HiddenField_ID.Value ="0";
    }

    protected void btnrset_Click(object sender, EventArgs e)
    {
        Clear();
    }

    protected void bind_Taxslabmaster()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_TaxSlab", new object[] { "Get_TaxSlabMaster", 0, "", "", "", "", Session["UserId"] });
            if (ds.Tables[0].Rows.Count > 0)
            {

                GV_TaxSlab.DataSource = ds;
                GV_TaxSlab.DataBind();
            }
            else
            {
                GV_TaxSlab.DataSource = ds;
                GV_TaxSlab.DataBind();
            }
        }
        catch (Exception ex)
        { }
    }
    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GridViewRow row = GV_TaxSlab.SelectedRow;
        Label lblCGST = row.FindControl("lblCGST") as Label;
        txtCGST.Text = lblCGST.Text;
        Label lblSGST = row.FindControl("lblSGST") as Label;
        txtSGCST.Text = lblSGST.Text;
        Label lblIGST = row.FindControl("lblIGST") as Label;
        txtIGST.Text = lblIGST.Text;
        Label lblTaxslab_Id = row.FindControl("lblTaxslab_Id") as Label;
        HiddenField_ID.Value = lblTaxslab_Id.Text;
        //Label lblsate = row.FindControl("lblHome_State") as Label;
        //ddlhomestate.SelectedIndex = ddlhomestate.Items.IndexOf(ddlhomestate.Items.FindByText(lblsate.Text.ToString()));
        bind_Taxslabmaster();
    }
    protected void GV_Insured_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Active")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblTaxslab_Id = (GV_TaxSlab.Rows[rowIndex].FindControl("lblTaxslab_Id") as Label).Text;
            Button Active = (GV_TaxSlab.Rows[rowIndex].FindControl("btnActive") as Button);

           
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_TaxSlab", new object[] { "Get_Active", lblTaxslab_Id, "", "", "", "", Session["UserId"] });

            bind_Taxslabmaster();
        }
        if (e.CommandName == "Deactive")
        {

            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblTaxslab_Id = (GV_TaxSlab.Rows[rowIndex].FindControl("lblTaxslab_Id") as Label).Text;
            Button Deactive = (GV_TaxSlab.Rows[rowIndex].FindControl("btndactive") as Button);
           
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_TaxSlab", new object[] { "Get_Deactive", lblTaxslab_Id, "", "", "", "", Session["UserId"] });
            bind_Taxslabmaster();
        }
    }

    protected void GV_Insured_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
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
        catch (Exception ex)
        { }
    }

    protected void GV_TaxSlab_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_TaxSlab.PageIndex = e.NewPageIndex;
        bind_Taxslabmaster();
    }
}