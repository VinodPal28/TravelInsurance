<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Notification.aspx.cs" Inherits="Admin_Notification" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style>
        p{
            margin:0px;
        }
    </style>

    <div class="app-content content">
        <div class="content-wrapper">
            <div class="content-header row">
            </div>
            <asp:Label ID="lblErrorMsg" runat="server" ForeColor="Red" ClientIDMode="Static"></asp:Label>
            <div class="content-body">

                <h1 class="h1Tag">Notifications</h1>
              
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">

                            <table>                              
                                <tr>                                  
                                    <td>
                                       <a class="scrollable-container media-list w-100" id="DivBindNotification" runat="server"></a>
                                      
                                    </td>
                                </tr>
                            </table>
                            <span runat="server" id="SpnNotif" style="color:red"></span>
                          
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

</asp:Content>

