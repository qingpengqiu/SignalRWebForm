<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Admin_Default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>管理入口-益跑网</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Admin.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<center>

<ERUN360:header_user id="header_user" runat="server" />

<style>
#item { float:left;width:80px;height:20px;padding:20px;text-align:center;cursor:pointer;font-size:14px;color:#000000;border:solid 1px #CCCCFF;border-top:solid 3px #CCCCFF;margin:10px; }
</style>

<div style="width:930px;height:600px;padding:10px;text-align:left;">

	<div style="padding:10px;height:32px;font-size:12px;">
		<a href="/">首页</a> >
		管理入口
	</div>

	<div style="clear:both;font-size:12px;">
		<div id="item" onclick="window.location='/admin/permission.aspx';">用户授权</div>
		<div id="item" onclick="window.location='/admin/prison.aspx';">封锁账户</div>
		<div id="item" onclick="window.location='/admin/memberlist.aspx';">会员</div>
		<!--
		<div id="item" onclick="window.location='/admin/memberfollowlist.aspx';">会员关联</div>
		<div id="item" onclick="window.location='/admin/membersizelist.aspx';">身体</div>
		<div id="item" onclick="window.location='/admin/memberhistorylist.aspx';">积分</div>
		<div id="item" onclick="window.location='/admin/membersummarylist.aspx';">会员摘要</div>
		-->
	</div>

	<div style="clear:both;font-size:12px;">
		<div id="item" onclick="window.location='/admin/bloglist.aspx';">博客</div>
		<div id="item" onclick="window.location='/admin/news.aspx';">首页新闻</div>
		<div id="item" onclick="window.location='/admin/ads.aspx';">首页广告</div>
		<div id="item" onclick="window.location='/admin/Channels_Experts.aspx';">专家右侧</div>
		<div id="item" onclick="window.location='/admin/blogpublishlist.aspx';">博客推荐 </div>
		<div id="item" onclick="window.location='/admin/weibolist.aspx';">微博 </div>
		<div id="item" onclick="window.location='/admin/discusslist.aspx';">评论</div>
        <div id="item" onclick="window.location='/admin/ClubList.aspx';">俱乐部管理</div>
         <div id="item" onclick="window.location='/admin/recomList.aspx';">编辑推荐</div>
        <div id="item" onclick="window.location='/admin/Choice.aspx';">首页益跑精选</div> 
        <div id="item" onclick="window.location='/admin/AdList.aspx';">博客广告</div>
        <div id="item" onclick="window.location='/admin/ShoesList.aspx';">跑鞋</div>
        <div id="item" onclick="window.location='/admin/IntegralList.aspx';">积分充值</div>
        <div id="item" onclick="window.location='/admin/ScoreList.aspx';">积分管理</div>

        <div id="item" onclick="window.location='/admin/GoodList.aspx';">积分物品管理</div>
        <div id="item" onclick="window.location='/admin/ReserveList.aspx';">积分库存管理</div>
        <div id="item" onclick="window.location='/admin/GoodShopList.aspx';">拼团物品管理</div>
        <div id="item" onclick="window.location='/admin/TourList.aspx';">拼团管理</div>
       <div id="item" onclick="window.location='/admin/ReserveTourList.aspx';">拼团库存管理</div>
        <div id="item" onclick="window.location='/admin/ShoppingList.aspx';">商品购买</div>
         <div id="item" onclick="window.location='/admin/CodeList.aspx';">积分兑换</div>
        <div id="item" onclick="window.location='/admin/Plan.aspx';">训练计划</div>
        <div id="item" onclick="window.location='/admin/GoodShopList_zc.aspx';">众筹物品管理</div>
        <div id="item" onclick="window.location='/admin/ReserveTourList_zc.aspx';">众筹库存管理</div>
        <div id="item" onclick="window.location='/admin/TourList_zc.aspx';">众筹管理</div>
         <div id="item" onclick="window.location='/admin/flightlist.aspx';">机票购买记录</div>
        <div id="item" onclick="window.location='/admin/flightgroom.aspx';">机票赛事推荐</div>
        <div id="item" onclick="window.location='/admin/FocusmapList.aspx';">首页焦点图</div>
        <div id="item" onclick="window.location='/admin/Backstage/Advertisementlb.aspx';">广告管理</div>
        <div id="item" onclick="window.location='/admin/Backstage/Advertisemlb.aspx';">广告位管理</div>
        <div id="item" onclick="window.location='/admin/NavList.aspx';">频道管理<img src="/images/new.gif"></div>
        <div id="item" onclick="window.location='/admin/NavClasslist.aspx';">分类管理<img src="/images/new.gif"></div>
        <div id="item" onclick="window.location='/admin/ADFlow.aspx';">广告流<img src="/images/new.gif"></div>
        <div id="item" onclick="window.location='/admin/ADFixed.aspx';">固定广告<img src="/images/new.gif"></div>
        <div id="item" onclick="window.location='/admin/FocusmapHome.aspx';">新版焦点图<img src="/images/new.gif"></div>
        <div id="item" onclick="window.location='/admin/PushManagerOfBlog.aspx';">推送内容管理<img src="/images/new.gif"></div>
        <div id="item" onclick="window.location='/admin//ShoesManager.aspx';">跑鞋关联信息管理<img src="/images/new.gif"></div>
        <%--<div id="item" onclick="window.location='/Admin/international.aspx';">热门赛事</div>--%>
		
		<!--<div id="item" onclick="window.location='/admin/blogsummarylist.aspx';">博客摘要</div>
		<div id="item" onclick="window.location='/admin/bloggrouplist.aspx';">博客分组</div>
		<div id="item" onclick="window.location='/admin/blogpublishlist.aspx';">博客排版</div> 
		<div id="item" onclick="window.location='/admin/bloglinkslist.aspx';">博客关联</div>
		-->
	</div>
	<!--
	<div style="clear:both;font-size:12px;">
		<div id="item" onclick="window.location='/admin/racecompetetionlist.aspx';">竞赛</div>
		<div id="item" onclick="window.location='/admin/raceactivitylist.aspx';">约跑</div>
		<div id="item" onclick="window.location='/admin/racejoinlist.aspx';">参与</div>
		<div id="item" onclick="window.location='/admin/racehistorylist.aspx';">跑步记录</div>
	</div>
	
	<div style="clear:both;font-size:12px;">
		<div id="item" onclick="window.location='/admin/raceclublist.aspx';">俱乐部</div>
		<div id="item" onclick="window.location='/admin/raceclubmemberlist.aspx';">俱乐部成员</div>
	</div>

	<div style="clear:both;font-size:12px;">
		<div id="item" onclick="window.location='/admin/productslist.aspx';">装备</div>
		<div id="item" onclick="window.location='/admin/productssalelist.aspx';">装备销售</div> 
		<div id="item" onclick="window.location='/admin/productsuselist.aspx';">装备使用</div>
	</div>
	-->
	<div style="clear:both;font-size:12px;">
		<!-- 
		<div id="item" onclick="window.location='/admin/attentionlist.aspx';">关注</div>
		<div id="item" onclick="window.location='/admin/imageslist.aspx';">图片</div>
		<div id="item" onclick="window.location='/admin/countslist.aspx';">数据统计</div>
		<div id="item" onclick="window.location='/admin/groupslist.aspx';">分类信息</div>
		-->
	</div>

	<!--
	<div id="item" onclick="window.location='/admin/racelocationlist.aspx';">跑步位置</div>
	<div id="item" onclick="window.location='/admin/racelocationslist.aspx';">跑步位置2</div>
	<div id="item" onclick="window.location='/admin/videoslist.aspx';">视频</div>
	<div id="item" onclick="window.location='/admin/keywordslist.aspx';">Keywords</div>\
	-->

</div>

</center>
</body>
</html>
