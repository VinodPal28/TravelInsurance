<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="Home" ClientIDMode="Static" %>

<!DOCTYPE html>

<html class="loading" lang="en" data-textdirection="ltr">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Modern admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities with bitcoin dashboard.">
    <meta name="keywords" content="admin template, modern admin template, dashboard template, flat admin template, responsive admin template, web app, crypto dashboard, bitcoin dashboard">
    <meta name="author" content="PIXINVENT">
    <title>Allianz : Travel</title>
    <link rel="apple-touch-icon" href="../Assets/images/ico/fav-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="../Assets/images/ico/fav-icon.png">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Quicksand:300,400,500,700"
        rel="stylesheet">
    <link href="https://maxcdn.icons8.com/fonts/line-awesome/1.1/css/line-awesome.min.css"
        rel="stylesheet">
    <!-- BEGIN VENDOR CSS-->
    <link rel="stylesheet" type="text/css" href="assets/css/vendors.css">
    <link rel="stylesheet" type="text/css" href="assets/vendors/css/forms/icheck/icheck.css">
    <link rel="stylesheet" type="text/css" href="assets/vendors/css/forms/icheck/custom.css">
    <!-- END VENDOR CSS-->
    <!-- BEGIN MODERN CSS-->
    <link rel="stylesheet" type="text/css" href="assets/css/app.css">
    <!-- END MODERN CSS-->
    <!-- BEGIN Page Level CSS-->
    <link rel="stylesheet" type="text/css" href="assets/css/core/menu/menu-types/vertical-menu.css">
    <link rel="stylesheet" type="text/css" href="assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="assets/css/pages/login-register.css">
    <!-- END Page Level CSS-->
    <!-- BEGIN Custom CSS-->
    <link rel="stylesheet" type="text/css" href="../../../assets/css/style.css">
    <!-- END Custom CSS-->
    <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
    <script src="assets/js/jquery.min.js"></script>
    <script src="Assets/js/PreventRightClick.js"></script>
    <script type="text/javascript">
        function getData() {
            var EncodedPswd = window.btoa($("#txtPassword").val());
            var data = [];
            var UserName = $("#txtUserName").val();
            var Password = EncodedPswd;
            var alldata = {
                'User_Name': UserName,
                'Password': Password,
            }
            data.push(alldata);
            return data;
        }
        function GetLogin() {
            var data = JSON.stringify(getData());
            $.ajax({
                url: "Home.aspx?Action=SaveData&lb=" + data,
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ 'Login': data }),
                success: function (msg) {
                    if (msg != '') {
                        // alert(msg);
                        var data = msg.split('#');
                        if (msg == '2') {
                            window.location.replace("../Admin/Dashboard.aspx");
                        }
                        else if (msg == '3') {
                            window.location.replace("../changepswd.aspx");
                        }
                        else if (data[0] == 'Attempt') {
                            $('#emailStatus').text('Wrong Password, you have only ' + (3 - data[1]) + ' attempts left').css("color", "red");
                        }
                        else if (msg == 'Not found') {
                            $('#emailStatus').text('User id does not exists').css("color", "red");
                        }
                        else if (msg == 'ACCOUNT LOCKED') {
                            $('#emailStatus').text('Your account is temporarily locked for security reasons.').css("color", "red");
                        }
                        else if (msg == 'NA') {
                            $('#emailStatus').text('User is not activated').css("color", "red");
                        }
                        else if (msg == 'EmaiID LOCKED') {
                            $('#emailStatus').text('Your account has been locked,Please try after 15 mins.').css("color", "red");
                        }
                        else if (msg == 'Invalid') {
                            $('#emailStatus').text('User id or password is invalid.').css("color", "red");
                        }

                        else {
                            $('#emailStatus').text('');
                        }
                    }
                }
            });

        }
        function OnSuccess(response) {
            alert(response.d);
        }

        $(document).ready(function () {
            $('#btnLogin').click(function (e) {

                var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if ($('#txtUserName').val() == "") {
                    $('#emailStatus').text('Please enter the email address').css("color", "red");
                    $('#txtUserName').focus();
                    e.preventDefault();
                    return false;
                }
                else if (!re.test($('#txtUserName').val())) {
                    $('#emailStatus').text('Invalid Email').css("color", "red");
                    $('#txtUserName').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtPassword').val() == "") {
                    $('#emailStatus').text('Please enter the password').css("color", "red");
                    $('#txtPassword').focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#emailStatus').text('');

                }
                GetLogin();
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

            <form runat="server" id="form12">
                <asp:HiddenField ID="hdnPassword" runat="server" />
                <asp:Label ID="errorMsg" runat="server" ForeColor="red"></asp:Label>
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
                                            <span>Login with Allianz</span>
                                        </h6>
                                    </div>
                                    <div class="card-content">
                                        <div class="card-body">
                                            <div style="height: 26px;">
                                                <asp:Label ID="emailStatus" runat="server" ForeColor="Red"></asp:Label>
                                            </div>

                                            <fieldset class="form-group position-relative has-icon-left mb-0">
                                                <input type="text" id="txtUserName" runat="server" class="form-control form-control-lg input-lg" placeholder="Your Username" required />
                                                <div class="form-control-position">
                                                    <i class="ft-user"></i>
                                                </div>
                                            </fieldset>

                                            <fieldset class="form-group position-relative has-icon-left">
                                                <input type="password" id="txtPassword" runat="server" class="form-control form-control-lg input-lg" placeholder="Enter Password" maxlength="12" required>
                                                <div class="form-control-position">
                                                    <i class="la la-key"></i>
                                                </div>
                                            </fieldset>

                                            <button type="submit" id="btnLogin" runat="server" class="btn btn-info btn-lg btn-block"><i class="ft-unlock"></i> Login</button>
                                            <%--<asp:LinkButton ID="btnLogin" runat="server" class="btn btn-info btn-lg btn-block" OnClick="btnLogin_Click"><i class="ft-unlock"></i> Login</asp:LinkButton>--%>
                                        </div>
                                    </div>
                                    <div class="card-footer">
                                        <div class="">
                                            <p class="float-sm-left text-center m-0"><a href="ForgotPassword.aspx" class="card-link">Forgot Password</a></p>
                                             <p class="float-sm-right text-center m-0"> <a href="/PartnerRegistration.aspx" class="card-link" target="_blank">New Partner Registration</a></p>
                                        </div>
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
    <script src="assets/vendors/js/forms/icheck/icheck.min.js" type="text/javascript"></script>
    <script src="assets/vendors/js/forms/validation/jqBootstrapValidation.js"
        type="text/javascript"></script>
    <!-- END PAGE VENDOR JS-->
    <!-- BEGIN MODERN JS-->
    <script src="assets/js/core/app-menu.js" type="text/javascript"></script>
    <script src="assets/js/core/app.js" type="text/javascript"></script>
    <!-- END MODERN JS-->
    <!-- BEGIN PAGE LEVEL JS-->
    <script src="assets/js/scripts/forms/form-login-register.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL JS-->
</body>


</html>
