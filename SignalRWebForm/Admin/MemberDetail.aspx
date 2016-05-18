<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MemberDetail.aspx.cs" Inherits="_Admin_Member_Detail" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>详细(Member)-数据维护-ERUN360.COM</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Frame.css" type="text/css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jPopup.js"></script>
<!-- 信息开始 -->
<div id="pageContent">
<table id="tableCreate" width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#CCCCCC" style="border-collapse:collapse;">
<tr>
	<td align="right" style="width:120px;">编号：</td>
	<td><% =record.id.ToString() %>
        <asp:Button ID="btPassWord" runat="server" OnClick="btPassWord_Click" Text="重置密码" />
        <asp:Label ID="lbPassWord" runat="server" ForeColor="Red"></asp:Label>
        <span class="span_href" onclick="ItemShow(<% =record.id.ToString() %>)">给TA留言</span>
    </td>
</tr>
<tr>
	<td align="right">登录名：</td>
	<td><% =record.cLoginName.ToString() %>姓名:<% =record.cName.ToString() %> 性别:<% =GCommon.FindValue("idGender",record.idGender.ToString()) %></td>
</tr>
<tr>
	<td align="right">出生日期：</td>
	<td><% =record.dBirthday.ToString() %></td>
</tr>
<tr>
	<td align="right">头像URL：</td>
	<td><img src="<% =record.cAvatar.ToString() %>" width="60" height="60"></td>
</tr>
<tr>
	<td align="right">简介：</td>
	<td><% =record.cBio.ToString() %></td>
</tr>
<tr>
	<td align="right">证件类型/号码：</td>
	<td><% =GCommon.FindValue("idNationIdType",record.idNationIdType.ToString()) %> <% =record.cNationID.ToString() %></td>
</tr>
<tr>
	<td align="right">手机：</td>
	<td><% =record.cMobile.ToString() %></td>
</tr>
<tr>
	<td align="right">邮箱：</td>
	<td><% =record.cMail.ToString() %></td>
</tr>
<tr>
	<td align="right">邮编,地址：</td>
	<td><% =record.cZipcode.ToString() %> <% =record.cAddress.ToString() %></td>
</tr>
<tr>
	<td align="right">所在城市：</td>
	<td><% =record.cCityname.ToString() %></td>
</tr>
<tr>
	<td align="right">血型：</td>
	<td><% =GCommon.FindValue("idBlood", record.idBlood.ToString()) %></td>
</tr>
<tr>
	<td align="right">职业：</td>
	<td><% =GCommon.FindValue("idOccupation", record.idOccupation.ToString()) %></td>
</tr>
<tr>
	<td align="right">最高学历：</td>
	<td><% =GCommon.FindValue("idEducation", record.idEducation.ToString()) %></td>
</tr>
<tr>
	<td align="right">兴趣爱好：</td>
	<td><% =record.cInterests.ToString() %></td>
</tr>
<tr>
	<td align="right">紧急联系方式：</td>
	<td><% =record.cEmergerContact.ToString() %></td>
</tr>
<tr>
	<td align="right">密码问题：</td>
	<td><% =GCommon.FindValue("idQuestion",record.idQuestion.ToString()) %></td>
</tr>
<tr>
	<td align="right">创建时间：</td>
	<td><% =record.dCreate.ToString() %></td>
</tr>
</table>
</div>


    </form>
<script language="javascript">
<!--
    function ItemShow(idx) {
        PopupShow(420, 200, "给TA留言", "/infocenter/PostMessage.aspx?uId=" + idx);
    }

    //-->
</script>

</body>
</html>
<!--Powered by 北京联高软件开发有限公司 Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:39-->

