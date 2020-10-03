<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="VASDetails.aspx.cs" Inherits="Admin_VASDetails" ClientIDMode="Static" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/jquery-1.10.2.min.js"></script>

    <script type="text/javascript">
        $(function () {
            $('body').on('change', '#ddlCountry1', function () {
                var selected_CountryCode = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "VASDetails.aspx?Action=Country1&id=" + selected_CountryCode,
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
                    //$('#hdnCity1').val(this.text);
                    $('#hdnCity1').val($("#ddlCity1 option:selected").text());
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
                    url: "VASDetails.aspx?Action=Country2&id=" + selected_CountryCode,
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
                    //$('#hdnCity2').val(this.text);
                    $('#hdnCity2').val($("#ddlCity2 option:selected").text());
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
                    url: "VASDetails.aspx?Action=Country3&id=" + selected_CountryCode,
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
                    //$('#hdnCity3').val(this.text);
                    $('#hdnCity3').val($("#ddlCity3 option:selected").text());
                   

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

    <script>
        function ViewMsg() {
            setTimeout(function () {
                $("#Model_VASPolicies").modal('show');
            }, 100);
        }
        function ShowMsg() {
            setTimeout(function () {
                $("#ModalMsg").modal('show');
            }, 100);
        }
        function ViewData() {
            setTimeout(function () {
                $("#Model_ViewVASPolicies").modal('show');
            }, 100);
        }
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtTrackerNo1').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
                }
            });

          
            $('#txtMake1').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9 ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9 ]/g, '');
                }
            });
            $('#txtMake2').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9 ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9 ]/g, '');
                }
            });
            $('#txtMake3').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9 ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9 ]/g, '');
                }
            });
            $('#txtModle1').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-z0-9 ]/g)) {
                    this.value = this.value.replace(/[^a-zA-z0-9 ]/g, '');
                }
            });
            $('#txtModle2').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-z0-9 ]/g)) {
                    this.value = this.value.replace(/[^a-zA-z0-9 ]/g, '');
                }
            });
            $('#txtModle3').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-z0-9 ]/g)) {
                    this.value = this.value.replace(/[^a-zA-z0-9 ]/g, '');
                }
            });
            $('#txtRegistrationNumber1').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-z0-9]/g)) {
                    this.value = this.value.replace(/[^a-zA-z0-9]/g, '');
                }
            });
            $('#txtRegistrationNumber2').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-z0-9]/g)) {
                    this.value = this.value.replace(/[^a-zA-z0-9]/g, '');
                }
            });
            $('#txtRegistrationNumber3').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-z0-9]/g)) {
                    this.value = this.value.replace(/[^a-zA-z0-9]/g, '');
                }
            });
            $('#txtBankName').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-z. ]/g)) {
                    this.value = this.value.replace(/[^a-zA-z. ]/g, '');
                }
            });
            $('#txtNameOfCardHolder').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-z ]/g)) {
                    this.value = this.value.replace(/[^a-zA-z ]/g, '');
                }
            });
            $('#txtcardNo').bind('keyup', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });

        });
    </script>

    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">VAS Details</h1>
                <br />
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <!-- start search -->
                            <div class="pull-right">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="projectinput1">Search</label>
                                        <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" class="form-control" placeholder="Policy No / Customer Name / Date(dd/mm/yyyy)" AutoCompleteType="Disabled"></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                            <!-- end search -->
                            <asp:HiddenField ID="hdnpolicytype" runat="server" Value="" />
                            <asp:HiddenField ID="Hiddpolicy" runat="server" Value="" />

                            <div class="card-content">
                                <div class="table-responsive">
                                    <table class="table table-de mb-0">
                                        <asp:GridView ID="GV_VASPolicy" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                            PagerStyle-CssClass="bs-pagination" Width="100%" OnRowCommand="GV_VASPolicy_RowCommand" OnPageIndexChanging="GV_VASPolicy_PageIndexChanging">

                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                        <asp:Label ID="lblVAS_Id" runat="server" Text='<%#Bind("VAS_Id") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Policy Number">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="LinkPolicyNo" runat="server" Text='<%#Bind("Policy_Number") %>' ForeColor="Blue" CommandName="ViewPolicy" CommandArgument='<%# Container.DataItemIndex + 1 %>'></asp:LinkButton>
                                                        <asp:Label ID="lblPolicy_No" runat="server" Text='<%#Bind("Policy_Number") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Policy Start date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTravel_Start_Date" runat="server" Text='<%#Bind("travel_StartDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Policy End date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTravel_End_Date" runat="server" Text='<%#Bind("travel_Enddate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Customer Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCustomer_Name" runat="server" Text='<%#Bind("Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Endorse">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnEndorse" runat="server" Text="Endorse" class="btn btn-sm round btn-outline-danger" CommandName="View"></asp:Button>
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

    <div class="modal dark_bg login-form-btn" id="Model_VASPolicies" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div style="width: 60%; margin-left: 20%" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel3">View Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>

                </div>
                <div class="modal-body">
                    <div class="card">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-content collapse show">
                                        <div class="card-body">
                                            <h1>Customer Information</h1>
                                            <hr />
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Policy Number</label>
                                                            <asp:TextBox ID="txtPolicyNo" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Travel Start Date</label>
                                                            <asp:TextBox ID="txtstartdtt" runat="server" class="form-control" disabled></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Travel End Date</label>
                                                            <asp:TextBox ID="txtEnddtt" runat="server" class="form-control" disabled></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Customer Name</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtName" runat="server" class="form-control" placeholder="First Name" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Contact Number</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtNumber" runat="server" class="form-control" placeholder="Contact Number" MaxLength="10" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Email</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtEmailid" runat="server" class="form-control" placeholder="Email " disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="Div_TrackNo">
                                            <h1>Luggage Tracker Information</h1>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Tracker Number</label>
                                                                <asp:TextBox ID="txtTrackerNo1" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30"></asp:TextBox>
                                                            </div>
                                                        </div>                                                        
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="Div_RSA">
                                            <h1>Roadside Assistance Information</h1>
                                            <div class="table-responsive" id="geodiv">
                                                <table class="table table-de mb-0" id="maintable">
                                                    <thead>
                                                    </thead>
                                                    <tbody id="maindiv" runat="server">
                                                        <tr>

                                                            <td><b>Vehicle Make</b></td>
                                                            <td><b>Vehicle Model</b></td>
                                                            <td><b>Registration No</b></td>
                                                            <td><b>Registration Year</b></td>

                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtMake1" runat="server" class="form-control" placeholder="Make" AutoCompleteType="Disabled" MaxLength="30"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtModle1" runat="server" class="form-control" placeholder="Model" AutoCompleteType="Disabled" MaxLength="30"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtRegistrationNumber1" runat="server" class="form-control" placeholder="Registration Number" AutoCompleteType="Disabled" MaxLength="30"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlRegistrationYear1" runat="server" class="form-control" placeholder="Registration Year" AutoCompleteType="Disabled"></asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                       
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="Div_CardInfo">
                                            <h1>Card Protection Information</h1>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Bank Name</label>
                                                                <asp:TextBox ID="txtBankName" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Card Type</label>
                                                                <asp:DropDownList ID="ddlCardType" runat="server" class="form-control" AutoCompleteType="Disabled">
                                                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                                                    <asp:ListItem Value="1">Debit</asp:ListItem>
                                                                    <asp:ListItem Value="2">Credit</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Name of Cardholder</label>
                                                                <asp:TextBox ID="txtNameOfCardHolder" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Card Number</label>
                                                                <asp:TextBox ID="txtcardNo" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="4"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Expiry Month</label>
                                                                <asp:DropDownList ID="ddlExpMonth" runat="server" class="form-control" AutoCompleteType="Disabled"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Expiry Year</label>
                                                                <asp:DropDownList ID="ddlExpYear" runat="server" class="form-control" AutoCompleteType="Disabled"></asp:DropDownList>
                                                            </div>
                                                        </div>


                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="Div_Weather">
                                            <h1>Weather Information</h1>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Country Name</label>
                                                                <asp:DropDownList ID="ddlCountry1" runat="server" class="form-control" AutoCompleteType="Disabled"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="projectinput2">City</label>
                                                                <asp:DropDownList ID="ddlCity1" runat="server" class="form-control"></asp:DropDownList>
                                                                <asp:HiddenField ID="hdnCity1" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <%--  <label for="projectinput2">Country Name</label>--%>
                                                                <asp:DropDownList ID="ddlCountry2" runat="server" class="form-control" AutoCompleteType="Disabled"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <%-- <label for="projectinput2">City</label>--%>
                                                                <asp:DropDownList ID="ddlCity2" runat="server" class="form-control"></asp:DropDownList>
                                                                <asp:HiddenField ID="hdnCity2" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <%--   <label for="projectinput2">Country Name</label>--%>
                                                                <asp:DropDownList ID="ddlCountry3" runat="server" class="form-control" AutoCompleteType="Disabled"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <%-- <label for="projectinput2">City</label>--%>
                                                                <asp:DropDownList ID="ddlCity3" runat="server" class="form-control"></asp:DropDownList>
                                                                <asp:HiddenField ID="hdnCity3" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                            <div class="text-right" style="margin-left: 22px;">
                                <asp:LinkButton ID="btnVAS_Save" runat="server" type="submit" CssClass="btn btn-success" OnClick="btnVAS_Save_Click"><i class="la la-thumbs-o-up position-right"></i>Submit</asp:LinkButton>
                                <button type="button" class="btn btn-success" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">Close</span> </button>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div id="ModalMsg" class="modal fade" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
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
                    <p>Details submitted successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg login-form-btn" id="Model_ViewVASPolicies" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div style="width: 60%; margin-left: 20%" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleMod">View Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>

                </div>
                <div class="modal-body">
                    <div class="card">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-content collapse show">
                                        <div class="card-body">
                                            <h1>Customer Information</h1>
                                            <hr />
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Policy Number</label>
                                                            <asp:TextBox ID="txtViewPolicyNo" runat="server" class="form-control" disabled></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Travel Start Date</label>
                                                            <asp:TextBox ID="txtViewSDate" runat="server" class="form-control" disabled></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Travel End Date</label>
                                                            <asp:TextBox ID="txtViewEDate" runat="server" class="form-control" disabled></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Customer Name</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtViewName" runat="server" class="form-control" placeholder="First Name" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Contact Number</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtViewContactNo" runat="server" class="form-control" placeholder="Contact Number" MaxLength="10" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Email</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtViewEmail" runat="server" class="form-control" placeholder="Email " disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="row">
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="View_Luggage">
                                            <h1>Luggage Tracker Information</h1>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Tracker Number</label>
                                                                <asp:TextBox ID="txtViewTracker1" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </div>
                                                        </div>                                                       

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="View_RSA">
                                            <h1>Roadside Assistance Information</h1>
                                            <div class="table-responsive">
                                                <table class="table table-de mb-0">
                                                    <thead>
                                                    </thead>
                                                    <tbody id="Tbody1" runat="server">
                                                        <tr>

                                                            <td><b>Vehicle Make</b></td>
                                                            <td><b>Vehicle Model</b></td>
                                                            <td><b>Registration No.</b></td>
                                                            <td><b>Registration Year</b></td>

                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:TextBox ID="txtViewMake1" runat="server" class="form-control" placeholder="Make" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtViewModel1" runat="server" class="form-control" placeholder="Model" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtViewRegNo1" runat="server" class="form-control" placeholder="Registration Number" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddlViewRegYear1" runat="server" class="form-control" placeholder="Registration Year" AutoCompleteType="Disabled" disabled></asp:DropDownList>
                                                            </td>
                                                        </tr>
                                                      
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="View_Card">
                                            <h1>Card Protection Information</h1>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Bank Name</label>
                                                                <asp:TextBox ID="txtViewBankName" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Card Type</label>
                                                                <asp:DropDownList ID="ddlViewCardtype" runat="server" class="form-control" AutoCompleteType="Disabled" disabled>
                                                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                                                    <asp:ListItem Value="1">Debit</asp:ListItem>
                                                                    <asp:ListItem Value="2">Credit</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Name of Cardholder</label>
                                                                <asp:TextBox ID="txtViewCardName" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Card Number</label>
                                                                <asp:TextBox ID="txtViewCardNo" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="4" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Expiry Month</label>
                                                                <asp:DropDownList ID="ddlViewExpMonth" runat="server" class="form-control" AutoCompleteType="Disabled" disabled></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Expiry Year</label>
                                                                <asp:DropDownList ID="ddlViewExpYear" runat="server" class="form-control" AutoCompleteType="Disabled" disabled></asp:DropDownList>
                                                            </div>
                                                        </div>


                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="View_WeatherInfo">
                                            <h1>Weather Information</h1>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Country Name</label>
                                                                <asp:Label ID="lblCountry" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="projectinput2">City</label>
                                                                <asp:Label ID="lblCity" runat="server" class="form-control"></asp:Label>
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

                </div>
            </div>
        </div>
    </div>
</asp:Content>

