<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceQuery.aspx.cs" Inherits="Channels_Competetion_RaceQuery" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>证书打印-益跑网个人中心</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="/Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/user-more.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/Group.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/modernizr.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/Html/js/bootstrap-validation.min.js"></script>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="/Common/jCity.js"></script>
    <script src="/Common/jCheck.js"></script>
    <script src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <style>
        .main-left ul .user-dq {
            filter: alpha(Opacity=100);
            -moz-opacity: 1;
            opacity: 1;
        }
        .query{width: 980px;margin: 20px auto}
        .query label{display: inline-block;width: 376px;text-align: right;height: 40px;}
        .query select{width: 230px;}
        .query input{background-color: #FFFFFF;border: 1px solid #CCCCCC;width: 210px;border-radius: 4px;height: 30px;line-height: 30px;padding-left: 10px;}
        .query .querygo{display: block;margin: 10px auto;background-color: #FFFFFF;border: 1px solid #CCCCCC;width: 220px;border-radius: 4px;height: 30px;line-height: 30px;text-align: center;color: #000}
    </style>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
</head>
<body>
    <form  id="rpfrom" runat="server">
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="wrap">
    	<div class="query">
    	<label>赛事选择:</label>
            <asp:DropDownList ID="match" runat="server">
            </asp:DropDownList>
    	<br>
    	<label>姓名:</label>
    	<input type="text" id="name" runat="server"> <br>
    	<label>证件号码:</label>
    	<input type="text" id="idcard" runat="server"> <br>
    	<a class="querygo" href="javascript:void(0);">点击查询</a>
    	</div>
    </div>
<script LANGUAGE="JavaScript">
	$(".querygo").on('click', function(event) {
		var name = encodeURIComponent(encodeURIComponent($("#name").val())),
			opt = $("#match").val(),
			idcard = $("#idcard").val()
		if(name && opt!=0 && idcard){
			// f_submit(980,600,'QueryResult.aspx?opt='+opt+'&name='+name+'&idcard='+idcard+'#name')
      
            window.location.href='QueryResult.aspx?opt='+opt+'&name='+name+'&idcard='+idcard+'#name'
		}else{
			alert("请填写完整")
		}
	});
    function f_submit(sWidth,sHeight,submitUrl){
		var sLeft =(screen.width-sWidth)/2;
		var sTop =(screen.height-sHeight)/2;
		window.open(submitUrl,"","height="+ sHeight +", width=" + sWidth+", top="+sTop+", left="+sLeft+", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no,status=no");  
 }
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
        </form>
</body>
</html>