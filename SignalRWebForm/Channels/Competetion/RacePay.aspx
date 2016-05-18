<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RacePay.aspx.cs" Inherits="Channels_Competetion_RacePay" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <script type="text/javascript" src="/Common/jQuery1.8.js"></script>
    <link href="favicon.ico" rel="shortcut icon" type="image/ico"/>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Common/cansai-from.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/race.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jQuery1.8.js"></script>
    <script type="text/javascript" src="/Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form id="form1" runat="server">
        <div class="indecen">
            <div class="racebody racetimew">
            <h1><asp:Label ID="LabelTitle2" runat="server" Text="参赛项目"></asp:Label></h1>
            <div class="payrace">
                <div class="payracetr">
                    <div class="payracetd">
                        <em>参赛项目</em>
                    </div>
                    <div class="payracetd">
                        <asp:Label ID="LabelTitle" runat="server" Text="参赛项目"></asp:Label>
                    </div>
                </div>
                <div class="payracetr">
                    <div class="payracetd">
                        <em>订购内容</em>
                    </div>
                    <div class="payracetd">
                        <asp:Label ID="Labeltype" runat="server" Text="订购内容"></asp:Label>
                    </div>
                </div>
                <div class="payracetr">
                    <div class="payracetd">
                        <em>总金额</em>
                    </div>
                    <div class="payracetd payrmb">
                        人民币:￥<asp:Label ID="Labelcost" runat="server" Text="总金额"></asp:Label>元
                    </div>
                </div>
                <div class="payracetr">
                    <div class="payracetd">
                        <em>在线支付</em>
                    </div>
                    <div class="payracetd paynum">
                        <%if (idAlipay != "")
                          {%><span>已完成支付</span>
                        <% } %>
                        <%else
                          {%><asp:Button ID="Buttonpay" Text="使用支付宝在线支付" runat="server" value="Button" OnClick="Button1_Click" Enabled="False" /><asp:Button ID="BtnAlipay" name="BtnAlipay" Text="立即支付" 
                                runat="server" OnClick="BtnAlipay_Click" Enabled="False" /><% } %>
                        订单号: <%=Request["orderid"].Trim()%> (请于2小时之内完成付款)
                    </div>
                </div>
            </div>
               <%-- <asp:Literal ID="ltlgoteam" runat="server"></asp:Literal>--%>
        </div>
        </div>
    </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
