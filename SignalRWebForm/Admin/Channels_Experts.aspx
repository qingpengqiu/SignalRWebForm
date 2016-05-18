<%@ Page Language="C#" AutoEventWireup="true" validateRequest="false" CodeFile="Channels_Experts.aspx.cs" Inherits="_Admin_Channels_Experts" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>专家专栏右侧排行-益跑网</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Admin.css" type="text/css" rel="stylesheet" />
<link href="/Common/Style.css" type="text/css" rel="stylesheet" />
</head>
<body>
<center>

<ERUN360:header_user id="header_user" runat="server" />

<div style="width:930px;height:600px;padding:10px;text-align:left;">

	<div style="padding:10px;height:32px;font-size:12px;">
		<a href="/">首页</a> >
		<a href="/admin/">管理首页</a> > 
		专家专栏右侧排行
	</div>


	<!-- 信息输入开始 -->
	<form id="form1" name="form1" action="Channels_Experts.aspx" method="post">
	<table width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
	<tr>
		<td colspan="3" style="border-top:dotted 1px #AAAAAA;padding:20px;padding-left:3px;color:#666666;font-size:12px;">
			<!--例子-->
			请参考下面实例输入专家专栏右侧排行（HTML格式）：<br>
			&lt;div id="H2_L_2A_t"&gt;&lt;a href="/blog/200000634.aspx" target="_blank"&gt;长跑爱好者的饮食建议&lt;/a&gt;&lt;/div&gt;<br>
			&lt;div id="H2_L_2A_u"&gt;&lt;a href="/user/100000014.aspx" target="_blank"&gt;石砚秀&lt;/a&gt;&lt;/div&gt;<br>
			&lt;div id="H2_L_2A_t"&gt;&lt;a href="/blog/200000238.aspx" target="_blank"&gt;最长的一次热身&lt;/a&gt;&lt;/div&gt;<br>
			&lt;div id="H2_L_2A_u"&gt;&lt;a href="/user/100000023.aspx" target="_blank"&gt;帅克&lt;/a&gt;&lt;/div&gt;<br>
			...<br>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<textarea id="cContent" name="cContent" cols="70" rows="23" style="font-size:12px;height:500px;"><% =PageBuffer %></textarea> 
		</td>
		<td nowrap width="100" align="center">
			<img src="/Images/preview.gif" onclick="Preview()">
		</td>
		<td>
			<style>
			#preview { width:300px;height:500px;padding-top:5px;line-height:23px;text-align:left;overflow:hidden; }
			#preview a { font-size:12px;color:#4C98CC; }
			#preview a:hover { font-size:12px;color:#FF6701; }
			#preview a.news_title { font-size:16px;color:#5C6F9A;line-height:25px; }
			</style>
			<div id="preview"></div>
		</td>
	</tr>
	<tr>
		<td colspan="3">
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

<!-- 信息输入相关javascript代码，需jQuery支持 -->
<script language="javascript">

function Preview()
{
	//alert($("#cContent")[0].value);
	$("#preview").html($("#cContent")[0].value);
}

function Finish()
{
	if($("#preview")[0].innerHTML.length < 1)
	{
		alert("请先点击预览");
		return false;
	}

	var check_num = 1;
	var obj = $("#cContent")[0];
	if(NullCheck(obj)) if(StringCheck(obj)) { check_num--; }
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

<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 10-09 13:39-->

