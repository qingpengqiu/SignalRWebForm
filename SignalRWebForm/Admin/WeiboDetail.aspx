<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeiboDetail.aspx.cs" Inherits="_Admin_Weibo_Detail" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>详细(Weibo)-数据维护-益跑网</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
</head>
<body>
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>

<!-- 信息开始 -->
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" valign="top">编号：</td>
	<td><% =record.id.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">图片：</td>
	<td><% =record.cFaceUrl.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">比赛时间：</td>
	<td><% =record.cUsername.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">赛事网址：</td>
	<td><% =record.cUserUrl.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">赛事名称：</td>
	<td><% =record.cContent.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">创建时间：</td>
	<td><% =record.dCreate.ToString() %></td>
</tr>
</table>

</body>
</html>
<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 10-09 13:39-->

