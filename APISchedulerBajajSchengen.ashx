<%@ WebHandler Language="C#" Class="APISchedulerBajajSchengen" %>

using System;
using System.Web;
using System.Text;
using Microsoft.SqlServer;
using System.Configuration;
using System.IO;
using System.Data;
using System.Net;
using System.Data.SqlClient;
using System.Xml.Linq;
using System.Xml;
using System.Collections.Generic;

public class APISchedulerBajajSchengen : IHttpHandler
{
    BusinessLogic bl = new BusinessLogic();
    string connstring = ConfigurationManager.ConnectionStrings["Allianz_Travel"].ConnectionString;
    string connstring_failed = ConfigurationManager.ConnectionStrings["Allianz_Travel"].ConnectionString;
    bool isFailed = false;
    ConnectionToSql sqlCon = new ConnectionToSql();

    public void ProcessRequest(HttpContext context)
    {
        try
        {
            DataTable _rslt = sqlCon.ExecuteReaderDt("Allianz_Travel", "USP_GetSchengen_PolicyDataForBajaj", new object[] { "GetPolicyData", "" });
            //var _rslt = clsSP.Schedular("Scheduler");
            if (_rslt.Rows.Count > 0)
            {
                try
                {
                    string AckPath = Path.Combine(context.Server.MapPath("~/BajajAPI/"), "PolicySchengenAck_" + DateTime.Now.ToString("ddMMyyyy") + ".txt");
                    if (!File.Exists(AckPath))
                    {
                        string str1 = "PolicyNo\t" + "ErrorNo\t" + "Message";
                        File.AppendAllText(AckPath, str1);
                    }
                    string endtflag = string.Empty;
                    string endtrsnwording = string.Empty;
                    string cancelReason = string.Empty;
                    for (int i = 0; i < _rslt.Rows.Count; i++)
                    {
                        try
                        {
                            //if (_rslt.Rows[i]["Policy_Status"].ToString().ToUpper() == "ENDORSED")
                            //{
                            //    endtflag = "PART_ENDT";
                            //    endtrsnwording = "Correction in the Customer details";
                            //    cancelReason = "";
                            //}
                            //else
                            //{
                            //    endtflag = "CANCEL_ENDT";
                            //    endtrsnwording = "Cancel Policy";
                            //    cancelReason = "Trip Cancellation";
                            //}
                            //API Code
                            string xmlrequest = @"<x:Envelope xmlns:x=""http://schemas.xmlsoap.org/soap/envelope/"" xmlns:bja=""http://com/bajajallianz/BjazAgaFileProcess/BjazAgaFileProcess.wsdl"">
                                <x:Header/>
                                 <x:Body>
                                    <bja:saveAgaWebsrvcDtls>
                                        <bja:pSrId>" + _rslt.Rows[i]["Policy_Id"].ToString() + @"</bja:pSrId>
                                        <bja:pTransDate>" + _rslt.Rows[i]["Trans_Date"].ToString() + @"</bja:pTransDate>
                                        <bja:pPolicyIssueDate>" + _rslt.Rows[i]["Trans_Date"].ToString() + @"</bja:pPolicyIssueDate>
                                        <bja:pPiDate>" + _rslt.Rows[i]["Trans_Date"].ToString() + @"</bja:pPiDate>
                                        <bja:pPiMmyyyy>" + _rslt.Rows[i]["PI_Date"].ToString() + @"</bja:pPiMmyyyy>
                                        <bja:pPiYear>" + _rslt.Rows[i]["Year"].ToString() + @"</bja:pPiYear>
                                        <bja:pPolicyNo>" + _rslt.Rows[i]["Policy_No"].ToString() + @"</bja:pPolicyNo>
                                        <bja:pTravelLocation>" + _rslt.Rows[i]["geo_name"].ToString() + @"</bja:pTravelLocation>
                                        <bja:pTypeCoverage>" + _rslt.Rows[i]["Plan_Name"].ToString() + @"</bja:pTypeCoverage>
                                        <bja:pDepartureCountry>India</bja:pDepartureCountry>
                                        <bja:pArrivalCountry>" + _rslt.Rows[i]["geo_name"].ToString() + @"</bja:pArrivalCountry>
                                        <bja:pDepartureDate>" + _rslt.Rows[i]["Travel_Start_Date"].ToString() + @"</bja:pDepartureDate>
                                        <bja:pReturnDate>" + _rslt.Rows[i]["Travel_End_Date"].ToString() + @"</bja:pReturnDate>
                                        <bja:pDuration></bja:pDuration>
                                        <bja:pNumPaxAdult></bja:pNumPaxAdult>
                                        <bja:pNumPaxChild></bja:pNumPaxChild>
                                        <bja:pPremiumInclTax>" + _rslt.Rows[i]["Price"].ToString() + @"</bja:pPremiumInclTax>
                                        <bja:pPremiumExclTax>" + _rslt.Rows[i]["Price"].ToString() + @"</bja:pPremiumExclTax>
                                        <bja:pPolicyStatus>#N/A</bja:pPolicyStatus>
                                        <bja:pExtensionPolicyNo>#N/A</bja:pExtensionPolicyNo>
                                        <bja:pEndorsementDoneYN>#N/A</bja:pEndorsementDoneYN>
                                        <bja:pInsuredPerson1Title>" + _rslt.Rows[i]["Title"].ToString() + @"</bja:pInsuredPerson1Title>
                                        <bja:pInsuredPerson1Firstname>" + _rslt.Rows[i]["First_Name"].ToString() + @"</bja:pInsuredPerson1Firstname>
                                        <bja:pInsuredPerson1Lastname>" + _rslt.Rows[i]["Last_Name"].ToString() + @"</bja:pInsuredPerson1Lastname>
                                        <bja:pInsuredPerson1Passport>" + _rslt.Rows[i]["PassportNo"].ToString() + @"</bja:pInsuredPerson1Passport>
                                        <bja:pInsuredPerson1Dateofbirth>" + _rslt.Rows[i]["DOB"].ToString() + @"</bja:pInsuredPerson1Dateofbirth>
                                        <bja:pAge></bja:pAge>
                                        <bja:pInsuredNomineeName>" + _rslt.Rows[i]["Nominee_Name"].ToString() + @"</bja:pInsuredNomineeName>
                                        <bja:pAddress1>" + _rslt.Rows[i]["Nominee_Address"].ToString() + @"</bja:pAddress1>
                                        <bja:pTown>" + _rslt.Rows[i]["City"].ToString() + @"</bja:pTown>
                                        <bja:pCountry></bja:pCountry>
                                        <bja:pZipcode>" + _rslt.Rows[i]["Nominee_PIN"].ToString() + @"</bja:pZipcode>
                                        <bja:pEmail>" + _rslt.Rows[i]["Email"].ToString() + @"</bja:pEmail>
                                        <bja:pPhonenumber1>" + _rslt.Rows[i]["Contact_No"].ToString() + @"</bja:pPhonenumber1>
                                        <bja:pPhonenumber2>" + _rslt.Rows[i]["Contact_No"].ToString() + @"</bja:pPhonenumber2>
                                        <bja:pPhonenumber3>" + _rslt.Rows[i]["Contact_No"].ToString() + @"</bja:pPhonenumber3>
                                        <bja:pPaymentMode></bja:pPaymentMode>
                                        <bja:pEmailSentTimeOrder>" + _rslt.Rows[i]["Trans_Date"].ToString() + @"</bja:pEmailSentTimeOrder>
                                        <bja:pFirstEmailSentTimePolicy>" + _rslt.Rows[i]["Trans_Date"].ToString() + @"</bja:pFirstEmailSentTimePolicy>
                                        <bja:pInsuredPerson1Middlename>" + _rslt.Rows[i]["Middle_Name"].ToString() + @"</bja:pInsuredPerson1Middlename>
                                        <bja:pProductCode></bja:pProductCode>
                                        <bja:pGstNo></bja:pGstNo>
                                        <bja:pErrorMessage_out></bja:pErrorMessage_out>
                                    </bja:saveAgaWebsrvcDtls>
                                </x:Body>
                            </x:Envelope>";

                            HttpWebRequest request = (HttpWebRequest)WebRequest.Create("http://bagicpreprod.bajajallianz.com:80/BjazAgaFileProcess/BjazAgaFileProcessPort?WSDL");
                            byte[] bytes;
                            bytes = System.Text.Encoding.ASCII.GetBytes(xmlrequest);
                            request.ContentType = "text/xml; encoding='utf-8'";
                            request.ContentLength = bytes.Length;
                            request.Method = "POST";
                            Stream requestStream = request.GetRequestStream();
                            requestStream.Write(bytes, 0, bytes.Length);
                            requestStream.Close();
                            HttpWebResponse response;
                            response = (HttpWebResponse)request.GetResponse();
                            //End API Code


                            if (response.StatusCode == HttpStatusCode.OK)
                            {
                                //XmlDocument doc = new XmlDocument();
                                //doc.Load(response.GetResponseStream());
                                // as an xml: deserialise into your own object or parse as you wish
                                //var responseXml = XDocument.Load(response.GetResponseStream());
                                //string a = doc.ChildNodes[0].ChildNodes[1].ChildNodes[0].ChildNodes[0].ChildNodes[8].ChildNodes[0].Value;

                                XmlDocument xmldoc = new XmlDocument();
                                XmlNodeList xmlnode;
                                xmldoc.Load(response.GetResponseStream());
                                //xmlnode = xmldoc.GetElementsByTagName("m:bjazEndtProcessApiResponse");
                                xmlnode = xmldoc.GetElementsByTagName("m:saveAgaWebsrvcDtls");
                                //for (int j = 0; j < xmlnode.Count; j++)
                                //{
                                //    string str = string.Format("ID: {0}\r\nName:{0}", xmlnode[j].ChildNodes.Item(0).InnerText, xmlnode[j].ChildNodes.Item(1).InnerText);
                                //}
                                //string errorcode = xmlnode[0].ChildNodes.Item(4).InnerText.ToString();
                                string errorcode = "0";
                                if (errorcode == "0")
                                {
                                    //string endttxt = xmlnode[0].ChildNodes.Item(2).InnerText.ToString();//"OG-19-1149-9910-00041825-EN02";
                                    // string endtno = endttxt.Substring(endttxt.LastIndexOf('-') + 1);
                                    using (DataSet ds = sqlCon.ExecuteReader("Allianz_Travel", "USP_GetSchengen_PolicyDataForBajaj", new object[] { "update", _rslt.Rows[i]["Policy_No"].ToString() }))
                                    {
                                        if (ds.Tables[0].Rows.Count > 0)
                                        {
                                            string str1 = "\r\n" + _rslt.Rows[i]["Policy_No"].ToString() + "\t" + "0\t" + "Policy Schengen successfully inserted";
                                            File.AppendAllText(AckPath, str1);
                                        }
                                    }


                                }
                                else
                                {
                                    XmlNodeList xmlnode1 = xmldoc.GetElementsByTagName("typ:WeoTygeErrorMessageUser");
                                    //string errNumber = xmlnode1[0].ChildNodes.Item(0).InnerText.ToString();
                                    // string errText = xmlnode1[0].ChildNodes.Item(3).InnerText.ToString();
                                    // string str1 = "\r\n" + _rslt.Rows[i]["Policy_No"].ToString() + "\t" + errNumber + "\t" + errText;
                                    string str1 = "\r\n" + _rslt.Rows[i]["Policy_No"].ToString() + "\t" + "Failed";
                                    File.AppendAllText(AckPath, str1);
                                }
                            }
                        }
                        catch (WebException ex)
                        {
                            string message = new StreamReader(ex.Response.GetResponseStream()).ReadToEnd();
                        }
                        catch (Exception ex)
                        {
                            Scheduler_failed();

                        }
                    }
                }
                catch (Exception ex)
                {
                     Scheduler_failed();

                }
            }

        }
        catch (Exception ex)
        {
            Scheduler_failed();
        }
    }

    public void Scheduler_failed()
    {
        if (isFailed == false)
        {
            isFailed = true;

            SqlConnection conn = new SqlConnection(connstring_failed);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand comm = new SqlCommand();
            try
            {
                string strSubject, stb, strTo, strFrom = "";

                comm.Connection = conn;
                conn.Open();
                int count = 0;
                DataTable _rslt = sqlCon.ExecuteReaderDt("Allianz_Travel", "USP_SchedulerFailed", new object[] { "SchedulerFailed", "BajajSchengenPolicy" });
                //var _rslt = clsSP.Schedular("Schedular_Failed");
                if (_rslt.Rows.Count > 0)
                {
                    count = Convert.ToInt32(_rslt.Rows[0]["id"].ToString());
                    if (count > 0 && count < 2)
                    {
                        count = count + 1;

                        comm = new SqlCommand("UPDATE [scheduler_details] set scheduler_Name='BajajSchengenPolicy', [scheduler_failed_count] = " + count + ",[created]='" + System.DateTime.Now.ToShortDateString() + "' WHERE scheduler_Name='BajajSchengenPolicy' and created='" + System.DateTime.Now.ToShortDateString() + "'", conn);

                        try
                        {
                            int idresult = comm.ExecuteNonQuery();

                            if (idresult > 0)
                            {
                                //mail 2

                                StringBuilder st = new StringBuilder();
                                strSubject = "Bajaj Schengen API|Scheduler Failed";
                                st = st.Append("<p>Hi,</p>");
                                st = st.Append("<p>This is to notify that the process of transaction has been failed for the second time.</p>");
                                st = st.Append("<p>&nbsp;</p>");
                                st = st.Append("<p>Thanks&nbsp;<br /><br /></p>");
                                stb = st.ToString();
                                strTo = "vinod.pal@evolutionco.com";
                                strFrom = ConfigurationManager.AppSettings["frommail"].ToString();
                                bl.sendmail(strSubject, stb.ToString(), "", "", strFrom, strTo, "", "");
                            }
                        }
                        catch (Exception ex)
                        {



                        }
                    }
                    else if (count == 0)
                    {
                        count = 1;
                        comm = new SqlCommand("INSERT INTO [dbo].[scheduler_details] ([scheduler_failed_count],scheduler_Name,[created]) VALUES ( " + count + ",'" + "'BajajSchengenPolicy'" + (System.DateTime.Now.ToShortDateString()) + "')", conn);

                        try
                        {
                            int idresult = comm.ExecuteNonQuery();

                            if (idresult > 0)
                            {
                                //mail 1

                                StringBuilder st = new StringBuilder();
                                strSubject = "Bajaj Schengen API|Scheduler Failed";
                                st = st.Append("<p>Hi,</p>");
                                st = st.Append("<p>This is to notify that the process has been failed.</p>");
                                st = st.Append("<p>&nbsp;</p>");
                                st = st.Append("<p>Thanks&nbsp;<br /><br /></p>");
                                stb = st.ToString();
                                strTo = "vinod.pal@evolutionco.com";
                                strFrom = ConfigurationManager.AppSettings["frommail"].ToString();
                                bl.sendmail(strSubject, stb.ToString(), "", "", strFrom, strTo, "", "");
                            }
                        }
                        catch (Exception ex)
                        {



                        }
                    }
                }

            }
            catch (Exception ex)
            {

            }
            finally
            {
                conn.Close();

            }
        }
    }



    public bool IsReusable
    {
        get
        {
            return false;
        }
    }

}