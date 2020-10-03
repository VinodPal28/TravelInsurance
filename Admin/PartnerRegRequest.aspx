<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="PartnerRegRequest.aspx.cs" Inherits="Admin_PartnerRegRequest" ClientIDMode="Static" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script>
        function View() {
            setTimeout(function () {
                $("#Model_PartnerRegRequest").modal('show');
                return false;
            }, 100);
        }
        function Approve() {
            setTimeout(function () {
                $("#MyModel_Approve").modal('show');
                return false;
            }, 100);
        }
        function View_Disapprove() {
            setTimeout(function () {
                $("#Model_Disapprove").modal('show');
                return false;
            }, 100);
        }
        function Disapprove() {
            setTimeout(function () {
                $("#ModalDisapproveMsg").modal('show');
                return false;
            }, 100);
        }
        function View_Details() {
            setTimeout(function () {
                $("#Model_PartnerDetailsView").modal('show');
                return false;
            }, 100);
        }
    </script>

    <script>
        $(function () {
            $('.multiselect-ui').multiselect({
                includeSelectAllOption: true
            });
        });
        $(function () {
            $('select[multiple].active.3col').multiselect({
                columns: 1,
                placeholder: 'Select Product',
                search: true,
                searchOptions: {
                    'default': 'Search Product Name'
                },
                selectAll: true
            });
        });
        $(document).ready(function () {
            $('#VolumeBased').hide();
            $('#AmountBased').hide();
            $('#PlanBased').hide();
            $('#radio1').click(function () {
                if ($('#radio1').is(':checked')) {
                    $('#PlanBased').show();
                }
                else {
                    $('#PlanBased').hide();
                }
            });
            $('#radio2').click(function () {
                if ($('#radio2').is(':checked')) {
                    $('#VolumeBased').show();
                }
                else {
                    $('#VolumeBased').hide();
                }
            });
            $('#radio3').click(function () {
                if ($('#radio3').is(':checked')) {
                    $('#AmountBased').show();
                }
                else {
                    $('#AmountBased').hide();
                }
            });

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

    <script>
        function process(date) {
            var parts = date.split("/");
            return new Date(parts[2], parts[1] - 1, parts[0]);
        }
        $(document).ready(function () {
            $('.Numeric').on('input', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });
            $('#RTA').hide();
            $('#KP').hide();
            $("select.select-user-drop-down").change(function () {
                var Val = $(this).val();
                if (Val == 'RetailPartner') {
                    $('#KP').hide();
                    $('#RTA').show();
                }
                else if (Val == 'KeyPartner') {
                    $('#RTA').hide();
                    $('#KP').show();
                }
                else {
                    $('#RTA').hide();
                    $('#KP').hide();
                }
            });
            $('#btnApprove').click(function (e) {               
                var allowedFiles = [".png", ".jpeg", ".pdf", ".jpg"];
                var regexFileUpload = new RegExp("([a-zA-Z0-9\s_\\.\-:])+(" + allowedFiles.join('|') + ")$");                
                if ($('input[name=radioFoo]:checked').length <= 0) {
                    $("#lblMsg").text("*Select the partner type").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if ($('input[name=radioFoo]:checked').val() == 'SubPartner' && $('#ddlHeadPartner').val() == "0") {
                    $("#lblMsg").text("*Select head partner").css("color", "red");
                    $('#ddlHeadPartner').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#ddlPaymentType').val() == "0") {
                    $("#lblMsg").text("*Select payment type").css("color", "red");
                    $('#ddlPaymentType').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#ListProductType').val() == "") {
                    $("#lblMsg").text("*Select product type").css("color", "red");
                    $('#ListProductType').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtCreditLimit').val() == "") {
                    $("#lblMsg").text("*enter credit limit").css("color", "red");
                    $('#txtCreditLimit').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#ddlPartnerType').val() == "0") {
                    $("#lblMsg").text("*select partner type").css("color", "red");
                    $('#ddlPartnerType').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#ddlPartnerType').val() == "KeyPartner" && $('#txtKeypartner').val() == "") {
                    $("#lblMsg").text("*enter key partner type").css("color", "red");
                    $('#txtKeypartner').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#ddlWalletType').val() == "0") {
                    $("#lblMsg").text("*select wallet type").css("color", "red");
                    $('#ddlWalletType').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtContractSDate').val() == "") {
                    $("#lblMsg").text("*select contract start date").css("color", "red");
                    $('#txtContractSDate').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtContractEDate').val() == "") {
                    $("#lblMsg").text("*select contract end date").css("color", "red");
                    $('#txtContractEDate').focus();
                    e.preventDefault();
                    return false;
                }
                else if (process($('#txtContractSDate').val()) > process($('#txtContractEDate').val())) {
                    $("#lblMsg").text("*Contract End Date should be greater than Contract Start Date").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if (!regexFileUpload.test($('#FileuploadContract').val().toLowerCase()) && $('#FileuploadContract').val() != "") {
                    $('#lblMsg').text('Please upload files having extensions: ' + allowedFiles.join(', ') + ' only.').css("color", "red");
                    $('#FileuploadContract').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('input[name=RadioGroup]:checked').length <= 0 && $('input[name=RadioGroup1]:checked').length <= 0 && $('input[name=RadioGroup2]:checked').length <= 0) {
                    $("#lblMsg").text("*select commission type").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else if ($('input[name=RadioGroup]:checked').length > 0) {
                    var count = document.getElementById('dvTable').getElementsByTagName('input').length;
                    for (var i = 1; i <= count; i++) {
                        if ($('#txtFixedBenefits' + i).val() == "") {
                            $("#lblMsg").text("*Enter the amount").css("color", "red");
                            $('#txtFixedBenefits' + i).focus();                                                     
                            e.preventDefault();
                            return false;
                        }                                                                                                  
                    }
                    var count1 = document.getElementById('dvTable').getElementsByTagName('input').length;
                    var data = [];
                    if (count1 > 0) {
                        for (var i = 1; i <= count1; i++) {
                            data.push($.trim($('#txtFixedBenefits' + i).val()));
                        }
                        $("#hdnProductPrice").val(data.join(","));
                    }                                    
                }
                else if ($('input[name=RadioGroup1]:checked').length > 0 && $('#txtNoOfPolicies').val() == "") {
                    $("#lblMsg").text("*enter no of policies").css("color", "red");
                    $('#txtNoOfPolicies').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('input[name=RadioGroup1]:checked').length > 0 && $('#txtCommissionParcentage').val() == "") {
                    $("#lblMsg").text("*enter commission percentage").css("color", "red");
                    $('#txtCommissionParcentage').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('input[name=RadioGroup2]:checked').length > 0 && $('#txtAmount_Month').val() == "") {
                    $("#lblMsg").text("*enter amount").css("color", "red");
                    $('#txtAmount_Month').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('input[name=RadioGroup2]:checked').length > 0 && $('#txtCommPercentage').val() == "") {
                    $("#lblMsg").text("*enter commission percentage").css("color", "red");
                    $('#txtCommPercentage').focus();
                    e.preventDefault();
                    return false;
                }
                else {                    
                    $("#lblMsg").text("");
                    //var count1 = document.getElementById('dvTable').getElementsByTagName('input').length;                  
                    //var data = [];
                    //if (count1 > 0) {
                    //    for (var i = 1; i <= count1; i++) {
                    //        data.push($.trim($('#txtFixedBenefits' + i).val()));
                    //    }
                    //    $("#hdnProductPrice").val(data.join(","));                        
                    //}                    
                }

            });
            $('#btnDisApprove').click(function (e) {
                if ($('#txtDisapproveRemark').val() == "") {
                    $("#lblDisapproveMsg").text("*Enter the remarks").css("color", "red");
                    $('#txtDisapproveRemark').focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $("#lblDisapproveMsg").text("");
                }
            });
            $('#Partner').click(function (e) {
                $("select option[value*='WalletPooling']").prop('disabled', true);
            });
            $('#SubPartner').click(function (e) {
                $("select option[value*='WalletPooling']").prop('disabled', false);

            });
        });
        function BindPlanbased() {
            var FixedBenefits = $("#ListProductType").val();
            if (FixedBenefits == '' || FixedBenefits == null) {
                $("#MsgFixedBenefits").text("Select fixed benefits").css("color", "Red");
                return false;
            }
            else {
                $("#MsgFixedBenefits").text("");
            }
            var values = "";
            var listBox = document.getElementById("<%= ListProductType.ClientID%>");
            for (var i = 0; i < listBox.options.length; i++) {
                if (listBox.options[i].selected) {
                    values += "!" + listBox.options[i].innerHTML;
                }
            }
            var SelectedValues = values.replace(/!/, "");
            var split = SelectedValues.split('!');

            var customers = new Array();
            var counter = 0;
            var id = 0;

            customers.push(["S.No", "Plan Name", "Commission Percentage ( % )"]);
            $.each(split, function (index, value) {
                counter++;
                id++;
                var name = "<label id='lblFixedBenefits" + id + "' >" + value + "</Label>";
                //var name = "<input type='label' name='label' id='lblFixedBenefits" + id + "'>"
                
                var textbox = "<input type='text' name='text' id='txtFixedBenefits" + id + "' class='form-control Numeric' placeholder='Amount' maxlength='3' AutoCompleteType='Disabled'>";
                customers.push([counter, name, textbox]);
            });
            //Create a HTML Table element.
            var table = $("<table class='table' />");
            table[0].border = "0";

            //Get the count of columns.
            var columnCount = customers[0].length;

            //Add the header row.
            var row = $(table[0].insertRow(-1));
            for (var i = 0; i < columnCount; i++) {
                var headerCell = $("<th />");
                headerCell.html(customers[0][i]);
                row.append(headerCell);
            }

            //Add the data rows.
            for (var i = 1; i < customers.length; i++) {
                row = $(table[0].insertRow(-1));
                for (var j = 0; j < columnCount; j++) {
                    var cell = $("<td />");
                    cell.html(customers[i][j]);
                    row.append(cell);
                }
            }

            var dvTable = $("#dvTable");
            dvTable.html("");
            dvTable.append(table);

            $('#dvTable').find(":text").each(function (e) {
                $(this).bind('keyup', function (e) {
                    if (this.value.match(/[^0-9]/g)) {
                        this.value = this.value.replace(/[^0-9]/g, '');
                    }
                });
            });

        }
    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">Partner Registration Request</h1>
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-content">
                                <div class="table-responsive">
                                    <table class="table table-de mb-0">
                                        <asp:GridView ID="GV_PartnerRegRequest" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                            PagerStyle-CssClass="bs-pagination" Width="100%" OnPageIndexChanging="GV_PartnerRegRequest_PageIndexChanging" OnRowCommand="GV_PartnerRegRequest_RowCommand">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                        <asp:Label ID="lblID" runat="server" Text='<%#Bind("ID") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Partner Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPartnerName" runat="server" Text='<%#Bind("Partner_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Partner EmailId">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPartnerEmailID" runat="server" Text='<%#Bind("Partner_Email") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Contact No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblContactNo" runat="server" Text='<%#Bind("PartnerContactNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Requested Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblReqDate" runat="server" Text='<%#Bind("RequestedDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="View">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btn_View" runat="server" class="btn btn-sm round btn-outline-danger" Text="View" CommandName="View" CommandArgument='<%# Container.DataItemIndex + 1 %>'></asp:Button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Approve">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btn_Approve" runat="server" class="btn btn-sm round btn-outline-danger" Text="Approve" CommandName="Approve" CommandArgument='<%# Container.DataItemIndex + 1 %>'></asp:Button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Disapprove">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btn_Disapprove" runat="server" class="btn btn-sm round btn-outline-danger" Text="Disapprove" CommandName="Disapprove" CommandArgument='<%# Container.DataItemIndex + 1 %>'></asp:Button>
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

    <div class="modal dark_bg login-form-btn" id="Model_PartnerRegRequest" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div style="width: 75%; margin-left: 13%" role="document">
            <div class="modal-content">
                <asp:HiddenField ID="hdnProductName" runat="server" />
                <asp:HiddenField ID="hdnProductPrice" runat="server" />
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel2">Partner Registration Request</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div style="height: 25px">
                        <center><asp:Label runat="server" ID="lblMsg"></asp:Label></center>
                    </div>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-content collapse show">
                                    <div class="card-body">
                                        <div class="form-body">
                                            <asp:HiddenField ID="PartnerId" runat="server" />
                                            <asp:HiddenField ID="hdnPartnerName" runat="server" />
                                            <asp:HiddenField ID="hdnPartnerEmailId" runat="server" />
                                            <asp:HiddenField ID="hdnPassword" runat="server" />
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Partner Type<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <label class="custom-input">
                                                                <input type="radio" name="radioFoo" value="Partner" data-attr="Partner" id="Partner">
                                                                <span class="check-radio"></span>
                                                                <span class="custom-input-label">Partner</span>
                                                            </label>
                                                            <label class="custom-input" style="width: 46%; margin-left: 26px">
                                                                <input type="radio" name="radioFoo" value="SubPartner" data-attr="SubPartner" id="SubPartner">
                                                                <span class="check-radio"></span>
                                                                <span class="custom-input-label">Sub Partner</span>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4 SubPartner radiopophide hidden">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Head Partner<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <asp:DropDownList ID="ddlHeadPartner" runat="server" class="form-control"></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Payment Type<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <asp:DropDownList ID="ddlPaymentType" runat="server" class="form-control">
                                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                                <asp:ListItem Value="DiscountedType">Discounted Type</asp:ListItem>
                                                                <asp:ListItem Value="FullPay">Full Pay</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Product Type<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <asp:ListBox ID="ListProductType" runat="server" SelectionMode="Multiple" CssClass="3col active" ClientIDMode="Static" onchange="BindPlanbased();"></asp:ListBox>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Credit Limit<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <asp:TextBox ID="txtCreditLimit" runat="server" class="form-control Numeric" placeholder="Credit Limit" MaxLength="8" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Partner Type<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <asp:DropDownList ID="ddlPartnerType" runat="server" class="form-control select-user-drop-down">
                                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                                <asp:ListItem Value="RetailPartner">Retail Partner</asp:ListItem>
                                                                <asp:ListItem Value="KeyPartner">Key Partner</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4" id="RTA">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Retail Partner<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <asp:TextBox ID="txtRetailPartner" runat="server" class="form-control" Text="RTA" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4" id="KP">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Key Partner<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <asp:TextBox ID="txtKeypartner" runat="server" class="form-control" placeholder="Key Partner" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Wallet Type<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <asp:DropDownList ID="ddlWalletType" runat="server" class="form-control">
                                                                <asp:ListItem Value="0">Select</asp:ListItem>
                                                                <asp:ListItem Value="WalletPooling">Wallet Pooling</asp:ListItem>
                                                                <asp:ListItem Value="SeparateWallet">Separate Wallet</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Contract Start Date<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <asp:TextBox ID="txtContractSDate" runat="server" class="form-control" placeholder="dd/mm/yyyy" AutoCompleteType="Disabled"></asp:TextBox>
                                                            <asp:CalendarExtender ID="CalendarSDate" PopupButtonID="txtContractSDate" runat="server" TargetControlID="txtContractSDate" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Contract End Date<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <asp:TextBox ID="txtContractEDate" runat="server" class="form-control" placeholder="dd/mm/yyyy" AutoCompleteType="Disabled"></asp:TextBox>
                                                            <asp:CalendarExtender ID="CalendarEDate" PopupButtonID="txtContractEDate" runat="server" TargetControlID="txtContractEDate" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Upload Contract</label>
                                                        <div class="controls">
                                                            <asp:FileUpload ID="FileuploadContract" runat="server" class="form-control" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-8">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Commission Type<span class="starRed" style="color: red">*</span></label>
                                                        <div class="controls">
                                                            <label class="custom-input">
                                                                <input type="checkbox" id="radio1" name="RadioGroup" value="Plan_Based" />
                                                                <span class="check-radio"></span>
                                                                <span class="custom-input-label">Plan Based</span>
                                                            </label>
                                                            <label class="custom-input">
                                                                <input type="checkbox" id="radio2" name="RadioGroup1" value="Volume_Based" />
                                                                <span class="check-radio"></span>
                                                                <span class="custom-input-label">Volume Based</span>
                                                            </label>
                                                            <label class="custom-input">
                                                                <input type="checkbox" id="radio3" name="RadioGroup2" value="Amount_Based" />
                                                                <span class="check-radio"></span>
                                                                <span class="custom-input-label">Amount Based</span>
                                                            </label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <br />

                                            <div class="row" id="PlanBased">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label for="projectinput2" style="font-weight: bold">Plan Based</label>
                                                        <div class="controls">
                                                            <div class="col-md-12">
                                                                <div class="table-responsive" id="dvTable">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row" id="VolumeBased">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label for="projectinput2" style="font-weight: bold">Volume Based</label>
                                                        <div class="controls">
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Number of Policies/month<span class="starRed" style="color: red">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtNoOfPolicies" runat="server" class="form-control Numeric" placeholder="Number of Policies / month" MaxLength="8" AutoCompleteType="Disabled"></asp:TextBox>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-4" style="margin-left: 34%; margin-top: -88px;">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Commission Percentage (%)<span class="starRed" style="color: red">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtCommissionParcentage" runat="server" class="form-control Numeric" placeholder="Commission Percentage (%)" MaxLength="3" AutoCompleteType="Disabled"></asp:TextBox>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row" id="AmountBased">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <label for="projectinput2" style="font-weight: bold">Amount Based</label>
                                                        <div class="controls">
                                                            <div class="col-md-4">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Amount/month<span class="starRed" style="color: red">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtAmount_Month" runat="server" class="form-control Numeric" placeholder="Amount / month" MaxLength="8" AutoCompleteType="Disabled"></asp:TextBox>

                                                                    </div>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-4" style="margin-left: 34%; margin-top: -88px;">
                                                                <div class="form-group">
                                                                    <label for="projectinput2">Commission Percentage (%)<span class="starRed" style="color: red">*</span></label>
                                                                    <div class="controls">
                                                                        <asp:TextBox ID="txtCommPercentage" runat="server" class="form-control Numeric" placeholder="Commission Percentage (%)" MaxLength="3" AutoCompleteType="Disabled"></asp:TextBox>

                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="footer" align="right">
                                        <asp:Button ID="btnApprove" runat="server" Text="Submit" CssClass="btn btn-primary edit-bg create-user" OnClick="btnApprove_Click" />
                                        <asp:Button ID="Button1" runat="server" Text="Close" CssClass="btn btn-primary edit-bg create-user" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </div>

    <div id="MyModel_Approve" class="modal fade">
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
                    <p>Partner details approved successfully!</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg login-form-btn" id="Model_Disapprove" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModa1">Disapprove</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>
                </div>
                <div style="height: 25px">
                    <center><asp:Label ID="lblDisapproveMsg" runat="server" ></asp:Label> </center>
                </div>
                <div class="modal-body">
                    <div class="card">
                        <div class="card-body input-textbox">
                            <div class="row justify-content-center">
                                <div class="col-md-16">
                                    <asp:HiddenField ID="hdnPartnerId" runat="server" />

                                    <div class="form-group ">
                                        <label>Remarks</label>
                                        <asp:TextBox ID="txtDisapproveRemark" runat="server" CssClass="form-control" ClientIDMode="Static" TextMode="MultiLine" />
                                    </div>

                                    <div class="footer" align="right">
                                        <asp:Button ID="btnDisApprove" runat="server" Text="Submit" CssClass="btn btn-primary edit-bg create-user" OnClick="btnDisApprove_Click" />
                                        <asp:Button ID="Button3" runat="server" Text="Close" CssClass="btn btn-primary edit-bg create-user" OnClientClick="Refresh();" />
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


    <div class="modal dark_bg login-form-btn" id="Model_PartnerDetailsView" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div style="width: 75%; margin-left: 13%" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exa">Partner Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-content collapse show">
                                    <div class="card-body">
                                        <div class="form-body">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Partner Name</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblPartner_Name" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Partner EmailId</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblEmailId" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Partner Contact No</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblMobNo" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4" runat="server" id="Div_GSTNo">
                                                    <div class="form-group">
                                                        <label for="projectinput2">GST Number</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblGSTno" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Pan Card Number</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblPancardNo" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">State</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblState" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">City</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblCity" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Pin Code</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblPinCode" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Address</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblAddress" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Contact Person</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblContactPerson" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Contact Person Number</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblContactPersonNo" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Contact Person EmailId</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblContactPersonEmail" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4" runat="server" id="Div_AccNo">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Bank A/C No.</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblBAnkAcctNo" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4" runat="server" id="Div_BnkName">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Bank Name</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblBankName" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4" runat="server" id="Div_IFSC">
                                                    <div class="form-group">
                                                        <label for="projectinput2">IFSC Code</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblIFSCCode" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4" runat="server" id="Div_BenefName">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Beneficiary Name</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblBeneficiaryName" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4" runat="server" id="Div_BranchAddr">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Branch Address</label>
                                                        <div class="controls">
                                                            <asp:Label ID="lblBranchAddress" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4" id="Div_Pan" runat="server">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Pan Card File</label>
                                                        <div class="controls">
                                                            <div class="col-md-12">
                                                                <%--<a href="#ModalPancard" data-toggle="modal" data-target="#ModalPancard">
                                                                    <asp:Image ID="PancardImg" runat="server" alt="Generic placeholder image" Width="80px"></asp:Image></a>--%>
                                                                <asp:HyperLink id="HyperLinkPancardImg" runat="server" Text="Click here..." Target="_blank" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4" id="Div_CancelCheque" runat="server">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Cancel Cheque File</label>
                                                        <div class="controls">
                                                            <div class="col-md-12">
                                                               <%-- <a href="#ModalCheque" data-toggle="modal" data-target="#ModalPancard">
                                                                    <asp:Image ID="CancelChequeImg" runat="server" alt="Generic placeholder image" Width="80px"></asp:Image></a>--%>
                                                                <asp:HyperLink id="HyperLinkCancelChequeImg" runat="server" Text="Click here..." Target="_blank" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4" id="Div_Addr" runat="server">
                                                    <div class="form-group">
                                                        <label for="projectinput2">Address Proof File</label>
                                                        <div class="controls">
                                                            <div class="col-md-12">
                                                                <%--<a href="#ModalAddress" data-toggle="modal" data-target="#ModalAddress">
                                                                    <asp:Image ID="AddrImg" runat="server" alt="Generic placeholder image" Width="80px"></asp:Image></a>--%>
                                                                <asp:HyperLink id="HyperLinkAddrImg" runat="server" Text="Click here..." Target="_blank" />
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-md-4" id="Div_GST" runat="server">
                                                    <div class="form-group">
                                                        <label for="projectinput2">GST Registration File</label>
                                                        <div class="controls">
                                                            <div class="col-md-12">
                                                               <%-- <a href="#ModalGST" data-toggle="modal" data-target="#ModalGST">
                                                                    <asp:Image ID="GSTImg" runat="server" alt="Generic placeholder image" Width="80px"></asp:Image></a>--%>
                                                                  <asp:HyperLink id="HyperLinkGSTImg" runat="server" Text="Click here..." Target="_blank" />
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

    <div class="modal dark_bg fade login-form-btn" id="ModalPancard" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div class="row ">
                        <div class="col-lg-16">
                            <asp:Image ID="imgFirst" runat="server" ImageUrl='<%#Eval("PAN_Image") %>' alt="Generic placeholder image" Width="100%" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div class="modal dark_bg fade login-form-btn" id="ModalCheque" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalC"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div class="row ">
                        <div class="col-lg-16">
                            <asp:Image ID="imgSecond" runat="server" ImageUrl='<%#Eval("Cheque_Image") %>' alt="Generic placeholder image" Width="100%" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg fade login-form-btn" id="ModalAddress" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalC1"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div class="row ">
                        <div class="col-lg-16">
                            <asp:Image ID="imgThird" runat="server" ImageUrl='<%#Eval("AddrProofImg") %>' alt="Generic placeholder image" Width="100%" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg fade login-form-btn" id="ModalGST" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ModalC2"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div class="row ">
                        <div class="col-lg-16">
                            <asp:Image ID="imgFourth" runat="server" ImageUrl='<%#Eval("GSTRegImg") %>' alt="Generic placeholder image" Width="100%" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

