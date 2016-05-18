<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Orderdetail.aspx.cs" Inherits="Flight_Orderdetail" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <script language="javascript" src="/Common/jQuery1.8.js"></script>
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Common/cansai-from.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/race.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jCalendar.js"></script>
    <script language="javascript" src="/Common/jQuery1.8.js"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/flight.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
</head>
<body>
    <script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Common/jPopup.js"></script>
    <script language="javascript" src="/Common/jCalendar.js"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>

    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="flithtpaysucc">
        <div class="article">
            <div class="qrnr" id="div2">
    <div class="hbbox successhbbox">
    <div class="successbox">
       <asp:Literal ID="ltlstatus" runat="server"></asp:Literal>
    </div>
    订单号：<asp:Literal ID="ltlorder" runat="server"></asp:Literal> <br>
    订单日期：<asp:Literal ID="ltltime" runat="server"></asp:Literal> <br>
    总金额：&yen;<i><asp:Literal ID="ltlcost" runat="server"></asp:Literal></i>
        Pnr：<asp:Literal ID="ltlpnr" runat="server"></asp:Literal> <br>
         OldPnr：<asp:Literal ID="ltloldPnr" runat="server"></asp:Literal> <br>
    </div>
    <div class="hbbox">
        <asp:Literal ID="ltlhk" runat="server"></asp:Literal>
      <%--<div class="fddt"><i>2015-04-05</i>北京首都 → 重庆</div>
      <div class="fdxl"><i>国际航空CA4136</i><em>20:00</em>北京首都T3<br><i>73T</i><em>23:00</em>重庆T2<img src="/Html/images/small/CA.gif"></div>--%>
    </div>
    <div class="hbbox">
      <div class="hbtitle">乘客信息</div>
        <asp:Literal ID="ltlck" runat="server"></asp:Literal>
     <%-- <div class="ckinfo"><i>姓名：张广星</i><em>身份证：372922198303066293</em>手机号：13522968082<br></div>--%>
    </div>
    <div class="hbbox">
      <div class="hbtitle">保险信息</div>
        <asp:Literal ID="ltlbx" runat="server"></asp:Literal>
        <%--<div class="bxinfo">被保人：张广星&nbsp;&nbsp;</div>--%>
    </div>
    <div class="hbbox xcdbox">
    <div class="hbtitle"><asp:Literal ID="ltlxcd" runat="server"></asp:Literal>联系人信息</div>
        <asp:Literal ID="ltllxr" runat="server"></asp:Literal>     
      <%--<div class="xcdinfo">姓名：王杰&nbsp;&nbsp;手机号码：18511583497&nbsp;&nbsp;联系地址：地址&nbsp;&nbsp;备注：测试</div>--%>
    </div>
    <div class="hbbox hbboxl">
        <div class="jginfo">提示文字：航空意外理赔请致电：021-95500太平洋保险24小时客服热线；航班延误理赔请致电：4007001951或登录 y.ebao51.cn，一般情况下，理赔无需航空公司出具书面延误证明，太平洋保险将根据民航系统的信息进行理赔，如被保险人对太平洋保险公司的取证信息有异议，则按被保险人提供的航空公司出具的延误证明及其他书面索赔材料处理。另外若被保险人委托他人办理理赔事宜的，必须提供被保险人实名制的银行卡。本保险的理赔由誉好数据公司协助处理。</div>
    </div>
    <div class="returnbox">
        <a class="returnfk dy" href="javascript:void(0)">打印订单</a>
        <a class="returnfk" href="/Flight/Flight_Search.aspx">继续购买</a>
    </div>
  </div>
        </div>
    </div>
    <span id="div1"></span>
    <script type="text/javascript">
        $(".dy").click(function (event) {
            document.body.innerHTML = document.getElementById('div1').innerHTML + '<br/>' + document.getElementById('div2').innerHTML;
            window.print();
        });
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
<%=outhtml%>
