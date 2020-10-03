<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="CommissionGeneration.aspx.cs" Inherits="Admin_CommissionGeneration" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Assets/js/jquery.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#btnSave').click(function (e) {

                if ($('#ddlMonth').val() == '0') {
                    $('#lblmsg').text('*Select a month').css("color", "red");
                    $('#ddlMonth').focus();
                    e.preventDefault();
                    return false;
                }
                else if ($('#ddlYear').val() == '0') {
                    $('#lblmsg').text('*Select a year').css("color", "red");
                    $('#ddlYear').focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#lblmsg').text('');
                }
            });
            $('#btnReset').click(function (e) {
                $('#ddlMonth').val('');
                $('#ddlYear').val('');
            });
        });
    </script>
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">Commission Generation</h1>
                <!-- Active Orders -->

                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-body input-textbox">
                                <div class="table-responsive">
                                    <br />
                                    <div style="height: 20px; margin-left: 29%;">
                                        <asp:Label ID="lblmsg" runat="server"></asp:Label>
                                    </div>

                                    <div class="card-content collapse show">
                                        <div class="card-body">
                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Month<span class="starRed" style="color: red">*</span></label>
                                                            <asp:DropDownList ID="ddlMonth" runat="server" class="form-control" ClientIDMode="Static">
                                                                <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                                <asp:ListItem Text="January" Value="01"></asp:ListItem>
                                                                <asp:ListItem Text="February" Value="02"></asp:ListItem>
                                                                <asp:ListItem Text="March" Value="03"></asp:ListItem>
                                                                <asp:ListItem Text="April" Value="04"></asp:ListItem>
                                                                <asp:ListItem Text="May" Value="05"></asp:ListItem>
                                                                <asp:ListItem Text="June" Value="06"></asp:ListItem>
                                                                <asp:ListItem Text="July" Value="07"></asp:ListItem>
                                                                <asp:ListItem Text="August" Value="08"></asp:ListItem>
                                                                <asp:ListItem Text="September" Value="09"></asp:ListItem>
                                                                <asp:ListItem Text="October" Value="10"></asp:ListItem>
                                                                <asp:ListItem Text="November" Value="11"></asp:ListItem>
                                                                <asp:ListItem Text="December" Value="12"></asp:ListItem>
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Year<span class="starRed" style="color: red">*</span></label>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="ddlYear" runat="server" class="form-control" ClientIDMode="Static">
                                                                    <asp:ListItem Text="Select" Value="0"></asp:ListItem>
                                                                </asp:DropDownList>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="text-left">
                                                <asp:LinkButton ID="btnSave" runat="server" class="btn btn-success" OnClick="btnSave_Click"><i class="la la-thumbs-o-up position-right"></i> Submit </asp:LinkButton>
                                                <asp:LinkButton ID="btnReset" runat="server" class="btn btn-danger reset-btn"><i class="la la-refresh position-right"></i> Reset </asp:LinkButton>
                                            </div>

                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="grid" runat="server">
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                               
                                <div class="card-content">
                                    <div class="table-responsive"><br />
                                        <asp:Button ID="btnExportToexcel" runat="server" CssClass="btn btn-primary edit-bg create-user" Text="Export to Excel" OnClick="btnExportToexcel_Click"/>
                                        <asp:GridView ID="GV_Commision" runat="server" AllowPaging="true" AutoGenerateColumns="false" class="table no-border table-hover custom_table dataTable no-footer dtr-inline manage-users"
                                            PageSize="10" PagerStyle-CssClass="bs-pagination" ShowHeaderWhenEmpty="true">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Particular" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPlan_Name" runat="server" Text='<%#Bind("Plan_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Quantity Sold" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblQuantity" runat="server" Text='<%#Bind("Quantity") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Total Amount(INR)" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTotalPrice" runat="server" Text='<%#Bind("Price") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Commission (%)" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCommission" runat="server" Text='<%#Bind("Commission") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Commission Amount(INR)" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblCommMargin" runat="server" Text='<%#Bind("TotalCommission") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                            </Columns>
                                            <EmptyDataTemplate><b style="color: red">No Record Available</b></EmptyDataTemplate>
                                            <PagerStyle HorizontalAlign="Center" CssClass="GridPager GridPager-Info" />

                                        </asp:GridView>
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

