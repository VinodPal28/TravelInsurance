// ******************************************************************************************
// Author           : Manish Jha
// Description      : A class used for common business logics/methods may be used across the application
// Created On       : 26-Apr-2018
// For Travel Insurance Portal      
// *******************************************************************************************

using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Configuration;
using System.Threading;
using System.Net;

/// <summary>
/// Summary description for BusinessLogic
/// </summary>
public class BusinessLogic
{
    ConnectionToSql con = new ConnectionToSql();
    public void ColumnsDownload(object[] objColumns, string strFileName)
    {
        try
        {
            DataTable dtColumns = new DataTable();
            for (int i = 0; i < objColumns.Length; i++)
            {
                dtColumns.Columns.Add(objColumns[i].ToString());
            }
            DownloadXLS(dtColumns, strFileName);
        }
        catch (System.Threading.ThreadAbortException err)
        {

        }
        catch (Exception err)
        {
            //ErrHandler.WriteError(err.Message.ToString());
        }
    }
    public void DownloadXLS(DataTable dt, string Report)
    {
        HttpResponse Response = HttpContext.Current.Response;
        string attachment = "attachment; filename=" + Report + ".xls";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/vnd.ms-excel";
        string tab = "";
        foreach (DataColumn dc in dt.Columns)
        {
            Response.Write(tab + dc.ColumnName);
            tab = "\t";
        }
        Response.Write("\n");

        foreach (DataRow dr in dt.Rows)
        {
            tab = "";
            for (int i = 0; i < dt.Columns.Count; i++)
            {
                Response.Write(tab + dr[i].ToString());
                tab = "\t";
            }
            Response.Write("\n");
        }
        Response.End();
    }
    public string ValidateColumn(DataTable dt, object[] obj)
    {
        string str = null;
        for (int i = 0; i < obj.Length; i++)
        {
            if (!dt.Columns.Contains(obj[i].ToString()))
            {
                str += obj[i] + ",";
            }
        }
        return (str);
    }
    public bool RequiredField(DataTable dtin, object[] obj)
    {
        DataTable dt = new DataTable();
        DataRow row;
        bool valid = true;
        string temp = null;
        for (int i = 0; i < dtin.Rows.Count; i++)
        {
            for (int j = 0; j < obj.Length; j++)
            {
                if (dtin.Rows[i][obj[j].ToString()].ToString().Trim(' ').Trim().Length == 0)
                {
                    if (dt.Columns.Count <= 0)
                    {
                        dt = table(new object[] { "ROW_NO", "COLUMN_NAME", "REMARKS" });
                    }
                    temp = Convert.ToString(i + 2) + "," + obj[j].ToString() + "," + "CAN NOT BE EMPTY";
                    row = Rows(dt, temp);
                    dt.Rows.Add(row);
                    valid = false;
                }
            }
        }
        if (valid == false)
        {
            DownloadXLS(dt, "ERRORREPORT");
        }
        return valid;
    }
    public DataTable table(object[] obj)
    {
        DataTable dt = new DataTable();
        for (int i = 0; i < obj.Length; i++)
        {
            dt.Columns.Add(new DataColumn(obj[i].ToString(), typeof(string)));
        }
        return dt;
    }
    public DataRow Rows(DataTable dt, string str)
    {
        DataRow row;
        row = dt.NewRow();
        for (int i = 0; i < dt.Columns.Count; i++)
        {
            string[] temp = str.Split(new char[] { ',' }, 3);
            for (int j = 0; j < temp.Length; j++)
            {
                row[dt.Columns[i].ToString()] = temp[j];
                i++;
            }
        }
        return row;
    }
    public void DownloadCSV(ArrayList listError, string Report)
    {
        HttpResponse Response = HttpContext.Current.Response;
        string attachment = "attachment; filename=" + Report + ".csv";
        Response.ClearContent();
        Response.AddHeader("content-disposition", attachment);
        Response.ContentType = "application/vnd.ms-excel";

        foreach (string str in listError)
        {
            Response.Write(str + "\n");
        }
        Response.End();
    }
    public bool sendmail(string subject, string body, string attachment, string attachment2, string mailfrom, string mailto, string mailcc, string mailbcc)
    {

        try
        {
            MailMessage mail = new MailMessage();
           
            mail.From = new MailAddress(ConfigurationManager.AppSettings["frommail"].ToString());//your mail id
                                                                                                 //  mail.To.Add(mailto);
            mail.Subject = subject;
            mail.IsBodyHtml = true;
            mail.Body = body;
            SmtpClient smc = new SmtpClient();
            smc.EnableSsl = true;
            smc.Credentials = System.Net.CredentialCache.DefaultNetworkCredentials;
            smc.Credentials = new System.Net.NetworkCredential("vinod.pal@evolutionco.com", "Vinod@1234");
            smc.Host = "smtp.gmail.com";
            smc.Port = 587;
            //With authentication
            mail.From = new MailAddress(mailfrom);
            if (!string.IsNullOrEmpty(mailto))
            {
                mail.To.Add(mailto);
            }

            if (!string.IsNullOrEmpty(mailcc))
            {
                mail.CC.Add(mailcc);
            }
            if (!string.IsNullOrEmpty(mailbcc))
            {
                mail.Bcc.Add(mailbcc);
            }
            mail.Subject = subject;
            mail.Body = body;
            if (!string.IsNullOrEmpty(attachment))
            {
                Attachment attach = new Attachment(attachment);
                mail.Attachments.Add(attach);
            }
            if (!string.IsNullOrEmpty(attachment2))
            {
                Attachment attach2 = new Attachment(attachment2);
                mail.Attachments.Add(attach2);

              
            }
            smc.Send(mail);

            
            return true;

        }
        catch (Exception ex)
        {
            LogError(ex, "Email");
            return false;
        }

    }
    public void LogError(Exception ex, string errorfor)
    {
        string message = string.Format("Time: {0}", DateTime.Now.ToString("dd/MM/yyyy hh:mm:ss tt"));
        message += Environment.NewLine;
        message += "-----------------------------------------------------------";
        message += Environment.NewLine;
        message += string.Format("Message: {0}", ex.Message);
        message += Environment.NewLine;
        message += string.Format("StackTrace: {0}", ex.StackTrace);
        message += Environment.NewLine;
        message += string.Format("Source: {0}", ex.Source);
        message += Environment.NewLine;
        message += string.Format("TargetSite: {0}", ex.TargetSite.ToString());
        message += Environment.NewLine;
        message += "-----------------------------------------------------------";
        message += Environment.NewLine;
        string path = System.Web.HttpContext.Current.Server.MapPath("~/Files/Error.txt");
        using (StreamWriter writer = new StreamWriter(path, true))
        {
            writer.WriteLine(message + errorfor);
            writer.Close();
        }
    }
    public static string QueryStringEncode(string QS)
    {
        try
        {
            byte[] encData_byte = new byte[QS.Length];
            encData_byte = System.Text.Encoding.UTF8.GetBytes(QS);
            string encodedData = Convert.ToBase64String(encData_byte);
            return encodedData;
        }
        catch (Exception e)
        {
            throw new Exception("Error in base64Encode" + e.Message);
        }

    }

    public static string QueryStringDecode(string QS)
    {
        System.Text.UTF8Encoding encoder = new System.Text.UTF8Encoding();
        System.Text.Decoder utf8Decode = encoder.GetDecoder();
        byte[] todecode_byte = Convert.FromBase64String(QS);
        int charCount = utf8Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
        char[] decoded_char = new char[charCount];
        utf8Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
        string result = new String(decoded_char);
        return result;
    }

    public bool CheckAuthority(string PageName, string UserType)
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_CheckAuthority", new object[] { "Check", PageName, 0, 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            if (ds.Tables[0].Rows[0]["Authen_User"].ToString().Contains(UserType))
            {
                return true;
            }
            else
            {
                return false;
            }
        }
        else
        {
            return false;
        }
    }

    public bool sendmailMatrix(string subject, string body, string attachment, string attachment2, string mailfrom, string mailto, string mailcc, string mailbcc)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(ConfigurationManager.AppSettings["frommail"].ToString());//your mail id
            //mail.To.Add(mailto);
            mail.Subject = subject;
            mail.IsBodyHtml = true;
            mail.Body = body;
            SmtpClient smc = new SmtpClient();
            smc.EnableSsl = true;
            smc.Credentials = System.Net.CredentialCache.DefaultNetworkCredentials;
            smc.Credentials = new System.Net.NetworkCredential("jamal6857@gmail.com", "boot@9910");
            smc.Host = "smtp.gmail.com";
            smc.Port = 587;
            //With authentication
            mail.From = new MailAddress(mailfrom);
            if (!string.IsNullOrEmpty(mailto))
            {
                mail.To.Add(mailto);
            }

            if (!string.IsNullOrEmpty(mailcc))
            {
                mail.CC.Add(mailcc);
            }
            if (!string.IsNullOrEmpty(mailbcc))
            {
                mail.Bcc.Add(mailbcc);
            }
            mail.Subject = subject;
            mail.Body = body;
            if (!string.IsNullOrEmpty(attachment))
            {
                Attachment attach = new Attachment(attachment);
                mail.Attachments.Add(attach);
            }
            if (!string.IsNullOrEmpty(attachment2))
            {
                Attachment attach2 = new Attachment(attachment2);
                mail.Attachments.Add(attach2);
            }

            smc.Send(mail);

            //for client
            //MailMessage mail = new MailMessage("insurance@matrix.in", mailto);
            //mail.IsBodyHtml = true;
            //mail.Body = body;
            //SmtpClient smc = new SmtpClient();
            ////smc.EnableSsl = true;
            ////smc.Credentials = System.Net.CredentialCache.DefaultNetworkCredentials;
            ////smc.Credentials = new System.Net.NetworkCredential("jamal6857@gmail.com", "boot@9910");
            //smc.Host = "Tmu.mail.allianz";//"Techuser.mail.allianz";
            //smc.Port = 25;
            //smc.DeliveryMethod = SmtpDeliveryMethod.Network;
            //smc.UseDefaultCredentials = false;
            ////With authentication
            ////mail.From = new MailAddress(mailfrom);
            ////if (!string.IsNullOrEmpty(mailto))
            ////{
            //    //mail.To.Add(mailto);
            ////}
            //mail.Subject = subject;
            //if (!string.IsNullOrEmpty(mailcc))
            //{
            //    mail.CC.Add(mailcc);
            //}
            //if (!string.IsNullOrEmpty(mailbcc))
            //{
            //    mail.Bcc.Add(mailbcc);
            //}
            //mail.Subject = subject;
            //mail.Body = body;
            //if (!string.IsNullOrEmpty(attachment))
            //{
            //    Attachment attach = new Attachment(attachment);
            //    mail.Attachments.Add(attach);
            //}
            //if (!string.IsNullOrEmpty(attachment2))
            //{
            //    Attachment attach2 = new Attachment(attachment2);
            //    mail.Attachments.Add(attach2);
            //}
            //smc.Send(mail);
            return true;
        }
        catch (Exception ex)
        {
            LogError(ex, "Email");
            return false;
        }
    }

    public bool sendmailattach(string subject, string body, string attachment, string attachment2, string attachment3, string mailfrom, string mailto, string mailcc, string mailbcc)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(ConfigurationManager.AppSettings["frommail"].ToString());//your mail id
            //mail.To.Add(mailto);
            mail.Subject = subject;
            mail.IsBodyHtml = true;
            mail.Body = body;
            SmtpClient smc = new SmtpClient();
            smc.EnableSsl = true;
            smc.Credentials = System.Net.CredentialCache.DefaultNetworkCredentials;
            smc.Credentials = new System.Net.NetworkCredential("vinod.pal@evolutionco.com", "Vinod@1234");
            smc.Host = "smtp.gmail.com";
            smc.Port = 587;
            //With authentication
            mail.From = new MailAddress(mailfrom);
            if (!string.IsNullOrEmpty(mailto))
            {
                mail.To.Add(mailto);
            }

            if (!string.IsNullOrEmpty(mailcc))
            {
                mail.CC.Add(mailcc);
            }
            if (!string.IsNullOrEmpty(mailbcc))
            {
                mail.Bcc.Add(mailbcc);
            }
            mail.Subject = subject;
            mail.Body = body;
            if (!string.IsNullOrEmpty(attachment))
            {
                Attachment attach = new Attachment(attachment);
                mail.Attachments.Add(attach);
            }
            if (!string.IsNullOrEmpty(attachment2))
            {
                Attachment attach2 = new Attachment(attachment2);
                mail.Attachments.Add(attach2);
            }
            if (!string.IsNullOrEmpty(attachment3))
            {
                Attachment attach3 = new Attachment(attachment3);
                mail.Attachments.Add(attach3);
            }
            smc.Send(mail);

            //for client
            //MailMessage mail = new MailMessage(ConfigurationManager.AppSettings["frommail"].ToString(), mailto);
            //mail.IsBodyHtml = true;
            //mail.Body = body;
            //SmtpClient smc = new SmtpClient();
            ////smc.EnableSsl = true;
            ////smc.Credentials = System.Net.CredentialCache.DefaultNetworkCredentials;
            ////smc.Credentials = new System.Net.NetworkCredential("jamal6857@gmail.com", "boot@9910");
            //smc.Host = "Tmu.mail.allianz";//"Techuser.mail.allianz";
            //smc.Port = 25;
            //smc.DeliveryMethod = SmtpDeliveryMethod.Network;
            //smc.UseDefaultCredentials = false;
            ////With authentication
            ////mail.From = new MailAddress(mailfrom);
            ////if (!string.IsNullOrEmpty(mailto))
            ////{
            //    //mail.To.Add(mailto);
            ////}
            //mail.Subject = subject;
            //if (!string.IsNullOrEmpty(mailcc))
            //{
            //    mail.CC.Add(mailcc);
            //}
            //if (!string.IsNullOrEmpty(mailbcc))
            //{
            //    mail.Bcc.Add(mailbcc);
            //}
            //mail.Subject = subject;
            //mail.Body = body;
            //if (!string.IsNullOrEmpty(attachment))
            //{
            //    Attachment attach = new Attachment(attachment);
            //    mail.Attachments.Add(attach);
            //}
            //if (!string.IsNullOrEmpty(attachment2))
            //{
            //    Attachment attach2 = new Attachment(attachment2);
            //    mail.Attachments.Add(attach2);
            //}
            //if (!string.IsNullOrEmpty(attachment3))
            //{
            //    Attachment attach3 = new Attachment(attachment3);
            //    mail.Attachments.Add(attach3);
            //}
            //smc.Send(mail);
            return true;
        }
        catch (Exception ex)
        {
            LogError(ex, "Email");
            return false;
        }
    }

    public bool sendmailattachMatrix(string subject, string body, string attachment, string attachment2, string attachment3, string mailfrom, string mailto, string mailcc, string mailbcc)
    {
        try
        {
            MailMessage mail = new MailMessage();
            mail.From = new MailAddress(ConfigurationManager.AppSettings["frommail"].ToString());//your mail id
            //mail.To.Add(mailto);
            mail.Subject = subject;
            mail.IsBodyHtml = true;
            mail.Body = body;
            SmtpClient smc = new SmtpClient();
            smc.EnableSsl = true;
            smc.Credentials = System.Net.CredentialCache.DefaultNetworkCredentials;
            smc.Credentials = new System.Net.NetworkCredential("jamal6857@gmail.com", "boot@9910");
            smc.Host = "smtp.gmail.com";
            smc.Port = 587;
            //With authentication
            mail.From = new MailAddress(mailfrom);
            if (!string.IsNullOrEmpty(mailto))
            {
                mail.To.Add(mailto);
            }

            if (!string.IsNullOrEmpty(mailcc))
            {
                mail.CC.Add(mailcc);
            }
            if (!string.IsNullOrEmpty(mailbcc))
            {
                mail.Bcc.Add(mailbcc);
            }
            mail.Subject = subject;
            mail.Body = body;
            if (!string.IsNullOrEmpty(attachment))
            {
                Attachment attach = new Attachment(attachment);
                mail.Attachments.Add(attach);
            }
            if (!string.IsNullOrEmpty(attachment2))
            {
                Attachment attach2 = new Attachment(attachment2);
                mail.Attachments.Add(attach2);
            }
            if (!string.IsNullOrEmpty(attachment3))
            {
                Attachment attach3 = new Attachment(attachment3);
                mail.Attachments.Add(attach3);
            }
            smc.Send(mail);

            //for client
            //MailMessage mail = new MailMessage("insurance@matrix.in", mailto);
            //mail.IsBodyHtml = true;
            //mail.Body = body;
            //SmtpClient smc = new SmtpClient();
            ////smc.EnableSsl = true;
            ////smc.Credentials = System.Net.CredentialCache.DefaultNetworkCredentials;
            ////smc.Credentials = new System.Net.NetworkCredential("jamal6857@gmail.com", "boot@9910");
            //smc.Host = "Tmu.mail.allianz";//"Techuser.mail.allianz";
            //smc.Port = 25;
            //smc.DeliveryMethod = SmtpDeliveryMethod.Network;
            //smc.UseDefaultCredentials = false;
            ////With authentication
            ////mail.From = new MailAddress(mailfrom);
            ////if (!string.IsNullOrEmpty(mailto))
            ////{
            //    //mail.To.Add(mailto);
            ////}
            //mail.Subject = subject;
            //if (!string.IsNullOrEmpty(mailcc))
            //{
            //    mail.CC.Add(mailcc);
            //}
            //if (!string.IsNullOrEmpty(mailbcc))
            //{
            //    mail.Bcc.Add(mailbcc);
            //}
            //mail.Subject = subject;
            //mail.Body = body;
            //if (!string.IsNullOrEmpty(attachment))
            //{
            //    Attachment attach = new Attachment(attachment);
            //    mail.Attachments.Add(attach);
            //}
            //if (!string.IsNullOrEmpty(attachment2))
            //{
            //    Attachment attach2 = new Attachment(attachment2);
            //    mail.Attachments.Add(attach2);
            //}
            //if (!string.IsNullOrEmpty(attachment3))
            //{
            //    Attachment attach3 = new Attachment(attachment3);
            //    mail.Attachments.Add(attach3);
            //}
            //smc.Send(mail);
            return true;
        }
        catch (Exception ex)
        {
            LogError(ex, "Email");
            return false;
        }
    }

    public bool sendsms(string smsapiurl, string mobileno, string msgcontent)
    {
        try
        {
            string xmlstring = "<?xml version=\"1.0\"?><a2wml version=\"2.0\"><request ACODE=\"AGASERVICES\" accId=\"516680\" pin=\"ags@1\"><fromAddress>AZTRVL</fromAddress><recipientList><destAddress>" + mobileno + "</destAddress></recipientList><message><messageType></messageType><port></port><udh></udh><messageTxt>" + msgcontent + "</messageTxt ><odRequestId ></odRequestId><custref></custref><billref ></billref><splitAlgm></splitAlgm><scheduleTime></scheduleTime><expiryMinutes></expiryMinutes><dlrtype></dlrtype ><priority></priority></message></request></a2wml>";
            byte[] bytes = null;
            ServicePointManager.MaxServicePointIdleTime = 1000;
            ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(smsapiurl);
            //WebProxy myProxy = new WebProxy();
            //Uri newUri = new Uri("http://10.125.128.35:8080/");
            //Uri newUri = new Uri("http://172.30.251.13:8080");
            //myProxy.Address = newUri;
            ////myProxy.Credentials = new NetworkCredential("sandhyas", "Allianz@123");
            //request.Proxy = myProxy;
            //request.Proxy = new WebProxy("http://fr003-ap1-svr.zone3.proxy.allianz:8090", true);
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
            return true;
        }
        catch (Exception exsms)
        {
            return false;
        }
    }
}
