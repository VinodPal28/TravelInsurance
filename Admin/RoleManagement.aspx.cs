//-- =============================================
//-- Author:		<Vinod Pal>
//-- Create date:   <27-07-2018>
//-- Description:	<User can assign role of particular department>
//-- =============================================

using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_RoleManagement : System.Web.UI.Page
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
                bool Authenticate = bl.CheckAuthority("RoleManagement.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }

            if (!IsPostBack)
            {

                Bind_UserRole();
                
                // Bind_UserType();
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

    public void GridDetails()
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_RoleManagement", new object[] { "BindRole", 0, 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            GV_RoleMgmt.DataSource = ds;
            GV_RoleMgmt.DataBind();
           
        }
        else
        {
            GV_RoleMgmt.DataSource = ds;
            GV_RoleMgmt.DataBind();
        }
    }

    protected void GV_RoleMgmt_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
           // GridDetails();
           
            int created = Convert.ToInt32(ddlUserRole.SelectedValue.ToString());
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_RoleManagement", new object[] { "RoleWise", created, 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                CheckBox chkSelect = (CheckBox)e.Row.FindControl("chkSelect");
                Label lblName = (Label)e.Row.FindControl("lblName");
                if (ds.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                    {
                        if (lblName.Text == ds.Tables[0].Rows[i]["Menu_Name"].ToString())
                        {
                            chkSelect.Checked = true;
                        }
                    }
                }
            }
            else
            {
                Div_UserRole.Visible = false;
            }
        }
    }

    protected void ddlUserRole_SelectedIndexChanged(object sender, EventArgs e)
    {
        Div_UserRole.Visible = false;
        if (ddlUserRole.SelectedValue.ToString() != "0")
        {
            GridDetails();
            Div_UserRole.Visible = true;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = new DataSet();
            bool isCkecked = false;
            foreach (GridViewRow row in GV_RoleMgmt.Rows)
            {
                if (((CheckBox)row.FindControl("chkSelect")).Checked)
                {
                    isCkecked = true;
                }
            }
            if (isCkecked)
            {
                int created = Convert.ToInt32(ddlUserRole.SelectedValue.ToString());
                ds = con.ExecuteReader("Allianz_Travel", "USP_RoleManagement", new object[] { "Delete", created, 0 });
                if (ds.Tables[0].Rows.Count > 0)
                {
                    foreach (GridViewRow row in GV_RoleMgmt.Rows)
                    {
                        HiddenField hdnmodel = (HiddenField)row.FindControl("hdnmodel");
                        int modelid = Convert.ToInt32(hdnmodel.Value.ToString());
                        if (((CheckBox)row.FindControl("chkSelect")).Checked)
                        {
                            ds = con.ExecuteReader("Allianz_Travel", "USP_RoleManagement", new object[] { "Save", created, modelid });
                        }
                    }
                    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMessage();", true);
                    GridDetails();
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
}