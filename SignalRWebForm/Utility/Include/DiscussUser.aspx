<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DiscussUser.aspx.cs" Inherits="_Utility_Include_DiscussUser" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>留言</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
<link href="/Common/Admin.css" type="text/css" rel="stylesheet" />
</head>
<body>

给TA留言：<br>
<form id="form1" name="form1" action="/utility/include/DiscussUser.aspx" method="post">
<input type="hidden" id="idBlog" name="idBlog" value="<% =id %>">
<textarea id="cContent" name="cContent" cols="70" rows="3" style="font-size:14px;padding:5px;"></textarea><br>
<img src="/images/submit.gif" onclick="document.form1.submit();return true;"> <% =PageResult %>
</form>

</body>
</html>
<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:40-->

