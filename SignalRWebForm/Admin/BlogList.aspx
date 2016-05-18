<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BlogList.aspx.cs" Inherits="_Admin_Blog_List" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>列表(Blog)-数据维护--ERUN360.COM</title>
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<link href="/Common/Admin.css" type="text/css" rel="stylesheet" />
<link href="/Common/Calendar.css" type="text/css" rel="stylesheet" />
</head>
<body>
<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jPopupht.js"></script>
<script language="javascript" src="/Common/jCalendar.js"></script>
<script language="javascript" src="/Common/jAdmin.js"></script>

<!-- 页首部分 -->


<script language="javascript" src="/Common/jQuery.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jCalendar.js"></script>

<div style="width:100%;height:85px;padding-top:30px;background-color:#F8FFF8;">
	<div style="width:950px;height:85px;text-align:left;">
		<img src="/images/logo-u.gif" onclick="window.location='/';" style="margin-right:80px;">
		<img src="/images/top-user.jpg">
	</div>
</div>

<div style="width:100%;height:25px;padding:20px;text-align:left;border-left:solid 1px #FCFCFC;border-top:solid 1px #FCFCFC;border-right:solid 1px #BEBEBE;border-bottom:solid 1px #BEBEBE;background-image:url(/images/s-back2.gif);">
<form id="frmSearch" name="frmSearch" action="BlogList.aspx" method="post">
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
			<option value="int:id">编码</option>
			<option value="int:idPersonGroup">个人分组</option>
			<option value="int:idHref">关联信息ID</option>
			<option value="int:idUser">用户ID</option>
			<option value="varchar:cLoginName">用户名称</option>
			<option value="varchar:cTitle">标题</option>
			<option value="text:cContent">内容</option>
			<option value="datetime:dCreate">创建时间</option>
            <option value="cInt:cTitle">约跑</option>
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
   PopupShow(700, 400, "详细显示", "BlogDetail.aspx?id=" + idx);
}

function Publish(idx)
{
   PopupShow(700, 450, "发布博客到相关栏目", "BlogPublishCreate.aspx?id=" + idx);
}
function Pushblog(idx) {
    PopupShow(700, 500, "发布博客到相关栏目", "PushBlog.aspx?id=" + idx);
}
function PushRun(idx) {
    PopupShow(700, 500, "发布博客到相关栏目", "PushRun.aspx?id=" + idx);
}
function ItemDelete(idx, pos, md5)
{
   if (confirm("确定要删除本行记录吗？") == true)
   {
      $.get("BlogDelete.aspx" , { id : idx, checksum : md5 }, function(result) { 
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
<!--Powered by 北京联高软件开发有限公司 Ltd.-->
<!--This file formatted by WizForm 2.1 at 09-14 16:40-->
