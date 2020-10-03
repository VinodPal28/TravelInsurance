<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Report.aspx.cs" Inherits="Admin_Report" EnableEventValidation="false" ClientIDMode="Static" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Assets/js/Valid.js"></script>
    <script src="../Assets/js/jquery.min.js"></script>
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <style>
        .Endorsed {
            color: #57e6e6;
            border-color: #57e6e6;
            background-color: transparent;
            min-width: 70px;
        }

        .Cancelled {
            color: #ef1717;
            border-color: #ef1717;
            background-color: transparent;
            min-width: 70px;
        }
    </style>

    <script>
        $(function () {
            $('select[multiple].active.3col1').multiselect({
                columns: 0,
                placeholder: 'Select Policy Type',
                search: true,
                searchOptions: {
                    'default': 'Search Policy Type'
                },
                selectAll: true
            });
        });
        $(function () {
            $('.multiselect-ui').multiselect({
                includeSelectAllOption: true
            });
        });
    </script>

    <script type="text/javascript">
        $(function () {
            $('body').on('change', '#ddlPartner', function () {
                var selected_PartnerId = $(this).val();
                $.ajax({
                    type: "POST",
                    url: "Report.aspx?Action=SubPartner&id=" + selected_PartnerId,
                    data: { 'selected_PartnerId': selected_PartnerId },
                    success: function (r) {
                        var myObj = $.parseJSON(r);
                        var ddlCity = "";
                        var select = $("#ddlSubPartner");
                        select.empty();
                        $.each(myObj, function (key, value) {
                            var content = '<option value="' + value.ID + '">' + value.Partner_Name + '</option>';
                            select.append(content);
                        });
                        $('#ddlSubPartner').selectpicker("refresh");
                    }
                });
            });
            $(function () {
                $("#ddlSubPartner").change(function () {
                    $('#hdnSubPartnerId').val(this.value);

                });
            });
        });
        function process(date) {
            var parts = date.split("/");
            return new Date(parts[2], parts[1] - 1, parts[0]);
        }
        $(document).ready(function () {
            $('#btnSubmit').click(function (e) {
                if ($('#txtpolicyNo').val() != '') {

                }
                else {

                    if ($('#txtFromDate').val() == "") {
                        $('#lblMsg').text('Select from date').css("color", "red");
                        $('#txtFromDate').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if ($('#txtToDate').val() == "") {
                        $('#lblMsg').text('Select to date').css("color", "red");
                        $('#txtToDate').focus();
                        e.preventDefault();
                        return false;
                    }
                    else if (process($('#txtFromDate').val()) > process($('#txtToDate').val())) {
                        $("#lblMsg").text("*To Date should be greater than from Date").css("color", "red");
                        $('#txtToDate').focus();
                        e.preventDefault();
                        return false;
                    }
                }
            });
            $('#btnReset').click(function (e) {
                $('#txtFromDate').val('');
                $('#txtToDate').val('');
                $('#txtpolicyNo').val('');
                $('#ddlPartner').empty();
                $('#ddlSubPartner').empty();
                $('#ddlPaymentStatus').empty();
                $('#ddlPlanName').empty();
                $('#ListPolicyType').val('');
            });
        });

    </script>

    <asp:ScriptManager ID="ScriptManager1" runat="server" />
    <div class="app-content content">
        <%--  <div class="content-wrapper">--%>
        <%-- <div class="content-header row">
            </div>--%>
        <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" ClientIDMode="Static"></asp:Label>
        <asp:HiddenField ID="hdnSubPartnerId" runat="server" />
        <div class="content-body">
            <h1 class="h1Tag">Report</h1>
            <!-- Active Orders -->
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div style="height: 20px">
                            <center><asp:Label ID="lblMsg" runat="server" ClientIDMode="Static"></asp:Label></center>
                        </div>
                        <div class="card-content collapse show">
                            <div class="card-body">

                                <div class="form-body">
                                    <div class="row">

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>From Date<font color="red">*</font> </label>
                                                <asp:TextBox ID="txtFromDate" runat="server" class="form-control" placeholder="dd/mm/yyyy" AutoCompleteType="Disabled"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarFromDate" PopupButtonID="txtFromDate" runat="server" TargetControlID="txtFromDate" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>To Date<font color="red">*</font></label>
                                                <asp:TextBox ID="txtToDate" runat="server" class="form-control" placeholder="dd/mm/yyyy" AutoCompleteType="Disabled"></asp:TextBox>
                                                <asp:CalendarExtender ID="CalendarToDate" PopupButtonID="txtToDate" runat="server" TargetControlID="txtToDate" Format="dd/MM/yyyy"></asp:CalendarExtender>
                                            </div>
                                        </div>

                                        <div class="col-md-6" runat="server" id="Div_PartnerName">
                                            <div class="form-group">
                                                <label>Partner Name</label>
                                                <asp:DropDownList ID="ddlPartner" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="col-md-6"  runat="server" id="Div_SubPartnerName">
                                            <div class="form-group">
                                                <label>Sub-Partner Name</label>
                                                <asp:DropDownList ID="ddlSubPartner" runat="server" CssClass="form-control" ClientIDMode="Static"></asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group ">
                                                <label>Policy Type</label>
                                                <asp:ListBox ID="ListPolicyType" runat="server" SelectionMode="Multiple" CssClass="3col1 active" ClientIDMode="Static">
                                                    <asp:ListItem Value="1">Issued Policy</asp:ListItem>
                                                    <asp:ListItem Value="0">Cancelled Policy</asp:ListItem>
                                                    <asp:ListItem Value="4">Endorsed Policy</asp:ListItem>
                                                    <asp:ListItem Value="6">Extended Policy</asp:ListItem>
                                                </asp:ListBox>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Policy Number</label>
                                                <asp:TextBox ID="txtpolicyNo" runat="server" CssClass="form-control" placeholder="Policy Number" AutoCompleteType="Disabled"></asp:TextBox>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Payment Status</label>
                                                <asp:DropDownList ID="ddlPaymentStatus" runat="server" CssClass="form-control" ClientIDMode="Static">
                                                    <asp:ListItem Value="0">Select</asp:ListItem>
                                                    <asp:ListItem Value="Received">Received</asp:ListItem>
                                                    <asp:ListItem Value="NotReceived">Not Received</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                        <div class="col-md-6">
                                            <div class="form-group">
                                                <label>Plan Name</label>
                                                <asp:DropDownList ID="ddlPlanName" runat="server" CssClass="form-control" ClientIDMode="Static">
                                                </asp:DropDownList>
                                            </div>
                                        </div>

                                    </div>
                                    <br />
                                    <div class="text-left">
                                        <asp:LinkButton ID="btnSubmit" runat="server" Text="Submit" class="btn btn-success" ClientIDMode="Static" OnClick="btnSubmit_Click"><i class="la la-thumbs-o-up position-right"></i> Submit</asp:LinkButton>
                                        <asp:LinkButton ID="btnReset" runat="server" Text="Reset" class="btn btn-danger reset-btn"><i class="la la-refresh position-right"></i> Reset</asp:LinkButton>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="row" runat="server" id="DivReport">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <%--<h4 class="card-title">Report</h4>--%>
                            <div class="row" runat="server" id="Div_Id">
                                <div class="col-md-6">
                                    <asp:Button ID="btnExportToexcel" runat="server" CssClass="btn btn-primary edit-bg create-user" Text="Export to Excel" OnClick="btnExportToexcel_Click" />
                                </div>
                                <div class="col-md-6" style="text-align:right">
                                    <label><b>Total No. Of Policies :</b>  <span runat="server" id="NoOfPolicies"></span></label>
                                </div>
                            </div>

                        </div>
                        <div class="card-content">
                            <div class="table-responsive" id="Gridview-container">
                                <asp:GridView ID="GV_Report" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                    PagerStyle-CssClass="bs-pagination" Width="100%" OnRowDataBound="GV_Report_RowDataBound" OnPageIndexChanging="GV_Report_PageIndexChanging">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No." ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Policy No" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPolicyNo" runat="server" Text='<%#Bind("Policy_No") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Issued On" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblIssued_On" runat="server" Text='<%#Bind("Issued_On") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Start Date" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblStart_Date" runat="server" Text='<%#Bind("Start_Date") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="End Date" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblEnd_Date" runat="server" Text='<%#Bind("End_Date") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Name" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblName" runat="server" Text='<%#Bind("Name") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Mobile No" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblMob_No" runat="server" Text='<%#Bind("Mob_No") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Total Premium" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPrice" runat="server" Text='<%#Bind("Total_Premium") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:TemplateField HeaderText="Status" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                            <ItemTemplate>
                                                <asp:Label ID="lblPolicy_Status" runat="server" Text='<%#Bind("Policy_Status") %>'></asp:Label>
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
        <%--</div>--%>
    </div>
</asp:Content>

