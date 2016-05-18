<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Upload.aspx.cs" Inherits="_Member_Include_Upload" %>
<html>
<head>
<title>上传头像-ERUN360.COM</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta name="generator" content="yipao editor">
<meta name="author" content="">
<meta name="copyright" content="">
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link href="/Common/Frame.css" rel="stylesheet" type="text/css"/>
</head>
<body style="background-color:#F8F8F8;">
<form id="form1" runat="server"> 

<table width="100%" style="padding:8px;line-height:24px;text-align:left;" cellpadding="0" cellspacing="0"> 
<tr> 
	<td align="right"></td> 
	<td>
		<% =PageEcho %>
	</td> 
</tr> 
<tr> 
	<td align="right"></td> 
	<td>
		请选择头像图片文件(*.JPG(JPEG),*.GIF,*.PNG &lt;=4MB)：<br>
		<asp:FileUpload ID="FileUpload" size="50" runat="server" />
	</td> 
</tr> 
<tr> 
	<td align="right"></td> 
	<td id="submit_info"><asp:Button ID="Button2" runat="server" Text="提交" Width="88px" /></td> 
</tr> 
<tr> 
	<td align="right"></td> 
	<td>
		<% =PageResult %>
		<% =PageBuffer %>
	</td> 
</tr> 
</table> 
</form>
</body>
</html>
