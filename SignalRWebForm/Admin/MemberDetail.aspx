<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MemberDetail.aspx.cs" Inherits="_Admin_Member_Detail" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>��ϸ(Member)-����ά��-ERUN360.COM</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jPopup.js"></script>
<!-- ��Ϣ��ʼ -->
<div id="pageContent">
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" style="width:120px;">��ţ�</td>
	<td><% =record.id.ToString() %>
        <asp:Button ID="btPassWord" runat="server" OnClick="btPassWord_Click" Text="��������" />
        <asp:Label ID="lbPassWord" runat="server" ForeColor="Red"></asp:Label>
        <span class="span_href" onclick="ItemShow(<% =record.id.ToString() %>)">��TA����</span>
    </td>
</tr>
<tr>
	<td align="right">��¼����</td>
	<td><% =record.cLoginName.ToString() %>����:<% =record.cName.ToString() %> �Ա�:<% =GCommon.FindValue("idGender",record.idGender.ToString()) %></td>
</tr>
<tr>
	<td align="right">�������ڣ�</td>
	<td><% =record.dBirthday.ToString() %></td>
</tr>
<tr>
	<td align="right">ͷ��URL��</td>
	<td><img src="<% =record.cAvatar.ToString() %>" width="60" height="60"></td>
</tr>
<tr>
	<td align="right">��飺</td>
	<td><% =record.cBio.ToString() %></td>
</tr>
<tr>
	<td align="right">֤������/���룺</td>
	<td><% =GCommon.FindValue("idNationIdType",record.idNationIdType.ToString()) %> <% =record.cNationID.ToString() %></td>
</tr>
<tr>
	<td align="right">�ֻ���</td>
	<td><% =record.cMobile.ToString() %></td>
</tr>
<tr>
	<td align="right">���䣺</td>
	<td><% =record.cMail.ToString() %></td>
</tr>
<tr>
	<td align="right">�ʱ�,��ַ��</td>
	<td><% =record.cZipcode.ToString() %> <% =record.cAddress.ToString() %></td>
</tr>
<tr>
	<td align="right">���ڳ��У�</td>
	<td><% =record.cCityname.ToString() %></td>
</tr>
<tr>
	<td align="right">Ѫ�ͣ�</td>
	<td><% =GCommon.FindValue("idBlood", record.idBlood.ToString()) %></td>
</tr>
<tr>
	<td align="right">ְҵ��</td>
	<td><% =GCommon.FindValue("idOccupation", record.idOccupation.ToString()) %></td>
</tr>
<tr>
	<td align="right">���ѧ����</td>
	<td><% =GCommon.FindValue("idEducation", record.idEducation.ToString()) %></td>
</tr>
<tr>
	<td align="right">��Ȥ���ã�</td>
	<td><% =record.cInterests.ToString() %></td>
</tr>
<tr>
	<td align="right">������ϵ��ʽ��</td>
	<td><% =record.cEmergerContact.ToString() %></td>
</tr>
<tr>
	<td align="right">�������⣺</td>
	<td><% =GCommon.FindValue("idQuestion",record.idQuestion.ToString()) %></td>
</tr>
<tr>
	<td align="right">����ʱ�䣺</td>
	<td><% =record.dCreate.ToString() %></td>
</tr>
</table>
</div>


    </form>
<script language="javascript">
<!--
    function ItemShow(idx) {
        PopupShow(420, 200, "��TA����", "/infocenter/PostMessage.aspx?uId=" + idx);
    }

    //-->
</script>

</body>
</html>
<!--Powered by ������������������޹�˾ Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:39-->

