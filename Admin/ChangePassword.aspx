<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="Admin_ChangePassword" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>     

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
               url: "ChangePassword.aspx/Page_Load",
               data: {
                   method: "ChangePswd",
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

    

    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblerrorMsg" runat="server" ></asp:Label>
            <div class="content-body">
                <section class="flexbox-container">
                    <div class="col-12 d-flex align-items-center justify-content-center">
                        <div class="col-md-6 col-10 box-shadow-2 p-0">
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
                                        <%-- <div class="form-group row">
                        <div class="col-md-6 col-12 text-center text-md-left">
                          <fieldset>
                            <input type="checkbox" id="remember-me" class="chk-remember">
                            <label for="remember-me"> Remember Me</label>
                          </fieldset>
                        </div>
                        <div class="col-md-6 col-12 text-center text-md-right"><a href="recover-password.html" class="card-link">Forgot Password?</a></div>
                      </div>--%>
                                        <button type="submit" class="btn btn-info btn-lg btn-block" id="btnSave" runat="server"><i class="ft-unlock"></i>Update</button>
                                        <%--  </form>--%>
                                    </div>
                                </div>
                                <div class="card-footer">
                                    <div class="">
                                        <%--  <p class="float-sm-left text-center m-0"><a href="recover-password.html" class="card-link">Recover password</a></p>
                    <p class="float-sm-right text-center m-0">New to Moden Admin? <a href="register-simple.html" class="card-link">Sign Up</a></p>--%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>
    </div>
</asp:Content>

