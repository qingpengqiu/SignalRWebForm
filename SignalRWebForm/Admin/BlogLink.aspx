<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BlogLink.aspx.cs" Inherits="_Admin_Blog_Link" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>创建或维护专题-ERUN360.COM</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Admin.css" type="text/css" rel="stylesheet" />
</head>
<body>
<center>

<ERUN360:header_user id="header_user" runat="server" />

<div style="width:930px;height:600px;padding:10px;text-align:left;">

	<div style="padding:10px;height:32px;font-size:12px;">
		<a href="/">首页</a> >
		<a href="/admin/">管理首页</a> > 
		创建或维护专题
	</div>

	<!-- 列表显示 -->
	<div id="pageContent" style="text-align:left;padding:10px;">

	<table width="100%">
	<tr>
		<td style="font-size:12px;color:#666666;" valign="top">
			<br>
			标题：<% =blog.cTitle %><br>
			摘要：<% =XString.Trunc(blog.cContent, 60) %><br>
			<br>
			<% =PageBuffer %>
			<br>
			以下为本专题博文列表:<br>
			<form id="frmLink" name="frmLink" action="BlogLink.aspx" method="post">
			<input type="hidden" id="id" name="id" value="<% =blog.id%>">
			<div id="index_list" style="font-size:12px;color:#666666;border-top:solid 2px #EEEEEE;padding-top:20px;">
			<% =PageResult %><br>
			</div>
			<br>
			<img src="/images/submit.gif" onclick="document.frmLink.submit(); return true;">
			</form>
		</td>
		<td>&nbsp;</td>
		<td rowspan="2" style="width:400px;padding:20px;border-left:dotted 2px #EEEEEE;" valign="top">
				
			<table width="400">
			<tr>
			<td colspan="3">从这里搜索博客,以添加至专题.</td>
			</tr>
			<td width="100" nowrap>
				<select id="fname" name="fname">
					<option value="cloginname">博主</option>
					<option selected value="ctitle">标题</option>
				</select>
				<input type="text" id="str" name="str" value="" size="20">
			</td>
			<td width="60"><img src="/images/search.gif" onclick="SearchIt()"></td>
			<td>&nbsp;</td>
			</tr>
			<tr>
			<td colspan="3" id="result"></td>
			</tr>
			</table>
<script language="javascript">
<!--
/*
function SearchIt()
{
	$.post("/Admin/Ajax/BlogSearch.aspx", { fname: document.getElementById("fname").options[document.getElementById("fname").selectedIndex].value , str : document.getElementById("str").value }, function(result) {
		document.getElementById("result").innerHTML = "<br>" + result;
	});
}
*/
var search_page = 1;
var search_field = "";
var search_word = "";

function SearchIt()
{
	search_field = document.getElementById("fname").options[document.getElementById("fname").selectedIndex].value;
	search_word = document.getElementById("str").value;
	$.post("/Admin/Ajax/BlogSearch.aspx", { page: 1, fname: search_field , str : search_word }, function(result) {
		document.getElementById("result").innerHTML = "<br>" + result;
	});
}

function SearchMore(p)
{
	search_page = p;
	$.post("/Admin/Ajax/BlogSearch.aspx", { page: p, fname: search_field , str : search_word }, function(result) {
		document.getElementById("result").innerHTML = "<br>" + result;
	});
}

//-->
</script>

		</td>
	</tr>
	</table>

	</div>
</div>
<script language="javascript">
<!--

function BlogAdd(idx, iduser, loginname, id, title)
{
	var vstr = document.getElementById("index_list").innerHTML;
	vstr += "<input type=\"checkbox\" id=\"indexlist\" name=\"indexlist\" value=\"" + id + "\" checked> <a href=\"/user/" + iduser + ".aspx\" target=_blank>" + loginname + "</a> : <a href=\"/blog/" + id + ".aspx\" target=_blank>" + title + "</a><br>";
	document.getElementById("index_list").innerHTML = vstr;
	if(idx>0) {
		document.getElementById("tr_num_" + idx).style.display = "none";
	}
}

//-->
</script>

</center>

</body>
</html>
<!--Powered by 北京联高软件开发有限公司 Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:40-->
