<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Channels_Shoe_Default" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>Ь��װ��-ERUN360.COM</title>
<meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
<meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
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
			<a href="<% =UrlHelper.TopicsUrl(303115100) %>" class="httitle">װ������</a>
			<% =pf.Show(303115100) %>
		</div>
		<div class="ht htr">
			<a href="<% =UrlHelper.TopicsUrl(303111100) %>" class="httitle">Ь</a>
			<% =pf.Show(303111100) %>
		</div>
		<div class="ht ">
			<a href="<% =UrlHelper.TopicsUrl(303116100) %>" class="httitle">��װ���</a>
			<% =pf.Show(303116100) %>
		</div>
		 <!-- <div class="ht htr">
			<a href="<% =UrlHelper.TopicsUrl(303114100) %>" class="httitle">���</a>
			<% =pf.Show(303114100) %>
		</div>-->	
		<div class="ht htr">
			<a href="<% =UrlHelper.TopicsUrl(303112100) %>" class="httitle">����</a>
			<% =pf.Show(303112100) %>
		</div>		
	</div>
	<div class="right">
		<div class="rkuang wzph zbrk">
			<div class="rkuangtitle">װ������</div>
			<ul>
			<% =pf.Focus(303100100, 12) %>
			</ul>
		</div>
		<a target="_blank" href="/GroupBuy/Group.aspx?id=42"><img width="300" height="300" border="0" alt="���� 2XU COMPRESSION CALF GUARD ѹ������" title="���� 2XU COMPRESSION CALF GUARD ѹ������" src="/images/2xu.jpg"></a>
	</div>
</div>
<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
