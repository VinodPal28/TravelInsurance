
//-- =============================================
//-- Author:		<Vinod Pal>
//-- Create date:   <18-06-2018>
//-- Description:	<get only issued policies>
//-- =============================================
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_IssuedPolicies : System.Web.UI.Page
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
                bool Authenticate = bl.CheckAuthority("IssuedPolicies.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                Div_BtnExport.Visible = false;
                this.SearchCustomers();
                Bind_IssuedPolicy();
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

    protected void Bind_IssuedPolicy()
    {
        try
        {
            if (Session["PartnerCode"].ToString() != "")
            {
                ds = con.ExecuteReader("Allianz_Travel", "USP_IssuedPolicies", new object[] { "IssuedPolicies_PartnerWise", "", Session["UserId"], 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Div_BtnExport.Visible = true;
                    GV_IssuedPolicy.DataSource = ds;
                    GV_IssuedPolicy.DataBind();
                }
                else
                {
                    GV_IssuedPolicy.DataSource = ds;
                    GV_IssuedPolicy.DataBind();
                }
            }
            else
            {
                ds = con.ExecuteReader("Allianz_Travel", "USP_IssuedPolicies", new object[] { "IssuedPolicies", "", 0, 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Div_BtnExport.Visible = true;
                    GV_IssuedPolicy.DataSource = ds;
                    GV_IssuedPolicy.DataBind();
                }
                else
                {
                    GV_IssuedPolicy.DataSource = ds;
                    GV_IssuedPolicy.DataBind();
                }
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void GV_IssuedPolicy_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        GV_IssuedPolicy.PageIndex = e.NewPageIndex;
        Bind_IssuedPolicy();
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        SearchCustomers();
    }

    private void SearchCustomers()
    {
        try
        {
            if (Session["PartnerCode"].ToString() != "")
            {
                DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_SearchIssuedPolicies", new object[] { "Search_PartnerWise", txtSearch.Text.Trim(), Session["UserId"] });
                if (dt.Rows.Count > 0)
                {
                    GV_IssuedPolicy.DataSource = dt;
                    GV_IssuedPolicy.DataBind();
                }
                else
                {
                    GV_IssuedPolicy.DataSource = dt;
                    GV_IssuedPolicy.DataBind();
                }
            }
            else
            {
                DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_SearchIssuedPolicies", new object[] { "Search", txtSearch.Text.Trim(), 0 });
                if (dt.Rows.Count > 0)
                {
                    GV_IssuedPolicy.DataSource = dt;
                    GV_IssuedPolicy.DataBind();
                }
                else
                {
                    GV_IssuedPolicy.DataSource = dt;
                    GV_IssuedPolicy.DataBind();
                }
            }

        }
        catch (Exception ex)
        { }
    }

    protected void GV_IssuedPolicy_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "View")
            {
                GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                Label lblPolicy_No = (Label)row.FindControl("lblPolicy_No");
                ds = con.ExecuteReader("Allianz_Travel", "USP_IssuedPolicies", new object[] { "View", lblPolicy_No.Text.Trim(), 0, 0 });
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
                        txtAdhar.Text = ds.Tables[0].Rows[0]["Nominee_Aadhar"].ToString();
                        txtPanNo.Text = ds.Tables[0].Rows[0]["Nominee_PAN"].ToString();
                        txtState.Text = ds.Tables[0].Rows[0]["CustState"].ToString();
                        txtCity.Text = ds.Tables[0].Rows[0]["CustCity"].ToString();
                        txtPinCode.Text = ds.Tables[0].Rows[0]["Nominee_PIN"].ToString();
                        txtAddr.Text = ds.Tables[0].Rows[0]["Nominee_Address"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["CompanyName"].ToString() != "")
                    {
                        CompInfo.Visible = true;
                        txtCompName.Text = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                        txtGSTIN.Text = ds.Tables[0].Rows[0]["Company_GSTIN"].ToString();
                        txtCompEmailID.Text = ds.Tables[0].Rows[0]["Company_EmailId"].ToString();
                        txtCompState.Text = ds.Tables[0].Rows[0]["CompState"].ToString();
                        txtCompCity.Text = ds.Tables[0].Rows[0]["CompCity"].ToString();
                        txtCompPin.Text = ds.Tables[0].Rows[0]["Company_Pin"].ToString();
                        txtCompAddr.Text = ds.Tables[0].Rows[0]["ComapnyAddress"].ToString();
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
                    txtNomineeRelation.Text = ds.Tables[0].Rows[0]["NomineeRelation"].ToString();
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

    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        try
        {
            if (Session["PartnerCode"].ToString() != "")
            {
                ds = con.ExecuteReader("Allianz_Travel", "USP_ExportIssuedPolicies", new object[] { "GET", "", 0, Session["UserId"] });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        string cardNo = BusinessLogic.QueryStringDecode(dr["Card Number"].ToString());
                        dr["Card Number"] = cardNo;
                    }
                    string FileName = "IssuedPolicies_" + DateTime.Now.ToString("dd-MM-yyyy");
                    bl.DownloadXLS(ds.Tables[0], FileName);
                }
            }
            else
            {
                ds = con.ExecuteReader("Allianz_Travel", "USP_ExportIssuedPolicies", new object[] { "GET_All", "", 0, 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (DataRow dr in ds.Tables[0].Rows)
                    {
                        string cardNo = BusinessLogic.QueryStringDecode(dr["Card Number"].ToString());
                        dr["Card Number"] = cardNo;
                    }
                    string FileName = "IssuedPolicies_" + DateTime.Now.ToString("dd-MM-yyyy");
                    bl.DownloadXLS(ds.Tables[0], FileName);
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
}