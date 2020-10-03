<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" ClientIDMode="Static" CodeFile="InsurerMaster.aspx.cs" Inherits="Admin_InsurerMaster" EnableEventValidation="false" %>

<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" TagPrefix="ajax" %>

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
        function ShowMsg() {
            setTimeout(function () {
                $("#ModalMsg").modal('show');
            }, 100);

        }     
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
          //  $('#txtIsurercode').AlphaNum();
            // $('#txtInsurername').name();
            $('#txtIsurercode').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9 ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9 ]/g, '');
                }
            });
            $('#txtInsurername').bind('keyup', function (e) {
                if (this.value.match(/[^a-zA-Z0-9 ]/g)) {
                    this.value = this.value.replace(/[^a-zA-Z0-9 ]/g, '');
                }
            });

        });
    </script>

    <script type="text/javascript">
        function InsurerCode() {
            $.ajax({
                url: "InsurerMaster.aspx/Page_Load",
                data: {
                    method: "InsurerCode",
                    InsurCode: $("#txtIsurercode").val()
                },
                success: function (msg) {
                    if (msg != '') {
                        //  var data = $("#txtIsurercode").val();

                        if (msg.toString() == 'F') {
                            $('#lblInsurCode').text('Insurer code ' + $("#txtIsurercode").val() + ' already exist!').css("color", "Red");
                            $('#txtIsurercode').val("");
                        }
                        if (msg == 'NF') {
                            $('#lblInsurCode').text('');
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

    <asp:ScriptManager ID="scriptmanager2" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="updatepnl" runat="server">

        <ContentTemplate>
            <div class="app-content content">
                <div class="content-wrapper">
                    <div class="content-header row">
                    </div>

                    <div class="content-body">

                        <h1 class="h1Tag">Insurer Master</h1>

                        <!-- Active Orders -->
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <asp:Label ID="SpnMsg" runat="server" ClientIDMode="Static"></asp:Label>
                                    <asp:Label ID="lblerrorMsg" runat="server" ClientIDMode="Static"></asp:Label>
                                    <div class="card-header">
                                        <h4 class="card-title" id="basic-layout-form">Insurer Master</h4>
                                    </div>
                                    <div class="card-content collapse show">
                                        <div class="card-body">

                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Insured Code</label>
                                                            <asp:TextBox ID="txtID" runat="server" class="form-control" Visible="false"></asp:TextBox>
                                                            <asp:TextBox ID="txtIsurercode" runat="server" class="form-control" placeholder="Insured Code" onchange="checkInsurerCode()"></asp:TextBox>
                                                            <asp:Label ID="lblInsurCode" runat="server" ClientIDMode="Static"></asp:Label>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtIsurercode" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter Insured Code!" />
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Insured Name</label>
                                                            <asp:TextBox ID="txtInsurername" runat="server" class="form-control" placeholder="Insured Name"></asp:TextBox>
                                                            <asp:RequiredFieldValidator runat="server" ID="reqName" ControlToValidate="txtInsurername" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter Insured Name!" />
                                                        </div>
                                                    </div>


                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput2">Home State</label>
                                                            <div class="controls">
                                                                <asp:DropDownList ID="ddlhomestate" runat="server" class="form-control"></asp:DropDownList>
                                                                <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ValidationGroup="gb1" InitialValue="0" ControlToValidate="ddlhomestate" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter Home State!" />
                                                            </div>
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
                                    <h4 class="card-title">Insurer Master</h4>

                                </div>
                                <div class="card-content">
                                    <div class="table-responsive">
                                        <table class="table table-de mb-0">
                                            <asp:GridView ID="GV_Insured" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true" OnSelectedIndexChanged="OnSelectedIndexChanged" OnPageIndexChanging="GV_Insured_PageIndexChanging" OnRowCommand="GV_Insured_RowCommand"
                                                OnRowDataBound="GV_Insured_RowDataBound" PagerStyle-CssClass="bs-pagination">

                                                <Columns>
                                                     <asp:TemplateField HeaderText="Sr.No." ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                            <asp:Label ID="lblId" runat="server" Text='<%#Bind("Insurer_Id")%>' Visible="false"></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                     <asp:TemplateField HeaderText="Insured Code" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblInsuredcode" runat="server" Text='<%#Bind("Insurer_Code") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Insured Name" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblInsuredname" runat="server" Text='<%#Bind("Insurer_Name") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                   
                                                    <asp:TemplateField HeaderText="Home State" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblHome_State" runat="server" Text='<%#Bind("Home_State") %>'></asp:Label>
                                                            <asp:HiddenField ID="HiddenIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
                                                            <asp:Label ID="lbl_ID" runat="server" Text='<%#Bind("insurer_Id") %>' Visible="false"></asp:Label>
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

                                                            <asp:LinkButton Text="Edit" ID="lnkSelect" runat="server" CommandName="Select" class="btn btn-sm round btn-outline-danger" OnClientClick="myFunction();" ClientIDMode="Static" />
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
        </ContentTemplate>
    </asp:UpdatePanel>

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
                    <p>Insurer details submitted successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

