<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Admin_Dashborad" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="app-content content">

        <div class="content-wrapper">
            <div id="news-updates" class="row">
                <div class="col-md-12">
                    <marquee behavior="scroll" direction="left"><span runat="server" id="Marquee"></span> </marquee>
                </div>
            </div>
            <div class="content-header row">
            </div>
            <div class="content-body">
                <div id="crypto-stats-3" class="row">
                    <div class="col-xl-4 col-12">
                        <div class="card crypto-card-3 pull-up">
                            <!-- Bar Chart -->
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Total Revenue (MTD)</h4>
                                    <br />

                                    <asp:Chart ID="Chart2" runat="server" BackColor="#ffffff" BackGradientStyle="LeftRight"
                                        BorderlineWidth="0" Height="350px" Palette="None" PaletteCustomColors="42, 63, 106"
                                        Width="300px" BorderlineColor="192, 64, 0">
                                        <Series>
                                            <asp:Series Name="Series1" YValuesPerPoint="10" ChartType="StackedColumn" XValueMember="Date"
                                                 XValueType="DateTime"><%--ToolTip="Date: #VALX{d}"--%>
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                    <br>
                                    <asp:Label ID="lblChartAlternateText" runat="server" Text="" CssClass="dashboardLabel marginright300" ></asp:Label>
                                </div>
                                <div class="card-content collapse show">
                                    <div class="card-body">
                                        <%--  <div id="bar-chart1"></div> --%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-xl-4 col-12">
                        <div class="card crypto-card-3 pull-up">
                            <!-- Bar Chart -->
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Total Revenue (BTD)</h4>
                                    <br />

                                    <asp:Chart ID="Chart1" runat="server" BackColor="#ffffff" BackGradientStyle="LeftRight"
                                        BorderlineWidth="0" Height="350px" Palette="None" PaletteCustomColors="42, 63, 106"
                                        Width="300px" BorderlineColor="192, 64, 0">
                                        <Series>
                                            <asp:Series Name="Series1" YValuesPerPoint="10" ChartType="StackedColumn">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>

                                        </ChartAreas>
                                    </asp:Chart>
                                     <br>
                                    <asp:Label ID="Label1" runat="server" Text="" CssClass="dashboardLabel marginright300" Font-Bold="true" ></asp:Label>
                                </div>
                                <div class="card-content collapse show">
                                    <div class="card-body">
                                        <%-- <div id="bar-chart2"></div>--%>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="col-xl-4 col-12">
                        <div class="card crypto-card-3 pull-up">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Total Revenue (YTD)</h4>
                                    <br />

                                    <asp:Chart ID="Chart3" runat="server" BackColor="#ffffff" BackGradientStyle="LeftRight"
                                        BorderlineWidth="0" Height="350px" Palette="None" PaletteCustomColors="42, 63, 106"
                                        Width="300px" BorderlineColor="192, 64, 0">
                                        <Series>
                                            <asp:Series Name="Series1" YValuesPerPoint="10" ChartType="StackedColumn">
                                            </asp:Series>
                                        </Series>
                                        <ChartAreas>
                                            <asp:ChartArea Name="ChartArea1">
                                            </asp:ChartArea>
                                        </ChartAreas>
                                    </asp:Chart>
                                     <br>
                                    <asp:Label ID="Label2" runat="server" Text="" CssClass="dashboardLabel marginright300" ></asp:Label>
                                    <%-- <div id="ytd" runat="server"></div>
                                    <div id="PolicyYTD" runat="server"></div>--%>
                                </div>

                                <div class="card-content collapse show">
                                    <div class="card-body">
                                        <%-- <div id="bar-chart3"></div>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>

