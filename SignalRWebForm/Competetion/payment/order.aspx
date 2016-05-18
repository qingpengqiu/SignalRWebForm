<%@ Page Language="C#" AutoEventWireup="true" CodeFile="order.aspx.cs" Inherits="Competetion_payment_order" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>订单详情</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="Label4" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label5" runat="server" Text="Label"></asp:Label>
            <br />
            <asp:Label ID="Label3" runat="server" Text="Label"></asp:Label>
            <br />
            <br />
            
            <br />
            <br />
            <br />
            <br />
            

        </div>
        <div class="pc-w-left">
          <asp:LinkButton ID="wxpay" runat="server" OnClick="wxpay_Click">微信支付</asp:LinkButton>
            <span>|</span>
          <asp:LinkButton ID="Alipay" runat="server" OnClick="Alipay_Click">支付宝付款</asp:LinkButton>
        </div>
    </form>
</body>
</html>
