<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GetOrderInfo_zc.aspx.cs" Inherits="GroupBuy_GetOrderInfo" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>�Ź�-��������������</title>
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
                ����<span>������</span>
                <div class="lc lc2"></div>
            </div>
            <div class="sbox">
                <div class="sboxt" style="border-top:0">
                    ȷ����Ʒ��֧��
                </div>
            	<div class="spshow">
                    <asp:Literal ID="ltlImg" runat="server"></asp:Literal>
                    �����ţ�<asp:Literal ID="ltlidOrder" runat="server"></asp:Literal><br>
					��Ŀ���ƣ�	<asp:Literal ID="ltlTitle" runat="server"></asp:Literal><br>
					��Ʒ������	<asp:Literal ID="ltlNum" runat="server"></asp:Literal> <br>
					��ɫ��<asp:Literal ID="ltlColor" runat="server"></asp:Literal> <br>
					���ֵֿۣ�	<asp:Literal ID="ltlSocre" runat="server"></asp:Literal> ���ֵֿ� <i>&yen;</i><asp:Literal ID="ltlMoney" runat="server"></asp:Literal> <br>
                    
					����Ҫ֧����<em><asp:Literal ID="ltlPrice" runat="server"></asp:Literal></em>Ԫ<em>(����2Сʱ֮����ɸ���)</em><br>
            	</div>
              <div class="sboxt" id="idsboxt" runat="server">
                    �ջ���ַ
                </div>
                <div class="address" id="idaddress" runat="server">
                    <asp:Literal ID="ltlAddress" runat="server"></asp:Literal>
                </div>
                <div class="sboxt">
                    ��ע
                </div>
                <div class="bzbox">
                    <asp:Literal ID="ltlMark" runat="server"></asp:Literal>
                </div>
            </div>
            <div id="payb">
                <asp:Button ID="ToNOPay" runat="server" Text="�����ڳ�" CssClass="topay" OnClick="ToNOPay_Click" Visible="False" />
            	<asp:Button ID="topay" runat="server" Text="֧��������" CssClass="topay" OnClick="topay_Click" Visible="False" />
                <asp:Button ID="waptourpay" runat="server" Text="֧��������" CssClass="topay" OnClick="waptourpay_Click" Visible="False" />
                <a href="/GroupBuy/Cart_zc.aspx?id=<%=idGood %>&from=<%=idorder %>" class="returnbuy">�����޸Ķ���</a>
            </div>
        </article> 
    </div>
    <script>
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    </form>
</body>
</html>
