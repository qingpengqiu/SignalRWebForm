<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Channels_Shoe_Default" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>鞋与装备-ERUN360.COM</title>
<meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
<meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
<style>
.nav li.h_zb em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}
.zbrk{margin: 12px 0 16px 0}
</style>
<script language="javascript" src="/Common/jQuery.js?2012111"></script>
<script language="javascript" src="/Common/jCheck.js?2012111"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<script language="javascript" src="/Common/jCalendar.js?2012111"></script>
</head>
<body>
<ERUN360:Erun_Header runat="server" ID="Erun_Header" />
<div class="indecen">
	<div class="left">
		<!-- <a href="http://detail.tmall.com/item.htm?spm=a1z10.1.w4004-5303076970.20.Z5WyFp&id=40804352872" target="_blank" style="display:block;margin-top: 20px;width:100%;"><img src="/Images/polar.jpg" style="width:100%"></a> -->
		<div class="ht">
			<a href="<% =UrlHelper.TopicsUrl(303115100) %>" class="httitle">装备评测</a>
			<% =pf.Show(303115100) %>
		</div>
		<div class="ht htr">
			<a href="<% =UrlHelper.TopicsUrl(303111100) %>" class="httitle">鞋</a>
			<% =pf.Show(303111100) %>
		</div>
		<div class="ht ">
			<a href="<% =UrlHelper.TopicsUrl(303116100) %>" class="httitle">服装配件</a>
			<% =pf.Show(303116100) %>
		</div>
		 <!-- <div class="ht htr">
			<a href="<% =UrlHelper.TopicsUrl(303114100) %>" class="httitle">配件</a>
			<% =pf.Show(303114100) %>
		</div>-->	
		<div class="ht htr">
			<a href="<% =UrlHelper.TopicsUrl(303112100) %>" class="httitle">其它</a>
			<% =pf.Show(303112100) %>
		</div>		
	</div>
	<div class="right">
		<div class="rkuang wzph zbrk">
			<div class="rkuangtitle">装备排行</div>
			<ul>
			<% =pf.Focus(303100100, 12) %>
			</ul>
		</div>
		<a target="_blank" href="/GroupBuy/Group.aspx?id=42"><img width="300" height="300" border="0" alt="澳洲 2XU COMPRESSION CALF GUARD 压缩护腿" title="澳洲 2XU COMPRESSION CALF GUARD 压缩护腿" src="/images/2xu.jpg"></a>
	</div>
</div>
<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
