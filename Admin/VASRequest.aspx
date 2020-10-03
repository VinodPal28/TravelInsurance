<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="VASRequest.aspx.cs" Inherits="Admin_VASRequest" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                $("#Model_VASRequest").modal('show');
            }, 100);
        }
        function ShowMsg() {
            setTimeout(function () {
                $("#ModalMsg").modal('show');
            }, 100);
        }
        function DisApprove() {
            setTimeout(function () {
                $("#ModalDisapproveMsg").modal('show');
            }, 100);
        }
        function Approve() {
            setTimeout(function () {
                $("#ModalApproveMsg").modal('show');
            }, 100);
        }
        $(document).ready(function () {
            $(document).ready(function () {
                $('.custom-input').find('input[type="radio"]').click(function () {
                    if ($(this).is(':checked')) {
                        $('.radiopophide').addClass('hidden');
                        $(this).addClass('ashish');
                        $('.' + $(this).attr('data-attr')).removeClass('hidden')
                    }
                });
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnPolicyEnorseDisapprove').click(function (e) {
                var remarks = $("#<%=txtRemark.ClientID %>").val();
                if (remarks == "") {
                    $('#lblmsgName').text('Enter the remarks').css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#lblmsgName').text('');
                }

            });
        });
    </script>


    <script>
        $(document).ready(function () {
            if ($('#txt_TrackerNumberNew').val() != $('#txtTrackerNo1').val()) { $('#txtTrackerNo1').css("background", "yellow"); }
            if ($('#txt_MakeNew').val() != $('#txtMake1').val()) { $('#txtMake1').css("background", "yellow"); }
            if ($('#txt_ModelNew').val() != $('#txtModle1').val()) { $('#txtModle1').css("background", "yellow"); }
            if ($('#txt_RegistrationnoNew').val() != $('#txtRegistrationNumber1').val()) { $('#txtRegistrationNumber1').css("background", "yellow"); }
            if ($('#txt_RegistrationYearNew').val() != $('#txt_RegistrationYear1').val()) { $('#txt_RegistrationYear1').css("background", "yellow"); }
            if ($('#txt_BankNameNew').val() != $('#txtBankName').val()) { $('#txtBankName').css("background", "yellow"); }
            if ($('#txt_CardTypeNew').val() != $('#txt_CardType').val()) { $('#txt_CardType').css("background", "yellow"); }
            if ($('#txtNameofCardholderNew').val() != $('#txtNameOfCardHolder').val()) { $('#txtNameOfCardHolder').css("background", "yellow"); }
            if ($('#txtCardNumberNew').val() != $('#txtcardNo').val()) { $('#txtcardNo').css("background", "yellow"); }
            if ($('#txt_ExpiryMonthNew').val() != $('#txt_ExpMonth').val()) { $('#txt_ExpMonth').css("background", "yellow"); }
            if ($('#txt_ExpiryYearNew').val() != $('#txtExpYear').val()) { $('#txtExpYear').css("background", "yellow"); }
            if ($('#lblCountryNameNew').text() != $('#lblCountry').text()) { $('#lblCountry').css("background", "yellow"); }
            if ($('#lblCityNew').text() != $('#lblCity').text()) { $('#lblCity').css("background", "yellow"); }

            //$("#btnView").click(function (e) {
            //    var Remark = $("#txt_TrackerNumberNew").val();
            //    if (Remark == "") {
            //        $("#lblmsg3").text("*Enter the Remark").css("color", "red");
            //        e.preventDefault();
            //        return false;
            //    }
            //    else {
            //        $("#lblmsg3").text("").css("color", "red")
            //    }
            //});
        });
    </script>


    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">VAS Request</h1>
                <br />
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">

                            <div class="card-content">
                                <div class="table-responsive">
                                    <table class="table table-de mb-0">
                                        <asp:GridView ID="GV_VASRequest" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                            PagerStyle-CssClass="bs-pagination" Width="100%" OnPageIndexChanging="GV_VASRequest_PageIndexChanging" OnRowCommand="GV_VASRequest_RowCommand">

                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                        <asp:Label ID="lblVAS_Id" runat="server" Text='<%#Bind("VAS_Id") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Policy Number">
                                                    <ItemTemplate>
                                                        <%--<asp:LinkButton ID="LinkPolicyNo" runat="server" Text='<%#Bind("Policy_No") %>' ForeColor="Blue" CommandName="View" CommandArgument='<%# Container.DataItemIndex + 1 %>'></asp:LinkButton>--%>
                                                        <asp:Label ID="lblPolicy_No" runat="server" Text='<%#Bind("Policy_Number") %>'></asp:Label>
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

                                                <asp:TemplateField HeaderText="View">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnView" runat="server" Text="View" class="btn btn-sm round btn-outline-danger" CommandName="View"></asp:Button>
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

    <div class="modal dark_bg login-form-btn" id="Model_VASRequest" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div style="width: 60%; margin-left: 20%" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel3">VAS Details</h5>
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
                                                            <asp:HiddenField ID="PolicyID" runat="server" />
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
                                        <!--Start Changes 19-12-2018 J.A-->
                                        <h2 style="font-weight:bold">Existing  Customer Information</h2>
                                        <hr />
                                        <div class="card-body" runat="server" id="ExistingInfo">

                                            <h3>Luggage Tracker Information</h3>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Tracker Number</label>
                                                                <asp:TextBox ID="txt_TrackerNumberNew" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="card-body" runat="server" id="RoadsideNew">
                                            <h3>Roadside Assistance Information</h3>
                                            <div class="table-responsive" id="geodiv2New">
                                                <table class="table table-de mb-0" id="maintable2New">
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
                                                                <asp:TextBox ID="txt_MakeNew" runat="server" class="form-control" placeholder="Make" AutoCompleteType="Disabled" MaxLength="30" ReadOnly="true"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_ModelNew" runat="server" class="form-control" placeholder="Model" AutoCompleteType="Disabled" MaxLength="30" ReadOnly="true"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txt_RegistrationnoNew" runat="server" class="form-control" placeholder="Registration Number" AutoCompleteType="Disabled" MaxLength="30" ReadOnly="true"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <%-- <asp:DropDownList ID="ddl_RegistrationYearNew" runat="server" class="form-control" placeholder="Registration Year" AutoCompleteType="Disabled" disabled></asp:DropDownList>--%>

                                                                <asp:TextBox ID="txt_RegistrationYearNew" runat="server" class="form-control" placeholder="Registration Year" AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                            </td>
                                                        </tr>

                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="CardProtectionNews">
                                            <h3>Card Protection Information</h3>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Bank Name</label>
                                                                <asp:TextBox ID="txt_BankNameNew" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Card Type</label>
                                                                <%--<asp:DropDownList ID="ddl_CardTypeNew" runat="server" class="form-control" AutoCompleteType="Disabled" disabled>
                                                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                                                    <asp:ListItem Value="1">Debit</asp:ListItem>
                                                                    <asp:ListItem Value="2">Credit</asp:ListItem>
                                                                </asp:DropDownList>--%>
                                                                <asp:TextBox ID="txt_CardTypeNew" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Name of Cardholder</label>
                                                                <asp:TextBox ID="txtNameofCardholderNew" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Card Number</label>
                                                                <asp:TextBox ID="txtCardNumberNew" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="4" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Expiry Month</label>
                                                                <%--<asp:DropDownList ID="ddl_ExpiryMonthNew" runat="server" class="form-control" AutoCompleteType="Disabled" disabled></asp:DropDownList>--%>
                                                                <asp:TextBox ID="txt_ExpiryMonthNew" runat="server" class="form-control" AutoCompleteType="Disabled" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Expiry Year</label>
                                                                <%--<asp:DropDownList ID="ddl_ExpiryYearNew" runat="server" class="form-control" AutoCompleteType="Disabled" disabled></asp:DropDownList>--%>
                                                                <asp:TextBox ID="txt_ExpiryYearNew" runat="server" class="form-control" AutoCompleteType="Disabled" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="WeatherNewW">
                                            <h3>Weather Information</h3>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Country Name</label>
                                                                <asp:Label ID="lblCountryNameNew" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-6">
                                                            <div class="form-group">
                                                                <label for="projectinput2">City</label>
                                                                <asp:Label ID="lblCityNew" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!--End Changes 19-12-2018 J.A-->
                                        <h2 style="font-weight:bold">Endorse Information</h2>
                                        <hr /><br />
                                        <div class="card-body" runat="server" id="Div_TrackNo">

                                            <h3>Luggage Tracker Information</h3>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Tracker Number</label>
                                                                <asp:TextBox ID="txtTrackerNo1" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="Div_RSA">
                                            <h3>Roadside Assistance Information</h3>
                                            <div class="table-responsive" id="geodiv">
                                                <table class="table table-de mb-0" id="maintable">
                                                    <thead>
                                                    </thead>
                                                    <tbody id="maindiv" runat="server">
                                                        <tr>

                                                            <td><b>Vehicle Make</b></td>
                                                            <td><b>Vehicle Model</b></td>
                                                            <td><b>Registration No.</b></td>
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
                                                                <asp:TextBox ID="txtRegistrationNumber1" runat="server" class="form-control" placeholder="Registration Number" AutoCompleteType="Disabled" MaxLength="30" ReadOnly="true"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <%-- <asp:DropDownList ID="ddlRegistrationYear1" runat="server" class="form-control" placeholder="Registration Year" AutoCompleteType="Disabled" disabled></asp:DropDownList>--%>
                                                                <asp:TextBox ID="txt_RegistrationYear1" runat="server" class="form-control" placeholder="Registration Year" AutoCompleteType="Disabled" ReadOnly="true"></asp:TextBox>
                                                            </td>
                                                        </tr>

                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="Div_CardInfo">
                                            <h3>Card Protection Information</h3>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Bank Name</label>
                                                                <asp:TextBox ID="txtBankName" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Card Type</label>
                                                                <%--<asp:DropDownList ID="ddlCardType" runat="server" class="form-control" AutoCompleteType="Disabled" disabled>
                                                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                                                    <asp:ListItem Value="1">Debit</asp:ListItem>
                                                                    <asp:ListItem Value="2">Credit</asp:ListItem>
                                                                </asp:DropDownList>--%>
                                                                <asp:TextBox ID="txt_CardType" runat="server" class="form-control" AutoCompleteType="Disabled" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Name of Cardholder</label>
                                                                <asp:TextBox ID="txtNameOfCardHolder" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="30" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Card Number</label>
                                                                <asp:TextBox ID="txtcardNo" runat="server" class="form-control" AutoCompleteType="Disabled" MaxLength="4" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Expiry Month</label>
                                                                <%-- <asp:DropDownList ID="ddlExpMonth" runat="server" class="form-control" AutoCompleteType="Disabled" disabled></asp:DropDownList>--%>
                                                                <asp:TextBox ID="txt_ExpMonth" runat="server" class="form-control" AutoCompleteType="Disabled" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Expiry Year</label>
                                                                <%-- <asp:DropDownList ID="ddlExpYear" runat="server" class="form-control" AutoCompleteType="Disabled" disabled></asp:DropDownList>--%>
                                                                <asp:TextBox ID="txtExpYear" runat="server" class="form-control" AutoCompleteType="Disabled" disabled></asp:TextBox>
                                                            </div>
                                                        </div>


                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="Div_Weather">
                                            <h3>Weather Information</h3>
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

                <div class="card-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="controls">
                                <label class="custom-input">
                                    <input type="radio" name="radioPaymentOption" data-attr="Wallet" value="Wallet" />
                                    <span class="check-radio"></span>
                                    <span class="custom-input-label">Approve</span>
                                </label>
                                <label class="custom-input">
                                    <input type="radio" name="radioPaymentOption" data-attr="card" value="Card" />
                                    <span class="check-radio"></span>
                                    <span class="custom-input-label">Disapprove</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-8">
                            <div class="card-body">
                                <br />
                                <div class="row card radiopophide hidden">
                                    <asp:Label ID="lblmsg3" runat="server" ClientIDMode="Static"></asp:Label>
                                    <div class="form-group">
                                        <label for="projectinput2">Remark<span class="starRed">*</span></label>
                                        <div class="controls">
                                            <center>   <asp:TextBox ID="txtRemark" runat="server" class="form-control" placeholder="Remark" TextMode="MultiLine" Width="100%"></asp:TextBox>
                                                
                                            </center>
                                            <span id="lblmsgName"></span>
                                        </div>
                                    </div>
                                    <div class="text-left">
                                        <asp:LinkButton ID="btnPolicyEnorseDisapprove" runat="server" type="submit" CssClass="btn btn-success" OnClick="btnPolicyEnorseDisapprove_Click" CausesValidation="false" ClientIDMode="Static">Disapprove</asp:LinkButton>
                                        <button type="button" class=" btn btn-success" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">Close</span> </button>
                                    </div>
                                </div>

                                <div class="row Wallet radiopophide hidden">
                                    <div class="form-body">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="form-group">
                                                    <div class="controls">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="text-right">
                                            <asp:LinkButton ID="btnPolicyEnorseApprove" runat="server" type="submit" CssClass="btn btn-success" OnClick="btnPolicyEnorseApprove_Click" CausesValidation="false" ClientIDMode="Static">Approve </asp:LinkButton>
                                            <button type="button" class=" btn btn-success" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">Close</span> </button>
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

    <div id="ModalDisapproveMsg" class="modal fade show">
        <div class="modal-dialog modal-confirmClose">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-close"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>

                <div class="modal-body">
                    <p>
                        <h1 style="color: crimson;">Disapproved !</h1>
                    </p>
                </div>

            </div>
        </div>
    </div>

    <div id="ModalApproveMsg" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h4>Approve!</h4>
                    <p>vas request has been approved !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

