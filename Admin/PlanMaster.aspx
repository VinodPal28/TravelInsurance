<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="PlanMaster.aspx.cs" Inherits="Admin_PlanMaster" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/jquery-1.10.2.min.js"></script>

    <%--<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>--%>
    <script src="../Assets/js/jquery.min.js"></script>
    <script src="../Assets/js/Valid.js"></script>
    <%--Start Multiselection script--%>


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
                placeholder: 'Select fixed benefits',
                search: true,
                searchOptions: {
                    'default': 'Search fixed benefits'
                },
                selectAll: true
            });
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

    <%--End Multiselection script--%>
    <%--======================================================================--%>

    <%--Start Plan Benifits script--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.custom-input').find('input[type="radio"]').click(function () {
                if ($(this).is(':checked')) {
                    $('.radiopophide').addClass('hidden');
                    $(this).addClass('ashish');
                    $('.' + $(this).attr('data-attr')).removeClass('hidden')
                    //alert($(this).attr('data-attr'));
                }
            });


            <%--Start textbox validation for fixed/opt benefits script--%>
            $("#btnBenefitsSlab").click(function (e) {
                var TextCountForfixedBenifits = document.getElementById('dvTable').getElementsByTagName('input').length;
                var TextCountForOptBenifits = document.getElementById('TableOptBenefits').getElementsByTagName('input').length;
                var valid = true;
                var i = 0;
                var j = 0;
                $('#dvTable').find(":text").each(function () {

                    i++;
                    $("input:text,textarea").keypress(function () {
                        $('#lblmsg3').text("");
                    });
                    //$('#txtFixedBenefits' + i).bind('keyup', function (e) {
                    //    if (this.value.match(/[^0-9]/g)) {
                    //        this.value = this.value.replace(/[^0-9]/g, '');
                    //    }
                    //});

                    if (this.value == "") {
                        $("#lblmsg3").text("*Enter a value").css("color", "red");
                        $(this).focus();
                        valid = false;
                    }
                    //else if (this.value != "" && this.value <= 0) {
                    //    $("#lblMsg4").text("*Value can not be zero.").css("color", "red");
                    //    $(this).focus();
                    //    valid = false;
                    //}
                    //if ($('#txtFixedBenefits' + i).val() == "") {
                    //    $("#lblmsg3").text("*Enter the Amount").css("color", "red");
                    //    $('#txtFixedBenefits' + i).focus();
                    //    valid = false;
                    //}

                    //else if ($('#txtFixedBenefits' + i).val() <= 0) {
                    //    $("#lblmsg3").text("*Amount must be greater than zero.").css("color", "red");
                    //    $('#txtFixedBenefits' + i).focus();
                    //    valid = false;
                    //}


                });
                $('#TableOptBenefits').find(":text").each(function () {
                    j++;
                    $("input:text,textarea").keypress(function () {
                        $('#lblmsg3').text("");

                    });
                    if (this.value == "") {
                        $("#lblmsg3").text("*Enter a value").css("color", "red");
                        $(this).focus();
                        valid = false;
                    }
                    //$('#txtOptBenefits' + j).bind('keyup', function (e) {
                    //    if (this.value.match(/[^0-9]/g)) {
                    //        this.value = this.value.replace(/[^0-9]/g, '');
                    //    }
                    //});

                    //if ($('#txtOptBenefits' + j).val() == "") {
                    //    $("#lblmsg3").text("*Enter the Amount").css("color", "red");
                    //    $('#txtOptBenefits' + j).focus();
                    //    valid = false;
                    //}

                    //else if ($('#txtOptBenefits' + j).val() <= 0) {
                    //    $("#lblmsg3").text("*Amount must be greater than zero.").css("color", "red");
                    //    $('#txtOptBenefits' + j).focus();
                    //    valid = false;
                    //}


                });
                if (valid == true) {
                    SavePlanBenefits();
                    //$('#tabs a[href="#plan-Pricing"]').tab('show');
                    //$('#PB').removeClass("active");
                    //$('#PP').addClass("active");
                }
                e.preventDefault();

                return false;

            });
            <%--End textbox validation for fixed/opt benefits script--%>
        });

         <%--Start Get data in JSON script--%>
        function getdate() {
            var Text_CountForfixedBenifits = document.getElementById('dvTable').getElementsByTagName('input').length;
            var Text_CountForOptBenifits = document.getElementById('TableOptBenefits').getElementsByTagName('input').length
            var TextCountForfixedBenifits = (Text_CountForfixedBenifits / 3);
            var TextCountForOptBenifits = (Text_CountForOptBenifits / 3);

            var data = [];
            for (var i = 1; i <= TextCountForfixedBenifits; i++) {
                var Fixed = 'Fixed';
                var Plan_Code = $('#txtPlancode').val();
                var Benifit_Name = $('#txtFixedBenefit' + i).val();
                var Sum_Insured = $('#txtFixedBenefits' + i).val();
                var DeductibleFixed = $('#txtDeductibleFixed' + i).val();
                var alldata = {
                    'PlanCode': Plan_Code,
                    'BenifitName': Benifit_Name.replace(/\&/g, '~'),
                    'BenifitType': Fixed,
                    'SumInsured': Sum_Insured.replace(/\&/g, '~'),
                    'Deductible': DeductibleFixed.replace(/\&/g, '~')
                }
                data.push(alldata);
            }
            if (TextCountForOptBenifits > 0) {
                for (var i = 1; i <= TextCountForOptBenifits; i++) {
                    var Plan_Code = $('#txtPlancode').val();
                    var Benifit_Name = $('#txtOptBenefit' + i).val();
                    var Sum_Insured = $('#txtOptBenefits' + i).val();
                    var DeductibleOpt = $('#txtDeductibleOpt' + i).val();
                    var alldata = {
                        'PlanCode': Plan_Code,
                        'BenifitName': Benifit_Name.replace(/\&/g, '~'),
                        'BenifitType': 'Optional',
                        'SumInsured': Sum_Insured.replace(/\&/g, '~'),
                        'Deductible': DeductibleOpt.replace(/\&/g, '~')
                    }
                    data.push(alldata);
                }
            }
            return data;
        }
        <%--End Get data in JSON script--%> 

        <%--Start Ajax for saving data--%>
        function SavePlanBenefits() {
            var dt = JSON.stringify(getdate());//"hi";
            //alert(dt);
            $.ajax({
                //url: "PlanMaster.aspx?Action=SaveData&lb=" + encodeURIComponent(data),
                //url: "PlanMaster.aspx/SaveData",
                url: '<%= ResolveUrl("PlanMaster.aspx/SaveData") %>',
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                //data: JSON.stringify({ 'PlanBenifits': getdate() }),
                data: '{PlanBenifits:' + JSON.stringify(dt) + '}',
                success: function (response) {
                    if (response.d != '') {
                        if (response.d.toString() == 'F') {
                            $('#tabs a[href="#plan-Pricing"]').tab('show');
                            $('#PB').removeClass("active");
                            $('#PP').addClass("active");
                        }
                    }
                },
                error: function () {
                    alert("Error while inserting data");
                }
            });
        }
        <%--End Ajax for saving data--%>
    </script>
    <%--End Plan Benifits script--%>
    <%--======================================================================--%>

    <%--Start Plan Details script--%>
    <script type="text/javascript">
        $(document).ready(function () {
            $('.data-Geo').hide();
            $('.data-Geod').hide();
            $('#txtmintripDuration').bind('keyup', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });
            $('#txtmaxDuration').bind('keyup', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });
            $('#txtMinAge').bind('keyup', function (e) {
                if (this.value.match(/[^0-9.]/g)) {
                    this.value = this.value.replace(/[^0-9.]/g, '');
                }
            });
            $('#txtMaxAge').bind('keyup', function (e) {
                if (this.value.match(/[^0-9.]/g)) {
                    this.value = this.value.replace(/[^0-9.]/g, '');
                }
            });
            $('#txtPlanname').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9%()-.$#&!@ ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9%()-.$#&!@', ]/g, '');
                }
            });
            $('#txtPlancode').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
                }
            });
            $("#btnPlanDetails").click(function (e) {
                var InsurerProvider = $("#<%= ddlInsurerProvider.ClientID %>").val();
                var Planname = $("#<%= txtPlanname.ClientID %>").val();
                var Plancode = $("#<%= txtPlancode.ClientID %>").val();
                var Valueaddedservices = $("#<%=ddlValueaddedservices.ClientID%>").val();
                var MinAge = $("#<%=txtMinAge.ClientID%>").val();
                var MaxAge = $("#<%=txtMaxAge.ClientID%>").val();
                var mintripDuration = $("#<%= txtmintripDuration.ClientID %>").val();
                var maxDuration = $("#<%= txtmaxDuration.ClientID %>").val();
                var TemandCodition = $("#<%=ddlTemandCodition.ClientID%> option:selected").text();
                //var upload = $("#fileUpload1").val();

                var allowedFiles = [".doc", ".docx", ".pdf"];
                var fileUpload = document.getElementById("fileUpload1");
                var regex = new RegExp("([a-zA-Z0-9\s_\\.\-:])+(" + allowedFiles.join('|') + ")$");

                if (InsurerProvider == "0") {
                    $("#MsgPlanDetails").text("*Select the Insurance Provider").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (Plancode == "") {
                    $("#MsgPlanDetails").text("*Enter a Plan Code").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (Plancode.length != 3) {
                    $("#MsgPlanDetails").text("*Plan code should not be less than 3 digits").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (Planname == "") {
                    $("#MsgPlanDetails").text("*Enter a Plan Name").css("color", "red");
                    e.preventDefault();
                    return false;
                }
              <%--  else if ($("#<%= txtPlancode.ClientID %>").val().length < 17) {
                        $("#MsgPlanDetails").text("*Length should be 17 alpha numeric of Plan Code.").css("color", "red");
                        e.preventDefault();
                        return false;
                    }--%>
                else if (Valueaddedservices == "0" || Valueaddedservices == null) {
                    $("#MsgPlanDetails").text("*Select the Value added services").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (MinAge == "") {
                    $("#MsgPlanDetails").text("*Enter the Min Age").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (MinAge <= 0) {
                    $("#MsgPlanDetails").text("*Min age must be greater than zero.").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (MinAge > 100) {
                    $("#MsgPlanDetails").text("*Min age not more than 100 Yrs.").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (MaxAge == "") {
                    $("#MsgPlanDetails").text("*Enter the Max Age").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (MaxAge <= 0) {
                    $("#MsgPlanDetails").text("*Max age must be greater than zero.").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (MaxAge > 100) {
                    $("#MsgPlanDetails").text("*max age not more than 100 Yrs.").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (parseInt(MaxAge) < parseInt(MinAge)) {
                    $("#MsgPlanDetails").text("*Max age must be greater than min age.").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (mintripDuration == "") {
                    $("#MsgPlanDetails").text("*Enter a min trip Duration").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (mintripDuration <= 0) {
                    $("#MsgPlanDetails").text("*Min trip Duration must be greater than zero.").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (maxDuration == "") {
                    $("#MsgPlanDetails").text("*Enter a max trip Duration").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (maxDuration <= 0) {
                    $("#MsgPlanDetails").text("*Max trip Duration must be greater than zero.").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (parseInt(maxDuration) < parseInt(mintripDuration)) {
                    $("#MsgPlanDetails").text("*Max trip duration must be greater than min trip duration.").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if ($('input[name=radioFoo]:checked').length <= 0) {
                    $("#MsgPlanDetails").text("*Select valid for").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if ($('input[name=radioFoo2]:checked').length <= 0) {
                    $("#MsgPlanDetails").text("*Select Travel Type").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (TemandCodition == '--Select--') {
                    $("#MsgPlanDetails").text("*Select Terms and Condition Document").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else {
                    $("#MsgPlanDetails").text("");
                }
                SavePlanDetails();
                e.preventDefault();
                $('#tabs a[href="#plan-Benefits"]').tab('show');
                if ($("input[name='radioFoo2']:checked").val() == 'International') {
                    $('.data-Geo').show();
                    $('.data-Geod').hide();
                }

                else if ($("input[name='radioFoo2']:checked").val() == 'Domestic') {
                    $('.data-Geo').hide();
                    $('.data-Geod').show();
                }
                $('#PD').removeClass("active");
                $('#PB').addClass("active");
                return false;
            });
        });

function SavePlanDetails() {
    var plandata = JSON.stringify(getPlanDetails());
    //alert(plandata);
    //alert("Hi");
    $.ajax({
        //url: "PlanMaster.aspx?Action=SavePlanDetails&PD=" + encodeURIComponent(data),
        url: '<%= ResolveUrl("PlanMaster.aspx/SavePlanData") %>',
        type: 'POST',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        data: '{PlanDetails:' + JSON.stringify(plandata) + '}',
        success: function (response) {
            if (response.d != '') {
                if (response.d.toString() == 'F') {

                }
            }
        },
        error: function () {
            alert("Error while inserting data");
        }
    });
}

function getPlanDetails() {
    var data = [];
    var SelectedVAS = ($.map($("select[id*=ddlValueaddedservices] option:selected"), function (item, i) { return $(item).text() })).join(",");
    var InsurerProvider = $("#<%= ddlInsurerProvider.ClientID %> option:selected").val();
    var PlanName = $('#txtPlanname').val();
    var PlanCode = $('#txtPlancode').val();
    var MinAge = $('#txtMinAge').val();
    var MaxAge = $('#txtMaxAge').val();
    var MinTrip = $('#txtmintripDuration').val();
    var MaxTrip = $('#txtmaxDuration').val();
    var ValidFor = $("input[name='radioFoo']:checked").val();
    var Traveltype = $("input[name='radioFoo2']:checked").val();
    var TandC = $('#ddlTemandCodition').val();
    //var filePath = files;

    var alldata = {
        'InsurerProvider': InsurerProvider,
        'PlanName': PlanName.replace(/\&/g, '~'),
        'PlanCode': PlanCode,
        'VAS': SelectedVAS,
        'MinAge': MinAge,
        'MaxAge': MaxAge,
        'MinTripDur': MinTrip,
        'MaxTripDur': MaxTrip,
        'ValidFor': ValidFor,
        'Traveltype': Traveltype,
        'TandC': TandC.replace(/\&/g, '~')
        // 'FileUpload': formData
    }
    data.push(alldata);
    return data;
}
    </script>
    <%--End Plan Details script--%>

    <script type="text/javascript">
        function CheckPlanCode() {
            $.ajax({
                url: "PlanMaster.aspx/Page_Load",
                data: {
                    method: "CheckPlanCode",
                    PlanCode: $("#txtPlancode").val()
                },
                success: function (msg) {
                    if (msg != '') {
                        if (msg.toString() == 'F') {
                            $('#lblMessage').text('Plan code ' + $("#txtPlancode").val() + ' already exist').css("color", "Red");
                            $('#txtPlancode').val("");
                        }
                        if (msg.toString() == 'NF') {
                            $('#lblMessage').text('');
                        }
                    }
                }
            });
        }
        function OnSuccess(response) {
            alert(response.d);
        }
    </script>

    <%--Start Plan price script--%>
    <script type="text/javascript">

        //Function for getting geo age data in json format
        function GetgeoageData(row, option) {
            var data = [];
            if (option == 'DayAgeGeo') {
                //alert(row);
                var geocnt = parseInt($("#HdnGeoCnt").val());
                if ($("input[name='radioFoo2']:checked").val() == 'Domestic') {
                    geocnt = 1;
                }
                //var ageslabcnt = parseInt($("#HdnAgeSlabCnt").val());
                var ageslabcnt = parseInt($("#txtNoOfAge").val());
                //var agepricecnt = (geocnt * ageslabcnt);          
                var i = 0;
                var dcnt = 1;
                var agetxtid = 0;
                //alert(geocnt);
                for (var pricerow = 1; pricerow <= parseInt(row) ; pricerow++) {
                    agetxtid = 0;
                    for (var geo = 1; geo <= parseInt(geocnt); geo++) {
                        for (var ageprice = 1; ageprice <= parseInt(ageslabcnt); ageprice++) {
                            agetxtid++;
                            //alert(agetxtid);
                            var AgSlab = $('#txtAgeSlab' + agetxtid).val();
                            if (AgSlab == '') {
                                i++;
                                continue;
                            }
                            var Geo = '';
                            i++;
                            var PlnCode = $('#txtPlancode').val();
                            if ($("input[name='radioFoo2']:checked").val() == 'Domestic') {
                                Geo = $('#lblGeod').text();
                            }
                            else {
                                Geo = $('#lblGeo' + geo).text();
                            }
                            //var Geo = $('#lblGeo' + geo).text();
                            //var AgSlab = $('#txtAgeSlab' + ageprice).val();
                            var Mind = $('#txtDaySlab' + dcnt).val();
                            var Maxd = $('#txtDaySlab' + (dcnt + 1)).val();
                            var Pr = $('#txtPrice' + i).val();
                            var alldata = {
                                'PlanCode': PlnCode,
                                'GeoName': Geo,
                                'AgeSlab': AgSlab,
                                'MinDay': Mind,
                                'MaxDay': Maxd,
                                'Price': Pr
                            }
                            data.push(alldata);
                        }
                    }
                    //data.push(alldata);
                    dcnt = dcnt + 2;
                }
            }
            else if (option == 'PerDay') {
                var PlnCode = $('#txtPlancode').val();
                var Pr = $('#txtPerdayprice').val();
                var travel = $('#txtPerdaytraveller').val();
                var alldata = {
                    'PlanCode': PlnCode,
                    'Price': Pr,
                    'Traveller': travel
                }
                data.push(alldata);
            }
            else if (option == 'MICE') {
                var PlnCode = $('#txtPlancode').val();
                var Pr = $('#txtMICEprice').val();
                var travel = $('#txttraveller').val();
                //var mandays = $('#txtmandays').val();
                var alldata = {
                    'PlanCode': PlnCode,
                    'Price': Pr,
                    'Traveller': travel
                    //'ManDays': mandays
                }
                data.push(alldata);
            }
            return data;
        }
        //Function for saving geo age data using ajax/json
        function SaveGeoDetails(rowcnt, option) {
            var geodata = JSON.stringify(GetgeoageData(rowcnt, option));
            //var geodata = GetgeoageData(rowcnt, option);
            //alert(geodata);
            if (option == 'DayAgeGeo') {
                $.ajax({
                    //url: "PlanMaster.aspx?Action=SaveGeoData&option=" + option + "&lb=" + geodata,
                    url: '<%= ResolveUrl("PlanMaster.aspx/SaveGeoData") %>',
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: '{geoagedetails:' + JSON.stringify(geodata) + '}',
                    success: function (response) {
                        if (response.d == 'true') {
                            window.location.href = "../Admin/PlanMsg.aspx";
                        }
                    },
                    error: function () {
                        //alert("Error while inserting data");
                        $("#lblMsg4").text("Error while inserting data").css("color", "red");
                    }

                });
            }
            else if (option == 'PerDay') {
                $.ajax({
                    //url: "PlanMaster.aspx?Action=SaveGeoData&option=" + option + "&lb=" + geodata,
                    url: '<%= ResolveUrl("PlanMaster.aspx/SavePerDay") %>',
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: '{geoagedetails:' + JSON.stringify(geodata) + '}',
                    success: function (response) {
                        if (response.d == 'true') {
                            window.location.href = "../Admin/PlanMsg.aspx";
                        }
                    },
                    error: function () {
                        //alert("Error while inserting data");
                        $("#lblMsg4").text("Error while inserting data").css("color", "red");
                    }

                });
            }
            else {
                $.ajax({
                    //url: "PlanMaster.aspx?Action=SaveGeoData&option=" + option + "&lb=" + geodata,
                    url: '<%= ResolveUrl("PlanMaster.aspx/SaveMICE") %>',
                    type: 'POST',
                    dataType: 'json',
                    contentType: 'application/json; charset=utf-8',
                    data: '{geoagedetails:' + JSON.stringify(geodata) + '}',
                    success: function (response) {
                        if (response.d == 'true') {
                            window.location.href = "../Admin/PlanMsg.aspx";
                        }
                    },
                    error: function () {
                        //alert("Error while inserting data");
                        $("#lblMsg4").text("Error while inserting data").css("color", "red");
                    }

                });
            }
        }

        $(document).ready(function () {
            $('#TableOptBenefits').hide();
            $('.benifit').on('input', function (event) {
                this.value = this.value.replace(/[^a-zA-Z0-9%()-.$#&!@', ]/g, '');
            });
            $("#btnOpt").show();
            $('#reMove').hide();
            $("#addMore").hide();
            $('#txtNoOfAge').show();
            $("#btnnoOfAge").show();
            $('#txtNoOfAge').numeric();
            $('#txtPerdayprice').numeric();
            $('#txttraveller').numeric();
            //$('#txtmandays').numeric();
            $('#txtMICEprice').numeric();
            //Global variables////used for generate dynamic control and saving it's value
            var ageslabid = parseInt($("#AgeSlabIdCnt").val());
            //alert(ageslabid);
            var dayslabcnt = 3;
            var rowcount = 1;
            var id = 1;
            var id1 = 1;
            $('#maintable').find(":text").each(function () {
                $("input:text,textarea").keypress(function () {
                    $('#lblMsg4').text("");
                });
                //$(this).bind('keyup', function (e) {
                //    if (this.value.match(/[^0-9]/g)) {
                //        this.value = this.value.replace(/[^0-9]/g, '');
                //    }
                //});
                $('.price').on('input', function (event) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                });
                $('.dayslab').on('input', function (event) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                });
                $('.ageslab').on('input', function (event) {
                    this.value = this.value.replace(/[^0-9-.]/g, '');
                });
            });

            //**Start**--Submit Geo-Age-Slab details////Done by Manish on 24-May-2018
            $("#btnSubmit").click(function (e) {

                var priceopt = $("input[name='radioFoo1']:checked").val();
                //var geocnt = parseInt($("#HdnGeoCnt").val());
                //var ageslabcnt = parseInt($("#HdnAgeSlabCnt").val());
                var ageslabcnt = parseInt($("#txtNoOfAge").val());
                //var agepricecnt = (geocnt * ageslabcnt);

                var valid = true;
                if ($('input[name=radioFoo1]:checked').length <= 0) {
                    $("#lblMsg4").text("*Select the Duration basis").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else {
                    var priceopt = $("input[name='radioFoo1']:checked").val();

                    if (priceopt == 'DayAgeGeo') {
                        var i = 0;
                        $('#maintable').find(":text").each(function () {
                            //i++;
                            //alert(i);
                            $("input:text,textarea").keypress(function () {
                                $('#lblMsg4').text("");
                            });
                            //$(this).bind('keyup', function (e) {
                            //    if (this.value.match(/[^0-9]/g)) {
                            //        this.value = this.value.replace(/[^0-9]/g, '');
                            //    }
                            //});
                            $('.price').on('input', function (event) {
                                this.value = this.value.replace(/[^0-9]/g, '');
                            });
                            $('.dayslab').on('input', function (event) {
                                this.value = this.value.replace(/[^0-9]/g, '');
                            });
                            $('.ageslab').on('input', function (event) {
                                this.value = this.value.replace(/[^0-9-.]/g, '');
                            });
                            //if (this.value == "") {
                            //    $("#lblMsg4").text("*Enter a value").css("color", "red");
                            //    $(this).focus();
                            //    valid = false;
                            //}
                            if (this.value != "" && this.value <= 0) {
                                $("#lblMsg4").text("*Value can not be zero.").css("color", "red");
                                $(this).focus();
                                valid = false;
                            }
                            //var ageslab = $('#txtAgeSlab' + i).val();
                            //var dayslab = $('#txtDaySlab' + i).val();
                            //var price = $('#txtPrice' + i).val();
                            //if (ageslab == "") {
                            //    $("#lblMsg4").text("*Enter age slab").css("color", "red");
                            //    $('#txtAgeSlab' + i).focus();
                            //    valid = false;
                            //}
                            //else if (ageslab.substring(0, 1) == '-' || ageslab.substring(0, 1) == '.' || ageslab.substring((ageslab.length - 1)) == '-' || ageslab.substring((ageslab.length - 1)) == '.')
                            //{
                            //    $("#lblMsg4").text("*Enter a valid age slab value, Ex: 1-10, 21-30").css("color", "red");
                            //    $('#txtAgeSlab' + i).focus();
                            //    valid = false;
                            //}
                            //    else if (ageslab.indexOf('-')<=0) {
                            //        $("#lblMsg4").text("*Enter a valid age slab value, Ex: 1-10, 21-30").css("color", "red");
                            //        $('#txtAgeSlab' + i).focus();
                            //        valid = false;
                            //    }
                            //    else if (ageslab!='' && i != 1 && i % 2 == 0) {
                            //        var arrage = ageslab.split('-');
                            //        var arrpreage = $('#txtAgeSlab' + (i - 1)).val().split('-');
                            //        if (arrage[0] <= arrpreage[1]) {
                            //            $("#lblMsg4").text("*Age slab min value should be greater than previous age slab's max value").css("color", "red");
                            //            $('#txtAgeSlab' + i).focus();
                            //            valid = false;
                            //        }
                            //    }
                            //    else if (dayslab == "") {
                            //        $("#lblMsg4").text("*Enter day slab").css("color", "red");
                            //        $('#txtDaySlab' + i).focus();
                            //        valid = false;
                            //    }
                            //else if (dayslab <= 0) {
                            //        $("#lblMsg4").text("*Day slab can not be 0").css("color", "red");
                            //        $('#txtDaySlab' + i).focus();
                            //        valid = false;
                            //    }
                            //    else if (price == "") {
                            //        $("#lblMsg4").text("*Enter Price").css("color", "red");
                            //        $('#txtPrice' + i).focus();
                            //        valid = false;
                            //    }

                            //    else if (price <= 0) {
                            //        $("#lblMsg4").text("*Price can not be 0").css("color", "red");
                            //        $('#txtDaySlab' + i).focus();
                            //        valid = false;
                            //    }
                        });
                    }
                    else if (priceopt == 'PerDay') {
                        if ($('#txtPerdaytraveller').val() == '') {
                            $("#lblMsg4").text("*Enter No. of Traveller").css("color", "red");
                            $('#txtPerdaytraveller').focus();
                            valid = false;
                            e.preventDefault();
                            return false;
                        }
                        else if ($('#txtPerdaytraveller').val() != '' && parseInt($('#txtPerdaytraveller').val(), 10) == 0) {
                            $("#lblMsg4").text("*No. of Traveller cannot be 0").css("color", "red");
                            $('#txtPerdaytraveller').focus();
                            valid = false;
                            e.preventDefault();
                            return false;
                        }
                        else if ($('#txtPerdayprice').val() == '') {
                            $("#lblMsg4").text("*Enter Price").css("color", "red");
                            $('#txtPerdayprice').focus();
                            valid = false;
                            e.preventDefault();
                            return false;
                        }
                        else if ($('#txtPerdayprice').val() != '' && parseInt($('#txtPerdayprice').val(), 10) == 0) {
                            $("#lblMsg4").text("*Price cannot be 0").css("color", "red");
                            $('#txtPerdayprice').focus();
                            valid = false;
                            e.preventDefault();
                            return false;
                        }
                    }
                    else if (priceopt == 'MICE') {
                        $('#txtMICEprice').numeric();
                        if ($('#txttraveller').val() == '') {
                            $("#lblMsg4").text("*Enter No. of Traveller").css("color", "red");
                            $('#txttraveller').focus();
                            valid = false;
                            e.preventDefault();
                            return false;
                        }
                        else if ($('#txttraveller').val() != '' && parseInt($('#txttraveller').val(), 10) == 0) {
                            $("#lblMsg4").text("*No. of Traveller cannot be 0").css("color", "red");
                            $('#txttraveller').focus();
                            valid = false;
                            e.preventDefault();
                            return false;
                        }
                            //else if ($('#txtmandays').val() == '') {
                            //    $("#lblMsg4").text("*Enter No. of Man Days").css("color", "red");
                            //    $('#txtmandays').focus();
                            //    valid = false;
                            //    e.preventDefault();
                            //    return false;
                            //}
                            //else if ($('#txtmandays').val() != '' && parseInt($('#txtmandays').val(), 10) == 0) {
                            //    $("#lblMsg4").text("*No. of Man Days cannot be 0").css("color", "red");
                            //    $('#txtmandays').focus();
                            //    valid = false;
                            //    e.preventDefault();
                            //    return false;
                            //}
                        else if ($('#txtMICEprice').val() == '') {
                            $("#lblMsg4").text("*Enter Price").css("color", "red");
                            $('#txtMICEprice').focus();
                            valid = false;
                            e.preventDefault();
                            return false;
                        }
                        else if ($('#txtMICEprice').val() != '' && parseInt($('#txtMICEprice').val(), 10) == 0) {
                            $("#lblMsg4").text("*Price cannot be 0").css("color", "red");
                            $('#txtMICEprice').focus();
                            valid = false;
                            e.preventDefault();
                            return false;
                        }
                    }
                    if (valid == true) {
                        $("#lblMsg4").text('');
                        SaveGeoDetails(rowcount, priceopt);
                    }
                }
                e.preventDefault();
                return false;
            });
            //**End**--Submit Geo-Age-Slab details

            //**Start**--Add more controls for Geo-Age-Slab price////Done by Manish on 24-May-2018
            $("#addMore").click(function (e) {
                //alert(ageslabid);
                var geocnt = parseInt($("#HdnGeoCnt").val());
                //var ageslabcnt = parseInt($("#HdnAgeSlabCnt").val());
                if ($("input[name='radioFoo2']:checked").val() == 'Domestic') {
                    geocnt = 1;
                }
                var pricetr = '<tr class="data-Price">';
                pricetr = pricetr + '<td ><input type="text" maxlength="3" id="txtDaySlab' + dayslabcnt + '" class="dayslab" style="width: 40px;"> &nbsp;<input type="text" maxlength="3" required="" data-validation-required-message="This field is required" id="txtDaySlab' + (dayslabcnt + 1) + '" class="dayslab" style="width: 40px;"></td>';
                dayslabcnt = dayslabcnt + 2;
                while (geocnt > 0) {
                    //var ageslabcnt = parseInt($("#HdnAgeSlabCnt").val());
                    var ageslabcnt = parseInt($("#txtNoOfAge").val());
                    pricetr = pricetr + '<td>';
                    while (ageslabcnt > 0) {
                        ageslabid++;
                        pricetr = pricetr + '<input type="text" maxlength="10" id="txtPrice' + ageslabid + '" placeholder="Price" class="price" style="width: 60px;">&nbsp;&nbsp;';
                        ageslabcnt--;
                    }
                    pricetr = pricetr + '</td>';
                    geocnt--;
                }
                pricetr = pricetr + '</tr>';
                $('#maindiv').append(pricetr);
                rowcount++;
                $('#maintable').find(":text").each(function () {
                    $("input:text,textarea").keypress(function () {
                        $('#lblMsg4').text("");
                    });
                    //$(this).bind('keyup', function (e) {
                    //    if (this.value.match(/[^0-9]/g)) {
                    //        this.value = this.value.replace(/[^0-9]/g, '');
                    //    }
                    //});
                    $('.price').on('input', function (event) {
                        this.value = this.value.replace(/[^0-9]/g, '');
                    });
                    $('.dayslab').on('input', function (event) {
                        this.value = this.value.replace(/[^0-9]/g, '');
                    });
                    $('.ageslab').on('input', function (event) {
                        this.value = this.value.replace(/[^0-9-.]/g, '');
                    });
                });
                e.preventDefault();
                return false;
            });
            //**End**--Add more controls for Geo-Age-Slab price

            $('#reMove').click(function () {
                if ($('#maintable tr').length > 2) {
                    $('#maintable tr:last').remove();
                    var geocnt = parseInt($("#HdnGeoCnt").val());
                    var ageslabcnt = parseInt($("#txtNoOfAge").val());
                    ageslabid = ageslabid - (geocnt * ageslabcnt);
                    dayslabcnt = dayslabcnt - 2;
                    //alert(ageslabid);
                    //alert(dayslabcnt);
                    rowcount--;
                }
                if ($('#maintable tr').length == 2) {
                    $('#reMove').hide();
                    $("#addMore").hide();
                    $('#txtNoOfAge').show();
                    $("#btnnoOfAge").show();
                }
            });

            $('#reMoveFB').click(function () {
                if ($('#maintableFB tr').length > 2) {
                    $('#maintableFB tr:last').remove();
                    id--;
                }
                //if ($('#maintableFB tr').length == 2) {
                //    $('#TableOptBenefits').show();

                //}
            });

            $('#reMoveOB').click(function () {
                if ($('#maintableOB tr').length > 1) {
                    $('#maintableOB tr:last').remove();
                    id1--;
                }
                if ($('#maintableOB tr').length == 1) {
                    $('#TableOptBenefits').hide();
                    $("#btnOpt").show();
                }
            });
            //**Start**--No of Age slab addition////Done by Manish on 20-Jun-2018
            $("#btnnoOfAge").click(function (e) {
                var noofage = $("#txtNoOfAge").val();
                if (noofage == "") {
                    $("#lblMsg4").text("*Enter No of age slab to add").css("color", "red");
                    $("#txtNoOfAge").focus();
                    e.preventDefault();
                    return false;
                }
                else if (noofage <= 0) {
                    $("#lblMsg4").text("*No of age slab must be greater than 0").css("color", "red");
                    $("#txtNoOfAge").focus();
                    e.preventDefault();
                    return false;
                }
                else if (noofage > 5) {
                    $("#lblMsg4").text("*No of age slab cannot be greater than 5").css("color", "red");
                    $("#txtNoOfAge").focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $("#lblMsg4").text("");
                    var geocnt = parseInt($("#HdnGeoCnt").val());
                    var agecnt = parseInt($("#txtNoOfAge").val());
                    if ($("input[name='radioFoo2']:checked").val() == 'Domestic') {
                        geocnt = 1;
                    }
                    var j = 0;
                    var pricetr = "<tr class='data-dayslab'>";
                    pricetr = pricetr + "<td><strong>Day/Age Slab</strong></td>";
                    while (geocnt > 0) {
                        pricetr = pricetr + '<td>';
                        for (var i = 1; i <= agecnt; i++) {
                            j++;
                            pricetr = pricetr + "<input type='text' maxlength='6' id='txtAgeSlab" + j + "' class='ageslab' style='width: 60px;'>&nbsp;&nbsp;";
                        }
                        pricetr = pricetr + '</td>';
                        geocnt--;
                    }
                    pricetr = pricetr + '</tr>';
                    pricetr = pricetr + "<tr class='data-Price'>";
                    pricetr = pricetr + "<td ><input type='text' maxlength='3' id='txtDaySlab1' class='dayslab' style='width: 40px;'> &nbsp;<input type='text' maxlength='3' id='txtDaySlab2' class='dayslab' style='width: 40px;'></td>";
                    geocnt = parseInt($("#HdnGeoCnt").val());
                    agecnt = parseInt($("#txtNoOfAge").val());
                    if ($("input[name='radioFoo2']:checked").val() == 'Domestic') {
                        geocnt = 1;
                    }
                    j = 0;
                    while (geocnt > 0) {
                        pricetr = pricetr + '<td>';
                        for (var i = 1; i <= agecnt; i++) {
                            j++;
                            pricetr = pricetr + "<input type='text' maxlength='10' id='txtPrice" + j + "' placeholder='Price' class='price' style='width: 60px;'>&nbsp;&nbsp;";
                        }
                        pricetr = pricetr + '</td>';
                        geocnt--;
                    }
                    $('#AgeSlabIdCnt').val(j);
                    ageslabid = $('#AgeSlabIdCnt').val();
                    //alert(ageslabid);
                    pricetr = pricetr + "</tr>";
                    pricetr = pricetr + "</tbody>";
                    pricetr = pricetr + "</table>";
                    $('#maindiv').append(pricetr);
                    $('#reMove').show();
                    $("#addMore").show();
                    $('#txtNoOfAge').hide();
                    $("#btnnoOfAge").hide();
                    $('#maintable').find(":text").each(function () {
                        $("input:text,textarea").keypress(function () {
                            $('#lblMsg4').text("");
                        });
                        //$(this).bind('keyup', function (e) {
                        //    if (this.value.match(/[^0-9]/g)) {
                        //        this.value = this.value.replace(/[^0-9]/g, '');
                        //    }
                        //});
                        $('.price').on('input', function (event) {
                            this.value = this.value.replace(/[^0-9]/g, '');
                        });
                        $('.dayslab').on('input', function (event) {
                            this.value = this.value.replace(/[^0-9]/g, '');
                        });
                        $('.ageslab').on('input', function (event) {
                            this.value = this.value.replace(/[^0-9-.]/g, '');
                        });
                    });
                    var noofage_1 = $("#txtNoOfAge").val();
                    ///alert(noofage_1);
                    //if (noofage_1 == 1) {
                    //} else {
                        if (noofage_1 == 1|| noofage_1 == 2) {
                            var wdth = (parseInt(noofage_1 + "000") - 800) + 'px';
                            $('#maintable').css("width", "100%");
                        }
                        if (noofage_1 == 3) {
                            var wdth = (parseInt(noofage_1 + "000") - 1800) + 'px';
                            $('#maintable').css("width", wdth);
                        }
                        else if (noofage_1 == 4) {
                            var wdth = (parseInt(noofage_1 + "000") - 2500) + 'px';
                            $('#maintable').css("width", wdth);
                        }
                        else if (noofage_1 == 5) {
                            var wdth = (parseInt(noofage_1 + "000") -3200) + 'px';
                            $('#maintable').css("width", wdth);
                        }
                    //}

                    e.preventDefault();
                    return false;
                }
            });
            //**End**--No of Age slab addition
            //**Start**--Optional Benifits addition
            $("#btnOpt").click(function (e) {
                var benifittr = "<tr class='data-FB'>";
                benifittr = benifittr + "<td>";
                benifittr = benifittr + "<input type='text' id='txtOptBenefit1' class='form-control benifit' placeholder='Enter Benifit' maxlength='300'>";
                benifittr = benifittr + "</td>";
                benifittr = benifittr + "<td>";
                benifittr = benifittr + "<input type='text' id='txtOptBenefits1' class='form-control benifit' placeholder='Sum Insured' maxlength='200'>";
                benifittr = benifittr + "</td>";
                benifittr = benifittr + "<td>";
                benifittr = benifittr + "<input type='text' id='txtDeductibleOpt1' class='form-control benifit' placeholder='Deductible' maxlength='200'>";
                benifittr = benifittr + "</td>";
                benifittr = benifittr + "</tr>";
                $('#maindivOB').append(benifittr);
                //$('#addMoreOB').show();
                //$('#reMoveOB').show();
                $("#btnOpt").hide();
                $('#TableOptBenefits').show();
                $('.benifit').on('input', function (event) {
                    this.value = this.value.replace(/[^a-zA-Z0-9%()-.$#&!@', ]/g, '');
                });
            });
            //**End**--Optional Benifits addition

            //**Start**--Fixed Benifits add more option
            $("#addMoreFB").click(function (e) {
                id++;
                var benifittr = "<tr class='data-FB'>";
                benifittr = benifittr + "<td>";
                benifittr = benifittr + "<input type='text' id='txtFixedBenefit" + id + "' class='form-control benifit' placeholder='Enter Benifit' maxlength='300'>";
                benifittr = benifittr + "</td>";
                benifittr = benifittr + "<td>";
                benifittr = benifittr + "<input type='text' id='txtFixedBenefits" + id + "' class='form-control benifit' placeholder='Sum Insured' maxlength='200'>";
                benifittr = benifittr + "</td>";
                benifittr = benifittr + "<td>";
                benifittr = benifittr + "<input type='text' id='txtDeductibleFixed" + id + "' class='form-control benifit' placeholder='Deductible' maxlength='200'>";
                benifittr = benifittr + "</td>";
                benifittr = benifittr + "</tr>";
                $('#maindivFB').append(benifittr);

                $('.benifit').on('input', function (event) {
                    this.value = this.value.replace(/[^a-zA-Z0-9%()-.$#&!@', ]/g, '');
                });
            });
            //**End**--Fixed Benifits add more option

            //**Start**--Optional Benifits add more option
            $("#addMoreOB").click(function (e) {
                id1++;
                var benifittr = "<tr class='data-FB'>";
                benifittr = benifittr + "<td>";
                benifittr = benifittr + "<input type='text' id='txtOptBenefit" + id1 + "' class='form-control benifit' placeholder='Enter Benifit' maxlength='300'>";
                benifittr = benifittr + "</td>";
                benifittr = benifittr + "<td>";
                benifittr = benifittr + "<input type='text' id='txtOptBenefits" + id1 + "' class='form-control benifit' placeholder='Sum Insured' maxlength='200'>";
                benifittr = benifittr + "</td>";
                benifittr = benifittr + "<td>";
                benifittr = benifittr + "<input type='text' id='txtDeductibleOpt" + id1 + "' class='form-control benifit' placeholder='Deductible' maxlength='200'>";
                benifittr = benifittr + "</td>";
                benifittr = benifittr + "</tr>";
                $('#maindivOB').append(benifittr);

                $('.benifit').on('input', function (event) {
                    this.value = this.value.replace(/[^a-zA-Z0-9%()-.$#&!@', ]/g, '');
                });
            });
            //**End**--Optional Benifits add more option
        });
    </script>

    <%--End Plan price script--%>



    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>

            <asp:Label ID="lblErrorMsg" runat="server"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">Plan Master</h1>
                <div id="plan-master-content">
                    <ul id="tabs" class="nav nav-tabs" data-tabs="tabs">
                        <li><a href="#plan-Details" role="tab" class="active" id="PD" <%--data-toggle="tab"--%>>Plan Details</a></li>
                        <li><a href="#plan-Benefits" role="tab" id="PB" <%--data-toggle="tab"--%>>Plan Benefits</a></li>
                        <li><a href="#plan-Pricing" role="tab" id="PP" <%--data-toggle="tab"--%>>Plan Pricing</a></li>

                    </ul>
                    <div id="my-tab-content" class="tab-content">
                        <div class="tab-pane active" id="plan-Details">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card">
                                        <div style="height: 20px">
                                            <center> <span id="MsgPlanDetails"></span></center>
                                        </div>
                                        <div class="card-content collapse show">
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <h5>Insurance Provider*</h5>
                                                                <div class="controls">
                                                                    <asp:DropDownList ID="ddlInsurerProvider" runat="server" class="form-control"></asp:DropDownList>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <h5>Plan Code*</h5>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtPlancode" runat="server" class="form-control" placeholder="Enter Plan Code" ClientIDMode="Static" MaxLength="3" onchange="CheckPlanCode();"></asp:TextBox>
                                                                    <span id="lblMessage"></span>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <h5>Plan Name*</h5>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtPlanname" runat="server" class="form-control" placeholder="Enter Plan Name" MaxLength="300"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <h5>Select Value added services*</h5>
                                                                <asp:ListBox ID="ddlValueaddedservices" runat="server" SelectionMode="Multiple" CssClass="3col1 active" ClientIDMode="Static" aria-invalid="false"></asp:ListBox>

                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <h5>Min. Age of Traveller (In Years)*</h5>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtMinAge" runat="server" class="form-control" placeholder="Minimum age of Traveller" MaxLength="5"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <h5>Max. Age of Traveller (In Years)*</h5>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtMaxAge" runat="server" class="form-control" placeholder="Maximum age of Traveller" MaxLength="5"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <h5>Min. Trip Duration*</h5>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtmintripDuration" runat="server" class="form-control" placeholder="Days" MaxLength="5"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <h5>Max. Trip Duration*</h5>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtmaxDuration" runat="server" class="form-control" placeholder="Days" MaxLength="5"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <h5>Valid for*</h5>
                                                                <div class="controls">
                                                                    <label class="custom-input">
                                                                        <input type="radio" name="radioFoo" value="OneWay">
                                                                        <span class="check-radio"></span>
                                                                        <span class="custom-input-label">One way trip</span>
                                                                    </label>
                                                                    <label class="custom-input">
                                                                        <input type="radio" name="radioFoo" value="Round">
                                                                        <span class="check-radio"></span>
                                                                        <span class="custom-input-label">Round trip</span>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <h5>Travel Type*</h5>
                                                                <div class="controls">
                                                                    <label class="custom-input">
                                                                        <input type="radio" name="radioFoo2" value="International">
                                                                        <span class="check-radio"></span>
                                                                        <span class="custom-input-label">International</span>
                                                                    </label>
                                                                    <label class="custom-input">
                                                                        <input type="radio" name="radioFoo2" value="Domestic">
                                                                        <span class="check-radio"></span>
                                                                        <span class="custom-input-label">Domestic</span>
                                                                    </label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <h5>Terms and Condition Document*</h5>
                                                                <div class="controls">
                                                                    <asp:DropDownList ID="ddlTemandCodition" runat="server" class="form-control">
                                                                    </asp:DropDownList>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <%--<div class="col-md-4">
                                                            <div class="form-group">
                                                                <h5>Upload Document*(PDF/DOC)</h5>
                                                                <div class="controls">
                                                                    <asp:FileUpload ID="fileUpload1" runat="server" class="form-control" /><br />
                                                                </div>
                                                            </div>
                                                        </div>--%>
                                                    </div>
                                                </div>
                                                <div class="text-right">
                                                    <button id="btnPlanDetails" type="submit" class="btn btn-success">Save & Continue &raquo; <%--<i class="la la-arrow-right"></i>--%></button>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="plan-Benefits">
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card" style="min-height: 500px;">
                                        <div class="card-content collapse show">
                                            <div class="card-body">
                                                <form class="form">
                                                    <center><span id="lblmsg3"></span></center>
                                                    <div class="form-body">
                                                        <div class="row" id="DivPlanBenifits">

                                                            <div class="col-md-12">
                                                                <div class="form-group">
                                                                    <h5>Fixed benefits Detail:</h5>
                                                                    <div class="table-responsive" id="dvTable">
                                                                        <table class="table table-de mb-0" id="maintableFB">

                                                                            <tbody id="maindivFB" runat="server">
                                                                                <tr>
                                                                                    <td><b>Benefit Name</b></td>
                                                                                    <td><b>Sum Insured</b></td>
                                                                                    <td><b>Deductible</b></td>
                                                                                </tr>
                                                                                <tr class="data-FB">
                                                                                    <td>
                                                                                        <input type="text" id="txtFixedBenefit1" runat="server" class="form-control benifit" placeholder="Enter Benifit" maxlength="300"></td>
                                                                                    <td>
                                                                                        <input type="text" id="txtFixedBenefits1" runat="server" class="form-control benifit" placeholder="Sum Insured" maxlength="200"></td>
                                                                                    <td>
                                                                                        <input type="text" id="txtDeductibleFixed1" runat="server" class="form-control benifit" placeholder="Deductible" maxlength="200"></td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>

                                                                        <div id="add_moreFB">
                                                                            <a href="javascript:void(0);" id="addMoreFB" class="btn btn-success">Add More</a>
                                                                            <a href="javascript:void(0);" id="reMoveFB" class="btn btn-danger reset-btn">Remove</a>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-12">
                                                                <div class="form-group">
                                                                    <h5>Optional benefits Detail:</h5>
                                                                    <div class="controls">
                                                                        <a href="javascript:void(0);" id="btnOpt" class="btn btn-success">Add Optional Benifits</a>
                                                                    </div>
                                                                    <br />
                                                                    <div class="table-responsive" id="TableOptBenefits">

                                                                        <table class="table table-de mb-0" id="maintableOB">

                                                                            <tbody id="maindivOB" runat="server">
                                                                                <tr>
                                                                                    <td><b>Benefit Name</b></td>
                                                                                    <td><b>Sum Insured</b></td>
                                                                                    <td><b>Deductible</b></td>
                                                                                </tr>
                                                                            </tbody>
                                                                        </table>

                                                                        <div id="add_moreOB">
                                                                            <a href="javascript:void(0);" id="addMoreOB" class="btn btn-success">Add More</a>
                                                                            <a href="javascript:void(0);" id="reMoveOB" class="btn btn-danger reset-btn">Remove</a>

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%--</div>--%>
                                                    </div>
                                                    <div class="text-right" id="btnBenefits">
                                                        <button type="submit" id="btnBenefitsSlab" class="btn btn-success">Save & Continue &raquo;<%--<i class="la la-arrow-right"></i>--%></button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane" id="plan-Pricing">
                            <div class="row">

                                <div class="col-md-12">
                                    <div class="card">
                                        <div class="card-content collapse show">
                                            <div class="card-body">
                                                <%-- <form class="form">--%>
                                                <div style="height: 20px">
                                                    <center><asp:Label ID="lblMsg4" runat="server" ClientIDMode="Static"></asp:Label></center>
                                                </div>
                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-6 durationB">
                                                            <div class="form-group">
                                                                <h5>Duration Basis:</h5>
                                                                <div class="controls">
                                                                    <label class="custom-input">
                                                                        <input type="radio" name="radioFoo1" id="rdbtnGeoAge" data-attr="dayAgeGeoSlab" value="DayAgeGeo">
                                                                        <span class="check-radio"></span>
                                                                        <span class="custom-input-label">Day Age Geo Slab</span>
                                                                    </label>
                                                                    <label class="custom-input">
                                                                        <input type="radio" name="radioFoo1" id="rdbtnPerDay" data-attr="perDay" value="PerDay">
                                                                        <span class="check-radio"></span>
                                                                        <span class="custom-input-label">Per Day</span>
                                                                    </label>
                                                                    <label class="custom-input">
                                                                        <input type="radio" name="radioFoo1" id="rdbtnMICE" data-attr="mICE" value="MICE">
                                                                        <span class="check-radio"></span>
                                                                        <span class="custom-input-label">MICE</span>
                                                                    </label>
                                                                </div>

                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md-4 perDay radiopophide hidden">
                                                        <div class="form-group">
                                                            <h5>No. of Travelers Allowed:</h5>
                                                            <div class="controls">
                                                                <input type="text" name="text" id="txtPerdaytraveller" maxlength="2" class="form-control" placeholder="20" required data-validation-required-message="This field is required">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4 perDay radiopophide hidden">
                                                        <div class="form-group">
                                                            <h5>Plan Price:</h5>
                                                            <div class="controls">
                                                                <input type="text" id="txtPerdayprice" name="text" class="form-control" maxlength="10" placeholder="Price" required data-validation-required-message="This field is required">
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4 mICE radiopophide hidden">
                                                        <div class="form-group">
                                                            <h5>No. of Travelers Allowed:</h5>
                                                            <div class="controls">
                                                                <input type="text" name="text" id="txttraveller" maxlength="2" class="form-control" placeholder="20" required data-validation-required-message="This field is required">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <%--<div class="col-md-4 mICE radiopophide hidden">
                                                        <div class="form-group">
                                                            <h5>No. of Man Days Allowed:</h5>
                                                            <div class="controls">
                                                                <input type="text" id="txtmandays" maxlength="8" name="text" class="form-control" placeholder="10" required data-validation-required-message="This field is required">
                                                            </div>
                                                        </div>
                                                    </div>--%>
                                                    <div class="col-md-4 mICE radiopophide hidden">
                                                        <div class="form-group">
                                                            <h5>Plan Price:</h5>
                                                            <div class="controls">
                                                                <input type="text" name="text" id="txtMICEprice" class="form-control" maxlength="10" placeholder="Price" required="" data-validation-required-message="This field is required">
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-12 dayAgeGeoSlab radiopophide hidden">
                                                    <div class="row">
                                                        <div class="col-12">
                                                            <div class="card">
                                                                <div class="card-content">
                                                                    <asp:HiddenField ID="HdnGeoCnt" runat="server" Value="0" />
                                                                    <asp:HiddenField ID="HdnAgeSlabCnt" runat="server" Value="0" />
                                                                    <asp:HiddenField ID="AgeSlabIdCnt" runat="server" Value="0" />

                                                                    <div class="row">
                                                                        <div class="col-md-4">
                                                                            <div class="form-group">
                                                                                <%--<h5>No Of Age Slab:</h5>--%>
                                                                                <div class="controls">
                                                                                    <input type="text" name="text" id="txtNoOfAge" maxlength="2" class="form-control" placeholder="No of age slab">
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col-md-6">
                                                                            <div class="form-group">
                                                                                <%--<h5></h5>--%>
                                                                                <div class="controls">
                                                                                    <a href="javascript:void(0);" id="btnnoOfAge" class="btn btn-success">Add</a>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <asp:Panel ID="pnl1" runat="server" ScrollBars="Horizontal">
                                                                        <div class="table-responsive" id="geodiv">
                                                                            <table class="table table-de mb-0" id="maintable">

                                                                                <tbody id="maindiv" runat="server">
                                                                                </tbody>
                                                                            </table>
                                                                        </div>
                                                                    </asp:Panel>

                                                                    <div id="add_morecls">
                                                                        <a href="javascript:void(0);" id="addMore" class="btn btn-success">Add More</a>
                                                                        <a href="javascript:void(0);" id="reMove" class="btn btn-danger reset-btn">Remove</a>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="text-right">
                                                    <button type="submit" id="btnSubmit" runat="server" class="btn btn-success"><i class="la la-thumbs-o-up position-right"></i>Submit</button>
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
        </div>
    </div>


    <%--<div id="SuccessModal" class="modal fade">
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
                    <p>Plan details submitted successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>--%>
</asp:Content>

