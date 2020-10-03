<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="UserCreation.aspx.cs" Inherits="Admin_UserCreation" EnableEventValidation="false" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../Assets/js/Valid.js"></script>
    <script src="../Assets/js/jquery.min.js"></script>
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.multiselect-ui').multiselect({
                includeSelectAllOption: true
            });
        });
    </script>

    <script>
        $(document).ready(function () {
            $("select.select-user-drop-down").change(function () {
                var Val = $(this).val();
                //alert(Val);
                if (Val == '5') {
                    $(".add-user-Workshop").css("display", "block");
                }
                else {
                    $(".add-user-Workshop").css("display", "none");
                }
            });
        });

    </script>

    <script>
        $(function () {
            $('select[multiple].active.3col').multiselect({
                columns: 1,
                placeholder: 'Select Partner',
                search: true,
                searchOptions: {
                    'default': 'Search Partner'
                },
                selectAll: true
            });
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtContactno').bind('keyup', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });
            //$('#txtContactno').mobile();
        });
    </script>

    <script type="text/javascript">
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=SpnMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <script type="text/javascript">
        function ShowWallet() {
            setTimeout(function () {
                $("#lblSuccessmsg").modal('show');
            }, 100);

        }
        function ShowMessage() {
            setTimeout(function () {
                $("#ModalMsg").modal('show');
            }, 100);

        }
    </script>


    <script>
        function ShowMsg() {
            SpnMsg.style.color = "Green";
            SpnMsg.innerHTML = "User Created Successfully !";
        };
    </script>

    <script type="text/javascript">
        function CheckEmail() {
            $.ajax({
                url: "UserCreation.aspx/Page_Load",
                data: {
                    method: "CheckEMail",
                    Email: $("#txtEmailid").val()
                },
                success: function (msg) {
                    if (msg != '') {
                        if (msg.toString() == 'F') {
                            $('#lblStatus').text('Email Id ' + $("#txtEmailid").val() + ' already exist').css("color", "Red");
                            $('#txtEmailid').val("");
                        }
                        if (msg.toString() == 'NF') {
                            $('#lblStatus').text('');
                        }
                    }
                }
            });
        }
        function OnSuccess(response) {
            alert(response.d);
        }

        function EmailAvailability() {
            CheckEmail();
        }

    </script>

    <script type="text/javascript">
        function CheckValidMobileNo() {
            var MobNo = document.getElementById('txtContactno').value;
            if (!(MobNo.charAt(0) == "9" || MobNo.charAt(0) == "8" || MobNo.charAt(0) == "7" || MobNo.charAt(0) == "6")) {
                $('#lblCheckMobno').text('Mobile No. should start with 6,7,8 or 9 ').css("color", "Red");
                //document.getElementById('txtContactno').focus();
                $('#txtContactno').val('');
                return false
            }
            else {
                $('#lblCheckMobno').text(' ');
            }
        }
    </script>
   

    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="SpnMsg" runat="server" ClientIDMode="Static"></asp:Label>
            <asp:Label ID="lblError" runat="server" ClientIDMode="Static"></asp:Label>
            <asp:Label ID="lblSuccessmsg" runat="server" ForeColor="Green" Text="Submit User Cereation Succesfully !" Visible="false"></asp:Label>
            <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>

            <div class="content-body">
                <h1 class="h1Tag">User Creation</h1>

                <div class="form-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="projectinput1">First Name</label>
                                <asp:TextBox ID="txtFname" runat="server" class="form-control" placeholder="First Name" name="fname" AutoCompleteType="Disabled"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="reqName" ControlToValidate="txtFname" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter your first name!" />
                            </div>
                        </div>


                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="projectinput2">Last Name</label>
                                <asp:TextBox ID="txtLname" runat="server" class="form-control" placeholder="Last Name" name="lname" AutoCompleteType="Disabled"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ValidationGroup="gb1" ControlToValidate="txtLname" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter your last name!" />
                            </div>
                        </div>


                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="projectinput2">Select Role</label>
                                <div class="controls">
                                    <asp:DropDownList ID="ddlRole" runat="server" class="form-control select-user-drop-down" aria-invalid="false"></asp:DropDownList>
                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ValidationGroup="gb1" InitialValue="0" ControlToValidate="ddlRole" Display="Dynamic" ForeColor="Red" ErrorMessage="Please select role!" />
                                    <div class="help-block"></div>
                                </div>
                            </div>
                        </div>


                        <div class="col-lg-4 col-md-4 add-user-Workshop">
                            <div class="form-group">
                                <label>Select Partner</label>
                                <asp:ListBox ID="listPartner" runat="server" SelectionMode="Multiple" CssClass="3col active" ClientIDMode="Static"></asp:ListBox>

                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="projectinput3">E-mail</label>
                                <asp:TextBox ID="txtEmailid" runat="server" class="form-control" placeholder="E-mail" name="email" TextMode="Email" ClientIDMode="Static" onchange="EmailAvailability()" AutoCompleteType="Disabled"></asp:TextBox>
                                <asp:Label ID="lblStatus" runat="server" ClientIDMode="Static"></asp:Label>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator5" ValidationGroup="gb1" ControlToValidate="txtEmailid" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter your Email Id!" />
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Please Enter Valid Email ID" ValidationGroup="gb1" ControlToValidate="txtEmailid"
                                    CssClass="requiredFieldValidateStyle" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                <asp:Label ID="emailCheck" runat="server"></asp:Label>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="projectinput3">Password</label>
                                <asp:TextBox ID="txtPassword" runat="server" class="form-control" placeholder="Password" name="password" TextMode="Password" AutoCompleteType="Disabled" MaxLength="12"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ValidationGroup="gb1" ControlToValidate="txtPassword" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter your Password!" />
                                <asp:RegularExpressionValidator ID="valPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Password Length must be between 8 and 12 and Must Contain atleast One Capital,One Small Character,One Special and Two Numeric" ValidationExpression="^(?=^.{8,12}$)(?=(?:.*?\d){2})(?=.*[a-z])(?=(?:.*?[A-Z]){1})(?=(?:.*?[!@#$%*()_+^&}{:;?.]){1})(?!.*\s)[0-9a-zA-Z!@#$%*()_+^&]*$" ValidationGroup="gb1" ForeColor="Red"/>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="projectinput4">Contact Number</label>
                                <asp:TextBox ID="txtContactno" runat="server" class="form-control" placeholder="Phone" MaxLength="10" AutoCompleteType="Disabled"></asp:TextBox>
                                <asp:Label ID="lblCheckMobno" runat="server"></asp:Label>
                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator4" ValidationGroup="gb1" ControlToValidate="txtContactno" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter your Contact Number!" />

                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-left">
                    <asp:LinkButton ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" ValidationGroup="gb1" class="btn btn-success"><i class="la la-thumbs-o-up position-right"></i> Add User</asp:LinkButton>
                    <asp:LinkButton ID="btnReset" runat="server" Text="Reset" class="btn btn-danger reset-btn" OnClick="btnReset_Click"><i class="la la-refresh position-right"></i> Reset</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <div id="ModalMsg" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h4>Success!</h4>
                    <p>User details submitted successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

