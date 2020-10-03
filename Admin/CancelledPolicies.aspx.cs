
//-- =============================================
//-- Author:		<Vinod Pal>
//-- Create date:   <18-06-2018>
//-- Description:	<get only cancelled policies>
//-- =============================================
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_CancelledPolicies : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
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
                bool Authenticate = bl.CheckAuthority("CancelledPolicies.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }

            if (!IsPostBack)
            {
                this.Search();
                Bind_CancelledPolicy();
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
    protected void Bind_CancelledPolicy()
    {
        try
        {
            int id = GetId();
            if (Session["PartnerCode"].ToString() != "")
            {
                ds = con.ExecuteReader("Allianz_Travel", "USP_CancelledPolicies", new object[] { "CancelledPolicies_PartnerWise", "", id, 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    GV_CancelledPolicy.DataSource = ds;
                    GV_CancelledPolicy.DataBind();
                }
                else
                {
                    GV_CancelledPolicy.DataSource = ds;
                    GV_CancelledPolicy.DataBind();
                }
            }
            else
            {
                ds = con.ExecuteReader("Allianz_Travel", "USP_CancelledPolicies", new object[] { "CancelledPolicies", "", 0, 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    GV_CancelledPolicy.DataSource = ds;
                    GV_CancelledPolicy.DataBind();
                }
                else
                {
                    GV_CancelledPolicy.DataSource = ds;
                    GV_CancelledPolicy.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void GV_CancelledPolicy_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_CancelledPolicy.PageIndex = e.NewPageIndex;
        Bind_CancelledPolicy();
    }

    protected void GV_CancelledPolicy_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
           
            if (e.CommandName == "View")
            {
                CompanyInfo.Visible = false;
                CustInfo.Visible = false;
                GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                Label lblPolicy_No = (Label)row.FindControl("lblPolicy_No");
                ds = con.ExecuteReader("Allianz_Travel", "USP_CancelledPolicies", new object[] { "View", lblPolicy_No.Text.Trim(), 0, 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    txtPolicyNo.Text = ds.Tables[0].Rows[0]["Policy_No"].ToString();
                    txtCountry.Text = ds.Tables[0].Rows[0]["Geography_Name"].ToString();
                    txtIssueDate.Text = ds.Tables[0].Rows[0]["IssueDate"].ToString();
                    txtstartdtt.Text = ds.Tables[0].Rows[0]["Travel_Start_Date"].ToString();
                    txtEnddtt.Text = ds.Tables[0].Rows[0]["Travel_End_Date"].ToString();
                    txtPlanName.Text = ds.Tables[0].Rows[0]["Plan_Name"].ToString();
                    txtPrices.Text = ds.Tables[0].Rows[0]["TotalPrice"].ToString();
                    if (ds.Tables[0].Rows[0]["First_Name"].ToString() != "")
                    {
                        CustInfo.Visible = true;
                        txtName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                        txtdob.Text = ds.Tables[0].Rows[0]["DOB"].ToString();
                        txtNumber.Text = ds.Tables[0].Rows[0]["Contact_No"].ToString();
                        txtEmailid.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                        txtNomineeNames.Text = ds.Tables[0].Rows[0]["Nominee_Name"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["CompanyName"].ToString() != "")
                    {
                        CompanyInfo.Visible = true;
                        txtCompName.Text = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                        txtCompEmailID.Text = ds.Tables[0].Rows[0]["Company_EmailId"].ToString();
                        txtCompGSTIN.Text = ds.Tables[0].Rows[0]["Company_GSTIN"].ToString();
                        txtCompState.Text = ds.Tables[0].Rows[0]["ComapnyAddress"].ToString();
                        txtCompCity.Text = ds.Tables[0].Rows[0]["CompCity"].ToString();
                        txtCompAddress.Text = ds.Tables[0].Rows[0]["CompState"].ToString();
                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ViewMsg();", true);
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

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        Search();
    }
    private void Search()
    {
        try
        {
            int id = GetId();
            if (Session["PartnerCode"].ToString() != "")
            {
                DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_SearchCancelledPolicies", new object[] { "Search_PartnerWise", txtSearch.Text.Trim(), id });
                if (dt.Rows.Count > 0)
                {
                    GV_CancelledPolicy.DataSource = dt;
                    GV_CancelledPolicy.DataBind();
                }
                else
                {
                    GV_CancelledPolicy.DataSource = dt;
                    GV_CancelledPolicy.DataBind();
                }
            }
            else
            {
                DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_SearchCancelledPolicies", new object[] { "Search", txtSearch.Text.Trim(), 0 });
                if (dt.Rows.Count > 0)
                {
                    GV_CancelledPolicy.DataSource = dt;
                    GV_CancelledPolicy.DataBind();
                }
                else
                {
                    GV_CancelledPolicy.DataSource = dt;
                    GV_CancelledPolicy.DataBind();
                }
            }

        }
        catch (Exception ex)
        { }
    }
}