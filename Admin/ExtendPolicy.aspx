<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ExtendPolicy.aspx.cs" Inherits="Admin_ExtendPolicy" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        function ViewMsg() {
            setTimeout(function () {
                $("#Model_ExtendPolicies").modal('show');
            }, 100);
        }
    </script>

    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">Extended Policies</h1>
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
                                        <asp:GridView ID="GV_ExtendPolicy" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                            PagerStyle-CssClass="bs-pagination" Width="100%" OnPageIndexChanging="GV_ExtendPolicy_PageIndexChanging" OnRowCommand="GV_ExtendPolicy_RowCommand">

                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                        <asp:Label ID="lblPolicyId" runat="server" Text='<%#Bind("Policy_Id") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Policy Number">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="LinkPolicyNo" runat="server" Text='<%#Bind("Policy_No") %>' ForeColor="Blue" CommandName="View" CommandArgument='<%# Container.DataItemIndex + 1 %>'></asp:LinkButton>
                                                        <asp:Label ID="lblPolicy_No" runat="server" Text='<%#Bind("Policy_No") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Extend Number">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCanNo" runat="server" Text='<%#Bind("PolicyExtendNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Issues Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblissues_dtt" runat="server" Text='<%#Bind("IssueDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Policy Start date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTravel_Start_Date" runat="server" Text='<%#Bind("Travel_Start_Date") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Policy End date">
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

    <div class="modal dark_bg login-form-btn" id="Model_ExtendPolicies" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
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
                                                            <label for="projectinput2">Issued on</label>
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
                                                            <label for="projectinput2">Total Price</label>
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
                                                                <label for="projectinput2">Customer Name</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtName" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Contact Number</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtNumber" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Email</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtEmailid" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Pan No.</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="lblPanNo" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Aadhaar No.</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="lblAadharNo" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Passport No.</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="lblPassportNo" runat="server" class="form-control"></asp:Label>
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
                                                                    <asp:Label ID="lblAddr" runat="server" class="form-control"></asp:Label>
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
                                                                    <asp:Label ID="lblCompName" runat="server" class="form-control" ></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">GSTIN</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="lblGSTIN" runat="server" class="form-control" ></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Email</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="lblCompEmailID" runat="server" class="form-control" ></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                                                                          
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">State</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="lblCompState" runat="server" class="form-control" ></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">City</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="lblCompCity" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Pin Code</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="lblCompPin" runat="server" class="form-control" ></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Address</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="lblCompAddr" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div><br />

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
                                                                    <asp:Label ID="lblNomineerelations" runat="server" class="form-control"></asp:Label>
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

