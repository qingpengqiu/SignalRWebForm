<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IOrder.aspx.cs" Inherits="GroupBuy_IOrder" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>积分兑换-益跑网个人中心</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/user-more.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/Group.css" />
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script> 
     <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script src="../Html/js/jquery.blockUI.js"></script>
    <style>
        .main-left ul .user-dq {
            filter: alpha(Opacity=100);
            -moz-opacity: 1;
            opacity: 1;
        }
    </style>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
</head>
<body>
    <form id="form1" runat="server">
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="wrap">
        <article>
            <div class="buylc">
                购买<span>仅三步</span>
                <div class="lc lc4"></div>
            </div>
            <div class="sbox">
            	<div class="spshow">
                    <asp:Literal ID="ltlImg" runat="server"></asp:Literal>
					项目名称：	<asp:Literal ID="ltlTitle" runat="server"></asp:Literal><br>
					商品数量：	<asp:Literal ID="ltlNum" runat="server"></asp:Literal> <br>
					颜色：<asp:Literal ID="ltlColor" runat="server"></asp:Literal> <br>					
                    订单号：<asp:Literal ID="ltlidOrder" runat="server"></asp:Literal><br>
					您需要支付：<em><asp:Literal ID="ltlSorce" runat="server"></asp:Literal><asp:Literal ID="ltlPrice" runat="server"></asp:Literal><asp:Literal ID="ltlTip" runat="server"></asp:Literal><asp:Literal ID="ltlwarn" runat="server"></asp:Literal></em><br>
            	</div>
                <div class="sboxt" id="idsboxt" runat="server">
                    收货地址
                </div>
                <div class="address" id="idaddress" runat="server">
                    <asp:Literal ID="ltlAddress" runat="server"></asp:Literal>
                </div>
                <div class="sboxt">
                    备注
                </div>
                <div class="bzbox">
                    <asp:Literal ID="ltlMark" runat="server"></asp:Literal>
                </div>
            </div>
            <div id="payb">
                <asp:Button ID="ToNOPay" runat="server" Text="立即兑换" CssClass="topay" OnClick="ToNOPay_Click" Visible="False" />
            	<asp:Button ID="topay" runat="server" Text="支付宝付款" CssClass="topay" OnClick="topay_Click" Visible="False" />
                <asp:Button ID="wapsorcepay" runat="server" Text="支付宝付款" CssClass="topay" OnClick="wapsorcepay_Click" Visible="False" />
                <a href="/GroupBuy/ICart.aspx?id=<%=idGood %>&from=<%=idorder %>" class="returnbuy">返回修改订单</a>
            </div>
        </article> 
    </div>
    <script>
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    </form>
</body>
</html>
