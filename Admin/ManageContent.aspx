<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ManageContent.aspx.cs" Inherits="ManageContent" ValidateRequest="false" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Assets/js/jquery.min.js"></script>
    <script src="../Assets/js/bootstrap.min.js"></script>

    <style>
        .modal {
            background: rgba(5, 2, 2, 0.5);
        }

        .dark_bg .modal-dialog .modal-content {
            margin-top: 15%;
        }

        .modal-backdrop {
            position: relative;
        }

        .modal-dialog {
            margin-top: 7%;
        }

        .bs-example {
            margin: 20px;
        }

        button.close {
            margin-left: 97%;
            margin-top: 0.1%;
        }

        .modal-dialog2 {
            max-width: 943px;
            margin: 1.75rem auto;
        }
    </style>
    <script type="text/javascript">

        function validateBanner() {          
            var err = "";
            var body = $('.Editor-editor').html();          
            $("#hdntext").val(body);
            if (err.length > 0) {
                alert("Please rectify the following errors :\n\n" + err);
                return false;
            }
            else {
                return true;
            }
            return false;
        }
        function messageshow() {
            setTimeout(function () {
                $("#myModal").modal('show');
                var bodyval = $("#hdntext").val();
                $('.Editor-editor').html(bodyval);
            }, 100);
        }
        function SuccessMsg() {
            setTimeout(function () {
                $("#ModelSuccessMsg").modal('show');
            }, 100);
        }
        $(document).ready(function () {
            $("#txtEditor").Editor();
            $("#txtEditor").Editor("setText", $("#hdntext").val());

            $('#btnSave').click(function (e) {

                if ($('#txtName').val() == "") {
                    $('#lblMsg').text('Please enter the content type').css("color", "red");
                    $('#txtName').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtSubject').val() == "") {
                    $('#lblMsg').text('Please enter the subject type').css("color", "red");
                    $('#txtSubject').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#txtEditor').val() == "") {
                    $('#lblMsg').text('Please enter the body type').css("color", "red");
                    $('#txtEditor').focus();
                    e.preventDefault();
                    return false;
                }

                else {
                    $('#lblMsg').text('');
                }
              
            });
        });
    </script>

    <asp:ScriptManager ID="sm" runat="server"></asp:ScriptManager>
     <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">Content Management</h1>
                <br />
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">

                            <div class="card-content">
                                <div class="table-responsive">
                                    <asp:GridView ID="gv_ContentType" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                        PagerStyle-CssClass="bs-pagination" Width="100%" OnRowCommand="gv_ContentType_RowCommand" OnPageIndexChanging="gv_ContentType_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Sr.No.">
                                                <ItemStyle Width="50px" HorizontalAlign="Center"></ItemStyle>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRow" runat="server" Text='<%# Container.DataItemIndex + 1 %>'></asp:Label>
                                                    <asp:Label ID="lblContentType" runat="server" Text='<%# Eval("ContentType") %>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Content Type" Visible="true">
                                                <ItemStyle HorizontalAlign="Left" Width="200px" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblType" runat="server" Text='<%# Eval("ContentName") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Description">
                                                <ItemStyle HorizontalAlign="Left" Width="500px" />
                                                <ItemTemplate>
                                                    <asp:Label ID="lblSubject" runat="server" Text='<%# Eval("Content_Desc") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText=" Edit " HeaderStyle-Width="50px">
                                                <ItemStyle HorizontalAlign="Center" Width="50px"></ItemStyle>
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imbEdit" runat="server" usesubmitbehavior="true" CommandName="Change" ImageUrl="../Assets/images/edit.png"></asp:ImageButton>
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
                <!-- Active Orders -->
            </div>
        </div>
    </div>

    <div class="modal dark_bg login-form-btn" id="myModal" tabindex="-2" role="dialog" aria-labelledby="exampleModalLabel8" aria-hidden="true">
        <div class="modal-dialog2" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel1" style="margin-left: 1%;">Manage Content Template</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="margin-left: 0%; margin-top: -2%"><span aria-hidden="true">×</span> </button>
                </div>
                <div style="height:20px"><center><asp:Label runat="server" ID="lblMsg"></asp:Label></center> </div> 
                <div class="modal-body">                 
                    <div class="modal-body">
                        <div class="form-group">
                            <label>Content Type<span class="starRed" style="color:red">*</span></label>
                            <asp:HiddenField ID="hdnemailtype" runat="server" ClientIDMode="Static" />
                            <asp:TextBox runat="server" ID="txtName" class="form-control" AutoCompleteType="Disabled" ></asp:TextBox>
                        </div>
                        <div class="form-group">
                            <label>Description<span class="starRed" style="color:red">*</span></label>
                            <asp:TextBox runat="server" ID="txtSubject" class="form-control" AutoCompleteType="Disabled" ></asp:TextBox>
                        </div>
                        <div class="form-group editor">
                            <label>Content<span class="starRed" style="color:red">*</span></label>
                            <textarea id="txtEditor"> </textarea>
                            <asp:HiddenField ID="hdntext" runat="server" ClientIDMode="Static" />
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:Button runat="server" ID="btnSave" class="btn btn-primary" Text="Save changes" OnClick="btnSave_Click" />
                        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        <asp:HiddenField ID="hdnType" runat="server" />
                        
                    </div>
                </div>
            </div>
        </div>
    </div>


    <div id="ModelSuccessMsg" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h4>Updated!</h4>
                    <p>Details updated successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

