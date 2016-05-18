<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EventImport.aspx.cs" Inherits="Admin_EventImport" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>管理入口-益跑网</title>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Admin.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script language="javascript" src="/Common/jCheck.js?2012111"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script language="javascript" src="/Common/jCalendar.js?2012111"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jPopup.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>

<body>
    <form id="form1" runat="server">
        <center>
<div style="width:100%;height:85px;padding-top:30px;background-color:#F8FFF8;">
	<div style="width:950px;height:85px;text-align:left;">
		<img src="/images/logo-u.gif" onclick="window.location='/';" style="margin-right:80px;">
		<img src="/images/top-user.jpg">
	</div>
</div>
<style>
    .cont {
        width: 930px;
        padding: 10px;
        text-align: left;
        font-family: 微软雅黑;
    }

    .conttop {
        padding: 10px;
        height: 32px;
        font-size: 14px;
        font-weight: bold;
        color: #333;
    }

    table {
        color: #666;
    }

        table tr td:first-child {
            width: 120px;
            text-align: right;
        }

        table tr td:last-child {
            width: 410px;
        }

        table tr {
            height: 40px;
            line-height: 50px;
        }

    #CalendarDiv select {
        width: 60px;
        height: 20px;
    }

    #CalendarDiv table tr {
        height: 20px;
        line-height: 20px;
    }

        #CalendarDiv table tr td {
            height: 20px;
            line-height: 20px;
        }

    #signingup {
        width: 80px;
    }

    table tr td:last-child input {
        float: left;
        margin-left: 4px;
    }

    table tr td:last-child label {
        float: left;
        margin-left: 3px;
        margin-right: 4px;
    }

    .item {
        width: 124px;
    }

    .price {
        width: 58px;
    }

    .number {
        width: 58px;
    }

    table tr .project label {
        margin-top: 4px;
    }

    .addproject {
        width: 60px;
        height: 22px;
        line-height: 22px;
        color: #458b08;
        font-size: 12px;
        border: 1px solid #e5e5e5;
        text-align: center;
        border-radius: 4px;
        float: left;
    }

    #Btnsubmit {
        width: 83px;
        height: 32px;
        background: url(/Images/submit.gif);
        border: 0;
        text-indent: -999em;
    }

    #tips {
        background: #fff;
        height: 100%;
        line-height: 110px;
        text-align: center;
        font-size: 14px;
    }

        #tips img {
            margin-right: 4px;
        }

    .gtable {
        width: 100%;
        overflow: auto;
    }

    #GVmain th {
        height: 20px;
        line-height: 20px;
        text-align: center;
    }

    #GVmain td {
        height: 20px;
        line-height: 20px;
        text-align: center;
    }

    #GVmain input {
        width: 80px;
        margin-bottom: 0px;
    }

    #GVmain tr {
        border-bottom: 1px dotted #ccc;
    }

        #GVmain tr:first-child {
            border: 0;
        }
        .tnewuser{float: right;color: #f00}
</style>
<div class="cont">
	<div class="conttop">
        <a class="tnewuser" title="总成绩模版" target="_blank" href="/zs/All.xls">总成绩模版下载</a><br/>
        <a class="tnewuser" title="分段成绩模版" target="_blank" href="/zs/Part.xls">分段成绩模版下载</a>
		<a href="/" >首页</a>  >
<a href="/Admin/RaceList.aspx">赛事首页</a>>
		赛事成绩倒入
	</div>
	<table style="width:100%">
		<tr>
			<td><label for="ssname">选择赛事：</label></td>
			<td>
                <asp:DropDownList ID="ddlRace" runat="server">
                </asp:DropDownList>
                </td>
		</tr>
        <tr>
			<td><label for="ssname">导入总成绩：</label></td>
			<td>
                <asp:FileUpload ID="FileUpload1" runat="server" />
                <asp:Button ID="btAllImport" runat="server" Text="导入" OnClick="btAllImport_Click" />
                <a title="总成绩模版" target="_blank" href="/zs/yangzhoutuantibaomingbiao.xlsx">总成绩模版下载</a>
            </td>
		</tr>
        <tr>
			<td>导入分段成绩：</td>
			<td>
                <asp:FileUpload ID="FileUpload2" runat="server" />
                <asp:Button ID="btPartImport" runat="server" Text="导入" OnClick="btPartImport_Click" />
                <a title="分段成绩模版" target="_blank" href="/zs/yangzhoutuantibaomingbiao.xlsx">分段成绩模版下载</a>
            </td>
		</tr>
	</table>
</div>
</center>
    </form>
</body>
</html>
