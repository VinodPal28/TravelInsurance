
//-- =============================================
//-- Author:		<JAMAL AHMAD>
//-- Create date:   <21-06-2018>
//-- Description:	<Extend policies>
//-- =============================================
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class Admin_ExtendPolicy : System.Web.UI.Page
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
                bool Authenticate = bl.CheckAuthority("ExtendPolicy.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }

            if (!IsPostBack)
            {
                this.Search();
                Bind_ExtendPolicy();
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
    protected void Bind_ExtendPolicy()
    {
        try
        {
            if (Session["PartnerCode"].ToString() != "")
            {
                ds = con.ExecuteReader("Allianz_Travel", "USP_ExtendPolicies", new object[] { "ExtendPolicies_PartnerWise", "", Session["UserId"], 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    GV_ExtendPolicy.DataSource = ds;
                    GV_ExtendPolicy.DataBind();
                }
                else
                {
                    GV_ExtendPolicy.DataSource = ds;
                    GV_ExtendPolicy.DataBind();
                }
            }
            else
            {
                ds = con.ExecuteReader("Allianz_Travel", "USP_ExtendPolicies", new object[] { "ExtendPolicies", "", 0, 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    GV_ExtendPolicy.DataSource = ds;
                    GV_ExtendPolicy.DataBind();
                }
                else
                {
                    GV_ExtendPolicy.DataSource = ds;
                    GV_ExtendPolicy.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void GV_ExtendPolicy_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_ExtendPolicy.PageIndex = e.NewPageIndex;
        Bind_ExtendPolicy();
    }

    protected void GV_ExtendPolicy_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "View")
            {
                GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                Label lblPolicy_No = (Label)row.FindControl("lblPolicy_No");
                ds = con.ExecuteReader("Allianz_Travel", "USP_ExtendPolicies", new object[] { "View", lblPolicy_No.Text.Trim(), 0, 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    CompInfo.Visible = false;
                    CustInfo.Visible = false;
                    txtPolicyNo.Text = ds.Tables[0].Rows[0]["Policy_No"].ToString();
                    txtCountry.Text = ds.Tables[0].Rows[0]["Geography_Name"].ToString();
                    txtIssueDate.Text = ds.Tables[0].Rows[0]["IssueDate"].ToString();
                    txtstartdtt.Text = ds.Tables[0].Rows[0]["Travel_Start_Date"].ToString();
                    txtEnddtt.Text = ds.Tables[0].Rows[0]["Travel_End_Date"].ToString();
                    txtPlanName.Text = ds.Tables[0].Rows[0]["Plan_Name"].ToString();
                    txtPrices.Text = ds.Tables[0].Rows[0]["TotalPrice"].ToString();
                    txtdob.Text = ds.Tables[0].Rows[0]["DOB"].ToString();

                    if (ds.Tables[0].Rows[0]["First_Name"].ToString() != "")
                    {
                        CustInfo.Visible = true;
                        txtName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                        txtNumber.Text = ds.Tables[0].Rows[0]["Contact_No"].ToString();
                        txtEmailid.Text = ds.Tables[0].Rows[0]["Email"].ToString();
                        lblPanNo.Text = ds.Tables[0].Rows[0]["Nominee_PAN"].ToString();
                        lblAadharNo.Text = ds.Tables[0].Rows[0]["Nominee_Aadhar"].ToString();
                        lblPassportNo.Text = ds.Tables[0].Rows[0]["PassportNo"].ToString();
                        lblState.Text = ds.Tables[0].Rows[0]["CustState"].ToString();
                        lblCity.Text = ds.Tables[0].Rows[0]["CustCity"].ToString();
                        lblPinCode.Text = ds.Tables[0].Rows[0]["Nominee_PIN"].ToString();
                        lblAddr.Text = ds.Tables[0].Rows[0]["Nominee_Address"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["CompanyName"].ToString() != "")
                    {
                        CompInfo.Visible = true;
                        lblCompName.Text = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                        lblGSTIN.Text = ds.Tables[0].Rows[0]["Company_GSTIN"].ToString();
                        lblCompEmailID.Text = ds.Tables[0].Rows[0]["Company_EmailId"].ToString();
                        lblCompState.Text = ds.Tables[0].Rows[0]["CompState"].ToString();
                        lblCompCity.Text = ds.Tables[0].Rows[0]["CompCity"].ToString();
                        lblCompPin.Text = ds.Tables[0].Rows[0]["Company_Pin"].ToString();
                        lblCompAddr.Text = ds.Tables[0].Rows[0]["ComapnyAddress"].ToString();
                        if (ds.Tables[1].Rows.Count > 0)
                        {
                            GV_MiceInfo.DataSource = ds.Tables[1];
                            GV_MiceInfo.DataBind();
                        }
                        else
                        {
                            GV_MiceInfo.DataSource = ds.Tables[1];
                            GV_MiceInfo.DataBind();
                        }
                    }

                    txtNomineeNames.Text = ds.Tables[0].Rows[0]["Nominee_Name"].ToString();
                    lblNomineerelations.Text = ds.Tables[0].Rows[0]["NomineeRelation"].ToString();
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
            if (Session["PartnerCode"].ToString() != "")
            {
                DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_SearchExtendPolicies", new object[] { "Search_PartnerWise", txtSearch.Text.Trim(), Session["UserId"] });
                if (dt.Rows.Count > 0)
                {
                    GV_ExtendPolicy.DataSource = dt;
                    GV_ExtendPolicy.DataBind();
                }
                else
                {
                    GV_ExtendPolicy.DataSource = dt;
                    GV_ExtendPolicy.DataBind();
                }
            }
            else
            {
                DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_SearchExtendPolicies", new object[] { "Search", txtSearch.Text.Trim(), 0 });
                if (dt.Rows.Count > 0)
                {
                    GV_ExtendPolicy.DataSource = dt;
                    GV_ExtendPolicy.DataBind();
                }
                else
                {
                    GV_ExtendPolicy.DataSource = dt;
                    GV_ExtendPolicy.DataBind();
                }
            }

        }
        catch (Exception ex)
        { }
    }
}