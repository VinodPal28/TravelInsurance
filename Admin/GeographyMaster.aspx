<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="GeographyMaster.aspx.cs" Inherits="Admin_GeographyMaster" ClientIDMode="Static" %>

<%--<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" TagPrefix="ajax" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <link href="../Assets/css/Grid_Pagination.css" rel="stylesheet" />
    <script src="../Assets/js/scripts/bs.pagination.js"></script>
    <script src="../Assets/js/jquery.min.js"></script>
    <script type="text/javascript">
        $(function () {
            $('.multiselect-ui').multiselect({
                includeSelectAllOption: true
            });
        });
    </script>

    <script>
        $(document).ready(function () {
            $("select.select-user-drop-down").change(function () {
                var Val = $(this).val();
                //alert(Val);
                if (Val == '5') {
                    $(".add-user-Workshop").css("display", "block");
                }
                else {
                    $(".add-user-Workshop").css("display", "none");
                }
            });
        });

    </script>

    <script>
        $(function () {
            $('select[multiple].active.3col').multiselect({
                columns: 1,
                placeholder: 'Select Countries',
                search: true,
                searchOptions: {
                    'default': 'Search Countries'
                },
                selectAll: true
            });
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('.name').on('input', function (event) {
                this.value = this.value.replace(/[^a-zA-Z-/()_ ]/g, '');
            });
            $('#btnSubmit').click(function (e) {
                var Country = $("#<%=ddlCountries.ClientID %>").val();

                if ($('#txtName').val() == "") {
                    $('#lblmsgName').text('Please enter the name').css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#lblmsgName').text('');
                }
                //if ($('#ddlRegion option:selected').text() == "" || $('#ddlRegion option:selected').text() == "--Select--") {
                //    $('#lblmsgRegion').text('Please select the region').css("color", "red");
                //    e.preventDefault();
                //    return false;
                //}
                //else {
                //    $('#lblmsgRegion').text('');
                //}
                if (Country == "") {
                    $('#lblmsgCountry').text('Please select the country').css("color", "red");
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#lblmsgCountry').text('');
                }
            });
            //$('#LinkButton1').click(function (e) {
            //    $('#txtName').removeAttr("readonly", false);

            //    $('#ddlCountries').empty();
              
            //});
        });
    </script>

    <script type="text/javascript">
        function CheckGeographyName() {
            $.ajax({
                url: "GeographyMaster.aspx/Page_Load",
                data: {
                    method: "CheckName",
                    name: $("#txtName").val()
                },
                success: function (msg) {
                    if (msg != '') {
                        if (msg.toString() == 'F') {
                            $('#lblmsgName').text('Name ' + $("#txtName").val() + ' already exist').css("color", "Red");
                            $('#txtName').val("");
                        }
                        if (msg.toString() == 'NF') {
                            $('#lblmsgName').text('');
                        }
                    }
                }
            });
        }
        function OnSuccess(response) {
            alert(response.d);
        }
    </script>

    <script type="text/javascript">
        function ShowMessage() {
            setTimeout(function () {
                $("#ModalMsg").modal('show');
            }, 100);

        }
    </script>

    <%--<asp:ScriptManager ID="scriptmanager1" runat="server"></asp:ScriptManager>
    <asp:UpdatePanel ID="updatepnl" runat="server">
        <ContentTemplate>--%>
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
            <div class="content-body">
                <h1 class="h1Tag">Geographical Zones</h1>
                <!-- Active Orders -->

                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title" id="basic-layout-form">Add Geographical Zone</h4>
                            </div>
                            <%--<span id="MsgSuceess"></span>--%>

                            <div class="card-content collapse show">

                                <div class="card-body">

                                    <div class="form-body">
                                        <div class="row">
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput1">Name<span class="starRed">*</span></label>
                                                    <asp:TextBox ID="txtName" runat="server" class="form-control name" placeholder="Name" MaxLength="50" onchange="CheckGeographyName()" AutoCompleteType="Disabled"></asp:TextBox>
                                                    <div style="height: 20px"><span id="lblmsgName" runat="server" style="color: red"></span></div>
                                                </div>
                                            </div>
                                            <%--<div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Continent<span class="starRed">*</span></label>                                               
                                                            <asp:DropDownList ID="ddlRegion" runat="server" class="form-control" placeholder="Select Region"></asp:DropDownList>
                                                            <div style="height:20px"><span id="lblmsgRegion" runat="server" style="color: red"></span></div>
                                                        </div>
                                                    </div>--%>
                                            <div class="col-md-4">
                                                <div class="form-group">
                                                    <label for="projectinput2">Select Countries<span class="starRed">*</span></label>
                                                    <div class="controls">
                                                        <asp:ListBox ID="ddlCountries" runat="server" SelectionMode="Multiple" CssClass="3col active" ClientIDMode="Static" aria-invalid="false"></asp:ListBox>
                                                        <div style="height: 20px"><span id="lblmsgCountry" runat="server" style="color: red"></span></div>
                                                        <div class="help-block"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="text-right">
                                        <asp:LinkButton ID="btnSubmit" runat="server" class="btn btn-success" OnClick="btnSubmit_Click"><i class="la la-thumbs-o-up position-right"></i> Submit </asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-danger reset-btn" OnClick="LinkButton1_Click"><i class="la la-refresh position-right"></i> Reset </asp:LinkButton>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <!-- Gridview for Geography masters -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">Geographical Zones</h4>
                            </div>
                            <div class="card-content">
                                <div class="table-responsive" id="Gridview-container">

                                    <asp:GridView ID="GV_Geography" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                        PagerStyle-CssClass="bs-pagination" Width="100%" OnPageIndexChanging="GV_Geography_PageIndexChanging" OnRowCommand="GV_Geography_RowCommand" OnRowDataBound="GV_Geography_RowDataBound" OnSelectedIndexChanged="GV_Geography_SelectedIndexChanged">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No." ItemStyle-Width="10%" HeaderStyle-Width="10%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                                                    <asp:Label ID="lblId" runat="server" Text='<%#Bind("Id")%>' Visible="false"></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Name" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblName" runat="server" Text='<%#Bind("Name") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <%--<asp:TemplateField HeaderText="Region" ItemStyle-Width="15%" HeaderStyle-Width="15%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblRegion" runat="server" Text='<%#Bind("Region") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Country" ItemStyle-Width="30%" HeaderStyle-Width="30%" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblCountry" runat="server" Text='<%#Bind("Country") %>'></asp:Label>
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
    <%--</ContentTemplate>
    </asp:UpdatePanel>--%>

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

