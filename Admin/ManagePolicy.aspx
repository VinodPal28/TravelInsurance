<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ManagePolicy.aspx.cs" Inherits="Admin_ManagePolicy" ClientIDMode="Static" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script>
        $(document).ready(function () {
            $("#btnSub").click(function (e) {
                var Reason = $("#ddlRegason").val();
                var FileUpload = $("#Upload_File").val();
                var hdnpolicytype = $("#hdnpolicytype").val();
                var txt_remarks = $("#txt_remarks").val();
                if (Reason == "0") {
                    $("#lblmsg3").text("*Select the Reason").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (hdnpolicytype.toUpperCase() == 'POST' && FileUpload == "") {
                    $("#lblmsg3").text("*Select a document for Upload").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                //else if (txt_remarks == "") {
                //    $("#lblmsg3").text("*Enter the Remark").css("color", "red");
                //    e.preventDefault();
                //    return false;
                //}
                else {
                    $("#lblmsg3").text("").css("color", "red")
                }
            });



        });
    </script>
    <script>
        function Showage() {
            setTimeout(function () {
                $("#Model_Cancel").modal('show');
            }, 100);

        }
        function Showage2() {
            setTimeout(function () {
                $("#Model_Modify").modal('show');
            }, 100);

        }
        function ShowMsgCancelReq() {
            setTimeout(function () {
                $("#myModal_CancelReq").modal('show');
            }, 100);

        }
        function ShowMsgEndorseReq() {
            setTimeout(function () {
                $("#myModal_ModificationReq").modal('show');
            }, 100);
        }
        function Showage3() {
            setTimeout(function () {
                $("#Model_Extend").modal('show');
            }, 100);
        }
        function ShowExtendReqMsg() {
            setTimeout(function () {
                $("#MyModal_Extendreq").modal('show');
            }, 100);
        }
        function GetExtendDetails() {
            setTimeout(function () {
                $("#MyModel_ExtendDetails").modal('show');
            }, 100);
        }
    </script>

    <script>
        $(document).ready(function () {
            $('#txtFirstname').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z ]/g, '');
                }
            });
            $('#txtCompName').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z. ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z. ]/g, '');
                }
            });
            $('#txtMiddlename').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z ]/g, '');
                }
            });
            $('#txtLastname').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z ]/g, '');
                }
            });
            $('#txtNomineename').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z ]/g, '');
                }
            });
            $('#txtContactNumber').bind('keyup', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });
            $('#txtAadhaar').bind('keyup', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });
            $('#txtPanNo').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9]/g, '');
                }
            });
            $("#btnPaymentMethod").click(function (e) {

                var DOB = $("#txtDOB").val();
                var SDate = $("#txtTravelStartDate").val();
                var EDate = $("#txtTravelEndDate").val();
                var FirstName = $("#txtFirstname").val();
                var Lastname = $("#txtLastname").val();
                var ContactNumber = $("#txtContactNumber").val();
                var Email = $("#txtEmail").val();
                var Nomineename = $("#txtNomineename").val();
                var State = $("#ddlState").val();
                var City = $("#ddlCity").val();
                var PinCode = $("#txtPinCode").val();
                var Aadhaar = $("#txtAadhaar").val();
                var PanNo = $("#txtPanNo").val();
                var passportNo = $("#txtCustPassport").val();
               
                var compName = $("#txtCompName").val();
                var compEmail = $("#txtCompEmailID").val();
                var compGSTIN = $("#txtCompGSTIN").val();
                var compAddr = $("#txtCompAddress").val();

                var NomineeAddres = $("#txtNomineeAddres").val();
                var NomineeRelation = $("#ddlRelationNominee").val();

                var regPassport = /[a-zA-Z]{1}[0-9]{7}/;
                var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
                var Aadh = /^\d{4}\s\d{4}\s\d{4}$/g;
                var regExp = /[a-zA-z]{5}\d{4}[a-zA-Z]{1}/;
                var reggst = /^([0-9]){2}([a-zA-Z]){5}([0-9]){4}([a-zA-Z]){1}([0-9]){1}([zZ]){1}([0-9]){1}?$/;

                if (DOB == "") {
                    $("#DOBMsg").text("*Select the DOB").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (SDate == "") {
                    $("#StartDatemsg").text("*Select the start date").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (EDate == "") {
                    $("#Datemsg").text("*Select the end date").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else
                {
                    $("#Datemsg").text("");
                    $("#StartDatemsg").text("");
                    $("#DOBMsg").text("");
                }
                if ($('#CheckInfo').val() == "1") {
                    

                    if (FirstName == "") {
                        $("#lblmsg4").text("*Enter the First Name").css("color", "red");
                        e.preventDefault();
                        return false;
                    }

                    else if (Lastname == "") {
                        $("#lblmsg4").text("*Enter the Last Name").css("color", "red");
                        e.preventDefault();
                        return false;
                    }

                    else if (ContactNumber == "") {
                        $("#lblmsg4").text("*Enter the Contact Number").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (ContactNumber.length != 10) {
                        $("#lblmsg4").text("*Contact Number must be 10 digit ").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (Email == "") {
                        $("#lblmsg4").text("*Enter the Email Id").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (!re.test(Email)) {
                        $('#lblmsg4').text('Invalid Email').css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (passportNo == '' && $('#txtGeographyAskcountry').val() != 'India') {
                            $("#lblmsg4").text("*Enter the passport number").css("color", "red");
                            e.preventDefault();
                            return false;
                        }
                    else if (passportNo != '' && !regPassport.test(passportNo)) {
                        $("#lblmsg4").text("*Enter valid passport No").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (Nomineename == "") {
                        $("#lblmsg4").text("*Enter the Nominee name").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (State == "0") {
                        $("#lblmsg4").text("*Select the State").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (City == "0") {
                        $("#lblmsg4").text("*Select the City").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (PinCode == "") {
                        $("#lblmsg4").text("*Enter the Pin Code").css("color", "red");
                        e.preventDefault();
                        return false;
                    }

                    else if (Aadhaar == Aadh && Aadhaar != '') {
                        $("#lblmsg4").text("*Invalid Aadhaar No.").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (Aadhaar.length != 12 && Aadhaar != '') {
                        $("#lblmsg4").text("*Enter valid  Aadhaar No").css("color", "red");
                        e.preventDefault();
                        return false;
                    }

                    else if (PanNo.length != 10 && PanNo != '') {
                        $("#lblmsg4").text("*Enter valid Pan No").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (!PanNo.match(regExp) && PanNo != '') {
                        $("#lblmsg4").text("*Enter valid Pan No (ex - aaaaa9999a)").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (NomineeAddres == "") {
                        $("#lblmsg4").text("*Enter the Addres").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                }
                else {
                    $("#lblmsg4").text("");
                }
                if ($('#CheckInfo').val() == "0") {
                    if (compName == "") {
                        $("#lblCompMsg").text("*Enter the name").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (compEmail == "") {
                        $("#lblCompMsg").text("*Enter the email id").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (!re.test(compEmail)) {
                        $("#lblCompMsg").text("*Enter the valid email id").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (compGSTIN == "") {
                        $("#lblCompMsg").text("*Enter the GSTIN no").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (!reggst.test(compGSTIN)) {
                        $("#lblCompMsg").text("*GST Identification Number is not valid. It should be in this '11AAAAA1111A1Z1' format").css("color", "red");
                        e.preventDefault();
                        return false;
                    }
                    else if (compAddr == "") {
                        $("#lblCompMsg").text("*Enter the address").css("color", "red");
                        e.preventDefault();
                        return false;
                    }


                }
                else {
                    $("#lblCompMsg").text("");
                }
                if (Nomineename == "") {
                    $("#lblmsg4").text("*Enter the nominee name").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                //else if (NomineeRelation == "0") {
                //    $("#lblmsg4").text("*Select the Nominee relation").css("color", "red");
                //    e.preventDefault();
                //    return false;
                //}
               // else {
                //    $("#lblmsg4").text("").css("color", "red")
                //}
            });
        });
    </script>

    <script type="text/javascript">
        function GetExtendPrice() {
            $.ajax({
                url: "ManagePolicy.aspx/Page_Load",
                data: {
                    method: "GetExtendPrice",
                    EndDate: $("#hiddenFieldID").val(),
                    ExtendStartDate: $("#txtNewStartDate").val(),
                    ExtendEndDate: $("#txtNewEndDate").val(),
                    PlanCode: $("#hiddenPlanCode").val(),
                    DOB: $("#txtdob2").val(),
                    Country: $("#txtCountry").val()

                },
                success: function (msg) {
                    if (msg != '') {
                        var data = msg.split('#');
                        if (data[0].toString() == 'F') {
                            $("#lblMsgextendPrice").text("");
                            $('#<%=txtExtend.ClientID%>').val(data[1].toString());
                            $('#HiddenFieldPrice').val(data[1].toString());
                          
                        }
                        else if (data[0].toString() == 'NF') {
                            $("#lblMsgextendPrice").text("*Date is exceeding from day slab").css("color", "red");
                            $('#<%=txtExtend.ClientID%>').val('');
                        }
                        else {
                            $('#<%=txtExtend.ClientID%>').val('');
                            $("#lblMsgextendPrice").text("");
                        }
                }
                }
            });
    }
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnExtendSave").click(function (e) {
                $('#hdnNewStartDate').val($('#txtNewStartDate').val());
                
                var ExtendStartdate = $("#txtNewStartDate").val();
                var ExtendEnddate = $("#txtNewEndDate").val();
                var Extendprice = $("#txtExtend").val();               
                if (ExtendEnddate == "") {
                    $("#lblMsgextendPrice").text("*Select the new end Date").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (Extendprice == "") {
                    $("#lblMsgextendPrice").text("*Enter the price").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else {
                    $("#lblMsgextendPrice").text("");
                }
                //SaveExtenddetails();
               // return false;
            });
        });

        function SaveExtenddetails() {
            $.ajax({
                url: "ManagePolicy.aspx/Page_Load",
                data: {
                    method: "SaveExtendData",
                    Policy_No: $("#Hidden_PolicyNo").val(),
                    PolicyEnd_dtt: $("#hiddenFieldID").val(),
                    PolicyExtend_Enddate: $("#txtNewEndDate").val(),
                    PolicyExtendStartdate: $("#txtNewStartDate").val(),
                    PolicyStartDate: $("#txtstartdtt").val(),
                    Total_Price: $("#txtPrices").val(),
                    Extend_Price: $("#txtExtend").val(),
                    Email: $("#txtEmailid").val(),
                    CompEmail: $("#txtCompEmail").val(),
                    CompName: $("#txtCompanyName").val(),
                    CustName: $("#txtNameFirst").val()
                },
                success: function (msg) {
                    if (msg != '') {
                        if (msg.toString() == 'F') {
                            alert("Submitted Successfully");
                            $('#txtExtend').val("");
                            window.location.href = "../Admin/Managepolicy.aspx";
                        }
                        if (msg.toString() == 'NF') {
                            alert("You do not have sufficient balance");
                            $('#txtExtend').val("");
                            window.location.href = "../Admin/Managepolicy.aspx";
                        }
                    }

                },
                error: function (msg) {
                    alert("failed Submitted data");
                }

            });
        }
       
        function EndorsePolicyDate() {            
            var DayDiff;
            var date1 = $('#txtTravelStartDate').val();        
            var date2  = $('#txtTravelEndDate').val();          
            var FDate = date1.split("/");
            var Todate = date2.split("/");
            var Fdays = FDate[0];
            var Fmonths = FDate[1];
            var Fyear = FDate[2];
        
            var Tdays = Todate[0];
            var Tmonths = Todate[1];
            var Tyear = Todate[2];
           
            if (Tdays < Fdays) {
                Tdays = parseInt(Tdays) + 30;
                Tmonths = parseInt(Tmonths) - 1;               
                DayDiff = (Tdays - Fdays)+1;             
            }
            else {
                DayDiff = (Tdays - Fdays)+1;
            }
            
            var OldPolicySDate = $('#hdnPolicySDate').val();
            var OldPolicyEDate = $('#hdnPolicyEDate').val();
            var FDate = OldPolicySDate.split("/");
            var Todate = OldPolicyEDate.split("/");
            var Fdays = FDate[0];
            var Fmonths = FDate[1];
            var Fyear = FDate[2];
            
            var Tdays = Todate[0];
            var Tmonths = Todate[1];
            var Tyear = Todate[2];
           
            if (Tdays < Fdays) {
                Tdays = parseInt(Tdays) + 30;
                Tmonths = parseInt(Tmonths) - 1;
                var OldDayDiff = (Tdays - Fdays) + 1;
            }
            else {
                var OldDayDiff = (Tdays - Fdays) + 1;
            }                                
            if (parseInt(OldDayDiff) != parseInt(DayDiff))
            {
                $("#Datemsg").text("travel days Should be equal to existing travel days").css("color", "red");
                $("#txtTravelEndDate").val('');
            }
            else {
                $("#Datemsg").text("");
            }
        }
    </script>

    <script type="text/javascript">
        function CheckDOB() {
            $.ajax({
                url: "ManagePolicy.aspx/Page_Load",
                data: {
                    method: "CheckDOB",
                    PlanCode: $("#hdnPlanCode").val(),
                    NewDOB: $("#txtDOB").val(),
                    GeoGraphy: $("#txtGeographyAskcountry").val(),
                    ExistingDOB: $("#hdnDOB").val(),
                    TravelSDate: $("#txtTravelStartDate").val(),
                    TravelEDate: $("#txtTravelEndDate").val()
                },
                success: function (msg) {
                    if (msg != '') {

                        if (msg.toString() == 'F') {
                            $("#DOBMsg").text("Cannot change DOB (exceeding age limit for existing plan)").css("color", "red");
                            $("#txtDOB").val('');
                        }
                        else if (msg.toString() == 'NF') {
                            $("#DOBMsg").text("");
                        }
                        else {
                            $("#DOBMsg").text("");
                        }
                    }
                }
            });
        }                
    </script>

    <style>
        .table-responsive{
            position:relative;
        }
        .table-responsive table{
            margin-top:75px;
        }
        .table-responsive .bs-pagination{
            position: absolute;
            top: -24px;
        }
        .table.table-de th, .table.table-de td{
            padding: .75rem 1rem;
        }
    </style>

    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <div class="content-body">
                <h1 class="h1Tag">Manage Policy</h1>
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
                                        <asp:TextBox ID="txtSearch" runat="server" OnTextChanged="txtSearch_TextChanged" AutoPostBack="true" class="form-control" placeholder="Policy No / Customer Name / Date(dd/mm/yyyy)"></asp:TextBox>
                                    </div>
                                </div>

                            </div>
                            <!-- end search -->
                            <asp:HiddenField ID="hdnpolicytype" runat="server" Value="" />
                            <asp:HiddenField ID="Hiddpolicy" runat="server" Value="" />
                            <asp:HiddenField ID="CheckInfo" runat="server" />
                            <asp:HiddenField ID="hdnCount" runat="server" />
                            <asp:HiddenField ID="miceno" runat="server" />
                            <div class="card-content">
                                <center><asp:Label ID="SpnMsg" runat="server"></asp:Label></center>

                                <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
                                <div class="table-responsive">
                                  <%--  <table class="table table-de mb-0">--%>
                                        <asp:GridView ID="GV_ManagePolicy" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                            PagerStyle-CssClass="bs-pagination" Width="100%" OnRowCommand="GV_ManagePolicy_RowCommand" OnRowDataBound="GV_ManagePolicy_RowDataBound" OnPageIndexChanging="GV_ManagePolicy_PageIndexChanging1">

                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                        <%-- <asp:HiddenField id="hdnDataId" runat="server" Value='<%#Bind() %>'/>--%>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Policy Number">
                                                    <ItemTemplate>
                                                         <asp:LinkButton ID="LinkPolicyNo" runat="server" Text='<%#Bind("Policy_No") %>' ForeColor="Blue" CommandName="ExtendDetailsView" CommandArgument='<%# Container.DataItemIndex + 1 %>'></asp:LinkButton>
                                                        <asp:Label ID="lblPolicy_No" runat="server" Text='<%#Bind("Policy_No") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Issued on">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblissues_dtt" runat="server" Text='<%#Bind("issues_dtt") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Policy Start">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTravel_Start_Date" runat="server" Text='<%#Bind("Travel_Start_Date") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Policy End">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTravel_End_Date" runat="server" Text='<%#Bind("Travel_End_Date") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCustomer_Name" runat="server" Text='<%#Bind("Customer_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%--<asp:TemplateField HeaderText="Partner Code">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPartner_Code" runat="server" Text='<%#Bind("Partner_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>--%>

                                                <asp:TemplateField HeaderText="Total Premium">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTotal_Price" runat="server" Text='<%#Bind("Total_Price") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblExtendStatus" runat="server" Visible="false" Text='<%#Bind("ExtendStatus") %>'></asp:Label>
                                                        <asp:Label ID="lblExtendCount" runat="server" Text='<%#Bind("ExtendedCount") %>'></asp:Label>
                                                        <asp:Button ID="btnExtend" runat="server" class="btn btn-sm round btn-outline-danger" Text="Extend" CommandName="Extend" CommandArgument='<%# Container.DataItemIndex + 1 %>' Style="margin-left: 24%; margin-top: -47%;"></asp:Button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEndorseCount" runat="server" Text='<%#Bind("EndorseCount") %>'></asp:Label>
                                                        <asp:Button ID="btnEndorse" runat="server" class="btn btn-sm round btn-outline-danger" Text="Endorse" CommandName="PolicyModification" CommandArgument='<%# Container.DataItemIndex + 1 %>' Style="margin-left: 24%; margin-top: -47%;"></asp:Button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCancelCount" runat="server" Text='<%#Bind("CancellationCount") %>'></asp:Label>
                                                        <asp:Button ID="btnCancel" runat="server" class="btn btn-sm round btn-outline-danger" Text="Cancel" ClientIDMode="Static" CausesValidation="false" CommandName="PolicyCancel" CommandArgument='<%# Container.DataItemIndex + 1 %>' Style="margin-left: 24%; margin-top: -47%;"></asp:Button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Action">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnDownload" runat="server" class="btn btn-sm round btn-outline-danger" Text="Download" CommandName="PolicyDownload"></asp:Button>
                                                        <asp:Label ID="lblStatus" runat="server" Text='<%#Bind("status") %>' Visible="false"/>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            
                                            <EmptyDataTemplate><b style="color: red">No Record Available</b></EmptyDataTemplate>
                                            
                                        </asp:GridView>
                                    <%--</table>--%>
                                </div>
                            </div>



                        </div>
                    </div>
                </div>
                <!-- Active Orders -->
            </div>
        </div>
    </div>


    <div class="modal dark_bg login-form-btn" id="Model_Cancel" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel1">Policy Cancel Request</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div class="card">
                        <div style="height: 20px">
                            <center><asp:Label ID="lblMsg" runat="server" ClientIDMode="Static"></asp:Label></center>
                            <center> <asp:Label ID="lblmsg3" runat="server"></asp:Label></center>
                        </div>
                        <div class="card-body input-textbox">
                            <div class="row justify-content-center">
                                <center><asp:Label ID="lblmsgApprove" runat="server" ></asp:Label> </center>
                                <div class="col-md-16">
                                    <div class="form-group ">
                                        <label>Reason<span class="starRed">*</span></label>
                                        <asp:DropDownList ID="ddlRegason" runat="server" CssClass="form-control"></asp:DropDownList>

                                    </div>
                                    <div class="form-group " id="File2" runat="server">
                                        <label>Upload File<span class="starRed">*</span></label>
                                        <asp:FileUpload ID="Upload_File" runat="server" CssClass="form-control" />
                                    </div>

                                    <div class="form-group ">
                                        <label>Remarks</label>
                                        <asp:TextBox ID="txt_remarks" runat="server" CssClass="form-control" ClientIDMode="Static" TextMode="MultiLine" />
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

    <div class="modal dark_bg login-form-btn" id="Model_Modify" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div style="width: 60%; margin-left: 20%" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel2">Policy Endorsement Request</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div class="card">
                        <div class="row">
                            <div class="card-content collapse show">
                                <div class="card-body">
                                    <h1>Plan Details</h1>
                                    <hr />
                                    <div class="form-body">
                                         <span id="DOBMsg"></span>
                                        <div class="row">
                                           
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput2">DOB<span class="starRed">*</span></label>
                                                    <asp:TextBox ID="txtDOB" runat="server" class="form-control" onchange="CheckDOB();" AutoCompleteType="Disabled"></asp:TextBox>
                                                    <asp:CalendarExtender ID="CalendarExtDOB" PopupButtonID="txtDOB" runat="server" TargetControlID="txtDOB" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                                    <asp:HiddenField ID="hdnDOB" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput2">Geography Cover <span class="starRed">*</span></label>
                                                    <asp:TextBox ID="txtGeographyAskcountry" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput2">Travel Start Date<span class="starRed">*</span></label>
                                                    <asp:TextBox ID="txtTravelStartDate" runat="server" class="form-control" AutoCompleteType="Disabled"></asp:TextBox>
                                                    <asp:CalendarExtender ID="CalendarPolicySdate" PopupButtonID="txtTravelStartDate" runat="server" TargetControlID="txtTravelStartDate" Format="dd/MM/yyyy" ></asp:CalendarExtender>
                                                    <asp:HiddenField ID="hdnPolicySDate" runat="server" />
                                                    <span id="StartDatemsg"></span>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput2">Travel End Date<span class="starRed">*</span></label>
                                                    <asp:TextBox ID="txtTravelEndDate" runat="server" class="form-control"  onchange="EndorsePolicyDate();" AutoCompleteType="Disabled"></asp:TextBox>
                                                     <asp:CalendarExtender ID="CalendarPolicyEdate" PopupButtonID="txtTravelEndDate" runat="server" TargetControlID="txtTravelEndDate" Format="dd/MM/yyyy" ></asp:CalendarExtender>
                                                    <asp:HiddenField ID="hdnPolicyEDate" runat="server" />
                                                     <span id="Datemsg"></span>
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput1">Plan Name<span class="starRed">*</span></label>
                                                    <asp:TextBox ID="txtPlanName" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                    <asp:HiddenField ID="hdnPlanCode" runat="server" />
                                                </div>
                                            </div>

                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput2">Price</label>
                                                    <asp:TextBox ID="txtPrice" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="card-content collapse show">

                                <div class="card-body">
                                    <div runat="server" id="CustInfo">
                                        <div style="height: 20px">
                                            <center><asp:Label ID="lblmsg4" runat="server" ClientIDMode="Static"></asp:Label></center>
                                        </div>
                                        <h1>Customer Information</h1>
                                        <hr />
                                        <div class="card-body">
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Title<span class="starRed">*</span></label>
                                                                <div class="controls">
                                                                    <asp:DropDownList ID="ddlTitle" runat="server" class="form-control" placeholder="Surname" MaxLength="20" AutoCompleteType="Disabled" ></asp:DropDownList>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2" style="margin-left: 10px;">First Name<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtFirstname" runat="server" class="form-control" placeholder="First Name" MaxLength="30"></asp:TextBox>
                                                                <asp:TextBox ID="txtpolicyno" runat="server" Visible="false"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Middle Name</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtMiddlename" runat="server" class="form-control" placeholder="Middle Name" MaxLength="30"></asp:TextBox>

                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Last Name<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtLastname" runat="server" class="form-control" placeholder="Last Name" MaxLength="30"></asp:TextBox>

                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Contact Number<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtContactNumber" runat="server" class="form-control" placeholder="Contact Number" MaxLength="10"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Email<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtEmail" runat="server" class="form-control" placeholder="Email "></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Passport<span class="starRed" id="PassID" runat="server">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCustPassport" runat="server" class="form-control" placeholder="Passport no" MaxLength="8"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">State<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:UpdatePanel ID="UpdatePanel" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="ddlState" runat="server" class="form-control" placeholder="State" AutoPostBack="true" disabled></asp:DropDownList>
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="ddlState" EventName="selectedindexchanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">City<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="ddlCity" runat="server" class="form-control" placeholder="Citry" disabled></asp:DropDownList>
                                                                <asp:HiddenField ID="hdnCustCity" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Pin Code<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtPinCode" runat="server" class="form-control" placeholder="Pin Code" MaxLength="6" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Aadhaar</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtAadhaar" runat="server" class="form-control" placeholder="Aadhaar" MaxLength="12"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Pan No</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtPanNo" runat="server" class="form-control" placeholder="Pan No" MaxLength="10" onblur="fnValidatePAN(this);"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Address<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtNomineeAddres" runat="server" class="form-control" placeholder="Address" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div runat="server" id="CompInfo" style="width: 100%;">
                                        <div style="height: 20px">
                                            <center><asp:Label ID="lblCompMsg" runat="server" ClientIDMode="Static"></asp:Label></center>
                                        </div>
                                        <h1>Company Information</h1>
                                        <hr />
                                        <div class="card-body">
                                            <div class="form-body">
                                                <div class="row">
                                                      
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Name<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompName" runat="server" class="form-control" placeholder="First Name" MaxLength="30"></asp:TextBox>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Email<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompEmailID" runat="server" class="form-control" placeholder="Email "></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>


                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">GSTIN<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompGSTIN" runat="server" class="form-control" placeholder="Contact Number" MaxLength="15"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">State<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                                    <ContentTemplate>
                                                                        <asp:DropDownList ID="ddlCompState" runat="server" class="form-control" placeholder="State" AutoPostBack="true" disabled></asp:DropDownList>
                                                                    </ContentTemplate>
                                                                    <Triggers>
                                                                        <asp:AsyncPostBackTrigger ControlID="ddlState" EventName="selectedindexchanged" />
                                                                    </Triggers>
                                                                </asp:UpdatePanel>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">City<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="ddlCompCity" runat="server" class="form-control" placeholder="Citry" disabled></asp:DropDownList>
                                                                <asp:HiddenField ID="hdnCompCity" runat="server" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Pin Code<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompPinCode" runat="server" class="form-control" placeholder="Pin Code" MaxLength="6" disabled></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Address<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompAddress" runat="server" class="form-control" placeholder="Address" TextMode="MultiLine"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </div>
                                        <br />

                                        <h2>No. of persons Information</h2>
                                        <hr />
                                        <div class="table-responsive">
                                            <table class="table table-de mb-0">

                                                <asp:GridView ID="GV_MiceInfo" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" Width="100%" OnRowDataBound="GV_MiceInfo_RowDataBound">
                                                    <Columns>
                                                        <%-- <asp:TemplateField HeaderText="Sr.No.">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />                                                              
                                                            </ItemTemplate>
                                                        </asp:TemplateField>--%>

                                                        <asp:TemplateField HeaderText="Name">
                                                            <ItemTemplate>
                                                                <asp:HiddenField runat="server" ID="hdnMiceNo" Value='<%#Bind("MiceNo") %>' />
                                                                <asp:TextBox ID="txtMiceName" runat="server" class="form-control valid" Text='<%#Bind("Name") %>' MaxLength="30"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Passport No">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtMicePassportNo" runat="server" class="form-control valid" Text='<%#Bind("PassportNo") %>' MaxLength="8"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Mobile No">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtMiceMobNo" runat="server" class="form-control valid" Text='<%#Bind("MobNo") %>' MaxLength="10"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Email">
                                                            <ItemTemplate>
                                                                <asp:TextBox ID="txtMiceEmailID" runat="server" class="form-control valid" Text='<%#Bind("EmailId") %>' MaxLength="20"></asp:TextBox>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Gender">
                                                            <ItemTemplate>
                                                                <%-- <asp:TextBox ID="txtMiceGender" runat="server" class="form-control" Text='<%#Bind("Gender") %>'></asp:TextBox>--%>
                                                                <asp:DropDownList ID="ddlMiceGender" runat="server" class="form-control valid" SelectedValue='<%# Bind("Gender") %>'>
                                                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                                                    <asp:ListItem Value="Male">Male</asp:ListItem>
                                                                    <asp:ListItem Value="Female">Female</asp:ListItem>
                                                                    <asp:ListItem Value="Others">Others</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                    </Columns>
                                                    <EmptyDataTemplate><b style="color: red">No Record Available</b></EmptyDataTemplate>
                                                </asp:GridView>
                                            </table>
                                        </div>


                                    </div>
                                    <br />
                                    <div style="width: 100%; margin-left: 21px">
                                        <h1>Nominee Information</h1>
                                        <hr />
                                        <div class="card-body">
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Nominee Name<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtNomineename" runat="server" class="form-control" placeholder="Nominee Name"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Nominee Relation<span class="starRed"></span></label>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="ddlRelationNominee" runat="server" class="form-control" placeholder="State">
                                                                </asp:DropDownList>
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

                        <div class="text-right">
                            <asp:LinkButton ID="btnPaymentMethod" runat="server" type="submit" CssClass="btn btn-success" OnClick="btnPaymentMethod_Click" CausesValidation="false"><i class="la la-thumbs-o-up position-right"></i> Submit</asp:LinkButton>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div id="myModal_CancelReq" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h4>Cancel Request!</h4>
                    <p>Your Cancel request has been sent successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

    <div id="myModal_ModificationReq" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h4>Endorsement Request!</h4>
                    <p>Your Endorsement request has been sent successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg login-form-btn" id="Model_Extend" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div style="width: 60%; margin-left: 20%" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel3">Policy Extend</h5>
                    <div style="margin-left: 55%;">
                        <span id="WalletBlnce" runat="server" class="btn btn-primary pull-right">Wallet Balance : <i class="fa fa-rupee" aria-hidden="true"></i>
                            <asp:Label ID="lblWalletBlnce" runat="server" Font-Bold="true"></asp:Label></span>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>

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
                                            <center><span id="lblMsgextendPrice"></span></center>
                                            <br />
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">DOB<span class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtdob2" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                            <asp:HiddenField ID="Hidden_PolicyNo" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Geography Cover <span class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtCountry" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Travel Start Date<span class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtstartdtt" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Travel End Date<span class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtEnddtt" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>

                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Plan Name<span class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtPlanNames" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                            <asp:HiddenField ID="hiddenPlanCode" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Price</label>
                                                            <asp:TextBox ID="txtPrices" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">New Start Date<span class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtNewStartDate" runat="server" class="form-control" placeholder="dd/mm/yyyy" disabled></asp:TextBox>
                                                            <asp:CalendarExtender ID="CalendarNewStartDate" PopupButtonID="txtNewStartDate" runat="server" TargetControlID="txtNewStartDate" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                                            <asp:HiddenField ID="hdnNewStartDate" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">New End Date<span class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtNewEndDate" runat="server" class="form-control" placeholder="dd/mm/yyyy" onchange="GetExtendPrice();" AutoCompleteType="Disabled"></asp:TextBox>
                                                            <asp:CalendarExtender ID="Calendarenddtt" PopupButtonID="txtNewEndDate" runat="server" TargetControlID="txtNewEndDate" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                                            <asp:HiddenField ID="hiddenFieldID" runat="server" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Extend Price</label>
                                                            <asp:TextBox ID="txtExtend" runat="server" class="form-control" ReadOnly="true" placeholder="Extend Price"></asp:TextBox>
                                                            <asp:HiddenField ID="HiddenFieldPrice" runat="server" />

                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-content collapse show">
                                        <div class="card-body">
                                            <div runat="server" id="CustomerInfo">
                                                <h1>Customer Information</h1>
                                                <hr />
                                                <div class="card-body">
                                                    <div class="form-body">
                                                        <div class="row">
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">First Name<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtNameFirst" runat="server" class="form-control" placeholder="First Name" ReadOnly="true"></asp:TextBox>
                                                                        <asp:TextBox ID="TextBox8" runat="server" Visible="false"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Middle Name</label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtNameMiddle" runat="server" class="form-control" placeholder="middle Name" ReadOnly="true"></asp:TextBox>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Last Name<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtNameLast" runat="server" class="form-control" placeholder="Last Name" ReadOnly="true"></asp:TextBox>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Contact Number<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtNumber" runat="server" class="form-control" placeholder="Contact Number" MaxLength="10" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Email<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtEmailid" runat="server" class="form-control" placeholder="Email " ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">State<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtStates" runat="server" class="form-control" placeholder="State" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">City<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtCitys" runat="server" class="form-control" placeholder="Citry" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Pin Code<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtPincodes" runat="server" class="form-control" placeholder="Pin Code" MaxLength="6" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Aadhaar<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtAdhaar" runat="server" class="form-control" placeholder="Aadhaar" MaxLength="12" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Pan No<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtPan_number" runat="server" class="form-control" placeholder="Pan No" MaxLength="10" onblur="fnValidatePAN(this);" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Address<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtNomineeAddress" runat="server" class="form-control" placeholder="Address" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div runat="server" id="CompanyInfo">
                                                <h1>Company Information</h1>
                                                <hr />
                                                <div class="card-body">
                                                    <div class="form-body">
                                                        <div class="row">
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Name<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtCompanyName" runat="server" class="form-control" placeholder="First Name" ReadOnly="true"></asp:TextBox>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Email Id</label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtCompEmail" runat="server" class="form-control" placeholder="middle Name" ReadOnly="true"></asp:TextBox>

                                                                    </div>
                                                                </div>
                                                            </div>


                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">GSTIN<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtComp_GSTIN" runat="server" class="form-control" placeholder="Contact Number" MaxLength="10" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">State<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtCompanyState" runat="server" class="form-control" placeholder="State" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">City<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtCompanyCity" runat="server" class="form-control" placeholder="Citry" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Pin Code<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtCompanyPin" runat="server" class="form-control" placeholder="Pin Code" MaxLength="6" ReadOnly="true"></asp:TextBox>
                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Address<span class="starRed">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtCompanyAddress" runat="server" class="form-control" placeholder="Address" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
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

                                                                    <asp:TextBox ID="txtNomineeNames" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Nominee Relation<span class="starRed"></span></label>
                                                                <div class="controls">

                                                                    <asp:TextBox ID="txtNomineeRelation" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
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

                        <div class="text-right">
                            <asp:LinkButton ID="btnExtendSave" runat="server" type="submit" CssClass="btn btn-success" OnClick="btnExtendSave_Click"><i class="la la-thumbs-o-up position-right"></i>Submit</asp:LinkButton>
                            <button type="button" class="btn btn-success" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">Close</span> </button>

                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <div id="MyModal_Extendreq" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h4>Extend Request!</h4>
                    <p>Extend request has been sent successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg fade login-form-btn" id="MyModel_ExtendDetails" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true" style="margin-left: -25%;">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="width: 205%;">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Extend Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body" style="margin: 2%;">
                    <div class="row">
                        <div class="col-lg-16">
                            <asp:GridView ID="GV_Extend" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false"
                                PagerStyle-CssClass="bs-pagination" Width="100%">
                                <Columns>
                                    <asp:TemplateField HeaderText="S.No." >
                                        <ItemTemplate>
                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Policy Extend No" ItemStyle-Width="50%" HeaderStyle-Width="50%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPolicyExtendNo" runat="server" Text='<%#Bind("PolicyExtendNo") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Old Start Date" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPrePolicySDate" runat="server" Text='<%#Bind("PrePolicySDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Old End Date" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPrePolicyEDate" runat="server" Text='<%#Bind("PrePolicyEDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="New Start Date" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblExtendPolicySDate" runat="server" Text='<%#Bind("ExtendPolicySDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="New End Date" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblExtendPolicySDate" runat="server" Text='<%#Bind("ExtendPolicyEDate") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Old Price" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblOldPrice" runat="server" Text='<%#Bind("TotalPrice") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                     <asp:TemplateField HeaderText="Extend Price" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                        <ItemTemplate>
                                            <asp:Label ID="lblExtendPrice" runat="server" Text='<%#Bind("ExtendPrice") %>'></asp:Label>
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

</asp:Content>

