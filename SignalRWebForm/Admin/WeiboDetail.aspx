<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeiboDetail.aspx.cs" Inherits="_Admin_Weibo_Detail" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>��ϸ(Weibo)-����ά��-������</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
</head>
<body>
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>

<!-- ��Ϣ��ʼ -->
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" valign="top">��ţ�</td>
	<td><% =record.id.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">ͼƬ��</td>
	<td><% =record.cFaceUrl.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">����ʱ�䣺</td>
	<td><% =record.cUsername.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">������ַ��</td>
	<td><% =record.cUserUrl.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">�������ƣ�</td>
	<td><% =record.cContent.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top">����ʱ�䣺</td>
	<td><% =record.dCreate.ToString() %></td>
</tr>
</table>

</body>
</html>
<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 10-09 13:39-->

