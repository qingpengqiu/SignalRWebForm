<%@ Page Language="C#" AutoEventWireup="true" CodeFile="wxpay.aspx.cs" Inherits="Competetion_payment_wxpay" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <a href="<%= parm %>">点击支付(微信浏览器)</a><br>扫描支付</br>
            <img src="/Competetion/payment/QRcode.aspx?parm=<%= parm %>" id="vimg" alt="" />
            <input type="button" value="换一张" onclick="change()" />
        </div>
    </form>
    <script type="text/javascript">      
        function change() {
            var imgNode = document.getElementById("vimg");
            imgNode.src = "/Competetion/payment/QRcode.aspx?t=" + <%= parm %>;
        }
    </script>

</body>
</html>
