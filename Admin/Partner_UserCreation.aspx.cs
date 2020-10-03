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

public partial class Admin_Partner_UserCreation : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    DataTable dt = new DataTable();
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
                bool Authenticate = bl.CheckAuthority("Partner_UserCreation.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                BindGridview();
                //bindRole();
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "CheckEMail")
                {
                    CheckEMail(Request.Params["Email"].ToString());
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
    public void CheckEMail(string Email)
    {
        string msg = "";
        DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_UserCreation", new object[] { "CheckEmail", "", "", Email, "", "", 0, 0 });
        msg = dt.Rows.Count > 0 ? "F" : "NF";
        Response.Write(msg);
        Response.End();
    }

    public void BindGridview()
    {
        DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_InsertEmpDetails", new object[] { "BindData", "","","","","","",0,0,0 });
        if (dt.Rows.Count > 0)
        {
            GV_Employee.DataSource = dt;
            GV_Employee.DataBind();
        }
        else
        {
            DataTable dt1 = new DataTable();
            GV_Employee.DataSource = dt1;
            GV_Employee.DataBind();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string ProductType = "";
            if (ddlWalletPermission.Items.Count > 0)
            {
                for (int i = 0; i < ddlWalletPermission.Items.Count; i++)
                {
                    if (ddlWalletPermission.Items[i].Selected)
                    {
                        if (ProductType == "")
                            ProductType = ddlWalletPermission.Items[i].Value;
                        else
                            ProductType += "," + ddlWalletPermission.Items[i].Value;
                    }
                }
            }
            string password = BusinessLogic.QueryStringEncode(txtPassword.Text.ToString());
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsertEmpDetails", new object[] { "INSERT", txtFname.Text.Trim(), txtLname.Text.Trim(), txtEmailid.Text.Trim(), password, txtContactno.Text, ProductType, Session["UserId"], Session["UserId"],0 });
            if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "I")
            {
                sendmail_User();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMessage();", true);
                BindGridview();
                clear();
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

    #region Send Mail
    private void sendmail_User()
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sblogo = new StringBuilder();
            string strSubject = "";
            string strTo = txtEmailid.Text.ToString();
            string strFrom = ConfigurationManager.AppSettings["frommail"].ToString();
            string password = (txtPassword.Text.ToString());
            DataSet dtvar = con.ExecuteReader("Allianz_Travel", "Get_Email", new object[] { "GET_EmailData", 0, 0, "", "", "", "", "" });
            StringBuilder stb = new StringBuilder();
            if (dtvar.Tables[0].Rows.Count > 0)
            {
                strSubject = dtvar.Tables[0].Rows[0]["Subject"].ToString();
                stb.Append(dtvar.Tables[0].Rows[0]["Body"].ToString());
            }
            stb.Replace("[User_Name]", txtFname.Text.ToString());
            stb.Replace("[Name]", txtFname.Text.ToString());
            stb.Replace("[EmailId]", txtEmailid.Text.ToString());
            stb.Replace("[Password]", password.ToString());

            string Link = ConfigurationManager.AppSettings["virtualpath"].ToString() + "Login.aspx";
            bl.sendmail(strSubject, stb.ToString(), "", "", strFrom, strTo, "", "");

        }
        catch (Exception ex)
        {

        }
    }
    #endregion

    public void clear()
    {
        txtFname.Text = "";
        txtLname.Text = "";
        ddlWalletPermission.SelectedIndex = -1;
        txtEmailid.Text = "";
        txtPassword.Text = "";
        txtContactno.Text = "";

    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        clear();
    }

    protected void GV_Employee_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_Employee.PageIndex = e.NewPageIndex;
        BindGridview();
    }

    protected void GV_Employee_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Active")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_Employee.Rows[rowIndex].FindControl("lblId") as Label).Text);
                Button active = (GV_Employee.Rows[rowIndex].FindControl("btnActive") as Button);
                dt = con.ExecuteReaderDt("Allianz_Travel", "USP_InsertEmpDetails", new object[] { "Active", "", "", "", "", "", "", 0, 0, Id });
                active.Enabled = false;
                BindGridview();
            }
            if (e.CommandName == "Deactive")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                int Id = Convert.ToInt32((GV_Employee.Rows[rowIndex].FindControl("lblId") as Label).Text);
                Button Deactive = (GV_Employee.Rows[rowIndex].FindControl("btndeactive") as Button);
                dt = con.ExecuteReaderDt("Allianz_Travel", "USP_InsertEmpDetails", new object[] { "Deactive", "", "", "", "", "", "", 0, 0, Id });
                Deactive.Enabled = false;
                BindGridview();
            }
            if (e.CommandName == "EditDetails")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                HdnEmpId.Value = Convert.ToString((GV_Employee.Rows[rowIndex].FindControl("lblId") as Label).Text);
                txt_FName.Text = Convert.ToString((GV_Employee.Rows[rowIndex].FindControl("lblFName") as Label).Text);
                txt_LName.Text = Convert.ToString((GV_Employee.Rows[rowIndex].FindControl("lblLName") as Label).Text);
                txt_EmailId.Text = Convert.ToString((GV_Employee.Rows[rowIndex].FindControl("lblEmailid") as Label).Text);
                txtMobNo.Text = Convert.ToString((GV_Employee.Rows[rowIndex].FindControl("lblContactNo") as Label).Text);
                string type = Convert.ToString((GV_Employee.Rows[rowIndex].FindControl("lblWalletPer") as Label).Text);
                for (int i = 0; i < ddl_WalletPermission.Items.Count; i++)
                {
                    foreach (string category in type.ToString().Split(','))
                    {
                        if (category != ddl_WalletPermission.Items[i].Value)
                        {
                            ddl_WalletPermission.Items[i].Selected = false;
                            continue;
                        }
                        else
                        {
                            ddl_WalletPermission.Items[i].Selected = true;
                            break;
                        }
                    }
                }
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "UserEdit();", true);
                

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

    protected void GV_Employee_RowDataBound(object sender, GridViewRowEventArgs e)
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
            string ProductType = "";
            if (ddl_WalletPermission.Items.Count > 0)
            {
                for (int i = 0; i < ddl_WalletPermission.Items.Count; i++)
                {
                    if (ddl_WalletPermission.Items[i].Selected)
                    {
                        if (ProductType == "")
                            ProductType = ddl_WalletPermission.Items[i].Value;
                        else
                            ProductType += "," + ddl_WalletPermission.Items[i].Value;
                    }
                }
            }
            
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsertEmpDetails", new object[] { "Update", txt_FName.Text.Trim(), txt_LName.Text.Trim(), txt_EmailId.Text.Trim(), "", txtMobNo.Text, ProductType, 0, 0, HdnEmpId.Value });
            if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "UPDATE")
            {               
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Update();", true);
                BindGridview();
               
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