<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Permission.aspx.cs" Inherits="_Admin_Permission" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>�����û�Ȩ��-����ά��-ERUN360.COM</title>
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
		�����û�Ȩ��
	</div>

<!-- ��Ϣ��ʼ -->
<form id="form1" name="form1" action="Permission.aspx" method="post" autocomplete="off">
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" valign="top"></td>
	<td>
		<br>
		�ɳ�������Ա����ָ���û�Ϊ����Ϣ����Ա��<br>
		<br>
	</td>
</tr>
<tr>
	<td align="right" valign="top">�û�ID��</td>
	<td>
		<input type="text" id="idUser" name="idUser" size="16" maxlength="32"  onblur="if(NullCheck(this)) if(StringCheck(this)) LengthCheck(this,2,32);" value="" >
		<span id="check_idUser" class="check_echo"></span>
	</td>
</tr>
<tr>
	<td align="right" valign="top">�û���¼����</td>
	<td>
		<input type="text" id="cLoginName" name="cLoginName" size="16" maxlength="32"  onblur="if(NullCheck(this)) if(StringCheck(this)) LengthCheck(this,2,32);" value="" >
		<span id="check_cLoginName" class="check_echo"></span>
	</td>
</tr>
<tr>
	<td align="right" valign="top">�����ɫ��</td>
	<td>
		<% =GCommon.Controls("�û���ɫ", "select", "idAdminStyle", "") %> ע�⣺��Ϣ����Ա���ܷ������͵�ָ����Ŀ��
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
		$("#total_echo").html("���а����ύ���ݻ��д���Ŷ��");
	}
	return false;
}
</script>

</center>

</body>
</html>
<!--Powered by ������������������޹�˾ Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:39-->

