<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MemberList.aspx.cs" Inherits="_Admin_Member_List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>�б�(Member)-����ά��-ERUN360.COM</title>
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

<div style="width:100%;height:25px;padding:20px;text-align:left;border-left:solid 1px #FCFCFC;border-top:solid 1px #FCFCFC;border-right:solid 1px #BEBEBE;border-bottom:solid 1px #BEBEBE;background-image:url(/images/s-back2.gif);">
<form id="frmSearch" name="frmSearch" action="MemberList.aspx" method="post">
	<table width="100">
	<tr>
	<td nowrap><a href="/admin/">������ҳ</a> > {����} > </td>
	<td nowrap>���� </td>
	<td nowrap>���ݷ�Χ��</td>
	<td id="dataRegion1" name="dataRegion1" style="display:;" nowrap><input id="searchValue1" name="searchValue1" size="16" value=""></td>
	<td id="dataRegion2" name="dataRegion2" style="display:none;" nowrap><input id="searchDate1" name="searchDate1" size="12" readonly value="" onclick="GDate(this)"></td>
	<td id="dataRegion3" name="dataRegion3" style="display:;" nowrap> &lt;= </td>
	<td>
		<select id="searchField" name="searchField" onchange="SearchFit(this)">
			<option value="int:id">���</option>
			<option value="int:idMemberStyle">��Ա����</option>
			<option value="varchar:cLoginName">��¼��</option>
			<option value="int:idGender">�Ա�</option>
			<option value="datetime:dBirthday">��������</option>
			<option value="varchar:cAvatar">ͷ��URL</option>
			<option value="varchar:cBio">���</option>
			<option value="varchar:cName">����</option>
			<option value="int:idNationIdType">֤������</option>
			<option value="varchar:cNationID">֤������</option>
			<option value="varchar:cMobile">�ֻ�</option>
			<option value="varchar:cMail">����</option>
			<option value="varchar:cZipcode">�ʱ�</option>
			<option value="varchar:cAddress">��ַ</option>
			<option value="int:idCity">���б���</option>
			<option value="varchar:cCityname">���ڳ���</option>
			<option value="int:idBlood">Ѫ��</option>
			<option value="int:idOccupation">ְҵ</option>
			<option value="int:idEducation">���ѧ��</option>
			<option value="varchar:cInterests">��Ȥ����</option>
			<option value="varchar:cEmergerContact">������ϵ��ʽ</option>
			<option value="int:idQuestion">��������</option>
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
function ItemShow(idx)
{
   PopupShow(700, 580, "��ϸ��ʾ", "MemberDetail.aspx?id=" + idx);
}

//-->
</script>
</body>
</html>
<!--Powered by ������������������޹�˾ Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:39-->
