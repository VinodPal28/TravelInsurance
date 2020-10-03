<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" ClientIDMode="Static" CodeFile="BenifitMaster.aspx.cs" Inherits="Admin_BenifitMaster"  %>

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
        $(function () {
             $('#txtBenifits').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9%() ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9%() ]/g, '');
                }
            });
        });
    </script>
    <script type="text/javascript">
        function CheckBenefitName() {
            $.ajax({
                url: "BenifitMaster.aspx/Page_Load",
                data: {
                    method: "CheckName",
                    name: $("#txtBenifits").val()
                },
                success: function (msg) {
                    if (msg != '') {
                        if (msg.toString() == 'F') {
                            $('#DuplicErrormsg').text('Name ' + $("#txtBenifits").val() + ' already exist').css("color", "Red");
                            $('#txtBenifits').val("");
                        }
                        if (msg.toString() == 'NF') {
                            $('#DuplicErrormsg').text('');
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
                <h1 class="h1Tag">Benefits Master</h1>
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <asp:Label ID="SpnMsg" runat="server"></asp:Label>
                            <asp:Label ID="lblerrorMsg" runat="server"></asp:Label>
                            <div class="card-header">
                                <h4 class="card-title" id="basic-layout-form">Benefits Master</h4>
                            </div>
                            <div class="card-content collapse show">
                                <div class="card-body">
                                    <div class="form-body">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="benifits">Benifits Name*</label>

                                                    <asp:TextBox ID="txtBenifits" runat="server" class="form-control" placeholder="Benifits" MaxLength="200" onchange="CheckBenefitName();"></asp:TextBox>
                                                    <span id="DuplicErrormsg"></span>
                                                    <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtBenifits" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter Benifits!" />
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

                <div class="row">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="card-title">Benifits Master</h4>

                        </div>
                        <div class="card-content">
                            <div class="table-responsive">
                                <table class="table table-de mb-0">
                                    <asp:HiddenField ID="HiddenField_Id" runat="server" Value="0" />
                                    <asp:GridView ID="GV_Benifits" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true" OnSelectedIndexChanged="GV_Benifits_SelectedIndexChanged" OnPageIndexChanging="GV_Benifits_PageIndexChanging"
                                        OnRowDataBound="GV_Benifits_RowDataBound" OnRowCommand="GV_Benifits_RowCommand"
                                        PagerStyle-CssClass="bs-pagination">
                                        <%--OnRowCommand="GV_Insured_RowCommand"--%>
                                        <Columns>

                                            <asp:TemplateField HeaderText="Benifits Name" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblBenifitsname" runat="server" Text='<%#Bind("Benifit_Name") %>'></asp:Label>
                                                    <asp:HiddenField ID="HiddenIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
                                                    <asp:Label ID="lblID" runat="server" Text='<%#Bind("Benifit_Id") %>' Visible="false"></asp:Label>
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
            </div>
        </div>
    </div>
</asp:Content>

