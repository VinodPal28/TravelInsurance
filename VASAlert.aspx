<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VASAlert.aspx.cs" Inherits="VASAlert" %>


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

                <div id="smartwizard">
                     <div id="travelstartdate" runat="server">
                        <div id="step-7" class="">
                            <div class="form-body">
                                <div class="row">

                                    <div class="col-md-12 text-xl-center" style="padding-top: 50px; height: 600px;">
                                        <div class="alert alert-warning text-xl-center ">
                                            <strong>Your travel has been started can not proceed for further details.</strong>
                                        </div>

                                    </div>


                                </div>

                            </div>
                        </div>
                    </div>


                    <div id="Success" runat="server">
                        <div id="step-6" class="">
                            <div class="form-body">
                                <div class="row">

                                    <div class="col-md-12 text-xl-center" style="padding-top: 50px; height: 600px;">
                                        <div class="alert alert-success text-xl-center ">
                                            <strong>Thank You for submitting your details to avail Value Added Services</strong>
                                        </div>

                                    </div>


                                </div>

                            </div>
                        </div>
                    </div>

                    <div id="Div_Alert" runat="server">
                        <div class="">
                            <div class="form-body">
                                <div class="row">

                                    <div class="col-md-12 text-xl-center" style="padding-top: 50px; height: 600px;">
                                        <div class="alert alert-danger">
                                            <strong>Already submitted details.</strong> 
                                        </div>

                                    </div>


                                </div>

                            </div>
                        </div>
                    </div>

                    <div id="D_NotExist" runat="server">
                        <div class="">
                            <div class="form-body">
                                <div class="row">

                                    <div class="col-md-12 text-xl-center" style="padding-top: 50px; height: 600px;">
                                        <div class="alert alert-danger">
                                            <strong>Details Does not Exist.</strong> 
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

    </form>
</body>
</html>

