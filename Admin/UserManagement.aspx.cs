
//-- =============================================
//-- Author:		<Vinod Pal>
//-- Create date:   <15-06-2018>
//-- Description:	<authorized user can take action on user profile>
//-- =============================================

using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_UserManagement : System.Web.UI.Page
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
                bool Authenticate = bl.CheckAuthority("UserManagement.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "CheckEMail")
                {
                    CheckEMail(Request.Params["Email"].ToString());
                }

            }
            if (!IsPostBack)
            {
                this.Search();
                Bind_UserRole();
                Bind_UserType();
                Div_UserRole.Visible = false;

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

    public void CheckEMail(string Email)
    {
        string msg = "";
        DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_ManageUserEdit", new object[] { "CheckEmailId", "", "", Email,"",0, 0, 0 });
        msg = dt.Rows.Count > 0 ? "F" : "NF";
        Response.Write(msg);
        Response.End();
    }
    protected void Bind_UserRole()
    {

        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ManageUser", new object[] { "Get_UserRole", 0, 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlUserRole.DataSource = ds;
            ddlUserRole.DataTextField = "UserType";
            ddlUserRole.DataValueField = "UserTypeId";
            ddlUserRole.DataBind();
        }
    }

    protected void Bind_UserType()
    {

        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ManageUser", new object[] { "Get_UserTpe", 0, 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlUserType.DataSource = ds;
            ddlUserType.DataTextField = "UserType";
            ddlUserType.DataValueField = "UserTypeId";
            ddlUserType.DataBind();
        }
    }

    protected void ddlUserRole_SelectedIndexChanged(object sender, EventArgs e)
    {

        Div_UserRole.Visible = true;
        if (ddlUserRole.SelectedValue!="0")
        {
            GridDetails();
        }
        else
        {
            Div_UserRole.Visible = false;
        }
        
    }
    public void GridDetails()
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ManageUser", new object[] { "Get_SelectedUser", ddlUserRole.SelectedValue, 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            GV_ManageUser.DataSource = ds;
            GV_ManageUser.DataBind();
        }
        else
        {
            GV_ManageUser.DataSource = ds;
            GV_ManageUser.DataBind();
        }
    }

    protected void GV_ManageUser_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        GV_ManageUser.PageIndex = e.NewPageIndex;
        GridDetails();
    }

    protected void GV_ManageUser_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Active")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_ManageUser.Rows[rowIndex].FindControl("lblId") as Label).Text);
                Button active = (GV_ManageUser.Rows[rowIndex].FindControl("btnActive") as Button);
                ds = con.ExecuteReader("Allianz_Travel", "USP_ManageUser", new object[] { "Active", ddlUserRole.SelectedValue, Id });
                active.Enabled = false;
                GridDetails();

            }
            else if (e.CommandName == "Deactive")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_ManageUser.Rows[rowIndex].FindControl("lblId") as Label).Text);
                Button Deactive = (GV_ManageUser.Rows[rowIndex].FindControl("btndeactive") as Button);
                ds = con.ExecuteReader("Allianz_Travel", "USP_ManageUser", new object[] { "Deactive", ddlUserRole.SelectedValue, Id });
                Deactive.Enabled = false;
                GridDetails();
            }
            else if (e.CommandName == "EditDetails")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                txtId.Text = (GV_ManageUser.Rows[rowIndex].FindControl("lblId") as Label).Text;
                txtFName.Text = (GV_ManageUser.Rows[rowIndex].FindControl("lblFname") as Label).Text;
                txtLName.Text = (GV_ManageUser.Rows[rowIndex].FindControl("lblLname") as Label).Text;
                txtEmailId.Text = (GV_ManageUser.Rows[rowIndex].FindControl("lblEmailId") as Label).Text;
                txtMobNo.Text = (GV_ManageUser.Rows[rowIndex].FindControl("lblContactNo") as Label).Text;
                //string UserRole = (GV_ManageUser.Rows[rowIndex].FindControl("lblUserType") as Label).Text;
                //ddlUserType.Items.FindByValue(UserRole).Selected = true;
                 ddlUserType.SelectedIndex = ddlUserType.Items.IndexOf(ddlUserType.Items.FindByText((GV_ManageUser.Rows[rowIndex].FindControl("lblUserType") as Label).Text));

                if (txtLName.Text=="")
                {
                    Div_LName.Visible = false;
                    Div_Role.Visible = false;
                }
                else
                {
                    Div_LName.Visible = true;
                    Div_Role.Visible = true;
                }
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Edit();", true);

            }
            else if (e.CommandName == "DeleteDetails")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_ManageUser.Rows[rowIndex].FindControl("lblId") as Label).Text);              
                ds = con.ExecuteReader("Allianz_Travel", "USP_ManageUser", new object[] { "Delete", ddlUserRole.SelectedValue, Id });              
                GridDetails();
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

    protected void GV_ManageUser_RowDataBound(object sender, GridViewRowEventArgs e)
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
        try
        {
            ds = con.ExecuteReader("Allianz_Travel", "USP_ManageUserEdit", new object[] { "UpdateUserDetails",txtFName.Text.Trim(),txtLName.Text.Trim(),txtEmailId.Text.Trim(),txtMobNo.Text.Trim(),ddlUserType.SelectedValue,ddlUserRole.SelectedValue,txtId.Text.Trim()});
            if(ds.Tables[0].Rows.Count>0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Updated();", true);
                GridDetails();
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

    protected void txtSearch_TextChanged(object sender, EventArgs e)
    {
        Search();
    }

    private void Search()
    {
        try
        {
            DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_ManageUserSearch", new object[] { "GetDetails",txtSearch.Text.Trim(),ddlUserRole.SelectedValue,0 });
            if (dt.Rows.Count > 0)
            {
                GV_ManageUser.DataSource = dt;
                GV_ManageUser.DataBind();
            }
            else
            {
                GV_ManageUser.DataSource = dt;
                GV_ManageUser.DataBind();
            }

        }
        catch (Exception ex)
        { }
    }

    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ManageUser_Export", new object[] { "ExportTOExcel", ddlUserRole.SelectedValue, 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                string FileName = "UserDetails_" + DateTime.Now.ToString("dd-MM-yyyy");
                bl.DownloadXLS(ds.Tables[0], FileName);
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