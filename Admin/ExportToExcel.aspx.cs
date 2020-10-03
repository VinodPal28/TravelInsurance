using System;
using System.Data;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Globalization;

public partial class ExportToExcel : System.Web.UI.Page
{
    ConnectionToSql sqlCon = new ConnectionToSql();
    DataSet ds = new DataSet();

    protected void Page_Load(object sender, EventArgs e)
    {
        string Fdate = Session["FDate"].ToString();
        string Todate = Session["ToDate"].ToString();
        bind_commision(Fdate, Todate);
    }

    public void bind_commision(string Fdate, string Todate)
    {
        try
        {
            string[] Arr = Session["FDate"].ToString().Split('-');
            int monthValue = Convert.ToInt32(Arr[1]);
            string month = DateTimeFormatInfo.CurrentInfo.GetAbbreviatedMonthName(monthValue);
            SpnMonth.InnerHtml = month;
            date.InnerHtml = DateTime.Now.ToString("dd-MMM-yy");

            DataSet ds = sqlCon.ExecuteReader("Allianz_Travel", "USP_CommGeneration", new object[] { "GetDetails", Fdate, Todate, Session["UserId"] });
            StringBuilder sb = new StringBuilder();
            if (ds.Tables[0].Rows.Count > 0)
            {
                Spn_State.InnerHtml = ds.Tables[4].Rows[0]["name"].ToString();
                int i;
                for (i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    sb.Append("<tr>");
                    sb.Append("<td style='width: 200px; height: 50px; text - align: center; border: 1px #8e8e8e solid;'>" + Convert.ToString(ds.Tables[0].Rows[i]["Plan_Name"] + "</td>"));
                    sb.Append("<td style='width: 200px; height: 50px; text - align: center; border: 1px #8e8e8e solid;'>" + Convert.ToString(ds.Tables[0].Rows[i]["Quantity"] + "</td>"));
                    sb.Append("<td style='width: 200px; height: 50px; text - align: center; border: 1px #8e8e8e solid;'>" + Convert.ToString(ds.Tables[0].Rows[i]["Commission"] + "</td>"));
                    sb.Append("<td style='width: 200px; height: 50px; text - align: center; border: 1px #8e8e8e solid;'>" + Convert.ToString(ds.Tables[0].Rows[i]["TotalCommission"] + "</td>"));
                    sb.Append("</tr>");
                }
                for (i = 0; i < ds.Tables[1].Rows.Count; i++)
                {
                    PartnerCode.InnerHtml = ds.Tables[1].Rows[0]["Partner_Code"].ToString();


                }
                for (i = 0; i < ds.Tables[2].Rows.Count; i++)
                {
                    decimal BaseAmount = Convert.ToDecimal(ds.Tables[2].Rows[0]["TotalCommission"]);
                    decimal GST = Math.Round(BaseAmount * 18 / 100, 2);
                    decimal TotalAmount = Math.Round((BaseAmount + GST), 2);
                    decimal HaryanaGST = Math.Round(BaseAmount * 9 / 100, 2);

                    StringBuilder sb2 = new StringBuilder();
                    sb2.Append("<td  style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'><b>Total</b></td>");
                    sb2.Append("<td  style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'><b></b></td>");
                    sb2.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'><b>" + Convert.ToString(BaseAmount) + "</b></td>");
                    Grd2.InnerHtml = Convert.ToString(sb2);


                    StringBuilder sb5 = new StringBuilder();
                    sb5.Append("<td  style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'>SGST @9.00%</td>");
                    sb5.Append("<td  style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'></td>");
                    if (ds.Tables[4].Rows[0]["name"].ToString() == "Haryana")
                    {
                        sb5.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'><b>" + Convert.ToString(HaryanaGST) + "</b></td>");
                    }
                    else
                    {
                        sb5.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'>0</td>");
                    }
                    Grd5.InnerHtml = Convert.ToString(sb5);

                    StringBuilder sb6 = new StringBuilder();
                    sb6.Append("<td  style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'>CGST @9.00%</td>");
                    sb6.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'></td>");
                    if (ds.Tables[4].Rows[0]["name"].ToString() == "Haryana")
                    {
                        sb6.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'><b>" + Convert.ToString(HaryanaGST) + "</b></td>");
                    }
                    else
                    {
                        sb6.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'>0</td>");
                    }
                    Grd6.InnerHtml = Convert.ToString(sb6);

                    StringBuilder sb7 = new StringBuilder();
                    sb7.Append("<td  style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'>UTGST @</td>");
                    sb7.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'></td>");
                    sb7.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'>0</td>");
                    Grd7.InnerHtml = Convert.ToString(sb7);

                    StringBuilder sb8 = new StringBuilder();
                    sb8.Append("<td  style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'>Cess @</td>");
                    sb8.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'></td>");
                    sb8.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid; border-top: none;'>0</td>");
                    Grd8.InnerHtml = Convert.ToString(sb8);

                    StringBuilder sb3 = new StringBuilder();
                    sb3.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'><b>Grand Total</b></td>");
                    sb3.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'><b></b></td>");
                    sb3.Append("<td style='height: 35px; width: 50 %; text - align: center; font - weight: 600; border: 1px #8e8e8e solid;'><b>" + Convert.ToString(TotalAmount + "</b></td>"));
                    Grd3.InnerHtml = Convert.ToString(sb3);


                    StringBuilder sb4 = new StringBuilder();
                    sb4.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'>IGST @18.00%</td>");
                    sb4.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'></td>");
                    if (ds.Tables[4].Rows[0]["name"].ToString() != "Haryana")
                    {
                        sb4.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'><b>" + Convert.ToString(GST) + "</b></td>");
                    }
                    else
                    {
                        sb4.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'>0</td>");
                    }
                    Grd4.InnerHtml = Convert.ToString(sb4);

                    StringBuilder sb9 = new StringBuilder();
                    sb9.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'>Amount Written in Word:</td>");
                    sb9.Append("<td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'><b>" + Convert.ToString(ds.Tables[3].Rows[0]["AmountInWords1"] + "</b></td>"));
                    Grd9.InnerHtml = Convert.ToString(sb9);

                    for (i = 0; i < ds.Tables[1].Rows.Count; i++)
                    {


                        StringBuilder sb10 = new StringBuilder();
                        sb10.Append("  <td  style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'>Name of the Authorized Person:</td>");
                        sb10.Append(" <td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'><b>" + Convert.ToString(ds.Tables[1].Rows[0]["Partner_Name"]) + "</b></td>");
                        Grd10.InnerHtml = Convert.ToString(sb10);

                        StringBuilder sb11 = new StringBuilder();
                        sb11.Append(" <td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'>Contact number of the Authorized Person:</td>");
                        sb11.Append(" <td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'><b>" + Convert.ToString(ds.Tables[1].Rows[0]["PartnerContactNo"]) + "</b></td>");
                        Grd11.InnerHtml = Convert.ToString(sb11);
                        StringBuilder sb13 = new StringBuilder();
                    }
                    StringBuilder sb12 = new StringBuilder();
                    sb12.Append("<td  style='height: 60px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'>Authorized Signatory  & Stamp:</td>");
                    sb12.Append(" <td style='height: 35px; width: 50 %; text - align: center; border: 1px #8e8e8e solid;'></td>");
                    Grd12.InnerHtml = Convert.ToString(sb12);

                }

                StringBuilder sb14 = new StringBuilder();
                sb14.Append(" <div  style='width: 70 %; border - collapse: collapse; border - color:red'></div>");
                ck.InnerHtml = Convert.ToString(sb14);


                Grd1.InnerHtml = Convert.ToString(sb);
                Response.ContentType = "application/x-msexcel";
                Response.AddHeader("Content-Disposition", "attachment; filename = Commission-" + month + ".xls");

                Response.ContentEncoding = Encoding.UTF8;
                StringWriter tw = new StringWriter();
                HtmlTextWriter hw = new HtmlTextWriter(tw);
                Cont.RenderControl(hw);
                Response.Write(tw.ToString());
                Response.End();
            }
            else
            {
                sb.Append("<td style='color:red'>Data not found</td>");
                Grd1.InnerHtml = Convert.ToString(sb);
            }
        }
        catch (Exception ex)
        { }
    }
}