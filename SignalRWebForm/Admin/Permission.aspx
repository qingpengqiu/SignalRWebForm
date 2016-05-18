<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Permission.aspx.cs" Inherits="_Admin_Permission" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>授予用户权限-数据维护-ERUN360.COM</title>
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
		授予用户权限
	</div>

<!-- 信息开始 -->
<form id="form1" name="form1" action="Permission.aspx" method="post" autocomplete="off">
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" valign="top"></td>
	<td>
		<br>
		由超级管理员授予指定用户为“信息管理员”<br>
		<br>
	</td>
</tr>
<tr>
	<td align="right" valign="top">用户ID：</td>
	<td>
		<input type="text" id="idUser" name="idUser" size="16" maxlength="32"  onblur="if(NullCheck(this)) if(StringCheck(this)) LengthCheck(this,2,32);" value="" >
		<span id="check_idUser" class="check_echo"></span>
	</td>
</tr>
<tr>
	<td align="right" valign="top">用户登录名：</td>
	<td>
		<input type="text" id="cLoginName" name="cLoginName" size="16" maxlength="32"  onblur="if(NullCheck(this)) if(StringCheck(this)) LengthCheck(this,2,32);" value="" >
		<span id="check_cLoginName" class="check_echo"></span>
	</td>
</tr>
<tr>
	<td align="right" valign="top">授予角色：</td>
	<td>
		<% =GCommon.Controls("用户角色", "select", "idAdminStyle", "") %> 注意：信息管理员才能发布博客到指定栏目。
	</td>
</tr>
<tr>
	<td align="right" valign="top"></td>
	<td>
		<input type="hidden" id="UpdatedFields" name="UpdatedFields" value="">
		<div style="float:left;width:100px;height:32px;">
			<img src="/Images/submit.gif" onclick="Finish()">
		</div>
		<div id="total_echo" style="float:left;width:300px;height:22px;padding-top:10px;" class="check_echo">
			<% =PageResult %>
		</div>
	</td>
</tr>
</table>
</form>

<br>
<% =PageBuffer %>
<br>
<% =PageNavigator %>

</div>
<script language="javascript">

function Finish()
{
	var check_num = 2;
	var obj = $("#idUser")[0];
	if(NullCheck(obj)) if(StringCheck(obj)) if(LengthCheck(obj,2,32)) { check_num--; }
	var obj = $("#cLoginName")[0];
	if(NullCheck(obj)) if(StringCheck(obj)) if(LengthCheck(obj,2,32)) { check_num--; }
	if(check_num == 0)
	{
		document.form1.submit();
		return true;
	}
	else
	{
		$("#total_echo").html("不行啊！提交数据还有错误哦！");
	}
	return false;
}
</script>

</center>

</body>
</html>
<!--Powered by 北京联高软件开发有限公司 Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:39-->

