<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BlogPublishCreate.aspx.cs" Inherits="_Admin_BlogPublish_Create" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>��ϸ(BlogPublish)-����ά��-ERUN360.COM</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
</head>
<body leftmargin="0" topmargin="0">
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jPopupht.js"></script>

<!-- ��Ϣ��ʼ -->
<div id="pageContent">
<form id="form1" name="form1" action="BlogPublishCreate.aspx" method="post">
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" valign="top" style="width:90px;" nowrap>���ͱ�ţ�</td>
	<td colspan="2"><% =record.id.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top" nowrap>���ߣ�</td>
	<td colspan="2"><% =record.cLoginName.ToString() %></td>
</tr>
<tr>
	<td align="right" valign="top" nowrap>���⣺</td>
	<td colspan="2">
		<% =record.cTitle.ToString() %><% =BlogExt %><br>
		�����޸�Ϊ: <input type="text" id="new_title" name="new_title" size="60" value="<% =record.cTitle.ToString() %>">	
	</td>
</tr>
<tr>
	<td align="right" valign="top" nowrap>ժҪ��</td>
	<td colspan="2">
		<% =XString.TruncBreak(record.cContent.ToString(), 40, 4) %>...
	</td>
</tr>
<tr>
	<td align="right" valign="top">�����ڣ�</td>
	<td>
		<% =groups.Controls("idPosition", 300000000, 0) %> 
		<span id="upspan" style="padding-left:3px;padding-right:3px;color:#FF0000;cursor:pointer;border:solid 1px #333333;" onclick="UploadImage()">�޸�ͼƬ</span>
	</td>
	<td style="color:#EE0000;">
		<% =BlogList %>
	</td>
</tr>
<tr>
	<td align="right" valign="top"></td>
	<td colspan="2">
		<input type="hidden" id="idImage" name="idImage" value="">
		<input type="hidden" id="UpdatedFields" name="UpdatedFields" value="">
		<input type="hidden" id="idBlog" name="idBlog" value="<% =record.id.ToString() %>">
		<div style="float:left;width:100px;height:32px;">
			<img src="/Images/submit.gif" onclick="Finish()">
		</div>
		<div id="total_echo" style="float:left;width:300px;height:22px;padding-top:10px;" class="check_echo">
			
		</div>
	</td>
</tr>
</table>
</form>
</div>

<script language="javascript">

function Finish()
{
	var pos = $("#idPosition")[0].options[$("#idPosition")[0].selectedIndex].value;
	if(pos.substr(3,3) == "100")
	{
		$("#total_echo").html("��ѡ���Ƶ������Ŀλ��!");
		return false;
	}

	if(pos.substr(3,6) == "102100")
	{
		$("#total_echo").html("��ѡ���Ƶ������Ŀλ��!");
		return false;
	}

	document.form1.submit();
	return true;
}

function ItemDelete(idx, pos, md5)
{
   if (confirm("ȷ��Ҫɾ�����м�¼��") == true)
   {
      $.get("BlogPublishDelete.aspx" , { id : idx, checksum : md5 }, function(result) { 
         if(result == "OK")
         {
             $("#trData_" + pos)[0].style.display = "none";
         }
         else
         {
             alert(result);
         }
      });
   }
}

function UploadImage()
{
   PopupShow(400, 210, "�ϴ�ͼƬ", "<% =HostInfo.imgName %>/admin/ajax/Image.aspx");
}

function UploadLargeImage()
{
   PopupShow(400, 210, "�ϴ�ͼƬ", "<% =HostInfo.imgName %>/admin/ajax/LargeImage.aspx");
}

function AddFiles()
{
	$.get("/Utility/Ajax/UpFiles.aspx", { rnd : Math.random() }, function(result) {
		if(result.length > 0) {
			var ra = result.split("|");
			document.getElementById("idImage").value = ra[0];
			//document.getElementById("cContent").value += "\n\n[IMG]" + ra[1] + "[/IMG]\n";
		}
	});
}
closeCallback = AddFiles;

function ChannelCheck()
{
	var obj = document.getElementById("idPosition");
	if(obj!=null)
	{
		var val = obj.options[obj.selectedIndex].value;
		if(val.substr(3,6)=="101100")
		{
			document.getElementById("upspan").innerHTML = "�޸Ĵ�ͼ";
			document.getElementById("upspan").onclick = UploadLargeImage;
		}
		else
		{
			document.getElementById("upspan").innerHTML = "�޸�ͼƬ";
			document.getElementById("upspan").onclick = UploadImage;
		}
	}
}

setInterval(ChannelCheck, 100);

</script>

</body>
</html>
<!--Powered by ������������������޹�˾ Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:40-->

