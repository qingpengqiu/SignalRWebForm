<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BlogPublishList.aspx.cs" Inherits="_Admin_BlogPublish_List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>�б�(BlogPublish)-����ά��-������</title>
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

<form id="frmSearch" name="frmSearch" action="BlogPublishList.aspx" method="post">
<div style="width:100%;height:25px;padding:20px;text-align:center;border-left:solid 1px #FCFCFC;border-top:solid 1px #FCFCFC;border-right:solid 1px #BEBEBE;border-bottom:solid 1px #BEBEBE;background-image:url(/images/s-back2.gif);">
<table width="100">
<tr>
<td nowrap><a href="/admin/">������ҳ</a> > {�����Ű�} > </td>
<td nowrap>λ�ڣ�</td>
<td>
<% =groups.Controls("idPosition", 300000000, position).Replace("UpdateHistory(this)", "document.frmSearch.submit()") %> 
</td>
</tr>
</table>
</div>

<!-- �б���ʾ -->
<% =PageResult %>
</form>

<!-- ��ҳ������ʾ -->
<% =PageNavigator %>

<!-- �����������������༭���޸ģ�ɾ���� -->
<script language="javascript">
<!--

function ItemListDelete()
{
   if (confirm("ȷ��Ҫɾ����Щ��¼��") == true)
   {
		document.frmSearch.submit();
		return true;
   }
   return false;
}
//-->
</script>
</body>
</html>
<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-17 09:18-->
