using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Services;
using System.Web.Script.Services;
using System.Text;
using System.Data.SqlTypes;
using System.Web.Script.Serialization;
using Newtonsoft.Json;
public partial class Admin_PassengersType : System.Web.UI.Page
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
                Bind_AgeGroup();
                Clear();
                             
            }
            if (Request.Params["method"] != null)
            {
                if (Request.Params["method"].ToString() == "GetMinAgeGroup")
                {
                    AgeGroup(Request.Params["MinAgeGroup"].ToString(), Request.Params["MaxAgeGroup"].ToString());
                }

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

    public string SaveData(string Passenger)
    {
        string result = "";
      
        var serializeData = JsonConvert.DeserializeObject<List<Passengerstype>>(Passenger);
        foreach (var data in serializeData)
        {
            using (DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PassengersType", new object[] { "Insert_Passengerstype", HiddenField_ID.Value, data.PassengersType, data.PassengersMinAge, data.PassengersMaxAge, 0, Session["UserId"] }))
            {
                result = "F";
                
            }
        }
       
        Bind_AgeGroup();
        Clear();
        return JsonConvert.SerializeObject(result);
        
    }
    public class Passengerstype
    {
        public string PassengersType { get; set; }
        public string PassengersMinAge { get; set; }
        public string PassengersMaxAge { get; set; }

    }
    public void AgeGroup(string MinAgeGroup, string MaxAgeGroup )
    {
        try
        {
            string msg = "";
           
            //DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PassengersType", new object[] { "CheckAge", 0, "", MinAgeGroup, "", 0, 0 });
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PassengersType", new object[] { "CheckAge", 0, "", MinAgeGroup, MaxAgeGroup, 0, 0 });
            if (ds.Tables[0].Rows[0]["Name"].ToString()=="F")
            {
                msg = "F";
            }
            else if (ds.Tables[0].Rows[0]["Name"].ToString() == "NF")
            {
                msg = "NF";
            }
           
            Response.Write(msg);
            Response.End();
        }
        catch (Exception ex)
        { }
    }
    protected void Clear()
    {
        txtPassengerstype.Text = "";
        txtmaxagegroup.Text = "";
        txtMinAgeGrouop.Text = "";
        //HiddenField_ID.Value = "0";
    }
   

    protected void Bind_AgeGroup()
    {
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PassengersType", new object[] { "Get_PassengersType", 0, "", "", "", Session["UserId"], 0 });
            if (ds.Tables[0].Rows.Count > 0)
            {
                GV_AgeGroup.DataSource = ds;
                GV_AgeGroup.DataBind();
            }
            else
            {
                GV_AgeGroup.DataSource = ds;
                GV_AgeGroup.DataBind();
            }
        }
        catch (Exception ex)
        {
        }
    }

    protected void GV_AgeGroup_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        GV_AgeGroup.PageIndex = e.NewPageIndex;
        Bind_AgeGroup();
    }

    protected void btnReset_Click(object sender, EventArgs e)
    {       
        Clear();
    }

    protected void GV_AgeGroup_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Active")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblAge_id = (GV_AgeGroup.Rows[rowIndex].FindControl("lblAge_id") as Label).Text;
            Button Active = (GV_AgeGroup.Rows[rowIndex].FindControl("btnActive") as Button);
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PassengersType", new object[] { "Active", lblAge_id.Trim(), "", "", "", Session["UserId"], 0 });

            Bind_AgeGroup();

        }
        if (e.CommandName == "Deactive")
        {
            GridViewRow gvr = (GridViewRow)((Control)e.CommandSource).NamingContainer;
            int rowIndex = gvr.RowIndex;
            string lblAge_id = (GV_AgeGroup.Rows[rowIndex].FindControl("lblAge_id") as Label).Text;
            Button Deactive = (GV_AgeGroup.Rows[rowIndex].FindControl("btndactive") as Button);
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PassengersType", new object[] { "Deactive", lblAge_id.Trim(), "", "", "", Session["UserId"], 0 });
            Bind_AgeGroup();
        }
        
    }
    protected void GV_AgeGroup_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Button btnDeactive = (Button)e.Row.FindControl("btndeactive");
            Button btnactive = (Button)e.Row.FindControl("btnActive");
            string outlookid = ((HiddenField)e.Row.FindControl("HiddenIsActive")).Value;

            if (outlookid == "0")
            {
                btnDeactive.Enabled = false;
                btnactive.Enabled = true;
                btnDeactive.CssClass = "btn btn-sm round btn-outline-fade";
                btnactive.CssClass = "btn btn-sm round btn-outline-danger";
                //btnDeactive.BackColor = System.Drawing.Color.Wheat;
            }
            else if (outlookid == "1")
            {
                btnDeactive.Enabled = true;
                btnactive.Enabled = false;
                btnDeactive.CssClass = "btn btn-sm round btn-outline-danger";
                btnactive.CssClass = "btn btn-sm round btn-outline-fade";
            }

        }
    }

    protected void GV_AgeGroup_SelectedIndexChanged(object sender, EventArgs e)
    {
       
           GridViewRow row = GV_AgeGroup.SelectedRow;
        Label AgeGrouop = row.FindControl("lblAgegroup") as Label;
        string[] arr = new string[2];
        arr = AgeGrouop.Text.Split('-');
        txtMinAgeGrouop.Text = arr[0];
        txtmaxagegroup.Text = arr[1];
        Label lblAge_id = row.FindControl("lblAge_id") as Label;
        HiddenField_ID.Value = lblAge_id.Text;
        txtPassengerstype.Text = (row.FindControl("lblPassengertype") as Label).Text;
        Bind_AgeGroup();
    }
    
    protected void GV_AgeGroup_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        GridViewRow row = GV_AgeGroup.Rows[e.RowIndex];
        Label lblAge_id = (Label)row.FindControl("lblAge_id");
        string Age = lblAge_id.Text;

        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PassengersType", new object[] { "Update", Age, "", "", "",2, Session["UserId"] });
        Bind_AgeGroup();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        txtmaxagegroup.Attributes.Add("onblur", "MinAgeGroupMaster()");
        try
        {
            DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_PassengersType", new object[] { "Insert_Passengerstype", HiddenField_ID.Value, txtPassengerstype.Text.Trim(), txtMinAgeGrouop.Text.Trim(), txtmaxagegroup.Text.Trim(), 0, Session["UserId"] });
            if (ds.Tables[0].Rows.Count > 0)
            {
                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "script", "messageshow();", true);
                Bind_AgeGroup();
                Clear();

            }
        }
        catch (Exception ex)
        { }
    }
}