using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Linq;

public partial class Admin_PlanManagement : System.Web.UI.Page
{
    ConnectionToSql ConSql = new ConnectionToSql();
    DataTable dt = new DataTable();
    BusinessLogic bl = new BusinessLogic();

    string PlanCode = string.Empty;
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
                    this.SearchCustomers();
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
                Label PlanName = (Label)row.FindControl("lblPlanName");
                SpanPlanName.InnerHtml = PlanName.Text;
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
                                        sb.Append("<input type='label'  readonly='true'  id='lblAgeSlab" + counter + "' class='form - control' value=" + Age[q] + " style='width: 60px;'>&nbsp;&nbsp;");
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
                                sb.Append("<input type='label' readonly='true' id='lblMinday" + DayCount + "' class='form - control' value=" + dr2["MinDay"].ToString() + " style='width: 60px;'>&nbsp;&nbsp;");
                                sb.Append("<input type='label'  readonly='true'  id='lblMaxday" + DayCount + "'' class='form - control' value=" + dr2["MaxDay"].ToString() + " style='width: 60px;'>");
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
                                        sb.Append("<input type='label'  readonly='true'  id='lblPrice" + PriceCount + "' class='form - control' value=" + Price[p] + " style='width: 60px;'>&nbsp;&nbsp;");
                                        p++;
                                    }
                                    sb.Append("</td>");

                                }
                                sb.Append("</tr>");
                            }


                            Tbody1.InnerHtml = Convert.ToString(sb);

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
            if (e.CommandName == "EditCommand")
            {
                Mice.Visible = false;
                Div_Geo.Visible = false;
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                PlanCode = (GV_PlanManagement.Rows[rowIndex].FindControl("lblPlanCode1") as Label).Text;
                DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_PlanMgmtActive/Deactive", new object[] { "Edit", 0, PlanCode });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    ViewState["DurationBasis"] = ds.Tables[0].Rows[0]["Duration_Basis"].ToString();
                    DurationBasis.Value = ds.Tables[0].Rows[0]["Duration_Basis"].ToString();
                    lblPlanCode.Text = ds.Tables[0].Rows[0]["Plan_Code"].ToString();
                    txtPlanName.Text = ds.Tables[0].Rows[0]["Plan_Name"].ToString();
                    txtMinAge.Text = ds.Tables[0].Rows[0]["Min_Age_Travel"].ToString();
                    txtMaxAge.Text = ds.Tables[0].Rows[0]["Max_Age_Travel"].ToString();
                    txtmintripDuration.Text = ds.Tables[0].Rows[0]["Min_trip_Duration"].ToString();
                    txtmaxDuration.Text = ds.Tables[0].Rows[0]["Max_Trip_Duration"].ToString();
                    ddlTAndC.SelectedIndex = ddlTAndC.Items.IndexOf(ddlTAndC.Items.FindByText(ds.Tables[0].Rows[0]["Document_Name"].ToString()));
                    string tripType = ds.Tables[0].Rows[0]["Trip_Detail"].ToString();
                    if (tripType == "OneWay")
                        RdbValidFor.Items[0].Selected = true;
                    else if (tripType == "Round")
                        RdbValidFor.Items[1].Selected = true;
                    if (ds.Tables[0].Rows[0]["Value_Added_Services"].ToString() != "")
                    {
                        string VAS = ds.Tables[0].Rows[0]["Value_Added_Services"].ToString();
                        for (int i = 0; i < ddlValueaddedservices.Items.Count; i++)
                        {
                            foreach (string category in VAS.ToString().Split(','))
                            {
                                if (category != ddlValueaddedservices.Items[i].Text)
                                {
                                    ddlValueaddedservices.Items[i].Selected = false;
                                    continue;
                                }
                                else
                                {
                                    ddlValueaddedservices.Items[i].Selected = true;
                                    break;
                                }
                            }
                        }
                    }
                    if (ds.Tables[1].Rows.Count > 0)
                    {
                        PlanBenefit.Visible = true;
                        GV_PlanBenefits.DataSource = ds.Tables[1];
                        GV_PlanBenefits.DataBind();
                    }
                    else
                    {
                        PlanBenefit.Visible = false;
                        GV_PlanBenefits.DataSource = ds.Tables[1];
                        GV_PlanBenefits.DataBind();
                    }
                    if (ds.Tables[0].Rows[0]["Duration_Basis"].ToString() == "MICE" || ds.Tables[0].Rows[0]["Duration_Basis"].ToString() == "PerDay")
                    {
                        Mice.Visible = true;
                        txttraveller.Text = ds.Tables[0].Rows[0]["NoofTraveller"].ToString();
                        txtMICEprice.Text = ds.Tables[0].Rows[0]["Plan_Price"].ToString();
                    }
                    if (ds.Tables[0].Rows[0]["Duration_Basis"].ToString() == "DayAgeGeo")
                    {
                        Div_Geo.Visible = true;
                        StringBuilder sb = new StringBuilder();
                        int counter = 0, j = 0;
                        if (ds.Tables[2].Rows.Count > 0)
                        {
                            hdnGeoCount.Value = ds.Tables[2].Rows.Count.ToString();
                            for (int i = 0; i < ds.Tables[2].Rows.Count; i++)
                            {
                                sb.Append("<tr>");
                                sb.Append("<td><strong>Geography </strong></td>");
                                foreach (DataRow dr in ds.Tables[2].Rows)
                                {
                                    i++;
                                    //sb.Append("<td><label runat='server' name='lblGeo" + i + "' id='lblGeo" + i + "'> " + dr["Geo_Name"].ToString() + "</label></td>");
                                    sb.Append("<td><input type='label' runat='server' readonly='true' name='lblGeo" + i + "' id='lblGeo" + i + "' class='form - control' value='" + dr["Geo_Name"].ToString() + "' ></td>");
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
                                hdnAgeCount.Value = Convert.ToString(AgeCount);
                                for (q = 0; q < Age.Length;)
                                {
                                    sb.Append("<td>");
                                    j++;

                                    for (int k = 0; k < AgeCount; k++)
                                    {
                                        counter++;
                                        sb.Append("<input type='label' readonly='true' runat='server' name='txtAgeSlab" + counter + "' id='txtAgeSlab" + counter + "' class='form - control' value=" + Age[q] + " style='width: 60px;'>&nbsp;&nbsp;");
                                        q++;
                                    }
                                    sb.Append("</td>");
                                }
                            }

                            sb.Append("</tr>");
                            int PriceCount = 0, DayCount = 0;
                            hdnPriceRowCount.Value = ds.Tables[4].Rows.Count.ToString();
                            foreach (DataRow dr2 in ds.Tables[4].Rows)
                            {
                                sb.Append("<tr class='data-dayslab'>");
                                DayCount++;
                                sb.Append("<td>");
                                sb.Append("<input type='label' readonly='true' runat='server' maxlength='3' name='txtMinday" + DayCount + "' id='txtMinday" + DayCount + "' class='form - control' value=" + dr2["MinDay"].ToString() + " style='width: 60px;'>&nbsp;&nbsp;");
                                sb.Append("<input type='label' readonly='true' runat='server' maxlength='3' name='txtMaxday" + DayCount + "'' id='txtMaxday" + DayCount + "'' class='form - control' value=" + dr2["MaxDay"].ToString() + " style='width: 60px;'>");
                                sb.Append("</td>");
                                int p = 0;
                                for (int l = 0; l < ds.Tables[2].Rows.Count; l++)
                                {
                                    string[] Price = dr2["Price"].ToString().Split(',');
                                    sb.Append("<td>");
                                    j++;

                                    int Count = Price.Length / ds.Tables[2].Rows.Count;
                                    hdnRowCount.Value = count.ToString();
                                    for (int k = 0; k < Count; k++)
                                    {
                                        PriceCount++;
                                        sb.Append("<input type='text' runat='server' name='txtPrice" + PriceCount + "' id='txtPrice" + PriceCount + "' class='ValidatePrice' maxlength='10' value=" + Price[p] + " style='width: 60px;'>&nbsp;&nbsp;");
                                        p++;
                                    }
                                    sb.Append("</td>");
                                }
                                sb.Append("</tr>");
                            }
                            maindiv.InnerHtml = Convert.ToString(sb);
                        }
                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Edit();", true);
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
    protected void btnSub_Click(object sender, EventArgs e)
    {
        save();
        BindGridview();
    }
    public void save()
    {
        try
        {
            string selectedItem = "";
            if (ddlValueaddedservices.Items.Count > 0)
            {
                for (int i = 0; i < ddlValueaddedservices.Items.Count; i++)
                {
                    if (ddlValueaddedservices.Items[i].Selected)
                    {
                        if (selectedItem == "")
                            selectedItem = ddlValueaddedservices.Items[i].Text;
                        else
                            selectedItem += "," + ddlValueaddedservices.Items[i].Text;
                    }
                }
            }

            DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_UpdatePlanDetails", new object[] { "UPDATE", 0, lblPlanCode.Text.Trim(), txtPlanName.Text.Trim(), selectedItem.Trim(), txtMinAge.Text.Trim(), txtMaxAge.Text.Trim(), txtmintripDuration.Text.Trim(), txtmaxDuration.Text.Trim(), RdbValidFor.SelectedValue, ddlTAndC.SelectedValue, Session["UserId"],"","" });
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataSet ds1 = ConSql.ExecuteReader("Allianz_Travel", "USP_UpdateBenefitDetails", new object[] { "DELETE", 0, lblPlanCode.Text.Trim(), "", "", "", "", "", "", 0 });
                if (ds1.Tables[0].Rows.Count > 0 && ds1.Tables[0].Rows[0]["NAME"].ToString() != "NA")
                {
                    int index = 0;
                    foreach (GridViewRow row in GV_PlanBenefits.Rows)
                    {
                        if (row.RowType == DataControlRowType.DataRow)
                        {
                            HiddenField PlanCode = GV_PlanBenefits.Rows[index].FindControl("hdnPlanCode") as HiddenField;
                            HiddenField BenefitType = GV_PlanBenefits.Rows[index].FindControl("hdnBenefitType") as HiddenField;
                            HiddenField CreatedBy = GV_PlanBenefits.Rows[index].FindControl("hdnCreatedBy") as HiddenField;
                            HiddenField CtreatedDate = GV_PlanBenefits.Rows[index].FindControl("hdnCreatedDate") as HiddenField;
                            TextBox BenefitName = GV_PlanBenefits.Rows[index].FindControl("txtBenifitName") as TextBox;
                            TextBox SumInsured = GV_PlanBenefits.Rows[index].FindControl("txtSumInsured") as TextBox;
                            TextBox Deductible = GV_PlanBenefits.Rows[index].FindControl("txtDeductible") as TextBox;
                            DataSet ds2 = ConSql.ExecuteReader("Allianz_Travel", "USP_UpdateBenefitDetails", new object[] { "UPDATE", 0, PlanCode.Value, BenefitName.Text.Trim(), SumInsured.Text.Trim(), Deductible.Text.Trim(), BenefitType.Value, CreatedBy.Value, CtreatedDate.Value, Session["UserId"] });
                        }
                        index++;
                    }

                }
                if (ViewState["DurationBasis"].ToString() == "DayAgeGeo")
                {
                    int PriceCount = 1, RowCount = 1;
                    for (int pricerow = 1; pricerow <= Convert.ToInt32(hdnPriceRowCount.Value); pricerow++)
                    {
                        int AgeCount = 1;
                        for (int a = 1; a <= Convert.ToInt32(hdnGeoCount.Value); a++)
                        {
                            for (int ageprice = 1; ageprice <= Convert.ToInt32(hdnAgeCount.Value); ageprice++)
                            {
                                string GeoName = Request.Form["lblGeo" + a];
                                string Age = Request.Form["txtAgeSlab" + AgeCount];
                                string[] GeoAge = Age.Split('-');
                                string MinAge = GeoAge[0].ToString();
                                string MaxAge = GeoAge[1].ToString();

                                string minDay = Request.Form["txtMinday" + RowCount];
                                string MaxDay = Request.Form["txtMaxday" + RowCount];
                                string price = Request.Form["txtPrice" + PriceCount];

                                DataSet ds2 = ConSql.ExecuteReader("Allianz_Travel", "USP_UpdatePlanPrice", new object[] { "UPDATE", lblPlanCode.Text.Trim(), GeoName, MinAge.Trim(), MaxAge.Trim(), minDay.Trim(), MaxDay.Trim(), price.Trim(), Session["UserId"] });
                                PriceCount++;
                                AgeCount++;
                            }

                        }
                        RowCount++;
                    }
                }
                if (ViewState["DurationBasis"].ToString() == "PerDay" || ViewState["DurationBasis"].ToString() == "MICE")
                {
                    DataSet ds3 = ConSql.ExecuteReader("Allianz_Travel", "USP_UpdatePlanDetails", new object[] { "UpdateMicePrice", 0, lblPlanCode.Text.Trim(), "", "", "", "", "", "","", "", Session["UserId"], txtMICEprice.Text.Trim(), txttraveller.Text.Trim() });
                    if(ds3.Tables[0].Rows.Count>0)
                    { }
                }
                BindGridview();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "UpdateMsg();", true);
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


    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        SearchCustomers();
    }

    private void SearchCustomers()
    {
        try
        {
            DataTable dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_SearchPlanName", new object[] { "Search", "", txtSearch.Text.Trim() });
            if (dt.Rows.Count > 0)
            {
                GV_PlanManagement.DataSource = dt;
                GV_PlanManagement.DataBind();
            }
            else
            {
                GV_PlanManagement.DataSource = dt;
                GV_PlanManagement.DataBind();
            }

        }
        catch (Exception ex)
        { }
    }
}