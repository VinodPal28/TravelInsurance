using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Configuration;
using System.Drawing;

public partial class ForgotPassword : System.Web.UI.Page
{
    ConnectionToSql ConSql = new ConnectionToSql();
    BusinessLogic Bl = new BusinessLogic();
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            
        }
        if (Request.Params["method"] != null)
        {
            if (Request.Params["method"].ToString() == "SendEmail")
            {
                SendEmail(Request.Params["Email"].ToString());
            }

        }

    }
    public void SendEmail(string Email)
    {
        string msg = "";     
        dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_ForgotPassword", new object[] { Email });
        if (dt.Rows.Count > 0)
        {
            sendmail(dt.Rows[0]["Password"].ToString(), dt.Rows[0]["First_Name"].ToString(), dt.Rows[0]["EmailId"].ToString());
            msg = "F";
           
        }
        else
        {
            msg = "NF";
        }  
        Response.Write(msg);
        Response.End();      
    }
    #region Send Mail
    private void sendmail(string password, string EmployeeName, string email)
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            //string physical_path = Server.MapPath("~/mailer_internal.html");
            string strSubject = "";
            dt = ConSql.ExecuteReaderDt("Allianz_Travel", "Get_Email", new object[] { "ForgotPassword",0,0,"","","","","" });
            StringBuilder stb = new StringBuilder();
            if (dt.Rows.Count > 0)
            {
                strSubject = dt.Rows[0]["Subject"].ToString();
                stb.Append(dt.Rows[0]["Body"].ToString());
            }
            stb.Replace("[EmailId]", email);
            stb.Replace("[Name]", EmployeeName);
            string password1 = BusinessLogic.QueryStringDecode(password);
            stb.Replace("[Password]", password1);
            string myTemplate = "";
            string strTo = email;
            string strFrom = ConfigurationManager.AppSettings["frommail"].ToString();            
            Bl.sendmail(strSubject, stb.ToString(),"","", strFrom, strTo,"","");
        }
        catch
        {

        }

    }
    #endregion
    
}