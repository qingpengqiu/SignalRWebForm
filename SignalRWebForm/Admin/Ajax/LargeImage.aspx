<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LargeImage.aspx.cs" Inherits="_Admin_Ajax_LargeImage" %>
<html>
<head>
<title>上传图片-ERUN360.COM</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta name="generator" content="">
<meta name="author" content="">
<meta name="copyright" content="">
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link href="/Common/Frame.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<form id="form1" runat="server"> 
<div style="padding:40px;font-size:14px;">
<br>
这里上传动画切换大图，<font color=red>必须是630x350!</font>
请选择图片文件(*.JPG(JPEG),*.GIF,*.PNG &lt;=4MB)：<br>
<asp:FileUpload ID="FileUpload" size="40" runat="server" /><br>
<span id="submit_info"><asp:Button ID="Button2" runat="server" Text="提交" Width="88px" /></span><br>
<br>
<% =PageResult %>
<% =PageBuffer %>
</div>
</form>
</body>
</html>
