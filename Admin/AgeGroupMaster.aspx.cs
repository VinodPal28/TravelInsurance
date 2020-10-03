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
public partial class AgeGroupMaster : System.Web.UI.Page
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
                Bind_Gv_AgeGroup();
                Clear();
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "GetMinAgeGroup")
                {
                    AgeGroup( Request.Params["MinAgeGroup"].ToString(), Request.Params["MaxAgeGroup"].ToString());
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

    public void AgeGroup(string MinAgeGroup,string MaxAgeGroup)
    {
        try
        {
            string msg = "";
            string Age = MinAgeGroup + "-" + MaxAgeGroup;
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_AgeGroup", new object[] { "CheckAge", 0, Age, 0,0, "" });
            if (ds.Tables[0].Rows.Count > 0)
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
        { }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string Age = txtAgeGrouop.Text.Trim() + "-" + txtmaxagegroup.Text.Trim();
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_AgeGroup", new object[] { "Insert_AgeGroup", HiddenField_ID.Value.Trim(), Age, 0, Session["UserId"], txtAgeGroupName.Text.Trim() });
            if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "I")
            {
                Bind_Gv_AgeGroup();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMsg();", true);
                Clear();
            }
            else if(ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "NF")
            {
                div_btn.Visible = false;
                lblExceded.Text = "Can not insert more than 3 records !";
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
        //  Inset_AgeGroup("Insert_AgeGroup");
    }

    

    protected void Clear()
    {
        txtAgeGroupName.Text = "";
        txtAgeGrouop.Text = "";
        txtmaxagegroup.Text = "";
        HiddenField_ID.Value = "0";
    }
    protected void Bind_Gv_AgeGroup()
    {

        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_AgeGroup", new object[] { "Get_AgeGroup", 0, "", 0, Session["UserId"], "" });
            if (ds.Tables[0].Rows.Count >= 0)
            {
                GV_AgeGroup.DataSource = ds;
                GV_AgeGroup.DataBind();
            }
            else
            {
                GV_AgeGroup.DataSource = ds;
                GV_AgeGroup.DataBind();
            }
        }
        catch (Exception ex)
        {

        }

    }

    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
        GridViewRow row = GV_AgeGroup.SelectedRow;
        Label AgeGrouop = row.FindControl("lblAge_Group") as Label;

        string[] arr = new string[2];
        arr = AgeGrouop.Text.Split('-');
        txtAgeGrouop.Text = arr[0];
        txtmaxagegroup.Text = arr[1];
        Label lblAge_id = row.FindControl("lblAge_id") as Label;
        HiddenField_ID.Value = lblAge_id.Text;
        Label AgeGrouopName = row.FindControl("lblAgeGroupName") as Label;
        txtAgeGroupName.Text = AgeGrouopName.Text;
        Bind_Gv_AgeGroup();
        lblExceded.Text = "";
        div_btn.Visible = true;
    }

    protected void GV_TaxSlab_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_AgeGroup.PageIndex = e.NewPageIndex;

        Bind_Gv_AgeGroup();
    }

    protected void GV_AgeGroup_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Active")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblAge_id = (GV_AgeGroup.Rows[rowIndex].FindControl("lblAge_id") as Label).Text;
            Button Active = (GV_AgeGroup.Rows[rowIndex].FindControl("btnActive") as Button);


            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_AgeGroup", new object[] { "Active", lblAge_id.Trim(), "", 0, Session["UserId"], "" });

            Bind_Gv_AgeGroup();
        }
        if (e.CommandName == "Deactive")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblAge_id = (GV_AgeGroup.Rows[rowIndex].FindControl("lblAge_id") as Label).Text;
            Button Deactive = (GV_AgeGroup.Rows[rowIndex].FindControl("btndactive") as Button);

            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_AgeGroup", new object[] { "Deactive", lblAge_id.Trim(), "", 0, Session["UserId"], "" });
            Bind_Gv_AgeGroup();
        }
    }

    protected void GV_AgeGroup_RowDataBound(object sender, GridViewRowEventArgs e)
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

    protected void btnReset_Click(object sender, EventArgs e)
    {
        Clear();
    }
}