<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="TermAndCondition.aspx.cs" Inherits="Admin_TermAndCondition" ClientIDMode="Static" %>

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
                $("# MyModel_Msgnotfound").modal('show');
            }, 100);
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            //$('#txtDocumentName').name();
            var allowedFiles = [".pdf"];
            var fileUpload = document.getElementById("fileUpload1");
            var regex = new RegExp("([a-zA-Z0-9\s_\\.\-:])+(" + allowedFiles.join('|') + ")$");

            $('#btnSubmit').click(function (e) {
                if ($('#txtDocumentName').val() == '') {
                    $('#SpnMsg').text('*Enter Document Name').css("color", "red");
                    $('#txtDocumentName').focus();
                    e.preventDefault();
                    return false;
                }

                else {
                    $('#SpnMsg').text('');
                }

                if ($('#fileUpload1').val() == '') {
                    $('#SpnMsg').text('*Please Upload Document File').css("color", "red");
                    $('#fileUpload1').focus();
                    e.preventDefault();
                    return false;
                }

                else {
                    $('#SpnMsg').text('');
                }
                if (!regex.test(fileUpload.val().toLowerCase())) {
                   
                    $('#SpnMsg').text('*Please upload files having extensions: <b>' + allowedFiles.join(', ') + '</b> only.').css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#SpnMsg').text('');
                }

            });



        });
    </script>

    <script type="text/javascript">
        function TermAndCondition() {
            $.ajax({
                url: "TermAndCondition.aspx/Page_Load",
                data: {
                    method: "GetTermCondition",
                    FileName: $("#txtDocumentName").val()                  
                },
                success: function (msg) {
                    if (msg != '') {

                        if (msg.toString() == 'F') {
                            $('#SpnMsg').text('Document File '+'"' + $("#txtDocumentName").val()+'"' + ' already exist!').css("color", "Red");
                          
                            $('#txtDocumentName').val("");
                            $('#fileUpload1').val("");
                        }
                        if (msg == 'NF') {
                            $('#SpnMsg').text('');
                        }
                    }
                }
            });
        }
        function OnSuccess(response) {
            alert(response.d);
        }
        function checkInsurerCode() {
            InsurerCode();

        }
    </script>
    <div class="app-content content">
        <div class="content-wrapper">          
            <div class="content-body">
                <h1 class="h1Tag">Terms And Condition</h1>
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
                                                            <label for="projectinput1">Document Name<span class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtDocumentName" MaxLength="100" runat="server" class="form-control" placeholder="Enter Document Name" onchange="TermAndCondition();"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Upload Document File<span class="starRed">*</span></label>
                                                            <asp:FileUpload ID="fileUpload1" runat="server" class="form-control" />
                                                        </div>
                                                    </div>
                                                    <div class="text-right" id="div_btn" runat="server" style="margin-left: 79%;">

                                                        <asp:LinkButton ID="btnSubmit" runat="server" Text="Submit" class="btn btn-success" ClientIDMode="Static" OnClick="btnSubmit_Click"><i class="la la-thumbs-o-up position-right"></i> Submit</asp:LinkButton>
                                                        <asp:LinkButton ID="btnReset" runat="server" Text="Reset" class="btn btn-danger reset-btn" OnClick="btnReset_Click"><i class="la la-refresh position-right"></i> Reset</asp:LinkButton>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>

                                    </div>
                                </div>
                            </div>
                            <div class="card-content">
                                <div class="table-responsive">
                                    <div class="card-content collapse show">
                                        <div class="card-body">
                                            <div class="form-body">
                                                <div class="row">
                                                    <table class="table table-de mb-0">
                                                        <asp:GridView ID="GV_TermandCondition" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                                            PagerStyle-CssClass="bs-pagination" Width="100%" OnPageIndexChanging="GV_TermandCondition_PageIndexChanging" OnRowCommand="GV_TermandCondition_RowCommand" OnRowDataBound="GV_TermandCondition_RowDataBound">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Sr.No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="File Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblFilename" runat="server" Text='<%#Bind("Document_Name") %>' Visible="true"></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="File Path">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblFilePath" runat="server" Text='<%#Bind("Document_Path") %>'></asp:Label>
                                                                         <asp:Label ID="lbl_id" runat="server" Text='<%#Bind("Id") %>' Visible="false"></asp:Label>
                                                                         <asp:HiddenField ID="HiddenIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Active" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                                    <ItemTemplate>
                                                                        <asp:Button ID="btnActive" runat="server" Text="Active" class="btn btn-sm round btn-outline-danger" CommandName="Active" CommandArgument="<%# Container.DataItemIndex %>"></asp:Button>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Deactive" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                                    <ItemTemplate>
                                                                        <asp:Button ID="btndeactive" runat="server" Text="Deactive" class="btn btn-sm round btn-outline-danger" CommandName="Deactive" CommandArgument="<%# Container.DataItemIndex %>"></asp:Button>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="View" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="btndownload" runat="server" Text="View" class="btn btn-sm round btn-outline-danger" CommandName="download" CommandArgument="<%# Container.DataItemIndex %>"></asp:LinkButton>
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
                    <p style="color: black; margin-left: 3%">Submitted successfully. </p>
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
                    <p style="color: black; margin-left: 3%">Sorry!!Upload only 'pdf' file. </p>
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
                    <p style="color: black; margin-left: 3%">Sorry!! Not Found!. </p>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

