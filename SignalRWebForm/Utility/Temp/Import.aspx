<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Import.aspx.cs" Inherits="_Utility_Import" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>���벩��-ERUN360.COM</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta name="generator" content="50018 editor">
<meta name="author" content="">
<meta name="copyright" content="">
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link href="/Common/Style.css" rel="stylesheet" type="text/css"/>
<link href="/Common/Blog.css" rel="stylesheet" type="text/css"/>
<link href="/Common/Calendar.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<center>

<ERUN360:header_blog id="header_blog" runat="server" />

<div id="blog_b">

	<div id="blog_c">
		<div id="blog_c_left">
			
			<!--��ʼժҪ-->
			<div id="blog_m_top"></div>

			<div style="width:675px;background-image:url(/images/blog/bk-left2.gif);background-position:-0px -17px;font-size:12px;padding-left:20px;padding-right:20px;padding-top:5px;text-align:left;overflow:hidden;">

<form id="form1" name="form1" action="ImportPrc.aspx" method="post" autocomplete="off">

<div id="InfoExtention" style="background-color:#FFFFFF;padding:6px;padding-right:18px;"></div>

<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;text-align:left;">
<tr>
	<td>
		<span id="title_2">�಩���ı� [���ϸ����¸�ʽ��<a href="">�������ˢ��</a>���벻Ҫˢ��ҳ�棡]</span>��
		<br>
		<div style="border:dotted 1px #000099;padding:10px;font-size:12px;color:#000099;">
		��1�У�############################<br>
		��2�У�����<br>
		��3�У�����<br>
		��4�У�����<br>
		��5�У����п�ʼΪ����...(������������Ҫ��̫��Ŀ���)<br>
		</div>
		<textarea id="cContent" name="cContent" cols="88" rows="20"></textarea>
	</td>
	<td>
	</td>
</tr>
<tr>
	<td>
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
<!-- ��Ϣ������� -->

<!-- ��Ϣ�������javascript���룬��jQuery֧�� -->
<script language="javascript">

function Finish()
{
	document.form1.submit();
	return true;
}

</script>

				
				<div style="clear:both;width:715px;height:20px;"></div>
			</div>

			<div id="blog_m_bot"></div>
			<div id="blog_m_spc"></div>

		</div>
		
		<!--�Ҳ��û���Ϣ-->
		<div id="blog_c_right">
			
		</div>

		<div id="h_clear"></div>
	</div>

	<div id="h_clear"></div>
</div>

<ERUN360:footer_blog id="footer_blog" runat="server" />

</center>
</body>
</html>
