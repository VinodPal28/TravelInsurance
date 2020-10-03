using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_PoliciesCancelled : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    string Policy_Number = "", CancellationNo = "";
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
                bool Authenticate = bl.CheckAuthority("PoliciesCancelled.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                Bind_PolicyCancellation();
               
                Bind_Reason();
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


    protected void Bind_PolicyCancellation()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "[USP_CancellationReq]", new object[] { });
            if (ds.Tables[0].Rows.Count > 0)
            {
                GV_PolicyCancelled.DataSource = ds;
                GV_PolicyCancelled.DataBind();

            }
            else
            {
                GV_PolicyCancelled.DataSource = ds;
                GV_PolicyCancelled.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void Bind_Reason()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetReason", new object[] { "Get_Reason" });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlReason.DataSource = ds;
                ddlReason.DataTextField = "Reason";
                ddlReason.DataValueField = "Id";
                ddlReason.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void GV_PolicyCancelled_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Approve")
            {

                GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
                Label lblPolicyNo = (Label)row.FindControl("lblPolicyNo");
                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetApproveReq", new object[] { "Policy_Approve", lblPolicyNo.Text });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    CustInfo.Visible = false;
                    CompanyInfo.Visible = false;
                    txtPolicyCanNo.Text = ds.Tables[0].Rows[0]["Cancellation_No"].ToString();
                    txtPolicyNo.Text = ds.Tables[0].Rows[0]["Policy_No"].ToString();
                    txtPolicyNo.Text = ds.Tables[0].Rows[0]["Policy_No"].ToString();
                    txtPolicyCanNo.Text = ds.Tables[0].Rows[0]["Cancellation_No"].ToString();
                    txtPolicyNumber.Text = ds.Tables[0].Rows[0]["PolicyCancellationNo"].ToString();
                    txtIssuesDate.Text = ds.Tables[0].Rows[0]["issues_dtt"].ToString();
                    txtPolicyStartdate.Text = ds.Tables[0].Rows[0]["Travel_Start_Date"].ToString();
                    txtPolicyEnddate.Text = ds.Tables[0].Rows[0]["Travel_End_Date"].ToString();
                    txtPartnerName.Text = ds.Tables[0].Rows[0]["Partner_Name"].ToString();
                    //TxtPartnerCode.Text = ds.Tables[0].Rows[0]["Partner_Code"].ToString();
                    txtTotalPrice.Text = ds.Tables[0].Rows[0]["Price"].ToString();
                    ddlReason.SelectedIndex = ddlReason.Items.IndexOf(ddlReason.Items.FindByText(ds.Tables[0].Rows[0]["Reason"].ToString()));
                    if (ds.Tables[0].Rows[0]["First_Name"].ToString() != "")
                    {
                        CustInfo.Visible = true;
                        txtFirstname.Text = ds.Tables[0].Rows[0]["First_Name"].ToString();
                        txtMiddlename.Text = ds.Tables[0].Rows[0]["Middle_Name"].ToString();
                        txtLastname.Text = ds.Tables[0].Rows[0]["Last_Name"].ToString();
                        txtContactNumber.Text = ds.Tables[0].Rows[0]["Contact_No"].ToString();
                        txtEmail.Text = ds.Tables[0].Rows[0]["Email"].ToString();                       
                        txtState.Text = ds.Tables[0].Rows[0]["Nominee_State"].ToString();
                        txtCity.Text = ds.Tables[0].Rows[0]["Nominee_City"].ToString();
                        txtPinCode.Text = ds.Tables[0].Rows[0]["Nominee_PIN"].ToString();
                        txtAadhaar.Text = ds.Tables[0].Rows[0]["Nominee_Aadhar"].ToString();
                        txtPanNo.Text = ds.Tables[0].Rows[0]["Nominee_PAN"].ToString();
                        txtNomineeAddres.Text = ds.Tables[0].Rows[0]["Nominee_Address"].ToString();
                       
                    }

                    if (ds.Tables[0].Rows[0]["CompanyName"].ToString() != "")
                    {
                        CompanyInfo.Visible = true;
                        txtCompName.Text = ds.Tables[0].Rows[0]["CompanyName"].ToString();
                        txtGSTIN.Text = ds.Tables[0].Rows[0]["Company_GSTIN"].ToString();
                        txtCompEmail.Text = ds.Tables[0].Rows[0]["Company_EmailId"].ToString();
                        txtCompAddr.Text = ds.Tables[0].Rows[0]["ComapnyAddress"].ToString();
                    }
                    txtNomineename.Text = ds.Tables[0].Rows[0]["Nominee_Name"].ToString();
                    txtNomineeRelation.Text = ds.Tables[0].Rows[0]["NomineeRelation"].ToString();
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Showage();", true);
                }
            }
           
        }
        catch (Exception ex)
        { }
    }

  

    protected void btnPolicyCancellation_Click(object sender, EventArgs e)
    {    
        try
        {       
                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PolicyCancellationApproveReq", new object[] { "Approve", txtPolicyNo.Text.Trim(), txtPolicyCanNo.Text.Trim(),"", Session["UserId"] });
                if (ds.Tables[0].Rows.Count > 0)
                {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowApprove();", true);
                // this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Approved!', 'Policy Cancellation Requests has been Approved !', 'success','rgb(245, 248, 250)');", true);
                Bind_PolicyCancellation();
                ((Admin_AdminMaster)this.Master).Notification();
            }                      
        }
        catch (Exception ex)
        {
        }
    }

    protected void btnPolicyDisapprove_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PolicyCancellationApproveReq", new object[] { "Disapprove", txtPolicyNo.Text.Trim(),txtPolicyCanNo.Text.Trim(),txtRemark.Text.Trim(),Session["UserId"] });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowDisapprove();", true);
                //this.ClientScript.RegisterStartupScript(this.GetType(), "SweetAlert", "swal('Disapproved!', 'Policy Cancellation Requests has been Disapproved !', 'success','rgb(245, 248, 250)');", true);
                Bind_PolicyCancellation();
                ((Admin_AdminMaster)this.Master).Notification();
            }
        }
        catch (Exception ex)
        {
        }
    }
}