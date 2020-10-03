<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="WalletReqApproval.aspx.cs" Inherits="Admin_WalletReqApproval" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        function Approve() {
            setTimeout(function () {
                $("#Model_Approve").modal('show');
            }, 100);
        }
        function Disapprove() {
            setTimeout(function () {
                $("#Model_Disapprove").modal('show');
            }, 100);
        }
        function MsgApprove() {
            setTimeout(function () {
                $("#ModalApproveMsg").modal('show');
            }, 100);
        } 
        function MsgDisapprove() {
            setTimeout(function () {
                $("#ModalDisapproveMsg").modal('show');
            }, 100);
        }
        function Refresh() {
            $('#txtGranted_Amt').val('');
            $('#txtOthers').val('');
            $('#txt_remarks').val('');
        }
    </script>
    <script type="text/javascript">

        $(document).ready(function () {
            $('#txtGranted_Amt').bind('keyup', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });

            $('#btnSub').click(function () {
                var ReqAmt = $("#txtrequestAmt").val();
                var GrantedAmt = $("#txtGranted_Amt").val();
                var Others = $("#txtOthers").val();
                var Remarks = $("#txt_remarks").val();

                if (GrantedAmt == '') {
                    $("#lblmsgApprove").text("Enter the granted amount").css("color", "Red");
                    return false;
                }
                else if (GrantedAmt <= 0) {
                    $("#lblmsgApprove").text("Amount must be greater than Zero.").css("color", "Red");
                    return false;
                }
                else if (parseInt(GrantedAmt) > parseInt(ReqAmt)) {
                    $("#lblmsgApprove").text("Granted amount should be less than or equal to request amount").css("color", "Red");
                    return false;
                }
                else if (Remarks == '') {
                    $("#lblmsgApprove").text("Enter the remarks").css("color", "Red");
                    return false;
                }
                else {
                    $("#lblmsgApprove").text("");
                }

            });

            $('#btnDisApprove').click(function () {
                var Remarks = $("#txtDisapproveRemark").val();
                if (Remarks == '') {
                    $("#lblDisapproveMsg").text("Enter the remarks").css("color", "Red");
                    return false;
                }
                else {
                    $("#lblDisapproveMsg").text("");
                }

            });
        });
    </script>

    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Wallet Request</h4>
                            </div>
                            <div class="card-content">
                                <div class="table-responsive" id="Gridview-container">

                                    <asp:GridView ID="GV_WalletApproval" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                        PagerStyle-CssClass="bs-pagination" Width="100%" OnRowCommand="GV_WalletApproval_RowCommand" OnPageIndexChanging="GV_WalletApproval_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No." ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    <asp:Label ID="lblId" runat="server" Text='<%#Bind("Id")%>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Partner Code" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPartnerCode" runat="server" Text='<%#Bind("PartnerCode") %>'></asp:Label>
                                                     <asp:Label ID="lblPartnerId" runat="server" Text='<%#Bind("RcvId")%>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Partner Name" ItemStyle-Width="20%" HeaderStyle-Width="20%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPartnerName" runat="server" Text='<%#Bind("PartnerName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Requested Date" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReqDate" runat="server" Text='<%#Bind("CreatedOn") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Requested Amount" ItemStyle-Width="25%" HeaderStyle-Width="25%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReqAmount" runat="server" Text='<%#Bind("Amount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Approve" ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnApprove" runat="server" class="btn btn-sm round btn-outline-danger" CommandName="Approve" Text="Approve" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Disapprove" ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnDisapprove" runat="server" class="btn btn-sm round btn-outline-danger" CommandName="Disapprove" Text="Disapprove" />
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
        </div>
    </div>

    <div class="modal dark_bg login-form-btn" id="Model_Approve" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel1">Approve</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" onclick="Refresh();"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body">
                    <div class="card">
                        <div class="card-body input-textbox">
                            <div class="row justify-content-center">
                                <center><asp:Label ID="lblmsgApprove" runat="server" ></asp:Label> </center>
                                <div class="col-md-16">
                                    <asp:TextBox ID="txtId" runat="server" Visible="false" />
                                    <asp:TextBox ID="txtPartnerCode" runat="server" Visible="false" />
                                    <asp:TextBox ID="txtPartnerName" runat="server" Visible="false" />
                                    <asp:TextBox ID="txtReqDate" runat="server" Visible="false" />

                                    <div class="form-group ">
                                        <label>Requested Amount</label>
                                        <asp:TextBox ID="txtrequestAmt" runat="server" CssClass="form-control" Enabled="false" ClientIDMode="Static" />
                                    </div>

                                    <div class="form-group ">
                                        <label>Granted Amount</label>
                                        <asp:TextBox ID="txtGranted_Amt" runat="server" CssClass="form-control" ClientIDMode="Static" />
                                    </div>

                                    <div class="form-group ">
                                        <label>Others</label>
                                        <asp:TextBox ID="txtOthers" runat="server" CssClass="form-control" ClientIDMode="Static" />
                                    </div>

                                    <div class="form-group ">
                                        <label>Remarks</label>
                                        <asp:TextBox ID="txt_remarks" runat="server" CssClass="form-control" ClientIDMode="Static" TextMode="MultiLine" />
                                    </div>

                                    <div class="footer" align="right">
                                        <asp:Button ID="btnSub" runat="server" Text="Submit" CssClass="btn btn-primary edit-bg create-user" OnClick="btnSub_Click" />
                                        <asp:Button ID="Button1" runat="server" Text="Close" CssClass="btn btn-primary edit-bg create-user" OnClientClick="Refresh();"/>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
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
                <div class="modal-body">
                    <div class="card">
                        <div class="card-body input-textbox">
                            <div class="row justify-content-center">
                                <center><asp:Label ID="lblDisapproveMsg" runat="server" ></asp:Label> </center>
                                <div class="col-md-16">
                                    <asp:TextBox ID="txt_Id" runat="server" Visible="false" />
                                    <asp:TextBox ID="txtPartCode" runat="server" Visible="false" />
                                    <asp:TextBox ID="txtPartName" runat="server" Visible="false" />
                                    <asp:TextBox ID="txtReq_date" runat="server" Visible="false" />
                                    <asp:TextBox ID="txtReqAmount" runat="server" Visible="false" />

                                    <div class="form-group ">
                                        <label>Remarks</label>
                                        <asp:TextBox ID="txtDisapproveRemark" runat="server" CssClass="form-control" ClientIDMode="Static" TextMode="MultiLine" />
                                    </div>

                                    <div class="footer" align="right">
                                        <asp:Button ID="btnDisApprove" runat="server" Text="Submit" CssClass="btn btn-primary edit-bg create-user" OnClick="btnDisApprove_Click" />
                                        <asp:Button ID="Button3" runat="server" Text="Close" CssClass="btn btn-primary edit-bg create-user" OnClientClick="Refresh();"/>
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
                    <p>Wallet request has been approved !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>    

    <div id="ModalDisapproveMsg" class="modal fade show" >
        <div class="modal-dialog modal-confirmClose">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-close"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                </div>

                <div class="modal-body">
                    <p><h1 style="color: crimson;">Disapproved !</h1></p>
                </div>
                <%--<div class="modal-footer"><br /> </div>--%>
            </div>
        </div>
    </div>
</asp:Content>
