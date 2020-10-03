<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="AgeGroupMaster.aspx.cs" Inherits="AgeGroupMaster" ClientIDMode="Static" %>

<%@ Register Namespace="AjaxControlToolkit" Assembly="AjaxControlToolkit" TagPrefix="ajax" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <script src="../Assets/js/jquery.min.js"></script>
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
        $(document).ready(function () {
            $('#txtAgeGrouop').bind('keyup', function (e) {
                if (this.value.match(/[^0-9.]/g)) {
                    this.value = this.value.replace(/[^0-9.]/g, '');
                }
            });
           // $('#txtAgeGrouop').numericdot();
            $('#txtmaxagegroup').numeric();
            $('#txtAgeGroupName').name();
            $('#btnSubmit').click(function (e) {

                if ($('#txtAgeGroupName').val() == '') {
                    $('#lblmsg3').text('*Enter Age Group Name').css("color", "red");
                    $('#txtAgeGroupName').focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#lblmsg3').text('');
                }

                if ($('#txtAgeGrouop').val().substring(0, 1) == '.') {
                    $('#lblmsg1').text('*Enter a valid age Group').css("color", "red");
                    $('#txtAgeGrouop').focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#lblmsg1').text('');
                }
                if (parseFloat($('#txtAgeGrouop').val()) == 0) {
                    $('#lblmsg1').text('*Age group must be greter than 0').css("color", "red");
                    $('#txtAgeGrouop').focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#lblmsg1').text('');
                }
                if (($('#txtAgeGrouop').val().indexOf('.') < 0 && $('#txtAgeGrouop').val().length == 3)) {
                    $('#lblmsg1').text('*Enter a valid age group value').css("color", "red");
                    $('#txtAgeGrouop').focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#lblmsg1').text('');
                }
                if (parseInt($('#txtmaxagegroup').val()) == 0) {
                    $('#lblmsg2').text('*Age group must be greter than 0').css("color", "red");
                    $('#txtmaxagegroup').focus();
                    e.preventDefault();
                    return false;
                }
                else {
                    $('#lblmsg2').text('');
                }
                if (parseFloat($('#txtAgeGrouop').val()) >= parseFloat($('#txtmaxagegroup').val())) {
                    $('#lblmsg2').text('*Max Age Group must be greater than Min Age Group').css("color", "red");
                    $('#txtmaxagegroup').focus();
                    e.preventDefault();
                    return false;

                }
                else {
                    $('#lblmsg2').text('');
                }



            });
        });
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

    <script>
        function ShowMsg() {
            SpnMsg.style.color = "Green";
            SpnMsg.innerHTML = "Submit Successfully !";
        };
        function ShowMsgErr() {
            lblError.style.color = "Red";
            lblError.innerHTML = "Already exist !";

        };
    </script>
     
    <script type="text/javascript">
        function MinAgeGroupMaster() {
            $.ajax({
                url: "AgeGroupMaster.aspx/Page_Load",
                data: {
                    method: "GetMinAgeGroup",
                   
                    MinAgeGroup: $("#txtAgeGrouop").val(),
                    MaxAgeGroup: $("#txtmaxagegroup").val()
                },
                success: function (msg) {
                    if (msg != '') {
                      
                        if (msg.toString() == 'F') {
                            $('#lblMaxAge').text('Min Age Group ' + $("#txtAgeGrouop").val() + ' and Max Age Group ' + $("#txtmaxagegroup").val() + ' already exist!').css("color", "Red");
                            $('#txtAgeGrouop').val("");
                            $('#txtmaxagegroup').val("");
                        }
                        if (msg == 'NF') {
                            $('#lblMaxAge').text('');
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


    <asp:ScriptManager ID="scriptmanager1" runat="server">
    </asp:ScriptManager>
    <asp:UpdatePanel ID="updatepnl" runat="server">
        <ContentTemplate>

            <div class="app-content content">
                <div class="content-wrapper">
                    <div class="content-header row">
                    </div>
                    <div class="content-body">
                       
                        <h1 class="h1Tag">Age Group Master</h1>
                        <!-- Active Orders -->
                        <div class="row">
                            
                            <div class="col-md-12">
                                
                                <div class="card">
                                    
                                    <center><asp:Label ID="SpnMsg" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label></center>
                                    <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red" ClientIDMode="Static"></asp:Label>
                                    <div class="card-header">
                                        <h4 class="card-title" id="basic-layout-form">Age Group Master</h4>

                                    </div>
                                    <div style="height:20px">
                                         <center><asp:Label ID="lblMaxAge" runat="server" ClientIDMode="Static"></asp:Label></center>
                                    </div>
                                    <div class="card-content collapse show">
                                        <div class="card-body">

                                            <div class="form-body">
                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Age Group Name<span class="starRed">*</span></label>

                                                            <asp:TextBox ID="txtAgeGroupName" runat="server" class="form-control" placeholder="Enter Age Group Name" MaxLength="100"></asp:TextBox>
                                                           <%--   <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator2" ControlToValidate="txtAgeGroupName" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter Age Group Name!" />--%>
                                                            <asp:Label ID="lblmsg3" runat="server" ClientIDMode="Static"></asp:Label>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Min Age Group<span class="starRed">*</span></label>

                                                            <asp:TextBox ID="txtAgeGrouop" runat="server" class="form-control" placeholder="Enter Years" MaxLength="3" ></asp:TextBox>
                                                            <asp:RequiredFieldValidator runat="server" ID="reqName" ControlToValidate="txtAgeGrouop" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter min Age Group!" />
                                                            <asp:Label ID="lblmsg1" runat="server" ClientIDMode="Static"></asp:Label>
                                                            <asp:Label ID="lblIAge_Group" runat="server"></asp:Label>

                                                             <asp:Label ID="lblMinAge" runat="server" ClientIDMode="Static"></asp:Label>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Max Age Group<span class="starRed">*</span></label>

                                                            <asp:TextBox ID="txtmaxagegroup" runat="server" class="form-control" placeholder="Enter Years" MaxLength="2" onchange="MinAgeGroupMaster();"></asp:TextBox>
                                                            <asp:RequiredFieldValidator runat="server" ID="RequiredFieldValidator1" ControlToValidate="txtmaxagegroup" ValidationGroup="gb1" Display="Dynamic" ForeColor="Red" ErrorMessage="Please enter max Age Group!" />
                                                            <asp:Label ID="lblmsg2" runat="server" ClientIDMode="Static"></asp:Label>

                                                              
                                                        </div>
                                                    </div>

                                                </div>
                                                <div><asp:Label ID="lblExceded" runat="server" ForeColor="Red"></asp:Label> </div>
                                                <div class="text-left" id="div_btn" runat="server">
                                                   
                                                    <asp:LinkButton ID="btnSubmit" runat="server" Text="Submit" class="btn btn-success" OnClick="btnSubmit_Click" ValidationGroup="gb1" ClientIDMode="Static"><i class="la la-thumbs-o-up position-right"></i> Submit</asp:LinkButton>
                                                    <asp:LinkButton ID="btnReset" runat="server" Text="Reset" class="btn btn-danger reset-btn" OnClick="btnReset_Click"><i class="la la-refresh position-right"></i> Reset</asp:LinkButton>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!-- Active Orders -->
                            <!-- Active Orders -->
                            <%--  <div class="row">--%>
                            <div class="col-12">
                                <div class="card">
                                    <div class="card-header">
                                        <h4 class="card-title">Age Group Master</h4>

                                    </div>
                                    <div class="card-content">
                                        <div class="table-responsive">
                                            <asp:HiddenField ID="HiddenField_ID" runat="server" Value="0" />
                                            <table class="table table-de mb-0">
                                                <asp:GridView ID="GV_AgeGroup" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                                    PagerStyle-CssClass="bs-pagination" OnSelectedIndexChanged="OnSelectedIndexChanged" OnPageIndexChanging="GV_TaxSlab_PageIndexChanging" OnRowCommand="GV_AgeGroup_RowCommand" OnRowDataBound="GV_AgeGroup_RowDataBound">
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Age Group Name" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAgeGroupName" runat="server" Text='<%#Bind("Age_GroupName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Age Group" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblAge_Group" runat="server" Text='<%#Bind("Age_Group") %>'></asp:Label>
                                                                <asp:Label ID="lblAge_id" runat="server" Text='<%#Bind("Agegroup_Id") %>' Visible="false"></asp:Label>
                                                                <asp:HiddenField ID="HiddenIsActive" runat="server" Value='<%# Eval("IsActive") %>' />
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
                            <%-- </div>--%>
                            <!-- Active Orders -->
                        </div>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

