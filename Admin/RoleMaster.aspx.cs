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

public partial class Admin_RoleMaster : System.Web.UI.Page
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
                bool Authenticate = bl.CheckAuthority("Masters", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                BindRoleMaster();
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "CheckUserRole")
                {
                    CheckUserRole(Request.Params["Role"].ToString(), Convert.ToInt32(Request.Params["ID"].ToString())==0?0: Convert.ToInt32(Request.Params["ID"].ToString()));
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

    public void CheckUserRole(string Role,int Id)
    {
        string msg = "";
        DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_RoleMaster", new object[] { "SAVE", Role, Id, Session["UserId"] });
        //msg = dt.Rows.Count > 0 ? "F" : "NF";
        if(dt.Rows.Count>0)
        {
            if(dt.Rows[0]["Name"].ToString()== "EXISTS")
            {
                msg = "EXISTS";
            }
            else if (dt.Rows[0]["Name"].ToString() == "I" || dt.Rows[0]["Name"].ToString() == "UPDATE")
            {
                msg = "F";
            }
           
            else
            {
                msg = "NF";
            }
        }
        Response.Write(msg);
        Response.End();
    }
    protected void BindRoleMaster()
    {     
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_RoleMaster", new object[] { "GET", "",0,0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                GV_RoleMaster.DataSource = ds;
                GV_RoleMaster.DataBind();
            }
            else
            {
                GV_RoleMaster.DataSource = ds;
                GV_RoleMaster.DataBind();
            }
       
    }

    protected void GV_RoleMaster_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Active")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_RoleMaster.Rows[rowIndex].FindControl("lblUserId") as Label).Text);
                Button active = (GV_RoleMaster.Rows[rowIndex].FindControl("btnActive") as Button);
                ds = con.ExecuteReader("Allianz_Travel", "USP_RoleMaster", new object[] { "Active", "", Id,0 });
                active.Enabled = false;
                BindRoleMaster();
            }
            if (e.CommandName == "Deactive")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_RoleMaster.Rows[rowIndex].FindControl("lblUserId") as Label).Text);
                Button Deactive = (GV_RoleMaster.Rows[rowIndex].FindControl("btndeactive") as Button);
                ds = con.ExecuteReader("Allianz_Travel", "USP_RoleMaster", new object[] { "Deactive", "", Id, 0 });
                Deactive.Enabled = false;
                BindRoleMaster();
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

    protected void GV_RoleMaster_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_RoleMaster.PageIndex = e.NewPageIndex;
        BindRoleMaster();
    }

    protected void GV_RoleMaster_RowDataBound(object sender, GridViewRowEventArgs e)
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

    protected void GV_RoleMaster_SelectedIndexChanged(object sender, EventArgs e)
    {               
        GridViewRow row = GV_RoleMaster.SelectedRow;
        Label lblUserType = row.FindControl("lblUserType") as Label;
        txtUserType.Text = lblUserType.Text;
        Label lblUserId = row.FindControl("lblUserId") as Label;
        hdnId.Value = lblUserId.Text;
    }
}