using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
using System.Text;
using System.Drawing;
using System.Web.Services;
using System.Data.SqlTypes;
using System.Web.Script.Serialization;
using Newtonsoft.Json;
using System.Net;

public partial class Customer_VAS : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Allianz_Travel"].ConnectionString);
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {

            if (!IsPostBack)
            {
                VAS1.Visible = true;
                Bind_Drop();
                if (Request.QueryString["PolicyNumber"] != null)
                {
                    string PolicyNo = BusinessLogic.QueryStringDecode(Request.QueryString["PolicyNumber"].ToString());
                    Get_VASdetails(PolicyNo);
                    abc(PolicyNo);
                }
            }

            //Tracker Info Save Data
            if (Request.QueryString["Action"] == "SaveData")
            {
                if (Request.QueryString["lb"] != "" && Request.QueryString["lb"] != null)
                {
                    string empdata = Request.QueryString["lb"];
                    string PolNo = Request.QueryString["PolicyNo"];
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Clear();
                    Response.Write(SaveData(empdata, PolNo));
                    Response.End();
                }
            }
            //All VAS Info Save Data
            if (Request.QueryString["Action"] == "SaveData2")
            {
                if (Request.QueryString["lb"] != "" && Request.QueryString["lb"] != null)
                {
                    string empdata = Request.QueryString["lb"];
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Clear();
                    Response.Write(SaveData2(empdata));
                    Response.End();
                }
            }


            if (Request.QueryString["Action"] == "PostDetail")
            {
                if (Request.QueryString["id"].ToString() != "" && Request.QueryString["id"].ToString() != null)
                {
                    int id = Convert.ToInt32(Request.QueryString["id"].ToString());
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Clear();
                    Response.Write(Get_RegYear(id));
                    Response.End();
                }

            }
            //VAS All Info Road Side Assistance 
            if (Request.QueryString["Action"] == "SaveRoadSide")
            {
                if (Request.QueryString["RS"].ToString() != "" && Request.QueryString["RS"].ToString() != null)
                {
                    string RSAID = Request.QueryString["RS"].ToString();
                    string PolNo = Request.QueryString["PolicyNo"];
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Clear();
                    Response.Write(SaveDataRoadSide(RSAID, PolNo));
                    Response.End();
                }

            }

            if (Request.QueryString["Action"] == "Country1" || Request.QueryString["Action"] == "Country2" || Request.QueryString["Action"] == "Country3")
            {
                if (Request.QueryString["id"].ToString() != "" && Request.QueryString["id"].ToString() != null)
                {
                    string CountryCode = Request.QueryString["id"].ToString();

                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Clear();
                    Response.Write(GetCity(CountryCode));
                    Response.End();
                }

            }
        }
        catch (SqlException ex)
        {
            // lblerrorMsg.Text = "Error occured : " + ex.Message.ToString();
        }
        catch (Exception ex)
        {
            //  lblerrorMsg.Text = "Error occured : " + ex.Message.ToString();
        }
    }

    public string GetCity(string CountryCode)
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_VASCountryMaster", new object[] { "Get_City", CountryCode });

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

    #region
    public void Get_VASdetails(string PolicyNo)
    {

        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_CustomerVAS", new object[] { "Get_VASdetails", 0, PolicyNo, "", "", "", SqlDateTime.Null, SqlDateTime.Null, "", "", "", "", "", "", "", "", "", "", "", "", "", 0, 0, SqlDateTime.Null, 0, SqlDateTime.Null });
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[0].Rows[0]["Name"].ToString() == "EXIST")
            {

                Response.Redirect("~/VASAlert.aspx?Id=" + 1);
            }
            else if (ds.Tables[0].Rows[0]["Name"].ToString() == "NF")
            {

                Response.Redirect("~/VASAlert.aspx?Id=" + 3);
            }
            else if (ds.Tables[0].Rows[0]["Name"].ToString() == "TRAVELSTARTED")
            {

                Response.Redirect("~/VASAlert.aspx?Id=" + 4);
            }
            else
            {

                txtPolicyNo.Text = PolicyNo;
                txtName.Text = ds.Tables[0].Rows[0]["Name"].ToString();
                txtContactNumber.Text = ds.Tables[0].Rows[0]["Contact_Number"].ToString();
                txtEmail.Text = ds.Tables[0].Rows[0]["Email_Id"].ToString();
                txtTravelStartDate.Text = ds.Tables[0].Rows[0]["Travel_StartDate"].ToString();
                txtEndDate.Text = ds.Tables[0].Rows[0]["Travel_EndDate"].ToString();

            }
        }

    }
    #endregion

    #region
    protected void Bind_Drop()
    {
        try
        {
            DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_RegistrationYear", new object[] { "Get_RegistrationYear", 0, "", "", 0, 0, SqlDateTime.Null, 0, SqlDateTime.Null });
            if (dt.Rows.Count > 0)
            {
                ddlRegistrationYear1.DataSource = dt;
                ddlRegistrationYear1.DataTextField = "RegistrationYear";
                ddlRegistrationYear1.DataValueField = "ID";
                ddlRegistrationYear1.DataBind();

            }
            DataTable dtR = con.ExecuteReaderDt("Allianz_Travel", "USP_VASCountryMaster", new object[] { "Get_Country", "" });
            if (dtR.Rows.Count > 0)
            {
                ddlCountry1.DataSource = dtR;
                ddlCountry1.DataTextField = "Country";
                ddlCountry1.DataValueField = "Country_Code";
                ddlCountry1.DataBind();

                ddlCountry2.DataSource = dtR;
                ddlCountry2.DataTextField = "Country";
                ddlCountry2.DataValueField = "Country_Code";
                ddlCountry2.DataBind();

                ddlCountry3.DataSource = dtR;
                ddlCountry3.DataTextField = "Country";
                ddlCountry3.DataValueField = "Country_Code";
                ddlCountry3.DataBind();

            }
            //DataTable dtC = con.ExecuteReaderDt("Allianz_Travel", "USP_RoadsideAssistance", new object[] { "Get_CityWeather", 0, "", "", "", "", "", 0, 0, SqlDateTime.Null, 0, SqlDateTime.Null });
            //if (dtC.Rows.Count > 0)
            //{
            //    ddlCity.DataSource = dtC;
            //    ddlCity.DataTextField = "City";
            //    ddlCity.DataValueField = "Id";
            //    ddlCity.DataBind();
            //}



            DataTable dttM = con.ExecuteReaderDt("Allianz_Travel", "USP_MonthYear", new object[] { "Get_Month", 0, "", "", "", 0, 0, SqlDateTime.Null, 0, SqlDateTime.Null });
            if (dttM.Rows.Count > 0)
            {
                ddlExpiryMonth.DataSource = dttM;
                ddlExpiryMonth.DataTextField = "ExpiryMonth";
                ddlExpiryMonth.DataValueField = "Id";
                ddlExpiryMonth.DataBind();
            }
            DataTable dttY = con.ExecuteReaderDt("Allianz_Travel", "USP_MonthYear", new object[] { "Get_Year", 0, "", "", "", 0, 0, SqlDateTime.Null, 0, SqlDateTime.Null });
            if (dttY.Rows.Count > 0)
            {
                ddlExpiryYear.DataSource = dttY;
                ddlExpiryYear.DataTextField = "ExpiryYear";
                ddlExpiryYear.DataValueField = "Id";
                ddlExpiryYear.DataBind();
            }

        }
        catch (Exception ex)
        {

        }
    }

    #endregion

    #region
    //Laggage Tracker Info Save
    public string SaveData(string tracker, string PolicyNo)//WebMethod to Save the data  
    {
        string result = "";

        DataSet dsTracker = con.ExecuteReader("Allianz_Travel", "USP_DeleteVASDetails", new object[] { "Luggage", PolicyNo });
        if (dsTracker.Tables[0].Rows.Count > 0)
        {
        }
        var serializeData = JsonConvert.DeserializeObject<List<LaggageTracker>>(tracker);
        foreach (var data in serializeData)
        {

            using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_Luggage_TrackerVAS", new object[] { "Save_Tracker", 0, data.PolicyNo.ToString().Trim(), data.TrackerNumber, 1, 1, SqlDateTime.Null, 1, SqlDateTime.Null }))
            {
                result = "F";
            }
        }
        return JsonConvert.SerializeObject(result);
    }
    public class LaggageTracker
    {
        public string PolicyNo { get; set; }
        public string TrackerNumber { get; set; }

    }
    #endregion

    #region
    //VAS All Info Save
    public string SaveData2(string AllVAS)//WebMethod to Save the data  ddlCountry
    {
        string result2 = "";
        var serializeData = JsonConvert.DeserializeObject<List<VASInfo>>(AllVAS);
        foreach (var data in serializeData)
        {
            using (DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_CustomerVAS", new object[] { "Save_VAS", 0, data.PolicyNo.ToString(), data.Name.ToString().Trim(), data.ContactNo.ToString().Trim(), data.Email.ToString().Trim(), data.Startdate, data.Enddate, "", "", "", "", data.BankName.ToString().Trim(), data.CardType.ToString().Trim(), data.NameofCardholder.ToString().Trim(), BusinessLogic.QueryStringEncode(data.CardNumber4), data.ExpiryMonth.ToString(), data.ExpiryYearSS.ToString(), "", data.Country.ToString(), data.City, 0, 0, "", 0, "" }))
            // using (DataTable dt = con.ExecuteReaderDt("Allianz_Travel", "USP_CustomerVAS", new object[] { "Save_VAS", 0, data.PolicyNo.ToString(), data.Name.ToString().Trim(), data.ContactNo.ToString().Trim(), data.Email.ToString().Trim(),"", "", data.Make.ToString().Trim(), data.RegNo.ToString().Trim(), data.Modle.ToString().Trim(), data.ExpiryYear, data.BankName.ToString().Trim(), data.CardType.ToString().Trim(), data.NameofCardholder.ToString().Trim(), data.CardNumber1.ToString().Trim() + data.CardNumber2 + data.CardNumber3 + data.CardNumber4, data.ExpiryMonth.ToString(), data.ExpiryYearSS.ToString(), "", data.Country.ToString(), data.City, 0, 0,"", 0, "" }))
            {
                result2 = "F";
                sendsms(data.ContactNo.ToString().Trim(), data.PolicyNo.ToString(), data.Name.ToString().Trim());
                sendmail_User(data.Name, data.Email);
            }
        }
        return JsonConvert.SerializeObject(result2);
    }
    public class VASInfo
    {
        public string PolicyNo { get; set; }
        public string Name { get; set; }
        public string ContactNo { get; set; }
        public string Email { get; set; }
        public string Startdate { get; set; }
        public string Enddate { get; set; }
        public string Make { get; set; }
        public string RegNo { get; set; }
        public string Modle { get; set; }
        public string ExpiryYear { get; set; }
        public string BankName { get; set; }
        public string CardType { get; set; }
        public string NameofCardholder { get; set; }
        public string CardNumber1 { get; set; }
        public string CardNumber2 { get; set; }
        public string CardNumber3 { get; set; }
        public string CardNumber4 { get; set; }
        public string ExpiryMonth { get; set; }
        public string ExpiryYearSS { get; set; }
        public string Country { get; set; }
        public string City { get; set; }

    }
    #endregion

    #region Send Mail
    private void sendmail_User(string name, string email)
    {
        //
        try
        {
            StringBuilder sb = new StringBuilder();
            StringBuilder sblogo = new StringBuilder();
            string myTemplate = "", strSubject = "";
            string strTo = email;
            string strFrom = ConfigurationManager.AppSettings["frommail"].ToString();

            DataSet dtvar = con.ExecuteReader("Allianz_Travel", "Get_VASEmail", new object[] { "GET_EmailData", 0, 0, "", "", "", "", "" });
            StringBuilder stb = new StringBuilder();
            if (dtvar.Tables[0].Rows.Count > 0)
            {
                strSubject = dtvar.Tables[0].Rows[0]["Subject"].ToString();
                stb.Append(dtvar.Tables[0].Rows[0]["Body"].ToString());
            }

            stb.Replace("[Name]", name);


            string Link = ConfigurationManager.AppSettings["virtualpath"].ToString() + "Login.aspx";
            bl.sendmail(strSubject, stb.ToString(), "", "", strFrom, strTo, "", "");

        }
        catch (Exception ex)
        {

        }

    }
    #endregion

    #region
    public string Get_RegYear(int id)
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_RegistrationYear", new object[] { "Get_RegistrationYear", 0, "", "", 0, 0, SqlDateTime.Null, 0, SqlDateTime.Null });

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
    #endregion

    #region
    //VAS All Info Road Side Assistance Save
    public string SaveDataRoadSide(string RoadAssistance_PNO, string PolicyNo)
    {
        string result = "";
        DataSet dsTracker = con.ExecuteReader("Allianz_Travel", "USP_DeleteVASDetails", new object[] { "RSA", PolicyNo });
        if (dsTracker.Tables[0].Rows.Count > 0)
        {
        }
        var serializeData = JsonConvert.DeserializeObject<List<RoadSideAssistance>>(RoadAssistance_PNO);
        foreach (var data in serializeData)
        {

            using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_RoadsideAssistance", new object[] { "Save_RoadsideAssiatance", 0, data.PolicyNo, data.Make, data.Model, data.RegNo, data.RegYear, 0, 0, SqlDateTime.Null, 0, SqlDateTime.Null }))
            {
                result = "F";
            }
        }
        return JsonConvert.SerializeObject(result);

    }
    public class RoadSideAssistance
    {
        public string PolicyNo { get; set; }
        public string Make { get; set; }
        public string Model { get; set; }
        public string RegNo { get; set; }
        public string RegYear { get; set; }

    }

    #endregion

    public void abc(string PolicyNo)
    {

        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_CustomerVAS", new object[] { "Get_VASdetails", 0, PolicyNo, "", "", "", SqlDateTime.Null, SqlDateTime.Null, "", "", "", "", "", "", "", "", "", "", "", "", "", 0, 0, SqlDateTime.Null, 0, SqlDateTime.Null });
        if (ds.Tables[0].Rows.Count > 0)
        {
            VAS2.Visible = false;
            VAS3.Visible = false;
            VAS4.Visible = false;
            VAS5.Visible = false;
            LuggageID.Visible = false;
            RoadsideID.Visible = false;
            WeatherID.Visible = false;
            CardProtectionId.Visible = false;
            string P = ds.Tables[1].Rows[0]["VAS"].ToString();
            CheckTab.Value = P;
            if (P.ToUpper().Contains("LUGGAGE TRACKER"))
            {
                VAS2.Visible = true;
                LuggageID.Visible = true;
            }

            if (P.ToUpper().Contains("ROADSIDE ASSISTANCE"))
            {
                VAS3.Visible = true;
                RoadsideID.Visible = true;
            }

            if (P.ToUpper().Contains("WEATHER UPDATE"))
            {
                VAS4.Visible = true;
                WeatherID.Visible = true;
            }


            if (P.ToUpper().Contains("CARD PROTECTION"))
            {
                VAS5.Visible = true;
                CardProtectionId.Visible = true;
            }
        }
    }

    #region send SMS
    public void sendsms(string mobileno, string PolicyNo, string name)
    {
        try
        {

            string xmlstring = string.Empty;
            xmlstring = "<?xml version=\"1.0\"?><a2wml version=\"2.0\"><request ACODE=\"AGASERVICES\" accId=\"516680\" pin=\"ags@1\"><fromAddress>AZTRVL</fromAddress><recipientList><destAddress>" + mobileno + "</destAddress></recipientList><message><messageType></messageType><port></port><udh></udh><messageTxt>Hi " + name + ", Congrats! Your travel value added services have been successfully activated. Call us @1800 419 8581 in case of queries.</messageTxt ><odRequestId ></odRequestId><custref></custref><billref ></billref><splitAlgm></splitAlgm><scheduleTime></scheduleTime><expiryMinutes></expiryMinutes><dlrtype></dlrtype ><priority></priority></message></request></a2wml>";

            byte[] bytes = null;
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://luna.a2wi.co.in:7501/failsafe/HttpData_SS");
            //WebProxy myProxy = new WebProxy();
            //Uri newUri = new Uri("http://10.125.128.35:8080/");
            //Uri newUri = new Uri("http://172.30.251.13:8080");
            //myProxy.Address = newUri;
            ////myProxy.Credentials = new NetworkCredential("sandhyas", "Allianz@123");
            //request.Proxy = myProxy;
            bytes = System.Text.Encoding.ASCII.GetBytes(xmlstring);
            request.ContentType = "text/xml; charset='utf-8'";
            request.Accept = "text/xml";
            request.ContentLength = bytes.Length;
            request.Method = "POST";
            Stream requestStream = request.GetRequestStream();
            requestStream.Write(bytes, 0, bytes.Length);
            requestStream.Close();
            HttpWebResponse response;
            response = (HttpWebResponse)request.GetResponse();
            if (response.StatusCode == HttpStatusCode.OK)
            {
                Stream responseStream = response.GetResponseStream();
                string responseStr = new StreamReader(responseStream).ReadToEnd();
                //return responseStr;
            }
        }
        catch (Exception exsms) { }
    }
    #endregion

}
