<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="WalletStatement.aspx.cs" Inherits="Partner_WalletStatement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
                                <h4 class="card-title">Wallet Statement</h4>
                                <div class="row" style="margin-top: 20px;">

                                    <div class="col-md-6" >
                                        <div class="form-group" >
                                            <asp:Button ID="btnExportToExcel" runat="server" CssClass="btn btn-primary" Text="Export To Excel"  OnClick="btnExportToExcel_Click"/>
                                        </div>
                                    </div>

                                    <div class="col-md-6">
                                        <span id="WalletBlnce" runat="server" class="btn btn-primary pull-right">Wallet Balance : <i class="fa fa-rupee" aria-hidden="true"></i>
                                            <asp:Label ID="lblWalletBlnce" runat="server" Font-Bold="true"></asp:Label></span>
                                    </div>
                                </div>
                            <div class="card-content">
                                <div class="table-responsive" id="Gridview-container">
                                    <asp:GridView ID="GV_TranxDetails" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                        PagerStyle-CssClass="bs-pagination" Width="100%" OnRowDataBound="GV_TranxDetails_RowDataBound" OnPageIndexChanging="GV_TranxDetails_PageIndexChanging">
                                        <Columns>

                                            <asp:TemplateField HeaderText="Transaction Id" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblID" runat="server" Text='<%#Bind("Transaction_Id") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Policy No" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblPolicyNo" runat="server" Text='<%#Bind("Policy_No") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Transaction Details" ItemStyle-Width="20%" HeaderStyle-Width="20%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblTransacdetls" runat="server" Text='<%#Bind("Transcation_Details") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Date" ItemStyle-Width="20%" HeaderStyle-Width="20%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDate" runat="server" Text='<%#Bind("Date") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Amount" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblAmt" runat="server" Text='<%#Bind("Amount") %>'></asp:Label>
                                                </ItemTemplate>

                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Status" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStatus" runat="server" Text='<%#Bind("Status") %>'></asp:Label><%--</span>--%>
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
</asp:Content>

