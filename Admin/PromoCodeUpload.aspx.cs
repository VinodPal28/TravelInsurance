// ******************************************************************************************
// Author           : JAMAL AHMAD
// Description      : To upload bulk data 
// Created On       : 17-10-2018 
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
public partial class Admin_PromoCodeUpload : System.Web.UI.Page
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
                bool Authenticate = bl.CheckAuthority("Masters", Session["UserTypeId"].ToString());
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
        objColumns = new object[] { "PromoCode" };
        bl.ColumnsDownload(objColumns, "PromoUploadFormat");
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
                    if (!Directory.Exists(@"D:\BulkUpload\PromoCode\" + @"\"))
                    {
                        Directory.CreateDirectory(@"D:\BulkUpload\PromoCode\" + @"\");
                    }
                    string SavePath = @"D:\BulkUpload\PromoCode\"; //+ @"\";
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


            objMissingColumn = new object[] { "PromoCode" };
            listMandatory = new object[] { "PromoCode" };

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

            listError.Add("PromoCode" + "," + "UPLOADED" + "," + "REMARKS");

            object[] objData = null;           //OBJECT LENGTH
            DataSet ds_insert = new DataSet();
    
            string[] dateFormatDMY = new string[] { "dd/MM/yyyy", "d/MM/yyyy", "d/M/yyyy", "dd/M/yyyy" };
          
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

                        if (!Regex.IsMatch(objData[1].ToString(), @"^[a-zA-Z0-9]+$"))
                        {
                           
                                valid = false;
                                Remarks += ",Invalid Promo Code - " + objData[1].ToString();
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
                                    // using (DataSet tmpds = ConSql.ExecuteReader("Allianz_Travel", "USP_InsPolicyBulkData", objData))
                                    using (DataSet tmpds = ConSql.ExecuteReader("Allianz_Travel", "USP_InsertPromoCode", objData))
                                    {
                                        if (tmpds != null)
                                        {
                                            if (tmpds.Tables[0].Rows[0][0].ToString().ToUpper() == "I")
                                            {
                                                Remarks += ",Imported Successfully";
                                                uploaded = uploaded && true;
                                                uploadedcount++;
                                            }
                                            else if (tmpds.Tables[0].Rows[0][0].ToString().ToUpper() == "D")
                                            {
                                                Remarks += ",Duplicate Promo code - " + objData[1].ToString();
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

                    Remarks = objData[1].ToString() + "," + isupload + Remarks;
                    listError.Add(Remarks);
                }
                #endregion
                rowindex++;
            } //end of for
            #endregion                  
            if (strcount != uploadedcount)
            {

                //lblmsg.Text = "";
                bl.DownloadCSV(listError, "UploadError");
                //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "messageshow();", true);
            }
            else
            {
                Response.Redirect("PromoCodeUpload.aspx?success=Data uploaded successfully", false);
              
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
            objData = new object[3];
            objData[0] = "Save";
            objData[1] = row["PromoCode"].ToString().Trim(' ').Trim('~').Trim().Trim('\'');           
            objData[2] = dealerid;

        }
        catch (Exception ex)
        {
            //ObjErr.WriteError(ex.Message);
            return null;
        }

        return objData;
    }

    protected void btnExcelExport_Click(object sender, EventArgs e)
    {
        DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_InsertPromoCode", new object[] { "ExportToExcel", "", 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            string FileName = "PromoCode_" + DateTime.Now.ToString("dd-MM-yyyy");
            bl.DownloadXLS(ds.Tables[0], FileName);
        }
        else
        {
            lblmsg.Text = "No Record Found";
            lblmsg.ForeColor = Color.Red;
        }
    }
}