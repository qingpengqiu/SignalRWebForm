<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>网站导航-ERUN360.COM</title>
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
	网站导航
</div>

<div style="width:950px;height:355px;padding-top:20px;padding-bottom:20px;text-align:left;">

	益跑网,开启精彩跑步人生.<br>
	<br>

	<style>
	#guide_table td { padding:5px; }
	#guide_table td a { font-size:14px;color:#4C98CC;padding:3px;text-decoration: none;border:solid 1px #FFFFFF; }
	#guide_table td a:hover { font-size:14px;color:#4C98CC;padding:3px;text-decoration: none;border:solid 1px #FF6701; }
	</style>
	<table id="guide_table" width="100%" height="330" border="1" bordercolor="#E0E0E0" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
	<tr style="background-color:#F0F0F0;">
		<td>
			信息类别
		</td>
		<td>
			创建类
		</td>
		<td>
			查询类
		</td>
		<td>
			关注类
		</td>
	</tr>
	<tr>
		<td>
			我的信息
		</td>
		<td>
			<a href="/Member/">注册</a> 
			<a href="/Member/Login.aspx">登录</a> 
			<a href="/Member/Personal.aspx">完善个人信息</a> 
			<a href="/Member/Bodysize.aspx">身体信息</a> 
			<a href="/Member/Photo.aspx">上传头像</a> 
		</td>
		<td>
			<a href="/Member/Query.aspx">密码查询</a>
		</td>
		<td>
		</td>
	</tr>
	<tr>
		<td>
			博主
		</td>
		<td>
		</td>
		<td>
			<a href="/utility/MyFans.aspx">我的粉丝</a> 
		</td>
		<td>
			<a href="/utility/MyFocus.aspx">我关注的博主</a>
		</td>
	</tr>
	<tr>
		<td>
			博客
		</td>
		<td>
			<a href="/utility/write.aspx">发表文章</a> 
		</td>
		<td>
			<a href="/utility/member.aspx">我的文章</a> 
		</td>
		<td>
			<a href="/utility/myAttentions.aspx">我关注的文章</a>
		</td>
	</tr>
	<tr>
		<td>
			赛事
		</td>
		<td>
			 
		</td>
		<td>
		</td>
		<td>
			<a href="/utility/MyCompetetions.aspx">我关注的赛事</a>
		</td>
	</tr>
	<tr>
		<td>
			约跑
		</td>
		<td>
			<a href="/utility/write.aspx">发起约跑</a> 
		</td>
		<td>
			<!--<a href="#">我发起的约跑</a>-->
		</td>
		<td>
			<a href="/utility/MyRaces.aspx">我关注的约跑</a>
		</td>
	</tr>
	<!--
	<tr>
		<td>
			俱乐部
		</td>
		<td>
			<a href="/utility/write.aspx">创建俱乐部</a> 
		</td>
		<td>
			<a href="#">我创建的俱乐部</a>
		</td>
		<td>
			<a href="/utility/MyClubs.aspx">我关注的俱乐部</a>
		</td>
	</tr>
	-->
	<tr>
		<td>
			装备
		</td>
		<td>
			 
		</td>
		<td>
		</td>
		<td>
			<a href="/utility/MyEquipments.aspx">我关注的俱乐部</a>
		</td>
	</tr>
	<tr style="background-color:#F0F0F0;">
		<td>
			信息类别
		</td>
		<td>
			创建类
		</td>
		<td>
			查询类
		</td>
		<td>
			关注类
		</td>
	</tr>
	</table>

</div>

<ERUN360:footer id="footer" runat="server" />

</center>
</body>
</html>
