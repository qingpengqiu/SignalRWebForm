<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BlogDetail.aspx.cs" Inherits="_Admin_Blog_Detail" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>详细(Blog)-数据维护--ERUN360.COM</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
</head>
<body leftmargin="0" topmargin="0">
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>

<!-- 信息开始 -->
<div id="pageContent">
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" valign="top">编码：</td>
	<td><% =record.id.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">个人分组：</td>
	<td><% =record.idPersonGroup.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">关联信息ID：</td>
	<td><% =record.idHref.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">用户ID：</td>
	<td><% =record.idUser.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">用户名称：</td>
	<td><% =record.cLoginName.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">标题：</td>
	<td><% =record.cTitle.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">内容：</td>
	<td><div style="width:500px;height:140px;overflow:auto;"><% =XString.TruncBreak(record.cContent, 30, 100) %></div></td>
</tr>
<tr>
	<td align="right" valign="top">创建时间：</td>
	<td><% =record.dCreate.ToString() %></td>
</tr>
</table>
</div>

</body>
</html>
<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:40-->

