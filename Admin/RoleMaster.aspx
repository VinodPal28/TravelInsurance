<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="RoleMaster.aspx.cs" Inherits="Admin_RoleMaster" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Assets/js/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtUserType').on('input', function (event) {
                this.value = this.value.replace(/[^a-zA-Z  ]/g, '');
            });
            $('#btnSubmit').click(function (e) {
                var UserType = $("#txtUserType").val();
                if (UserType == "") {
                    $('#Msg').text('Please enter the user type').css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#Msg').text('');
                    $.ajax({
                        url: "RoleMaster.aspx/Page_Load",
                        data: {
                            method: "CheckUserRole",
                            Role: $("#txtUserType").val(),
                            ID : $("#hdnId").val()
                        },
                        success: function (msg) {
                            if (msg != '') {
                                if (msg.toString() == 'EXISTS') {
                                    $('#Msg').text('User role ' + $("#txtUserType").val() + ' already exist').css("color", "Red");
                                    $('#txtUserType').val("");

                                }
                                if (msg.toString() == 'F') {
                                    $('#txtUserType').val("");
                                    $("#ModalMsg").modal('show');

                                }
                                if (msg.toString() == 'NF') {
                                    $('#Msg').text('');
                                }
                            }
                        }
                    });
                    e.preventDefault();
                    return false;
                }
            });
            $('#btnrset').click(function (e) {
                $('#txtUserType').val("");
            });
        });
    </script>
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red" ClientIDMode="Static"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">Role Master</h1>
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-content collapse show">
                                <div class="card-body">
                                    <div class="form-body">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput2">User Type</label>
                                                    <asp:TextBox ID="txtUserType" runat="server" class="form-control" placeholder="User Type" MaxLength="30"></asp:TextBox>
                                                    <asp:HiddenField runat="server" ID="hdnId" Value="0"/>
                                                    <span id="Msg"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="text-left">
                                                <asp:LinkButton ID="btnSubmit" runat="server" Text="Submit" class="btn btn-success" ValidationGroup="gb1"><i class="la la-thumbs-o-up position-right"></i> Submit</asp:LinkButton>
                                                <asp:LinkButton ID="btnrset" runat="server" Text="Reset" class="btn btn-danger reset-btn"><i class="la la-refresh position-right"></i> Reset</asp:LinkButton>
                                            </div>
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
                                <h4 class="card-title">Role Master</h4>
                            </div>
                            <div class="card-content">
                                <div class="table-responsive">
                                    <table class="table table-de mb-0">
                                        <asp:GridView ID="GV_RoleMaster" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                            PagerStyle-CssClass="bs-pagination" OnRowCommand="GV_RoleMaster_RowCommand" OnPageIndexChanging="GV_RoleMaster_PageIndexChanging" OnRowDataBound="GV_RoleMaster_RowDataBound" OnSelectedIndexChanged="GV_RoleMaster_SelectedIndexChanged">
                                            <Columns>
                                                <asp:TemplateField HeaderText="S.No." ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" /> 
                                                        <asp:Label ID="lblUserId" runat="server" Text='<%#Bind("UserTypeId") %>' Visible="false"></asp:Label>                                                      
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="User Type" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblUserType" runat="server" Text='<%#Bind("UserType") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Active" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnActive" runat="server" Text="Active" class="btn btn-sm round btn-outline-danger" CommandName="Active" CommandArgument="<%# Container.DataItemIndex %>"></asp:Button>
                                                       <asp:HiddenField ID="HiddenIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Deactive" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btndeactive" runat="server" Text="Deactive" class="btn btn-sm round btn-outline-danger" CommandName="Deactive" CommandArgument="<%# Container.DataItemIndex %>"></asp:Button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Edit" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btnEdit" runat="server" Text="Edit" class="btn btn-sm round btn-outline-danger" CommandName="Select"></asp:LinkButton>
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

    <div id="ModalMsg" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <%-- <button type="button" class="close" data-dismiss="modal" aria-hidden="true" >&times;</button>--%>
                    <a class="close" href="/Admin/RoleMaster.aspx">&times;</a>
                </div>
                <div class="modal-body text-center">
                    <h4>Success!</h4>
                    <p>Details submitted successfully !</p>
                    <%--<button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>--%>
                    <a class="btn btn-success" href="/Admin/RoleMaster.aspx"><span>Close</span></a>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

