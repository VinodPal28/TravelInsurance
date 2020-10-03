using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_Report : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Allianz_Travel"].ConnectionString);
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
                bool Authenticate = bl.CheckAuthority("Report.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                DivReport.Visible = false;
                Bind();
                PartnerWise();
            }

            if (Request.QueryString["Action"] == "SubPartner")
            {
                if (Request.QueryString["id"].ToString() != "" && Request.QueryString["id"].ToString() != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["id"].ToString());

                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Clear();
                    Response.Write(GetSubPartner(id));
                    Response.End();
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

    public void PartnerWise()
    {
        if(Session["PartnerCode"]!=null && Session["PartnerCode"].ToString()!="")
        {
            Div_PartnerName.Visible = false;
            Div_SubPartnerName.Visible = false;
        }
    }
    public string GetSubPartner(int id)
    {
        ds = con.ExecuteReader("Allianz_Travel", "USP_Report", new object[] { "Bind_SubPartner", "", "", id, 0, 0, "", 0, "" });

        System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
        Dictionary<string, object> row;
        foreach (DataRow dr in ds.Tables[0].Rows)
        {
            row = new Dictionary<string, object>();

            foreach (DataColumn col in ds.Tables[0].Columns)
            {
                row.Add(col.ColumnName, dr[col]);
            }
            rows.Add(row);
        }

        return serializer.Serialize(rows);
    }

    public void Bind()
    {
        ds = con.ExecuteReader("Allianz_Travel", "USP_Report", new object[] { "Bind_Partner", "", "", 0, 0, 0, "", 0, "" });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlPartner.DataSource = ds;
            ddlPartner.DataValueField = "ID";
            ddlPartner.DataTextField = "Partner_Name";
            ddlPartner.DataBind();
        }

        ds = con.ExecuteReader("Allianz_Travel", "USP_Report", new object[] { "Bind_PlanName", "", "", 0, 0, 0, "", 0, "" });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlPlanName.DataSource = ds;
            ddlPlanName.DataValueField = "Plan_Code";
            ddlPlanName.DataTextField = "PLAN_NAME";
            ddlPlanName.DataBind();
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            #region MultiSelection for PolicyType
            string selectPolicyType = string.Empty;
            foreach (ListItem item2 in ListPolicyType.Items)
            {
                if (item2.Selected)
                {
                    selectPolicyType += "" + item2.Value + ",";
                }
                else
                {
                    // selectedZone = ",";
                }
            }

            if (selectPolicyType == "")
            {
                selectPolicyType = null;
            }
            #endregion

            int PartnerId = 0;
            if (Session["PartnerCode"] != null && Session["PartnerCode"].ToString() != "")
            {
                PartnerId = Convert.ToInt32(Session["UserId"]);
            }
            else
            {
                PartnerId = Convert.ToInt32(ddlPartner.SelectedValue);
            }


            ds = con.ExecuteReader("Allianz_Travel", "USP_Report", new object[] { "AllData", txtFromDate.Text.Trim(), txtToDate.Text.Trim(), PartnerId, hdnSubPartnerId.Value.ToString() == "" ? "0" : hdnSubPartnerId.Value, selectPolicyType, txtpolicyNo.Text.Trim(), ddlPaymentStatus.SelectedValue.ToString()=="0"?"" : ddlPaymentStatus.SelectedValue.ToString(), ddlPlanName.SelectedValue.ToString()=="0"?"": ddlPlanName.SelectedValue.ToString() });
            if(ds.Tables[0].Rows.Count>0)
            {
                Div_Id.Visible = true;
                DivReport.Visible = true;
                GV_Report.DataSource = ds;
                GV_Report.DataBind();
                ViewState["Griddata"] = ds;

                NoOfPolicies.InnerHtml = ds.Tables[1].Rows[0]["Count"].ToString();
            }
            else
            {
                Div_Id.Visible = false;
                DivReport.Visible = true;
                GV_Report.DataSource = ds;
                GV_Report.DataBind();
            }
            ViewState["Griddata"] = ds;

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

    protected void GV_Report_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl = (Label)e.Row.FindControl("lblPolicy_Status");
            if (lbl.Text == "Issued")
            {
                lbl.CssClass = "btn btn-sm round btn-outline-danger";
            }
            if (lbl.Text == "Endorsed")
            {
                lbl.CssClass = "btn btn-sm round Endorsed";
            }
            if (lbl.Text == "Cancelled")
            {
                lbl.CssClass = "btn btn-sm round Cancelled";
            }
            if (lbl.Text == "Extend")
            {
                lbl.CssClass = "btn btn-sm round Endorsed";
            }
        }
    }

    protected void GV_Report_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_Report.PageIndex = e.NewPageIndex;
        GV_Report.DataSource = ViewState["Griddata"];
        GV_Report.DataBind();
    }

    protected void btnExportToexcel_Click(object sender, EventArgs e)
    {
        string FileName = "Report_" + DateTime.Now.ToString("dd-MM-yyyy");
        DataSet ds = (DataSet)ViewState["Griddata"];
        DataTable dt = ds.Tables[0];
        bl.DownloadXLS(dt, FileName);
    }
}