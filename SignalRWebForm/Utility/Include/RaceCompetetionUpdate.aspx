<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceCompetetionUpdate.aspx.cs" Inherits="_Utility_RaceCompetetion_Update" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>�༭(RaceCompetetion)������</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
<link href="/Common/Calendar.css" type="text/css" rel="stylesheet" />
</head>
<body>
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jCalendar.js"></script>
<script language="javascript" src="/Common/jCity.js"></script>

<!-- ��Ϣ���뿪ʼ -->
<br>
<br>
<form id="form1" name="form1" action="RaceCompetetionUpdate.aspx" method="post">
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" valign="top">�������ͣ�</td>
	<td>
		<% =GCommon.Controls("��������", "select", "idCompeteStyle", record.idCompeteStyle.ToString()) %>
	</td>
</tr>
<tr>
	<td align="right" valign="top">���ڳ��У�</td>
	<td>
		<select  name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)">
		</select>
		<select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)">
		</select>
		<script language ="javascript">
		<!--
			BindProvince("����");
		-->
		</script>
		<input type="text" id="idCity" name="idCity" size="5" readonly value="<% =record.idCity %>">
		<input type="text" id="cCityname" name="cCityname" size="15" readonly value="<% =record.cCityname %>">
	</td>
</tr>
<tr>
	<td align="right" valign="top">���¿�ʼ��</td>
	<td>
		<input type="text" id="dRaceBegin" name="dRaceBegin" size="12" maxlength="22" value="<% =record.dRaceBegin.ToString("yyyy-MM-dd") %>" readonly onclick="GDate(this);UpdateHistory(this)"  > 
		���½�����<input type="text" id="dRaceEnd" name="dRaceEnd" size="12" maxlength="22" value="<% =record.dRaceEnd.ToString("yyyy-MM-dd") %>" readonly onclick="GDate(this);UpdateHistory(this)"  > 
	</td>
</tr>
<tr>
	<td align="right" valign="top">������ʼ��</td>
	<td>
		<input type="text" id="dJoinBegin" name="dJoinBegin" size="12" maxlength="22" value="<% =record.dJoinBegin.ToString("yyyy-MM-dd") %>" readonly onclick="GDate(this);UpdateHistory(this)" > 
		����������<input type="text" id="dJoinEnd" name="dJoinEnd" size="12" maxlength="22" value="<% =record.dJoinEnd.ToString("yyyy-MM-dd") %>" readonly onclick="GDate(this);UpdateHistory(this)"  > 
	</td>
</tr>

<tr>
	<td>
		<input type="hidden" id="id" name="id" value="<% =record.id.ToString() %>">
		<input type="hidden" id="UpdatedFields" name="UpdatedFields" value="">
	</td>
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

<!-- ��Ϣ�������javascript���룬��jQuery֧�� -->
<script language="javascript">

function Finish()
{
	//var check_num = 0;
	//var obj = $("#idCompeteStyle")[0];
	//if(NullCheck(obj)) if(IntegerCheck(obj)) { check_num--; }
	//var obj = $("#idCity")[0];
	//if(NullCheck(obj)) if(IntegerCheck(obj)) { check_num--; }
	//if(check_num == 0)
	//{
		document.form1.submit();
		return true;
	//}
	//else
	//{
	//	$("#total_echo").html("���а����ύ���ݻ��д���Ŷ��");
	//}
	//return false;
}

</script>

</body>
</html>
<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-17 09:18-->

