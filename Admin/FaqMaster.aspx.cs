using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using System.Drawing;
using System.Data;
using System.Data.SqlClient;

public partial class Admin_FaqMaster : System.Web.UI.Page
{
    ConnectionToSql ConSql = new ConnectionToSql();
    DataSet ds = new DataSet();
    BusinessLogic bl = new BusinessLogic();
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
                    BindGridview();
                }
                else
                {
                    Response.Redirect("../Home.aspx");
                }
            }
            if (Request.QueryString["Success"] != null)
            {
                if (Request.QueryString["Success"].ToString() == "true")
                {
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMessage();", true);
                }               
            }
            btnSubmit.Attributes.Add("onclick", "return validateBanner();");

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

    public void BindGridview()
    {
        DataTable dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_FAQ", new object[] { "Bind", "", "", "", 0, 0 });
        if (dt.Rows.Count > 0)
        {
            GV_FAQ.DataSource = dt;
            GV_FAQ.DataBind();
        }
        else
        {
            DataTable dt1 = new DataTable();
            GV_FAQ.DataSource = dt1;
            GV_FAQ.DataBind();
        }
    }
    protected void clear()
    {
        //txtScectiontype.Text = "";
        txtQuestion.Text = "";
        // txtAnswer.Text = "";
        txtEditor.Value = "0";
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int id = Id.Value=="" ? 0: Convert.ToInt32(Id.Value);
            // ds = ConSql.ExecuteReader("Allianz_Travel", "USP_FAQ", new object[] { "INSERT", "", txtQuestion.Text.ToString(), txtAnswer.Text.ToString(), Session["UserId"], id });
            ds = ConSql.ExecuteReader("Allianz_Travel", "USP_FAQ", new object[] { "INSERT", "", txtQuestion.Text.ToString(), hdntext.Value.ToString(), Session["UserId"], id });
            if (ds.Tables[0].Rows.Count > 0)
            {
                clear();
                BindGridview();
                Response.Redirect("~/Admin/FaqMaster.aspx?success=true");
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMessage();", true);

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

    protected void GV_FAQ_RowDataBound(object sender, GridViewRowEventArgs e)
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

    protected void GV_FAQ_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Active")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_FAQ.Rows[rowIndex].FindControl("hdnId") as HiddenField).Value);
                Button active = (GV_FAQ.Rows[rowIndex].FindControl("btnActive") as Button);
                ds = ConSql.ExecuteReader("Allianz_Travel", "USP_FAQ", new object[] { "Active", "", "", "", 0, Id });
                active.Enabled = false;
                BindGridview();
            }
            if (e.CommandName == "Deactive")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_FAQ.Rows[rowIndex].FindControl("hdnId") as HiddenField).Value);
                Button Deactive = (GV_FAQ.Rows[rowIndex].FindControl("btndeactive") as Button);
                ds = ConSql.ExecuteReader("Allianz_Travel", "USP_FAQ", new object[] { "Deactive", "", "", "", 0, Id });
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

    protected void GV_FAQ_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_FAQ.PageIndex = e.NewPageIndex;
        BindGridview();
    }

    protected void GV_FAQ_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            GridViewRow row = GV_FAQ.SelectedRow;
            HiddenField ID = row.FindControl("hdnId") as HiddenField;
            Id.Value = ID.Value;

            Label lblQuestions = row.FindControl("lblQuestions") as Label;
            txtQuestion.Text = lblQuestions.Text;

            Label lblAnswers = row.FindControl("lblAnswers") as Label;
            // txtAnswer.Text = lblAnswers.Text;
            hdntext.Value = lblAnswers.Text;

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
}