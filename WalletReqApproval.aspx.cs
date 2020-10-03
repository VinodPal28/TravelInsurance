﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Admin_WalletReqApproval : System.Web.UI.Page
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
                    Bind();
                   
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


    public void Bind()
    {
        dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_WalletReqApproval", new object[] { "GetWalletReqDetails","","","","","","","","","",0});
        if (dt.Rows.Count > 0)
        {
            GV_WalletApproval.DataSource = dt;
            GV_WalletApproval.DataBind();
        }
        else
        {
            DataTable dt1 = new DataTable();
            GV_WalletApproval.DataSource = dt1;
            GV_WalletApproval.DataBind();
        }
    }

    protected void GV_WalletApproval_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "Approve")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                txtId.Text = (GV_WalletApproval.Rows[rowIndex].FindControl("lblId") as Label).Text;
                txtPartnerCode.Text = (GV_WalletApproval.Rows[rowIndex].FindControl("lblPartnerId") as Label).Text;
                txtPartnerName.Text = (GV_WalletApproval.Rows[rowIndex].FindControl("lblPartnerName") as Label).Text;
                txtrequestAmt.Text = (GV_WalletApproval.Rows[rowIndex].FindControl("lblReqAmount") as Label).Text;
                txtReqDate.Text = (GV_WalletApproval.Rows[rowIndex].FindControl("lblReqDate") as Label).Text;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Approve();", true);
                
            }
            if (e.CommandName == "Disapprove")
            {
                GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
                int rowIndex = gvr.RowIndex;
                txt_Id.Text = (GV_WalletApproval.Rows[rowIndex].FindControl("lblId") as Label).Text;
                txtPartCode.Text = (GV_WalletApproval.Rows[rowIndex].FindControl("lblPartnerId") as Label).Text;
                txtPartName.Text = (GV_WalletApproval.Rows[rowIndex].FindControl("lblPartnerName") as Label).Text;
                txtReqAmount.Text = (GV_WalletApproval.Rows[rowIndex].FindControl("lblReqAmount") as Label).Text;
                txtReq_date.Text = (GV_WalletApproval.Rows[rowIndex].FindControl("lblReqDate") as Label).Text;
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "Disapprove();", true);

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

    protected void btnSub_Click(object sender, EventArgs e)
    {
        try
        {
            dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_WalletReqApproval", new object[] { "WalletReqApprove", txtrequestAmt.Text.ToString(), txtGranted_Amt.Text.ToString(), txtPartnerCode.Text.ToString(), txtPartnerName.Text.ToString(), txtOthers.Text.ToString(), "", txtReqDate.Text.ToString(), txt_remarks.Text.ToString(), Session["UserId"].ToString(), txtId.Text });
            if (dt.Rows.Count > 0 && dt.Rows[0][0].ToString().ToUpper() == "I")
            {
                Bind();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "MsgApprove();", true);
               
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

    protected void btnDisApprove_Click(object sender, EventArgs e)
    {
        try
        {
            dt = ConSql.ExecuteReaderDt("Allianz_Travel", "USP_WalletReqApproval", new object[] { "WalletReqDisapprove", txtReqAmount.Text.ToString(), "", txtPartCode.Text.ToString(), txtPartName.Text.ToString(), "", "", txtReq_date.Text.ToString(), txtDisapproveRemark.Text.ToString(), Session["UserId"].ToString(), txt_Id.Text });
            if (dt.Rows.Count > 0 && dt.Rows[0][0].ToString().ToUpper() == "I")
            {
                Bind();
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "MsgDisapprove();", true);
       
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

    protected void GV_WalletApproval_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_WalletApproval.PageIndex = e.NewPageIndex;
        Bind();
    }
}