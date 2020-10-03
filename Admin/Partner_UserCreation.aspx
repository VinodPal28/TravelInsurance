<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Partner_UserCreation.aspx.cs" Inherits="Admin_Partner_UserCreation" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../Assets/js/jquery.min.js"></script>
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.multiselect-ui').multiselect({
                includeSelectAllOption: true
            });
        });
        $(function () {
            $('select[multiple].active.3col').multiselect({
                columns: 1,
                placeholder: 'Select Wallet Permisssion',
                search: true,
                searchOptions: {
                    'default': 'Search Wallet Permisssion'
                },
                selectAll: true
            });
        });
        $(function () {
            $('select[multiple].active.3col1').multiselect({
                columns: 1,
                placeholder: 'Select Wallet Permisssion',
                search: true,
                searchOptions: {
                    'default': 'Search Wallet Permisssion'
                },
                selectAll: true
            });
        });
        function ShowMessage() {
            setTimeout(function () {
                $("#ModalMsg").modal('show');
            }, 100);

        } 
        function UserEdit() {
            setTimeout(function () {
                $("#Model_UserEdit").modal('show');
            }, 100);

        }
        function Update() {
            setTimeout(function () {
                $("#ModalUpdateMsg").modal('show');
            }, 100);

        }
    </script>

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
        $(document).ready(function () {

            $('.name').on('input', function (e) {
                if (this.value.match(/[^a-zA-Z. ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z. ]/g, '');
                }
            });
            $('.Numeric').on('input', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });
            $('#btnSubmit').click(function (e) {
                var RegexEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if ($('#txtFname').val() == '') {
                    $('#lblMsg').text('*Enter the first name').css("color", "red");
                    $('#txtFname').focus();
                    e.preventDefault();
                    return false;
                }

                else if ($('#txtLname').val() == '') {
                    $('#lblMsg').text('*Enter the last name').css("color", "red");
                    $('#txtLname').focus();
                    e.preventDefault();
                    return false;
                }

                else if ($('#txtEmailid').val() == '') {
                    $('#lblMsg').text('*Enter the email id').css("color", "red");
                    $('#txtEmailid').focus();
                    e.preventDefault();
                    return false;
                }
                else if (!RegexEmail.test($('#txtEmailid').val())) {
                    $('#lblMsg').text('Invalid Email').css("color", "red");
                    $('#txtEmailid').focus();
                    e.preventDefault();
                    return false;
                }

                else if ($('#txtPassword').val() == '') {
                    $('#lblMsg').text('*Enter the password').css("color", "red");
                    $('#txtPassword').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtPassword').val().length < 8) {
                    $('#lblMsg').text('Password Length must be between 8 and 12').css("color", "red");
                    $('#txtPassword').focus();
                    e.preventDefault();
                    return false;
                }
                else if (!ValidatePwd($('#txtPassword').val())) {
                    $('#lblMsg').text('Password Must Be Contain atleast One Capital,One Small Character,One Special and Two Numeric').css("color", "red");
                    $('#txtPassword').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtContactno').val() == '') {
                    $('#lblMsg').text('*Enter the contact no').css("color", "red");
                    $('#txtContactno').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtContactno').val().length != 10) {
                    $('#lblMsg').text('*Contact no  must be 10 digits').css("color", "red");
                    $('#txtContactno').focus();
                    e.preventDefault();
                    return false;
                }

                else if ($('#ddlWalletPermission').val() == '') {
                    $('#lblMsg').text('*Select the wallet permission').css("color", "red");
                    $('#ddlWalletPermission').focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#lblMsg').text('');
                }
            });

            $('#btnSub').click(function (e) {
                var RegexEmail1 = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if ($('#txt_FName').val() == '') {
                    $('#lblEditMsg').text('*Enter the first name').css("color", "red");
                    $('#txt_FName').focus();
                    e.preventDefault();
                    return false;
                }

                else if ($('#txt_LName').val() == '') {
                    $('#lblEditMsg').text('*Enter the last name').css("color", "red");
                    $('#txt_LName').focus();
                    e.preventDefault();
                    return false;
                }

                else if ($('#txt_EmailId').val() == '') {
                    $('#lblEditMsg').text('*Enter the email id').css("color", "red");
                    $('#txt_EmailId').focus();
                    e.preventDefault();
                    return false;
                }
                else if (!RegexEmail1.test($('#txt_EmailId').val())) {
                    $('#lblEditMsg').text('Invalid Email').css("color", "red");
                    $('#txt_EmailId').focus();
                    e.preventDefault();
                    return false;
                }                              
                else if ($('#txtMobNo').val() == '') {
                    $('#lblEditMsg').text('*Enter the contact no').css("color", "red");
                    $('#txtMobNo').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtMobNo').val().length != 10) {
                    $('#lblEditMsg').text('*Contact no  must be 10 digits').css("color", "red");
                    $('#txtMobNo').focus();
                    e.preventDefault();
                    return false;
                }

                else if ($('#ddl_WalletPermission').val() == '') {
                    $('#lblEditMsg').text('*Select the wallet permission').css("color", "red");
                    $('#ddl_WalletPermission').focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#lblEditMsg').text('');
                }
            });
        });
    </script>

    <script type="text/javascript">
        function CheckEmail() {
            $.ajax({
                url: "Partner_UserCreation.aspx/Page_Load",
                data: {
                    method: "CheckEMail",
                    Email: $("#txtEmailid").val()
                },
                success: function (msg) {
                    if (msg != '') {
                        if (msg.toString() == 'F') {
                            $('#lblMsg').text('Email Id ' + $("#txtEmailid").val() + ' already exist').css("color", "Red");
                            $('#txtEmailid').val("");
                            $('#txtEmailid').focus();
                        }
                        if (msg.toString() == 'NF') {
                            $('#lblMsg').text('');
                        }
                    }
                }
            });
        }

        function CheckEditEmail() {
            $.ajax({
                url: "Partner_UserCreation.aspx/Page_Load",
                data: {
                    method: "CheckEMail",
                    Email: $("#txt_EmailId").val()
                },
                success: function (msg) {
                    if (msg != '') {
                        if (msg.toString() == 'F') {
                            $('#lblEditMsg').text('Email Id ' + $("#txt_EmailId").val() + ' already exist').css("color", "Red");
                            $('#txt_EmailId').val("");
                            $('#txt_EmailId').focus();
                        }
                        if (msg.toString() == 'NF') {
                            $('#lblEditMsg').text('');
                        }
                    }
                }
            });
        }
    </script>

    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <div style="height: 20px">
                <center><asp:Label ID="lblMsg" runat="server"></asp:Label></center>
            </div>
            <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>

            <div class="content-body">
                <h1 class="h1Tag">Add New Employee</h1>
                <div class="form-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="projectinput1">First Name<span style="color: red" class="starRed">*</span></label>
                                <asp:TextBox ID="txtFname" runat="server" class="form-control name" placeholder="First Name" AutoCompleteType="Disabled" MaxLength="20"></asp:TextBox>
                                <asp:HiddenField ID="HdnId" runat="server" />
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="projectinput2">Last Name<span style="color: red" class="starRed">*</span></label>
                                <asp:TextBox ID="txtLname" runat="server" class="form-control name" placeholder="Last Name" AutoCompleteType="Disabled" MaxLength="20"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="projectinput3">E-mail<span style="color: red" class="starRed">*</span></label>
                                <asp:TextBox ID="txtEmailid" runat="server" class="form-control" placeholder="E-mail" name="email" TextMode="Email" ClientIDMode="Static" onchange="CheckEmail()" AutoCompleteType="Disabled"></asp:TextBox>

                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="projectinput3">Password<span style="color: red" class="starRed">*</span></label>
                                <asp:TextBox ID="txtPassword" runat="server" class="form-control" placeholder="Password" name="password" TextMode="Password" AutoCompleteType="Disabled" MaxLength="12"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="projectinput4">Contact Number<span style="color: red" class="starRed">*</span></label>
                                <asp:TextBox ID="txtContactno" runat="server" class="form-control Numeric" placeholder="Phone" MaxLength="10" AutoCompleteType="Disabled"></asp:TextBox>
                            </div>
                        </div>

                        <div class="col-md-4">
                            <div class="form-group">
                                <label for="projectinput4">Wallet Permisssion<span style="color: red" class="starRed">*</span></label>
                                <asp:ListBox ID="ddlWalletPermission" runat="server" SelectionMode="Multiple" CssClass="3col active" ClientIDMode="Static">
                                    <asp:ListItem Value="WalletRequest">Wallet Request</asp:ListItem>
                                    <asp:ListItem Value="WalletStatement">Wallet Statement</asp:ListItem>
                                </asp:ListBox>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="text-left">
                    <asp:LinkButton ID="btnSubmit" runat="server" Text="Submit" class="btn btn-success" OnClick="btnSubmit_Click"><i class="la la-thumbs-o-up position-right"></i> Add User</asp:LinkButton>
                    <asp:LinkButton ID="btnReset" runat="server" Text="Reset" class="btn btn-danger reset-btn" OnClick="btnReset_Click"><i class="la la-refresh position-right"></i> Reset</asp:LinkButton>
                </div>
            </div>
            <br />
            <br />
            <br />
            <div class="content-body">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Employee Details</h4>
                            </div>
                            <div class="card-content">
                                <div class="table-responsive" id="Gridview-container">

                                    <asp:GridView ID="GV_Employee" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                        PagerStyle-CssClass="bs-pagination" Width="100%" OnPageIndexChanging="GV_Employee_PageIndexChanging" OnRowCommand="GV_Employee_RowCommand" OnRowDataBound="GV_Employee_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No." ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    <asp:Label ID="lblId" runat="server" Text='<%#Bind("Id")%>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="First Name" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFName" runat="server" Text='<%#Bind("FirstName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Last Name" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblLName" runat="server" Text='<%#Bind("LastName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Email Id" ItemStyle-Width="30%" HeaderStyle-Width="30%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblEmailid" runat="server" Text='<%#Bind("EmailId") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Contact No" ItemStyle-Width="30%" HeaderStyle-Width="30%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblContactNo" runat="server" Text='<%#Bind("ContactNo") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Wallet Permission" ItemStyle-Width="30%" HeaderStyle-Width="30%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblWalletPer" runat="server" Text='<%#Bind("WalletType") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Active" ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnActive" runat="server" Text="Active" class="btn btn-sm round btn-outline-danger" CommandName="Active"></asp:Button>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Deactive" ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Button ID="btndeactive" runat="server" Text="Deactive" class="btn btn-sm round btn-outline-danger" CommandName="Deactive"></asp:Button>
                                                    <asp:HiddenField ID="HiddenIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit" ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnEdit" runat="server" Text="Edit" class="btn btn-sm round btn-outline-danger" CommandName="EditDetails"></asp:LinkButton>

                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                        <EmptyDataTemplate><b style="color: red">No Record Available</b></EmptyDataTemplate>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
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
                    <p>Employee details submitted successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg login-form-btn" id="Model_UserEdit" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div style="width: 60%; margin-left: 20%" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel3">Edit</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>
                </div>
                <div style="height:20px"><center><asp:Label ID="lblEditMsg" runat="server"></asp:Label> </center> </div>
                <div class="modal-body">
                    <div class="card">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-content collapse show">
                                        <div class="card-body">
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">First Name<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox ID="txt_FName" runat="server" CssClass="form-control name" ClientIDMode="Static" MaxLength="50" AutoCompleteType="Disabled" />
                                                            <asp:HiddenField ID="HdnEmpId" runat="server" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Last Name<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox ID="txt_LName" runat="server" CssClass="form-control name" ClientIDMode="Static" MaxLength="50" AutoCompleteType="Disabled" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Email Id<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox ID="txt_EmailId" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="CheckEditEmail();" AutoCompleteType="Disabled" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Contact No<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtMobNo" runat="server" CssClass="form-control Numeric" ClientIDMode="Static" MaxLength="10" AutoCompleteType="Disabled" />
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label>Wallet Permission<span style="color: red" class="starRed">*</span></label>
                                                            <asp:ListBox ID="ddl_WalletPermission" runat="server" SelectionMode="Multiple" CssClass="3col1 active" ClientIDMode="Static">
                                                                <asp:ListItem Value="WalletRequest">Wallet Request</asp:ListItem>
                                                                <asp:ListItem Value="WalletStatement">Wallet Statement</asp:ListItem>
                                                            </asp:ListBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="footer" align="right">
                                                <asp:Button ID="btnSub" runat="server" Text="Submit" CssClass="btn btn-primary edit-bg create-user" OnClick="btnSub_Click"/>
                                                <asp:Button ID="btnClear" runat="server" Text="Close" CssClass="btn btn-primary edit-bg create-user" />
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
    </div>

    <div id="ModalUpdateMsg" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h4>Updated</h4>
                 <%--   <p>Employee details submitted successfully !</p>--%>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

