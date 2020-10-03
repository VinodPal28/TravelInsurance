<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="faq.aspx.cs" Inherits="Admin_faq" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-body faq-section">
                <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red"></asp:Label>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <h1 class="h1Tag">FAQ's</h1>
                    <!--Accordion wrapper-->
                    <div class="accordion" id="accordionEx" role="tablist" aria-multiselectable="true">
                        <div id="Faq_Id" runat="server"></div>
                        <!-- Accordion card -->

                 <%--       <div class="card">
                           
                            <div class="card-header" role="tab" id="headingOne">
                                <a data-toggle="collapse" data-parent="#accordionEx" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    <h5 class="mb-0" style="font:bold">fdfdfdfssd sdsdsdsdsdsds <i class="fa fa-angle-down rotate-icon"></i>
                                    </h5>
                                </a>
                            </div>
                          
                            <div id="collapseOne" class="collapse show" role="tabpanel" aria-labelledby="headingOne" data-parent="#accordionEx">
                                <div class="card-body">
                                  sdsssssssssssss dddddddddddddddddddddddddddddddddddddddddddddddddd
                                </div>
                            </div>
                        </div>--%>

                        <!-- Accordion card -->

                      
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

