<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" ClientIDMode="Static" AutoEventWireup="true" CodeFile="ValueAddedService.aspx.cs" Inherits="Admin_ValueAddedService" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Assets/css/Grid_Pagination.css" rel="stylesheet" />
    <script src="../Assets/js/scripts/bs.pagination.js"></script>
    <script src="../Assets/js/Valid.js"></script>
     <script src="../Assets/js/jquery.min.js"></script>
    <script type="text/javascript">
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblerrorMsg.ClientID %>").style.display = "none";
                document.getElementById("<%=SpnMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <script>
        function ShowMsg() {
            SpnMsg.style.color = "Green";
            SpnMsg.innerHTML = "Submitted Successfully!";

        };
        function ShowMsgErr() {
            lblError.style.color = "Red";
            lblError.innerHTML = "Already exist!";
        };
    </script>
   
    <script type="text/javascript">
        $(document).ready(function () {
            $('#txtVASName').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9%() ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9%() ]/g, '');
                }
            });
            $('#txtVASSupplier').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9%() ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9%() ]/g, '');
                }
            });
            $('#txtVASPrice').bind('keyup', function (e) {
                if (this.value.match(/[^0-9.]/g)) {
                    this.value = this.value.replace(/[^0-9.]/g, '');
                }
            });
        });
    </script>
    <script type="text/javascript">
        function CheckVASName() {
            $.ajax({
                url: "ValueAddedService.aspx/Page_Load",
                data: {
                    method: "CheckName",
                    name: $("#txtVASName").val()
                },
                success: function (msg) {
                    if (msg != '') {
                        if (msg.toString() == 'F') {
                            $('#lblMsgshow').text('Name ' + $("#txtVASName").val() + ' already exist').css("color", "Red");
                            $('#txtVASName').val("");
                        }
                        if (msg.toString() == 'NF') {
                            $('#lblMsgshow').text('');
                        }
                    }
                }
            });
        }
        function OnSuccess(response) {
            alert(response.d);
        }
    </script>
    
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <div class="content-body">
                <h1 class="h1Tag">Value Added Service Master</h1>
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <asp:Label ID="SpnMsg" runat="server"></asp:Label>
                            <asp:Label ID="lblerrorMsg" runat="server"></asp:Label>
                            <div class="card-header">
                                <h4 class="card-title" id="basic-layout-form">Value Added Service Master</h4>
                            </div>
                            <div class="card-content collapse show">
                                <div class="card-body">
                                    <div class="form-body">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="benifits">VAS Name*</label>

                                                    <asp:TextBox ID="txtVASName" runat="server" class="form-control" placeholder="VAS Name" MaxLength="100" onchange="CheckVASName();"></asp:TextBox>
                                                    <span id="lblMsgshow"></span>
                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtVASName" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter VAS Name!" />
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="benifits">VAS Supplier*</label>
                                                    <asp:TextBox ID="txtVASSupplier" runat="server" class="form-control" placeholder="VAS Supplier" MaxLength="100"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txtVASSupplier" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter VAS Supplier!" />
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="benifits">Price*</label>
                                                    <asp:TextBox ID="txtVASPrice" runat="server" class="form-control" placeholder="VAS Supplier" MaxLength="8"></asp:TextBox>
                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator3" ControlToValidate="txtVASPrice" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter the price!" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="text-left">

                                            <asp:LinkButton ID="btnsubmit" runat="server" class="btn btn-success" OnClick="btnsubmit_Click" ValidationGroup="gb1"><i class="la la-thumbs-o-up position-right"></i> Submit</asp:LinkButton>
                                            <asp:LinkButton ID="btnreset" runat="server" class="btn btn-danger reset-btn" OnClick="btnreset_Click"><i class="la la-refresh position-right"></i> Reset</asp:LinkButton>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                <!-- Active Orders -->


                 <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">Value Added Service Master</h4>

                        </div>
                        <div class="card-content">
                            <div class="table-responsive">
                                <table class="table table-de mb-0">
                                    <asp:HiddenField ID="HiddenField_Id" runat="server" Value="0" />
                                    <asp:GridView ID="GV_VAS" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true" OnSelectedIndexChanged="GV_VAS_SelectedIndexChanged" OnPageIndexChanging="GV_VAS_PageIndexChanging"
                                        OnRowDataBound="GV_VAS_RowDataBound" OnRowCommand="GV_VAS_RowCommand"
                                        PagerStyle-CssClass="bs-pagination">
                                        <%--OnRowCommand="GV_Insured_RowCommand"--%>
                                        <Columns>
                                            <asp:TemplateField HeaderText="VAS Name" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVASname" runat="server" Text='<%#Bind("VAS_Name") %>'></asp:Label>
                                                    <asp:HiddenField ID="HiddenIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
                                                    <asp:Label ID="lblID" runat="server" Text='<%#Bind("VAS_Id") %>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="VAS Supplier" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVASSupplier" runat="server" Text='<%#Bind("VAS_Supplier") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="Price" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblVASPrice" runat="server" Text='<%#Bind("price") %>'></asp:Label>
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
                                            <asp:TemplateField HeaderText="Edit" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <%--  <asp:LinkButton ID="btnEdit" runat="server" Text="Edit" class="btn btn-sm round btn-outline-danger" CommandName="Edit" CommandArgument="<%# Container.DataItemIndex %>"></asp:LinkButton>--%>
                                                    <%--       <asp:LinkButton ID="btnEdit" runat="server" Text="Edit" class="btn btn-sm round btn-outline-danger" ></asp:LinkButton>--%>
                                                    <asp:LinkButton Text="Edit" ID="lnkSelect" runat="server" CommandName="Select" class="btn btn-sm round btn-outline-danger" />
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
</asp:Content>

