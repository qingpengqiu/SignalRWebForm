<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>�ղر�վ-ERUN360.COM</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta name="distribution" content="global" />
<link href="/Common/Style.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<center>

<ERUN360:header id="header" runat="server" />

<div id="page_nav">
	<a href="/">��ҳ</a> >
	<a href="/channels/about/">��������</a> >
	�ղر�վ
</div>

<div style="width:950px;height:345px;padding-top:20px;padding-bottom:20px;">

<script language="javascript">

//var $ = function (id) { return "string" == typeof id ? document.getElementById(id) : id; };
String.prototype.replaceAll = function(s1,s2) { return this.replace(new RegExp(s1,"gm"),s2);  }

function getElements(ctrl, attr, name) 
{ 
	var returns = document.getElementsByName(name); 
	if(returns.length > 0) return returns; 
	returns = new Array(); 
	var e = document.getElementsByTagName(ctrl); 
	for(i = 0; i < e.length; i++) { 
		if(e[i].getAttribute(attr) == name) { 
			returns[returns.length] = e[i]; 
		} 
	} 
	return returns; 
}

function getElementsByName(ctrl, name) 
{ 
	return getElements(ctrl, "name", name); 
}

var d_title = "������";
var d_href = "http://www.erun360.com";

function showFavorite()
{
	var rsl = "";
	rsl += "<style>#favAction td { padding:10px;background-color:#F0F0F0;} #favActions { text-decoration: underline;cursor:pointer; } </style>";
	rsl += "<table id=\"favAction\" width=\"100%\" cellpadding=0 cellspacing=0 border=1 bordercolor=\"#E0E0E0\" style=\"border-collapse:collapse;padding:10px;background-color:#F0F0F0;\">";
	rsl += "<tr><td colspan=5 style=\"text-align:left;\">��վ��" + d_title + "<br>��ַ��" + d_href + "</td></tr>";
	rsl += "<tr>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"local\">�ղؼ�</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://v.t.sina.com.cn/share/share.php?title={TITLE} {URL}&source=bookmark\">����΢��</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={URL}\">QQ�ռ�</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://shuqian.qq.com/post?title={TITLE}&uri={URL}\">QQ��ǩ</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://cang.baidu.com/do/add?it={TITLE}&iu={URL}&dc=&fr=ien#nw=1\">�ٶ��Ѳ�</td>";
	rsl += "</tr><tr>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://vivi.sina.com.cn/collect/icollect.php?pid=28&title={TITLE}&url={URL}\">����vivi</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://myweb.cn.yahoo.com/popadd.html?title={TITLE}&url={URL}&tag=&summary=\">Yahoo��ǩ</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.douban.com/recommend/?url={URL}&title={TITLE}&v=1\" >����</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.kaixin001.com/repaste/share.php?rtitle={TITLE}&rurl={URL}&rcontent=\">������</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.xianguo.com/service/submitfav/?link={URL}&title={TITLE}\">�ʹ�</td>";
	rsl += "</tr><tr>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://share.renren.com/share/buttonshare.do?link={URL}&title={TITLE}\">����</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.diguff.com/diguShare/bookMark_FF.jsp?&title={TITLE}&url={URL}\">�ֹ�</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://zuosa.com/collect/Collect.aspx?u={URL}&t={TITLE}&s=bjnahan.net\">��ɶ</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://jiwai.de/wo/share/s?u={URL}&t={TITLE}\">ߴ��</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://fanfou.com/sharer?u={URL}&t={TITLE}\" >����</td>";
	rsl += "</tr><tr>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://leshou.com/post?act=shou&reuser=&title={TITLE}&url={URL}&intro=&tags=&tool=1\">����</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://my.poco.cn/fav/storeIt.php?t={TITLE}&u={URL}\" >POCO��ժ</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.shouker.com/mc/col/post2.aspx?title={TITLE}&surl={URL}\">�տ�</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.365key.com/storeit.aspx?t={URL}&h={TITLE}\">365key��ժ</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.google.com/bookmarks/mark?op=edit&bkmk={URL}&title={TITLE}\">Google��ǩ</td>";
	rsl += "</tr>";
	rsl += "<tr><td colspan=5 style=\"text-align:left;\">�ղط������Լ����ʾ�����վ��<br>���ݵ��ղط�ʽ�ǰ�Ctrl+D����<br>���������ĺ��ѹ�ͬӵ�о��ʶ��м�ֵ����վ��</td></tr>";
	rsl += "</table>";
	return rsl;
}

function initFavorite()
{
	var objs = getElementsByName("div", "favActions");
	for(var i=0; i<objs.length; i++) {
		objs[i].onclick = actionFavorite;
	}
}

function addFavorite(sURL, sTitle)
{
	try
	{
		window.external.addFavorite(sURL, sTitle);
	}
	catch (e)
	{
		try
		{
			window.sidebar.addPanel(sTitle, sURL, "");
		}
		catch (e)
		{
			alert("�����ղ�ʧ�ܣ���ʹ��Ctrl+D�������");
		}
	}
}

function actionFavorite()
{
	/*
	var url = this.getAttribute("tips");
	if(url=="local") { addFavorite(location.href, document.title); return; }
	url = url.replaceAll("{TITLE}",encodeURI(document.title));
	url = url.replaceAll("{URL}",encodeURI(location.href));
	*/
	var url = this.getAttribute("tips");
	if(url=="local") { addFavorite(d_href, d_title); return; }
	url = url.replaceAll("{TITLE}",encodeURI(d_title));
	url = url.replaceAll("{URL}",encodeURI(d_href));
	window.open(url,'_blank','width=640,height=500');
	return;
}

document.write(showFavorite());
initFavorite();

</script>

</div>

<ERUN360:footer id="footer" runat="server" />

</center>
</body>
</html>
