<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WeiboList.aspx.cs" Inherits="_Admin_Weibo_List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>列表(Weibo)-数据维护-益跑网</title>
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

<div style="width:100%;height:25px;padding:20px;text-align:center;border-left:solid 1px #FCFCFC;border-top:solid 1px #FCFCFC;border-right:solid 1px #BEBEBE;border-bottom:solid 1px #BEBEBE;background-image:url(/images/s-back2.gif);">
<form id="frmSearch" name="frmSearch" action="WeiboList.aspx" method="post">
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
			<option value="varchar:cFaceUrl">头像图片地址</option>
			<option value="datetime:cUsername">比赛时间</option>
			<option value="varchar:cUserUrl">赛事网址</option>
			<option value="varchar:cContent">赛事标题</option>
			<option value="datetime:dCreate">创建时间</option>
		</select>
	</td>
	<td id="dataRegion4" name="dataRegion4" nowrap> &lt; </td>
	<td id="dataRegion5" name="dataRegion5" style="display:;" nowrap><input id="searchValue2" name="searchValue2" size="16" value=""></td>
	<td id="dataRegion6" name="dataRegion6" style="display:none;" nowrap><input id="searchDate2" name="searchDate2" size="12" readonly value="" onclick="GDate(this)"></td>
	<td><img src="/Images/search.gif" style="margin-bottom:1px;" onclick="document.frmSearch.submit();return true;"></td>
	<td style="padding-left:10px;"><div id="span_create" onclick="ItemCreate()"></div></td>
	</tr>
	</table>
</form>
</div>
<script language="javascript">SearchInit();</script>

<!-- 列表显示 -->
<% =PageResult %>

<!-- 分页导航显示 -->
<% =PageNavigator %>

<!-- 弹窗操作（创建，编辑，修改，删除） -->
<script language="javascript">
<!--
function ItemCreate()
{
   PopupShow(700, 400, "新建数据", "WeiboCreate.aspx");
}

function ItemShow(idx)
{
   PopupShow(700, 400, "详细显示", "WeiboDetail.aspx?id=" + idx);
}

function ItemUpdate(idx, pos)
{
   PopupShow(700, 400, "修改数据", "WeiboUpdate.aspx?id=" + idx);
}

function ItemDelete(idx, pos, md5)
{
   if (confirm("确定要删除本行记录吗？") == true)
   {
      $.get("WeiboDelete.aspx" , { id : idx, checksum : md5 }, function(result) { 
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
<!--Powered by Beijing Legalsoft Ltd.-->
<!--This file formatted by WizForm 2.1 at 10-09 13:39-->
