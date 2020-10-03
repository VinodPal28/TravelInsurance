<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePswd.aspx.cs" Inherits="ChangePswd" %>

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
        function ValidatePwd(Pwd) {
            var reg = /(?=^.{8,12}$)(?=(?:.*?\d){2})(?=.*[a-z])(?=(?:.*?[A-Z]){1})(?=(?:.*?[!@#$%*()_+^&}{:;?.]){1})(?!.*\s)[0-9a-zA-Z!@#$%*()_+^&]*$/;
            if (reg.test(Pwd)) {
                return true;
            }
            else {
                return false;
            }
        }
        function ChangePassword() {
           $.ajax({
               url: "ChangePswd.aspx/Page_Load",
               data: {
                   method: "Change_Password",
                   OldPswd: $("#txtOldPswd").val(),
                   NewPswd: $("#txtNewPswd").val()
               },
               success: function (msg) {
                   if (msg != '') {                      
                       if (msg == 'F') {
                           $('#lblMsg').text('Password has been changed successfully !').css("color", "green");
                       }
                       else if (msg == 'NA') {
                           $('#lblMsg').text('Old password is invalid !').css("color", "red");
                       }
                       else {
                           $('#lblMsg').text('');
                       }
                   }
                   $('#txtOldPswd').val('');
                   $('#txtNewPswd').val('');
                   $('#txtConfirmPswd').val('');
               }             
           });

       }
       function OnSuccess(response) {
           alert(response.d);
       }
       $(document).ready(function () {
           $('#btnSave').click(function (e) {             
               if ($('#txtOldPswd').val() == "") {
                   $('#lblMsg').text('Enter the old password').css("color", "red");
                   $('#txtOldPswd').focus();
                   e.preventDefault();
                   return false;
               }              
               else if ($('#txtNewPswd').val() == "") {
                   $('#lblMsg').text('Enter the new password').css("color", "red");
                   $('#txtNewPswd').focus();
                   e.preventDefault();
                   return false;
               }
               else if ($('#txtNewPswd').val().length < 8) {
                   $('#lblMsg').text('Password Length must be between 8 and 12').css("color", "red");
                   $('#txtNewPswd').focus();
                   e.preventDefault();
                   return false;
               }
               else if (!ValidatePwd($('#txtNewPswd').val())) {
                   $('#lblMsg').text('Password Must Be Contain atleast One Capital,One Small Character,One Special and Two Numeric').css("color", "red");
                   $('#txtNewPswd').focus();
                   e.preventDefault();
                   return false;
            }
               else if ($('#txtConfirmPswd').val() == "") {
                   $('#lblMsg').text('Enter the confirm password').css("color", "red");
                   $('#txtConfirmPswd').focus();
                   e.preventDefault();
                   return false;
               }
               else if ($('#txtNewPswd').val() != $('#txtConfirmPswd').val()) {
                   $('#lblMsg').text('New & confirm password must be same').css("color", "red");
                   $('#txtConfirmPswd').focus();
                   e.preventDefault();
                   return false;
               }
               else if ($('#txtOldPswd').val() == $('#txtNewPswd').val()) {
                   $('#lblMsg').text('Old & new password should not be same').css("color", "red");
                   e.preventDefault();
                   return false;
               }
               else
               {
                   $('#lblMsg').text('');
               }
               ChangePassword();
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
            <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <section class="flexbox-container">
                    <div class="col-12 d-flex align-items-center justify-content-center">
                        <div class="col-md-4 col-10 box-shadow-2 p-0">
                            <div class="card border-grey border-lighten-3 m-0">
                                <div class="card-header border-0">
                                    <div class="card-title text-center">
                                        <div class="p-1">
                                            <h1>Allianz</h1>
                                            <!-- <img src="images/logo/logo-dark.png" alt="branding logo"> -->
                                        </div>
                                    </div>
                                    <h6 class="card-subtitle line-on-side text-muted text-center font-small-3 pt-2">
                                        <span>Change Password</span>
                                    </h6>
                                </div>
                               
                                <div class="card-content">
                                    <div class="card-body" style="margin-top: -30px;">                                     
                                        <div style="height: 50px;"><asp:Label ID="lblMsg" runat="server"></asp:Label> </div>
                                        <%--<form class="form-horizontal form-simple" action="index.html" novalidate>--%>
                                        <fieldset class="form-group position-relative has-icon-left">
                                            <input type="password" class="form-control form-control-lg input-lg" id="txtOldPswd" runat="server" placeholder="Enter Password" maxlength="12">
                                            <div class="form-control-position">
                                                <i class="la la-key"></i>
                                            </div>
                                        </fieldset>
                                         
                                        <fieldset class="form-group position-relative has-icon-left">
                                            <input type="password" class="form-control form-control-lg input-lg" id="txtNewPswd" runat="server" placeholder="Enter New Password" maxlength="12">
                                            <div class="form-control-position">
                                                <i class="la la-key"></i>
                                            </div>
                                        </fieldset>

                                        <fieldset class="form-group position-relative has-icon-left">
                                            <input type="password" class="form-control form-control-lg input-lg" id="txtConfirmPswd" runat="server" placeholder="Enter Confirm Password" maxlength="12">
                                            <div class="form-control-position">
                                                <i class="la la-key"></i>
                                            </div>
                                        </fieldset>
                                      
                                        <button type="submit" class="btn btn-info btn-lg btn-block" id="btnSave" runat="server"><i class="ft-unlock"></i> Change Password</button>
                                        <%--  </form>--%>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <div class="">
                                          <p class="float-sm-left text-center m-0"><a href="/Home.aspx" class="card-link">Login</a></p>
                   <%-- <p class="float-sm-right text-center m-0">New to Moden Admin? <a href="register-simple.html" class="card-link">Sign Up</a></p>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
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
