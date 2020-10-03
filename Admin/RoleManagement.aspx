<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="RoleManagement.aspx.cs" Inherits="Admin_RoleManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script type="text/javascript">       
        function ShowMessage() {
            setTimeout(function () {
                $("#ModalMsg").modal('show');
            }, 100);

        }
    </script>
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <div class="content-body">
                <%--<h1 class="h1Tag">Manage User</h1>--%>
                <br />

                <div class="col-6 col-sm-12 ">
                    <div class="btn-group option-select edit-btn">
                        <div class="form-group">
                            <label>Select User Type : </label>
                            <asp:DropDownList ID="ddlUserRole" runat="server" class="form-control" DataValueField="UserName" OnSelectedIndexChanged="ddlUserRole_SelectedIndexChanged" AutoPostBack="true">
                            </asp:DropDownList>

                        </div>
                    </div>
                </div>

                <!-- Active Orders -->
                <div class="row" runat="server" id="Div_UserRole">
                    <div class="col-12">
                        <div class="card">
                            <!-- start search -->
                            <%--<div class="pull-right">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label for="projectinput1">Search</label>
                                        <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="true" class="form-control" placeholder="Page Name"></asp:TextBox>
                                    </div>
                                </div>

                            </div>--%>
                            <!-- end search -->

                            <div class="card-content">
                                <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red"></asp:Label>
                                <div class="table-responsive" style="margin-top: 15px;margin-left: 15px;">
                                    <table class="table table-de mb-0" style="border: 2px solid darkgray">

                                        <asp:GridView ID="GV_RoleMgmt" runat="server" CssClass="table table-bordered table-hover table-striped" Width="480px" AllowSorting="true"
                                            AllowPaging="false" AutoGenerateColumns="False" ShowFooter="false" PagerStyle-CssClass="bs-pagination" OnRowDataBound="GV_RoleMgmt_RowDataBound">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Select" Visible="true">
                                                    <ItemStyle HorizontalAlign="Left" Width="50px" />
                                                    <ItemTemplate>
                                                        <asp:CheckBox runat="server" ID="chkSelect" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Name" Visible="true">
                                                    <ItemStyle HorizontalAlign="Left" Width="100px" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblName" runat="server" Text='<%# Eval("Menu_Name")%>'></asp:Label>
                                                        <asp:HiddenField ID="hdnmodel" runat="server" Value='<%# Eval("Id")%>' />
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                            </Columns>
                                            <HeaderStyle CssClass="gridheader" HorizontalAlign="Center" />
                                            <RowStyle CssClass="gridrow" HorizontalAlign="Center" />
                                            <EmptyDataTemplate><b style="color: red">No Record Available</b></EmptyDataTemplate>
                                        </asp:GridView>
                                    </table>
                                    <div style="margin-left: 15px; margin-bottom: 12px;">
                                        <asp:Button runat="server" ID="btnSave" Text="Save" class="btn btn-primary" OnClick="btnSave_Click"/>
                                    </div>
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
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <h4>Success!</h4>
                    <p> </p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

