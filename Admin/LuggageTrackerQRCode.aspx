<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="LuggageTrackerQRCode.aspx.cs" Inherits="Admin_QRCode" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Assets/js/jquery.min.js"></script>
    <link href="../Assets/css/Grid_Pagination.css" rel="stylesheet" />
    <script src="../Assets/js/scripts/bs.pagination.js"></script>
    <script src="../Assets/js/Valid.js"></script>

    <script type="text/javascript">
        function messageshow() {
            setTimeout(function () {
                $("#MyModel_MsgSuccess").modal('show');
            }, 100);
        }

        function Errmessageshow() {
            setTimeout(function () {
                $("#MyModel_Msg").modal('show');
            }, 100);
        }

        function NotFoundmessageshow() {
            setTimeout(function () {
                $("#MyModel_Msgnotfound").modal('show');
            }, 100);
        }
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#fileUpload1').change(function () {
                var fp = $("#fileUpload1");
                var lg = fp[0].files.length; // get length
                var items = fp[0].files;
                var fileSize = 0;
                if (lg > 0) {
                    for (var i = 0; i < lg; i++) {
                        fileSize = fileSize + items[i].size; // get file size
                    }
                    if (fileSize > 4194304) {
                       // alert('File size must not be more than 4 MB');
                        $('#SpnMsg').text('*File size must not be more than 4 MB').css("color", "red");
                        $('#fileUpload1').focus();
                        e.preventDefault();
                        return false;
                        $('#fileUpload1').val('');
                    }
                }
            });
        });
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            var allowedFiles = [".pdf"];
            //var fileUpload = document.getElementById("fileUpload1");
            var regex = new RegExp("([a-zA-Z0-9\s_\\.\-:])+(" + allowedFiles.join('|') + ")$");
            $('#btnSubmit').click(function (e) {

                if ($('#fileUpload1').val() == '') {
                    $('#SpnMsg').text('*Please Upload QR Code File').css("color", "red");
                    $('#fileUpload1').focus();
                    e.preventDefault();
                    return false;
                }

                else if (!regex.test($('#fileUpload1').val().toLowerCase())) {
                    //alert(1);
                    $('#SpnMsg').text('*Please upload files having extension: ' + allowedFiles.join(', ') + ' only.').css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#SpnMsg').text('');
                }

            });
        });
    </script>
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-body">
                <h1 class="h1Tag">QR Code</h1>
                <br />
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div style="height: 20px">
                                <center>
                                    <asp:Label ID="lblmsg2" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label>
                                    <asp:Label ID="SpnMsg" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label>
                                    <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red" ClientIDMode="Static"></asp:Label> 
                                    <asp:Label ID="lblMsguploadfile" runat="server"></asp:Label>
                                </center>
                            </div>
                            <div class="card-content">
                                <div class="table-responsive">
                                    <div class="card-content collapse show">
                                        <div class="card-body">

                                            <br />
                                            <div class="form-body">
                                                <div class="row">

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Upload QR Code File(.pdf)<span class="starRed" style="color: red">*</span></label>
                                                            <asp:FileUpload ID="fileUpload1" runat="server" class="form-control" AllowMultiple="true" />                                                         
                                                        </div>
                                                    </div>
                                                    <div class="text-right" id="div_btn" runat="server" style="margin-left: 2.5%; margin-top: 2.5%;">

                                                        <asp:LinkButton ID="btnSubmit" runat="server" Text="Upload" class="btn btn-success" ClientIDMode="Static" OnClick="btnSubmit_Click" ValidationGroup="gp1"><i class="la la-thumbs-o-up position-right"></i> Upload</asp:LinkButton>

                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                </div>

                                 <br />
                                 <br />
                                 <asp:Button ID="btnExportToexcel" runat="server" CssClass="btn btn-primary edit-bg create-user" Text="Export to Excel" OnClick="btnExportToexcel_Click"/>
                               <br />
                                 <div class="table-responsive" >
                                   
                                    <asp:GridView ID="GV_QRCODE" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                        PagerStyle-CssClass="bs-pagination" Width="100%" OnPageIndexChanging="GV_QRCODE_PageIndexChanging" OnRowDataBound="GV_QRCODE_RowDataBound" OnRowCommand="GV_QRCODE_RowCommand">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No." ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    <asp:Label ID="lblid" runat="server" Text='<%#Bind("Id") %>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="QR Code" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQR_Code" runat="server" Text='<%#Bind("QR_Code") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="File Name" ItemStyle-Width="20%" HeaderStyle-Width="20%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblFilePath" runat="server" Text='<%#Bind("FileName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            

                                            <asp:TemplateField HeaderText="Download File" ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:HiddenField ID="hdnUploadImg" runat="server" Value='<%#Eval("Id") %>'></asp:HiddenField>
                                                    <asp:Button ID="lnkView" runat="server" class="btn btn-sm round btn-outline-danger" CommandName="Views" Text="Download" />
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
    <div id="MyModel_MsgSuccess" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>

                <div class="modal-body text-center">
                    <%-- <h4>Passengers Type</h4>--%>
                    <p style="color: green; margin-left: 3%"><asp:Label ID="lblSuccess" runat="server" Text="File Uploaded successfully."></asp:Label> </p>
                    <p style="color: green; margin-left: 3%"><asp:Label ID="lblsuccessmsg" runat="server"></asp:Label></p>
                         <p style="color: red; margin-left: 3%"><asp:Label ID="lblDuplicate" runat="server"></asp:Label></p>
                </div>
            </div>
        </div>
    </div>
    <div id="MyModel_Msg" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-file-pdf-o"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <p style="color: red; margin-left: 3%">Duplicate!File alredy uploded</p>
                </div>
            </div>
        </div>
    </div>
    <div id="MyModel_Msgnotfound" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-file-pdf-o"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <p style="color: red; margin-left: 3%">Invalid ! QR Code file name must be first 2 character and rest in numeric</p>
                    <p style="color: red; margin-left: 3%"><asp:Label ID="lblInvalidFile" runat="server"></asp:Label></p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

