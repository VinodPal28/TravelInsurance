// ******************************************************************************************
// Author           : Vinod Pal
// Description      : To upload bulk data of Policy
// Created On       : 06-08-2018 
// *******************************************************************************************
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.OleDb;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using System.IO;
using System.Collections;
using System.Text.RegularExpressions;
using System.Globalization;
using System.Data.SqlClient;

public partial class Admin_BulkUpload : System.Web.UI.Page
{
    ConnectionToSql ConSql = new ConnectionToSql();
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
                bool Authenticate = bl.CheckAuthority("BulkUpload.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                if (Session["UserId"] != null && Session["UserId"].ToString() != "0")
                {
                    if (Request.QueryString["success"] != null)
                    {
                        string strchk = Request.QueryString["success"].ToString();
                        lblmsg.Text = strchk;
                        lblmsg.ForeColor = Color.Green;
                    }
                }
                else
                {
                    Response.Redirect("../Home.aspx");
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

    protected void LnkBtn_Format_Click(object sender, EventArgs e)
    {
        object[] objColumns = null;
        objColumns = new object[] { "Plan_Name", "Travel_StartDate", "Travel_EndDate", "Customer_DOB", "Geography_Cover", "Total_Premium","Title", "Customer_First_Name", "Customer_Middle_Name", "Customer_Last_Name","Gender", "Customer_Mobile_No", "Customer_Email", "Customer_State", "Customer_City", "Customer_PinCode", "Customer_Address", "Customer_PAN", "Customer_Aadhaar","GSTIN","Passport","Travel_Type","NomineeName","NomineeRelation" };
        bl.ColumnsDownload(objColumns, "BulkUploadFormat");
    }

    protected void BtnUpload_Click(object sender, EventArgs e)
    {
        string fileExt = string.Empty;
        try
        {
            if (File_Upload.HasFile)
            {
                fileExt = System.IO.Path.GetExtension(File_Upload.FileName).ToLower();
                if (fileExt == ".xls" || fileExt == ".xlsx")
                {
                    if (!Directory.Exists(@"D:\BulkUpload\Policy\" + @"\"))
                    {
                        Directory.CreateDirectory(@"D:\BulkUpload\Policy\" + @"\");
                    }
                    string SavePath = @"D:\BulkUpload\Policy\"; //+ @"\";
                    string fileName = Path.GetFileNameWithoutExtension(File_Upload.FileName);
                    fileName += "_" + DateTime.Now.ToString("ddMMyyyyhhmm");
                    string pathToCheck = SavePath + fileName;
                    SavePath += fileName + fileExt;
                    File_Upload.SaveAs(SavePath);
                    DataTable dtRecords = GetExcelData(SavePath, Path.GetFileName(SavePath), fileExt);
                    if (dtRecords == null)
                    {
                        lblmsg.Visible = true;
                        lblmsg.ForeColor = Color.Red;
                        lblmsg.Text = "*Unable to read file";
                    }
                    else
                    {
                        if (dtRecords.Rows.Count == 0)
                        {
                            lblmsg.Visible = true;
                            lblmsg.ForeColor = Color.Red;
                            lblmsg.Text = "*Empty File/File Error";
                        }
                        else
                        {
                            Boolean isFileValid = ValidateFile(dtRecords);
                            if (isFileValid)
                            {
                                lblmsg.Visible = false;
                                try
                                {
                                    DataImport(dtRecords, SavePath, Session["UserId"].ToString());
                                }
                                catch (Exception ex)
                                {
                                    lblmsg.Visible = true;
                                    lblmsg.ForeColor = Color.Red;
                                    lblmsg.Text = "Unable to upload file - " + ex.Message;

                                }

                            }
                        }
                    }
                }
                else
                {
                    lblmsg.Visible = true;
                    lblmsg.ForeColor = Color.Red;
                    lblmsg.Text = "*Pls. import file in .xls format";
                }
            }
            else
            {
                lblmsg.Visible = true;
                lblmsg.ForeColor = Color.Red;
                lblmsg.Text = "*Pls. select a file in .xls format for import";
            }
        }
        catch (Exception ex)
        {
            lblmsg.Visible = true;
            lblmsg.ForeColor = Color.Red;
            lblmsg.Text = ex.Message.ToString();
        }
    }

    private DataTable GetExcelData(string pathOfSavedFile, string fileName, string fileExtension)
    {
        string strConnection = "";
        if (fileExtension == ".xls")
        {
            strConnection = "Provider=Microsoft.Jet.OLEDB.4.0;" + "Data Source=" + pathOfSavedFile + ";Extended Properties=\"Excel 8.0;IMEX=1\";";
        }
        else if (fileExtension == ".xlsx")
        {
            strConnection = "Provider=Microsoft.ACE.OLEDB.12.0;" + "Data Source=" + pathOfSavedFile + ";Extended Properties=\"Excel 12.0 Xml;HDR=YES;IMEX=1\";";
        }

        try
        {
            OleDbConnection dbconn = new OleDbConnection(strConnection);
            dbconn.Open();

            DataTable dtSheet = new DataTable();
            dtSheet = dbconn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
            String[] excelSheets = new String[dtSheet.Rows.Count];
            int jj = 0;
            foreach (DataRow row in dtSheet.Rows)
            {
                excelSheets[jj] = row["TABLE_NAME"].ToString();
                jj++;
            }
            string query = "SELECT * FROM [" + excelSheets[0] + "]";
            OleDbDataAdapter oda = new OleDbDataAdapter(query, dbconn);
            //DataSet ds = new DataSet();
            //oda.Fill(ds);
            DataTable dt = new DataTable();
            oda.Fill(dt);
            dbconn.Close();

            foreach (DataColumn dc in dt.Columns)
                dc.ColumnName = dc.ColumnName.Trim().ToUpper();
            return dt;
        }
        catch (Exception ex)
        {
            return null;
        }
    }

    private bool ValidateFile(DataTable dtRecords)
    {
        try
        {
            bool isvalid = true;
            object[] objMissingColumn = null;
            object[] listMandatory = null;


            objMissingColumn = new object[] { "Plan_Name", "Travel_StartDate", "Travel_EndDate", "Customer_DOB", "Geography_Cover", "Total_Premium", "Title", "Customer_First_Name", "Customer_Middle_Name", "Customer_Last_Name", "Gender", "Customer_Mobile_No", "Customer_Email", "Customer_State", "Customer_City", "Customer_PinCode", "Customer_Address", "Customer_PAN", "Customer_Aadhaar", "GSTIN", "Passport", "Travel_Type","NomineeName","NomineeRelation" };
            listMandatory = new object[] { "Plan_Name", "Travel_StartDate", "Travel_EndDate", "Customer_DOB", "Geography_Cover", "Total_Premium", "Title", "Customer_First_Name",  "Customer_Last_Name", "Gender", "Customer_Mobile_No", "Customer_Email", "Customer_State", "Customer_City", "Customer_PinCode", "Customer_Address", "Passport", "Travel_Type", "NomineeName", "NomineeRelation" };

            string MissingColumns = bl.ValidateColumn(dtRecords, objMissingColumn);
            if (MissingColumns != null && MissingColumns.Length != 0)
            {
                MissingColumns = MissingColumns.Remove(MissingColumns.LastIndexOf(','));
                lblmsg.Text = "Columns Missing : " + MissingColumns;
                lblmsg.ForeColor = System.Drawing.Color.Red;
                isvalid = false;
            }

            if (isvalid)
            {
                if (dtRecords != null)
                {
                    isvalid = bl.RequiredField(dtRecords, listMandatory);
                }
                else
                {
                    lblmsg.Text = "Empty File/Error Reading" + MissingColumns;
                    lblmsg.ForeColor = System.Drawing.Color.Red;
                    isvalid = false;
                }
            }

            return isvalid;
        }
        catch (Exception ex)
        {
            //ObjErr.WriteError(ex.Message);
            return false;
        }
    }

    public void DataImport(DataTable dtRecords, string filepath, string dealerid)
    {
        try
        {
            int strcount = dtRecords.Rows.Count;
            int uploadedcount = 0;
            int totalRecords = dtRecords.Rows.Count;
            int rowindex = 2;
            string Remarks = string.Empty;
            bool uploaded = true;
            int errCount = 0, maxErrCount = 0;

            #region Validation Switches
            bool valid = true;

            #endregion
            ArrayList listError = new ArrayList();

            listError.Add("Customer_Name" + "," + "UPLOADED" + "," + "REMARKS");

            object[] objData = null;           //OBJECT LENGTH
            DataSet ds_insert = new DataSet();

            //string[] dateFormatMDY = new string[] { "MM/dd/yyyy", "M/dd/yyyy", "M/d/yyyy", "MM/d/yyyy" };
            //string[] dateFormatDMMMY = new string[] { "dd-MMM-yyyy", "d-MMM-yyyy", "dd-MMM-yy", "d-MMM-yy" };
            string[] dateFormatDMY = new string[] { "dd/MM/yyyy", "d/MM/yyyy", "d/M/yyyy", "dd/M/yyyy" };
            //string[] dateFormatYMD = new string[] { "yyyy-MM-dd", "yyyy-MM-d", "yyyy-M-d", "yyyy-M-dd" };

            DateTime dtOut;
            #region Start Of For Loop
            foreach (DataRow row in dtRecords.Select())
            {
                valid = uploaded = true;
                Remarks = string.Empty;
                #region Data Retrieval
                objData = GetData(dealerid, row);
                #endregion
                if (objData != null)
                {
                    if (valid)
                    {
                        #region  Validations                                             

                        if (Regex.IsMatch(objData[7].ToString(), @"^[a-zA-Z ]+$"))
                        {
                            if (objData[7].ToString().Length <= 2)
                            {
                                valid = false;
                                Remarks += ",Invalid Customer_First_Name - " + objData[7].ToString();
                                uploaded = uploaded && false;
                            }
                        }
                        else
                        {
                            valid = false;
                            Remarks += ",Invalid Customer_First_Name - " + objData[7].ToString();
                            uploaded = uploaded && false;
                        }
                        if (objData[8].ToString() != "" && !Regex.IsMatch(objData[8].ToString(), @"^[a-zA-Z ]+$"))
                        {
                            valid = false;
                            Remarks += ",Invalid Customer_Middle_Name - " + objData[8].ToString();
                            uploaded = uploaded && false;
                        }
                        if (!Regex.IsMatch(objData[9].ToString(), @"^[a-zA-Z ]+$"))
                        {
                            valid = false;
                            Remarks += ",Invalid Customer_Last_Name - " + objData[9].ToString();
                            uploaded = uploaded && false;
                        }

                        #endregion
                        #region Date Validations
                        string date = objData[1].ToString();
                        string subdate = date.IndexOf(' ') != -1 ? date.Substring(0, date.IndexOf(' ')) : date;

                        if (DateTime.TryParseExact(subdate, dateFormatDMY, null, DateTimeStyles.None, out dtOut))
                        {
                            objData[1] = dtOut.ToString("dd/MMM/yyyy");
                        }
                        else
                        {
                            valid = false;
                            Remarks += ",Travel_StartDate format should be in dd/MM/yyyy - " + date.ToString();
                            uploaded = uploaded && false;
                        }

                        date = objData[2].ToString();
                        subdate = date.IndexOf(' ') != -1 ? date.Substring(0, date.IndexOf(' ')) : date;
                        if (DateTime.TryParseExact(subdate, dateFormatDMY, null, DateTimeStyles.None, out dtOut))
                        {
                            objData[2] = dtOut.ToString("dd/MMM/yyyy");
                        }
                        else
                        {
                            valid = false;
                            Remarks += ",Travel_EndDate format should be in dd/MM/yyyy - " + date.ToString();
                            uploaded = uploaded && false;
                        }
                        if(Convert.ToDateTime(objData[1]) > Convert.ToDateTime(objData[2]))
                        {
                            valid = false;
                            Remarks += ",Travel EndDate should be greater than start date ";
                            uploaded = uploaded && false;
                        }
                        date = objData[3].ToString();
                        subdate = date.IndexOf(' ') != -1 ? date.Substring(0, date.IndexOf(' ')) : date;
                        if (DateTime.TryParseExact(subdate, dateFormatDMY, null, DateTimeStyles.None, out dtOut))
                        {
                            objData[3] = dtOut.ToString("dd/MMM/yyyy");
                        }
                        else
                        {
                            valid = false;
                            Remarks += ",Customer_DOB format should be in dd/MM/yyyy - " + date.ToString();
                            uploaded = uploaded && false;
                        }
                        if (objData[11].ToString() != "" && !Regex.IsMatch(objData[11].ToString(), @"^[0-9]+$"))
                        {
                            valid = false;
                            Remarks += ",Invalid mobile no - " + objData[11].ToString();
                            uploaded = uploaded && false;
                        }
                        if (objData[11].ToString() != "" && objData[11].ToString().Length!=10)
                        {
                            valid = false;
                            Remarks += ",mobile no should be 10 digits - " + objData[11].ToString();
                            uploaded = uploaded && false;
                        }
                        if (objData[12].ToString() != "" && !Regex.IsMatch(objData[12].ToString(), @"\A(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?)\Z", RegexOptions.IgnoreCase))
                        {
                            valid = false;
                            Remarks += ",Invalid email id - " + objData[12].ToString();
                            uploaded = uploaded && false;
                        }
                        if (objData[15].ToString() != "" && !Regex.IsMatch(objData[15].ToString(), @"^[0-9]+$"))
                        {
                            valid = false;
                            Remarks += ",Invalid pin code - " + objData[15].ToString();
                            uploaded = uploaded && false;
                        }
                        if (objData[15].ToString() != "" && objData[15].ToString().Length!=6)
                        {
                            valid = false;
                            Remarks += ",Pin code should be 6 digits - " + objData[15].ToString();
                            uploaded = uploaded && false;
                        }
                        if (objData[17].ToString() != "" && !Regex.IsMatch(objData[17].ToString(), @"^[a-zA-z]{5}[0-9]{4}[a-zA-Z]{1}", RegexOptions.IgnoreCase))
                        {
                            valid = false;
                            Remarks += ",Invalid PAN No. - " + objData[17].ToString();
                            uploaded = uploaded && false;
                        }
                        if (objData[18].ToString() != "" && !Regex.IsMatch(objData[18].ToString(), @"^[0-9]{12}", RegexOptions.IgnoreCase))
                        {
                            valid = false;
                            Remarks += ",Invalid Aadhaar No. - " + objData[18].ToString();
                            uploaded = uploaded && false;
                        }
                        if (objData[19].ToString() != "" && !Regex.IsMatch(objData[19].ToString(), @"^[0-9]{2}[a-zA-Z]{5}[0-9]{4}[a-zA-Z]{1}[0-9]{1}[zZ]{1}[0-9]{1}", RegexOptions.IgnoreCase))
                        {
                            valid = false;
                            Remarks += ",Invalid GSTIN No. - " + objData[19].ToString() + ". It should be in this '11AAAAA1111A1Z1' format";
                            uploaded = uploaded && false;
                        }
                        if (objData[20].ToString() != "" && !Regex.IsMatch(objData[20].ToString(), @"^[a-zA-Z]{1}[0-9]{7}", RegexOptions.IgnoreCase))
                        {
                            valid = false;
                            Remarks += ",Invalid passport no. - " + objData[20].ToString();
                            uploaded = uploaded && false;
                        }
                        #endregion

                        if (valid)
                        {

                            #region INSERTING DATA
                            if (valid)
                            {
                                try
                                {
                                    using (DataSet tmpds = ConSql.ExecuteReader("Allianz_Travel", "USP_InsPolicyBulkData", objData))
                                    {
                                        if (tmpds != null)
                                        {
                                            if (tmpds.Tables[0].Rows[0][0].ToString().ToUpper() == "I")
                                            {                                              
                                                Remarks += ",Imported Successfully";
                                                uploaded = uploaded && true;
                                                uploadedcount++;
                                            }
                                           else if (tmpds.Tables[0].Rows[0][0].ToString().ToUpper() == "INVALID_PLAN_NAME")
                                            {
                                                Remarks += ",Invalid Plan Name - "+ objData[0].ToString();
                                                uploaded = uploaded && false;
                                                //uploadedcount++;
                                            }
                                            else if (tmpds.Tables[0].Rows[0][0].ToString().ToUpper() == "INVALID_GEOCOVER_NAME")
                                            {
                                                Remarks += ",Invalid Geography Name - " + objData[4].ToString();
                                                uploaded = uploaded && false;
                                                //uploadedcount++;
                                            }
                                            else
                                            {
                                                Remarks += ",Unknown Error - " + tmpds.Tables[0].Rows[0][1].ToString();
                                                uploaded = uploaded && false;
                                            }
                                        }
                                        else
                                        {
                                            Remarks += "," + "DB Error - Insertion";
                                            uploaded = uploaded && false;
                                        }
                                    }
                                }
                                catch (SqlException SqlEx)
                                {
                                    if (SqlEx.Number == 2601)
                                    {
                                        Remarks += "," + "Duplicate";
                                    }
                                    else
                                    {
                                        Remarks += "," + "Unknown Error - " + SqlEx.Message;
                                    }

                                    uploaded = uploaded && false;
                                }
                            }
                            #endregion
                        }
                    }
                }
                else
                {
                    valid = false;
                    Remarks += ",System Error, Retrieval Failure - Row No : " + rowindex.ToString();
                    uploaded = uploaded && false;
                }

                #region Adding To Error List

                if (!string.IsNullOrEmpty(Remarks))
                {
                    errCount = Remarks.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries).Length;
                    if (errCount > maxErrCount)
                        maxErrCount = errCount;

                    string isupload = uploaded ? "YES" : "NO";

                    Remarks = objData[7].ToString() + "," + isupload + Remarks;
                    listError.Add(Remarks);
                }
                #endregion
                rowindex++;
            } //end of for
            #endregion                  
            if (strcount != uploadedcount)
            {
                //lblmsg.Text = "Data uploading error";
                //lblmsg.ForeColor = Color.Red;  
                bl.DownloadCSV(listError, "UploadError");
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "messageshow();", true);
            }
            else
            {
                Response.Redirect("BulkUpload.aspx?success=Data uploaded successfully", false);
                //lblmsg.Text = "Data uploaded successfully";
                //lblmsg.ForeColor = Color.Green;
            }

        }

        catch (Exception ex)
        {
            lblmsg.Text = "Error!" + ex.Message.ToString();
            lblmsg.ForeColor = Color.Red;
        }
    }

    private object[] GetData(string dealerid, DataRow row)
    {

        object[] objData;
        try
        {
            objData = new object[26];
            objData[0] = row["Plan_Name"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[1] = row["Travel_StartDate"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');//console_date
            objData[2] = row["Travel_EndDate"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[3] = row["Customer_DOB"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');//uid_no
            objData[4] = row["Geography_Cover"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[5] = row["Total_Premium"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[6] = row["Title"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[7] = row["Customer_First_Name"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[8] = row["Customer_Middle_Name"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[9] = row["Customer_Last_Name"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[10] = row["Gender"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[11] = row["Customer_Mobile_No"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[12] = row["Customer_Email"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[13] = row["Customer_State"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[14] = row["Customer_City"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[15] = row["Customer_PinCode"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[16] = row["Customer_Address"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[17] = row["Customer_PAN"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[18] = row["Customer_Aadhaar"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[19] = row["GSTIN"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[20] = row["Passport"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[21] = row["Travel_Type"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[22] = row["NomineeName"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[23] = row["NomineeRelation"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');
            objData[24] = dealerid;
            objData[25] = dealerid;
        }
        catch (Exception ex)
        {
            //ObjErr.WriteError(ex.Message);
            return null;
        }

        return objData;
    }

}