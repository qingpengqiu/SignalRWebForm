<%@ Page Language="C#" AutoEventWireup="true" validateRequest="false" CodeFile="Ads.aspx.cs" Inherits="_Admin_Ads" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>���½ǹ��-������</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Admin.css" type="text/css" rel="stylesheet" />
</head>
<body>
<center>

<ERUN360:header_user id="header_user" runat="server" />

<div style="width:930px;height:600px;padding:10px;text-align:left;">

	<div style="padding:10px;height:32px;font-size:12px;">
		<a href="/">��ҳ</a> >
		<a href="/admin/">������ҳ</a> > 
		�༭��ҳ���½ǹ��
	</div>

	<!-- ��Ϣ���뿪ʼ -->
	<form id="form1" name="form1" action="Ads.aspx" method="post">
	<table width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
	<tr>
		<td style="border-top:dotted 1px #AAAAAA;padding:20px;padding-left:3px;color:#666666;font-size:12px;">
			<!--����-->
			��ο�����ʵ��������ҳ���½ǹ�����ݣ�HTML��ʽ����<br>
			&lt;a href="http://a.taobao.com"&gt;&lt;img src="/images/temp/03.jpg"&gt;&lt;/a&gt; <br>
		</td>
		<td colspan="2" align="left" valign="top" style="color:#5C6F9A;padding:20px;border-top:dotted 1px #AAAAAA;font-size:12px;">
			<!--
			<br>
			&bull; ��һ�����������ǿ��ʾ���� class="news_title" ���Ρ�<br>
			&bull; ���������&lt;br&gt;������<br>
			-->
			ͼƬ�ߴ�Ϊ: 277x104
		</td>
	</tr>
	<tr>
		<td>
			<textarea id="cContent" name="cContent" cols="70" rows="12"><% =PageBuffer %></textarea> 
		</td>
		<td nowrap width="100" align="center">
			<img src="/Images/preview.gif" onclick="Preview()">
		</td>
		<td>
			<style>
			#preview { width:300px;height:127px;line-height:23px;text-align:left;overflow:hidden; }
			#preview a { font-size:12px;color:#4C98CC; }
			#preview a:hover { font-size:12px;color:#FF6701; }
			#preview a.news_title { font-size:16px;color:#5C6F9A; }
			</style>
			<div id="preview"></div>
		</td>
	</tr>
	<tr>
		<td>
			<input type="hidden" id="UpdatedFields" name="UpdatedFields" value="">
			<div style="float:left;width:100px;height:32px;">
				<img src="/Images/submit.gif" onclick="Finish()">
			</div>
			<div id="total_echo" style="float:left;width:300px;height:22px;padding-top:10px;" class="check_echo">
			<% =PageResult %>
			</div>
		</td>
		<td>
		</td>	
	</tr>
	</table>
	</form>

<!-- ��Ϣ�������javascript���룬��jQuery֧�� -->
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
		alert("���ȵ��Ԥ��");
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
		$("#total_echo").html("���а����ύ���ݻ��д���Ŷ��");
	}
	return false;
}

</script>
</center>

</body>
</html>

<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 10-09 13:39-->

