<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>收藏本站-ERUN360.COM</title>
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
	<a href="/">首页</a> >
	<a href="/channels/about/">关于益跑</a> >
	收藏本站
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

var d_title = "益跑网";
var d_href = "http://www.erun360.com";

function showFavorite()
{
	var rsl = "";
	rsl += "<style>#favAction td { padding:10px;background-color:#F0F0F0;} #favActions { text-decoration: underline;cursor:pointer; } </style>";
	rsl += "<table id=\"favAction\" width=\"100%\" cellpadding=0 cellspacing=0 border=1 bordercolor=\"#E0E0E0\" style=\"border-collapse:collapse;padding:10px;background-color:#F0F0F0;\">";
	rsl += "<tr><td colspan=5 style=\"text-align:left;\">网站：" + d_title + "<br>网址：" + d_href + "</td></tr>";
	rsl += "<tr>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"local\">收藏夹</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://v.t.sina.com.cn/share/share.php?title={TITLE} {URL}&source=bookmark\">新浪微博</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url={URL}\">QQ空间</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://shuqian.qq.com/post?title={TITLE}&uri={URL}\">QQ书签</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://cang.baidu.com/do/add?it={TITLE}&iu={URL}&dc=&fr=ien#nw=1\">百度搜藏</td>";
	rsl += "</tr><tr>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://vivi.sina.com.cn/collect/icollect.php?pid=28&title={TITLE}&url={URL}\">新浪vivi</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://myweb.cn.yahoo.com/popadd.html?title={TITLE}&url={URL}&tag=&summary=\">Yahoo书签</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.douban.com/recommend/?url={URL}&title={TITLE}&v=1\" >豆瓣</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.kaixin001.com/repaste/share.php?rtitle={TITLE}&rurl={URL}&rcontent=\">开心网</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.xianguo.com/service/submitfav/?link={URL}&title={TITLE}\">鲜果</td>";
	rsl += "</tr><tr>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://share.renren.com/share/buttonshare.do?link={URL}&title={TITLE}\">人人</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.diguff.com/diguShare/bookMark_FF.jsp?&title={TITLE}&url={URL}\">嘀咕</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://zuosa.com/collect/Collect.aspx?u={URL}&t={TITLE}&s=bjnahan.net\">做啥</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://jiwai.de/wo/share/s?u={URL}&t={TITLE}\">叽歪</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://fanfou.com/sharer?u={URL}&t={TITLE}\" >饭否</td>";
	rsl += "</tr><tr>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://leshou.com/post?act=shou&reuser=&title={TITLE}&url={URL}&intro=&tags=&tool=1\">乐收</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://my.poco.cn/fav/storeIt.php?t={TITLE}&u={URL}\" >POCO网摘</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.shouker.com/mc/col/post2.aspx?title={TITLE}&surl={URL}\">收客</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.365key.com/storeit.aspx?t={URL}&h={TITLE}\">365key网摘</td>";
	rsl += "<td id=\"favActions\" name=\"favActions\" tips=\"http://www.google.com/bookmarks/mark?op=edit&bkmk={URL}&title={TITLE}\">Google书签</td>";
	rsl += "</tr>";
	rsl += "<tr><td colspan=5 style=\"text-align:left;\">收藏方便您自己访问精彩网站！<br>最快捷的收藏方式是按Ctrl+D键！<br>分享方便您的好友共同拥有精彩而有价值的网站！</td></tr>";
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
			alert("加入收藏失败，请使用Ctrl+D进行添加");
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
