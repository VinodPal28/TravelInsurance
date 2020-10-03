<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="CancelledPolicies.aspx.cs" Inherits="Admin_CancelledPolicies" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script>
        function ViewMsg() {
            setTimeout(function () {
                $("#Model_CancelledPolicies").modal('show');
            }, 100);
        }
    </script>

    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">Cancelled Policies</h1>
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
                                        <asp:GridView ID="GV_CancelledPolicy" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" Width="100%" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                            PagerStyle-CssClass="bs-pagination" OnPageIndexChanging="GV_CancelledPolicy_PageIndexChanging" OnRowCommand="GV_CancelledPolicy_RowCommand">

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

                                                 <asp:TemplateField HeaderText="Cancellation Number">
                                                    <ItemTemplate>                                                        
                                                        <asp:Label ID="lblCanNo" runat="server" Text='<%#Bind("PolicyCancellationNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Issues Date" >
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblissues_dtt" runat="server" Text='<%#Bind("IssueDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Policy Start date" >
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

                                                <asp:TemplateField HeaderText="Partner Name" >
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

    <div class="modal dark_bg login-form-btn" id="Model_CancelledPolicies" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
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
                                                            <asp:TextBox ID="txtPolicyNo" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Geography/Ask country</label>
                                                            <asp:TextBox ID="txtCountry" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Issuance Date</label>
                                                            <asp:TextBox ID="txtIssueDate" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Travel Start Date</label>
                                                            <asp:TextBox ID="txtstartdtt" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Travel End Date</label>
                                                            <asp:TextBox ID="txtEnddtt" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Plan Name</label>
                                                            <asp:TextBox ID="txtPlanName" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Total Price</label>
                                                            <asp:TextBox ID="txtPrices" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
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
                                                                    <asp:TextBox ID="txtName" runat="server" class="form-control" placeholder="First Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">DOB</label>
                                                                <asp:TextBox ID="txtdob" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Contact Number</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtNumber" runat="server" class="form-control" placeholder="Contact Number" MaxLength="10" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Email</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtEmailid" runat="server" class="form-control" placeholder="Email " ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Nominee Name</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtNomineeNames" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="card-body" runat="server" id="CompanyInfo">
                                            <h1>Company Information</h1>
                                            <hr />
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Name</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompName" runat="server" class="form-control" placeholder="First Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Email Id</label>
                                                                <asp:TextBox ID="txtCompEmailID" runat="server" class="form-control" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">GSTIN</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompGSTIN" runat="server" class="form-control" placeholder="Contact Number" MaxLength="10" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">State</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompState" runat="server" class="form-control" placeholder="Email " ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">City</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompCity" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Address</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompAddress" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
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
    </div>
</asp:Content>

