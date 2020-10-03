<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="PaymentStatus.aspx.cs" Inherits="Admin_PaymentStatus" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Assets/js/jquery.min.js"></script>

    <style>
        .table-responsive {
            position: relative;
        }

            .table-responsive table {
                margin-top: 38px;
            }

            .table-responsive .bs-pagination {
                position: absolute;
                top: -24px;
            }

        .table.table-de th, .table.table-de td {
            padding: .75rem 1rem;
        }

        body {
            font-family: Arial;
            font-size: 10pt;
        }

        .selected {
            background-color: #A1DCF2;
        }
    </style>

    
    <script type="text/javascript" lang="javascript">
        function ViewMsg() {
            setTimeout(function () {
                $("#Model_IssuedPolicies").modal('show');
            }, 100);
        }
        function ShowMessage() {
            setTimeout(function () {
                $("#ModalMsg").modal('show');
            }, 100);
        }

    </script>

    <div class="app-content content">
        <%--   <div class="content-wrapper">--%>
        <div class="content-header row">
        </div>
        <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
        <div class="content-body">
            <h1 class="h1Tag">Payment Status</h1>
            <br />
            <!-- Active Orders -->
            <%--  <div class="row" style="text-align: right;margin-top: -5%;" runat="server" id="Div_BtnExport">
                    <div class="col-md-12">
                        <div class="form-group">
                            <asp:Button ID="btnExportToExcel" runat="server" CssClass="btn btn-primary" Text="Export To Excel" OnClick="btnExportToExcel_Click" />
                        </div>
                    </div>
                </div>--%>

            <div class="row">
                <div class="col-12">
                    <div class="card">
                        <!-- start search -->
                        <div class="pull-right">
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label for="projectinput1">Search</label>
                                    <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" class="form-control" placeholder="Policy No / Customer Name / Date(dd/mm/yyyy)" AutoCompleteType="Disabled" OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-8" style="text-align:right;margin-top:32px">
                                <div class="form-group">
                                    <label for="projectinput1"></label>
                                    <asp:Button ID="btnSubmit" runat="server" class="btn btn-sm round btn-outline-danger" Text="Receive Payment" OnClick="btnSubmit_Click"></asp:Button>
                                </div>
                            </div>
                        </div>

                        <!-- end search -->
                        <div class="card-content">
                            <div class="table-responsive">
                                <table class="table table-de mb-0">
                                    <%--<asp:Button ID="btnSubmit" runat="server" class="btn btn-sm round btn-outline-danger" Text="Payment Received" ></asp:Button>--%>
                                    <asp:GridView ID="GV_PaymentStatus" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                        PagerStyle-CssClass="bs-pagination" Width="100%" OnPageIndexChanging="GV_PaymentStatus_PageIndexChanging" OnRowCommand="GV_PaymentStatus_RowCommand">

                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr.No.">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    <asp:Label ID="lblPolicyId" runat="server" Text='<%#Bind("Policy_Id") %>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField>
                                                <HeaderTemplate>
                                                    <%--<asp:CheckBox ID="chkSelectAll" ToolTip="Click here to select/deselect all rows" runat="server" AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" />--%>
                                                    <asp:CheckBox ID="chkSelectAll" ToolTip="Click here to select/deselect all rows" runat="server" AutoPostBack="true" OnCheckedChanged="chkSelectAll_CheckedChanged" />
                                                </HeaderTemplate>

                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkSelect" runat="server" />

                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Policy Number">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkPolicyNo" runat="server" Text='<%#Bind("Policy_No") %>' ForeColor="Blue" CommandName="View" CommandArgument='<%# Container.DataItemIndex + 1 %>'></asp:LinkButton>
                                                    <asp:Label ID="lblPolicy_No" runat="server" Text='<%#Bind("Policy_No") %>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Issued On">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblissues_dtt" runat="server" Text='<%#Bind("IssueDate") %>'></asp:Label>
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

                                            <asp:TemplateField HeaderText="Customer Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCustomer_Name" runat="server" Text='<%#Bind("Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Partner Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPartner_Name" runat="server" Text='<%#Bind("Partner_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Total Price">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTotal_Price" runat="server" Text='<%#Bind("TotalPrice") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnPaymentStatus" runat="server" class="btn btn-sm round btn-outline-danger" Text="Receive Payment" CommandName="PaymentReceived"></asp:Button>
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
    <%-- </div>--%>

    <div class="modal dark_bg login-form-btn" id="Model_IssuedPolicies" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div style="width: 60%; margin-left: 20%" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel3">View Policy Details</h5>
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
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Policy Number</label>
                                                            <asp:Label ID="txtPolicyNo" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Geography Cover</label>
                                                            <asp:Label ID="txtCountry" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Issuance Date</label>
                                                            <asp:Label ID="txtIssueDate" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Travel Start Date</label>
                                                            <asp:Label ID="txtstartdtt" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Travel End Date</label>
                                                            <asp:Label ID="txtEnddtt" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Plan Name</label>
                                                            <asp:Label ID="txtPlanName" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Total Premium</label>
                                                            <asp:Label ID="txtPrices" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">DOB</label>
                                                            <asp:Label ID="txtdob" runat="server" class="form-control"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                        </div>

                                        <div class="card-body" runat="server" id="CustInfo">
                                            <h1>Customer Information</h1>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Name</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtName" runat="server" class="form-control" placeholder="First Name"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Contact Number</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtNumber" runat="server" class="form-control" placeholder="Contact Number"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Email</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtEmailid" runat="server" class="form-control" placeholder="Email "></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Aadhar No</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtAdhar" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Pan No</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtPanNo" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">State</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtState" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">City</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtCity" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Pin Code</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtPinCode" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Address</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtAddr" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="CompInfo">
                                            <h1>Company Information</h1>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Company Name</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtCompName" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">GSTIN</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtGSTIN" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Email</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtCompEmailID" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">State</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtCompState" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">City</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtCompCity" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Pin Code</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtCompPin" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Address</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtCompAddr" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <br />

                                                    <div class="table-responsive">
                                                        <table class="table table-de mb-0">
                                                            <asp:GridView ID="GV_MiceInfo" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" Width="100%">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblMiceName" runat="server" Text='<%#Bind("Name") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Passport No">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblMicePassportNo" runat="server" Text='<%#Bind("PassportNo") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Mobile No">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblMiceMobNo" runat="server" Text='<%#Bind("MobNo") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Email">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblMiceEmailID" runat="server" Text='<%#Bind("EmailId") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Gender">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblGender" runat="server" Text='<%#Bind("Gender") %>'></asp:Label>
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

                                        <div class="card-body">
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Nominee Name</label>
                                                            <div class="controls">
                                                                <asp:Label ID="txtNomineeNames" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Nominee Relation</label>
                                                            <div class="controls">
                                                                <asp:Label ID="txtNomineeRelation" runat="server" class="form-control"></asp:Label>
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

     <div id="ModalMsg" class="modal fade">
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
                    <p>Payment status submitted successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

