<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Channels_Woman_Default" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>红粉跑者-ERUN360.COM</title>
<meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
<meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
<style>
.nav li.h_hf{background:url(/Images/index/navhbj.png) repeat-x; }
.nav li.h_hf a{background:url(/Images/index/adqbj.png) no-repeat center 49px; }
</style>
</head>
<body>
<script language="javascript" src="/Common/jQuery.js?2012111"></script>
<script language="javascript" src="/Common/jCheck.js?2012111"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<script language="javascript" src="/Common/jCalendar.js?2012111"></script>	
<ERUN360:Erun_Header runat="server" ID="Erun_Header" />
<div class="indecen">
	<div class="left">
		<div class="ht">
			<a href="<% =UrlHelper.TopicsUrl(312111100) %>" class="httitle">闪闪粉星</a>
			<% =pf.Show(312111100) %>
		</div>
		<div class="ht htr">
			<a href="<% =UrlHelper.TopicsUrl(312112100) %>" class="httitle">专属装备</a>
			<% =pf.Show(312112100) %>
		</div>
		<div class="ht">
			<a href="<% =UrlHelper.TopicsUrl(312113100) %>" class="httitle">专属蜜籍</a>
			<% =pf.Show(312113100) %>
		</div>
		<div class="ht htr">
			<a href="<% =UrlHelper.TopicsUrl(312114100) %>" class="httitle">其它</a>
			<% =pf.Show(312114100) %>
		</div>		
	</div>
	<div class="right">
		<div class="rkuang wzph">
			<div class="rkuangtitle">关注排行</div>
			<ul>
			<% =pf.Focus(312100100, 26) %>
			</ul>
		</div>		
	</div>
</div>
<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
