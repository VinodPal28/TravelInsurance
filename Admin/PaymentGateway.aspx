<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PaymentGateway.aspx.cs" Inherits="Ajax_PaymentGateway" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
              <asp:Label ID="lblErrorshowMessage" runat="server" ForeColor="Red" ></asp:Label>
            <asp:Label ID="lblprice" runat="server"></asp:Label>
            <asp:HiddenField ID="hash" runat="server" />
            <asp:HiddenField ID="txnid" runat="server" />
            <asp:HiddenField ID="sts" runat="server" />
            <input type="hidden" id="key" runat="server" />
            <input type="hidden" id="service_provider" runat="server" name="service_provider" value="payu_paisa" />
        </div>
    </form>
</body>
</html>
