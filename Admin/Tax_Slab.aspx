<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Tax_Slab.aspx.cs" Inherits="Admin_Tax_Slab" EnableEventValidation="false" ClientIDMode="Static" %>

<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" TagPrefix="ajax" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link href="../Assets/css/Grid_Pagination.css" rel="stylesheet" />
    <script src="../Assets/js/scripts/bs.pagination.js"></script>
    <script src="../Assets/js/Valid.js"></script>



    <script type="text/javascript">

        function isNumberKey(evt, obj) {

            var charCode = (evt.which) ? evt.which : event.keyCode
            var value = obj.value;
            var dotcontains = value.indexOf(".") != -1;
            if (dotcontains)
                if (charCode == 46) return false;
            if (charCode == 46) return true;
            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }



    </script>
    <script type="text/javascript">
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblerrorMsg.ClientID %>").style.display = "none";
                document.getElementById("<%=SpnMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <script type="text/javascript">
        function ShowWallet() {
            setTimeout(function () {
                $("#lblSuccessmsg").modal('show');
            }, 100);

        }
        function ShowMessage() {
            setTimeout(function () {
                $("#ModalMsg").modal('show');
            }, 100);

        }
    </script>
    <script>


        function ShowMsg() {
            SpnMsg.style.color = "Green";
            SpnMsg.innerHTML = "Tax Slab Submit Successfully !";

        };
        function ShowMsgErr() {
            lblError.style.color = "Red";
            lblError.innerHTML = "Already exist !";

        };
    </script>

    <script type='text/javascript'>
        $(function ($) {
            $('#txtCGST').autoNumeric('init', { lZero: 'deny', aSep: '', mDec: 0 });


        });

    </script>
    <%--  <script type="text/javascript">
        $(document).ready(function () {
            $('#txtCGST').numeric();
            $('#txtSGCST').numeric();
            $('#txtIGST').numeric();
        });
    </script>--%>

    <asp:ScriptManager ID="scriptmanager2" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="updatepnl" runat="server">

        <ContentTemplate>
            <div class="app-content content">
                <div class="content-wrapper">
                    <div class="content-header row">
                    </div>
                    <asp:Label ID="SpnMsg" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label>
                    <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red" ClientIDMode="Static"></asp:Label>
               
                    <div class="content-body">
                        <h1 class="h1Tag">Tax Slab Master</h1>

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
                                                            <label for="projectinput2">CGST</label>

                                                            <asp:TextBox ID="txtCGST" runat="server" class="form-control" placeholder="CGST" name="lname" MaxLength="5" onkeypress="return isNumberKey(event,this)"></asp:TextBox>
                                                            <asp:RequiredFieldValidator runat="server" ID="reqName" ControlToValidate="txtCGST" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter your CGST!" />
                                                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator1" ControlToValidate="txtCGST" runat="server" ErrorMessage="Only Numbers allowed" ValidationExpression="\d+" ValidationGroup="gb1"></asp:RegularExpressionValidator>--%>
                                                            <asp:regularexpressionvalidator id="revAvailablePeriod" runat="server" errormessage="Must be greater than 0" controltovalidate="txtCGST" display="Dynamic" forecolor="Red" validationexpression="^[1-9][0-9]*(\.[0-9]+)?|0+\.[0-9]*[1-9][0-9]*$" setfocusonerror="true" validationgroup="gb1" xmlns:asp="#unknown"></asp:regularexpressionvalidator>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1" style="display: block">SGST</label>

                                                            <asp:TextBox ID="txtSGCST" runat="server" class="form-control" placeholder="SGST" name="fname" MaxLength="5" onkeypress="return isNumberKey(event,this)"></asp:TextBox>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtSGCST" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter your SGST!" />
                                                            <asp:regularexpressionvalidator id="Regularexpressionvalidator1" runat="server" errormessage="Must be greater than 0" controltovalidate="txtSGCST" display="Dynamic" forecolor="Red" validationexpression="^[1-9][0-9]*(\.[0-9]+)?|0+\.[0-9]*[1-9][0-9]*$" setfocusonerror="true" validationgroup="gb1" xmlns:asp="#unknown"></asp:regularexpressionvalidator>
                                                        </div>
                                                    </div>


                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1" style="display: block">IGST</label>

                                                            <asp:TextBox ID="txtIGST" runat="server" class="form-control width" placeholder="IGST" name="fname" MaxLength="5" onkeypress="return isNumberKey(event,this)"></asp:TextBox>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txtIGST" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter your IGST!" />
                                                            <asp:regularexpressionvalidator id="Regularexpressionvalidator2" runat="server" errormessage="Must be greater than 0" controltovalidate="txtIGST" display="Dynamic" forecolor="Red" validationexpression="^[1-9][0-9]*(\.[0-9]+)?|0+\.[0-9]*[1-9][0-9]*$" setfocusonerror="true" validationgroup="gb1" xmlns:asp="#unknown"></asp:regularexpressionvalidator>
                                                        </div>
                                                    </div>
                                                </div>

                                            </div>
                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="text-left">


                                                        <asp:LinkButton ID="btnSubmit" runat="server" Text="Submit" class="btn btn-success" OnClick="btnSubmit_Click" ValidationGroup="gb1"><i class="la la-thumbs-o-up position-right"></i> Submit</asp:LinkButton>

                                                        <asp:LinkButton ID="btnrset" runat="server" Text="Reset" class="btn btn-danger reset-btn" OnClick="btnrset_Click"><i class="la la-refresh position-right"></i> Reset</asp:LinkButton>
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
                                        <h4 class="card-title">Tax Slab Master</h4>

                                    </div>
                                    <div class="card-content">
                                        <div class="table-responsive">
                                            <table class="table table-de mb-0">
                                                <asp:HiddenField ID="HiddenField_ID" runat="server" Value="0" />

                                                <asp:GridView ID="GV_TaxSlab" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true" OnSelectedIndexChanged="OnSelectedIndexChanged" OnPageIndexChanging="GV_TaxSlab_PageIndexChanging"
                                                    OnRowCommand="GV_Insured_RowCommand" OnRowDataBound="GV_Insured_RowDataBound" PagerStyle-CssClass="bs-pagination">
                                                    <Columns>

                                                        <asp:TemplateField HeaderText="CGST" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblCGST" runat="server" Text='<%#Bind("CGST") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="SGST" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblSGST" runat="server" Text='<%#Bind("SGST") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="IGST" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblIGST" runat="server" Text='<%#Bind("IGST") %>'></asp:Label>
                                                                <asp:HiddenField ID="HiddenIsActive" runat="server" Value='<%# Eval("IsActive") %>' />

                                                                <asp:Label ID="lblTaxslab_Id" runat="server" Visible="false" Text='<%#Bind("Taxslab_Id") %>'></asp:Label>
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
                    <p>Details submitted successfully !</p>
                    <button class="btn btn-success" data-dismiss="modal"><span>Close</span></button>
                </div>
            </div>
        </div>
    </div>

</asp:Content>



