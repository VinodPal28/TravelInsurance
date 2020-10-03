<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="WalletRequest.aspx.cs" Inherits="Partner_WalletRequest" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../Scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtAmount').bind('keyup', function (e) {
                if (this.value.match(/[^0-9]/g)) {
                    this.value = this.value.replace(/[^0-9]/g, '');
                }
            });

            $('#btnSave').click(function () {
                var Amt = $("#txtAmount").val();
                var Tran_Date = $("#txtTranxDate").val();
                var paymentMethod = $("#ddlPaymentMethod").val();
                var PayDetails = $("#txtPayMethoDetails").val();
                var upload = $("#FileUpload").val();
                var remark = $("#txtRemarks").val();

                if (Amt == '') {
                    $("#MsgAmt").text("Enter the amount").css("color", "Red");
                    return false;
                }
                else if (Amt <= 0) {
                    $("#MsgAmt").text("Amount must be greater than Zero.").css("color", "Red");
                    return false;
                }
                else {
                    $("#MsgAmt").text("");
                }
                if (Tran_Date == '') {
                    $("#MsgTranxDate").text("Select the transaction date").css("color", "Red");
                    return false;
                }
                else {
                    $("#MsgTranxDate").text("");

                }
                if (paymentMethod == '0') {
                    $("#MsgPayMethod").text("Select the payment method").css("color", "Red");
                    return false;
                }
                else {
                    $("#MsgPayMethod").text("");
                }
                if (PayDetails == '' && upload == '') {
                    $("#MsgFileupload").text("Either provide the Payment Method Details or upload the file. ").css("color", "Red");
                    return false;
                }
                else {
                    $("#MsgFileupload").text("");
                }
                if (remark == '') {
                    $("#MsgRemarks").text("Enter the remarks").css("color", "Red");
                    return false;
                }
                else {
                    $("#MsgRemarks").text("");
                }

            });
            // $('#ModalImage').on('show.bs.modal', function (e) { if (!data) return e.preventDefault() });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnshow').click(function (e) {
                
                $("#ModalImageabc").modal('show');
                e.preventDefault();
                return false;
            });

        });
    </script>
    <script type="text/javascript">
        function messageshow() {
            setTimeout(function () {              
                $("#ModalImage").modal('show');                
                return false;
            }, 100);
        }
    </script>

    <script type="text/javascript">
        function SuccessMsg() {
            setTimeout(function () {
                $("#myModal_Success").modal('show');
                return false;
            }, 100);
        }
    </script>

    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            
            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">Partner Wallet Request</h1>
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <center><asp:Label ID="lblMessage" runat="server" ForeColor="Green"></asp:Label>  </center>
                            <div class="card-content collapse show">
                                <div class="card-body">
                                    <div class="form-body">

                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput1">Amount<span class="starRed">*</span></label>
                                                    <asp:TextBox runat="server" ID="txtAmount" class="form-control" placeholder="Amount" MaxLength="8"></asp:TextBox>
                                                    <div style="height: 20px"><span id="MsgAmt"></span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <h1 class="h1Tag">Transcation Details</h1>
                                    <hr />
                                    <br />
                                    <div class="form-body">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput2">Transaction Date<span class="starRed">*</span></label>
                                                    <input type="date" id="txtTranxDate" runat="server" class="form-control" name="dateopened" data-toggle="tooltip" data-trigger="hover" data-placement="top" data-title="Date Opened">
                                                    <div style="height: 20px"><span id="MsgTranxDate"></span></div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput2">Payment Method<span class="starRed">*</span></label>
                                                    <asp:DropDownList ID="ddlPaymentMethod" runat="server" class="form-control">
                                                        <asp:ListItem Value="0">Select</asp:ListItem>
                                                        <asp:ListItem Value="Cash">Cash</asp:ListItem>
                                                        <asp:ListItem Value="cheque">Cheque</asp:ListItem>
                                                        <asp:ListItem Value="NEFT">NEFT</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <div style="height: 20px"><span id="MsgPayMethod"></span></div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput3">Payment Method Details</label>
                                                    <asp:TextBox runat="server" ID="txtPayMethoDetails" class="form-control" placeholder="Payment Method Details" MaxLength="50"></asp:TextBox>
                                                    <div style="height: 20px"><span id="MsgPayDetails"></span></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <h5>Upload Image:</h5>
                                                    <div class="controls">
                                                        <asp:FileUpload ID="FileUpload" class="form-control" aria-describedby="fileHelp" runat="server" />
                                                        <div style="height: 20px"><span id="MsgFileupload"></span></div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput4">Remarks<span class="starRed">*</span></label>
                                                    <asp:TextBox runat="server" ID="txtRemarks" class="form-control" placeholder="Remarks" MaxLength="50"></asp:TextBox>
                                                    <div style="height: 20px"><span id="MsgRemarks"></span></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="text-left">
                                        <asp:LinkButton ID="btnSave" runat="server" class="btn btn-success" OnClick="btnSave_Click"><i class="la la-thumbs-o-up position-right"></i> Submit</asp:LinkButton>
                                        <asp:LinkButton ID="btnReset" runat="server" class="btn btn-danger reset-btn" OnClick="btnReset_Click"><i class="la la-refresh position-right"></i> Reset</asp:LinkButton>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Start Gridview -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Transcation Details</h4>
                            </div>
                            <div class="card-content">
                                <div class="table-responsive" id="Gridview-container">

                                    <asp:GridView ID="GV_TranxDetails" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                        PagerStyle-CssClass="bs-pagination" Width="100%" OnPageIndexChanging="GV_TranxDetails_PageIndexChanging" OnRowDataBound="GV_TranxDetails_RowDataBound" OnRowCommand="GV_TranxDetails_RowCommand">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No." ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    <asp:Label ID="lblId" runat="server" Text='<%#Bind("Id")%>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Amount" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmt" runat="server" Text='<%#Bind("Amount") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Transaction Date" ItemStyle-Width="20%" HeaderStyle-Width="20%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTranxDate" runat="server" Text='<%#Bind("Transac_Date") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Payment Method" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPayMethod" runat="server" Text='<%#Bind("Payment_Method") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Requested Date" ItemStyle-Width="25%" HeaderStyle-Width="25%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblReqDate" runat="server" Text='<%#Bind("Created_Date","{0:dd/MM/yyyy hh:mm:ss}") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="View Uploaded File" ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnUploadImg" runat="server" Value='<%#Eval("File") %>'></asp:HiddenField>
                                                    <asp:Button ID="lnkView" runat="server" class="btn btn-sm round btn-outline-danger" CommandName="ViewImage" Text="View" />
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
                <!-- End Gridview -->

            </div>
        </div>
    </div>

    <div class="modal dark_bg fade login-form-btn" id="ModalImage" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span> </button>
                </div>
                <div class="modal-body" style="margin: 2%;">
                    <div class="row">
                        <div class="col-lg-16">
                            <asp:Image ID="imgFirst" runat="server" alt="Image not available" Width="100%" />
                            <%--src="../assets/img/PAN_CARD.jpg"--%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    

    <div id="myModal_Success" class="modal fade">
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
                    <p>Your wallet request has been sent successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>
   

</asp:Content>

