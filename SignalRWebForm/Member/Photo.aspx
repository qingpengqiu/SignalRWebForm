<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Photo.aspx.cs" Inherits="_Member_Photo" %>
<html>
<head>
<title>上传头像-ERUN360.COM</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link href="/Common/Member.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<center>

<ERUN360:header_user id="header_user" runat="server" />

<div style="width:950px;height:533px;background-image:url(/images/user-back2.gif);">

	<div id="page_nav" style="padding-left:30px;padding-top:20px;">
		<a href="/">首页</a> >
		<a href="/Member/">会员中心</a> > 
		上传头像
	</div>

	<div id="pageContent" style="float:left;width:608px;padding-left:30px;">
		<br>
		<br>
		<iframe src="<% =HostInfo.imgName %>/member/include/upload.aspx" border="0" width="600" height="400" frameborder="no" scrolling="no"></iframe>

	</div>
</div>

<script language="javascript">

</script>

<ERUN360:footer_user id="footer_user" runat="server" />

</center>
</body>
</html>
