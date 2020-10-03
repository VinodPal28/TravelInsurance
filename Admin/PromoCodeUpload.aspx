<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="PromoCodeUpload.aspx.cs" Inherits="Admin_PromoCodeUpload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Assets/js/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#BtnUpload').click(function (e) {
                var allowedFiles = [".xls", ".xlsx"];
                var regexFileUpload = new RegExp("([a-zA-Z0-9\s_\\.\-:])+(" + allowedFiles.join('|') + ")$");

                if ($('#File_Upload').val() == '') {
                    $('#lblmsg').text('*Select a file to upload').css("color", "red");
                    $('#File_Upload').focus();
                    e.preventDefault();
                    return false;
                }
                else if (!regexFileUpload.test($('#File_Upload').val().toLowerCase())) {
                    $('#lblmsg').text('Please upload files having extensions: ' + allowedFiles.join(', ') + ' only.').css("color", "red");
                    $('#File_Upload').focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#lblmsg').text('');
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
                <h1 class="h1Tag">Upload PromoCode</h1>
                <!-- Active Orders -->

                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body input-textbox">
                                <div class="table-responsive">
                                    <br />
                                    <div style="height: 20px; margin-left: 13%;">
                                        <asp:Label ID="lblmsg" runat="server"></asp:Label>
                                       
                                    </div>
                                  
                                    <br />
                                    <label for="Browse-File" class="form-control-label">Select File(.xls/.xlsx)<font style="color: red">*</font> :-</label>
                                    <asp:FileUpload ID="File_Upload" runat="server" /><br />
                                    <u>
                                        <asp:LinkButton ID="LnkBtn_Format" runat="server" Text="Click here for file format" OnClick="LnkBtn_Format_Click" Style="margin-left: 13%; color: blue;" />

                                    </u>
                                    <br />
                                    <br />
                                    <br />
                                    <div>
                                        <asp:Button ID="BtnUpload" runat="server" Text="Upload" class="btn btn-lg btn-primary Prospective-signup" OnClick="BtnUpload_Click" ClientIDMode="static" /> &nbsp;&nbsp; <asp:Button ID="btnExcelExport" runat="server" Text="Export To Excel" class="btn btn-lg btn-primary" OnClick="btnExcelExport_Click" ClientIDMode="static" /><br />
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

