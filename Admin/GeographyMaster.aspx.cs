using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_GeographyMaster : System.Web.UI.Page
{
    ConnectionToSql ConSql = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    DataTable rslt = new DataTable();
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
                if (Session["UserId"] != null && Session["UserId"].ToString() != "0")
                {
                    Bind();
                    BindGridview();
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "CheckName")
                {
                    CheckCode(Request.Params["name"].ToString());
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

    public void Bind()
    {
        DataTable dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_GeographyDetails", new object[] { "GetCountryName", "", "", "", "", 0,"" });
        if (dt.Rows.Count > 0)
        {
            ddlCountries.DataSource = dt;
            ddlCountries.DataValueField = "CountryId";
            ddlCountries.DataTextField = "Country";
            ddlCountries.DataBind();
        }
        //DataTable dt1 = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_GeographyDetails", new object[] { "BindRegion", "", "", "", "", 0,"" });
        //if (dt1.Rows.Count > 0)
        //{
        //    ddlRegion.DataSource = dt1;
        //    ddlRegion.DataValueField = "Id";
        //    ddlRegion.DataTextField = "Region";
        //    ddlRegion.DataBind();
        //}
    }

    public void BindGridview()
    {
        DataTable dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_GeographyDetails", new object[] { "BindGridview", "", "", "", "", 0,"" });
        if (dt.Rows.Count > 0)
        {
            GV_Geography.DataSource = dt;
            GV_Geography.DataBind();
        }
        else
        {
            DataTable dt1 = new DataTable();
            GV_Geography.DataSource = dt1;
            GV_Geography.DataBind();
        }
    }

    public void CheckCode(string name)
    {
        string message = string.Empty;
        try
        {
            DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_GeographyDetails", new object[] { "GetName", "", name, "", "", 0,"" });
            message = ds.Tables[0].Rows.Count > 0 ? "F" : "NF";
            Response.Write(message);
            Response.End();
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
   
    protected void GV_Geography_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_Geography.PageIndex = e.NewPageIndex;
        BindGridview();
        
    }

    protected void GV_Geography_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Active")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_Geography.Rows[rowIndex].FindControl("lblId") as Label).Text);
                Button active = (GV_Geography.Rows[rowIndex].FindControl("btnActive") as Button);
                rslt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_GeographyDetails", new object[] { "Active", "", "", "", "", Id,"" });
                active.Enabled = false;
                BindGridview();
            }
            if (e.CommandName == "Deactive")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_Geography.Rows[rowIndex].FindControl("lblId") as Label).Text);
                Button Deactive = (GV_Geography.Rows[rowIndex].FindControl("btndeactive") as Button);
                rslt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_GeographyDetails", new object[] { "Deactive", "", "", "", "", Id,"" });
                Deactive.Enabled = false;
                BindGridview();
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

    protected void GV_Geography_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        // GV_Geography.PagerStyle.CssClass = "bs-pagination";
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Button btnDeactive = (Button)e.Row.FindControl("btndeactive");
            Button btnactive = (Button)e.Row.FindControl("btnActive");
            string Isactive = ((HiddenField)e.Row.FindControl("HiddenIsActive")).Value;

            if (Isactive == "0")
            {
                btnDeactive.Enabled = false;
                btnactive.Enabled = true;
                btnDeactive.CssClass = "btn btn-sm round btn-outline-fade";
            }
            else if (Isactive == "1")
            {
                btnDeactive.Enabled = true;
                btnactive.Enabled = false;
                btnactive.CssClass = "btn btn-sm round btn-outline-fade";
            }

        }
    }

    protected void GV_Geography_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtName.ReadOnly = true;
        string lstCountry = string.Empty;
        GridViewRow row = GV_Geography.SelectedRow;
        
        Label lblName = row.FindControl("lblName") as Label;
        txtName.Text = lblName.Text;
        Label lblRegion = row.FindControl("lblRegion") as Label;
      
        //ddlRegion.SelectedIndex = ddlRegion.Items.IndexOf(ddlRegion.Items.FindByText(lblRegion.Text.ToString()));
        Label lblcountry = row.FindControl("lblCountry") as Label;
        lstCountry = lblcountry.Text.ToString();
        for (int i = 0; i < ddlCountries.Items.Count; i++)
        {
            foreach (string category in lstCountry.ToString().Split(','))
            {
                if (category != ddlCountries.Items[i].Text)
                {
                    ddlCountries.Items[i].Selected = false;
                    continue;
                }
                else
                {                   
                    ddlCountries.Items[i].Selected = true;
                    break;
                }
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            
            string selectedItem = "";
            if (ddlCountries.Items.Count > 0)
            {
                for (int i = 0; i < ddlCountries.Items.Count; i++)
                {
                    if (ddlCountries.Items[i].Selected)
                    {
                        if (selectedItem == "")
                            selectedItem = ddlCountries.Items[i].Text;
                        else
                            selectedItem += "," + ddlCountries.Items[i].Text;
                    }
                }
            }
                                  
                DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_GeographyDetails", new object[] { "Save", "", txtName.Text, selectedItem, Session["UserId"], 0,""});
                if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "I")
                {
                    txtName.ReadOnly = false;
                    clear();
                    BindGridview();
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMessage();", true);
                   
                }
                else
                {
                    //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMsgErr();", true);
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

    public void clear()
    {
        
        txtName.Text = "";
        //ddlRegion.SelectedIndex = -1;
        ddlCountries.SelectedIndex = -1;
    }



    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        txtName.ReadOnly = false;
        clear();

    }
}