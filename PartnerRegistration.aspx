<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PartnerRegistration.aspx.cs" Inherits="PartnerRegistration" EnableEventValidation="false" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui" />
    <meta name="description" content="Modern admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities with bitcoin dashboard." />
    <meta name="keywords" content="admin template, modern admin template, dashboard template, flat admin template, responsive admin template, web app, crypto dashboard, bitcoin dashboard" />
    <meta name="author" content="PIXINVENT" />
    <title>Partner Registration</title>
    <link rel="apple-touch-icon" href="../Assets/images/ico/fav-icon.png" />
    <link rel="shortcut icon" type="image/x-icon" href="../Assets/images/ico/fav-icon.png" />
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Quicksand:300,400,500,700" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link href="https://maxcdn.icons8.com/fonts/line-awesome/1.1/css/line-awesome.min.css" rel="stylesheet" />
    <!-- BEGIN VENDOR CSS-->
    <link rel="stylesheet" type="text/css" href="../Assets/css/vendors.css" />
    <!-- END VENDOR CSS-->
    <!-- BEGIN MODERN CSS-->
    <link rel="stylesheet" type="text/css" href="../Assets/css/app.css" />
    <!-- END MODERN CSS-->
    <!-- BEGIN Page Level CSS-->
    <link rel="stylesheet" type="text/css" href="../Assets/css/core/menu/menu-types/vertical-menu.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/css/core/colors/palette-gradient.css" />
    <link rel="stylesheet" type="text/css" href="../Assets/vendors/css/cryptocoins/cryptocoins.css" />
    <!-- END Page Level CSS-->
    <!-- BEGIN Custom CSS-->
    <link rel="stylesheet" type="text/css" href="../Assets/css/style.css" />
    <link href="../Assets/css/Grid_Pagination.css" rel="stylesheet" />
    <script src="../Assets/js/jquery.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.name').on('input', function (e) {
                if (this.value.match(/[^a-zA-Z./ ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z./ ]/g, '');
                }
            });
            $('.GST').on('input', function (e) {
                if (this.value.match(/[^a-zA-Z0-9]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
                }
            });
            $('.Numeric').on('input', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });


            $('#btnSave').click(function (e) {

                var regIFSC = /^[A-Za-z]{4}0[a-zA-Z0-9]{6}$/;
                var regPan = /[a-zA-z]{5}\d{4}[a-zA-Z]{1}/;
                var reggst = /^([0-9]){2}([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}([0-9]){1}([zZ]){1}([0-9]){1}?$/;
                var RegexEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                var allowedFiles = [".png", ".jpeg", ".pdf", ".jpg"];
                var regexFileUpload = new RegExp("([a-zA-Z0-9\s_\\.\-:])+(" + allowedFiles.join('|') + ")$");

                if ($('#txtPartnerName').val() == "") {
                    $('#ValidationMsg').text('Enter partner name').css("color", "red");
                    $('#txtPartnerName').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtPartnerEmail').val() == "") {
                    $('#ValidationMsg').text('Enter partner email id').css("color", "red");
                    $('#txtPartnerEmail').focus();
                    e.preventDefault();
                    return false;
                }
                else if (!RegexEmail.test($('#txtPartnerEmail').val())) {
                    $('#ValidationMsg').text('Invalid Email').css("color", "red");
                    $('#txtPartnerEmail').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtPartnerMobNo').val() == "") {
                    $('#ValidationMsg').text('Enter Contact no').css("color", "red");
                    $('#txtPartnerMobNo').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtPartnerMobNo').val().length != 10) {
                    $('#ValidationMsg').text('Contact no must be 10 digit').css("color", "red");
                    $('#txtPartnerMobNo').focus();
                    e.preventDefault();
                    return false;
                }
                //else if ($('#txtGstNo').val() == "") {
                //    $('#ValidationMsg').text('Enter GST number').css("color", "red");
                //    $('#txtGstNo').focus();
                //    e.preventDefault();
                //    return false;
                //}
                else if (!reggst.test($('#txtGstNo').val()) && $('#txtGstNo').val() != "") {
                    $('#ValidationMsg').text('GST Identification Number is not valid. It should be in this "11AAAAA1111A1Z1" format').css("color", "red");
                    $('#txtGstNo').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtPanCard').val() == "") {
                    $('#ValidationMsg').text('Enter Pan number').css("color", "red");
                    $('#txtPanCard').focus();
                    e.preventDefault();
                    return false;
                }
                else if (!($('#txtPanCard').val()).match(regPan)) {
                    $("#ValidationMsg").text("*Enter valid Pan No (ex - aaaaa9999a)").css("color", "red");
                    $('#txtPanCard').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#ddlPartnerState').val() == "0") {
                    $('#ValidationMsg').text('Select the state').css("color", "red");
                    $('#ddlPartnerState').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#ddlPartnerCity').val() == "0") {
                    $('#ValidationMsg').text('Select the city').css("color", "red");
                    $('#ddlPartnerCity').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtPinCode').val() == "") {
                    $('#ValidationMsg').text('Enter Pin Code').css("color", "red");
                    $('#txtPinCode').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtPinCode').val().length != 6) {
                    $('#ValidationMsg').text('Pin Code must be 6 digit').css("color", "red");
                    $('#txtPinCode').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtPartnerAddr').val() == "") {
                    $('#ValidationMsg').text('Enter Partner address').css("color", "red");
                    $('#txtPartnerAddr').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtContactPerson').val() == "") {
                    $('#ValidationMsg').text('Enter contact person name').css("color", "red");
                    $('#txtContactPerson').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtContactNoOfContPerson').val() == "") {
                    $('#ValidationMsg').text('Enter contact number of contact person').css("color", "red");
                    $('#txtContactNoOfContPerson').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtContactNoOfContPerson').val().length != 10) {
                    $('#ValidationMsg').text('contact number must be 10 digit').css("color", "red");
                    $('#txtContactNoOfContPerson').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtEmailIdOfContperson').val() == "") {
                    $('#ValidationMsg').text('Enter contact person email id').css("color", "red");
                    $('#txtEmailIdOfContperson').focus();
                    e.preventDefault();
                    return false;
                }
                else if (!RegexEmail.test($('#txtEmailIdOfContperson').val())) {
                    $('#ValidationMsg').text('Enter valid email id').css("color", "red");
                    $('#txtEmailIdOfContperson').focus();
                    e.preventDefault();
                    return false;
                }
                //else if ($('#ddlRegion').val() == "0") {
                //    $('#ValidationMsg').text('Select region').css("color", "red");
                //    $('#ddlRegion').focus();
                //    e.preventDefault();
                //    return false;
                //}
                //else if ($('#txtAccountNo').val() == "") {
                //    $('#ValidationMsg').text('Enter account number').css("color", "red");
                //    $('#txtAccountNo').focus();
                //    e.preventDefault();
                //    return false;
                //}
                //else if ($('#txtBankName').val() == "") {
                //    $('#ValidationMsg').text('Enter bank name').css("color", "red");
                //    $('#txtBankName').focus();
                //    e.preventDefault();
                //    return false;
                //}
                //else if ($('#txtIfscCode').val() == "") {
                //    $('#ValidationMsg').text('Enter IFSC code').css("color", "red");
                //    $('#txtIfscCode').focus();
                //    e.preventDefault();
                //    return false;
                //}
                //else if (!regIFSC.test($('#txtIfscCode').val())) {
                //    $('#ValidationMsg').text('Invalid IFSC code').css("color", "red");
                //    $('#txtIfscCode').focus();
                //    e.preventDefault();
                //    return false;
                //}
                //else if ($('#txtBeneficiaryName').val() == "") {
                //    $('#ValidationMsg').text('Enter beneficiary name').css("color", "red");
                //    $('#txtBeneficiaryName').focus();
                //    e.preventDefault();
                //    return false;
                //}
                //else if ($('#txtBranchAddr').val() == "") {
                //    $('#ValidationMsg').text('Enter branch address').css("color", "red");
                //    $('#txtBranchAddr').focus();
                //    e.preventDefault();
                //    return false;
                //}
                else if ($('#fileUploadPanCard').val() == '') {
                    $('#ValidationMsg').text('*Upload Pan card document').css("color", "red");
                    $('#fileUploadPanCard').focus();
                    e.preventDefault();
                    return false;
                }
                else if (!regexFileUpload.test($('#fileUploadPanCard').val().toLowerCase())) {
                    $('#ValidationMsg').text('Please upload files having extensions: ' + allowedFiles.join(', ') + ' only.').css("color", "red");
                    $('#fileUploadPanCard').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#fileUploadCancelCheque').val() == '') {
                    $('#ValidationMsg').text('*Upload cancel cheque').css("color", "red");
                    $('#fileUploadCancelCheque').focus();
                    e.preventDefault();
                    return false;
                }
                else if (!regexFileUpload.test($('#fileUploadCancelCheque').val().toLowerCase())) {
                    $('#ValidationMsg').text('Please upload files having extensions:" ' + allowedFiles.join(', ') + '" only."').css("color", "red");
                    $('#fileUploadCancelCheque').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#fileUploadAddrProof').val() == '') {
                    $('#ValidationMsg').text('*Upload address proof').css("color", "red");
                    $('#fileUploadAddrProof').focus();
                    e.preventDefault();
                    return false;
                }
                else if (!regexFileUpload.test($('#fileUploadAddrProof').val().toLowerCase())) {
                    $('#ValidationMsg').text('Please upload files having extensions:" ' + allowedFiles.join(', ') + '" only."').css("color", "red");
                    $('#fileUploadAddrProof').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#fileUploadGstReg').val() == '' && $('#txtGstNo').val() != "") {
                    $('#ValidationMsg').text('*Upload gst registration document').css("color", "red");
                    $('#fileUploadGstReg').focus();
                    e.preventDefault();
                    return false;
                }
                else if (!regexFileUpload.test($('#fileUploadGstReg').val().toLowerCase()) && $('#txtGstNo').val() != "") {
                    $('#ValidationMsg').text('Please upload files having extensions:" ' + allowedFiles.join(', ') + '" only."').css("color", "red");
                    $('#fileUploadGstReg').focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#ValidationMsg').text('');
                }
            });
        });
        function CheckEmail() {
            $.ajax({
                url: "PartnerRegistration.aspx/Page_Load",
                data: {
                    method: "CheckEMail",
                    Email: $("#txtPartnerEmail").val()
                },
                success: function (msg) {
                    if (msg != '') {
                        if (msg.toString() == 'F') {
                            $('#ValidationMsg').text('Email Id ' + $("#txtPartnerEmail").val() + ' already exist').css("color", "Red");
                            $('#txtPartnerEmail').focus();
                            $('#txtPartnerEmail').val("");
                        }
                        if (msg.toString() == 'NF') {
                            $('#ValidationMsg').text('');
                        }
                    }
                }
            });
        }
        function Msg() {
            setTimeout(function () {
                $("#MyModel_MsgSuccess").modal('show');
            }, 100);
        }
    </script>
    <script type="text/javascript">
        $(function () {
            $('body').on('change', '#ddlPartnerState', function () {
                var selected_state_id = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "PartnerRegistration.aspx?Action=PostDetailCompany&id=" + selected_state_id,
                    data: { 'selected_state_id': selected_state_id },
                    //contentType: "application/json; charset=utf-8",
                    //dataType: "json",
                    success: function (r) {
                        var myObj = $.parseJSON(r);
                        var ddlCity = "";
                        var select = $("#ddlPartnerCity");
                        select.empty();
                        $.each(myObj, function (key, value) {
                            var content = '<option value="' + value.id_city + '">' + value.name + '</option>';
                            select.append(content);
                        });
                        $('#ddlPartnerCity').selectpicker("refresh");
                    }
                });
            });
            $(function () {
                $("#ddlPartnerCity").change(function () {
                    $('#hdnPartnerCity').val(this.value);

                });
            });
        });


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div class="app-content content partnerRegistration">
                <div class="content-wrapper">
                    <div class="content-header row">
                    </div>
                    <asp:Label ID="lblErrorshowMessage" runat="server" ForeColor="Red"></asp:Label>
                    <div class="content-body">
                        <h1 class="h1Tag">Partner Registration</h1>
                        <!-- Active Orders -->
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div style="height: 25px">
                                        <center><span id="ValidationMsg"></span></center>
                                    </div>
                                    <div class="card-content collapse show">
                                        <div class="card-body">

                                            <div class="form-body">
                                                <div class="row">

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Partner Name<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox runat="server" ID="txtPartnerName" class="form-control name" placeholder="Partner Name" AutoCompleteType="Disabled" MaxLength="50"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Partner EmailId<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox runat="server" ID="txtPartnerEmail" class="form-control" placeholder="Partner Email" AutoCompleteType="Disabled" onchange="CheckEmail();"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Partner Contact No<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox runat="server" ID="txtPartnerMobNo" class="form-control Numeric" placeholder="Partner contact no" AutoCompleteType="Disabled" MaxLength="10"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">GST Number<span style="color: red" class="starRed"></span></label>
                                                            <asp:TextBox runat="server" ID="txtGstNo" class="form-control GST" placeholder="GST Number" AutoCompleteType="Disabled" MaxLength="15"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Pan Card Number<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox runat="server" ID="txtPanCard" class="form-control GST" placeholder="Pan Card Number" AutoCompleteType="Disabled" MaxLength="10"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">State<span style="color: red" class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="ddlPartnerState" runat="server" class="form-control" placeholder="State"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">City<span style="color: red" class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="ddlPartnerCity" runat="server" class="form-control" placeholder="State"></asp:DropDownList>
                                                                <asp:HiddenField ID="hdnPartnerCity" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Pin Code<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox runat="server" ID="txtPinCode" class="form-control Numeric" placeholder="Pin Code" AutoCompleteType="Disabled" MaxLength="6"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Partner address<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox runat="server" ID="txtPartnerAddr" class="form-control" placeholder="Partner Address" TextMode="MultiLine" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Contact Person<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox runat="server" ID="txtContactPerson" class="form-control name" placeholder="Contact Person" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Contact Number of Contact Person<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox runat="server" ID="txtContactNoOfContPerson" class="form-control Numeric" placeholder="Contact Number of Contact Person" AutoCompleteType="Disabled" MaxLength="10"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Email Id of Contact Person<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox runat="server" ID="txtEmailIdOfContperson" class="form-control" placeholder="Email Id of Contact Person" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                   <%-- <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Region<span style="color: red" class="starRed">*</span></label>                                                            
                                                            <asp:DropDownList ID="ddlRegion" runat="server" class="form-control" placeholder="State">
                                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                                <asp:ListItem Value="1">East</asp:ListItem>
                                                                <asp:ListItem Value="2">North</asp:ListItem>
                                                                <asp:ListItem Value="3">South</asp:ListItem>
                                                                <asp:ListItem Value="4">West</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>--%>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Bank Account Number<span style="color: red" class="starRed"></span></label>
                                                            <asp:TextBox runat="server" ID="txtAccountNo" class="form-control Numeric" placeholder="Bank Account Number" AutoCompleteType="Disabled" MaxLength="20"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Bank Name<span style="color: red" class="starRed"></span></label>
                                                            <asp:TextBox runat="server" ID="txtBankName" class="form-control" placeholder="Bank Name" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">IFSC Code<span style="color: red" class="starRed"></span></label>
                                                            <asp:TextBox runat="server" ID="txtIfscCode" class="form-control" placeholder="IFSC Code" AutoCompleteType="Disabled" MaxLength="11"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Beneficiary Name<span style="color: red" class="starRed"></span></label>
                                                            <asp:TextBox runat="server" ID="txtBeneficiaryName" class="form-control" placeholder="Beneficiary Name" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Branch Address<span style="color: red" class="starRed"></span></label>
                                                            <asp:TextBox runat="server" ID="txtBranchAddr" class="form-control" placeholder="Branch Address" TextMode="MultiLine" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <%--<div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Bank Pin Code<span style="color: red" class="starRed">*</span></label>
                                                            <asp:TextBox runat="server" ID="txtBankPinCode" class="form-control Numeric" placeholder="Bank Pin Code" AutoCompleteType="Disabled" MaxLength="6"></asp:TextBox>
                                                        </div>
                                                    </div>--%>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <h5>Pan card (Image(.png,.jpeg,.jpg) or pdf format)<span style="color: red" class="starRed">*</span></h5>
                                                            <div class="controls">
                                                                <asp:FileUpload ID="fileUploadPanCard" runat="server" class="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <h5>Cancelled Cheque (Image(.png,.jpeg,.jpg) or pdf format)<span style="color: red" class="starRed">*</span></h5>
                                                            <div class="controls">
                                                                <asp:FileUpload ID="fileUploadCancelCheque" runat="server" class="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <h5>Address proof (Image(.png,.jpeg,.jpg) or pdf format)<span style="color: red" class="starRed">*</span></h5>
                                                            <div class="controls">
                                                                <asp:FileUpload ID="fileUploadAddrProof" runat="server" class="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <h5>GST Regsitration proof (Image(.png,.jpeg,.jpg) or pdf format)<span style="color: red" class="starRed"></span></h5>
                                                            <div class="controls">
                                                                <asp:FileUpload ID="fileUploadGstReg" runat="server" class="form-control" />
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                            <div class="text-right">
                                                <asp:LinkButton ID="btnSave" runat="server" class="btn btn-success" OnClick="btnSave_Click"><i class="la la-thumbs-o-up position-right"></i> Submit</asp:LinkButton>
                                                <button type="reset" class="btn btn-danger reset-btn"><i class="la la-refresh position-right"></i>Reset</button>
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

        <div id="MyModel_MsgSuccess" class="modal fade">
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
                        <p>Partner details submitted successfully !</p>
                        <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                    </div>
                </div>
            </div>
        </div>

    </form>



    <script src="../Assets/js/jquery.min.js"></script>
    <script src="../Assets/js/scripts/bs.pagination.js"></script>
    <!-- BEGIN VENDOR JS-->
    <script src="../Assets/vendors/js/vendors.min.js" type="text/javascript"></script>
    <!-- BEGIN VENDOR JS-->
    <!-- BEGIN MODERN JS-->
    <script src="../Assets/js/core/app-menu.js" type="text/javascript"></script>
    <script src="../Assets/js/core/app.js" type="text/javascript"></script>
    <script src="../Assets/js/scripts/customizer.js" type="text/javascript"></script>
    <!-- END MODERN JS-->
    <!-- BEGIN PAGE LEVEL JS-->
    <script src="../Assets/js/scripts/pages/dashboard-crypto.js" type="text/javascript"></script>
    <!-- END PAGE LEVEL JS-->
    <script src="../Assets/js/bootstrap.min.js"></script>
    <script src="../Assets/js/PreventRightClick.js"></script>
</body>
</html>
