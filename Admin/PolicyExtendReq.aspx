<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="PolicyExtendReq.aspx.cs" Inherits="Admin_PolicyExtendReq" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        function View() {
            setTimeout(function () {
                $("#MyModel_View").modal('show');
                return false;
            }, 100);
        }
        function DisApprove() {
            setTimeout(function () {
                $("#MyModel_Disapprove").modal('show');
                return false;
            }, 100);
        }
        function Approve() {
            setTimeout(function () {
                $("#Modal_Approve").modal('show');
                return false;
            }, 100);
        }
        function Walletbalance() {
            setTimeout(function () {
                $("#MyModel_CheckBalance").modal('show');
                return false;
            }, 100);
        }
    </script>

    <script>
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

    <script>
        $(document).ready(function () {
            if ($('#lblExPolicyStartdate').text() != $('#lblExtendSdate').text()) { $('#lblExtendSdate').css("background", "yellow"); }
            if ($('#lblExPolicyEnddate').text() != $('#lblExtendEdate').text()) { $('#lblExtendEdate').css("background", "yellow"); }
            if ($('#lblExTotalPrice').text() != $('#lblExtendTotalPremium').text()) { $('#lblExtendTotalPremium').css("background", "yellow"); }

            $("#btnPolicyEnorseDisapprove").click(function (e) {
                var Remark = $("#txtRemark").val();
                if (Remark == "") {
                    $("#lblmsg3").text("*Enter the Remark").css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else {
                    $("#lblmsg3").text("").css("color", "red")
                }
            });
        });
    </script>

    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">Policy Extend Request</h1>
                <br />
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-content">
                                <div class="table-responsive">
                                    <table class="table table-de mb-0">
                                        <asp:GridView ID="GV_PolicyExtendReq" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                            PagerStyle-CssClass="bs-pagination" Width="100%" OnRowCommand="GV_PolicyExtendReq_RowCommand">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Policy No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPolicyNo" runat="server" Text='<%#Bind("Policy_No") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Policy Issued on">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblIssuedOn" runat="server" Text='<%#Bind("IssuedOn") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Policy Start Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPolicySdate" runat="server" Text='<%#Bind("Travel_Start_Date") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Policy End Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPolicyEdate" runat="server" Text='<%#Bind("Travel_End_Date") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <%-- <asp:TemplateField HeaderText="Customer Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCustName" runat="server" Text='<%#Bind("Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Partner Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPartner_Name" runat="server" Text='<%#Bind("Partner_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Total Premium">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPrice" runat="server" Text='<%#Bind("Price") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="View">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnView" runat="server" class="btn btn-sm round btn-outline-danger" Text="View" CommandName="View" CommandArgument='<%# Container.DataItemIndex + 1 %>'></asp:Button>
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

    <div class="modal dark_bg login-form-btn" id="MyModel_View" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div style="width: 60%; margin-left: 20%" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel2">Policy Details</h5>
                    <div style="margin-left: 60%;">
                        <span id="WalletBlnce" runat="server" class="btn btn-primary pull-right">Wallet Balance : <i class="fa fa-rupee" aria-hidden="true"></i>
                            <asp:Label ID="lblWalletBlnce" runat="server" Font-Bold="true"></asp:Label></span>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-content collapse show">
                                    <div class="card-body">
                                        <div class="card-body">
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Policy Number</label>
                                                            <div class="controls">
                                                                <asp:HiddenField ID="PartnerId" runat="server" />
                                                                <asp:Label ID="lblPolicy_No" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Geography Cover</label>
                                                            <div class="controls">
                                                                <asp:Label ID="lblGeoName" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Plan Name</label>
                                                            <div class="controls">
                                                                <asp:Label ID="lblPlanName" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">DOB</label>
                                                            <div class="controls">
                                                                <asp:Label ID="lblDOB" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Issued on</label>
                                                            <div class="controls">
                                                                <asp:Label ID="lblIssuedon" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Existing Policy Start date</label>
                                                            <div class="controls">
                                                                <asp:Label ID="lblExPolicyStartdate" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Existing Policy End date</label>
                                                            <div class="controls">
                                                                <asp:Label ID="lblExPolicyEnddate" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Existing Total Premium</label>
                                                            <div class="controls">
                                                                <asp:Label ID="lblExTotalPrice" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Extend Policy Start date</label>
                                                            <div class="controls">
                                                                <asp:Label ID="lblExtendSdate" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Extend Policy End date</label>
                                                            <div class="controls">
                                                                <asp:Label ID="lblExtendEdate" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Extend Total Premium</label>
                                                            <div class="controls">
                                                                <asp:Label ID="lblExtendTotalPremium" runat="server" class="form-control"></asp:Label>
                                                            </div>
                                                        </div>
                                                    </div>


                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div runat="server" id="CustInfo">
                                        <div class="card-body">
                                            <div>
                                                <h1>Customer Information</h1>
                                                <hr />
                                            </div>
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Name</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtname" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Contact Number</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtContactNumber" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Email</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtEmail" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Passport No</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtPassportNo" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Aadhaar</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtAadhaar" runat="server" class="form-control"></asp:Label>
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
                                                                <label for="projectinput2">Address</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="lblCustAddr" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Nominee Name</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtNomineename" runat="server" class="form-control"></asp:Label>
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

                                    <div runat="server" id="CompInfo">
                                        <div class="card-body">
                                            <div>
                                                <h1>Company Information</h1>
                                                <hr />
                                            </div>
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Name</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtCOmpName" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Email</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtCompEmail" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">GSTIN</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtCompGSTIN" runat="server" class="form-control"></asp:Label>
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

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Nominee Name</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtCompNomiName" runat="server" class="form-control"></asp:Label>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Nominee Relation</label>
                                                                <div class="controls">
                                                                    <asp:Label ID="txtCompNomineeRelation" runat="server" class="form-control"></asp:Label>
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
                                                    <center>   <asp:TextBox ID="txtRemark" runat="server" class="form-control" placeholder="Remark" TextMode="MultiLine" Width="100%"></asp:TextBox></center>
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
        </div>
    </div>

    <div id="MyModel_Disapprove" class="modal fade show">
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

    <div id="Modal_Approve" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h4>Approved!</h4>
                    <p>Extend Policy has been approved !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal dark_bg fade login-form-btn" id="MyModel_CheckBalance" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content" style="border: 1px solid black; width: 109%;">
                <div class="modal-header" style="border-bottom: 1px solid black;">
                    <h5 class="modal-title" id="exampleModalLabel1"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="refresh();">
                        <span aria-hidden="true"><b>x</b></span>
                    </button>
                </div>
                <div class="modal-body">
                    <p style="color: red; margin-left: 3%">Requested Partner have Insufficient balance in wallet to extend the policy.</p>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

