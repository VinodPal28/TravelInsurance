using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Web.UI.DataVisualization.Charting;
using System.Drawing;
using System.Web.Services;
public partial class Admin_Dashborad : System.Web.UI.Page
{
    ConnectionToSql con = new ConnectionToSql();
    BusinessLogic bl = new BusinessLogic();
    SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["Allianz_Travel"].ConnectionString);
    string FD = "", TD = "", Sday = "", Eday = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            Bindchart();
            BindContentManagement();
            string m = DateTime.Now.Month.ToString();
            string y = DateTime.Now.Year.ToString();
            string d = DateTime.Now.Day.ToString();

            FD = "" + y + "-" + m + "-01 00:00:00";
            TD = "" + y + "-" + m + "-" + d + " 23:59:59";
            Sday = "" + y + "-" + m + "-" + d + " 00:00:00";
            Eday = "" + y + "-" + m + "-" + d + " 23:59:59";
            if (Session["DealerId"] != null)
            {

                HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                HttpContext.Current.Response.Cache.SetNoServerCaching();
                HttpContext.Current.Response.Cache.SetNoStore();
            }

        }
    }



    private void Bindchart()
    {
        using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["Allianz_Travel"].ToString()))
        {
            if (Session["PartnerCode"].ToString() == "")
            {
                SqlCommand cmd = new SqlCommand("USP_GoogleChart", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Condition", "AllUsers");
                cmd.Parameters.AddWithValue("@DealerId", "0");
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataSet ds = new DataSet();
                da.Fill(ds);
                // DataTable ChartData = ds.Tables[0];

                //--MTD---------------------------------------
                DataTable ChartData = ds.Tables[0];
                string[] XPointMember = new string[ChartData.Rows.Count];
                int[] YPointMember = new int[ChartData.Rows.Count];
                for (int count = 0; count < ChartData.Rows.Count; count++)
                {
                    XPointMember[count] = ChartData.Rows[count]["days"].ToString();
                    YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["counts"]);
                }
                Chart1.Series[0].Points.DataBindXY(XPointMember, YPointMember);
                Chart1.Series[0].BorderWidth = 10;
                Chart1.Series[0].ChartType = SeriesChartType.StackedColumn;
                Chart1.Series[0].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
                Chart1.ChartAreas["ChartArea1"].AxisX.LabelStyle.Angle = -50;
                Chart1.ChartAreas["ChartArea1"].AxisX.TitleFont = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
                Chart1.ChartAreas["ChartArea1"].AxisY.TitleFont = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
                Chart1.ChartAreas["ChartArea1"].AxisX.Minimum = 0;
                Chart1.ChartAreas["ChartArea1"].AxisX.Interval = 1;

                Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = true;
                Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.LineColor = ColorTranslator.FromHtml("#e5e5e5");
                Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = true;
                Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.LineColor = ColorTranslator.FromHtml("#e5e5e5");
                Chart1.ChartAreas["ChartArea1"].AxisX.LabelStyle.Font = new Font("Tahoma", 8, FontStyle.Bold);
                Chart1.ChartAreas["ChartArea1"].AxisY.LabelStyle.Font = new Font("Tahoma", 8, FontStyle.Bold);
                Chart1.Series[0].IsValueShownAsLabel = true;

                Chart1.ChartAreas["ChartArea1"].AxisY.Title = "Count";
                Chart1.ChartAreas["ChartArea1"].AxisX.Title = "Day";
                foreach (DataPoint dp in Chart1.Series[0].Points)
                    dp.Color = Color.FromArgb(0, 55, 129);
                Chart1.Series["Series1"]["PixelPointWidth"] = "7";


                // Chart1.Width = 300;

                //--BTD---------------------------------------
                DataTable ChartData2 = ds.Tables[1];
                string[] XPointMember2 = new string[ChartData2.Rows.Count];
                int[] YPointMember2 = new int[ChartData2.Rows.Count];
                for (int count = 0; count < ChartData2.Rows.Count; count++)
                {
                    XPointMember2[count] = ChartData2.Rows[count]["Months"].ToString();
                    YPointMember2[count] = Convert.ToInt32(ChartData2.Rows[count]["countsBTD"]);
                }
                Chart2.Series[0].Points.DataBindXY(XPointMember2, YPointMember2);
                Chart2.Series[0].BorderWidth = 10;
                Chart2.Series[0].ChartType = SeriesChartType.StackedColumn;
                Chart2.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                Chart2.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;

                Chart2.Series[0].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                Chart2.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                Chart2.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
                Chart2.ChartAreas["ChartArea1"].AxisX.LabelStyle.Angle = -50;
                Chart2.ChartAreas["ChartArea1"].AxisX.TitleFont = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
                Chart2.ChartAreas["ChartArea1"].AxisY.TitleFont = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
                Chart2.ChartAreas["ChartArea1"].AxisX.Minimum = 0;
                Chart2.ChartAreas["ChartArea1"].AxisX.Interval = 1;
                Chart2.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = true;
                Chart2.ChartAreas["ChartArea1"].AxisX.MajorGrid.LineColor = ColorTranslator.FromHtml("#e5e5e5");
                Chart2.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = true;
                Chart2.ChartAreas["ChartArea1"].AxisY.MajorGrid.LineColor = ColorTranslator.FromHtml("#e5e5e5");
                Chart2.ChartAreas["ChartArea1"].AxisX.LabelStyle.Font = new Font("Tahoma", 8, FontStyle.Bold);
                Chart2.ChartAreas["ChartArea1"].AxisY.LabelStyle.Font = new Font("Tahoma", 8, FontStyle.Bold);
                Chart2.Series[0].IsValueShownAsLabel = true;
                Chart2.ChartAreas["ChartArea1"].AxisY.Title = "Count";
                Chart2.ChartAreas["ChartArea1"].AxisX.Title = "Month";
                foreach (DataPoint dp in Chart2.Series[0].Points)
                    dp.Color = Color.FromArgb(0, 55, 129);
                Chart2.Series["Series1"]["PixelPointWidth"] = "7";
                //--YTD---------------------------------------
                DataTable ChartData3 = ds.Tables[2];
                string[] XPointMember3 = new string[ChartData3.Rows.Count];
                int[] YPointMember3 = new int[ChartData3.Rows.Count];
                for (int count = 0; count < ChartData3.Rows.Count; count++)
                {
                    XPointMember3[count] = ChartData3.Rows[count]["Year"].ToString();
                    YPointMember3[count] = Convert.ToInt32(ChartData3.Rows[count]["countsYTD"]);
                }
                Chart3.Series[0].Points.DataBindXY(XPointMember3, YPointMember3);
                Chart3.Series[0].BorderWidth = 10;
                Chart3.Series[0].ChartType = SeriesChartType.StackedColumn;
                Chart3.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                Chart3.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;

                Chart3.Series[0].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                Chart3.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                Chart3.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
                Chart3.ChartAreas["ChartArea1"].AxisX.LabelStyle.Angle = -50;
                Chart3.ChartAreas["ChartArea1"].AxisX.TitleFont = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
                Chart3.ChartAreas["ChartArea1"].AxisY.TitleFont = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
                Chart3.ChartAreas["ChartArea1"].AxisX.Minimum = 0;
                Chart3.ChartAreas["ChartArea1"].AxisX.Interval = 1;
                Chart3.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = true;
                Chart3.ChartAreas["ChartArea1"].AxisX.MajorGrid.LineColor = ColorTranslator.FromHtml("#e5e5e5");
                Chart3.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = true;
                Chart3.ChartAreas["ChartArea1"].AxisY.MajorGrid.LineColor = ColorTranslator.FromHtml("#e5e5e5");
                Chart3.ChartAreas["ChartArea1"].AxisX.LabelStyle.Font = new Font("Tahoma", 8, FontStyle.Bold);
                Chart3.ChartAreas["ChartArea1"].AxisY.LabelStyle.Font = new Font("Tahoma", 8, FontStyle.Bold);
                Chart3.Series[0].IsValueShownAsLabel = true;
                Chart3.ChartAreas["ChartArea1"].AxisY.Title = "Count";
                Chart3.ChartAreas["ChartArea1"].AxisX.Title = "Year";
                foreach (DataPoint dp in Chart3.Series[0].Points)
                    dp.Color = Color.FromArgb(0, 55, 129);
                Chart3.Series["Series1"]["PixelPointWidth"] = "7";
                con.Close();

            }

            if (Session["PartnerCode"].ToString() != "")
            {
                SqlCommand cmd = new SqlCommand("USP_GoogleChart", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Condition", "DealerWise");
                cmd.Parameters.AddWithValue("@DealerId", Session["UserId"]);
                SqlDataAdapter da = new SqlDataAdapter();
                da.SelectCommand = cmd;
                DataSet ds = new DataSet();
                da.Fill(ds);
                // DataTable ChartData = ds.Tables[0];

                //--MTD---------------------------------------
                DataTable ChartData = ds.Tables[0];
                string[] XPointMember = new string[ChartData.Rows.Count];
                int[] YPointMember = new int[ChartData.Rows.Count];
                for (int count = 0; count < ChartData.Rows.Count; count++)
                {
                    XPointMember[count] = ChartData.Rows[count]["days"].ToString();
                    YPointMember[count] = Convert.ToInt32(ChartData.Rows[count]["counts"]);
                }
                Chart1.Series[0].Points.DataBindXY(XPointMember, YPointMember);
                Chart1.Series[0].BorderWidth = 10;
                Chart1.Series[0].ChartType = SeriesChartType.StackedColumn;
                Chart1.Series[0].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
                Chart1.ChartAreas["ChartArea1"].AxisX.LabelStyle.Angle = -50;
                Chart1.ChartAreas["ChartArea1"].AxisX.TitleFont = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
                Chart1.ChartAreas["ChartArea1"].AxisY.TitleFont = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
                Chart1.ChartAreas["ChartArea1"].AxisX.Minimum = 0;
                Chart1.ChartAreas["ChartArea1"].AxisX.Interval = 1;

                Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = true;
                Chart1.ChartAreas["ChartArea1"].AxisX.MajorGrid.LineColor = ColorTranslator.FromHtml("#e5e5e5");
                Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = true;
                Chart1.ChartAreas["ChartArea1"].AxisY.MajorGrid.LineColor = ColorTranslator.FromHtml("#e5e5e5");
                Chart1.ChartAreas["ChartArea1"].AxisX.LabelStyle.Font = new Font("Tahoma", 8, FontStyle.Bold);
                Chart1.ChartAreas["ChartArea1"].AxisY.LabelStyle.Font = new Font("Tahoma", 8, FontStyle.Bold);
                Chart1.Series[0].IsValueShownAsLabel = true;

                Chart1.ChartAreas["ChartArea1"].AxisY.Title = "Count";
                Chart1.ChartAreas["ChartArea1"].AxisX.Title = "Day";
                foreach (DataPoint dp in Chart1.Series[0].Points)
                    //dp.Color = Color.FromArgb(204, 221, 97);
                    dp.Color = Color.FromArgb(0, 55, 129);
                Chart1.Series["Series1"]["PixelPointWidth"] = "7";


                // Chart1.Width = 300;

                //--BTD---------------------------------------
                DataTable ChartData2 = ds.Tables[1];
                string[] XPointMember2 = new string[ChartData2.Rows.Count];
                int[] YPointMember2 = new int[ChartData2.Rows.Count];
                for (int count = 0; count < ChartData2.Rows.Count; count++)
                {
                    XPointMember2[count] = ChartData2.Rows[count]["Months"].ToString();
                    YPointMember2[count] = Convert.ToInt32(ChartData2.Rows[count]["countsBTD"]);
                }
                Chart2.Series[0].Points.DataBindXY(XPointMember2, YPointMember2);
                Chart2.Series[0].BorderWidth = 10;
                Chart2.Series[0].ChartType = SeriesChartType.StackedColumn;
                Chart2.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                Chart2.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;

                Chart2.Series[0].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                Chart2.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                Chart2.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
                Chart2.ChartAreas["ChartArea1"].AxisX.LabelStyle.Angle = -50;
                Chart2.ChartAreas["ChartArea1"].AxisX.TitleFont = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
                Chart2.ChartAreas["ChartArea1"].AxisY.TitleFont = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
                Chart2.ChartAreas["ChartArea1"].AxisX.Minimum = 0;
                Chart2.ChartAreas["ChartArea1"].AxisX.Interval = 1;
                Chart2.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = true;
                Chart2.ChartAreas["ChartArea1"].AxisX.MajorGrid.LineColor = ColorTranslator.FromHtml("#e5e5e5");
                Chart2.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = true;
                Chart2.ChartAreas["ChartArea1"].AxisY.MajorGrid.LineColor = ColorTranslator.FromHtml("#e5e5e5");
                Chart2.ChartAreas["ChartArea1"].AxisX.LabelStyle.Font = new Font("Tahoma", 8, FontStyle.Bold);
                Chart2.ChartAreas["ChartArea1"].AxisY.LabelStyle.Font = new Font("Tahoma", 8, FontStyle.Bold);
                Chart2.Series[0].IsValueShownAsLabel = true;
                Chart2.ChartAreas["ChartArea1"].AxisY.Title = "Count";
                Chart2.ChartAreas["ChartArea1"].AxisX.Title = "Month";
                foreach (DataPoint dp in Chart2.Series[0].Points)
                    dp.Color = Color.FromArgb(0, 55, 129);
                Chart2.Series["Series1"]["PixelPointWidth"] = "7";
                //--YTD---------------------------------------
                DataTable ChartData3 = ds.Tables[2];
                string[] XPointMember3 = new string[ChartData3.Rows.Count];
                int[] YPointMember3 = new int[ChartData3.Rows.Count];
                for (int count = 0; count < ChartData3.Rows.Count; count++)
                {
                    XPointMember3[count] = ChartData3.Rows[count]["Year"].ToString();
                    YPointMember3[count] = Convert.ToInt32(ChartData3.Rows[count]["countsYTD"]);
                }
                Chart3.Series[0].Points.DataBindXY(XPointMember3, YPointMember3);
                Chart3.Series[0].BorderWidth = 10;
                Chart3.Series[0].ChartType = SeriesChartType.StackedColumn;
                Chart3.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                Chart3.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;

                Chart3.Series[0].ChartType = System.Web.UI.DataVisualization.Charting.SeriesChartType.Column;
                Chart3.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = false;
                Chart3.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = false;
                Chart3.ChartAreas["ChartArea1"].AxisX.LabelStyle.Angle = -50;
                Chart3.ChartAreas["ChartArea1"].AxisX.TitleFont = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
                Chart3.ChartAreas["ChartArea1"].AxisY.TitleFont = new System.Drawing.Font("Verdana", 8, System.Drawing.FontStyle.Bold);
                Chart3.ChartAreas["ChartArea1"].AxisX.Minimum = 0;
                Chart3.ChartAreas["ChartArea1"].AxisX.Interval = 1;
                Chart3.ChartAreas["ChartArea1"].AxisX.MajorGrid.Enabled = true;
                Chart3.ChartAreas["ChartArea1"].AxisX.MajorGrid.LineColor = ColorTranslator.FromHtml("#e5e5e5");
                Chart3.ChartAreas["ChartArea1"].AxisY.MajorGrid.Enabled = true;
                Chart3.ChartAreas["ChartArea1"].AxisY.MajorGrid.LineColor = ColorTranslator.FromHtml("#e5e5e5");
                Chart3.ChartAreas["ChartArea1"].AxisX.LabelStyle.Font = new Font("Tahoma", 8, FontStyle.Bold);
                Chart3.ChartAreas["ChartArea1"].AxisY.LabelStyle.Font = new Font("Tahoma", 8, FontStyle.Bold);
                Chart3.Series[0].IsValueShownAsLabel = true;
                Chart3.ChartAreas["ChartArea1"].AxisY.Title = "Count";
                Chart3.ChartAreas["ChartArea1"].AxisX.Title = "Year";
                foreach (DataPoint dp in Chart3.Series[0].Points)
                    dp.Color = Color.FromArgb(0, 55, 129);
                Chart3.Series["Series1"]["PixelPointWidth"] = "7";
                con.Close();

            }
        }
    }

    private void BindContentManagement()
    {
        DataSet ds = con.ExecuteReader("Allianz_Travel", "USP_ManageContent", new object[] { "BindMarquee", "", "", "", "", 0 });
        if (ds.Tables[0].Rows.Count > 0)
        {
            Marquee.InnerHtml = ds.Tables[0].Rows[0]["ContentBody"].ToString();
        }
    }
}