<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GetOrderInfo_zc.aspx.cs" Inherits="GroupBuy_GetOrderInfo" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>团购-益跑网个人中心</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="/Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/user-more.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/Group.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/groupmedia.css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script> 
     <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script src="/Html/js/jquery.blockUI.js"></script>
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
                <div class="lc lc2"></div>
            </div>
            <div class="sbox">
                <div class="sboxt" style="border-top:0">
                    确认商品及支付
                </div>
            	<div class="spshow">
                    <asp:Literal ID="ltlImg" runat="server"></asp:Literal>
                    订单号：<asp:Literal ID="ltlidOrder" runat="server"></asp:Literal><br>
					项目名称：	<asp:Literal ID="ltlTitle" runat="server"></asp:Literal><br>
					商品数量：	<asp:Literal ID="ltlNum" runat="server"></asp:Literal> <br>
					颜色：<asp:Literal ID="ltlColor" runat="server"></asp:Literal> <br>
					积分抵扣：	<asp:Literal ID="ltlSocre" runat="server"></asp:Literal> 积分抵扣 <i>&yen;</i><asp:Literal ID="ltlMoney" runat="server"></asp:Literal> <br>
                    
					您需要支付：<em><asp:Literal ID="ltlPrice" runat="server"></asp:Literal></em>元<em>(请于2小时之内完成付款)</em><br>
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
                <asp:Button ID="ToNOPay" runat="server" Text="立即众筹" CssClass="topay" OnClick="ToNOPay_Click" Visible="False" />
            	<asp:Button ID="topay" runat="server" Text="支付宝付款" CssClass="topay" OnClick="topay_Click" Visible="False" />
                <asp:Button ID="waptourpay" runat="server" Text="支付宝付款" CssClass="topay" OnClick="waptourpay_Click" Visible="False" />
                <a href="/GroupBuy/Cart_zc.aspx?id=<%=idGood %>&from=<%=idorder %>" class="returnbuy">返回修改订单</a>
            </div>
        </article> 
    </div>
    <script>
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    </form>
</body>
</html>
