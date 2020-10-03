<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="UserManagement.aspx.cs" Inherits="Admin_UserManagement" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        function Edit() {
            setTimeout(function () {
                $("#Model_UserEdit").modal('show');
            }, 100);
        }
        function Updated() {
            setTimeout(function () {
                $("#Model_Updated").modal('show');
            }, 100);
        }
        function CheckEmailId() {
            $.ajax({
                url: "UserManagement.aspx/Page_Load",
                data: {
                    method: "CheckEMail",
                    Email: $("#txtEmailId").val()
                },
                success: function (msg) {
                    if (msg != '') {
                        if (msg.toString() == 'F') {
                            $('#lblmsg').text('Email Id ' + $("#txtEmailId").val() + ' already exist').css("color", "Red");
                            $('#txtEmailId').val("");
                        }
                        if (msg.toString() == 'NF') {
                            $('#lblmsg').text('');
                        }
                    }
                }
            });
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtFName').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z. ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z. ]/g, '');
                }
            });
            $('#txtLName').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z. ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z. ]/g, '');
                }
            });
            $('#txtMobNo').bind('keyup', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });
            $('#btnSub').click(function () {
                var Fname = $("#txtFName").val();
                var Lname = $("#txtLName").val();
                var EmailId = $("#txtEmailId").val();
                var ContactNo = $("#txtMobNo").val();

                var regEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                if (Fname == '') {
                    $("#lblmsg").text("Enter the first name").css("color", "Red");
                    return false;
                }
                else if (Lname == '') {
                    $("#lblmsg").text("Enter the last name").css("color", "Red");
                    return false;
                }
                else if (EmailId == '') {
                    $("#lblmsg").text("Enter the email id").css("color", "Red");
                    return false;
                }
                else if (!regEmail.test($('#txtEmailId').val())) {
                    $('#lblmsg').text('Invalid Email').css("color", "red");
                    return false;
                }
                else if (ContactNo == '') {
                    $("#lblmsg").text("Enter the Contact No").css("color", "Red");
                    return false;
                }
                else if (ContactNo.length < 10) {
                    $("#lblmsg").text("Contact No should not be less than 10 digit").css("color", "Red");
                    return false;
                }
                else {
                    $("#lblmsg").text("");
                }

            });
        });
    </script>


    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <div class="content-body">
                <%--<h1 class="h1Tag">Manage User</h1>--%>
                <br />

                <div class="col-6 col-sm-12 ">
                    <div class="btn-group option-select edit-btn">
                        <div class="form-group">
                            <label>Select User Type : </label>
                            <asp:DropDownList ID="ddlUserRole" runat="server" class="form-control" OnSelectedIndexChanged="ddlUserRole_SelectedIndexChanged" AutoPostBack="true">
                            </asp:DropDownList>

                        </div>
                    </div>
                </div>

                <!-- Active Orders -->
                <div class="row" runat="server" id="Div_UserRole">
                    <div class="col-12">
                        <div class="card">
                            <!-- start search -->
                            <div class="pull-right">
                                <div class="row">
                                    <div class="col-md-4">
                                        <div class="form-group">
                                            <label for="projectinput1">Search</label>
                                            <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" class="form-control" placeholder="Name / Email Id"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-md-8" style="text-align: right;margin-top:25px">
                                        <div class="form-group">
                                            <label for="projectinput1"></label>
                                            <asp:Button ID="btnExportToExcel" runat="server" CssClass="btn btn-primary" Text="Export To Excel" OnClick="btnExportToExcel_Click"/>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <!-- end search -->

                            <div class="card-content">
                                <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
                                <div class="table-responsive">
                                    <table class="table table-de mb-0">
                                        <asp:GridView ID="GV_ManageUser" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                            PagerStyle-CssClass="bs-pagination" Width="100%" OnPageIndexChanging="GV_ManageUser_PageIndexChanging" OnRowCommand="GV_ManageUser_RowCommand" OnRowDataBound="GV_ManageUser_RowDataBound">

                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                        <asp:Label ID="lblId" runat="server" Text='<%#Bind("UserId") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="First Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblFname" runat="server" Text='<%#Bind("First_Name") %>'></asp:Label>
                                                        <asp:Label ID="lblUserType" runat="server" Text='<%# Bind("UserType") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Last Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblLname" runat="server" Text='<%#Bind("Last_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Email Id">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEmailId" runat="server" Text='<%#Bind("EmailId") %>'></asp:Label>
                                                        <asp:HiddenField ID="HiddenIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Contact No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblContactNo" runat="server" Text='<%#Bind("Contact_Number") %>'></asp:Label>
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
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Edit" ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnEdit" runat="server" Text="Edit" class="btn btn-sm round btn-outline-danger" CommandName="EditDetails"></asp:Button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Delete" ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnDelete" runat="server" Text="Delete" class="btn btn-sm round btn-outline-danger" CommandName="DeleteDetails"></asp:Button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                            </Columns>
                                            <EmptyDataTemplate><b style="color: red">No Record Available</b></EmptyDataTemplate>
                                        </asp:GridView>
                                    </table>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <!-- Active Orders -->
            </div>
        </div>
    </div>


    <div class="modal dark_bg login-form-btn" id="Model_UserEdit" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel1">Edit</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div class="card">
                        <div class="card-body input-textbox">
                            <div class="row justify-content-center">
                                <center><asp:Label ID="lblmsg" runat="server" ></asp:Label> </center>
                                <div class="col-md-16">
                                    <asp:TextBox ID="txtId" runat="server" Visible="false" />

                                    <div class="form-group ">
                                        <label>First Name</label>
                                        <asp:TextBox ID="txtFName" runat="server" CssClass="form-control" ClientIDMode="Static" MaxLength="100" />
                                    </div>

                                    <div class="form-group" runat="server" id="Div_LName">
                                        <label>Last Name</label>
                                        <asp:TextBox ID="txtLName" runat="server" CssClass="form-control" ClientIDMode="Static" MaxLength="50" />
                                    </div>

                                    <div class="form-group ">
                                        <label>Email Id</label>
                                        <asp:TextBox ID="txtEmailId" runat="server" CssClass="form-control" ClientIDMode="Static" onchange="CheckEmailId();" />
                                    </div>

                                    <div class="form-group" runat="server">
                                        <label>Contact No.</label>
                                        <asp:TextBox ID="txtMobNo" runat="server" CssClass="form-control" ClientIDMode="Static" MaxLength="12" />
                                    </div>

                                    <div class="form-group" runat="server" id="Div_Role">
                                        <label>User Role</label>
                                        <asp:DropDownList ID="ddlUserType" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                                    </div>

                                    <div class="footer" align="right">
                                        <asp:Button ID="btnSub" runat="server" Text="Submit" CssClass="btn btn-primary edit-bg create-user" OnClick="btnSub_Click" />
                                        <asp:Button ID="Button1" runat="server" Text="Close" CssClass="btn btn-primary edit-bg create-user" OnClientClick="Refresh();" />
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="Model_Updated" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h4>Updated!</h4>
                    <p>User details updated successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

