<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BlogDetail.aspx.cs" Inherits="_Admin_Blog_Detail" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>��ϸ(Blog)-����ά��--ERUN360.COM</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
</head>
<body leftmargin="0" topmargin="0">
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>

<!-- ��Ϣ��ʼ -->
<div id="pageContent">
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" valign="top">���룺</td>
	<td><% =record.id.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">���˷��飺</td>
	<td><% =record.idPersonGroup.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">������ϢID��</td>
	<td><% =record.idHref.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">�û�ID��</td>
	<td><% =record.idUser.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">�û����ƣ�</td>
	<td><% =record.cLoginName.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">���⣺</td>
	<td><% =record.cTitle.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">���ݣ�</td>
	<td><div style="width:500px;height:140px;overflow:auto;"><% =XString.TruncBreak(record.cContent, 30, 100) %></div></td>
</tr>
<tr>
	<td align="right" valign="top">����ʱ�䣺</td>
	<td><% =record.dCreate.ToString() %></td>
</tr>
</table>
</div>

</body>
</html>
<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:40-->

