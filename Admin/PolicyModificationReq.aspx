<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="PolicyModificationReq.aspx.cs" Inherits="Admin_PolicyModificationReq" ClientIDMode="Static" %>

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
        function Disapprove() {
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
            if ($('#txtname').val() != $('#txtEndorseName').val()) {
                $('#txtEndorseName').css("background", "yellow");
            }
            if ($('#txtTitle').val() != $('#txtEndorseTitle').val()) { $('#txtEndorseTitle').css("background", "yellow"); }
            if ($('#txtContactNumber').val() != $('#txtEndorseMobNo').val()) { $('#txtEndorseMobNo').css("background", "yellow"); }
            if ($('#txtEmail').val() != $('#txtEndorseEmail').val()) { $('#txtEndorseEmail').css("background", "yellow"); }
            if ($('#txtAadhaar').val() != $('#txtEndorseNomiAdhar').val()) { $('#txtEndorseNomiAdhar').css("background", "yellow"); }
            if ($('#txtPanNo').val() != $('#txtEndorseNomiPAN').val()) { $('#txtEndorseNomiPAN').css("background", "yellow"); }
            if ($('#txtNomineeAddres').val() != $('#txtEndorseNomiAddr').val()) { $('#txtEndorseNomiAddr').css("background", "yellow"); }
            if ($('#txtNomineename').val() != $('#txtEndorseNomiName').val()) { $('#txtEndorseNomiName').css("background", "yellow"); }
            if ($('#txtNomineeRelation').val() != $('#txtEndorseNomineeRelation').val()) { $('#txtEndorseNomineeRelation').css("background", "yellow"); }
            if ($('#txtPassportNo').val() != $('#txtEndorsePassportNo').val()) { $('#txtEndorsePassportNo').css("background", "yellow"); }
            if ($('#txtDOB').val() != $('#txtEndorseDOB').val()) { $('#txtEndorseDOB').css("background", "yellow"); }
            if ($('#txtPolicyStartdate').val() != $('#txtEndorseSdate').val()) { $('#txtEndorseSdate').css("background", "yellow"); }
            if ($('#txtPolicyEnddate').val() != $('#txtEndorsEdate').val()) { $('#txtEndorsEdate').css("background", "yellow"); }

            if ($('#txtCOmpName').val() != $('#txtCompEndorseName').val()) { $('#txtCompEndorseName').css("background", "yellow"); }
            if ($('#txtCompEmail').val() != $('#txtCompEndorseEmail').val()) { $('#txtCompEndorseEmail').css("background", "yellow"); }
            if ($('#txtCompGSTIN').val() != $('#txtCompEndorseGSTIN').val()) { $('#txtCompEndorseGSTIN').css("background", "yellow"); }
            if ($('#txtCompAddr').val() != $('#txtCompEndorseAddr').val()) { $('#txtCompEndorseAddr').css("background", "yellow"); }
            if ($('#txtCompNomiName').val() != $('#txtCompEndorseNomName').val()) { $('#txtCompEndorseNomName').css("background", "yellow"); }
            if ($('#txtCompNomineeRelation').val() != $('#txtCompEndorseNomRelation').val()) { $('#txtCompEndorseNomRelation').css("background", "yellow"); }
          

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
            <div class="content-body">
                <h1 class="h1Tag">Policy Endorsement Request</h1>
                <br />
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-content">
                                <center><asp:Label ID="lblMsg" runat="server"></asp:Label></center>
                                <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
                                <div class="table-responsive">
                                    <table class="table table-de mb-0">
                                        <asp:GridView ID="GV_PolicyModReq" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                            PagerStyle-CssClass="bs-pagination" Width="100%" OnRowCommand="GV_PolicyModReq_RowCommand">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                        <asp:Label ID="lblPolicyEndorNo" runat="server" Text='<%#Bind("Endorsement_No") %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="lblPolicyNo" runat="server" Text='<%#Bind("Policy_No") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Policy No">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblEndorsementNo" runat="server" Text='<%#Bind("PolicyEndorsementNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Policy Issues Date">
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
                    <h5 class="modal-title" id="exampleModalLabel2">Policy Endorsement Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">

                    <div class="row">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-content collapse show">
                                    <div class="card-body">
                                        <%--<h1>Policy Cancellation Request</h1>
                                        <hr />--%>
                                        <div class="card-body">
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Policy Number</label>
                                                            <asp:TextBox ID="txtPolicyEndorsementNo" runat="server" Text='<%#Bind("Cancellation_No") %>' Visible="false"></asp:TextBox>
                                                            <asp:TextBox ID="txtPolicyNo" runat="server" Text='<%#Bind("Policy_No") %>' Visible="false"></asp:TextBox>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtPolicyEndorseNumber" runat="server" class="form-control" placeholder="Policy Number" ReadOnly="true"></asp:TextBox>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Issuance Date</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtIssuesDate" runat="server" class="form-control" placeholder="Issues Date" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                       <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Total Price</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtTotalPrice" runat="server" class="form-control" placeholder="Total Price" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Existing Policy Start date</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtPolicyStartdate" runat="server" class="form-control" placeholder="Start date" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Existing Policy End date</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtPolicyEnddate" runat="server" class="form-control" placeholder="End date" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                      <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Endorse Policy Start date</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtEndorseSdate" runat="server" class="form-control" placeholder="Start date" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Endorse Policy End date</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtEndorsEdate" runat="server" class="form-control" placeholder="End date" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                 
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Existing DOB</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtDOB" runat="server" class="form-control" placeholder="End date" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                        <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Endorse DOB</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtEndorseDOB" runat="server" class="form-control" placeholder="End date" ReadOnly="true"></asp:TextBox>
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
                                                <h1>Customer Existing Information</h1>
                                                <hr />
                                            </div>

                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">
                                                          <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Title</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtTitle" runat="server" class="form-control" placeholder="Title" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Name</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtname" runat="server" class="form-control" placeholder="First Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Contact Number</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtContactNumber" runat="server" class="form-control" placeholder="Contact Number" MaxLength="10" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Email</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtEmail" runat="server" class="form-control" placeholder="Email " ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Passport No</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtPassportNo" runat="server" class="form-control" placeholder="Email " ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%--<div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">State</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtState" runat="server" class="form-control" placeholder="State" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>--%>

                                                        <%--  <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">City</label>
                                                            <div class="controls">

                                                                <asp:TextBox ID="txtCity" runat="server" class="form-control" placeholder="Citry" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>--%>

                                                        <%-- <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Pin Code</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtPinCode" runat="server" class="form-control" placeholder="Pin Code" MaxLength="6" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>--%>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Aadhaar</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtAadhaar" runat="server" class="form-control" placeholder="Aadhaar" MaxLength="12" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Pan No</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtPanNo" runat="server" class="form-control" placeholder="Pan No" MaxLength="10" onblur="fnValidatePAN(this);" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Address</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtNomineeAddres" runat="server" class="form-control" placeholder="Address" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Nominee Name</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtNomineename" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Nominee Relation</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtNomineeRelation" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>

                                                </div>
                                            </div>

                                        </div>

                                        <div class="card-body">
                                            <div>
                                                <h1>Customer Endorsement Information</h1>
                                                <hr />
                                            </div>
                                            <div class="card-body">
                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Title</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtEndorseTitle" runat="server" class="form-control" placeholder="Title" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Name</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtEndorseName" runat="server" class="form-control" placeholder="First Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Contact Number</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtEndorseMobNo" runat="server" class="form-control" placeholder="Contact Number" MaxLength="10" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Email</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtEndorseEmail" runat="server" class="form-control" placeholder="Email " ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Passport No</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtEndorsePassportNo" runat="server" class="form-control" placeholder="Passport No" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Aadhaar</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtEndorseNomiAdhar" runat="server" class="form-control" placeholder="Aadhaar" MaxLength="12" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Pan No</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtEndorseNomiPAN" runat="server" class="form-control" placeholder="Pan No" MaxLength="10" onblur="fnValidatePAN(this);" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Addres</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtEndorseNomiAddr" runat="server" class="form-control" placeholder="Address" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Nominee Name</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtEndorseNomiName" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Nominee Relation</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtEndorseNomineeRelation" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
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
                                                <h1>Company Existing Information</h1>
                                                <hr />
                                            </div>

                                            <div class="card-body">

                                                <div class="form-body">
                                                    <div class="row">
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Name</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCOmpName" runat="server" class="form-control" placeholder="First Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Email</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompEmail" runat="server" class="form-control" placeholder="Email " ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">GSTIN</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompGSTIN" runat="server" class="form-control" placeholder="State" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Address</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompAddr" runat="server" class="form-control" placeholder="Address" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Nominee Name</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompNomiName" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-md-4">
                                                            <div class="form-group">
                                                                <label for="projectinput2">Nominee Relation</label>
                                                                <div class="controls">
                                                                    <asp:TextBox ID="txtCompNomineeRelation" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                        </div>

                                                    </div>
                                                    <div class="table-responsive">
                                                        <table class="table table-de mb-0">
                                                            <asp:GridView ID="GV_MiceInfo" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" Width="100%">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderText="Name">
                                                                        <ItemTemplate>
                                                                            <asp:HiddenField runat="server" ID="hdnMiceNo" Value='<%#Bind("MiceNo") %>' />
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

                                        <%--     <div class="card-body">--%>
                                        <div>
                                            <h1>Company Endorsement Information</h1>
                                            <hr />
                                        </div>
                                        <div class="card-body">
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Name</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompEndorseName" runat="server" class="form-control" placeholder="First Name" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Email</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompEndorseEmail" runat="server" class="form-control" placeholder="Email " ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">GSTIN</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompEndorseGSTIN" runat="server" class="form-control" placeholder="State" AutoPostBack="true" OnSelectedIndexChanged="ddlState_SelectedIndexChanged" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Address</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompEndorseAddr" runat="server" class="form-control" placeholder="Address" TextMode="MultiLine" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Nominee Name</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompEndorseNomName" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Nominee Relation</label>
                                                            <div class="controls">
                                                                <asp:TextBox ID="txtCompEndorseNomRelation" runat="server" class="form-control" placeholder="Nominee Name" ReadOnly="true"></asp:TextBox>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>

                                        </div>
                                        <div class="table-responsive">
                                            <table class="table table-de mb-0">
                                                <asp:GridView ID="GV_EndorseMiceDetails" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" Width="100%">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEndorseMiceName" runat="server" Text='<%#Bind("Name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Passport No">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEndorseMicePassportNo" runat="server" Text='<%#Bind("PassportNo") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Mobile No">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEndorseMiceMobNo" runat="server" Text='<%#Bind("Mobno") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Email">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEndorseMiceEmailID" runat="server" Text='<%#Bind("EmailId") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Gender">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblEndorseGender" runat="server" Text='<%#Bind("Gender") %>'></asp:Label>

                                                            </ItemTemplate>
                                                        </asp:TemplateField>

                                                    </Columns>
                                                    <EmptyDataTemplate><b style="color: red">No Record Available</b></EmptyDataTemplate>
                                                </asp:GridView>
                                            </table>
                                        </div>
                                        <%-- </div>--%>
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
                                                <asp:LinkButton ID="btnPolicyEnorseDisapprove" runat="server" type="submit" CssClass="btn btn-success" CausesValidation="false" ClientIDMode="Static" OnClick="btnPolicyEnorseDisapprove_Click">Disapprove</asp:LinkButton>
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
                    <p>Enorsement Policy has been approved !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

