using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_PlanMaster : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    DataTable dt = new DataTable();
    BusinessLogic bl = new BusinessLogic();
    private static int userid = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] == null || Session["UserId"].ToString() == "0")
            {
                Response.Redirect("../Home.aspx");
            }
            //else
            //{
            //    bool Authenticate = bl.CheckAuthority("Masters", Session["UserTypeId"].ToString());
            //    if (Authenticate == false)
            //    {
            //        Response.Redirect("../Default.aspx");
            //    }
            //}
            if (!IsPostBack)
            {
                userid = int.Parse(Session["UserId"].ToString());
                //Bind();
                Bind_TermCondition();
                Bind_InsurerProvider();
                Bind_Valueaddedservices();
                AddDayageGeoControl();
            }

            if (Request.QueryString["Action"] == "GetOptionalBenifit")
            {
                if (Request.QueryString["lb"] != "" && Request.QueryString["lb"] != null)
                {
                    string listbox = Request.QueryString["lb"];

                    Response.Cache.SetCacheability(HttpCacheability.NoCache);
                    Response.Clear();
                    Response.Write(GetOptionalBenifit(listbox));
                    Response.End();
                }
            }

            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "CheckPlanCode")
                {
                    CheckCode(Request.Params["PlanCode"].ToString());
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
    public void CheckCode(string Plancode)
    {
        string message = string.Empty;
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_CheckPlanCode", new object[] { Plancode });
            message = ds.Tables[0].Rows.Count > 0 ? "F" : "NF";
            Response.Write(message);
            Response.End();
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
    //public void Bind()
    //{
    //    dt = con.ExecuteReaderDt("Allianz_Travel", "USP_GetBenefit", new object[] { "", "" });
    //    if (dt.Rows.Count > 0)
    //    {
    //        ListFixdBenefits.DataSource = dt;
    //        ListFixdBenefits.DataTextField = "name";
    //        ListFixdBenefits.DataValueField = "Benifit_id";
    //        ListFixdBenefits.SelectedValue = null;
    //        ListFixdBenefits.DataBind();
    //    }

    //}
    protected void Bind_InsurerProvider()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "Insurer_Provider", 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlInsurerProvider.DataSource = ds;
                ddlInsurerProvider.DataValueField = "Insurer_Id";
                ddlInsurerProvider.DataTextField = "name";
                ddlInsurerProvider.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void Bind_Valueaddedservices()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetMasters", new object[] { "Value_AddedService", 0 });

            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlValueaddedservices.DataSource = ds;
                ddlValueaddedservices.DataValueField = "id";
                ddlValueaddedservices.DataTextField = "name";
                ddlValueaddedservices.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }
    protected void Bind_TermCondition()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetTermCondition", new object[] { "Get" });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlTemandCodition.DataSource = ds;
                ddlTemandCodition.DataValueField = "Document_Path";
                ddlTemandCodition.DataTextField = "Document_Name";
                ddlTemandCodition.DataBind();
            }
        }
        catch (Exception ex)
        {

        }
    }
    public string GetOptionalBenifit(string items)
    {
        try
        {

            items = string.Join(",", items);
            DataTable dtbenifit = con.ExecuteReaderDt("Allianz_Travel", "USP_GetOptionalBenifit", new object[] { "GET", items });

            System.Web.Script.Serialization.JavaScriptSerializer serializer = new System.Web.Script.Serialization.JavaScriptSerializer();
            List<Dictionary<string, object>> rows = new List<Dictionary<string, object>>();
            Dictionary<string, object> row;
            foreach (DataRow dr in dtbenifit.Rows)
            {
                row = new Dictionary<string, object>();
                foreach (DataColumn col in dtbenifit.Columns)
                {
                    row.Add(col.ColumnName, dr[col]);
                }
                rows.Add(row);
            }

            return serializer.Serialize(rows);
        }

        catch (Exception ex)
        {
            return null;

        }
    }

    //**Start**Adding controls dynamically for geo age day slab price, done by Manish/Vinod on 23-May-2018
    protected void AddDayageGeoControl()
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_GetGeoAgeSlab", new object[] { "Get" });
            if (ds.Tables[0].Rows.Count > 0)
            {
                HdnGeoCnt.Value = ds.Tables[0].Rows.Count.ToString();
                //HdnAgeSlabCnt.Value = ds.Tables[1].Rows.Count.ToString();
                int i = 0, j = 0;
                //sb.Append("<table class='table table-de mb-0' id='maintable' runat='server'>");
                //sb.Append("<tbody>");
                sb.Append("<tr class='data-Geo'>");
                //sb.Append("<td><strong>Geography</strong> <i class='la la - arrow - right'></i></td>");
                sb.Append("<td><strong>Geography</strong></td>");
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    i++;
                    // sb.Append("<th colspan='2'><asp:Label id=''Geo' "+ i + "' Text='" + dr["Geography_Name"].ToString() + "' runat='server'></asp:Label> </th>");
                    sb.Append("<td><label id='lblGeo" + i + "'> " + dr["Geography_Name"].ToString() + "</label></td>");
                }
                int count = ds.Tables[0].Rows.Count;
                sb.Append("</tr>");
                sb.Append("<tr class='data-Geod'>");
                sb.Append("<td><strong>Geography</strong></td>");
                sb.Append("<td><label id='lblGeod'>India</label></td>");
                sb.Append("</tr>");
                //sb.Append("<tr class='data-dayslab'>");
                ////sb.Append("<td><strong>Day Slab</strong> <i class='la la - arrow - down'></i></td>");
                //sb.Append("<td><strong>Day Slab</strong></td>");
                //while (count > 0)
                //{
                //    sb.Append("<td>");
                //    foreach (DataRow dr1 in ds.Tables[1].Rows)
                //    {
                //        j++;
                //        //sb.Append("<label id=''lblAgeSlab" + j + "> " + dr1["Age_Group"].ToString() + "</label>&nbsp;&nbsp;");
                //        sb.Append("<input type='text' id='txtAgeSlab" + j + "' class='form - control' value=" + dr1["Age_Group"].ToString() + " style='width: 60px;' readonly='true'>&nbsp;&nbsp;");
                //    }
                //    sb.Append("</td>");
                //    count--;
                //}
                //sb.Append("</tr>");

                //sb.Append("<tr class='data-Price'>");
                //sb.Append("<td ><input type='text' maxlength='3' id='txtDaySlab1' class='form - control' style='width: 40px;'> &nbsp;<input type='text' maxlength='2' id='txtDaySlab2' class='form - control' style='width: 40px;'></td>");
                //count = ds.Tables[0].Rows.Count;
                //j = 0;
                //while (count > 0)
                //{
                //    sb.Append("<td>");
                //    foreach (DataRow dr1 in ds.Tables[1].Rows)
                //    {
                //        j++;
                //        sb.Append("<input type='text' maxlength='10' id='txtPrice" + j + "' placeholder='Price' class='form - control' style='width: 60px;'>&nbsp;&nbsp;");
                //    }
                //    sb.Append("</td>");
                //    count--;
                //}
                //AgeSlabIdCnt.Value = j.ToString();
                //sb.Append("</tr>");
                //sb.Append("</tbody>");
                //sb.Append("</table>");
                maindiv.InnerHtml = Convert.ToString(sb);
            }
        }
        catch (Exception ex)
        {

        }
    }
    //**End**Adding controls dynamically for geo age day slab price

    //Geo-Age-Price details saving method///Done by Manish on 25-May-2018

    //[WebMethod, ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
    //public static string SaveGeoData(string geoagedetails, string option)
    //{
    //    ConnectionToSql con = new ConnectionToSql();
    //    string status = "";
    //    try
    //    {
    //        if (option.Equals("DayAgeGeo", StringComparison.OrdinalIgnoreCase))
    //        {
    //            //float minage, maxage;
    //            string plancode = "";
    //            string[] ageslab = new string[2];
    //            //JavaScriptSerializer js = new JavaScriptSerializer();
    //            //js.MaxJsonLength = 2147483647;
    //            //string jsonData = js.Serialize(geoagedetails);
    //            //var serializeData = JsonConvert.DeserializeObject<List<GeoAgeDetail>>(jsonData);
    //            //var objJSS = new JavaScriptSerializer() { MaxJsonLength = Int32.MaxValue };
    //            //string jsonData=objJSS.Serialize(geoagedetails);
    //            var serializeData = JsonConvert.DeserializeObject<List<GeoAgeDetail>>(geoagedetails);
    //            //var serializeData = JsonConvert.DeserializeObject<List<GeoAgeDetail>>(jsonData);
    //            foreach (var data in serializeData)
    //            {
    //                plancode = data.PlanCode.Trim();
    //                ageslab = data.AgeSlab.ToString().Split('-');

    //                using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_SaveGeoAgeDetails", new object[] { "Save", data.PlanCode.Trim(), data.GeoName.Trim(), ageslab[0].Trim(), ageslab[1].Trim(), data.MinDay.Trim(), data.MaxDay.Trim(), Convert.ToDecimal(data.Price.Trim()), Admin_PlanMaster.userid }))
    //                {

    //                }

    //            }
    //            using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_UpdatePlanpricing", new object[] { "Update", plancode, option, 0, 0, 0 }))
    //            {

    //            }
    //            status = "true";
    //        }
    //        else if (option.Equals("PerDay", StringComparison.OrdinalIgnoreCase))
    //        {
    //            var serializeData = JsonConvert.DeserializeObject<List<MICEDetail>>(geoagedetails);
    //            foreach (var data in serializeData)
    //            {
    //                using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_UpdatePlanpricing", new object[] { "Update", data.PlanCode.Trim(), option, int.Parse(data.Traveller.Trim()), 0, Convert.ToDecimal(data.Price.Trim()) }))
    //                {

    //                }
    //            }
    //            status = "true";
    //        }
    //        else if (option.Equals("MICE", StringComparison.OrdinalIgnoreCase))
    //        {
    //            var serializeData = JsonConvert.DeserializeObject<List<MICEDetail>>(geoagedetails);
    //            foreach (var data in serializeData)
    //            {
    //                using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_UpdatePlanpricing", new object[] { "Update", data.PlanCode.Trim(), option, int.Parse(data.Traveller.Trim()), 0, Convert.ToDecimal(data.Price.Trim()) }))
    //                {

    //                }
    //            }
    //            status = "true";
    //        }
    //    }
    //    catch (Exception ex)
    //    {
    //        status = "false";
    //    }
    //    //return JsonConvert.SerializeObject(status);
    //    return status;
    //}

    //[WebMethod,ScriptMethod(ResponseFormat = ResponseFormat.Json, UseHttpGet = false)]
    //public string SaveData(string PlanBenifits)//WebMethod to Save the data  
    //{
    //    //ConnectionToSql con = new ConnectionToSql();
    //    string result = "";
    //    var serializeData = JsonConvert.DeserializeObject<List<planBenifits>>(PlanBenifits);
    //    foreach (var data in serializeData)
    //    {
    //        using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsertPlanBenifits", new object[] { data.PlanCode, data.BenifitName.Replace('~','&'), data.BenifitType, data.SumInsured.Replace('~', '&'), Session["UserId"],data.Deductible.Replace('~', '&') }))
    //        {
    //            result = "F";
    //        }

    //    }

    //    return JsonConvert.SerializeObject(result);
    //    //return result;
    //}
    public class planDetails
    {
        public string InsurerProvider { get; set; }
        public string PlanName { get; set; }
        public string PlanCode { get; set; }
        public string VAS { get; set; }
        public string MinAge { get; set; }
        public string MaxAge { get; set; }
        public string MinTripDur { get; set; }
        public string MaxTripDur { get; set; }
        public string ValidFor { get; set; }
        //public string FileUpload { get; set; }
        public string Traveltype { get; set; }
        public string TandC { get; set; }
    }
    public class planBenifits
    {
        public string PlanCode { get; set; }
        public string BenifitName { get; set; }
        public string BenifitType { get; set; }
        public string SumInsured { get; set; }
        public string Deductible { get; set; }

    }
    public class GeoAgeDetail
    {
        public string PlanCode { get; set; }
        public string GeoName { get; set; }
        public string AgeSlab { get; set; }
        public string MinDay { get; set; }
        public string MaxDay { get; set; }
        public string Price { get; set; }
    }
    public class PerDayDetail
    {
        public string PlanCode { get; set; }
        public string Price { get; set; }
    }
    public class MICEDetail
    {
        public string PlanCode { get; set; }
        public string Price { get; set; }
        public string Traveller { get; set; }
        //public string ManDays { get; set; }
    }

    [WebMethod]
    public static string SavePlanData(string PlanDetails)
    {
        ConnectionToSql con = new ConnectionToSql();
        string result = "";
        var serializeData = JsonConvert.DeserializeObject<List<planDetails>>(PlanDetails);
        foreach (var PlanData in serializeData)
        {
            using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsertPlanDetails", new object[] { PlanData.InsurerProvider, PlanData.PlanName.Replace('~', '&'), PlanData.PlanCode, 0, PlanData.VAS, PlanData.MinAge, PlanData.MaxAge, PlanData.MinTripDur, PlanData.MaxTripDur, PlanData.ValidFor, PlanData.TandC.Replace('~', '&'), Admin_PlanMaster.userid, PlanData.Traveltype }))
            {
                result = "F";
            }
        }
        //return JsonConvert.SerializeObject(result);
        return result;
    }

    [WebMethod]
    public static string SaveData(string PlanBenifits)//WebMethod to Save the data  
    {
        ConnectionToSql con = new ConnectionToSql();
        string result = "";
        var serializeData = JsonConvert.DeserializeObject<List<planBenifits>>(PlanBenifits);
        foreach (var data in serializeData)
        {
            using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsertPlanBenifits", new object[] { data.PlanCode, data.BenifitName.Replace('~', '&'), data.BenifitType, data.SumInsured.Replace('~', '&'), Admin_PlanMaster.userid, data.Deductible.Replace('~', '&') }))
            {
                result = "F";
            }

        }

        //return JsonConvert.SerializeObject(result);
        return result;
    }

    [WebMethod]
    public static string SaveGeoData(string geoagedetails)
    {
        ConnectionToSql con = new ConnectionToSql();
        string status = "";
        try
        {
            //float minage, maxage;
            string plancode = "";
            string[] ageslab = new string[2];

            var serializeData = JsonConvert.DeserializeObject<List<GeoAgeDetail>>(geoagedetails);
            foreach (var data in serializeData)
            {
                plancode = data.PlanCode.Trim();
                ageslab = data.AgeSlab.ToString().Split('-');

                using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_SaveGeoAgeDetails", new object[] { "Save", data.PlanCode.Trim(), data.GeoName.Trim(), ageslab[0].Trim(), ageslab[1].Trim(), data.MinDay.Trim(), data.MaxDay.Trim(), Convert.ToDecimal(data.Price.Trim()), Admin_PlanMaster.userid }))
                {

                }

            }
            using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_UpdatePlanpricing", new object[] { "Update", plancode, "DayAgeGeo", 0, 0, 0 }))
            {

            }
            status = "true";
        }
        catch (Exception ex)
        {
            status = "false";
        }
        //return JsonConvert.SerializeObject(status);
        return status;
    }

    [WebMethod]
    public static string SavePerDay(string geoagedetails)
    {
        ConnectionToSql con = new ConnectionToSql();
        string status = "";
        try
        {
            var serializeData = JsonConvert.DeserializeObject<List<MICEDetail>>(geoagedetails);
            foreach (var data in serializeData)
            {
                using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_UpdatePlanpricing", new object[] { "Update", data.PlanCode.Trim(), "PerDay", int.Parse(data.Traveller.Trim()), 0, Convert.ToDecimal(data.Price.Trim()) }))
                {

                }
            }
            status = "true";
            //else if (option.Equals("MICE", StringComparison.OrdinalIgnoreCase))
            //{
            //    var serializeData = JsonConvert.DeserializeObject<List<MICEDetail>>(geoagedetails);
            //    foreach (var data in serializeData)
            //    {
            //        using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_UpdatePlanpricing", new object[] { "Update", data.PlanCode.Trim(), option, int.Parse(data.Traveller.Trim()), 0, Convert.ToDecimal(data.Price.Trim()) }))
            //        {

            //        }
            //    }
            //    status = "true";
            //}
        }
        catch (Exception ex)
        {
            status = "false";
        }
        //return JsonConvert.SerializeObject(status);
        return status;
    }

    [WebMethod]
    public static string SaveMICE(string geoagedetails)
    {
        ConnectionToSql con = new ConnectionToSql();
        string status = "";
        try
        {
            var serializeData = JsonConvert.DeserializeObject<List<MICEDetail>>(geoagedetails);
            foreach (var data in serializeData)
            {
                using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_UpdatePlanpricing", new object[] { "Update", data.PlanCode.Trim(), "MICE", int.Parse(data.Traveller.Trim()), 0, Convert.ToDecimal(data.Price.Trim()) }))
                {

                }
            }
            status = "true";
        }
        catch (Exception ex)
        {
            status = "false";
        }
        //return JsonConvert.SerializeObject(status);
        return status;
    }
}