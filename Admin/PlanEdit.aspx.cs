using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.Script.Serialization;
using System.IdentityModel;
using Microsoft.Ajax.Utilities;
using Microsoft.SqlServer.Server;
using System.Web.UI.HtmlControls;
using System.Web.Services;
using Newtonsoft.Json;

public partial class Admin_PlanEdit : System.Web.UI.Page
{
    ConnectionToSql ConSql = new ConnectionToSql();
    DataTable dt = new DataTable();
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
                bool Authenticate = bl.CheckAuthority("PlanManagement.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                if (Session["UserId"] != null && Session["UserId"].ToString() != "0")
                {
                    PlanBenefit.Visible = false;
                    BindGridview();
                    Bind_Valueaddedservices();
                    Bind_TermCondition();
                }
                else
                {
                    Response.Redirect("../Home.aspx");
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



    [WebMethod]
    public static string GetPlanDetails(string Plan_Code)
    {
        ConnectionToSql con = new ConnectionToSql();
        string result = "";
        using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PlanMgmtActive/Deactive", new object[] { "Edit", 0, Plan_Code }))
        {
            result = "F#" + ds.Tables[0].Rows[0]["Plan_Code"].ToString()+"#"+ ds.Tables[0].Rows[0]["Plan_Name"].ToString() + "#" + ds.Tables[0].Rows[0]["Value_Added_Services"].ToString() + "#" + ds.Tables[0].Rows[0]["Min_Age_Travel"].ToString() + "#" + ds.Tables[0].Rows[0]["Max_Age_Travel"].ToString() + "#" + ds.Tables[0].Rows[0]["Min_trip_Duration"].ToString() + "#" + ds.Tables[0].Rows[0]["Max_Trip_Duration"].ToString() + "#" + ds.Tables[0].Rows[0]["Trip_Detail"].ToString() + "#" + ds.Tables[0].Rows[0]["Document_Name"].ToString();
        }
        return result;
    }


    protected void Bind_Valueaddedservices()
    {
        DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "Value_AddedService", 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlValueaddedservices.DataSource = ds;
            ddlValueaddedservices.DataValueField = "id";
            ddlValueaddedservices.DataTextField = "name";
            ddlValueaddedservices.DataBind();
        }

    }
    protected void Bind_TermCondition()
    {
        try
        {
            DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_GetTermCondition", new object[] { "Get" });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlTAndC.DataSource = ds;
                ddlTAndC.DataValueField = "Document_Path";
                ddlTAndC.DataTextField = "Document_Name";
                ddlTAndC.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }
    public void BindGridview()
    {
        DataTable dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_GetPlanDetails", new object[] { });
        if (dt.Rows.Count > 0)
        {
            GV_PlanManagement.DataSource = dt;
            GV_PlanManagement.DataBind();
        }
        else
        {
            DataTable dt1 = new DataTable();
            GV_PlanManagement.DataSource = dt1;
            GV_PlanManagement.DataBind();
        }
    }
    protected void GV_PlanManagement_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_PlanManagement.PageIndex = e.NewPageIndex;
        BindGridview();
    }
    protected void GV_PlanManagement_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "ViewPrice")
            {
                GridViewRow row = (GridViewRow)(((LinkButton)e.CommandSource).NamingContainer);
                Label lblPlanCode = (Label)row.FindControl("lblPlanCode1");
                Label lblDurationBasis = (Label)row.FindControl("lblDurationBasis");
                DataTable dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_GetPlanPrice", new object[] { lblDurationBasis.Text, lblPlanCode.Text });
                if (dt.Rows.Count > 0)
                {
                    if (lblDurationBasis.Text.ToString() == "DayAgeGeo")
                    {
                        GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                        int rowIndex = gvr.RowIndex;
                        string PlanCode = (GV_PlanManagement.Rows[rowIndex].FindControl("lblPlanCode1") as Label).Text;
                        DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_PlanMgmtActive/Deactive", new object[] { "Edit", 0, PlanCode });
                        StringBuilder sb = new StringBuilder();
                        int counter = 0, j = 0;
                        if (ds.Tables[2].Rows.Count > 0)
                        {
                            for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
                            {
                                sb.Append("<tr>");
                                sb.Append("<td><strong>Geography </strong></td>");
                                foreach (DataRow dr in ds.Tables[2].Rows)
                                {
                                    i++;
                                    sb.Append("<td><label id='lblGeo" + i + "'> " + dr["Geo_Name"].ToString() + "</label></td>");
                                }
                                sb.Append("</tr>");
                            }
                            int count = ds.Tables[3].Rows.Count;
                            sb.Append("<tr class='data-dayslab'>");
                            sb.Append("<td><strong>Day/Age Slab</strong></td>");
                            int q = 0;
                            foreach (DataRow dr1 in ds.Tables[3].Rows)
                            {
                                string[] Age = dr1["Age"].ToString().Split(',');
                                int AgeCount = Age.Length / ds.Tables[2].Rows.Count;
                                for (q = 0; q < Age.Length;)
                                {
                                    sb.Append("<td>");
                                    j++;

                                    for (int k = 0; k < AgeCount; k++)
                                    {

                                        counter++;
                                        sb.Append("<input type='label' id='lblAgeSlab" + counter + "' class='form - control' value=" + Age[q] + " style='width: 60px;'>&nbsp;&nbsp;");
                                        q++;
                                    }
                                    sb.Append("</td>");
                                }
                            }

                            sb.Append("</tr>");
                            int PriceCount = 0, DayCount = 0;

                            foreach (DataRow dr2 in ds.Tables[4].Rows)
                            {

                                sb.Append("<tr class='data-dayslab'>");
                                DayCount++;
                                sb.Append("<td>");
                                sb.Append("<input type='label' id='lblMinday" + DayCount + "' class='form - control' value=" + dr2["MinDay"].ToString() + " style='width: 60px;'>&nbsp;&nbsp;");
                                sb.Append("<input type='label' id='lblMaxday" + DayCount + "'' class='form - control' value=" + dr2["MaxDay"].ToString() + " style='width: 60px;'>");
                                sb.Append("</td>");
                                int p = 0;
                                for (int l = 0; l < ds.Tables[2].Rows.Count; l++)
                                {

                                    string[] Price = dr2["Price"].ToString().Split(',');

                                    sb.Append("<td>");
                                    j++;

                                    int Count = Price.Length / ds.Tables[2].Rows.Count;
                                    for (int k = 0; k < Count; k++)
                                    {

                                        PriceCount++;
                                        sb.Append("<input type='label' id='lblPrice" + PriceCount + "' class='form - control' value=" + Price[p] + " style='width: 60px;'>&nbsp;&nbsp;");
                                        p++;
                                    }
                                    sb.Append("</td>");

                                }
                                sb.Append("</tr>");
                            }


                            maindiv.InnerHtml = Convert.ToString(sb);

                            // maindiv.Text = Convert.ToString(sb);
                        }
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowDayAgeGeo();", true);

                    }
                    if (lblDurationBasis.Text.ToString() == "MICE")
                    {
                        txtPrice.Text = dt.Rows[0]["Plan_Price"].ToString();
                        //txtNoOfmandays.Text = dt.Rows[0]["NoofManDays"].ToString();
                        txtNoOftraveller.Text = dt.Rows[0]["NoofTraveller"].ToString();
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMICE();", true);
                    }
                    if (lblDurationBasis.Text.ToString() == "PerDay")
                    {
                        txtPricePerday.Text = dt.Rows[0]["Plan_Price"].ToString();
                        txtNoOfTravellers.Text = dt.Rows[0]["NoofTraveller"].ToString();
                        ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowPerday();", true);
                    }

                }
            }
            if (e.CommandName == "Active")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_PlanManagement.Rows[rowIndex].FindControl("lblId") as Label).Text);
                Button active = (GV_PlanManagement.Rows[rowIndex].FindControl("btnActive") as Button);
                dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_PlanMgmtActive/Deactive", new object[] { "Active", Id, "" });
                active.Enabled = false;
                BindGridview();
            }
            if (e.CommandName == "Deactive")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_PlanManagement.Rows[rowIndex].FindControl("lblId") as Label).Text);
                Button Deactive = (GV_PlanManagement.Rows[rowIndex].FindControl("btndeactive") as Button);
                dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_PlanMgmtActive/Deactive", new object[] { "Deactive", Id, "" });
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

    protected void GV_PlanManagement_RowDataBound(object sender, GridViewRowEventArgs e)
    {
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



}