<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Channels_Woman_Default" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>�������-ERUN360.COM</title>
<meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
<meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
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
			<a href="<% =UrlHelper.TopicsUrl(312111100) %>" class="httitle">��������</a>
			<% =pf.Show(312111100) %>
		</div>
		<div class="ht htr">
			<a href="<% =UrlHelper.TopicsUrl(312112100) %>" class="httitle">ר��װ��</a>
			<% =pf.Show(312112100) %>
		</div>
		<div class="ht">
			<a href="<% =UrlHelper.TopicsUrl(312113100) %>" class="httitle">ר���ۼ�</a>
			<% =pf.Show(312113100) %>
		</div>
		<div class="ht htr">
			<a href="<% =UrlHelper.TopicsUrl(312114100) %>" class="httitle">����</a>
			<% =pf.Show(312114100) %>
		</div>		
	</div>
	<div class="right">
		<div class="rkuang wzph">
			<div class="rkuangtitle">��ע����</div>
			<ul>
			<% =pf.Focus(312100100, 26) %>
			</ul>
		</div>		
	</div>
</div>
<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
