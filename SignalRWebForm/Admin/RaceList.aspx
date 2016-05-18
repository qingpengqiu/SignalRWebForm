<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceList.aspx.cs" Inherits="Admin_RaceList" %>

<!DOCTYPE html>

<html>
<head>
    <title>赛事管理-益跑网</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <link href="/Common/Admin.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>

    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<body>
    <form id="form2" runat="server">
        <center>           
        <div style="width: 100%; height: 85px; padding-top: 30px; background-color: #F8FFF8;">
            <div style="width: 950px; height: 85px; text-align: left;">
                <img src="/images/logo-u.gif" onclick="window.location='/';" style="margin-right: 80px;">
                <img src="/images/top-user.jpg">
            </div>
        </div>
        <style>
            #item {
        float: left;
        width: 80px;
        height: 20px;
        padding: 20px;
        text-align: center;
        cursor: pointer;
        font-size: 14px;
        color: #000000;
        border: solid 1px #CCCCFF;
        border-top: solid 3px #CCCCFF;
        margin: 10px;
    }
        </style>

 <div style="width:930px;height:600px;padding:10px;text-align:left;">

	<div style="padding:10px;height:32px;font-size:12px;">
		<a href="/">首页</a> >
		赛事管理
	</div>
	<div style="clear:both;font-size:12px;">
	<%=item.ToString() %>
	</div>
</div>
             </center>
    </form>
</body>
</html>
