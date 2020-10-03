<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="PassengersType.aspx.cs" Inherits="Admin_PassengersType" ClientIDMode="Static" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <script src="../Assets/js/jquery.min.js"></script>
    <link href="../Assets/css/Grid_Pagination.css" rel="stylesheet" />
    <script src="../Assets/js/scripts/bs.pagination.js"></script>
    <script src="../Assets/js/Valid.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#div_btn").hide();
            $('#txtMinAgeGrouop').bind('keyup', function (e) {
                if (this.value.match(/[^0-9.]/g)) {
                    this.value = this.value.replace(/[^0-9.]/g, '');
                }
            });
            $('#txtmaxagegroup').bind('keyup', function (e) {
                if (this.value.match(/[^0-9.]/g)) {
                    this.value = this.value.replace(/[^0-9.]/g, '');
                }
            });
            $('#txtPassengerstype').bind('keyup', function (e) {
                if (this.value.match(/[^A-Za-z0-9. ]/g)) {
                    this.value = this.value.replace(/[^A-Za-z0-9. ]/g, '');
                }
            });
            //$('#txtAgeGrouop').numericdot();
            //$('#txtmaxagegroup').numeric();
            //$('#txtPassengerstype').name();
            
            $('#btnSubmit').click(function (e) {
               
                if ($('#txtPassengerstype').val() == '') {
                    $('#lblmsg2').text('*Enter Age Group Name').css("color", "red");
                    $('#txtPassengerstype').focus();
                    e.preventDefault();
                    return false;
                }

                else if ($('#txtMinAgeGrouop').val() == '') {
                    $('#lblmsg2').text('*Enter Min Age').css("color", "red");
                    $('#txtMinAgeGrouop').focus();
                    e.preventDefault();
                    return false;
                }

                else if ($('#txtmaxagegroup').val() == '') {
                    $('#lblmsg2').text('*Enter Max Age').css("color", "red");
                    $('#txtmaxagegroup').focus();
                    e.preventDefault();
                    return false;
                }


                else if ($('#txtMinAgeGrouop').val().substring(0, 1) == '.') {
                    $('#lblmsg2').text('*Enter a valid age Group').css("color", "red");
                    $('#txtMinAgeGrouop').focus();
                    e.preventDefault();
                    return false;
                }

                //else if (parseFloat($('#txtMinAgeGrouop').val()) == "") {
                //    $('#lblmsg2').text('*Age group must be greter than 0').css("color", "red");
                //    $('#txtMinAgeGrouop').focus();
                //    e.preventDefault();
                //    return false;
                //}
                    //if (($('#txtMinAgeGrouop').val().indexOf('.') < 0 && $('#txtMinAgeGrouop').val().length == 3)) {
                    //    $('#lblmsg1').text('*Enter a valid age group value').css("color", "red");
                    //    $('#txtMinAgeGrouop').focus();
                    //    e.preventDefault();
                    //    return false;
                    //}
                    //else {
                    //    $('#lblmsg1').text('');
                    //}
                else if (parseFloat($('#txtmaxagegroup').val()) == 0) {
                    $('#lblmsg2').text('*Age group must be greter than 0').css("color", "red");
                    $('#txtmaxagegroup').focus();
                    e.preventDefault();
                    return false;
                }

                else if (parseFloat($('#txtmaxagegroup').val()) > 150) {
                    $('#lblmsg2').text('*Max Age can not be greater than 150.').css("color", "red");
                    $('#txtMinAgeGrouop').focus();
                    e.preventDefault();
                    return false;
                }

                else if (parseFloat($('#txtMinAgeGrouop').val()) > parseFloat($('#txtmaxagegroup').val())) {
                    $('#lblmsg2').text('*Max Age Group must be greater than Min Age Group').css("color", "red");
                    $('#txtMinAgeGrouop').focus();
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
        function MinAgeGroupMaster() {

            $.ajax({
                url: "PassengersType.aspx/Page_Load",
                data: {
                    method: "GetMinAgeGroup",
                    MinAgeGroup: $("#txtMinAgeGrouop").val(),
                    MaxAgeGroup: $("#txtmaxagegroup").val(),
                    //  PassengersType: $('#txtPassengerstype').val()

                },
                success: function (msg) {
                    // alert(msg);
                    if (msg != '') {
                        //alert(1);
                        if (msg.toString() == 'F') {

                            $('#lblmsg2').text('Age Group must be greater than existing age group !').css("color", "Red");
                            $('#txtMinAgeGrouop').val("");
                            $('#txtmaxagegroup').val("");
                            e.preventDefault();
                            return false;
                        }
                        if (msg == 'NF') {
                            $('#lblmsg2').text('');
                            $("#div_btn").show();
                            // $('#txtMinAgeGrouop').val("");
                            // $('#txtmaxagegroup').val("");
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

    <script type="text/javascript">
        function messageshow() {
            setTimeout(function () {
                $("#MyModel_MsgSuccess").modal('show');
            }, 100);
        }
    </script>

    
 
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>

            <div class="content-body">
                <h1 class="h1Tag">Passengers Type</h1>
                <br />
                <!-- Active Orders -->
                <div class="row">
                    <div class="col-12">
                        <div class="card">

                            <div class="card-content">
                                <div class="table-responsive">
                                    <div class="card-content collapse show">
                                        <div class="card-body">
                                            <div style="height: 20px">
                                                <asp:HiddenField ID="HiddenField_ID" runat="server" Value="0" />
                                                <asp:HiddenField ID="HiddenFieldIsactive" runat="server" Value="0" />
                                                <center><asp:Label ID="lblMaxAge" runat="server" ClientIDMode="Static"></asp:Label></center>
                                                <center><asp:Label ID="lblmsg1" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label></center>
                                                <center><asp:Label ID="lblmsg2" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label></center>
                                                <center><asp:Label ID="lblmsg3" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label></center>
                                                <center><asp:Label ID="SpnMsg" runat="server" ForeColor="Green" ClientIDMode="Static"></asp:Label></center>
                                                <asp:Label ID="lblerrorMsg" runat="server" ForeColor="Red" ClientIDMode="Static"></asp:Label>
                                            </div>
                                            <br />
                                            <div class="form-body">

                                                <div class="row">
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Passengers Type<span class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtPassengerstype" runat="server" class="form-control" placeholder="Enter Passengers Type" MaxLength="100" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Min Age Group<span class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtMinAgeGrouop" runat="server" class="form-control" placeholder="Enter Min Age" MaxLength="5" AutoCompleteType="Disabled"></asp:TextBox>
                                                        </div>
                                                    </div>

                                                    <div class="col-md-4">
                                                        <div class="form-group">
                                                            <label for="projectinput1">Max Age Group<span class="starRed">*</span></label>
                                                            <asp:TextBox ID="txtmaxagegroup" runat="server" class="form-control" placeholder="Enter Max Age" MaxLength="5" onchange="MinAgeGroupMaster();" AutoCompleteType="Disabled"></asp:TextBox><%--onchange="MinAgeGroupMaster();"--%>
                                                        </div>
                                                    </div>
                                                    <div class="text-right" id="div_btn" runat="server" style="margin-left: 79%;">

                                                        <asp:LinkButton ID="btnSubmit" runat="server" Text="Submit" class="btn btn-success" ClientIDMode="Static" OnClick="btnSubmit_Click"><i class="la la-thumbs-o-up position-right"></i> Submit</asp:LinkButton>
                                                        <asp:LinkButton ID="btnReset" runat="server" Text="Reset" class="btn btn-danger reset-btn" OnClick="btnReset_Click"><i class="la la-refresh position-right"></i> Reset</asp:LinkButton>
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                    </div>
                                    <table class="table table-de mb-0">
                                        <asp:GridView ID="GV_AgeGroup" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" ShowHeaderWhenEmpty="true" class="table table-de mb-0" AutoGenerateColumns="false" PageSize="10" AllowPaging="true"
                                            PagerStyle-CssClass="bs-pagination" Width="100%" OnPageIndexChanging="GV_AgeGroup_PageIndexChanging" OnRowCommand="GV_AgeGroup_RowCommand" OnRowDataBound="GV_AgeGroup_RowDataBound" OnSelectedIndexChanged="GV_AgeGroup_SelectedIndexChanged" OnRowDeleting="GV_AgeGroup_RowDeleting">

                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No.">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />

                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Passengers Type">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblPassengertype" runat="server" Text='<%#Bind("passengers_type") %>' Visible="true"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Age Group">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblAgegroup" runat="server" Text='<%#Bind("Agegroup") %>'></asp:Label>
                                                        <asp:HiddenField ID="HiddenIsActive" runat="server" Value='<%# Eval("IsActive") %>' />

                                                        <asp:Label ID="lblAge_id" runat="server" Text='<%#Bind("Passengers_Id") %>' Visible="false"></asp:Label>
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

                                                <asp:TemplateField HeaderText="Delete" ItemStyle-Width="20px" HeaderStyle-Width="20px" ItemStyle-HorizontalAlign="Left" HeaderStyle-HorizontalAlign="Left">
                                                    <ItemTemplate>
                                                        <asp:LinkButton ID="btndelete" runat="server" Text="Delete" class="btn btn-sm round btn-outline-danger" CommandName="Delete" CommandArgument="<%# Container.DataItemIndex %>"></asp:LinkButton>
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

    <div id="MyModel_MsgSuccess" class="modal fade">
        <div class="modal-dialog modal-confirm">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="icon-box">
                        <i class="la la-check"></i>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body text-center">
                    <%-- <h4>Passengers Type</h4>--%>
                    <p style="color: black; margin-left: 3%">Submitted successfully. </p>

                </div>
            </div>
        </div>
    </div>
</asp:Content>

