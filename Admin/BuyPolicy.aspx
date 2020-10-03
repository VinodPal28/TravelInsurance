<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="BuyPolicy.aspx.cs" Inherits="BuyPolicy" EnableEventValidation="false" ClientIDMode="Static" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
     <script src="../Assets/js/jquery.disableAutoFill.js"></script>
    <script src="../Assets/js/jquery.disableAutoFill.min.js"></script>
    <script>
        $(document).ready(function () {
           
            $('.custom-input').find('input[type="radio"]').click(function () {
                if ($(this).is(':checked')) {
                    $('.radiopophide').addClass('hidden');
                    $(this).addClass('ashish');
                    $('.' + $(this).attr('data-attr')).removeClass('hidden')
                    //alert($(this).attr('data-attr'));
                }
            });

            $('#txtFirstname').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z ]/g, '');
                }
            });
            $('#txtMiddlename').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z]/g, '');
                }
            });
            $('#txtLastname').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z]/g, '');
                }
            });
            $('#txtContactNumber').bind('keyup', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });
            $('#txtNomineename').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z ]/g, '');
                }
            });
            $('#txtDOB').bind('keyup', function (e) {
                if (this.value.match(/[^0-9/]/g)) {
                    this.value = this.value.replace(/[^0-9/]/g, '');
                }
            });
            $('#txtTravelStartDate').bind('keyup', function (e) {
                if (this.value.match(/[^0-9/]/g)) {
                    this.value = this.value.replace(/[^0-9/]/g, '');
                }
            });
            $('#txtTravelEndDate').bind('keyup', function (e) {
                if (this.value.match(/[^0-9/]/g)) {
                    this.value = this.value.replace(/[^0-9/]/g, '');
                }
            });
            $('#txtCompanyName').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z ]/g, '');
                }
            });
            $('#txtCompGSTIN').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
                }
            });
            $('#txtCompPincode').bind('keyup', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });
            
            $('#txtNoOfPersons').bind('keyup', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });
            $('#txtNomineeAddres').on('input', function (e) {
                if (this.value.match(/[^a-zA-Z0-9.-/ ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9.-/ ]/g, '');
                }
            });
            function process(date) {
                var parts = date.split("/");
                return new Date(parts[2], parts[1] - 1, parts[0]);
            }
            $("#btnGetprice").click(function (e) {
                var Planlist = $("#<%= ddlPlanlist.ClientID %>").val();
                var DOB = $("#<%= txtDOB.ClientID %>").val();
                var GeographyAskcountry = $("#<%= ddlGeographyAskcountry.ClientID %>").val();
                var GeoState = $("#<%= ddlDomesticState.ClientID %>").val();
                var TravelStartDate = $("#<%= txtTravelStartDate.ClientID %>").val();
                var TravelEndDate = $("#<%= txtTravelEndDate.ClientID %>").val();
                <%--var Productname = $("#<%= ddlProductname.ClientID %>").val();--%>
               <%-- var Price = $("#<%= txtPrice.ClientID %>").val();--%>

                if (Planlist == "0") {
                    $("#lblmsg3").text("*Select the Partner").css("color", "red");
                    $('#ddlPlanlist').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('input[name=radioFoo1]:checked').length <= 0) {
                    $("#lblmsg3").text("*Select the travel type").css("color", "red");
                    $('input[name=radioFoo1]:checked').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('input[name=radioFoo1]:checked').val() == 'International' && GeographyAskcountry == "0") {
                    $("#lblmsg3").text("*Select a Geography Cover").css("color", "red")
                    $('#ddlGeographyAskcountry').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('input[name=radioFoo1]:checked').val() == 'Domestic' && GeoState == "0") {
                    $("#lblmsg3").text("*Select a state").css("color", "red")
                    $('#ddlDomesticState').focus();
                    e.preventDefault();
                    return false;
                }
                else if (DOB == "") {
                    $("#lblmsg3").text("*Select the DOB").css("color", "red");
                    $('#txtDOB').focus();
                    e.preventDefault();
                    return false;
                }
                else if (TravelStartDate == "") {
                    $("#lblmsg3").text("*Select a Travel Start Date").css("color", "red");
                    $('#txtTravelStartDate').focus();
                    e.preventDefault();
                    return false;
                }
                else if (TravelEndDate == "") {
                    $("#lblmsg3").text("*Select a Travel end Date").css("color", "red");
                    $('#txtTravelEndDate').focus();
                    e.preventDefault();
                    return false;
                }
                else if (process(TravelStartDate) > process(TravelEndDate)) {
                    $("#lblmsg3").text("*Travel End Date should be greater than Travel Start Date").css("color", "red");
                    $('#txtTravelEndDate').focus();
                    e.preventDefault();
                    return false;
                }
                    //else if (Productname == "0") {
                    //    $("#lblmsg3").text("*Select Plan name").css("color", "red");
                    //    e.preventDefault();
                    //    return false;
                    //}
                    //else if (Price == "" || Price == "0") {
                    //    $("#lblmsg3").text("*Enter a Price").css("color", "red")
                    //    e.preventDefault();
                    //    return false;
                    //}
                else {
                    $("#lblmsg3").text("").css("color", "red")
                }

                //e.preventDefault();                
                //return false;
            });

            $("#btnCustomerInfo").click(function (e) {
                var title=$("#<%= ddlsurname.ClientID %>").val();
                var Firstname = $("#<%= txtFirstname.ClientID %>").val();
                <%--var Middlename = $("#<%= txtMiddlename.ClientID %>").val();--%>
                var Lastname = $("#<%= txtLastname.ClientID %>").val();
                var ContactNumber = $("#<%= txtContactNumber.ClientID %>").val();
                var Email = $("#<%= txtEmail.ClientID %>").val();
                var NomineeName = $("#<%= txtNomineename.ClientID %>").val();
                var State = $("#<%= ddlState.ClientID %>").val();
                var City = $("#<%= ddlCity.ClientID %>").val();
                var gender = $("#<%= ddlGender.ClientID %>").val();
                var PinCode = $("#<%= txtPinCode.ClientID %>").val();
                var Aadhaar = $("#<%= txtAadhaar.ClientID %>").val();
                var PanNo = $("#<%= txtPanNo.ClientID %>").val();
                var NomineeAddress = $("#<%= txtNomineeAddres.ClientID %>").val();
                var GSTNo = $("#<%= txtGstIn.ClientID %>").val();
                var PassportNo = $("#<%= txtPassportNo.ClientID %>").val();
                var travelType = $("#<%= HiddenTravelType.ClientID %>").val();
                var NomineeRelation = $("#<%= ddlRelationNominee.ClientID %>").val();

                // var mobilerex=/^([6-9]{1})([0-9]{9})$/;

                var reggst = /^([0-9]){2}([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}([0-9]){1}([zZ]){1}([0-9]){1}?$/;
                var regPassport = /[a-zA-Z]{1}[0-9]{7}/;
                var regExp = /[a-zA-z]{5}\d{4}[a-zA-Z]{1}/;
                var Aadh = /^\d{4}\s\d{4}\s\d{4}$/g;
                var RegNumeric = /^[0-9]+$/;
                var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;


                if (validation == true) {
                    if (title == "0") {
                        $("#lblmsg4").text("*Select the title").css("color", "red");
                        $("#ddlsurname").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (Firstname == "") {
                        $("#lblmsg4").text("*Enter the first name").css("color", "red");
                        $("#txtFirstname").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (Lastname == "") {
                        $("#lblmsg4").text("*Enter the Last name").css("color", "red");
                        $("#txtLastname").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (gender == "0") {
                        $("#lblmsg4").text("*Select the gender").css("color", "red");
                        $("#ddlGender").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (ContactNumber == "") {
                        $("#lblmsg4").text("*Enter Contact Number").css("color", "red");
                        $("#txtContactNumber").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (ContactNumber.length != 10) {
                        $("#lblmsg4").text("*Contact Number must be 10 digit ").css("color", "red");
                        $("#txtContactNumber").focus();
                        e.preventDefault();
                        return false;
                    }
                        //else if (!mobilerex.test(ContactNumber)) {
                        //    $("#lblmsg4").text("*Enter valid Contact Number").css("color", "red");
                        //    e.preventDefault();
                        //    return false;
                        //}
                    else if (Email == "") {
                        $("#lblmsg4").text("*Enter a Email").css("color", "red");
                        $("#txtEmail").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (!re.test($('#txtEmail').val())) {
                        $('#lblmsg4').text('Invalid Email').css("color", "red");
                        $("#txtEmail").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (travelType == 'International' && PassportNo == '') {
                        $("#lblmsg4").text("*Enter the passport number").css("color", "red");
                        $("#txtPassportNo").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (PassportNo != '' && !regPassport.test(PassportNo)) {
                        $("#lblmsg4").text("*Enter valid passport No").css("color", "red");
                        $("#txtPassportNo").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (Aadhaar.length != 12 && Aadhaar != '') {
                        $("#lblmsg4").text("*Enter valid Aadhaar No").css("color", "red");
                        $("#txtAadhaar").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (!Aadhaar.match(RegNumeric) && Aadhaar != '') {
                        $("#lblmsg4").text("*Aadhaar no must be numeric").css("color", "red");
                        $("#txtAadhaar").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (PanNo.length != 10 && PanNo != '') {
                        $("#lblmsg4").text("*Enter valid Pan No").css("color", "red");
                        $("#txtPanNo").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (!PanNo.match(regExp) && PanNo != '') {
                        $("#lblmsg4").text("*Enter valid Pan No (ex - aaaaa9999a)").css("color", "red");
                        $("#txtPanNo").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (!reggst.test(GSTNo) && GSTNo != '') {
                        $('#lblmsg4').text('GST Identification Number is not valid. It should be in this "11AAAAA1111A1Z1" format').css("color", "red");
                        $("#txtGstIn").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (State == "0") {
                        $("#lblmsg4").text("*Select the State").css("color", "red");
                        $("#ddlState").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (City == "0") {
                        $("#lblmsg4").text("*Select the City").css("color", "red");
                        $("#ddlCity").focus();
                        e.preventDefault();
                        return false;
                    }

                    else if (PinCode == "") {
                        $("#lblmsg4").text("*Enter Pin Code").css("color", "red");
                        $("#txtPinCode").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (PinCode.length != 6) {
                        $("#lblmsg4").text("*Pincode must be 6 digit").css("color", "red");
                        $("#txtPinCode").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (!PinCode.match(RegNumeric)) {
                        $("#lblmsg4").text("*Pincode must be numeric").css("color", "red");
                        $("#txtPinCode").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (NomineeAddress == "") {
                        $("#lblmsg4").text("*Enter the Address").css("color", "red");
                        $("#txtNomineeAddres").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (NomineeName == "") {
                        $("#lblmsg4").text("*Enter the Nominee Name").css("color", "red");
                        $("#txtNomineename").focus();
                        e.preventDefault();
                        return false;
                    }
                    //else if (NomineeRelation == "0") {
                    //    $("#lblmsg4").text("*Select the Nominee relation").css("color", "red");
                    //    e.preventDefault();
                    //    return false;
                    //}
                    else {
                        $("#lblmsg4").text("").css("color", "red");
                        $("#ddlCity").change(function () {
                            $('#HiddenCity').val("#ddlCity".val());

                        });
                    }

                    $('#lblCustName').text($('#txtFirstname').val() + ' ' + $('#txtMiddlename').val() + ' ' + $('#txtLastname').val());
                    $('#lblDOB').text($('#txtDOB').val());
                    $('#lblEmailId').text($('#txtEmail').val());
                    $('#lblMobNo').text($('#txtContactNumber').val());
                    $('#lblAddr').text($('#txtNomineeAddres').val());
                    $('#lblPinCode').text($('#txtPinCode').val());
                    $('#lblSDate').text($('#txtTravelStartDate').val());
                    $('#lblEdate').text($('#txtTravelEndDate').val());

                    e.preventDefault();
                    $('#tabs a[href="#summery"]').tab('show');
                    $('#CI').removeClass("active");
                    $('#smry').addClass("active");
                    $('#smry').focus();
                    return false;
                }
                if (validation == false) {
                    var CompanyTitle=$("#<%= ddlCompanySurname.ClientID %>").val();
                    var CompanyName = $("#<%= txtCompanyName.ClientID %>").val();
                    var CompanyEmail = $("#<%= txtCompEmailID.ClientID %>").val();
                    var CompGSTIN = $("#<%= txtCompGSTIN.ClientID %>").val();
                    var CompState = $("#<%= ddlCompState.ClientID %>").val();
                    var CompCity = $("#<%= ddlCompCity.ClientID %>").val();
                    var CompPinCode = $("#<%= txtCompPincode.ClientID %>").val();
                    var CompAddr = $("#<%= txtCompAddt.ClientID %>").val();
                    var CheckNoOfPerson = $("#<%= txtNoOfPersons.ClientID %>").val();
                    var CompNomineName = $("#<%= txtNomineename.ClientID %>").val();
                    if (CompanyTitle == "0") {
                        $("#lblmsg4").text("*Select the title").css("color", "red");
                        $("#ddlCompanySurname").focus();
                        e.preventDefault();
                        return false;
                    }
                   else if (CompanyName == "") {
                       $("#lblmsg4").text("*Enter the Company name").css("color", "red");
                       $("#txtCompanyName").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (CompanyEmail == "") {
                        $("#lblmsg4").text("*Enter a Email").css("color", "red");
                        $("#txtCompEmailID").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (!re.test($('#txtCompEmailID').val())) {
                        $('#lblmsg4').text('Invalid Email').css("color", "red");
                        $("#txtCompEmailID").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (CompGSTIN == "") {
                        $("#lblmsg4").text("*Enter the GSTIN no").css("color", "red");
                        $("#txtCompGSTIN").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (!reggst.test(CompGSTIN)) {
                        $('#lblmsg4').text('GST Identification Number is not valid. It should be in this "11AAAAA1111A1Z1" format').css("color", "red");
                        $("#txtCompGSTIN").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (CompState == "0") {
                        $("#lblmsg4").text("*Select the state").css("color", "red");
                        $("#ddlCompState").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (CompCity == "0") {
                        $("#lblmsg4").text("*Select the City").css("color", "red");
                        $("#ddlCompCity").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (CompPinCode == "") {
                        $("#lblmsg4").text("*Enter the pinCode").css("color", "red");
                        $("#txtCompPincode").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (CompPinCode.length != 6) {
                        $("#lblmsg4").text("*Pincode must be 6 digit").css("color", "red");
                        $("#txtCompPincode").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (CompAddr == "") {
                        $("#lblmsg4").text("*Enter the address").css("color", "red");
                        $("#txtCompAddt").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (CheckNoOfPerson == "") {
                        $("#lblmsg4").text("*Enter the No Of Persons").css("color", "red");
                        $("#txtNoOfPersons").focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (CompNomineName == "") {
                        $("#lblmsg4").text("*Enter the nominee name").css("color", "red");
                        $("#txtNomineename").focus();
                        e.preventDefault();
                        return false;
                    }
                    //else if (NomineeRelation == "0") {
                    //    $("#lblmsg4").text("*Select the Nominee relation").css("color", "red");
                    //    e.preventDefault();
                    //    return false;
                    //}
                    else {
                        $("#lblmsg4").text("").css("color", "red");
                        $("#ddlCompCity").change(function () {
                            $('#HiddenCompCity').val(this.value);

                        });
                    }

                    $('#lblCustName').text($('#txtCompanyName').val());
                    $('#lblDOB').text($('#txtDOB').val());
                    $('#lblEmailId').text($('#txtCompEmailID').val());
                   
                    $('#lblAddr').text($('#txtCompAddt').val());
                    $('#lblPinCode').text($('#txtCompPincode').val());
                    $('#lblSDate').text($('#txtTravelStartDate').val());
                    $('#lblEdate').text($('#txtTravelEndDate').val());

                    e.preventDefault();
                    $('#tabs a[href="#summery"]').tab('show');
                    $('#CI').removeClass("active");
                    $('#smry').addClass("active");
                    $('#smry').focus();
                    return false;

                }
            });
            $('#btnWait').hide();
            $('#btnWait').attr('disabled', 'disabled').removeClass('btn-success');
            $('#btnSummery').show();
            $('#btnSumryPrecious').show();
            $("#btnSummery").click(function (e) {
                if ($('input[name=radioPaymentOption]:checked').length <= 0) {
                    $("#lblMsgSummary").text("*Select the payment option").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else {
                    $("#lblMsgSummary").text("");                   
                    $('#btnWait').show();
                    $('#btnSummery').hide();
                    $('#btnSumryPrecious').hide();
                }
            });
            $("#btnCustomerPrecious").click(function (e) {
                
                $('#tabs a[href="#Plan-Details"]').tab('show');
                $('#CI').removeClass("active");
                $('#PD').addClass("active");
                $('#PD').focus();
                e.preventDefault();
                return false;
            });

            $("#btnSumryPrecious").click(function (e) {
                
                e.preventDefault();
                $('#tabs a[href="#Customer-Information"]').tab('show');
                // $('#tabs a[href="#summery"]').tab('hide');
                $('#smry').removeClass("active");
                $('#CI').addClass("active");
                $('#CI').focus();
                return false;
            });          
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

    <script>
        function ShowMsg() {
            SpnMsg.style.color = "Green";
            SpnMsg.innerHTML = "Submit Successfully!";
        };
        function ShowMsgErr() {
            lblError.style.color = "Red";
            lblError.innerHTML = "Already exist!";
        };
    </script>

    <script type="text/javascript">
        function messageshow() {
            setTimeout(function () {
                $("#exampleModal9").modal('show');
            }, 100);
        }
    </script>

    <script type="text/javascript">

        function Showage() {
            setTimeout(function () {
                $("#MyModel_Age").modal('show');
            }, 100);
        }
        function CheckWalletBalance() {
            setTimeout(function () {
                $("#MyModel_CheckBalance").modal('show');
            }, 100);
        }

        function MsgSuccess() {
            setTimeout(function () {
                $("#MyModel_MsgSuccess").modal('show');
            }, 100);
        }
        function MsgFail() {
           
            setTimeout(function () {
                $("#MyModel_PaymentFail").modal('show');
            }, 100);
        }
        function ViewBenifits() {
            setTimeout(function () {
                $("#MyModal_Benifits").modal('show');
            }, 100);
        }
        function MovetoCust(e) {
            e.preventDefault();            
            $('#tabs a[href="#Customer-Information"]').tab('show');
            $('#PD').removeClass("active");
            $('#CI').addClass("active");          
            return false;
        }
    </script>

    <script type="text/javascript">
        function CheckDetails() {
            $.ajax({
                url: "BuyPolicy.aspx/Page_Load",
                data: {
                    method: "CheckNoOfpersons",
                    NoOfpersons: $("#txtNoOfPersons").val(),
                    planCode: $("#HiddenplanCodeOfPolicy").val(),
                    StartDate: $("#txtTravelStartDate").val(),
                    EndDate: $("#txtTravelEndDate").val()
                },
                success: function (msg) {
                    if (msg != '') {
                        var data = msg.split('#');
                        if (data[0].toString() == 'F') {
                            $('#lblNoOfpersons').text('');
                        }
                        else if (data[0].toString() == 'NoOftravelExceded') {
                            $('#lblNoOfpersons').text('Not more than ' + data[1].toString() + ' travellers allowed').css("color", "Red");
                            $('#txtNoOfPersons').val("");
                        }
                    }
                }
            });
        }
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#Div_Walletbtn").hide();
            $("#RdoWallet").click(function (e) {

                var Price = $("#txtPaymentamount").val();
                var WalletBalance = $("#lblWalletBalace").val();

                if (WalletBalance < Price) {

                    $("#Div_Summary").show();
                    $("#Div_Walletbtn").hide();
                }
            });

        });

    </script>

    <script type="text/javascript">
        function MiceShow() {
            if ($('#txtNoOfPersons').val() == "0") {
                $("#lblNoOfpersons").text("No of persons must be greater than 0").css("color", "red");
                e.preventDefault();
                return false;
            }
            else {
                $("#lblNoOfpersons").text("");

                $.ajax({
                    url: "BuyPolicy.aspx/Page_Load",
                    data: {
                        method: "CheckNoOfpersons",
                        NoOfpersons: $("#txtNoOfPersons").val(),
                        planCode: $("#HiddenplanCodeOfPolicy").val(),
                        StartDate: $("#txtTravelStartDate").val(),
                        EndDate: $("#txtTravelEndDate").val()
                    },
                    success: function (msg) {
                        if (msg != '') {
                            var data = msg.split('#');
                            if (data[0].toString() == 'F') {
                                $('#lblNoOfpersons').text('');

                                if ($('#maintable tr').length > 1) {
                                    $('#maintable tr').remove();

                                }
                                $("#lblMsg4").text("");

                                var NoOfPersonsCount = parseInt($("#txtNoOfPersons").val());

                                var j = 0;
                                while (NoOfPersonsCount > 0) {
                                    j++;
                                    var pricetr = "<tr>";
                                    pricetr = pricetr + "<td><label>" + j + "</Label></td>";
                                    pricetr = pricetr + "<td><input type='text' maxlength='30' id='txtName" + j + "' class='form-control Name' placeholder='Name'></td>";
                                    pricetr = pricetr + "<td><input type='text' maxlength='8' id='txtPassportNo" + j + "' class='form-control PassportNo' placeholder='Passport number'></td>";
                                    pricetr = pricetr + "<td><input type='text' maxlength='10' id='txtMobNo" + j + "' class='form-control MobNo' placeholder='Mobile No'></td>";
                                    pricetr = pricetr + "<td><input type='text' maxlength='20' id='txtEmailId" + j + "' class='form-control EmailId' placeholder='Email Id'></td>";
                                    pricetr = pricetr + "<td><select id='ddlMiceGender" + j + "' class='form-control'><option value='0'>Select</option><option value='Male'>Male</option><option value='Female'>Female</option><option value='Others'>Others</option></td>";
                                    pricetr = pricetr + "</tr></br>";
                                    NoOfPersonsCount--;

                                    $('#maindiv').append(pricetr);
                                }
                                $('#maintable').find(":text").each(function () {
                                    $("input:text,textarea").keypress(function () {
                                        $('#lblCustMessage').text("");
                                    });
                                    $('.Name').on('input', function (event) {
                                        this.value = this.value.replace(/[^A-Za-z ]/g, '');
                                    });
                                    $('.PassportNo').on('input', function (event) {
                                        this.value = this.value.replace(/[^A-Za-z0-9]/g, '');
                                    });
                                    $('.MobNo').on('input', function (event) {
                                        this.value = this.value.replace(/[^0-9]/g, '');
                                    });
                                });
                                $("#MyModal_Persons").modal('show');
                                e.preventDefault();
                                return false;
                            }
                            else if (data[0].toString() == 'NoOftravelExceded') {
                                $('#lblNoOfpersons').text('Not more than ' + data[1].toString() + ' travellers allowed').css("color", "Red");
                                $('#txtNoOfPersons').val("");
                            }
                        }
                    }
                });
            }
        }
        $(document).ready(function () {
            $("#Div_GeoCountry").hide();
            $("#Div_State").hide();

            $('.custom-input').find('input[type="radio"]').click(function () {
                if ($(this).is(':checked')) {
                    $('.radiopophide').addClass('hidden');
                    $(this).addClass('ashish');
                    $('.' + $(this).attr('data-attr')).removeClass('hidden')
                    //alert($(this).attr('data-attr'));
                }
            });
            $("#Close").click(function (e) {

                $('#txtNoOfPersons').val('');
            });
            $("#close1").click(function (e) {

                $('#txtNoOfPersons').val('');
            });
            $("#btnNoOfPersonsSave").click(function (e) {
                var valid = true;
                var CountMiceDetails = parseInt($("#txtNoOfPersons").val());
                var regPassport1 = /[a-zA-Z]{1}[0-9]{7}/;
                var reEmail = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                var mobilerex = /^([6-9]{1})([0-9]{9})$/;
                for (var i = 1; i <= CountMiceDetails; i++) {

                    if ($('#txtName' + i).val() == "") {
                        $("#lblCustMessage").text("*Enter the name").css("color", "red");
                        $('#txtName' + i).focus();
                        valid = false;
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtPassportNo' + i).val() == "") {
                        $("#lblCustMessage").text("*Enter the passport number").css("color", "red");
                        $('#txtPassportNo' + i).focus();
                        valid = false;
                        e.preventDefault();
                        return false;
                    }
                    else if (!regPassport1.test($('#txtPassportNo' + i).val())) {
                        $("#lblCustMessage").text("*Enter the valid passport number").css("color", "red");
                        $('#txtPassportNo' + i).focus();
                        valid = false;
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtMobNo' + i).val() == "") {
                        $("#lblCustMessage").text("*Enter the mobile number").css("color", "red");
                        $('#txtMobNo' + i).focus();
                        valid = false;
                        e.preventDefault();
                        return false;
                    }

                    else if ($('#txtMobNo' + i).val().length != 10) {
                        $("#lblCustMessage").text("*Mobile number must be 10 digit").css("color", "red");
                        $('#txtMobNo' + i).focus();
                        valid = false;
                        e.preventDefault();
                        return false;
                    }
                        //else if (!mobilerex.test($('#txtMobNo' + i).val())) {
                        //    $("#lblCustMessage").text("*Enter valid mobile number").css("color", "red");
                        //    $('#txtMobNo' + i).focus();
                        //    valid = false;
                        //    e.preventDefault();
                        //    return false;
                        //}
                    else if ($('#txtEmailId' + i).val() == "") {
                        $("#lblCustMessage").text("*Enter the email id").css("color", "red");
                        $('#txtEmailId' + i).focus();
                        valid = false;
                        e.preventDefault();
                        return false;
                    }
                    else if (!reEmail.test($('#txtEmailId' + i).val())) {
                        $('#lblCustMessage').text('Invalid Email id').css("color", "red");
                        $('#txtEmailId' + i).focus();
                        valid = false;
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#ddlMiceGender' + i).val() == "0") {
                        $("#lblCustMessage").text("*Select the gender").css("color", "red");
                        $('#ddlMiceGender' + i).focus();
                        valid = false;
                        e.preventDefault();
                        return false;
                    }
                }
                // });
                if (valid == false) {
                    e.preventDefault();
                    return false;
                }
                else {
                    SaveMiceDetails();
                }
            });
            $(".Next").on("click", function (e) {
                GetSelectedRow(this);
                e.preventDefault();
                if ($('#HiddenTravelType').val() == "International") {
                    $('#Passsportvalid').text("Passport Number*");

                }

                else {

                    $('#Passsportvalid').text("Passport Number");
                }

                $('#tabs a[href="#Customer-Information"]').tab('show');
                $('#PD').removeClass("active");
                $('#CI').addClass("active");
                $('#CI').focus();
                return false;
            });
            var validation = true;
        });

        function SaveMiceDetails() {
            var data = JSON.stringify(getdate());
            $.ajax({
                url: "BuyPolicy.aspx?Action=SaveData&lb=" + data,
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                data: JSON.stringify({ 'PlanBenifits': data }),
                success: function (response) {
                    if (response != '') {
                        var data = response.split('#');
                        if (data[0].toString() == 'F') {
                            $('#HiddenMiceNo').val(data[1].toString());

                        }

                    }
                },
                error: function () {
                    alert("Error while inserting data");
                }
            });
        }

        function getdate() {
            var CountMiceDetails = document.getElementById('maindiv').getElementsByTagName('input').length;
            var TextCountMiceDetails = CountMiceDetails / 4;
            var data = [];
            for (var i = 1; i <= TextCountMiceDetails; i++) {
                var Name = $('#txtName' + i).val();
                var PassportNo = $('#txtPassportNo' + i).val();
                var MobNo = $('#txtMobNo' + i).val();
                var EmailId = $('#txtEmailId' + i).val();
                var Gender = $('#ddlMiceGender' + i).val();

                var alldata = {
                    'Name': Name,
                    'PassportNo': PassportNo,
                    'MobNo': MobNo,
                    'EmailId': EmailId,
                    'Gender': Gender
                }
                data.push(alldata);
            }

            return data;
        }
    </script>

    <script type="text/javascript">
        function GetSelectedRow(lnk) {
            var row = lnk.parentNode.parentNode;
            var rowIndex = row.rowIndex - 1;
            var PlanCode = row.cells[0].getElementsByTagName("input")[0].value;
            var DurationBasis = row.cells[1].getElementsByTagName("input")[0].value;
            var Price = row.cells[2].getElementsByTagName("input")[0].value;
            var PlanNameOfPolicy = row.cells[3].getElementsByTagName("input")[0].value;

            if (DurationBasis == 'MICE' || DurationBasis == 'Perday') {
                $('#CompanyDetails').show();
                $('#Div_NoOfPersons').show();
                $('#CustomerInfo').hide();
                validation = false;
            }
            else {
                $('#CompanyDetails').hide();
                $('#Div_NoOfPersons').hide();
                $('#CustomerInfo').show();
                validation = true;
            }
            $('#lblPlanNameOfPolicy').text(PlanNameOfPolicy);
            $('#lblPriceSummary').text(Price);
            $('#lblTotalPremium').text(Price);
            $('#HiddenPlanPrice').val(Price);
            $('#lblPlanCodeOfPolicy').text(PlanCode);
            $('#HiddenplanCodeOfPolicy').val(PlanCode);

            return false;
        }
    </script>

    <script type="text/javascript">
        $(function () {
            $('body').on('change', '#ddlState', function () {
                var selected_state_id = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "BuyPolicy.aspx?Action=PostDetail&id=" + selected_state_id,
                    data: { 'selected_state_id': selected_state_id },
                    //contentType: "application/json; charset=utf-8",
                    //dataType: "json",
                    success: function (r) {
                        var myObj = $.parseJSON(r);
                        var ddlCity = "";
                        var select = $("#ddlCity");
                        select.empty();
                        $.each(myObj, function (key, value) {
                            var content = '<option value="' + value.id_city + '">' + value.name + '</option>';
                            select.append(content);
                        });
                        $('#ddlCity').selectpicker("refresh");
                    }
                });
            });
        });
        $(function () {
            $("#ddlCity").change(function () {
                $('#HiddenCity').val(this.value);

            });
        });

    </script>

    <script type="text/javascript">
        $(function () {
            $('body').on('change', '#ddlCompState', function () {
                var selected_state_id = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "BuyPolicy.aspx?Action=PostDetailCompany&id=" + selected_state_id,
                    data: { 'selected_state_id': selected_state_id },
                    //contentType: "application/json; charset=utf-8",
                    //dataType: "json",
                    success: function (r) {
                        var myObj = $.parseJSON(r);
                        var ddlCity = "";
                        var select = $("#ddlCompCity");
                        select.empty();
                        $.each(myObj, function (key, value) {
                            var content = '<option value="' + value.id_city + '">' + value.name + '</option>';
                            select.append(content);
                        });
                        $('#ddlCompCity').selectpicker("refresh");
                    }
                });
            });
            $(function () {
                $("#ddlCompCity").change(function () {
                    $('#HiddenCompCity').val(this.value);

                });
            });
        });

      
    </script>
    <asp:ScriptManager ID="ScriptManager1" runat="server" />

    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblErrorshowMessage" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">Buy Policy</h1>
                <div id="buy-policy-content">
                    <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
                        <li><a href="#Plan-Details" class="active" id="PD">Plan Details </a></li>
                        <li><a href="#Customer-Information" id="CI">Customer Information</a></li>
                        <%--<li><a href="#Payment" id="Pay" data-toggle="tab">Payment</a></li>--%>
                        <li><a href="#summery" id="smry">Summary</a></li>
                        <%--<li><a href="#Download-policy">Download</a></li>--%>
                    </ul>
                    <div class="tab-dot" id="div3"></div>
                    <div id="my_tab_content" class="tab-content">
                        <asp:HiddenField ID="HiddenPlanPrice" runat="server"></asp:HiddenField>
                        <asp:HiddenField ID="HiddenplanCodeOfPolicy" runat="server"></asp:HiddenField>
                        <asp:HiddenField ID="HiddenCity" runat="server"></asp:HiddenField>
                        <asp:HiddenField ID="HiddenTravelType" runat="server"></asp:HiddenField>
                        <asp:HiddenField ID="HiddenCompCity" runat="server"></asp:HiddenField>
                        <asp:HiddenField ID="HiddenMiceNo" runat="server" Value="0"></asp:HiddenField>
                        <div class="tab-pane active" id="Plan-Details">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div style="height: 20px">
                                            <center><asp:Label ID="lblmsg3" runat="server" ClientIDMode="Static"></asp:Label></center>
                                            <center><asp:Label ID="SpnMsg" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label></center>
                                            <center><asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red" ClientIDMode="Static"></asp:Label></center>
                                        </div>
                                        <div class="card-content collapse show">

                                            <div class="card-body">

                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-4" id="div_PartnerName" runat="server">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Partner Name<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:DropDownList ID="ddlPlanlist" runat="server" class="form-control"></asp:DropDownList>
                                                                    <div class="help-block"></div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Travel Type<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <label class="custom-input" style="width: 120px;">

                                                                        <input type="radio" name="radioFoo1" value="International" data-attr="GeoGraphy" id="RdoInternational">
                                                                        <span class="check-radio"></span>
                                                                        <span class="custom-input-label">International</span>
                                                                    </label>
                                                                    <label class="custom-input" style="width: 110px;">
                                                                        <input type="radio" name="radioFoo1" value="Domestic" data-attr="DomesticState" id="RdoDomestic">
                                                                        <span class="check-radio"></span>
                                                                        <span class="custom-input-label">Domestic</span>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4 GeoGraphy radiopophide hidden">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Geography Cover <span class="starRed">*</span></label>
                                                                <asp:DropDownList ID="ddlGeographyAskcountry" runat="server" class="form-control"></asp:DropDownList>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4 DomesticState radiopophide hidden">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Geography Cover<span class="starRed">*</span></label>
                                                                <%--<asp:DropDownList ID="ddlDomesticState" runat="server" class="form-control"></asp:DropDownList>--%>
                                                                <asp:TextBox ID="ddlDomesticState" runat="server" class="form-control" Text="Within India" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Customer DOB<span class="starRed">*</span></label>
                                                                <asp:TextBox ID="txtDOB" runat="server" class="form-control" placeholder="dd/mm/yyyy" ClientIDMode="Static" AutoCompleteType="Disabled" MaxLength="10"></asp:TextBox>
                                                                <%--<asp:TextBox ID="txtDOB" runat="server" class="form-control" placeholder="dd/mm/yyyy" OnTextChanged="txtDOB_TextChanged" AutoPostBack="true" ClientIDMode="Static" AutoCompleteType="Disabled"></asp:TextBox>--%>
                                                                <asp:CalendarExtender ID="CalendarDOB" PopupButtonID="txtDOB" runat="server" TargetControlID="txtDOB" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Travel Start Date<span class="starRed">*</span></label>
                                                                <%-- <asp:TextBox type="date" ID="txtTravelStartDate" runat="server" class="form-control" name="dateopened" data-trigger="hover" data-placement="top" data-title="Date Opened"></asp:TextBox>--%>
                                                                <asp:TextBox ID="txtTravelStartDate" runat="server" class="form-control" placeholder="dd/mm/yyyy" AutoCompleteType="Disabled" MaxLength="10"></asp:TextBox>
                                                                <asp:CalendarExtender ID="CalendarTravelSDate" PopupButtonID="txtTravelStartDate" runat="server" TargetControlID="txtTravelStartDate" Format="dd/MM/yyyy"></asp:CalendarExtender>

                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Travel End Date<span class="starRed">*</span></label>
                                                                <%-- <asp:TextBox type="date" ID="txtTravelEndDate" runat="server" class="form-control" data-trigger="hover" data-title="Date Opened" ClientIDMode="Static"></asp:TextBox>--%>
                                                                <asp:TextBox ID="txtTravelEndDate" runat="server" class="form-control" placeholder="dd/mm/yyyy" AutoCompleteType="Disabled" MaxLength="10"></asp:TextBox>
                                                                <asp:CalendarExtender ID="CalendarTravelEDate" PopupButtonID="txtTravelEndDate" runat="server" TargetControlID="txtTravelEndDate" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                                            </div>
                                                        </div>

                                                        <%-- <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput1">Plan Name<span class="starRed">*</span></label>
                                                                <asp:DropDownList ID="ddlProductname" runat="server" class="form-control" OnSelectedIndexChanged="ddlProductname_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput1">No of Days</label>
                                                                <asp:TextBox ID="txtNoOfDays" runat="server" class="form-control" placeholder="No of days" AutoCompleteType="Disabled" disabled></asp:TextBox>

                                                            </div>
                                                        </div>

                                                        <div class="col-md-4" runat="server" id="NoOfPerson">
                                                            <div class="form-group">
                                                                <label for="projectinput1">No of Persons<span class="starRed">*</span></label>
                                                                <asp:TextBox ID="txtNoOfPersons" runat="server" class="form-control" placeholder="No of Persons" onchange="CheckDetails();" AutoCompleteType="Disabled"></asp:TextBox>
                                                                <span id="lblNoOfpersons"></span>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Price</label>
                                                                <asp:TextBox ID="txtPrice" runat="server" class="form-control" placeholder="Price"></asp:TextBox>
                                                            </div>
                                                        </div>--%>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2"></label>
                                                                <asp:Button ID="btnGetprice" runat="server" CssClass="btn btn-success" OnClick="btnGetprice_Click" Text="Get Quote" Style="margin-top: 7%;"></asp:Button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <%--<div class="text-right">
                                                    <button id="btnsubmit" type="submit" class="btn btn-success">Next</button>
                                                </div>--%>
                                                <br />
                                                <br />
                                                <%--Start Grid of Plan Name--%>
                                                <div class="table table-de mb-0" runat="server" id="GridViewPlanDetails">
                                                    <asp:GridView ID="GV_PlanName" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" 
                                                        PagerStyle-CssClass="bs-pagination" Width="100%" OnRowCommand="GV_PlanName_RowCommand" >

                                                        <Columns>

                                                            <asp:TemplateField HeaderText="Sr.No.">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                                    <asp:HiddenField ID="lblPlanCode" runat="server" Value='<%#Bind("id") %>'></asp:HiddenField>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Plan Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblPlanName123" runat="server" Text='<%#Bind("name") %>'></asp:Label>
                                                                    <asp:HiddenField ID="lblDurationBasis" runat="server" Value='<%#Bind("Duration_Basis") %>'></asp:HiddenField>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                            <asp:TemplateField HeaderText="Benefits">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lblPlanBenifits" runat="server" Text='View' ForeColor="Blue" Font-Underline="true" CommandName="View" CommandArgument='<%# Container.DataItemIndex + 1 %>'></asp:LinkButton>
                                                                    <asp:HiddenField ID="lblprice" runat="server" Value='<%#Bind("price") %>'></asp:HiddenField>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Price (Inclusive of all taxes)">
                                                                <ItemTemplate>
                                                                    <asp:HiddenField ID="lblPlanName" runat="server" Value='<%#Bind("name") %>'></asp:HiddenField>
                                                                    <button id="BtnPlanPrice" type="submit" class="btn btn-success Next">
                                                                        <i class="fa fa-rupee" aria-hidden="true"></i>
                                                                        <asp:Label ID="HiddenField1" runat="server" Text='<%#Bind("price") %>'></asp:Label>
                                                                        <i class="fa fa-arrow-right" aria-hidden="true"></i>
                                                                    </button>
                                                                </ItemTemplate>


                                                            </asp:TemplateField>

                                                        </Columns>
                                                        <EmptyDataTemplate><b style="color: red">No Plan Available</b></EmptyDataTemplate>
                                                    </asp:GridView>
                                                </div>

                                                <%-- End Grid--%>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="Customer-Information">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-content collapse show">
                                            <div class="card-body" style="border: 1px solid #9e9e9e87">
                                                <div style="height: 20px">
                                                    <center><asp:Label ID="lblmsg4" runat="server" ClientIDMode="Static"></asp:Label></center>
                                                </div>

                                                <div id="CompanyDetails">
                                                    <h1>Company Information</h1>
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-md-1">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Title<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:DropDownList ID="ddlCompanySurname" runat="server" class="form-control" placeholder="Surname" MaxLength="20" AutoCompleteType="Disabled" style=" width: 92px;"></asp:DropDownList>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-3">
                                                            <div class="form-group">
                                                                <label for="projectinput2" style="margin-left: 10px;">Company Name<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompanyName" runat="server" class="form-control" placeholder="First Name" MaxLength="20" AutoCompleteType="Disabled" Style=" margin-left: 12px; width: 207px;"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Email Id<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompEmailID" runat="server" class="form-control" placeholder="Email" AutoCompleteType="Disabled"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">GSTIN<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompGSTIN" runat="server" class="form-control" placeholder="GSTIN" AutoCompleteType="Disabled" MaxLength="15"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">State<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:DropDownList ID="ddlCompState" runat="server" class="form-control" placeholder="State"></asp:DropDownList>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">City<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:DropDownList ID="ddlCompCity" runat="server" class="form-control" placeholder="State"></asp:DropDownList>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Pin Code<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompPincode" runat="server" class="form-control" placeholder="Pin Code" MaxLength="6" AutoCompleteType="Disabled"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Address<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompAddt" runat="server" class="form-control" placeholder="Address" TextMode="MultiLine" AutoCompleteType="Disabled"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>


                                                    </div>
                                                </div>

                                                <div class="row" id="Div_NoOfPersons">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">No of Persons<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtNoOfPersons" runat="server" class="form-control" placeholder="No of Persons" MaxLength="2" AutoCompleteType="Disabled" onblur="MiceShow();"></asp:TextBox>
                                                                <span id="lblNoOfpersons"></span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%-- <div class="col-md-4">
                                                        <div class="heading-elements" style="margin-top: 38px;">
                                                            <a href="javascript:void(0);" class="btncolor" id="btnNoOfPersons">Submit No Of Person details</a>

                                                        </div>
                                                    </div>--%>
                                                </div>

                                                <div id="CustomerInfo">
                                                    <h1>Customer Information</h1>
                                                    <hr />

                                                    <div class="card-body">

                                                        <div class="form-body">


                                                            <div class="row">
                                                                <div class="col-md-1">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">Title<span class="starRed">*</span></label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="ddlsurname" runat="server" class="form-control" placeholder="Surname" MaxLength="20" AutoCompleteType="Disabled" Style="width: 89px;"></asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-3">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2" style=" margin-left: 13px;">First Name<span class="starRed">*</span></label>
                                                                        <div class="controls">
                                                                            <asp:TextBox ID="txtFirstname" runat="server" class="form-control" placeholder="First Name" MaxLength="20" AutoCompleteType="Disabled" Style="margin-left: 14px; width: 195px;"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">Middle Name<span class="starRed"></span></label>
                                                                        <div class="controls">
                                                                            <asp:TextBox ID="txtMiddlename" runat="server" class="form-control" placeholder="Middle Name" MaxLength="20" AutoCompleteType="Disabled"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">Last Name<span class="starRed">*</span></label>
                                                                        <div class="controls">
                                                                            <asp:TextBox ID="txtLastname" runat="server" class="form-control" placeholder="Last Name" MaxLength="20" AutoCompleteType="Disabled"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">Gender<span class="starRed">*</span></label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="ddlGender" runat="server" class="form-control" placeholder="Gender">
                                                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                                                <asp:ListItem Value="F">Female</asp:ListItem>
                                                                                <asp:ListItem Value="M">Male</asp:ListItem>
                                                                                <asp:ListItem Value="O">Others</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <%-- <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Middle Name<span class="starRed"></span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtMiddlename" runat="server" class="form-control" placeholder="Middle Name" MaxLength="20" AutoCompleteType="Disabled"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Last Name<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtLastname" runat="server" class="form-control" placeholder="Last Name" MaxLength="20" AutoCompleteType="Disabled"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>--%>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">Contact Number<span class="starRed">*</span></label>
                                                                        <div class="controls">
                                                                            <asp:TextBox ID="txtContactNumber" runat="server" class="form-control" placeholder="Contact Number" MaxLength="10" AutoCompleteType="Disabled"></asp:TextBox>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">Email<span class="starRed">*</span></label>
                                                                        <div class="controls">
                                                                            <asp:TextBox ID="txtEmail" runat="server" class="form-control" placeholder="Email" AutoCompleteType="Disabled"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <%--  <label for="projectinput2" >Passport Number</label>--%><asp:Label ID="Passsportvalid" runat="server" Text="Passport Number"></asp:Label>
                                                                        <div class="controls">
                                                                            <asp:TextBox ID="txtPassportNo" runat="server" class="form-control" placeholder="Passport number" AutoCompleteType="Disabled" MaxLength="8"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">Aadhaar</label>
                                                                        <div class="controls">
                                                                            <asp:TextBox ID="txtAadhaar" runat="server" class="form-control" placeholder="Aadhaar" MaxLength="12" AutoCompleteType="Disabled"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">Pan No</label>
                                                                        <div class="controls">
                                                                            <asp:TextBox ID="txtPanNo" runat="server" class="form-control" placeholder="Pan No" MaxLength="10" onblur="fnValidatePAN(this);" AutoCompleteType="Disabled"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">GSTIN</label>
                                                                        <div class="controls">
                                                                            <asp:TextBox ID="txtGstIn" runat="server" class="form-control" placeholder="GSTIN" AutoCompleteType="Disabled" MaxLength="15"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">State<span class="starRed">*</span></label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="ddlState" runat="server" class="form-control" placeholder="State"></asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">City<span class="starRed">*</span></label>
                                                                        <div class="controls">
                                                                            <asp:DropDownList ID="ddlCity" runat="server" class="form-control" placeholder="State"></asp:DropDownList>
                                                                        </div>
                                                                    </div>
                                                                </div>

                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">Pin Code<span class="starRed">*</span></label>
                                                                        <div class="controls">
                                                                            <asp:TextBox ID="txtPinCode" runat="server" class="form-control" placeholder="Pin Code" MaxLength="6" AutoCompleteType="Disabled"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="col-md-4">
                                                                    <div class="form-group">
                                                                        <label for="projectinput2">Address<span class="starRed">*</span></label>
                                                                        <div class="controls">
                                                                            <asp:TextBox ID="txtNomineeAddres" runat="server" class="form-control" placeholder="Address" TextMode="MultiLine" AutoCompleteType="Disabled"></asp:TextBox>
                                                                        </div>
                                                                    </div>
                                                                </div>


                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                                <h1>Nominee Information</h1>
                                                <hr />
                                                <div class="card-body">
                                                    <div class="form-body">
                                                        <div class="row">
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Nominee Name<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtNomineename" runat="server" class="form-control" placeholder="Nominee Name" AutoCompleteType="Disabled"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Relation With Nominee<span class="starRed"></span></label>
                                                                    <div class="controls">
                                                                        <asp:DropDownList ID="ddlRelationNominee" runat="server" class="form-control" placeholder="State">
                                                                        </asp:DropDownList>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="text-right">
                                                    <button id="btnCustomerPrecious" type="submit" class="btn btn-success">Previous</button>
                                                    <button id="btnCustomerInfo" type="submit" class="btn btn-success"><%--<i class="la la-thumbs-o-up position-right"></i>--%>Next</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%--<div class="tab-pane" id="Payment">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div style="height: 20px">
                                            <center><asp:Label ID="lblmsg5" runat="server" ClientIDMode="Static"></asp:Label></center>
                                        </div>
                                        <div class="card-content collapse show">
                                            <div class="card-body">

                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Payment Method <span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:DropDownList ID="ddlPaymentMethod" runat="server" class="form-control">
                                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                                        <asp:ListItem Value="1">Cash</asp:ListItem>
                                                                        <asp:ListItem Value="2">Cheque</asp:ListItem>
                                                                        <asp:ListItem Value="3">Credit Card</asp:ListItem>
                                                                        <asp:ListItem Value="4">Debit Card</asp:ListItem>
                                                                        <asp:ListItem Value="5">NEFT</asp:ListItem>
                                                                        <asp:ListItem Value="6">IMPS</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Payment Date<span class="starRed"></span></label>
                                                                <div class="controls">
                                                                   
                                                                    <asp:TextBox ID="txtPaymentDate" runat="server" class="form-control" placeholder="dd/mm/yyyy"></asp:TextBox>
                                                                    <asp:CalendarExtender ID="CalendarExtender1" PopupButtonID="txtPaymentDate" runat="server" TargetControlID="txtPaymentDate" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Sold by<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtSoldby" runat="server" class="form-control" placeholder="Sold by "></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Payment amount (Including GST)<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtPaymentamount" runat="server" class="form-control" placeholder="Payment amount "></asp:TextBox>

                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="text-right">
                                                    <button id="btnPaymentPrecious" type="submit" class="btn btn-success">Previous</button>
                                                    <asp:LinkButton ID="btnPaymentMethod" runat="server" type="submit" CssClass="btn btn-success">Next </asp:LinkButton>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>--%>

                        <div class="tab-pane" id="summery">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div style="height: 20px">
                                            <center><asp:Label ID="lblMsgSummary" runat="server" ClientIDMode="Static"></asp:Label></center>
                                        </div>
                                        <div class="card-content collapse show">
                                            <div class="card-body">
                                                <div class="form-body">

                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2"><b>Plan Name :</b></label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:Label ID="lblPlanNameOfPolicy" runat="server"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2"><b>Insured Name :</b></label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:Label ID="lblCustName" runat="server"></asp:Label>
                                                            <asp:Label ID="lblPlanCodeOfPolicy" runat="server" Visible="false"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2"><b>Date Of Birth :</b></label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:Label ID="lblDOB" runat="server"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2"><b>Email Id :</b></label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:Label ID="lblEmailId" runat="server"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2"><b>Contact No :</b></label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:Label ID="lblMobNo" runat="server"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2"><b>Address :</b></label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:Label ID="lblAddr" runat="server"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2"><b>Pin Code :</b></label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:Label ID="lblPinCode" runat="server"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2"><b>Travel Start Date :</b></label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:Label ID="lblSDate" runat="server"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2"><b>Travel End Date :</b></label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <asp:Label ID="lblEdate" runat="server"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2"><b>Price (Inclusive of all taxes) :</b></label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <i class="fa fa-rupee" aria-hidden="true"></i>
                                                            <asp:Label ID="lblPriceSummary" runat="server"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <br />
                                                    <hr />
                                                    <div class="row">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2" style="margin-top: 8px;"><b>Payment Method :</b></label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-8">
                                                            <div class="controls">
                                                                <label class="custom-input">
                                                                    <input type="radio" name="radioPaymentOption" data-attr="Wallet" value="Wallet" id="RdoWallet">
                                                                    <span class="check-radio"></span>
                                                                    <span class="custom-input-label">Wallet</span>
                                                                </label>
                                                                 <label class="custom-input">
                                                                    <input type="radio" name="radioPaymentOption" data-attr="card" value="Card">
                                                                    <span class="check-radio"></span>
                                                                    <span class="custom-input-label">Online Payment</span>
                                                                </label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row Wallet radiopophide hidden">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2"><b>Wallet Balance:</b> </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <i class="fa fa-rupee" aria-hidden="true"></i>
                                                            <asp:Label ID="lblWalletBalace" runat="server"></asp:Label>
                                                        </div>
                                                        <%-- <div id="Div_Walletbtn">
                                                            <button type="submit" class="btn btn-success" formaction="/Admin/WalletRequest.aspx">Add Balance</button>                                                           
                                                        </div>--%>
                                                    </div>


                                                    <%--<div class="row card radiopophide hidden">
                                                        <div class="col-md-1"></div>
                                                        <div class="col-md-3" style="text-align: right">
                                                            <div class="form-group">
                                                                <label for="projectinput2"><b>Total Premium :</b> </label>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <i class="fa fa-rupee" aria-hidden="true"></i>
                                                            <asp:Label ID="lblTotalPremium" runat="server"></asp:Label>
                                                        </div>                                                     
                                                    </div>--%>

                                                </div>

                                                <div class="text-right" id="Div_Summary">
                                                    <button id="btnSumryPrecious" type="submit" class="btn btn-success">Previous</button>
                                                    <asp:LinkButton ID="btnSummery" runat="server" type="submit" CssClass="btn btn-success" OnClick="btnPaymentMethod_Click"><i class="la la-thumbs-o-up position-right"></i> Buy Policy</asp:LinkButton>
                                                 <%-- <asp:LinkButton ID="btnWait" runat="server" type="submit" CssClass="btn btn-success"><i class="la la-thumbs-o-up position-right"></i> Please Wait...</asp:LinkButton>--%>
                                                   <button id="btnWait" type="submit" class="btn btn-success"><i class="la la-thumbs-o-up position-right"></i> Please Wait...</button>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                       <%-- <div class="tab-pane" id="Download-policy">
                            <button class="btn btn-primary dnwld-pdf-btn">Download PDF</button>
                        </div>--%>

                    </div>

                </div>
            </div>

        </div>
    </div>

    <div class="modal dark_bg fade login-form-btn" id="exampleModal9" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="border: 1px solid black;">
                <div class="modal-header" style="border-bottom: 1px solid black;">
                    <h5 class="modal-title"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="window.location.href='BuyPolicy.aspx'">
                        <span aria-hidden="true"><b>x</b></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row ">
                        <div class="col-lg-16 col-md-8">
                            <div class="model-border">
                                <p style="color: green">Plan not available.</p>
                            </div>
                            <div class="col-lg-16 col-md-8" style="text-align: right">
                                <p>
                                </p>


                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg fade login-form-btn" id="MyModel_CheckBalance" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="border: 1px solid black;">
                <div class="modal-header" style="border-bottom: 1px solid black;">
                    <h5 class="modal-title" id="exampleModalLabel1"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="refresh();">
                        <span aria-hidden="true"><b>x</b></span>
                    </button>
                </div>
                <div class="modal-body">
                    <%-- <div class="row ">
                        <div class="col-lg-16">
                            <div class="model-border">--%>
                    <p style="color: red; margin-left: 3%">Insufficient balance in wallet to buy policy.</p>
                    <%--  </div>
                        </div>
                    </div>--%>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg fade login-form-btn" id="MyModel_Age" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="border: 1px solid black;">
                <div class="modal-header" style="border-bottom: 1px solid black;">
                    <h5 class="modal-title" id="exampleModal"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="refresh();">
                        <span aria-hidden="true"><b>x</b></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="row ">
                        <div class="col-lg-16 col-md-8">
                            <div class="model-border">
                                <p style="color: red">Duration limit is exceeding for this plan.Please choose another plan.</p>
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
                    <button type="button" class="close" data-dismiss="modal" id="close" onclick="window.location.href='BuyPolicy.aspx'" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h4>THANK YOU</h4>
                    <p style="color: black; margin-left: 3%">Policy has been issued successfully. </p>
                    <p>Your policy #<b><span id="PolicyNo" runat="server"></span></b> </p>
                    <p runat="server" id="P_TrxId">Your Transaction ID #<b><span id="trxId" runat="server"></span></b> </p>
                    <%--   <button id="btnPolicyDownload" class="btn btn-success" data-dismiss="modal" ><span>Download Policy Certificate</span></button>--%>
                    <button type="submit" runat="server" id="btnPolicyDownload" class="btn btn-success" data-dismiss="modal" onserverclick="btnPolicyDownload_ServerClick"><span>Download Policy Certificate</span></button>
                </div>
            </div>
        </div>
    </div>

    <div id="MyModel_PaymentFail" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="window.location.href='BuyPolicy.aspx'">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h3>Failed !</h3>
                    <p style="color: black; margin-left: 3%">Your payment has been Failed. Your transaction id: <asp:Label ID="lblorderid" runat="server" ForeColor="Red"></asp:Label></p>
                   
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg fade login-form-btn" id="MyModal_Benifits" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="border: 1px solid black; width: 582px;">
                <div class="modal-header" style="border-bottom: 1px solid black;">
                    <h5 class="modal-title"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="refresh();">
                        <span aria-hidden="true"><b>x</b></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="card-body" id="BD" runat="server">
                        <h1>Benifits Details</h1>
                        <div class="form-body">
                            <asp:GridView ID="GV_Benifits" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" 
                                PagerStyle-CssClass="bs-pagination">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Benifit Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBenifit_Name" runat="server" Text='<%#Bind("Benifit_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="SumInsured">
                                        <ItemTemplate>
                                            <asp:Label ID="lblSumInsured" runat="server" Text='<%#Bind("SumInsured") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Deductible">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDeductible" runat="server" Text='<%#Bind("Deductible") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <EmptyDataTemplate><b style="color: red">No Record Available</b></EmptyDataTemplate>
                            </asp:GridView>
                        </div>
                    </div>

                    <div class="card-body" id="VAS" runat="server">
                        <h1>Value added services</h1>

                        <div class="form-body">
                            <asp:GridView ID="GV_vas" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" 
                                PagerStyle-CssClass="bs-pagination">
                                <Columns>
                                    <asp:TemplateField HeaderText="Sr.No.">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="VAS Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblVASName" runat="server" Text='<%#Bind("VAS_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Price">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPrice" runat="server" Text='<%#Bind("Price") %>'></asp:Label>
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


    <div class="modal dark_bg fade login-form-btn" id="MyModal_Persons" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="border: 1px solid black; width: 1190px; margin-left: -327px;">
                <div class="modal-header" style="border-bottom: 1px solid black;">
                    <h5 class="modal-title">Customer Details</h5>
                    <button type="button" class="close" data-dismiss="modal" id="Close" aria-label="Close" onclick="refresh();">
                        <span aria-hidden="true"><b>x</b></span>
                    </button>
                </div>
                <div class="modal-body">
                    <center><asp:Label ID="lblCustMessage" runat="server"></asp:Label></center>
                    <div class="table-responsive" id="geodiv">
                        <table class="table table-de mb-0" id="maintable">
                            <thead>
                            </thead>
                            <tbody id="maindiv" runat="server">
                                <tr>
                                    <td><b>Sr. No.</b></td>
                                    <td><b>Name</b></td>
                                    <td><b>Passport No</b></td>
                                    <td><b>Mobile No</b></td>
                                    <td><b>Email Id</b></td>
                                    <td><b>Gender</b></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <br />
                    <div class="text-right">
                        <button type="button" class="btn btn-success" id="btnNoOfPersonsSave" data-dismiss="modal" aria-hidden="true"><i class="la la-thumbs-o-up position-right"></i>Submit </button>
                        <%-- <asp:LinkButton ID="btnNoOfPersonsSave" runat="server" type="submit" CssClass="btn btn-success"><i class="la la-thumbs-o-up position-right"></i>Submit</asp:LinkButton>--%>
                        <button type="button" class="btn btn-success" id="close1" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">Close</span> </button>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

