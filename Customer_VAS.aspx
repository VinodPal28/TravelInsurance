<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Customer_VAS.aspx.cs" Inherits="Customer_VAS" ClientIDMode="Static" EnableEventValidation="false" %>

<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Modern admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities with bitcoin dashboard.">
    <meta name="keywords" content="admin template, modern admin template, dashboard template, flat admin template, responsive admin template, web app, crypto dashboard, bitcoin dashboard">
    <meta name="author" content="PIXINVENT">
    <title>Customer Value Added Services</title>
    <link rel="apple-touch-icon" href="images/ico/apple-icon-120.png">
    <link rel="shortcut icon" type="image/x-icon" href="images/ico/fav-icon.png">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Quicksand:300,400,500,700"
        rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="VAS/css/line-awesome.min.css">
    <!-- BEGIN VENDOR CSS-->
    <link rel="stylesheet" type="text/css" href="VAS/css/vendors.css">
    <!-- END VENDOR CSS-->
    <!-- BEGIN MODERN CSS-->
    <link rel="stylesheet" type="text/css" href="VAS/css/app.css">
</head>
<body class="vertical-layout vertical-menu 2-columns fixed-navbar" data-open="click" data-menu="vertical-menu" data-col="2-columns">
    <!-- fixed-top-->
    <form id="frm" runat="server">
        <nav class="header-navbar navbar-expand-md navbar navbar-with-menu navbar-without-dd-arrow fixed-top navbar-semi-light bg-info navbar-shadow">
            <div class="navbar-wrapper">
                <div class="navbar-header">
                    <ul class="nav navbar-nav flex-row">
                        <li class="nav-item mobile-menu d-md-none mr-auto"><a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i class="ft-menu font-large-1"></i></a></li>
                        <li class="nav-item">
                            <a class="navbar-brand" id="brand-logoB" href="index.html">
                                <img class="brand-logo" alt="modern admin logo" src="VAS/images/logo/allianz-travel.png">
                            </a>
                        </li>
                        <li class="nav-item d-md-none">
                            <a class="nav-link open-navbar-container" data-toggle="collapse" data-target="#navbar-mobile"><i class="la la-ellipsis-v"></i></a>
                        </li>
                    </ul>
                </div>

            </div>
        </nav>
        <div class="app-content content">
            <div class="container">
                <div class="content-header row">
                </div>
                <asp:HiddenField ID="CheckTab" runat="server" />
                <asp:HiddenField ID="HiddenEmail" runat="server" />
                <asp:HiddenField ID="HiddenName" runat="server" />
                <asp:HiddenField ID="HiddenPolicyNo" runat="server" />

                <asp:HiddenField ID="HiddenLuggageTrackerId" runat="server" Value="0" />
                <asp:HiddenField ID="HiddenRoadsideAssistanceId" runat="server" Value="0" />
                <asp:HiddenField ID="HiddenWeatherUpdateId" runat="server" Value="0" />
                <asp:HiddenField ID="HiddenCardProtectionId" runat="server" Value="0" />
                <div class="content-body">
                    <h3 class="h13Tag">Welcome to Allianz Travel, kindly submit your details in order to activate your travel "Value Added Services".</h3>
                </div>
                <div id="smartwizard">
                    <ul>
                        <li id="VAS1" runat="server"><a href="#step-1" id="CI" class="active" runat="server">Customer Information</a></li>
                        <li id="VAS2" runat="server"><a href="#step-2" id="LT" runat="server">Luggage Tracker</a></li>
                        <li id="VAS3" runat="server"><a href="#step-3" id="RA" runat="server">Roadside Assistance</a></li>
                        <li id="VAS4" runat="server"><a href="#step-4" id="WU" runat="server">Weather Update</a></li>
                        <li id="VAS5" runat="server"><a href="#step-5" id="CP" runat="server">Card Protection</a></li>
                        <li id="VAS6" runat="server"><a href="#step-6" id="FS" runat="server">Final Summary</a></li>
                    </ul>
                    <div>

                        <div id="step-1">
                            <!-- <h1 class="h1Tag">Customer Information</h1> -->
                            <form class="form customForms">
                                <div class="form-body" id="CustomerInformation" runat="server">
                                    <div style="height: 20px">
                                        <center><asp:Label ID="SpnMsg" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label>
                                            <asp:Label ID="lblExistMsg" runat="server" ForeColor="Red" ClientIDMode="Static"></asp:Label>
                                        <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red" ClientIDMode="Static"></asp:Label></center>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-md-6 col-xs-12">
                                            <div class="row">
                                                <div class="col-md-12 col-xs-12">
                                                    <div class="form-group">
                                                        <h5>Name</h5>
                                                        <div class="controls">
                                                            <asp:TextBox ID="txtName" runat="server" class="form-control" placeholder="Name" ReadOnly="true" AutoCompleteType="Disabled"></asp:TextBox>
                                                            <asp:Label ID="lblPolicyNo" runat="server" Visible="false"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Contact Number<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <asp:TextBox ID="txtContactNumber" runat="server" class="form-control" placeholder="Contact Number" MaxLength="10" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Email<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <asp:TextBox ID="txtEmail" runat="server" class="form-control" placeholder="Email" TextMode="Email" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-xs-12">
                                            <div class="row">
                                                <div class="col-md-12 col-xs-12">
                                                    <div class="form-group">
                                                        <h5>Policy Number</h5>
                                                        <div class="controls">
                                                            <asp:TextBox ID="txtPolicyNo" runat="server" class="form-control" placeholder="Policy Number" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Travel Start Date<span class="starRed"></span></label>
                                                        <div class="controls">
                                                            <asp:TextBox ID="txtTravelStartDate" runat="server" class="form-control" placeholder="Travel Start Date" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="col-md-12 col-xs-12">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Travel End Date<span class="starRed"></span></label>
                                                        <div class="controls">
                                                            <asp:TextBox ID="txtEndDate" runat="server" class="form-control" placeholder="Travel End Date" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div style="text-align: right">
                                                <asp:Button ID="btnNext1" runat="server" Text="Next" class="btn btn-secondary" ClientIDMode="Static" />


                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div id="step-2" class="">
                            <!-- <h1 class="h1Tag">Luggage Tracker</h1> -->
                            <form class="form customForms">
                                <div style="height: 20px">
                                    <center><asp:Label ID="lblMSg2" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label>
                                       </center>
                                </div>
                                <div class="form-body" id="LuggageID" runat="server">
                                    <div class="row">
                                        <div class="col-md-6 col-xs-12">
                                            <div class="form-group">
                                                <h5>Luggage Tracker<span class="starRed" style="color: red">*</span></h5>
                                                <div class="controls">
                                                    <table id="maindivOB">
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txttrackerNumber1" runat="server" class="form-control" placeholder="Enter Luggage Tracker Number" Width="530px" AutoCompleteType="Disabled" MaxLength="12"></asp:TextBox>
                                                                <br />
                                                            </td>
                                                        </tr>

                                                    </table>

                                                </div>
                                            </div>
                                        </div>

                                      <%--  <div class="col-md-12">
                                            <input id="btnAdd" type="button" value="Add More" class="btn btn-secondary " />
                                            <asp:Button ID="btnRemove" runat="server" Text="Remove" class="btn btn-secondary " />
                                            <br />
                                            <br />
                                            <div id="TextBoxContainer">
                                               
                                            </div>
                                            <br />
                                        </div>--%>

                                        <div class="col-md-12 col-xs-6">
                                            <div style="text-align: right">
                                                <asp:Button ID="btnNext2" runat="server" Text="Next" class="btn btn-secondary " ClientIDMode="Static" />
                                            </div>
                                        </div>
                                    </div>

                                </div>

                            </form>

                        </div>
                        <div id="step-3" class="">
                            <!-- <h1 class="h1Tag">RSA Registration</h1> -->
                            <form class="form customForms">
                                <div style="height: 20px">
                                    <center><asp:Label ID="bblmsg3" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label>
                                       </center>
                                </div>
                                <br />
                                <div class="form-body" id="RoadsideID" runat="server">
                                    <%--<div class="row">
                                        <div class="col-md-6 col-xs-12">
                                            <div class="form-group">
                                                <h5>Make</h5>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtMake" runat="server" class="form-control" placeholder="Make" AutoCompleteType="Disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-xs-12">
                                            <div class="form-group">
                                                <h5>Model</h5>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtModle" runat="server" class="form-control" placeholder="AL-Model" AutoCompleteType="Disabled"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-xs-12">
                                            <div class="form-group">
                                                <h5>Registration Number</h5>
                                                <div class="controls">
                                                    <asp:TextBox ID="txtRegistrationNumber" runat="server" class="form-control" placeholder="Registration Number"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6 col-xs-12">
                                            <div class="form-group">
                                                <label for="projectinput2">Registration Year<span class="starRed"></span></label>
                                                <div class="controls">
                                                    <asp:DropDownList ID="ddlRegistrationYear" runat="server" class="form-control"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-12 col-xs-6">
                                            <div style="text-align: right">
                                                <asp:Button ID="btnNext3" runat="server" Text="Next" class="btn btn-secondary " />
                                            </div>
                                        </div>
                                    </div>--%>

                                    <div class="table-responsive" id="geodiv">
                                        <table class="table table-de mb-0" id="maintable">
                                            <thead>
                                            </thead>
                                            <tbody id="maindiv" runat="server">
                                                <tr>

                                                    <td><b>Vehicle Make<span class="starRed" style="color: red">*</span></b></td>
                                                    <td><b>Vehicle Model<span class="starRed" style="color: red">*</span></b></td>
                                                    <td><b>Registration Number<span class="starRed" style="color: red">*</span></b></td>
                                                    <td><b>Registration Year<span class="starRed" style="color: red">*</span></b></td>

                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtMake1" runat="server" class="form-control make" placeholder="Vehicle Make" AutoCompleteType="Disabled" MaxLength="50"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtModle1" runat="server" class="form-control alphanumsp" placeholder="Vehicle Model" AutoCompleteType="Disabled"  MaxLength="50"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtRegistrationNumber1" runat="server" class="form-control alphanum" placeholder="Registration Number"  MaxLength="50"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlRegistrationYear1" runat="server" class="form-control"></asp:DropDownList>
                                                    </td>
                                                </tr>


                                            </tbody>
                                        </table>
                                        <br />

                                       <%-- <div class="col-md-12">
                                            <input id="btnAddMore" type="button" value="Add More" class="btn btn-secondary " />
                                            <asp:Button ID="btnRemoves" runat="server" Text="Remove" class="btn btn-secondary " />
                                            <br />
                                            <br />

                                            <br />
                                        </div>--%>
                                    </div>
                                    <br />
                                    <br />
                                    <div class="col-md-12 col-xs-6">
                                        <div style="text-align: right">
                                            <asp:Button ID="btnNext3" runat="server" Text="Next" class="btn btn-secondary " />
                                        </div>
                                    </div>


                                </div>
                            </form>
                        </div>
                        <div id="step-4" class="">
                            <!-- <h1 class="h1Tag">Card Protection</h1> -->
                            <form class="form customForms">
                                <div style="height: 20px">
                                    <center><asp:Label ID="lblmsg4" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label>
                                       </center>
                                </div>
                                <br />
                                <div class="form-body" id="WeatherID" runat="server">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5>Select Country<span class="starRed" style="color: red">*</span></h5>
                                                <div class="controls">
                                                    <asp:DropDownList ID="ddlCountry1" runat="server" class="form-control "></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <h5>Select City<span class="starRed" style="color: red">*</span></h5>
                                                <div class="controls">
                                                    <asp:DropDownList ID="ddlCity1" runat="server" class="form-control "></asp:DropDownList>
                                                    <asp:HiddenField runat="server" ID="City1" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" id="Wheather2">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <%-- <h5>Select Country<span class="starRed" style="color: red">*</span></h5>--%>
                                                <div class="controls">
                                                    <asp:DropDownList ID="ddlCountry2" runat="server" class="form-control "></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <%-- <h5>Select City<span class="starRed" style="color: red">*</span></h5>--%>
                                                <div class="controls">
                                                    <asp:DropDownList ID="ddlCity2" runat="server" class="form-control "></asp:DropDownList>
                                                    <asp:HiddenField runat="server" ID="City2" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row" id="Wheather3">
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <%-- <h5>Select Country<span class="starRed" style="color: red">*</span></h5>--%>
                                                <div class="controls">
                                                    <asp:DropDownList ID="ddlCountry3" runat="server" class="form-control "></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <%--<h5>Select City<span class="starRed" style="color: red">*</span></h5>--%>
                                                <div class="controls">
                                                    <asp:DropDownList ID="ddlCity3" runat="server" class="form-control "></asp:DropDownList>
                                                    <asp:HiddenField runat="server" ID="City3" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-12">
                                        <input id="btnWheatherAdd" type="button" value="Add More" class="btn btn-secondary " />
                                        <input id="btnWheatherRemove" type="button" value="Remove" class="btn btn-secondary " />
                                        <%-- <asp:Button ID="btnWheatherRemove" runat="server" Text="Remove" class="btn btn-secondary " />--%>
                                        <br />
                                        <br />

                                        <br />
                                    </div>
                                    <div class="col-md-12 col-xs-6">
                                        <div style="text-align: right">
                                            <asp:Button ID="btnNext4" runat="server" Text="Next" class="btn btn-secondary " />
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div id="step-5" class="">
                            <!-- <h1 class="h1Tag">Weather Update Service</h1> -->
                            <form class="form customForms">
                                <div style="height: 20px">
                                    <center><asp:Label ID="lblmsg5" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label>
                                       </center>
                                </div>
                                <br />
                                <div class="form-body" id="CardProtectionId" runat="server">
                                    <div class="row">
                                        <!-- <h5>Weather Update Service</h5> -->
                                        <div class="col-md-6">
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <h5>Bank Name<span class="starRed" style="color: red">*</span></h5>
                                                        <asp:TextBox ID="txtBankName" runat="server" class="form-control" placeholder="Bank Name"></asp:TextBox>
                                                    </div>
                                                </div>
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <h5>Card Type<span class="starRed" style="color: red">*</span></h5>
                                                        <div class="controls">
                                                            <asp:DropDownList ID="ddlCardType" runat="server" class="form-control">
                                                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                                <asp:ListItem Text="Credit" Value="Credit"></asp:ListItem>
                                                                <asp:ListItem Text="Debit" Value="Debit"></asp:ListItem>

                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="cardDetails">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <h5>Name of Cardholder<span class="starRed" style="color: red">*</span></h5>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtNameofCardholder" runat="server" class="form-control" placeholder="Enter Cardholder Name"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="form-group">
                                                            <h5>Card Number (Last 4 digit)<span class="starRed" style="color: red">*</span></h5>
                                                            <div class="controls">
                                                                <div class="row">
                                                                    <div class="col-md-3">
                                                                        <asp:TextBox ID="txtCardNumber1" runat="server" class="form-control" placeholder="xxxx" MaxLength="4" AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <asp:TextBox ID="txtCardNumber2" runat="server" class="form-control" placeholder="xxxx" MaxLength="4" AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <asp:TextBox ID="txtCardNumber3" runat="server" class="form-control" placeholder="xxxx" MaxLength="4" AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                    <div class="col-md-3">
                                                                        <asp:TextBox ID="txtCardNumber4" runat="server" class="form-control" placeholder="xxxx" MaxLength="4" AutoCompleteType="Disabled"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <h5>Expiry Month<span class="starRed" style="color: red">*</span></h5>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="ddlExpiryMonth" runat="server" class="form-control"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-6">
                                                        <div class="form-group">
                                                            <h5>Expiry Year<span class="starRed" style="color: red">*</span></h5>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="ddlExpiryYear" runat="server" class="form-control"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="col-md-12 col-xs-6">
                                            <div style="text-align: right">
                                                <br />
                                                <asp:Button ID="btnNext5" runat="server" Text="Next" class="btn btn-secondary" />

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div id="step-6" class="">
                            <div class="modal-content">
                                <br />
                                <div class="form-body">
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="text-align: right">
                                            <div class="form-group">
                                                <label for="projectinput2" id="Sumary_name" runat="server"><b>Name :</b></label>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:Label ID="lblName" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="text-align: right">
                                            <div class="form-group">
                                                <label for="projectinput2" id="Sumary_Contactno" runat="server"><b>Conatct Number :</b></label>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:Label ID="lblContactno" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="text-align: right">
                                            <div class="form-group">
                                                <label for="projectinput2" id="Sumary_Emailid" runat="server"><b>Email Id :</b></label>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:Label ID="lblEmailid" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="text-align: right">
                                            <div class="form-group">
                                                <label for="projectinput2" id="Sumary_Policyno" runat="server"><b>Policy Number:</b></label>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:Label ID="lblpolicynum" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="text-align: right">
                                            <div class="form-group">
                                                <label for="projectinput2" id="Sumary_Startdate" runat="server"><b>Travel Start Date :</b></label>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:Label ID="lblSDate" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="text-align: right">
                                            <div class="form-group">
                                                <label for="projectinput2" id="Sumary_Enddate" runat="server"><b>Travel End Date :</b></label>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:Label ID="lblEDate" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <%--  <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-3" style="text-align: right">
                                        <div class="form-group">
                                            <label for="projectinput2"><b>Registration Number :</b></label>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <asp:Label ID="lblRegNo" runat="server"></asp:Label>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-1"></div>
                                    <div class="col-md-3" style="text-align: right">
                                        <div class="form-group">
                                            <label for="projectinput2"><b>Registration Year :</b></label>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <asp:Label ID="lblRegYear" runat="server"></asp:Label>
                                    </div>
                                </div>--%>
                                    <div class="row" id="Sumary_country" runat="server">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="text-align: right">
                                            <div class="form-group">
                                                <label for="projectinput2"><b>Country :</b></label>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:Label ID="lblCountry" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row" id="Sumary_city" runat="server">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="text-align: right">
                                            <div class="form-group">
                                                <label for="projectinput2"><b>City :</b></label>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:Label ID="lblCity" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row" id="Sumary_bankname" runat="server">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="text-align: right">
                                            <div class="form-group">
                                                <label for="projectinput2"><b>Bank Name :</b></label>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:Label ID="lblbankname" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row" id="Sumary_cardtype" runat="server">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="text-align: right">
                                            <div class="form-group">
                                                <label for="projectinput2"><b>Card Type :</b></label>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:Label ID="lblCardT" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="row" id="Sumary_nameofcardholder" runat="server">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="text-align: right">
                                            <div class="form-group">
                                                <label for="projectinput2"><b>Name of Cardholder :</b></label>
                                            </div>
                                        </div>
                                        <div class="col-md-8">
                                            <asp:Label ID="lblCardholder" runat="server"></asp:Label>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="row">
                                        <div class="col-md-1"></div>
                                        <div class="col-md-3" style="text-align: right">
                                            <div class="form-group">
                                            </div>
                                        </div>
                                        <div class="col-md-12" style="margin-left: -849px; margin-top: -25px;">

                                            <div style="text-align: right">
                                                <asp:Button ID="btnSave" runat="server" Text="Submit" class="btn btn-secondary" CausesValidation="false" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>


        <!-- ////////////////////////////////////////////////////////////////////////////-->
        <footer class="footer footer-static footer-light navbar-border navbar-shadow text-center">
            Copyright &copy; 2018 <a href="http://evolutionco.com" target="_blank">EvolutionCo</a>. All rights reserved.
        </footer>
        <!-- BEGIN VENDOR JS-->
        <script src="../Assets/js/jquery.min.js"></script>
        <link href="../Assets/css/Grid_Pagination.css" rel="stylesheet" />
        <script src="../Assets/js/scripts/bs.pagination.js"></script>
        <script src="../Assets/js/Valid.js"></script>
        <%-- my script--%>
        <script src="../Assets/js/jquery.min.js"></script>
        <script src="VAS/vendors/js/vendors.min.js" type="text/javascript"></script>
        <script src="VAS/js/core/app-menu.js" type="text/javascript"></script>
        <script src="VAS/js/core/app.js" type="text/javascript"></script>
        <script src="VAS/js/scripts/customizer.js" type="text/javascript"></script>
        <script src="VAS/js/jquery.min.js"></script>
        <script src="VAS/js/bootstrap.min.js"></script>
        <!-- <script src="js/jquery.multiselect.js"></script> -->
        <script src="VAS/js/jquery.smartWizard.js"></script>
        <script src="../Assets/js/jquery.multiselect.js" type="text/javascript"></script>
        <script>
            $(document).ready(function () {
                var counter = 0;
                $('#Wheather2').hide();
                $('#Wheather3').hide();
                $("#btnWheatherAdd").click(function () {
                    counter++;
                    if (counter == 1)
                    { $('#Wheather2').show(); }
                    else if (counter == 2)
                    { $('#Wheather2').show(); $('#Wheather3').show(); }
                    else if (counter == 3) {
                        counter = 2;
                    }

                });
                $("#btnWheatherRemove").click(function () {
                    counter--;
                    if (counter == 1) {
                        $('#ddlCountry3').val(0);
                        $('#ddlCity3').val(0);
                        $('#Wheather3').hide();
                    }
                    else if (counter == 0) {
                        $('#ddlCountry3').val(0);
                        $('#ddlCity3').val(0);
                        $('#ddlCountry2').val(0);
                        $('#ddlCity2').val(0);
                        $('#Wheather2').hide();
                        $('#Wheather3').hide();
                    }
                    else if (counter == -1)
                    { counter = 0; }
                });
            });
        </script>

        <script type="text/javascript">
            $(function () {
                $('body').on('change', '#ddlCountry1', function () {
                    var selected_CountryCode = $(this).val();
                    $.ajax({
                        type: "POST",
                        url: "Customer_VAS.aspx?Action=Country1&id=" + selected_CountryCode,
                        data: { 'selected_CountryCode': selected_CountryCode },
                        success: function (r) {
                            var myObj = $.parseJSON(r);
                            var ddlCity = "";
                            var select = $("#ddlCity1");
                            select.empty();
                            $.each(myObj, function (key, value) {
                                var content = '<option value="' + value.Country_Code + '">' + value.City + '</option>';
                                select.append(content);
                            });
                            $('#ddlCountry1').selectpicker("refresh");
                        }
                    });
                });
                $(function () {
                    $("#ddlCity1").change(function () {
                        $('#City1').val(this.text);

                    });
                });
            });


        </script>

        <script type="text/javascript">
            $(function () {
                $('body').on('change', '#ddlCountry2', function () {
                    var selected_CountryCode = $(this).val();
                    $.ajax({
                        type: "POST",
                        url: "Customer_VAS.aspx?Action=Country2&id=" + selected_CountryCode,
                        data: { 'selected_CountryCode': selected_CountryCode },
                        success: function (r) {
                            var myObj = $.parseJSON(r);
                            var ddlCity = "";
                            var select = $("#ddlCity2");
                            select.empty();
                            $.each(myObj, function (key, value) {
                                var content = '<option value="' + value.Country_Code + '">' + value.City + '</option>';
                                select.append(content);
                            });
                            $('#ddlCountry2').selectpicker("refresh");
                        }
                    });
                });
                $(function () {
                    $("#ddlCity2").change(function () {
                        $('#City2').val(this.text);
                        
                    });
                });
            });


        </script>

        <script type="text/javascript">
            $(function () {
                $('body').on('change', '#ddlCountry3', function () {
                    var selected_CountryCode = $(this).val();
                    $.ajax({
                        type: "POST",
                        url: "Customer_VAS.aspx?Action=Country3&id=" + selected_CountryCode,
                        data: { 'selected_CountryCode': selected_CountryCode },
                        success: function (r) {
                            var myObj = $.parseJSON(r);
                            var ddlCity = "";
                            var select = $("#ddlCity3");
                            select.empty();
                            $.each(myObj, function (key, value) {
                                var content = '<option value="' + value.Country_Code + '">' + value.City + '</option>';
                                select.append(content);
                            });
                            $('#ddlCountry3').selectpicker("refresh");
                        }
                    });
                });
                $(function () {
                    $("#ddlCity3").change(function () {
                        $('#City3').val(this.text);

                    });
                });
            });


        </script>

        <script type="text/javascript">
            $(function () {
                $('.multiselect-ui').multiselect({
                    includeSelectAllOption: true
                });
            });
        </script>
        <script>
            $(function () {
                $('select[multiple].active.3col').multiselect({
                    columns: 1,
                    placeholder: 'Select City',
                    search: true,
                    searchOptions: {
                        'default': 'Search City'
                    },
                    selectAll: true
                });
            });
        </script>
        <script type="text/javascript">
            $(function () {
                $("#addMore").click(function () {
                    $('#maintable tr:last').after("<tr><td><div class='row'><div class='col-md-6'><div class='controls'><input type='text' name='text' class='form-control' placeholder='1' required='' data-validation-required-message='This field is required'></div></div><div class='col-md-6'><div class='controls'><input type='text' name='text' class='form-control' placeholder='4' required='' data-validation-required-message='This field is required'></div></div></div></td><td><div class='row'><div class='col-md-12'><div class='controls'><input type='text' name='text' class='form-control' placeholder='Price' required='' data-validation-required-message='This field is required'></div></div></div></td><td><div class='row'><div class='col-md-12'><div class='controls'><input type='text' name='text' class='form-control' placeholder='Price' required='' data-validation-required-message='This field is required'></div></div></div></td><td><div class='row'><div class='col-md-12'><div class='controls'><input type='text' name='text' class='form-control' placeholder='Price' required='' data-validation-required-message='This field is required'></div></div></div></td><td><div class='row'><div class='col-md-12'><div class='controls'><input type='text' name='text' class='form-control' placeholder='Price' required='' data-validation-required-message='This field is required'></div></div></div></td></tr>");
                });
                $('#reMove').click(function () {
                    if ($('#maintable tr').length >= 4) {
                        $('#maintable tr:last').remove();
                    }
                });
            })
        </script>
        <!-- Start code for steps  -->
        <script type="text/javascript">
            $(document).ready(function () {
                // Step show event
                $("#smartwizard").on("showStep", function (e, anchorObject, stepNumber, stepDirection, stepPosition) {
                    //alert("You are on step "+stepNumber+" now");
                    if (stepPosition === 'first') {
                        $("#prev-btn").addClass('disabled');
                    } else if (stepPosition === 'final') {
                        $("#next-btn").addClass('disabled');
                    } else {
                        $("#prev-btn").removeClass('disabled');
                        $("#next-btn").removeClass('disabled');
                    }
                });
                // Toolbar extra buttons
                var btnFinish = $('').text('')
                                                 .addClass('')
                                                 .on('click', function () { alert('Finish Clicked'); });
                var btnCancel = $('').text('')
                                                 .addClass('')
                                                 .on('click', function () { $('#smartwizard').smartWizard("reset"); });
                // Smart Wizard
                $('#smartwizard').smartWizard({
                    selected: 0,
                    theme: 'default',
                    transitionEffect: 'fade',
                    showStepURLhash: true,
                    toolbarSettings: {
                        toolbarPosition: 'both',
                        toolbarButtonPosition: 'end',
                        toolbarExtraButtons: [btnFinish, btnCancel]
                    }
                });
                // External Button Events
                $("#reset-btn").on("click", function () {
                    // Reset wizard
                    $('#smartwizard').smartWizard("reset");
                    return true;
                });
                $("#prev-btn").on("click", function () {
                    // Navigate previous
                    $('#smartwizard').smartWizard("prev");
                    return true;
                });
                $("#next-btn").on("click", function (e) {
                    // Navigate next                              
                    //$('#smartwizard').smartWizard("next");
                    return true;
                });
                $("#theme_selector").on("change", function () {
                    // Change theme
                    $('#smartwizard').smartWizard("theme", $(this).val());
                    return true;
                });
                // Set selected theme on page refresh
                $("#theme_selector").change();
                /*Code for Remove tracker*/
                $("body,html").on("click", ".reset-btn", function () {

                    $(this).parent(".added_text").hide();
                });
                $("#addMoreTrack").click(function () {
                    if ($('#trackerNumber').val().length == 0) {
                        //   alert("Please enter your tracker number.");
                        $("#trackerNumber").focus();
                    }
                    else {
                        var value = $("#trackerNumber").focus();
                        var value = $("#trackerNumber").val();
                        $(".savedBtn").show();
                        $(".savedBtn ").append('<div class="added_text"><span class="savedItem">' + value + '</span><a href="javascript:void(0);" class="btn btn-sm btn-danger reset-btn">Remove</a></div>');
                        $("#trackerNumber").val(" ");
                    }
                });
                $("body,html").on("click", ".reset-btn", function () {
                    $(this).parent(".added_text").hide();
                }); b
                $("#addMoreCountries").click(function () {
                    var select_Country = $('#select_Country :selected').val();
                    var select_City = $('#select_City :selected').val();
                    $(".savedDatas").append('<div class="added_text"><span class="savedCountries">' + select_Country + '</span><span class="savedCities">' + select_City + '</span><a href="javascript:void(0);" id="reMoveCountry" class="btn btn-sm btn-danger reset-btn">Remove</a></div>');
                });
            });


        </script>

        <script>
            $(document).ready(function () {
                $('#txtContactNumber').bind('keyup', function (e) {
                    if (this.value.match(/[^0-9.]/g)) {
                        this.value = this.value.replace(/[^0-9.]/g, '');
                    }
                });
                var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                $('#txtName').name();
                $('#txtContactNumber').numeric();
                $('#txtPolicyNo').AlphaNumeric();
                $('#btnNext1').click(function (e) {

                    if ($('#txtName').val() == '') {
                        $('#SpnMsg').text('*Enter a Name').css("color", "red");
                        $('#txtName').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtContactNumber').val() == '') {
                        $('#SpnMsg').text('*Enter a Contact Number').css("color", "red");
                        $('#txtContactNumber').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtContactNumber').val().length != 10) {
                        $('#SpnMsg').text('*Contact Number must be 10 digits').css("color", "red");
                        $('#txtContactNumber').focus();
                        e.preventDefault();
                        return false;
                    }

                    else if ($('#txtEmail').val() == '') {
                        $('#SpnMsg').text('*Enter a Email').css("color", "red");
                        $('#txtEmail').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (!re.test($('#txtEmail').val())) {
                        $('#SpnMsg').text('Invalid Email').css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtPolicyNo').val() == '') {
                        $('#SpnMsg').text('*Enter a Policy Number').css("color", "red");
                        $('#txtPolicyNo').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtTravelStartDate').val() == '') {
                        $('#SpnMsg').text('*Enter a Start Date').css("color", "red");
                        $('#txtTravelStartDate').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtEndDate').val() == '') {
                        $('#SpnMsg').text('*Enter a End Date').css("color", "red");
                        $('#txtEndDate').focus();
                        e.preventDefault();
                        return false;
                    }

                    else {
                        $('#SpnMsg').text('');
                    }

                    e.preventDefault();

                    $('#lblName').text($('#txtName').val());
                    $('#lblContactno').text($('#txtContactNumber').val());
                    $('#lblEmailid').text($('#txtEmail').val());
                    $('#lblpolicynum').text($('#txtPolicyNo').val());
                    $('#lblSDate').text($('#txtTravelStartDate').val());
                    $('#lblEDate').text($('#txtEndDate').val());


                    var array = $('#CheckTab').val().split(",");
                    $.each(array, function (i) {
                        //  alert(array[i]);                       
                    });
                    if ($.inArray('Luggage Tracker', array) !== -1) {

                        $('#CI').removeClass("active");
                        $('#LT').addClass("active");
                        $("#step-2").show();
                        $("#step-1").hide();
                        $(".nav-item active").hide();
                    }

                    else if ($.inArray('Roadside Assistance', array) !== -1) {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').addClass("active");
                        $("#step-3").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                    }
                    else if ($.inArray('Weather Update', array) !== -1) {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').removeClass("active");
                        $('#WU').addClass("active");
                        $("#step-4").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                        $("#step-3").hide()
                    }
                    else if ($.inArray('Card Protection', array) !== -1) {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').removeClass("active");
                        $('#WU').removeClass("active");
                        $('#CP').addClass("active");
                        $("#step-5").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                        $("#step-3").hide()
                        $("#step-4").hide();
                    }
                    else {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').removeClass("active");
                        $('#WU').removeClass("active");
                        $('#CP').removeClass("active");
                        $('#FS').addClass("active");
                        $("#step-6").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                        $("#step-3").hide()
                        $("#step-4").hide();
                        $("#step-5").hide();

                        $("#Sumary_bankname").hide();
                        $("#Sumary_cardtype").hide();
                        $("#Sumary_nameofcardholder").hide();
                        $("#Sumary_country").hide();
                        $("#Sumary_city").hide();

                    }

                    return false;
                });
            });
            $(document).ready(function () {
                           
                //$('#txttrackerNumber1').AlphaNumeric();
                $('#btnNext2').click(function (e) {
                  
                    var TrackerNo = /^[a-zA-Z]{2}[0-9]{10}$/;
                    if ($('#txttrackerNumber1').val() == '') {
                        $('#lblMSg2').text('*Enter a tracker Number').css("color", "red");
                        $('#txttrackerNumber1').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txttrackerNumber1').val().length !=12) {
                        $('#lblMSg2').text('*Tracker Number must be 12 digit').css("color", "red");
                        $('#txttrackerNumber1').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (!TrackerNo.test($('#txttrackerNumber1').val())) {
                        $('#lblMSg2').text('*Tracker Number must be alphanumeric ex-AB1234567895').css("color", "red");
                        $('#txttrackerNumber1').focus();
                        e.preventDefault();
                        return false;
                    }
                   
                    else {
                        $('#lblMSg2').text('');
                    }
                    //SaveTracker(totaladd);
                    SaveTracker();
                    var array = $('#CheckTab').val().split(",");
                    $.each(array, function (i) {
                        //alert(array[i]);
                    });


                    if ($.inArray('Roadside Assistance', array) !== -1) {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').addClass("active");
                        $("#step-3").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                    }
                    else if ($.inArray('Weather Update', array) !== -1) {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').removeClass("active");
                        $('#WU').addClass("active");
                        $("#step-4").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                        $("#step-3").hide()
                    }
                    else if ($.inArray('Card Protection', array) !== -1) {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').removeClass("active");
                        $('#WU').removeClass("active");
                        $('#CP').addClass("active");
                        $("#step-5").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                        $("#step-3").hide()
                        $("#step-4").hide();
                    }
                    else {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').removeClass("active");
                        $('#WU').removeClass("active");
                        $('#CP').removeClass("active");
                        $('#FS').addClass("active");
                        $("#step-6").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                        $("#step-3").hide()
                        $("#step-4").hide();
                        $("#step-5").hide();

                        $("#Sumary_bankname").hide();
                        $("#Sumary_cardtype").hide();
                        $("#Sumary_nameofcardholder").hide();
                        $("#Sumary_country").hide();
                        $("#Sumary_city").hide();
                    }

                    e.preventDefault();



                    return false;
                });


            });
            $(document).ready(function () {
                //$('#btnRemoves').hide();
                //$('.make').name();
                //$('.alphanum').AlphaNumeric();
                //$('.alphanumsp').on('input', function (event) {
                //    this.value = this.value.replace(/[^a-zA-Z0-9 ]/g, '');
                //});

                //var totalRoadside = 1;
                //$("#btnAddMore").click(function (e) {
                //    if (totalRoadside < 3) {
                //        totalRoadside++;
                //        var Roadsidetr = "<tr>";
                //        Roadsidetr = Roadsidetr + "<td>";
                //        Roadsidetr = Roadsidetr + " <input type='text' ID='txtMake" + totalRoadside + "'   class='form-control make' placeholder='Make' AutoCompleteType='Disabled'> <br />";
                //        Roadsidetr = Roadsidetr + "</td>";
                //        Roadsidetr = Roadsidetr + "<td>";
                //        Roadsidetr = Roadsidetr + " <input type='text' ID='txtModle" + totalRoadside + "'  class='form-control alphanumsp' placeholder='AL-Model' AutoCompleteType='Disabled'> <br />";
                //        Roadsidetr = Roadsidetr + "</td>";
                //        Roadsidetr = Roadsidetr + "<td>";
                //        Roadsidetr = Roadsidetr + "   <input type='text' ID='txtRegistrationNumber" + totalRoadside + "'  class='form-control alphanum' placeholder='Registration Number'>";
                //        Roadsidetr = Roadsidetr + "</td>";
                //        Roadsidetr = Roadsidetr + "<td>";
                //        Roadsidetr = Roadsidetr + "  <select ID='ddlRegistrationYear" + totalRoadside + "'  class='form-control'> <br />";
                //        Roadsidetr = Roadsidetr + "</td>";
                //        Roadsidetr = Roadsidetr + "</tr>";
                //        $('#maindiv').append(Roadsidetr);
                //        $('#btnRemoves').show();
                //        $.ajax({
                //            type: "POST",
                //            url: "Customer_VAS.aspx?Action=PostDetail&id=1",
                //            data: { 'Id': '1' },

                //            success: function (r) {
                //                var myObj = $.parseJSON(r);

                //                var select = $("#ddlRegistrationYear" + totalRoadside);
                //                select.empty();
                //                $.each(myObj, function (key, value) {
                //                    var content = '<option value="' + value.Id + '">' + value.RegistrationYear + '</option>';
                //                    select.append(content);
                //                });
                //                $("#ddlRegistrationYear" + totalRoadside).selectpicker("refresh");
                //            }
                //        });


                //    }

                //    $('.make').on('input', function (event) {
                //        this.value = this.value.replace(/[^a-zA-Z ]/g, '');
                //    });
                //    $('.alphanum').on('input', function (event) {
                //        this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
                //    });
                //    $('.alphanumsp').on('input', function (event) {
                //        this.value = this.value.replace(/[^a-zA-Z0-9 ]/g, '');
                //    });
                //});
                //$('#btnRemoves').click(function (e) {
                //    if ($('#maintable tr').length > 2) {
                //        $('#maintable tr:last').remove();
                //        totalRoadside--;
                //    }
                //    if ($('#maintable tr').length == 2) {

                //        $('#btnRemoves').hide();
                //    }
                //    else {

                //    }
                //    e.preventDefault();
                //});

                $('#btnNext3').click(function (e) {

                    if ($('#txtMake1').val() == '') {
                        $('#bblmsg3').text('*Enter a vehicle Make').css("color", "red");
                        $('#txtMake1').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtModle1').val() == '') {
                        $('#bblmsg3').text('*Enter a vehicle model name').css("color", "red");
                        $('#txtModle1').focus();
                        e.preventDefault();
                        return false;
                    }
                    
                    else if ($('#txtRegistrationNumber1').val() == '') {
                        $('#bblmsg3').text('*Enter a Registration Number').css("color", "red");
                        $('#txtRegistrationNumber1').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#ddlRegistrationYear1').val() == '--Select--') {
                        $('#bblmsg3').text('*Select a Registration Year').css("color", "red");
                        $('#ddlRegistrationYear1').focus();
                        e.preventDefault();
                        return false;
                    }
                    else {
                        $('#bblmsg3').text('');
                    }

                    var array = $('#CheckTab').val().split(",");
                    $.each(array, function (i) {
                        // alert(array[i]);
                    });


                    if ($.inArray('Weather Update', array) !== -1) {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').removeClass("active");
                        $('#WU').addClass("active");
                        $("#step-4").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                        $("#step-3").hide()

                        $("#Sumary_country").show();
                        $("#Sumary_city").show();
                    }
                    else if ($.inArray('Card Protection', array) !== -1) {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').removeClass("active");
                        $('#WU').removeClass("active");
                        $('#CP').addClass("active");
                        $("#step-5").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                        $("#step-3").hide();
                        $("#step-4").hide();
                        $("#Sumary_country").hide();
                        $("#Sumary_city").hide();

                    }
                    else {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').removeClass("active");
                        $('#WU').removeClass("active");
                        $('#CP').removeClass("active");
                        $('#FS').addClass("active");
                        $("#step-6").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                        $("#step-3").hide();
                        $("#step-4").hide();
                        $("#step-5").hide();
                        $("#Sumary_bankname").hide();
                        $("#Sumary_cardtype").hide();
                        $("#Sumary_nameofcardholder").hide();
                        $("#Sumary_country").hide();
                        $("#Sumary_city").hide();

                    }

                    e.preventDefault();

                    SaveRoadside();


                    return false;
                });
            });
            $(document).ready(function () {
                $('#btnNext4').click(function (e) {
                    if ($('#ddlCountry1').val() == 0) {
                        $('#lblmsg4').text('*Select a Country').css("color", "red");
                        $('#ddlCountry1').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#ddlCity1').val() == 0) {
                        $('#lblmsg4').text('*Select a City').css("color", "red");
                        $('#ddlCity1').focus();
                        e.preventDefault();
                        return false;
                    }
                    else {
                        $('#lblmsg4').text('');
                    }

                    var array = $('#CheckTab').val().split(",");
                    $.each(array, function (i) {
                        // alert(array[i]);
                    });
                    if ($.inArray('Card Protection', array) !== -1) {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').removeClass("active");
                        $('#WU').removeClass("active");
                        $('#CP').addClass("active");
                        $("#step-5").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                        $("#step-3").hide();
                        $("#step-4").hide();

                        $("#Sumary_bankname").show();
                        $("#Sumary_cardtype").show();
                        $("#Sumary_nameofcardholder").show();

                    }
                    else {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').removeClass("active");
                        $('#WU').removeClass("active");
                        $('#CP').removeClass("active");
                        $('#FS').addClass("active");
                        $("#step-6").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                        $("#step-3").hide();
                        $("#step-4").hide();
                        $("#step-5").hide();
                        $("#Sumary_bankname").hide();
                        $("#Sumary_cardtype").hide();
                        $("#Sumary_nameofcardholder").hide();
                        $("#Sumary_country").show();
                        $("#Sumary_city").show();
                    }

                    e.preventDefault();
                    var Country = '';                   
                    if ($('#ddlCountry2 option:selected').text() == '--Select--' && $('#ddlCountry3 option:selected').text() == '--Select--') {
                        Country = $('#ddlCountry1 option:selected').text();                        
                    }
                    else if ($('#ddlCountry2 option:selected').text() != '--Select--' && $('#ddlCountry3 option:selected').text() != '--Select--') {
                        Country = $('#ddlCountry1 option:selected').text() + ',' + $('#ddlCountry2 option:selected').text() + ',' + $('#ddlCountry3 option:selected').text();                      
                    }
                    else if ($('#ddlCountry2 option:selected').text() != '--Select--' && $('#ddlCountry3 option:selected').text() == '--Select--') {
                        Country = $('#ddlCountry1 option:selected').text() + ',' + $('#ddlCountry2 option:selected').text();                        
                    }
                    else if ($('#ddlCountry3 option:selected').text() != '--Select--' && $('#ddlCountry2 option:selected').text() == '--Select--') {
                        Country = $('#ddlCountry1 option:selected').text() + ',' + $('#ddlCountry3 option:selected').text();                        
                    }
                    else {
                        Country = $('#ddlCountry1 option:selected').text();                        
                    }
                    
                    var City = '';                 
                    if ($('#ddlCity2 option:selected').text() == '' && $('#ddlCity3 option:selected').text() == '') {
                        City = $('#ddlCity1 option:selected').text();
                    }
                    else if ($('#ddlCity2 option:selected').text() != '' && $('#ddlCity2 option:selected').text() != '') {
                        City = $('#ddlCity1 option:selected').text() + ',' + $('#ddlCity2 option:selected').text() + ',' + $('#ddlCity3 option:selected').text();
                    }
                    else if ($('#ddlCity2 option:selected').text() != '' && $('#ddlCity3 option:selected').text() == '') {
                        City = $('#ddlCity1 option:selected').text() + ',' + $('#ddlCity2 option:selected').text();
                    }
                    else if ($('#ddlCity3 option:selected').text() != '' && $('#ddlCity2 option:selected').text() == '') {
                        City = $('#ddlCity1 option:selected').text() + ',' + $('#ddlCity3 option:selected').text();
                    }
                    else {
                        City = $('#ddlCity1 option:selected').text();
                    }
                    
                    $('#lblCountry').text(Country);
                    $('#lblCity').text(City);
                    return false;
                });
            });
            $(document).ready(function () {
                $("#txtBankName").bind('keyup', function (e) {
                    if (this.value.match(/[^a-zA-Z0-9. ]/g)) {
                        this.value = this.value.replace(/[^a-zA-Z0-9. ]/g, '');
                    }
                });
                $('#txtNameofCardholder').name();
                $('#txtCardNumber1').numeric();
                $('#txtCardNumber2').numeric();
                $('#txtCardNumber3').numeric();
                $('#txtCardNumber4').numeric();
                $('#btnNext5').click(function (e) {
                    if ($('#txtBankName').val() == 0) {
                        $('#lblmsg5').text('*Enter a Bank Name').css("color", "red");
                        $('#txtBankName').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#ddlCardType').val() == 0) {
                        $('#lblmsg5').text('*Select a Card Type').css("color", "red");
                        $('#ddlCardType').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtNameofCardholder').val() == "") {
                        $('#lblmsg5').text('*Enter a Name of Cardholder').css("color", "red");
                        $('#txtNameofCardholder').focus();
                        e.preventDefault();
                        return false;
                    }

                    else if ($('#txtCardNumber4').val() == "") {
                        $('#lblmsg5').text('*Enter last 4 digit of your Card Number').css("color", "red");
                        $('#txtCardNumber4').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtCardNumber4').val().length !=4) {
                        $('#lblmsg5').text('*Must be 4 digit of your card number').css("color", "red");
                        $('#txtCardNumber4').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#ddlExpiryMonth').val() == 0) {
                        $('#lblmsg5').text('*Select a Expiry Month').css("color", "red");
                        $('#ddlExpiryMonth').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#ddlExpiryYear').val() == 0) {
                        $('#lblmsg5').text('*Select a Expiry Year').css("color", "red");
                        $('#ddlExpiryYear').focus();
                        e.preventDefault();
                        return false;
                    }
                    else {
                        $('#lblmsg5').text('');
                    }



                    var array = $('#CheckTab').val().split(",");
                    $.each(array, function (i) {
                        // alert(array[i]);
                    });
                    if ($.inArray('Card Protection', array) !== -1) {

                        $('#CI').removeClass("active");
                        $('#LT').removeClass("active");
                        $('#RA').removeClass("active");
                        $('#WU').removeClass("active");
                        $('#CP').removeClass("active");
                        $('#FS').addClass("active");
                        $("#step-6").show();
                        $("#step-1").hide();
                        $("#step-2").hide();
                        $("#step-3").hide();
                        $("#step-4").hide();
                        $("#step-5").hide();
                    }

                    e.preventDefault();

                    //$('#lblName').text($('#txtName').val());
                    //$('#lblContactno').text($('#txtContactNumber').val());
                    //$('#lblEmailid').text($('#txtEmail').val());
                    //$('#lblpolicynum').text($('#txtPolicyNo').val());
                    //$('#lblSDate').text($('#txtTravelStartDate').val());
                    //$('#lblEDate').text($('#txtEndDate').val());
                    // $('#lblRegNo').text($('#txtRegistrationNumber1').val());
                    // $('#lblRegYear').text($('#ddlRegistrationYear1 option:selected').text());
                    //$('#lblCountry').text($('#ddlCountry option:selected').text());
                    //$('#lblCity').text($('#ddlCity option:selected').text());
                    $('#lblbankname').text($('#txtBankName').val());
                    $('#lblCardT').text($('#ddlCardType option:selected').text());
                    $('#lblCardholder').text($('#txtNameofCardholder').val());



                    return false;
                });



            });
            $(document).ready(function () {
                $('#btnSave').click(function (e) {
                    
                    SaveAllVAS();
                    e.preventDefault();
                    // $('#CI').removeClass("active");
                    $('#LT').removeClass("active");
                    $('#RA').removeClass("active");
                    $('#WU').removeClass("active");
                    $('#CP').removeClass("active");
                    $('#FS').removeClass("active");
                    $('#CI').addClass("active");
                    $("#step-1").show();
                    $("#step-6").hide();
                    $("#step-2").hide();
                    $("#step-3").hide();
                    $("#step-4").hide();
                    $("#step-5").hide();

                    return false;
                });
            });
        </script>

        <script>
            //function SaveTracker(cnt) {
            function SaveTracker() {
               
                var data = JSON.stringify(getdata());
               //  alert(data);
                $.ajax({
                    url: "Customer_VAS.aspx?Action=SaveData&lb=" + data + "&PolicyNo=" + $('#txtPolicyNo').val(),
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({ 'LaggageTracker': data }),
                    success: function (response) {
                        if (response != '') {
                            if (response.toString() == 'F') {

                            }
                        }
                    },
                    error: function () {
                        // alert("Error while inserting data");
                    }
                });
            }
            function getdata() {
                var data = [];               
                    var PolicyNo = $('#txtPolicyNo').val();
                    var TrackerNumber = $('#txttrackerNumber1').val();                  
                    var alldata = {
                        'PolicyNo': PolicyNo,
                        'TrackerNumber': TrackerNumber
                    }
                    data.push(alldata);                
                return data;
            }
        </script>
        <script>

            function SaveAllVAS(cnt2) {
                var data = JSON.stringify(getdata2(cnt2));
                  //alert(data);
                $.ajax({
                    url: "Customer_VAS.aspx?Action=SaveData2&lb=" + data,
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({ 'VASInfo': data }),
                    success: function (response) {
                        if (response != '') {
                            if (response.toString() == 'F') {
                                //alert("You will now be redirected.");
                                window.location = "VASAlert.aspx?Id=" + 2;
                            }
                        }
                    },
                    error: function () {
                        alert("Error while inserting data");
                    }
                });
            }

            function getdata2(cnt2) {
                var array = $('#CheckTab').val().split(",");
                var BankName = '';
                var NameofCardholder = '';
                var CardNumber1 = '';
                var CardNumber2 = '';
                var CardNumber3 = '';
                var CardNumber4 = '';
                if ($.inArray('Card Protection', array) !== -1) {
                    BankName = $('#txtBankName').val();
                    NameofCardholder = $('#txtNameofCardholder').val();

                    CardNumber1 = $('#txtCardNumber1').val();
                    CardNumber2 = $('#txtCardNumber2').val();
                    CardNumber3 = $('#txtCardNumber3').val();
                    CardNumber4 = $('#txtCardNumber4').val();
                }


                var data = [];
                          
                var Country = '';
                //alert(Country);
                if ($('#ddlCountry2 option:selected').text() == '--Select--' && $('#ddlCountry3 option:selected').text() == '--Select--')
                {
                    Country = $('#ddlCountry1 option:selected').text();
                }
                else if ($('#ddlCountry2 option:selected').text() != '--Select--' && $('#ddlCountry3 option:selected').text() != '--Select--') {
                    Country = $('#ddlCountry1 option:selected').text() + ',' + $('#ddlCountry2 option:selected').text() + ',' + $('#ddlCountry3 option:selected').text();
                }
                else if ($('#ddlCountry2 option:selected').text() != '--Select--' && $('#ddlCountry3 option:selected').text() == '--Select--')
                {
                    Country = $('#ddlCountry1 option:selected').text() + ',' + $('#ddlCountry2 option:selected').text();
                }
               
                else if ($('#ddlCountry3 option:selected').text() != '--Select--' && $('#ddlCountry2 option:selected').text() == '--Select--')
                {
                    Country = $('#ddlCountry1 option:selected').text() + ',' + $('#ddlCountry3 option:selected').text();
                }
                else {
                    Country = $('#ddlCountry1 option:selected').text();
                }
                
                var City = '';

                if ($('#ddlCity2 option:selected').text() == '' && $('#ddlCity3 option:selected').text() == '') {
                    City = $('#ddlCity1 option:selected').text();
                }
                else if ($('#ddlCity2 option:selected').text() != '' && $('#ddlCity2 option:selected').text() != '') {
                    City = $('#ddlCity1 option:selected').text() + ',' + $('#ddlCity2 option:selected').text() + ',' + $('#ddlCity3 option:selected').text();
                }
                else if ($('#ddlCity2 option:selected').text() != '' && $('#ddlCity3 option:selected').text() == '') {
                    City = $('#ddlCity1 option:selected').text() + ',' + $('#ddlCity2 option:selected').text();
                }
                else if ($('#ddlCity3 option:selected').text() != '' && $('#ddlCity2 option:selected').text() == '') {
                    City = $('#ddlCity1 option:selected').text() + ',' + $('#ddlCity3 option:selected').text();
                }
                else {
                    City = $('#ddlCity1 option:selected').text();
                }
                
                var PolicyNo = $('#txtPolicyNo').val();
                var Name = $('#txtName').val();
                var ContactNo = $('#txtContactNumber').val();
                var Email = $('#txtEmail').val();
                var Startdate = $('#txtTravelStartDate').val();
                var Enddate = $('#txtEndDate').val();
                var Make = $('#txtMake1').val();
                var Modle = $('#txtModle1').val();
                var RegNo = $('#txtRegistrationNumber1').val();
                var ExpiryYear = $('#ddlRegistrationYear1 option:selected').text();
                //var Country = $('#ddlCountry1 option:selected').text() + ',' + Country1 + ',' + Country2;
                //var City = ($.map($("select[id*=ddlCity] option:selected"), function (item, i) { return $(item).text() })).join(",");
                //var BankName = $('#txtBankName').val();
                var CardType = $('#ddlCardType option:selected').text();
                //var NameofCardholder = $('#txtNameofCardholder').val();

                //var CardNumber1 = $('#txtCardNumber1').val();
                //var CardNumber2 = $('#txtCardNumber2').val();
                //var CardNumber3 = $('#txtCardNumber3').val();
                //var CardNumber4 = $('#txtCardNumber4').val();
                var ExpiryMonth = $('#ddlExpiryMonth option:selected').text();
                var ExpiryYearSS = $('#ddlExpiryYear option:selected').text();


                var alldata2 = {
                    'PolicyNo': PolicyNo,
                    'Name': Name,
                    'ContactNo': ContactNo,
                    'Email': Email,
                    'Startdate': Startdate,
                    'Enddate': Enddate,
                    'Make': Make,
                    'Modle': Modle,
                    'RegNo': RegNo,
                    'ExpiryYear': ExpiryYear,
                    'Country': Country,
                    'City': City,
                    'BankName': BankName,
                    'CardType': CardType,
                    'NameofCardholder': NameofCardholder,
                    'CardNumber1': CardNumber1,
                    'CardNumber2': CardNumber2,
                    'CardNumber3': CardNumber3,
                    'CardNumber4': CardNumber4,
                    'ExpiryMonth': ExpiryMonth,
                    'ExpiryYearSS': ExpiryYearSS

                }
                data.push(alldata2);

                return data;
            }
        </script>

        <script>
            function SaveRoadside() {
                var data = JSON.stringify(getdata3());
                // alert(data);
                $.ajax({
                    url: "Customer_VAS.aspx?Action=SaveRoadSide&RS=" + data + "&PolicyNo=" + $('#txtPolicyNo').val(),
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: JSON.stringify({ 'RoadAssistance': data }),
                    success: function (response) {
                        if (response != '') {
                            if (response.toString() == 'F') {

                            }
                        }
                    },
                    error: function () {
                        // alert("Error while inserting data");
                    }
                });
            }
            function getdata3(RSA) {
                // alert(2);
                var data = [];              
                    var PolicyNo = $('#txtPolicyNo').val();
                    var Make = $('#txtMake1').val();
                    var Model = $('#txtModle1').val();
                    var RegNo = $('#txtRegistrationNumber1').val();
                    var RegYear = $('#ddlRegistrationYear1').val();
                    
                    var alldata = {
                        'PolicyNo': PolicyNo,
                        'Make': Make,
                        'Model': Model,
                        'RegNo': RegNo,
                        'RegYear': RegYear
                    }
                    data.push(alldata);                
                return data;
            }
        </script>
        <script src="../Assets/js/core/app-menu.js" type="text/javascript"></script>
        <script src="../Assets/js/core/app.js" type="text/javascript"></script>
        <script src="../Assets/js/scripts/customizer.js" type="text/javascript"></script>


    </form>
</body>
</html>
