<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="PlanManagement.aspx.cs" Inherits="Admin_PlanManagement" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        function ShowDayAgeGeo() {
            setTimeout(function () {
                $("#MyModel_DayAgeGeo").modal('show');
            }, 100);
        }
        function ShowMICE() {
            setTimeout(function () {
                $("#MyModel_Mice").modal('show');
            }, 100);
        }
        function ShowPerday() {
            setTimeout(function () {
                $("#MyModel_Perday").modal('show');
            }, 100);
        }
        function Edit() {
            setTimeout(function () {
                $("#Model_EditPlan").modal('show');
            }, 100);
        }
        function UpdateMsg() {
            setTimeout(function () {
                $("#ModalUpdateMsg").modal('show');
            }, 100);
        }
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
            $('select[multiple].active.3col1').multiselect({
                columns: 1,
                placeholder: 'Select value added services',
                search: true,
                searchOptions: {
                    'default': 'Search value added services'
                },
                selectAll: true
            });
        });
    </script>

    <style>
        .radioButtonList input[type="radio"] {
            width: 20px;
            padding: 0;
            vertical-align: middle;
        }

        .radioButtonList label {
            margin-right: 20px;
            white-space: nowrap;
            font-size: 14px;
            margin-top: 7px;
        }
    </style>

    <script>
        $(document).ready(function () {
            $('.numeric').on('input', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });
            $('.NumericDot').on('input', function (e) {
                if (this.value.match(/[^0-9.]/g)) {
                    this.value = this.value.replace(/[^0-9.]/g, '');
                }
            });

            $('#txtPlanName').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9%()-.$#&!@ ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9%()-.$#&!@', ]/g, '');
                }
            });
            $("#btnSub").click(function (e) {
                //  alert($('#DurationBasis').val());
                var Benefitcount = 0, SumInsured = 0, Deductible = 0, Price = 0;
                $('.BenefitName').each(function (index, item) {
                    if ($(this).val() == "") {
                        Benefitcount = 1;
                    }
                }, 0);
                $('.SumInsured').each(function (index, item) {
                    if ($(this).val() == "") {
                        SumInsured = 1;
                    }
                }, 0);

                $('.Deductible').each(function (index, item) {
                    if ($(this).val() == "") {
                        Deductible = 1;
                    }
                }, 0);

                $('.ValidatePrice').each(function (index, item) {
                    if ($(this).val() == "") {
                        Price = 1;
                    }
                }, 0);

                if ($('#txtPlanName').val() == "") {
                    $("#lblmsg").text("*Enter the Plan Name").css("color", "red");
                    $("#txtPlanName").focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtMinAge').val() == "") {
                    $("#lblmsg").text("*Enter the Min Age").css("color", "red");
                    $("#txtMinAge").focus();
                    e.preventDefault();
                    return false;
                }
                //else if ($('#txtMinAge').val() <= 0) {
                //    $("#lblmsg").text("*Min age must be greater than zero.").css("color", "red");
                //    $("#txtMinAge").focus();
                //    e.preventDefault();
                //    return false;
                //}
                else if ($('#txtMinAge').val() > 150) {
                    $("#lblmsg").text("*Min age not more than 150 Yrs.").css("color", "red");
                    $("#txtMinAge").focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtMaxAge').val() == "") {
                    $("#lblmsg").text("*Enter the Max Age").css("color", "red");
                    $("#txtMaxAge").focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtMaxAge').val() <= 0) {
                    $("#lblmsg").text("*Max age must be greater than zero.").css("color", "red");
                    $("#txtMaxAge").focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtMaxAge').val() > 150) {
                    $("#lblmsg").text("*max age not more than 150 Yrs.").css("color", "red");
                    $("#txtMaxAge").focus();
                    e.preventDefault();
                    return false;
                }
                else if (parseInt($('#txtMaxAge').val()) < parseInt($('#txtMinAge').val())) {
                    $("#lblmsg").text("*Max age must be greater than min age.").css("color", "red");
                    $("#txtMaxAge").focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtmintripDuration').val() == "") {
                    $("#lblmsg").text("*Enter a min trip Duration").css("color", "red");
                    $("#txtmintripDuration").focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtmintripDuration').val() <= 0) {
                    $("#lblmsg").text("*Min trip Duration must be greater than zero.").css("color", "red");
                    $("#txtmintripDuration").focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtmaxDuration').val() == "") {
                    $("#lblmsg").text("*Enter a max trip Duration").css("color", "red");
                    $("#txtmaxDuration").focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtmaxDuration').val() <= 0) {
                    $("#lblmsg").text("*Max trip Duration must be greater than zero.").css("color", "red");
                    $("#txtmaxDuration").focus();
                    e.preventDefault();
                    return false;
                }
                else if (parseInt($('#txtmaxDuration').val()) < parseInt($('#txtmintripDuration').val())) {
                    $("#lblmsg").text("*Max trip duration must be greater than min trip duration.").css("color", "red");
                    $("#txtmaxDuration").focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#RdbValidFor').length <= 0) {
                    $("#lblmsg").text("*Select valid for").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if ($('#ddlTAndC').val() == "--Select--") {
                    $("#lblmsg").text("*Select Terms and Condition Document").css("color", "red");
                    $("#ddlTAndC").focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#DurationBasis').val() == "MICE" || $('#DurationBasis').val() == "PerDay") {
                    if ($('#txttraveller').val() == "") {
                        $("#lblmsg").text("*Enter No. of Traveller").css("color", "red");
                        $("#txttraveller").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txttraveller').val() != '' && parseInt($('#txttraveller').val(), 10) == 0) {
                        $("#lblmsg").text("*No. of Traveller cannot be 0").css("color", "red");
                        $('#txttraveller').focus();
                        valid = false;
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtMICEprice').val() == "") {
                        $("#lblmsg").text("*Enter the price").css("color", "red");
                        $("#txtMICEprice").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtMICEprice').val() != '' && parseInt($('#txtMICEprice').val(), 10) == 0) {
                        $("#lblmsg").text("*Price cannot be 0").css("color", "red");
                        $('#txtMICEprice').focus();
                        e.preventDefault();
                        return false;
                    }
                }
                else if (Benefitcount > 0) {
                    $("#lblmsg").text("*Please enter benefit name").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (SumInsured > 0) {
                    $("#lblmsg").text("*Please enter SumInsured").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (Deductible > 0) {
                    $("#lblmsg").text("*Please enter deductible").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if ($('#DurationBasis').val() == "DayAgeGeo") {
                    if (Price > 0) {
                        $("#lblmsg").text("*Please enter the Price").css("color", "red");

                        e.preventDefault();
                        return false;
                    }
                }
            });
        });

    </script>

    <style>
        .table-responsive {
            position: relative;
        }

            .table-responsive table {
                margin-top: 0px;
            }

            /*.table-responsive .bs-pagination {
                position: absolute;
                top: -24px;
            }*/

        .table.table-de th, .table.table-de td {
            padding: .75rem 1rem;
        }
    </style>


    <asp:ScriptManager ID="src" runat="server"></asp:ScriptManager>

    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">Plan Management</h1>
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
                                        <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" AutoCompleteType="Disabled" AutoPostBack="true" class="form-control" placeholder="Plan code / Plan name"></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                            <!-- end search -->
                            <div class="card-content">
                                <div class="table-responsive">
                                    <asp:GridView ID="GV_PlanManagement" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                        PagerStyle-CssClass="bs-pagination" Width="100%" OnRowCommand="GV_PlanManagement_RowCommand" OnRowDataBound="GV_PlanManagement_RowDataBound" OnPageIndexChanging="GV_PlanManagement_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDurationBasis" runat="server" Text='<%#Bind("Duration_Basis") %>' Visible="false"></asp:Label>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    <asp:Label ID="lblId" runat="server" Text='<%#Bind("Plan_Id")%>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Plan Code">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPlanCode1" runat="server" Text='<%#Bind("Plan_Code") %>' Visible="false"></asp:Label>
                                                    <asp:LinkButton ID="lblPlanCode" runat="server" Text='<%#Bind("Plan_Code") %>' ForeColor="Blue" Font-Underline="true" CommandName="ViewPrice" CommandArgument='<%# Container.DataItemIndex + 1 %>'></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Plan Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPlanName" runat="server" Text='<%#Bind("Plan_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                           <%-- <asp:TemplateField HeaderText="Duration Basis">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDurationBasis" runat="server" Text='<%#Bind("Duration_Basis") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                            <%--<asp:TemplateField HeaderText="Value Added Services">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVAS" runat="server" Text='<%#Bind("Value_Added_Services") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Min Age">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMinAgeTravel" runat="server" Text='<%#Bind("Min_Age_Travel") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Max Age">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMaxAgeTravel" runat="server" Text='<%#Bind("Max_Age_Travel") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Min Trip">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMintripDuration" runat="server" Text='<%#Bind("Min_trip_Duration") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Max Trip">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMaxTripDuration" runat="server" Text='<%#Bind("Max_Trip_Duration") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                           <%-- <asp:TemplateField HeaderText="Insurer Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblInsurerName" runat="server" Text='<%#Bind("Insurer_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Edit">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnEdit" runat="server" Text="Edit" class="btn btn-sm round btn-outline-danger" CommandName="EditCommand"></asp:Button>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Active">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnActive" runat="server" Text="Active" class="btn btn-sm round btn-outline-danger" CommandName="Active"></asp:Button>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Deactive">
                                                <ItemTemplate>
                                                    <asp:Button ID="btndeactive" runat="server" Text="Deactive" class="btn btn-sm round btn-outline-danger" CommandName="Deactive"></asp:Button>
                                                    <asp:HiddenField ID="HiddenIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
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
                <!-- Active Orders -->
            </div>
        </div>
    </div>

    <div class="modal dark_bg fade login-form-btn" id="MyModel_DayAgeGeo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="margin-left: -25%;">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 175%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Geography Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body" style="margin: 2%;">
                    <div class="row">
                        <div class="col-lg-16">
                            <b><label>Plan Name : <span runat="server" id="SpanPlanName"></span></label></b> 
                            <div class="table-responsive" id="Div1" runat="server">
                                <table class="table table-de mb-0" id="Viewtable">
                                    <tbody id="Tbody1" runat="server">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg fade login-form-btn" id="MyModel_Mice" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampl">MICE Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div class="card">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="projectinput2">Price</label>
                                    <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" Enabled="false" ClientIDMode="Static" ReadOnly="true" />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="projectinput1">No Of Traveller</label>
                                    <asp:TextBox ID="txtNoOftraveller" runat="server" CssClass="form-control" ClientIDMode="Static" Enabled="false" ReadOnly="true" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg fade login-form-btn" id="MyModel_Perday" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="example">Perday Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div class="card">


                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group ">
                                    <label>Price</label>
                                    <asp:TextBox ID="txtPricePerday" runat="server" CssClass="form-control" Enabled="false" ClientIDMode="Static" ReadOnly="true" />
                                </div>

                            </div>
                            <div class="col-md-6">
                                <div class="form-group ">
                                    <label>No Of Traveller</label>
                                    <asp:TextBox ID="txtNoOfTravellers" runat="server" CssClass="form-control" ClientIDMode="Static" Enabled="false" ReadOnly="true" />
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg login-form-btn" id="Model_EditPlan" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div style="width: 70%; margin-left: 15%" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel3">Edit Plan details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="window.location.href='PlanManagement.aspx'"><span aria-hidden="true">×</span> </button>
                </div>

                <asp:HiddenField ID="DurationBasis" runat="server" />
                <div style="height: 20px">
                    <center><asp:Label ID="lblmsg" runat="server"></asp:Label> </center>
                </div>
                <div class="modal-body">
                    <div class="card">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-content collapse show">
                                        <div class="card-body">
                                            <h1>Plan Details</h1>
                                            <hr />
                                            <div class="form-body">
                                                <div class="row">

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Plan Code </label>
                                                            <asp:Label ID="lblPlanCode" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Plan Name<span style="color: red">*</span></label>
                                                            <asp:TextBox ID="txtPlanName" runat="server" class="form-control" placeholder="Enter Plan Name" MaxLength="300"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Select Value added services</label>
                                                            <asp:ListBox ID="ddlValueaddedservices" runat="server" SelectionMode="Multiple" CssClass="3col1 active" ClientIDMode="Static" aria-invalid="false"></asp:ListBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Min. Age of Traveller (In Years)<span style="color: red">*</span></label>
                                                            <asp:TextBox ID="txtMinAge" runat="server" class="form-control NumericDot" placeholder="Minimum age of Traveller" MaxLength="5"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Max. Age of Traveller (In Years)<span style="color: red">*</span></label>
                                                            <asp:TextBox ID="txtMaxAge" runat="server" class="form-control NumericDot" placeholder="Maximum age of Traveller" MaxLength="5"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <h5>Min. Trip Duration<span style="color: red">*</span></h5>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtmintripDuration" runat="server" class="form-control numeric" placeholder="Days" MaxLength="5"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <h5>Max. Trip Duration<span style="color: red">*</span></h5>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtmaxDuration" runat="server" class="form-control numeric" placeholder="Days" MaxLength="5"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <h5>Valid for<span style="color: red">*</span></h5>
                                                            <asp:RadioButtonList ID="RdbValidFor" RepeatDirection="Horizontal" runat="server" CssClass="radioButtonList" RepeatColumns="6">
                                                                <asp:ListItem Value="OneWay">One way trip</asp:ListItem>
                                                                <asp:ListItem Value="Round">Round trip</asp:ListItem>
                                                            </asp:RadioButtonList>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <h5>Terms and Condition Document<span style="color: red">*</span></h5>
                                                            <asp:DropDownList ID="ddlTAndC" runat="server" class="form-control">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="PlanBenefit">
                                            <h1>Plan Benefits</h1>
                                            <hr />
                                            <div class="table-responsive">
                                                <table class="table table-de mb-0">
                                                    <asp:HiddenField runat="server" ID="hdnPriceRowCount" ClientIDMode="Static" />
                                                    <asp:HiddenField runat="server" ID="hdnGeoCount" ClientIDMode="Static" />
                                                    <asp:HiddenField runat="server" ID="hdnAgeCount" ClientIDMode="Static" />
                                                    <asp:HiddenField runat="server" ID="hdnRowCount" ClientIDMode="Static" />
                                                    <asp:GridView ID="GV_PlanBenefits" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" Width="100%">
                                                        <Columns>
                                                            <asp:TemplateField HeaderText="Benifit Name">
                                                                <ItemTemplate>
                                                                    <asp:HiddenField runat="server" ID="hdnBenefitType" Value='<%#Bind("Benifit_Type") %>' />
                                                                    <asp:HiddenField runat="server" ID="hdnCreatedBy" Value='<%#Bind("Created_By") %>' />
                                                                    <asp:HiddenField runat="server" ID="hdnCreatedDate" Value='<%#Bind("Created_date") %>' />
                                                                    <asp:HiddenField runat="server" ID="hdnPlanCode" Value='<%#Bind("Plan_Code") %>' />
                                                                    <asp:TextBox ID="txtBenifitName" runat="server" class="form-control BenefitName" Text='<%#Bind("Benifit_Name") %>' MaxLength="30"></asp:TextBox>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="SumInsured">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtSumInsured" runat="server" class="form-control SumInsured" Text='<%#Bind("SumInsured") %>' MaxLength="8"></asp:TextBox>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Deductible">
                                                                <ItemTemplate>
                                                                    <asp:TextBox ID="txtDeductible" runat="server" class="form-control Deductible" Text='<%#Bind("Deductible") %>' MaxLength="10"></asp:TextBox>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                        </Columns>
                                                        <EmptyDataTemplate><b style="color: red">No Record Available</b></EmptyDataTemplate>
                                                    </asp:GridView>
                                                </table>
                                            </div>

                                        </div>

                                        <div class="card-body">
                                            <h1>Plan Pricing</h1>
                                            <hr />
                                            <div class="form-body">
                                                <div class="row" runat="server" id="Mice">

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <h5>No. of Travelers Allowed<span style="color: red">*</span></h5>
                                                            <div class="controls">
                                                                <asp:TextBox runat="server" ID="txttraveller" MaxLength="2" class="form-control numeric" placeholder="No. of Travelers"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <h5>Plan Price<span style="color: red">*</span></h5>
                                                            <div class="controls">
                                                                <asp:TextBox runat="server" ID="txtMICEprice" class="form-control numeric" MaxLength="10" placeholder="Price"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>

                                                <div class="table-responsive" id="Div_Geo" runat="server">
                                                    <table class="table table-de mb-0" id="maintable">
                                                        <tbody id="maindiv" runat="server">
                                                            <asp:Panel ID="PnlTextBoxes" runat="server"></asp:Panel>
                                                        </tbody>
                                                    </table>
                                                </div>


                                            </div>
                                        </div>

                                        <div class="footer" align="right">
                                            <asp:Button ID="btnSub" runat="server" Text="Submit" CssClass="btn btn-primary edit-bg create-user" OnClick="btnSub_Click" />
                                            <button type="button" data-dismiss="modal" class="btn btn-primary edit-bg create-user" aria-label="Close" onclick="window.location.href='PlanManagement.aspx'"><span aria-hidden="true">Close</span> </button>
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
                    <h4>Updated!</h4>
                    <p>Plan details updated successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

