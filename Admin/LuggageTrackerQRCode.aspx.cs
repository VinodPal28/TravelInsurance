using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text.RegularExpressions;

public partial class Admin_QRCode : System.Web.UI.Page
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
                bool Authenticate = bl.CheckAuthority("Masters", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                Bind_QRCode();
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

    #region Rename File Name
    public string RenameFile(string FileName)
    {
        string fileNameWithoutExtension = Path.GetFileNameWithoutExtension(FileName);
        string fileExtension = Path.GetExtension(FileName);
        return fileNameWithoutExtension + DateTime.Now.ToString("mmddyyHHmmssffff") + fileExtension;
    }
    #endregion
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        try
        {
            int uploadedcnt = 0;
            int FileNo = 0;
            string DuplicateFileName = string.Empty;
            foreach (HttpPostedFile postedFile in fileUpload1.PostedFiles)
            {
                FileNo = fileUpload1.PostedFiles.Count;
                //if (fileUpload1.HasFile)
                //{
                if (postedFile.ContentType == "application/pdf")
                {
                    Regex QRCheck = new Regex("^[a-zA-Z]{2}[0-9]{10}");
                    string filename = Path.GetFileName(postedFile.FileName);
                    string QRCode = Path.GetFileNameWithoutExtension(postedFile.FileName);
                    // string A = RenameFile(QRCode);
                    if (Path.GetExtension(postedFile.FileName).ToString().ToUpper() == ".PDF")
                    {

                        if (QRCheck.IsMatch(QRCode))
                        {
                            string dir = Server.MapPath("~/QRCodeFile/");
                            if (!Directory.Exists(dir))
                            {
                                Directory.CreateDirectory(dir);
                            }
                            using (Stream fs = postedFile.InputStream)
                            {
                                using (BinaryReader br = new BinaryReader(fs))
                                {
                                    byte[] bytes = br.ReadBytes((Int32)fs.Length);

                                    // fileUpload1.SaveAs(Server.MapPath("~/QRCodeFile/" + filename));
                                    if (!File.Exists("~/QRCodeFile/" + filename))
                                    {
                                        //fileUpload1.SaveAs(Server.MapPath("~/QRCodeFile/" + filename));
                                        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsertQRCode", new object[] { "Save", filename.Trim(), QRCode.Trim(), 0, Session["UserId"],0 });
                                        if (ds.Tables[0].Rows.Count > 0)
                                        {

                                            if (ds.Tables[0].Rows[0]["FileName"].ToString() != "")
                                            {
                                                DuplicateFileName += ds.Tables[0].Rows[0]["FileName"].ToString() + " ,";

                                            }
                                            else
                                            {
                                                uploadedcnt++;
                                                fileUpload1.SaveAs(Server.MapPath("~/QRCodeFile/" + filename));
                                            }
                                            //ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "messageshow();", true);
                                        }
                                    }
                                    //else
                                    //{

                                    //    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Errmessageshow();", true);
                                    //}
                                }
                            }
                            // }
                        }
                        else
                        {
                            lblInvalidFile.Text = "Invalid File Name : " + QRCode.ToString();
                            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "NotFoundmessageshow();", true);
                        }
                    }

                }
            }
            //
            //Response.Redirect(Request.Url.AbsoluteUri);
            int notupload = (FileNo - uploadedcnt);
            lblDuplicate.Visible = false;
            lblSuccess.Visible = true;
            lblsuccessmsg.Text = "Total Files " + FileNo.ToString() + "|Uploaded " + uploadedcnt + "|Not Uploaded " + notupload.ToString();
            if (DuplicateFileName.ToString() != "" && DuplicateFileName.ToString() != " ,")
            {
                lblDuplicate.Visible = true;
                lblSuccess.Visible = false;
                lblDuplicate.Text = "Duplicate Files : " + DuplicateFileName.ToString();
            }

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "messageshow();", true);
            Bind_QRCode();
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

    protected void Bind_QRCode()
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsertQRCode", new object[] { "get_QRcode", "", "", 0, 0, 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            btnExportToexcel.Visible = true;
            GV_QRCODE.DataSource = ds;
            GV_QRCODE.DataBind();
        }
        else
        {
            btnExportToexcel.Visible = false;
            GV_QRCODE.DataSource = ds;
            GV_QRCODE.DataBind();
        }
        //ViewState["Griddata"] = ds;
    }
    protected void GV_QRCODE_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_QRCODE.PageIndex = e.NewPageIndex;
        Bind_QRCode();
    }

    protected void GV_QRCODE_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }

    protected void GV_QRCODE_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        try
        {
            if (e.CommandName == "Views")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                string url = Request.Url.GetLeftPart(UriPartial.Authority) + Request.ApplicationPath;
                int Id = Convert.ToInt32((GV_QRCODE.Rows[rowIndex].FindControl("lblid") as Label).Text);
                DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsertQRCode", new object[] { "Download", "", "", 0, 0, Id });
                string filename = ds.Tables[0].Rows[0]["FileName"].ToString();
                string url1 = url + "QRCodeFile/" + filename + "";

                Response.ClearHeaders();
                Response.AddHeader("Content-Disposition", "attachment;filename=\"" + filename + "\"");
                Response.TransmitFile(HttpContext.Current.Server.MapPath("~/") + "\\QRCodeFile\\" + filename);
                Response.End();
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

    protected void btnExportToexcel_Click(object sender, EventArgs e)
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_InsertQRCode", new object[] { "ExportToExcel", "", "", 0, 0, 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            string FileName = "QRCodeFile_" + DateTime.Now.ToString("dd-MM-yyyy");
            bl.DownloadXLS(ds.Tables[0], FileName);
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        /* Verifies that the control is rendered */
    }

}