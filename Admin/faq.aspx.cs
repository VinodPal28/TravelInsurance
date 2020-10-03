using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Text;

public partial class Admin_faq : System.Web.UI.Page
{

    ConnectionToSql ConSql = new ConnectionToSql();
    DataSet ds = new DataSet();
    BusinessLogic bl = new BusinessLogic();
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (Session["UserId"] == null || Session["UserId"].ToString() == "0")
            {
                Response.Redirect("../Home.aspx");
            }
           
            if (!IsPostBack)
            {
                if (Session["UserId"] != null && Session["UserId"].ToString() != "0")
                {
                    BindFaqList();
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

    public void BindFaqList()
    {
        ds = ConSql.ExecuteReader("Allianz_Travel", "USP_FAQ", new object[] { "BindfaqList", "", "", "", 0, 0 });
        if(ds.Tables[0].Rows.Count>0)
        {
            StringBuilder sb = new StringBuilder();
            for (int i=0;i< ds.Tables[0].Rows.Count;i++)
            {
                sb.Append("<div class='card'");
                sb.Append("<div class='accordion' id='accordionEx" + i + "' role='tablist' aria-multiselectable='true'>");
                sb.Append("<div class='card-header' role='tab' id='headingThree " + i + "' > <a class='collapsed' data-toggle='collapse' data-parent='#accordionEx" + i + "' href='#collapseThree" + i + "' aria-expanded='false' aria-controls='collapseThree'><h5 class='mb-0'  style='font-weight: bold'>" + Convert.ToString(ds.Tables[0].Rows[i]["Questions"]) + " <i class='fa fa-angle-down rotate-icon'></i></h5></a></div>");
                sb.Append("<div id='collapseThree" + i + "' class='collapse' role='tabpanel' aria-labelledby='headingThree " + i + "' data-parent='#accordionEx" + i + "'style='padding-left:17px;margin-top: -27px;'>&nbsp&nbsp&nbsp <p style='margin-left:2 %;'>" + Convert.ToString(ds.Tables[0].Rows[i]["Answers"]) + "</p></div></div>");
            }
            Faq_Id.InnerHtml = Convert.ToString(sb);
        }
    }
}