<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="PoliciesCancelled.aspx.cs" Inherits="Admin_PoliciesCancelled" ClientIDMode="Static" EnableEventValidation="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  
      <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script>
        function Showage() {
            setTimeout(function () {               
                $("#Model_Approve").modal('show');
                return false;
            }, 100);
        }
        function ShowApprove() {
            setTimeout(function () {
                $("#ModalApproveMsg").modal('show');
            }, 100);
        }

        function ShowDisapprove() {
            setTimeout(function () {
                $("#ModalDisapproveMsg").modal('show');
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
            $("#btnPolicyDisapprove").click(function (e) {
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
            <div class="content-body">
                <h1 class="h1Tag">Policy Cancellation Request </h1>
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">

                            <div class="card-content">
                                <div class="table-responsive">
                                    <table class="table table-de mb-0">

                                        <center><asp:Label ID="SpnMsg" runat="server" ClientIDMode="Static"></asp:Label></center>
                                        <asp:Label ID="lblerrorMsg" runat="server"></asp:Label>
                                        <asp:GridView ID="GV_PolicyCancelled" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                            PagerStyle-CssClass="bs-pagination" Width="100%" OnRowCommand="GV_PolicyCancelled_RowCommand">

                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                        <asp:Label ID="Policy_Id" runat="server" Text='<%#Bind("Policy_Id") %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lblPolicyCanNo" runat="server" Text='<%#Bind("Cancellation_No") %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lblPolicyNo" runat="server" Text='<%#Bind("Policy_No") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Policy Number">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPolicy_No" runat="server" Text='<%#Bind("PolicyCancellationNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Issues Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblissues_dtt" runat="server" Text='<%#Bind("issues_dtt") %>'></asp:Label>
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
                                                <asp:TemplateField HeaderText="Partner Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPartner_Name" runat="server" Text='<%#Bind("Partner_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                

                                                <asp:TemplateField HeaderText="Total Price">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTotal_Price" runat="server" Text='<%#Bind("Price") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>


                                                <asp:TemplateField HeaderText="View">
                                                    <ItemTemplate>

                                                        <asp:Button ID="btnView" runat="server" class="btn btn-sm round btn-outline-danger" Text="View" CommandName="Approve" CommandArgument='<%# Container.DataItemIndex + 1 %>'></asp:Button>

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

    
    <div class="modal dark_bg login-form-btn" id="Model_Approve" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div style="width: 60%; margin-left: 20%" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel2">Policy Cancellation details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-content collapse show">
                                    <div class="card-body">
                                        <h1>Policy Cancellation Request</h1>
                                        <hr />
                                        <div class="card-body">
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Policy Cancellation Number<span class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtPolicyCanNo" runat="server" Text='<%#Bind("Cancellation_No") %>' Visible="false"></asp:TextBox>
                                                            <asp:TextBox ID="txtPolicyNo" runat="server" Text='<%#Bind("Policy_No") %>' Visible="false"></asp:TextBox>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtPolicyNumber" runat="server" class="form-control" placeholder="Policy Number" ReadOnly="true"></asp:TextBox>
                                                                <asp:TextBox ID="txtpolicyID" runat="server" Visible="false"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Issues Date<span class="starRed"></span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtIssuesDate" runat="server" class="form-control" placeholder="Issues Date" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Policy Start date<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtPolicyStartdate" runat="server" class="form-control" placeholder="Start date" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Policy End date<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtPolicyEnddate" runat="server" class="form-control" placeholder="End date" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Partner Name<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtPartnerName" runat="server" class="form-control" placeholder="Partner Name " ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                   <%-- <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Partner Code<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="TxtPartnerCode" runat="server" class="form-control" placeholder="Partner Code" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>--%>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Total Price<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtTotalPrice" runat="server" class="form-control" placeholder="Total Price" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Reason<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="ddlReason" runat="server" CssClass="form-control" ReadOnly="true" Enabled="False"></asp:DropDownList>

                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>

                                    <div class="card-body" runat="server" id="CustInfo">                                     
                                        <div>
                                            <h1>Customer Information</h1>
                                            <hr />
                                        </div>

                                        <div class="card-body">

                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">First Name<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtFirstname" runat="server" class="form-control" placeholder="First Name" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Middle Name<span class="starRed"></span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtMiddlename" runat="server" class="form-control" placeholder="Middle Name" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Last Name<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtLastname" runat="server" class="form-control" placeholder="Last Name " ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Contact Number<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtContactNumber" runat="server" class="form-control" placeholder="Contact Number" MaxLength="10" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Email<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtEmail" runat="server" class="form-control" placeholder="Email " ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                      <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">State<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtState" runat="server" class="form-control" placeholder="State" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">City<span class="starRed">*</span></label>
                                                            <div class="controls">

                                                                <asp:TextBox ID="txtCity" runat="server" class="form-control" placeholder="Citry" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Pin Code<span class="starRed">*</span></label>
                                                            <div class="controls">

                                                                <asp:TextBox ID="txtPinCode" runat="server" class="form-control" placeholder="Pin Code" MaxLength="6" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Aadhaar<span class="starRed">*</span></label>
                                                            <div class="controls">

                                                                <asp:TextBox ID="txtAadhaar" runat="server" class="form-control" placeholder="Aadhaar" MaxLength="12" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Pan No<span class="starRed">*</span></label>
                                                            <div class="controls">

                                                                <asp:TextBox ID="txtPanNo" runat="server" class="form-control" placeholder="Pan No" MaxLength="10" onblur="fnValidatePAN(this);" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Address<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtNomineeAddres" runat="server" class="form-control" placeholder="Address" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-body" runat="server" id="CompanyInfo">                                     
                                        <div>
                                            <h1>Company Information</h1>
                                            <hr />
                                        </div>

                                        <div class="card-body">

                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Name<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompName" runat="server" class="form-control" placeholder="First Name" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">GSTIN<span class="starRed"></span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtGSTIN" runat="server" class="form-control" placeholder="Middle Name" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Email ID<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompEmail" runat="server" class="form-control" placeholder="Last Name " ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>     

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Address<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompAddr" runat="server" class="form-control" placeholder="Address" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="card-body">
                                        <div>
                                            <h1>Nominee Information</h1>
                                            <hr />
                                        </div>
                                        <div class="card-body">
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Nominee Name<span class="starRed">*</span></label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtNomineename" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                     <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Nominee Relation<span class="starRed">*</span></label>
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
                                        <asp:LinkButton ID="btnPolicyDisapprove" runat="server" type="submit" CssClass="btn btn-success" OnClick="btnPolicyDisapprove_Click" CausesValidation="false" ClientIDMode="Static">Disapprove</asp:LinkButton>
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
                                            <asp:LinkButton ID="btnPolicyCancellation" runat="server" type="submit" CssClass="btn btn-success" OnClick="btnPolicyCancellation_Click" CausesValidation="false" ClientIDMode="Static">Approve </asp:LinkButton>
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

            <div id="ModalApproveMsg" class="modal fade">
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
                            <p>Cancellation Policy has been approved !</p>
                            <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
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
</asp:Content>

