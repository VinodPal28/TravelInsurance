//-- =============================================
//-- Author:		<Vinod Pal>
//-- Create date:   <29-10-2018>
//-- Description:	<Get Status of Issued policy payment status>
//-- =============================================
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
public partial class Admin_PaymentStatus : System.Web.UI.Page
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
                bool Authenticate = bl.CheckAuthority("PaymentStatus.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                this.SearchPolicy();
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
        ds = con.ExecuteReader("Allianz_Travel", "USP_IssuedPolicyPaymentStatus", new object[] { "IssuedPolicies_PaymentStatus", "", 0, 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            GV_PaymentStatus.DataSource = ds;
            GV_PaymentStatus.DataBind();
            if (ds.Tables[1].Rows.Count > 0)
            {
                // lblCount.Text = ds.Tables[1].Rows[0]["Count"].ToString();
            }
        }
        else
        {
            GV_PaymentStatus.DataSource = ds;
            GV_PaymentStatus.DataBind();
        }

    }

    protected void GV_PaymentStatus_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_PaymentStatus.PageIndex = e.NewPageIndex;
        Bind_IssuedPolicy();
    }

    protected void GV_PaymentStatus_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "View")
            {
                GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                Label lblPolicy_No = (Label)row.FindControl("lblPolicy_No");
                ds = con.ExecuteReader("Allianz_Travel", "USP_IssuedPolicyPaymentStatus", new object[] { "View", lblPolicy_No.Text.Trim(), 0, 0 });
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

            if (e.CommandName == "PaymentReceived")
            {
                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                Label lblPolicy_No = (Label)row.FindControl("lblPolicy_No");
                ds = con.ExecuteReader("Allianz_Travel", "USP_IssuedPolicyPaymentStatus", new object[] { "PaymentReceived", lblPolicy_No.Text.Trim(), 0, 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    Bind_IssuedPolicy();
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

    protected void chkSelectAll_CheckedChanged(object sender, EventArgs e)
    {

        CheckBox ChkBoxHeader = (CheckBox)GV_PaymentStatus.HeaderRow.FindControl("chkSelectAll");

        foreach (GridViewRow row in GV_PaymentStatus.Rows)
        {
            CheckBox ChkBoxRows = (CheckBox)row.FindControl("chkSelect");
            if (ChkBoxHeader.Checked == true)
            {

                ChkBoxRows.Checked = true;
            }
            if (ChkBoxHeader.Checked == false)
            {
                ChkBoxRows.Checked = false;
            }
        }
    }

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        SearchPolicy();
    }

    private void SearchPolicy()
    {
        try
        {
            DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_SearchPolicyWise", new object[] { "Search", "", txtSearch.Text.Trim(), "" });
            if (dt.Rows.Count > 0)
            {
                GV_PaymentStatus.DataSource = dt;
                GV_PaymentStatus.DataBind();
            }
            else
            {
                GV_PaymentStatus.DataSource = dt;
                GV_PaymentStatus.DataBind();
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
        try
        {
            for (int i = 0; i < GV_PaymentStatus.Rows.Count; i++)
            {
                CheckBox checkboxdelete = ((CheckBox)GV_PaymentStatus.Rows[i].FindControl("chkSelect"));
                if (checkboxdelete.Checked == true)
                {
                    Label PolicyNo = ((Label)GV_PaymentStatus.Rows[i].FindControl("lblPolicy_No"));
                    ds = con.ExecuteReader("Allianz_Travel", "USP_IssuedPolicyPaymentStatus", new object[] { "PaymentReceived", PolicyNo.Text, 0, 0 });
                    if (ds.Tables[0].Rows.Count > 0)
                    {

                    }

                }
            }
            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMessage();", true);
            Bind_IssuedPolicy();
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