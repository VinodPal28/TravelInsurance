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
    DataTable dt = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
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

    protected void Bind_WalletStmt()
    {       
        try
        {         
            dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_WalletStmt", new object[] { "Wallet_Stmt", Session["UserId"],"" });
            if (dt.Rows.Count > 0)
            {
                GV_TranxDetails.DataSource = dt;
                GV_TranxDetails.DataBind();
            }
            else
            {
               // btnexport.Visible = false;
                DataTable dt = new DataTable();
                GV_TranxDetails.DataSource = dt;
                GV_TranxDetails.DataBind();
            }
            // ViewState["Griddata"] = dt;
            dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_WalletStmt", new object[] { "Wallet_Balance", Session["UserId"],"" });
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
}