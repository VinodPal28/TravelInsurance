using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Text;

public partial class PolicyDownload : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Allianz_Travel"].ConnectionString);
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            
            if (Request.QueryString["Policy_No"] != null)
            {
                string PolicyNo = Request.QueryString["Policy_No"].ToString();              
                GetPolicyDownloadDetails(PolicyNo);
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
    public void GetPolicyDownloadDetails(string PolicyNo)
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_DownloadPolicy", new object[] { "Get_PolicyDetails", PolicyNo });
        if (ds.Tables[0].Rows.Count > 0)
        {
            
            PolicyNumber.InnerHtml = ds.Tables[0].Rows[0]["Policy_No"].ToString();
            InsurancePlan.InnerHtml = ds.Tables[0].Rows[0]["Plan_Name"].ToString();
            GeoName.InnerHtml = ds.Tables[0].Rows[0]["Geography_Name"].ToString()==""?"India": ds.Tables[0].Rows[0]["Geography_Name"].ToString();
            title.InnerHtml = ds.Tables[0].Rows[0]["Title"].ToString();
            CustName.InnerHtml = ds.Tables[0].Rows[0]["First_Name"].ToString()==""? ds.Tables[0].Rows[0]["CompanyName"].ToString(): ds.Tables[0].Rows[0]["First_Name"].ToString();
            DOB.InnerHtml = ds.Tables[0].Rows[0]["DOB"].ToString();
            NomineeName.InnerHtml = ds.Tables[0].Rows[0]["Nominee_Name"].ToString();                     
            CustAddress.InnerHtml = ds.Tables[0].Rows[0]["Nominee_Address"].ToString()==""? ds.Tables[0].Rows[0]["ComapnyAddress"].ToString(): ds.Tables[0].Rows[0]["Nominee_Address"].ToString();
          
            decimal Base_Price = Math.Round( Convert.ToDecimal(ds.Tables[0].Rows[0]["Price"].ToString()) /Convert.ToDecimal(1.18),2);
            decimal GST_Price = Math.Round(Convert.ToDecimal(ds.Tables[0].Rows[0]["Price"].ToString())-Base_Price,2);

            BasePrice.InnerHtml = Convert.ToString(Base_Price);
            GstPrice.InnerHtml = Convert.ToString(GST_Price);
            TotalPrice.InnerHtml = ds.Tables[0].Rows[0]["Price"].ToString();
            PolicyIssueDate.InnerHtml = ds.Tables[0].Rows[0]["Created_date"].ToString();
            PolicyStartdate.InnerHtml = ds.Tables[0].Rows[0]["Travel_Start_Date"].ToString();
            PolicyEndDate.InnerHtml = ds.Tables[0].Rows[0]["Travel_End_Date"].ToString();
            StateCode.InnerHtml= (ds.Tables[0].Rows[0]["Nominee_State"].ToString()=="0" || ds.Tables[0].Rows[0]["Nominee_State"].ToString() == "") ? ds.Tables[0].Rows[0]["Company_State"].ToString(): ds.Tables[0].Rows[0]["Nominee_State"].ToString();
            GSTIN.InnerHtml= ds.Tables[0].Rows[0]["GSTIN"].ToString()==""? ds.Tables[0].Rows[0]["Company_GSTIN"].ToString() : ds.Tables[0].Rows[0]["GSTIN"].ToString();
            PassportNo.InnerHtml= ds.Tables[0].Rows[0]["PassportNo"].ToString();

            DateTime dt = DateTime.Now;
            string dateAsString = dt.ToString("dd/MM/yyyy");
            string dtString = ds.Tables[0].Rows[0]["CustAge"].ToString();

            DateTime dtTarget;
            if (DateTime.TryParseExact(dtString, "dd/MM/yyyy", System.Globalization.CultureInfo.CurrentCulture, System.Globalization.DateTimeStyles.None, out dtTarget))
            {
                dtString = dtTarget.ToString("MM/dd/yyyy");

            }
            DateTime dob = Convert.ToDateTime(dtString);
            DateTime now = DateTime.Now;
            TimeSpan ts = now - dob;
            int Age = ts.Days / 365;
            int ChildAge = 0;
            if (Age == 0)
            {
                ChildAge = ts.Days / 30;
            }

            DataSet ds1 = con.ExecuteReader("Allianz_Travel", "USP_GetPassengerType", new object[] { Age , ChildAge });
            if (ds1.Tables[0].Rows.Count > 0)
            {
                PassengerType.InnerHtml = ds1.Tables[0].Rows[0]["Passengers_type"].ToString();
            }                                  
            StringBuilder sb = new StringBuilder();
            if (ds.Tables[1].Rows.Count > 0)
            {

                for (int i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    sb.Append("<tr>");
                    sb.Append("<td>" + Convert.ToString(ds.Tables[1].Rows[i]["Benifit_Name"] + "</td>"));
                    sb.Append("<td>" + Convert.ToString(ds.Tables[1].Rows[i]["SumInsured"] + "</td>"));
                    sb.Append("<td>" + Convert.ToString(ds.Tables[1].Rows[i]["Deductible"] + "</td>"));
                    //sb.Append("<td>" + ds.Tables[1].Rows[i]["Deductible"].ToString()==""?"-": ds.Tables[1].Rows[i]["Deductible"].ToString() + "</td>"); 
                    //sb.Append("<td>-</td>");
                    sb.Append("</tr>");
                }
                // sb.Append("</table>");
                BenefitsDetails.InnerHtml = Convert.ToString(sb);
            }
        }
    }
}