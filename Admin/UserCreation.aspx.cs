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
public partial class Admin_UserCreation : System.Web.UI.Page
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
                bool Authenticate = bl.CheckAuthority("UserCreation.aspx", Session["UserTypeId"].ToString());
                if(Authenticate==false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                
                bindRole();                           
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
        try
        {
        string msg = "";     
        DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_UserCreation", new object[] { "CheckEmail","","", Email, "","",0,0 });       
        msg = dt.Rows.Count>0 ? "F" : "NF";
        Response.Write(msg);
        Response.End();
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
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            string password = BusinessLogic.QueryStringEncode(txtPassword.Text.ToString());
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_UserCreation", new object[] { "Insert_User", txtFname.Text, txtLname.Text, txtEmailid.Text, password, txtContactno.Text, ddlRole.SelectedValue, Session["UserId"] });
            if (ds.Tables[0].Rows.Count >= 0 && ds.Tables[0].Rows[0][0].ToString().ToUpper() == "I")
            {
                DataTable dtcheck = con.ExecuteReaderDt("Allianz_Travel", "USP_UserCreation", new object[] { "GetId", "", "", "", "", "", 0, 0});
                string userId = dtcheck.Rows[0]["Id"].ToString();
                string message = "";
                foreach (ListItem item in listPartner.Items)
                {
                    if (item.Selected)
                    {
                        message = item.Value;
                        using (SqlConnection sqlcon = new SqlConnection(ConfigurationManager.ConnectionStrings["Allianz_Travel"].ConnectionString))
                        {
                            sqlcon.Open();
                            using (SqlCommand cmd = new SqlCommand())
                            {
                                cmd.Connection = sqlcon;
                                cmd.CommandType = CommandType.Text;
                                cmd.CommandText = "INSERT INTO mst_PartnerMap (UserId, PartnerCode) values (@UserId,@PartnerCode)";
                                //cmd.Parameters.AddWithValue("@schdlby", Page.User.Identity.Name.ToString());
                                if (listPartner.SelectedItem.Text != "")
                                {
                                    cmd.Parameters.AddWithValue("@PartnerCode", message);
                                }
                                else
                                {
                                    cmd.Parameters.AddWithValue("@PartnerCode", DBNull.Value);
                                }
                                cmd.Parameters.AddWithValue("@UserId", Convert.ToInt32(userId));
                                cmd.ExecuteNonQuery();

                            }
                        }
                    }
                }
                sendmail_User();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMessage();", true);
                clear();
            }
            else
            {
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "ShowMsgErr();", true);
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
    protected void bindRole()
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetUserRole", new object[] { "Get" });
        if (ds.Tables[0].Rows.Count > 0)
        {
            ddlRole.DataSource = ds;
            ddlRole.DataValueField = "RoleId";
            ddlRole.DataTextField = "Role";
            ddlRole.DataBind();
        }

        DataSet ds1 = con.ExecuteReader("Allianz_Travel", "USP_UserCreation", new object[] { "BindPartner", "","","","","",0,0 });
        if (ds1.Tables[0].Rows.Count > 0)
        {
            listPartner.DataSource = ds1;
            listPartner.DataValueField = "id";
            listPartner.DataTextField = "Partner";
            listPartner.DataBind();
        }
    }

    #region Send Mail
    private void sendmail_User()
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sblogo = new StringBuilder();
            string myTemplate = "", strSubject = "";
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
        ddlRole.SelectedIndex = 0;
        txtEmailid.Text = "";
        txtPassword.Text = "";
        txtContactno.Text = "";

    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        clear();
    }
}