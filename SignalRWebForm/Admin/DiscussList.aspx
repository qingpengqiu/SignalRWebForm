<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DiscussList.aspx.cs" Inherits="_Admin_Discuss_List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>�б�(Discuss)-����ά��-ERUN360.COM</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Admin.css" type="text/css" rel="stylesheet" />
<link href="/Common/Calendar.css" type="text/css" rel="stylesheet" />
</head>
<body>
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jPopup.js"></script>
<script language="javascript" src="/Common/jCalendar.js"></script>
<script language="javascript" src="/Common/jAdmin.js"></script>

<!-- ҳ�ײ��� -->
<ERUN360:header_user id="header_user" runat="server" />

<div style="width:100%;height:25px;padding:20px;text-align:center;border-left:solid 1px #FCFCFC;border-top:solid 1px #FCFCFC;border-right:solid 1px #BEBEBE;border-bottom:solid 1px #BEBEBE;background-image:url(/images/s-back2.gif);">
<form id="frmSearch" name="frmSearch" action="DiscussList.aspx" method="post">
	<table width="100">
	<tr>
	<td nowrap><a href="/admin/">������ҳ</a> > {����} > </td>
	<td nowrap>���� </td>
	<td>
		<select id="searchKey" name="searchKey" title="�����ݿ������ϢID(idInfo)��β�����зֿ⣻�ֿ��ѯ�ٶȽϿ죡"  onchange="TableChange(this)">
			<option value="*">���б�</option>
			<option value="0">���ݿ��0</option>
			<option value="1">���ݿ��1</option>
			<option value="2">���ݿ��2</option>
			<option value="3">���ݿ��3</option>
			<option value="4">���ݿ��4</option>
			<option value="5">���ݿ��5</option>
			<option value="6">���ݿ��6</option>
			<option value="7">���ݿ��7</option>
			<option value="8">���ݿ��8</option>
			<option value="9">���ݿ��9</option>
		</select>
	</td>
	<td nowrap>���ݷ�Χ��</td>
	<td id="dataRegion1" name="dataRegion1" style="display:;" nowrap><input id="searchValue1" name="searchValue1" size="16" value=""></td>
	<td id="dataRegion2" name="dataRegion2" style="display:none;" nowrap><input id="searchDate1" name="searchDate1" size="12" readonly value="" onclick="GDate(this)"></td>
	<td id="dataRegion3" name="dataRegion3" style="display:;" nowrap> &lt;= </td>
	<td>
		<select id="searchField" name="searchField" onchange="SearchFit(this)">
			<option value="int:id">���</option>
			<option value="int:idInfo">��ϢID</option>
			<option value="int:idUser">�û�ID</option>
			<option value="varchar:cLoginName">�ǳ�</option>
			<option value="varchar:cContent">����</option>
			<option value="datetime:dCreate">����ʱ��</option>
		</select>
	</td>
	<td id="dataRegion4" name="dataRegion4" nowrap> &lt; </td>
	<td id="dataRegion5" name="dataRegion5" style="display:;" nowrap><input id="searchValue2" name="searchValue2" size="16" value=""></td>
	<td id="dataRegion6" name="dataRegion6" style="display:none;" nowrap><input id="searchDate2" name="searchDate2" size="12" readonly value="" onclick="GDate(this)"></td>
	<td><img src="/Images/search.gif" style="margin-bottom:1px;" onclick="document.frmSearch.submit();return true;"></td>
	</tr>
	</table>
</form>
</div>
<script language="javascript">SearchInit();</script>

<!-- �б���ʾ -->
<div id="pageContent">
<% =PageResult %>

<!-- ��ҳ������ʾ -->
<% =PageNavigator %>
</div>


<!-- �����������������༭���޸ģ�ɾ���� -->
<script language="javascript">
<!--
function TableChange(obj)
{
   var idx = obj.options[obj.selectedIndex].value;
   if(idx!="*") window.location = "DiscussList.aspx?table=" + idx;
   else window.location = "DiscussList.aspx";
}

function ItemShow(tab,idx)
{
   PopupShow(700, 400, "��ϸ��ʾ", "DiscussDetail.aspx?idinfo=" + tab + "&id=" + idx);
}

function ItemDelete(tab, idx, pos, md5)
{
   if (confirm("ȷ��Ҫɾ�����м�¼��") == true)
   {
      $.get("DiscussDelete.aspx" , { idinfo : tab, id : idx, checksum : md5 }, function(result) { 
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
//-->
</script>
</body>
</html>
<!--Powered by ������������������޹�˾ Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:40-->
