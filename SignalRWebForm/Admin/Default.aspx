<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Admin_Default" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>�������-������</title>
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
		<a href="/">��ҳ</a> >
		�������
	</div>

	<div style="clear:both;font-size:12px;">
		<div id="item" onclick="window.location='/admin/permission.aspx';">�û���Ȩ</div>
		<div id="item" onclick="window.location='/admin/prison.aspx';">�����˻�</div>
		<div id="item" onclick="window.location='/admin/memberlist.aspx';">��Ա</div>
		<!--
		<div id="item" onclick="window.location='/admin/memberfollowlist.aspx';">��Ա����</div>
		<div id="item" onclick="window.location='/admin/membersizelist.aspx';">����</div>
		<div id="item" onclick="window.location='/admin/memberhistorylist.aspx';">����</div>
		<div id="item" onclick="window.location='/admin/membersummarylist.aspx';">��ԱժҪ</div>
		-->
	</div>

	<div style="clear:both;font-size:12px;">
		<div id="item" onclick="window.location='/admin/bloglist.aspx';">����</div>
		<div id="item" onclick="window.location='/admin/news.aspx';">��ҳ����</div>
		<div id="item" onclick="window.location='/admin/ads.aspx';">��ҳ���</div>
		<div id="item" onclick="window.location='/admin/Channels_Experts.aspx';">ר���Ҳ�</div>
		<div id="item" onclick="window.location='/admin/blogpublishlist.aspx';">�����Ƽ� </div>
		<div id="item" onclick="window.location='/admin/weibolist.aspx';">΢�� </div>
		<div id="item" onclick="window.location='/admin/discusslist.aspx';">����</div>
        <div id="item" onclick="window.location='/admin/ClubList.aspx';">���ֲ�����</div>
         <div id="item" onclick="window.location='/admin/recomList.aspx';">�༭�Ƽ�</div>
        <div id="item" onclick="window.location='/admin/Choice.aspx';">��ҳ���ܾ�ѡ</div> 
        <div id="item" onclick="window.location='/admin/AdList.aspx';">���͹��</div>
        <div id="item" onclick="window.location='/admin/ShoesList.aspx';">��Ь</div>
        <div id="item" onclick="window.location='/admin/IntegralList.aspx';">���ֳ�ֵ</div>
        <div id="item" onclick="window.location='/admin/ScoreList.aspx';">���ֹ���</div>

        <div id="item" onclick="window.location='/admin/GoodList.aspx';">������Ʒ����</div>
        <div id="item" onclick="window.location='/admin/ReserveList.aspx';">���ֿ�����</div>
        <div id="item" onclick="window.location='/admin/GoodShopList.aspx';">ƴ����Ʒ����</div>
        <div id="item" onclick="window.location='/admin/TourList.aspx';">ƴ�Ź���</div>
       <div id="item" onclick="window.location='/admin/ReserveTourList.aspx';">ƴ�ſ�����</div>
        <div id="item" onclick="window.location='/admin/ShoppingList.aspx';">��Ʒ����</div>
         <div id="item" onclick="window.location='/admin/CodeList.aspx';">���ֶһ�</div>
        <div id="item" onclick="window.location='/admin/Plan.aspx';">ѵ���ƻ�</div>
        <div id="item" onclick="window.location='/admin/GoodShopList_zc.aspx';">�ڳ���Ʒ����</div>
        <div id="item" onclick="window.location='/admin/ReserveTourList_zc.aspx';">�ڳ������</div>
        <div id="item" onclick="window.location='/admin/TourList_zc.aspx';">�ڳ����</div>
         <div id="item" onclick="window.location='/admin/flightlist.aspx';">��Ʊ�����¼</div>
        <div id="item" onclick="window.location='/admin/flightgroom.aspx';">��Ʊ�����Ƽ�</div>
        <div id="item" onclick="window.location='/admin/FocusmapList.aspx';">��ҳ����ͼ</div>
        <div id="item" onclick="window.location='/admin/Backstage/Advertisementlb.aspx';">������</div>
        <div id="item" onclick="window.location='/admin/Backstage/Advertisemlb.aspx';">���λ����</div>
        <div id="item" onclick="window.location='/admin/NavList.aspx';">Ƶ������<img src="/images/new.gif"></div>
        <div id="item" onclick="window.location='/admin/NavClasslist.aspx';">�������<img src="/images/new.gif"></div>
        <div id="item" onclick="window.location='/admin/ADFlow.aspx';">�����<img src="/images/new.gif"></div>
        <div id="item" onclick="window.location='/admin/ADFixed.aspx';">�̶����<img src="/images/new.gif"></div>
        <div id="item" onclick="window.location='/admin/FocusmapHome.aspx';">�°潹��ͼ<img src="/images/new.gif"></div>
        <div id="item" onclick="window.location='/admin/PushManagerOfBlog.aspx';">�������ݹ���<img src="/images/new.gif"></div>
        <div id="item" onclick="window.location='/admin//ShoesManager.aspx';">��Ь������Ϣ����<img src="/images/new.gif"></div>
        <%--<div id="item" onclick="window.location='/Admin/international.aspx';">��������</div>--%>
		
		<!--<div id="item" onclick="window.location='/admin/blogsummarylist.aspx';">����ժҪ</div>
		<div id="item" onclick="window.location='/admin/bloggrouplist.aspx';">���ͷ���</div>
		<div id="item" onclick="window.location='/admin/blogpublishlist.aspx';">�����Ű�</div> 
		<div id="item" onclick="window.location='/admin/bloglinkslist.aspx';">���͹���</div>
		-->
	</div>
	<!--
	<div style="clear:both;font-size:12px;">
		<div id="item" onclick="window.location='/admin/racecompetetionlist.aspx';">����</div>
		<div id="item" onclick="window.location='/admin/raceactivitylist.aspx';">Լ��</div>
		<div id="item" onclick="window.location='/admin/racejoinlist.aspx';">����</div>
		<div id="item" onclick="window.location='/admin/racehistorylist.aspx';">�ܲ���¼</div>
	</div>
	
	<div style="clear:both;font-size:12px;">
		<div id="item" onclick="window.location='/admin/raceclublist.aspx';">���ֲ�</div>
		<div id="item" onclick="window.location='/admin/raceclubmemberlist.aspx';">���ֲ���Ա</div>
	</div>

	<div style="clear:both;font-size:12px;">
		<div id="item" onclick="window.location='/admin/productslist.aspx';">װ��</div>
		<div id="item" onclick="window.location='/admin/productssalelist.aspx';">װ������</div> 
		<div id="item" onclick="window.location='/admin/productsuselist.aspx';">װ��ʹ��</div>
	</div>
	-->
	<div style="clear:both;font-size:12px;">
		<!-- 
		<div id="item" onclick="window.location='/admin/attentionlist.aspx';">��ע</div>
		<div id="item" onclick="window.location='/admin/imageslist.aspx';">ͼƬ</div>
		<div id="item" onclick="window.location='/admin/countslist.aspx';">����ͳ��</div>
		<div id="item" onclick="window.location='/admin/groupslist.aspx';">������Ϣ</div>
		-->
	</div>

	<!--
	<div id="item" onclick="window.location='/admin/racelocationlist.aspx';">�ܲ�λ��</div>
	<div id="item" onclick="window.location='/admin/racelocationslist.aspx';">�ܲ�λ��2</div>
	<div id="item" onclick="window.location='/admin/videoslist.aspx';">��Ƶ</div>
	<div id="item" onclick="window.location='/admin/keywordslist.aspx';">Keywords</div>\
	-->

</div>

</center>
</body>
</html>
