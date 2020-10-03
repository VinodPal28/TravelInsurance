<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<html class="loading" lang="en" data-textdirection="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Modern admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities with bitcoin dashboard.">
    <meta name="keywords" content="admin template, modern admin template, dashboard template, flat admin template, responsive admin template, web app, crypto dashboard, bitcoin dashboard">
    <meta name="author" content="PIXINVENT">
    <title>Allianz : Recover Password</title>
   <link rel="apple-touch-icon" href="../Assets/images/ico/fav-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="../Assets/images/ico/fav-icon.png">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Quicksand:300,400,500,700"
        rel="stylesheet">
    <link href="https://maxcdn.icons8.com/fonts/line-awesome/1.1/css/line-awesome.min.css"
        rel="stylesheet">
    <!-- BEGIN VENDOR CSS-->
    <link rel="stylesheet" type="text/css" href="assets/css/vendors.css">
    <!-- END VENDOR CSS-->
    <!-- BEGIN MODERN CSS-->
    <link rel="stylesheet" type="text/css" href="assets/css/app.css">
    <!-- END MODERN CSS-->
    <!-- BEGIN Page Level CSS-->
    <link rel="stylesheet" type="text/css" href="assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="assets/css/core/colors/palette-gradient.css">
    <!-- END Page Level CSS-->
    <!-- BEGIN Custom CSS-->
    <link rel="stylesheet" type="text/css" href="../../../assets/css/style.css">
    <!-- END Custom CSS-->

    <script src="assets/js/jquery.min.js"></script>
    <script type="text/javascript">
       function SendEmail() {            
           $.ajax({
               url: "ForgotPassword.aspx/Page_Load",
               data: {
                   method: "SendEmail",
                   Email: $("#txtEmail").val()
               },
               success: function (msg) {
                   if (msg != '') {
                       var data = msg.split('#');
                       if (data[0].toString() == 'F') {                          
                           $('#emailStatus').text('An email has been sent to the email you entered').css("color", "green");
                       }
                       if (data[0].toString() == 'NF') {                           
                           $('#emailStatus').text('An email has been sent to the email you entered.').css("color", "green");
                       }
                       $('#txtEmail').val("");
                   }
               }             
           });

       }
       function OnSuccess(response) {
           alert(response.d);
       }
       $(document).ready(function () {
           $('#btnSubmit').click(function (e) {
               var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
               if ($('#txtEmail').val() == "") {
                   $('#emailStatus').text('Please enter the email address').css("color", "red");
                   e.preventDefault();
                   return false;
               }
              
               else if (!re.test($('#txtEmail').val())) {
                   $('#emailStatus').text('Invalid Email').css("color", "red");
                   e.preventDefault();
                   return false;
               }
               else
               {
                   $('#emailStatus').text('');
               }
               SendEmail();
               e.preventDefault();
               return false;
           });
       });
     
   </script>
</head>
<body class="vertical-layout vertical-menu 1-column   menu-expanded blank-page blank-page"
    data-open="click" data-menu="vertical-menu" data-col="1-column">
    <!-- ////////////////////////////////////////////////////////////////////////////-->
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <form runat="server">
                <div class="content-body">
                    <section class="flexbox-container">
                        <div class="col-12 d-flex align-items-center justify-content-center">
                            <div class="col-md-4 col-10 box-shadow-2 p-0">
                                <div class="card border-grey border-lighten-3 px-2 py-2 m-0">
                                    <div class="card-header border-0 pb-0">
                                        <div class="card-title text-center">
                                            <h1>Allianz</h1>
                                            <!-- <img src="images/logo/logo-dark.png" alt="branding logo"> -->
                                        </div>
                                        <h6 class="card-subtitle line-on-side text-muted text-center font-small-3 pt-2">
                                            <span>We will send you a link to reset password.</span>
                                        </h6>
                                    </div>
                                   
                                    <div class="card-content">
                                        <div class="card-body">
                                            <div style="height:20px"><asp:Label ID="emailStatus" runat="server"></asp:Label></div> 
                                            <%--   <form class="form-horizontal" action="login-simple.html" novalidate>--%>
                                            <fieldset class="form-group position-relative has-icon-left">
                                                <input type="text" id="txtEmail" runat="server" class="form-control form-control-lg input-lg" placeholder="Your Email Address" required  />                                          
                                                <div class="form-control-position">
                                                    <i class="ft-mail"></i>
                                                </div>
                                            </fieldset>
                                            <button type="submit" id="btnSubmit" class="btn btn-outline-info btn-lg btn-block" ><i class="ft-unlock"></i>Recover Password</button>
                                            <%--  </form>--%>
                                        </div>
                                    </div>
                                    <div class="card-footer border-0">
                                        <p class="float-sm-left text-center"><a href="Home.aspx" class="card-link">Login</a></p>
                                        <%--<p class="float-sm-right text-center">New to Modern ? <a href="register-simple.html" class="card-link">Create Account</a></p>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </section>
                </div>
            </form>
        </div>
    </div>
    <!-- ////////////////////////////////////////////////////////////////////////////-->
    <!-- BEGIN VENDOR JS-->
    <script src="assets/vendors/js/vendors.min.js" type="text/javascript"></script>
    <!-- BEGIN VENDOR JS-->
    <!-- BEGIN PAGE VENDOR JS-->
    <script src="assets/vendors/js/forms/validation/jqBootstrapValidation.js" type="text/javascript"></script>
    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN MODERN JS-->
    <script src="assets/js/core/app-menu.js" type="text/javascript"></script>
    <script src="assets/js/core/app.js" type="text/javascript"></script>
    <!-- END MODERN JS-->
    <!-- BEGIN PAGE LEVEL JS-->
    <script src="assets/js/scripts/forms/form-login-register.js" type="text/javascript"></script>
    <script src="../Assets/js/PreventRightClick.js"></script>
    <!-- END PAGE LEVEL JS-->
</body>
</html>
