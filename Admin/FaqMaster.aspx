<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="FaqMaster.aspx.cs" Inherits="Admin_FaqMaster" ClientIDMode="Static" ValidateRequest="false" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
       <script src="../Assets/js/jquery.min.js"></script>
       
    <script src="../Assets/js/bootstrap.min.js"></script>
    <script>
        $(document).ready(function () {
            //$('#txtEditor').val('');
            
            $('#btnSubmit').click(function (e) {
                //alert($('#txtEditor').val());
                 if ($('#txtQuestion').val() == '') {
                     $('#lblMsg').text('*Enter a Question.').css("color", "red");
                     $('#txtQuestion').focus();
                    e.preventDefault();
                    return false;
                }
                // else if ($('.Editor-editor').val() == '') {
                 else if ($('#txtEditor').val() == '') {
                    $('#lblMsg').text('*Enter a Answer.').css("color", "red");
                    $('#txtEditor').focus();
                    e.preventDefault();
                    return false;
                 }               

            });
            $('#btnReset').click(function (e) {
                $('#txtQuestion').val('');
                $('#txtEditor').val('');

            });
        });
        function ShowMessage() {
            setTimeout(function () {
                $("#ModalMsg").modal('show');
            }, 100);

        }
    </script>
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
            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" ClientIDMode="Static"></asp:Label>
            <div class="content-body">

                <h1 class="h1Tag">FAQ Master</h1>
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div style="height: 20px">
                                <center><asp:Label ID="lblMsg" runat="server" ClientIDMode="Static"></asp:Label></center>
                            </div>
                            <div class="card-content collapse show">
                                <div class="card-body">

                                    <div class="form-body">
                                        <div class="row">
                                            <asp:HiddenField ID="Id" runat="server" />
                                          <%--  <div class="col-md-12">
                                                <div class="form-group">
                                                    <label><b>Section Type</b><span style="color: red">*</span></label>
                                                    <asp:TextBox ID="txtScectiontype" runat="server" class="form-control" placeholder="Section Type"></asp:TextBox>
                                                </div>
                                            </div>--%>
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label><b>Question</b><span style="color: red">*</span></label>
                                                    <asp:TextBox ID="txtQuestion" runat="server" class="form-control" placeholder="Question" TextMode="MultiLine" Height="70px"></asp:TextBox>
                                                </div>
                                            </div>

                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label><b>Answer</b><span style="color: red">*</span></label>
                                                  <%--  <asp:TextBox ID="txtAnswer" runat="server" class="form-control" placeholder="Answer" TextMode="MultiLine" Height="119px"></asp:TextBox>--%>
                                                    <textarea id="txtEditor" runat="server"> </textarea>
                                                     <asp:HiddenField ID="hdntext" runat="server" ClientIDMode="Static" />
                                                </div>
                                            </div>
                                        </div>
                                      
                                        <div class="text-left" id="div_btn" runat="server">
                                            <asp:LinkButton ID="btnSubmit" runat="server" Text="Submit" class="btn btn-success"  ClientIDMode="Static" OnClick="btnSubmit_Click"><i class="la la-thumbs-o-up position-right"></i> Submit</asp:LinkButton>
                                            <asp:LinkButton ID="btnReset" runat="server" Text="Reset" class="btn btn-danger reset-btn"><i class="la la-refresh position-right"></i> Reset</asp:LinkButton>
                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">FAQ Management</h4>
                            </div>
                            <div class="card-content">
                                <div class="table-responsive" id="Gridview-container">
                                    <asp:GridView ID="GV_FAQ" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                        PagerStyle-CssClass="bs-pagination" Width="100%" OnRowDataBound="GV_FAQ_RowDataBound" OnRowCommand="GV_FAQ_RowCommand" OnPageIndexChanging="GV_FAQ_PageIndexChanging" OnSelectedIndexChanged="GV_FAQ_SelectedIndexChanged">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No." ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />    
                                                    <asp:HiddenField ID="hdnId" runat="server" Value='<%# Eval("Id") %>'/>                                             
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Questions" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblQuestions" runat="server" Text='<%#Bind("Questions") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                          
                                            <asp:TemplateField HeaderText="Answers" ItemStyle-Width="30%" HeaderStyle-Width="30%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAnswers" runat="server" Text='<%#Bind("Answers") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Active" ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Button ID="btnActive" runat="server" Text="Active" class="btn btn-sm round btn-outline-danger" CommandName="Active"></asp:Button>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Deactive" ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Button ID="btndeactive" runat="server" Text="Deactive" class="btn btn-sm round btn-outline-danger" CommandName="Deactive"></asp:Button>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Edit" ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btnEdit" runat="server" Text="Edit" class="btn btn-sm round btn-outline-danger" CommandName="Select"></asp:LinkButton>
                                                    <asp:HiddenField ID="HiddenIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
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



     <div id="ModalMsg" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true" onclick="window.location.href='FaqMaster.aspx'">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h4>Success!</h4>
                    <p>Details submitted successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

