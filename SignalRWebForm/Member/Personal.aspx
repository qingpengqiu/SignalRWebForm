<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Personal.aspx.cs" Inherits="_Member_Personal" %>
<html>
<head>
<title>����ע����Ϣ-ERUN360.COM</title>
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link href="/Common/Member.css" rel="stylesheet" type="text/css"/>
<link href="/Common/Calendar.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<center>

<ERUN360:header_user id="header_user" runat="server" />

<style>
#tableCreate td { padding:5px;padding-top:1px;padding-bottom:1px; }
</style>

<div style="width:950px;height:613px;background-image:url(/images/user-back3.gif);">

	<div id="page_nav" style="padding-left:30px;padding-top:20px;">
		<a href="/">��ҳ</a> >
		<a href="/Member/">��Ա����</a> > 
		����ע����Ϣ
	</div>

	<!-- ��Ϣ���뿪ʼ -->
	<div id="pageContent" style="float:left;width:828px;">
	<br>
	<form id="form1" name="form1" action="Personal.aspx" method="post" autocomplete="off">
	<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="0" bordercolor="#CCCCCC" style="border-collapse:collapse;background-repeat:no-repeat;">
	<tr>
		<td align="right" style="width:120px;">֤����</td>
		<td>
			<div style="float:left;width:90px;height:28px;border:solid 1px #CCCCCC;background-color:#FFFFFF;padding:3px;margin-right:10px;">
			<% =GCommon.Controls("֤������","select", "idNationIdType", record.idNationIdType.ToString()) %>
			</div>
			<input type="text" id="cNationID" name="cNationID" size="24" maxlength="255"  value="<% =record.cNationID %>" onblur="" onchange="UpdateHistory(this)"> 
			<span id="check_iNationId" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right">�ֻ���</td>
		<td>
			<input type="text" id="cMobile" name="cMobile" size="16" maxlength="255"  value="<% =record.cMobile %>" onblur="" onchange="UpdateHistory(this)"> 
			<span id="check_cMobile" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right">�������䣺</td>
		<td>
			<input type="text" id="cMail" name="cMail" size="32" maxlength="255"  value="<% =record.cMail %>" onblur="" onchange="UpdateHistory(this)"> 
			<span id="check_cMail" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right">�ʱ��ַ��</td>
		<td>
			<input type="text" id="cZipcode" name="cZipcode" size="6" maxlength="6"  value="<% =record.cZipcode %>" onblur="" onchange="UpdateHistory(this)"> 
			<input type="text" id="cAddress" name="cAddress" size="40" maxlength="255"  value="<% =record.cAddress %>" onblur="" onchange="UpdateHistory(this)"> 
			<span id="check_cAddress" class="check_echo"></span>
			<span id="check_cZipcode" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right">���ڳ��У�</td>
		<td>
			<script type="text/javascript" src="/Common/jCity.js"></script>
			<div style="float:left;width:130px;height:28px;border:solid 1px #CCCCCC;background-color:#FFFFFF;padding:3px;margin-right:10px;">
			<select  name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)">
			</select>
			</div>
			<div style="float:left;width:130px;height:28px;border:solid 1px #CCCCCC;background-color:#FFFFFF;padding:3px;margin-right:10px;">
			<select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)">
			</select>
			</div>
			<!-- </FORM> -->
			<script type="text/javascript" language ="javascript">
			<!--
				BindProvince("����");
			// -->
			</script>
			<input type="hidden" id="idCity" name="idCity" size="5" readonly value="<% =record.idCity %>" onchange="UpdateHistory(this)">
			<input type="hidden" id="cCityname" name="cCityname" size="16" readonly value="<% =record.cCityname %>" onchange="UpdateHistory(this)">
		</td>
	</tr>
	<tr>
		<td align="right">Ѫ�ͣ�</td>
		<td>
			<div style="float:left;width:90px;height:28px;border:solid 1px #CCCCCC;background-color:#FFFFFF;padding:3px;margin-right:10px;">
			<% =GCommon.Controls("Ѫ��","select", "idBlood", record.idBlood.ToString()) %>
			</div>
		</td>
	</tr>
	<tr>
		<td align="right">���ѧ����</td>
		<td>
			<div style="float:left;width:190px;height:28px;border:solid 1px #CCCCCC;background-color:#FFFFFF;padding:3px;margin-right:10px;">
			<% =GCommon.Controls("���ѧ��","select", "idEducation", record.idEducation.ToString()) %>
			</div>
		</td>
	</tr>
	<tr>
		<td align="right">��Ȥ���ã�</td>
		<td>
			<input type="text" id="cInterests" name="cInterests" size="32" maxlength="255"  value="<% =record.cInterests %>" onblur="" onchange="UpdateHistory(this)"> 
			<span id="check_cInterests" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right">����ְҵ��</td>
		<td>
			<div style="float:left;width:290px;height:28px;border:solid 1px #CCCCCC;background-color:#FFFFFF;padding:3px;margin-right:10px;">
			<% =GCommon.Controls("����ְҵ","select", "idOccupation", record.idOccupation.ToString()) %>
			</div>
			<span id="check_iOccupation" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right">������ϵ��Ϣ��</td>
		<td>
			<input type="text" id="cEmergerContact" name="cEmergerContact" size="32" maxlength="255"  value="<% =record.cEmergerContact %>" onblur="$('#check_' + this.id).html('');" onchange="UpdateHistory(this)" onclick="$('#check_' + this.id).html('<font color=blue>��ϵ�˼��ֻ���</font>');"> 
			<span id="check_cEmergerContact" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td align="right">��飺</td>
		<td>
			<textarea type="text" id="cBio" name="cBio" cols="54" rows="3" onblur="" onchange="UpdateHistory(this)"><% =record.cBio %></textarea>
			<span id="check_cBio" class="check_echo"></span>
		</td>
	</tr>
	<tr>
		<td>
			<input type="hidden" id="idUser" name="idUser" value="<% =record.id %>">
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
	<!-- ��Ϣ������� -->
	</div>
	<!--
	<div id="blog_c_right">
		<img src="/images/ajax-loader.gif">
	</div>
	-->
	<div style="clear:both;width:1px;height:1px;line-height:1px;font-size:1px;"></div>
</div>

<script language="javascript">
/*
$.get("/Utility/Ajax/UserSummery.aspx", { }, function(result) {
	if(result.length > 0) {
		document.getElementById("blog_c_right").innerHTML = result;
	}
});
*/
function Finish()
{
	var hv = $("#UpdatedFields")[0].value;
	//alert(hv);
	if(hv.length > 0)
	{
		document.form1.submit();
		return true;
	}
	else
	{
		alert("δ�޸��κ���Ϣ");
		//$("#UpdatedFields").html("δ�޸��κ���Ϣ");
		return false;
	}
}

</script>

<ERUN360:footer_user id="footer_user" runat="server" />

</center>
</body>
</html>
