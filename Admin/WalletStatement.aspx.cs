using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Partner_WalletStatement : System.Web.UI.Page
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
                bool Authenticate = bl.CheckAuthority("WalletStatement.aspx", Session["UserTypeId"].ToString());
                if (Authenticate == false)
                {
                    Response.Redirect("../Default.aspx");
                }
            }
            if (!IsPostBack)
            {
                if (Session["UserId"] != null && Session["UserId"].ToString() != "0")
                {
                    Bind_WalletStmt();
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
    public int GetId()
    {
        int id;
        if (Session["PartnerId"].ToString() != "")
        {
            id = Convert.ToInt32(Session["PartnerId"]);
        }
        else
        {
            id = Convert.ToInt32(Session["UserId"]);
        }
        return id;
    }
    protected void Bind_WalletStmt()
    {
        try
        {
            int id = GetId();
            dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_WalletStmt", new object[] { "Wallet_Stmt", id, "" });
            if (dt.Rows.Count > 0)
            {
                GV_TranxDetails.DataSource = dt;
                GV_TranxDetails.DataBind();
            }
            else
            {
                // btnexport.Visible = false;
                //DivExcel.Visible = false;
                btnExportToExcel.Visible = false;
                DataTable dt = new DataTable();
                GV_TranxDetails.DataSource = dt;
                GV_TranxDetails.DataBind();
            }
            // ViewState["Griddata"] = dt;
            dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_WalletStmt", new object[] { "Wallet_Balance", id, "" });
            lblWalletBlnce.Text = dt.Rows[0]["Balance"].ToString();
            Session["WalletBalance"] = Convert.ToDecimal(lblWalletBlnce.Text);
        }
        catch (Exception ex)
        {
        }

    }

    protected void GV_TranxDetails_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lbl = (Label)e.Row.FindControl("lblStatus");
            if (lbl.Text == "Credited")
            {
                lbl.CssClass = "btn btn-sm round btn-outline-danger";
            }
            if (lbl.Text == "Debited")
            {
                lbl.CssClass = "btn btn-sm round btn-outline-danger";
            }

        }
    }

    protected void GV_TranxDetails_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            GV_TranxDetails.PageIndex = e.NewPageIndex;
            Bind_WalletStmt();
        }
        catch (Exception ex)
        { }
    }

    protected void btnExportToExcel_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet ds = ConSql.ExecuteReader("Allianz_Travel", "USP_ExportWalletStmt", new object[] { "ExportToExcel", 0, Session["UserId"] });
            if (ds.Tables[0].Rows.Count > 0)
            {               
                string FileName = "WalletStatement_" + DateTime.Now.ToString("dd-MM-yyyy");
                bl.DownloadXLS(ds.Tables[0], FileName);
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
}