<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="Test.aspx.cs" Inherits="Admin_Test" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

   <div class="app-content content">
    <div class="content-wrapper">
      <div class="content-header row">
      </div>
      <div class="content-body">        
        <!-- Active Orders -->
        <div class="row">
          <div class="col-12">
            <div class="card">
              <div class="card-header">
                <h4 class="card-title"></h4>
                <!-- <a class="heading-elements-toggle"><i class="la la-ellipsis-v font-medium-3"></i></a>
                <div class="heading-elements">
                  <td>
                    <button class="btn btn-sm round btn-danger btn-glow"><i class="la la-close font-medium-1"></i> Cancel all</button>
                  </td>
                </div> -->
              </div>
              <div class="card-content">
                <div class="table-responsive">
                  <table class="table table-de mb-0">
                   <%-- <thead>
                      <tr>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Role</th>
                        <th>E-mail</th>
                        <th>Password</th>
                        <th>Contact Number</th>
                        <th width="120">Active</th>
                        <th width="120">Deactive</th>
                        <th width="120">Edit</th>
                      </tr>
                    </thead>--%>
                    <tbody>
                      <tr>
                        <td><b>Geo Name</b></td>
                        <td runat="server" id="GeoName"></td>
                     
                      </tr>
                      <tr>
                        <td><b>Day/Age</b></td>
                        <td class="parent"><table><tr> <td class="child" runat="server" id="Age"></td> </tr> </table> </td>
                     
                      </tr>
                     
                     
                    </tbody>
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


    </table>
</asp:Content>

