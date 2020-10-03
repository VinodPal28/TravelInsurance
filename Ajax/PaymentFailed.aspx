<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaymentFailed.aspx.cs" Inherits="Ajax_PaymentFailed" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Allianz : Travel</title>
    <link rel="apple-touch-icon" href="../Assets/images/ico/fav-icon.png" />
    <link rel="shortcut icon" type="image/x-icon" href="../Assets/images/ico/fav-icon.png" />

    <link href="../Assets/css/bootstrap.min.css" rel="stylesheet" />
    <script src="../Assets/js/jquery.min.js"></script>
    <script src="../Assets/js/bootstrap.min.js"></script>
    <script src="../Scripts/jquery-1.10.2.min.js"></script>


    <script type="text/javascript">
        $(document).ready(function () {
            $('#idgoback').click(function (e) {
                window.location.replace("http://localhost:65161/Admin/BuyPolicy.aspx");
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container" style="margin-left: 25%;margin-top: 5%;">
            <div class="row">
                <div class="col-sm-16">
                    <!-- Add User Section Start -->
                    <div class="card">
                        <div class="card-body">
                            <asp:Label ID="lblmsg" runat="server" ForeColor="Green"></asp:Label>
                            <h5 class="m-0"></h5>

                            <div class="container" id="lblPayFailed" runat="server" style="text-align: center; margin-top: 8%;">


                                <div class="alert alert-danger">

                                    <strong><b>Failed!</b></strong><b> Your payment has been Failed !. Your transaction id: <asp:Label ID="lblorderid" runat="server" ForeColor="Red"></asp:Label>
                                          <a class="dropdown-item" id="idgoback">Go to back</a></b>
                                </div>
                               <%-- <p><b>
                                    <asp:LinkButton ID="idgoback" runat="server" ClientIDMode="Static"><b>Go to back</b></asp:LinkButton>
                                </b></p>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>
</body>
</html>
