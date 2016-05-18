<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MemberList.aspx.cs" Inherits="_Admin_Member_List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>列表(Member)-数据维护-ERUN360.COM</title>
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

<!-- 页首部分 -->
<ERUN360:header_user id="header_user" runat="server" />

<div style="width:100%;height:25px;padding:20px;text-align:left;border-left:solid 1px #FCFCFC;border-top:solid 1px #FCFCFC;border-right:solid 1px #BEBEBE;border-bottom:solid 1px #BEBEBE;background-image:url(/images/s-back2.gif);">
<form id="frmSearch" name="frmSearch" action="MemberList.aspx" method="post">
	<table width="100">
	<tr>
	<td nowrap><a href="/admin/">管理首页</a> > {标题} > </td>
	<td nowrap>搜索 </td>
	<td nowrap>数据范围：</td>
	<td id="dataRegion1" name="dataRegion1" style="display:;" nowrap><input id="searchValue1" name="searchValue1" size="16" value=""></td>
	<td id="dataRegion2" name="dataRegion2" style="display:none;" nowrap><input id="searchDate1" name="searchDate1" size="12" readonly value="" onclick="GDate(this)"></td>
	<td id="dataRegion3" name="dataRegion3" style="display:;" nowrap> &lt;= </td>
	<td>
		<select id="searchField" name="searchField" onchange="SearchFit(this)">
			<option value="int:id">编号</option>
			<option value="int:idMemberStyle">会员类型</option>
			<option value="varchar:cLoginName">登录名</option>
			<option value="int:idGender">性别</option>
			<option value="datetime:dBirthday">出生日期</option>
			<option value="varchar:cAvatar">头像URL</option>
			<option value="varchar:cBio">简介</option>
			<option value="varchar:cName">姓名</option>
			<option value="int:idNationIdType">证件类型</option>
			<option value="varchar:cNationID">证件号码</option>
			<option value="varchar:cMobile">手机</option>
			<option value="varchar:cMail">邮箱</option>
			<option value="varchar:cZipcode">邮编</option>
			<option value="varchar:cAddress">地址</option>
			<option value="int:idCity">城市编码</option>
			<option value="varchar:cCityname">所在城市</option>
			<option value="int:idBlood">血型</option>
			<option value="int:idOccupation">职业</option>
			<option value="int:idEducation">最高学历</option>
			<option value="varchar:cInterests">兴趣爱好</option>
			<option value="varchar:cEmergerContact">紧急联系方式</option>
			<option value="int:idQuestion">密码问题</option>
			<option value="datetime:dCreate">创建时间</option>
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

<!-- 列表显示 -->
<div id="pageContent">
<% =PageResult %>

<!-- 分页导航显示 -->
<% =PageNavigator %>
</div>


<!-- 弹窗操作（创建，编辑，修改，删除） -->
<script language="javascript">
<!--
function ItemShow(idx)
{
   PopupShow(700, 580, "详细显示", "MemberDetail.aspx?id=" + idx);
}

//-->
</script>
</body>
</html>
<!--Powered by 北京联高软件开发有限公司 Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:39-->
