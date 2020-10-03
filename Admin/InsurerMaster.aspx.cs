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
using System.IO;
public partial class Admin_InsurerMaster : System.Web.UI.Page
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
                bind_Home_State();
                //bind_InsurerName();
                bind_Insureremaster();
                txtIsurercode.Enabled = true;
                txtIsurercode.CssClass = "form-control";
            }
           
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "InsurerCode")
                {
                    InsurerCode(Request.Params["InsurCode"].ToString());
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
    public void InsurerCode(string InsurCode)
    {

        try
        {
            string msg = "";
            DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_InsurerMaster", new object[] { "CheckInsurereCode", "", InsurCode, "", Session["UserId"], 0 ,0});
            if (dt.Rows.Count > 0)
            {
                msg = "F";
            }
            else
            {
                msg = "NF";
            }
            Response.Write(msg);
            Response.End();
        }
        catch (Exception ex)
        {

        }
    }
    protected void bind_Home_State()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "Get_Home_State",0 });

            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlhomestate.DataSource = ds;
                ddlhomestate.DataValueField = "id_state";
                ddlhomestate.DataTextField = "name";
                ddlhomestate.DataBind();
            }
        }
        catch (Exception ex)
        { }
    }
    
    protected void btnsubmit_Click(object sender, EventArgs e)
    {
        Submit_Details("Insert_InsurereMaster");
        bind_Insureremaster();
        //txtIsurercode.Enabled = true;
        //txtIsurercode.CssClass = "form-control";
    }

    protected void Submit_Details(string Option)
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsurerMaster", new object[] { Option, txtInsurername.Text.Trim(), txtIsurercode.Text.Trim(), ddlhomestate.SelectedItem.Text, Session["UserId"], 0,txtID.Text.Trim()==""?"0": txtID.Text.Trim() });
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
       
        ddlhomestate.SelectedIndex = 0;
        txtInsurername.Text = "";
        txtIsurercode.Text = "";
    }

    protected void bind_Insureremaster()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsurerMaster", new object[] { "Get_Insurere", "", "", "", Session["UserId"], 0 ,0});
            if (ds.Tables[0].Rows.Count > 0)
            {

                GV_Insured.DataSource = ds;
                GV_Insured.DataBind();

            }
            else
            {
                GV_Insured.DataSource = ds;
                GV_Insured.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }

    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {                  
        GridViewRow row = GV_Insured.SelectedRow;
        Label lblId = row.FindControl("lblId") as Label;
        txtID.Text = lblId.Text;
        Label lblcode = row.FindControl("lblInsuredcode") as Label;
        txtIsurercode.Text = lblcode.Text;
        Label lblname = row.FindControl("lblInsuredname") as Label;
        txtInsurername.Text = lblname.Text;
        Label lblsate = row.FindControl("lblHome_State") as Label;
        ddlhomestate.SelectedIndex = ddlhomestate.Items.IndexOf(ddlhomestate.Items.FindByText(lblsate.Text.ToString()));
        //txtInsurername.Text = (row.FindControl("Insurer_Name") as Label).Text; //row.Cells["Insured Name"].Text;
        //string ddlstate = (row.FindControl("lblHome_State") as Label).Text;//row.Cells[2].Text; //(row.FindControl("lblHome_State") as Label).Text;
        //ddlhomestate.SelectedIndex = ddlhomestate.Items.IndexOf(ddlhomestate.Items.FindByText(ddlstate));

       // txtIsurercode.Enabled = false;
       // txtIsurercode.CssClass = "form-control";
    }
    protected void btnreset_Click(object sender, EventArgs e)
    {
        txtIsurercode.Enabled = true;
        txtIsurercode.CssClass = "form-control";
        Clear();
    }

    protected void GV_Insured_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_Insured.PageIndex = e.NewPageIndex;

        bind_Insureremaster();
    }

    protected void GV_Insured_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Active")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                string lbl_ID = (GV_Insured.Rows[rowIndex].FindControl("lbl_ID") as Label).Text;
                Button Active = (GV_Insured.Rows[rowIndex].FindControl("btnActive") as Button);

                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsurerMaster", new object[] { "Get_Active", "", lbl_ID, "", Session["UserId"], 0,0 });
                
                bind_Insureremaster();

            }
            if (e.CommandName == "Deactive")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                string lbl_ID = (GV_Insured.Rows[rowIndex].FindControl("lbl_ID") as Label).Text;
                Button Deactive = (GV_Insured.Rows[rowIndex].FindControl("btndactive") as Button);

                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsurerMaster", new object[] { "Get_Deactive", "", lbl_ID, "", Session["UserId"], 0 ,0});
               
                bind_Insureremaster();
            }
        }
        catch (Exception ex) { }
    }

    protected void GV_Insured_RowDataBound(object sender, GridViewRowEventArgs e)
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




}