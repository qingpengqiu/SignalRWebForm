<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MarathonPace.aspx.cs" Inherits="_Channels_Tools_MarathonPace" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>马拉松配速指南</title>
<meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />

<meta name="keywords" content="2013厦门国际马拉松,厦马,兔子军团,初马指南,跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta name="distribution" content="global" />
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
<link href="/Common/tools.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
<script language="javascript" src="/Common/jQuery.js?2012111"></script>
<script language="javascript" src="/Common/jCheck.js?2012111"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<script language="javascript" src="/Common/jCalendar.js?2012111"></script>	
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
<!--第二段-->
<div id="H2_w" >
	<div id="cal_main">
		<div id="guide">
			<ul>
				<li><a href="PaceCalculator.aspx">配速计算器<i>（Pace Calculator）</i></a></li>
				<li><a href="PaceConverter.aspx">配速转换器（Pace Converter）</a></li>
				<li><a href="FinishTime.aspx">完跑计算器（Finish Time）</a></li>
				<li class="dq"><a href="MarathonPace.aspx">马拉松配速指南<em>（Marathon Pace）</em></a></li>
				<li><a href="AgeGrade.aspx">年龄等级计算器（Age-graded）</a></li>
				<li><a href="BMI.aspx">BMI体重指数计算器</a></li>
				<li><a href="Calorie.aspx">卡路里计算器<i>（Calorie）</i></a></li>
				<li><a href="Training.aspx">训练计算器</a></li>
				<li><a href="Grade.aspx">国家运动员等级</a></li>
				<li><a href="BMR.aspx">基础代谢计算器</a></li>
				<li><a href="ShoeSize.aspx">鞋码对照表</a></li>
				<li><a href="Converter.aspx">公英制转换</a>	</li>
			</ul>				
			<script language="javascript" src="/common/jtools.js"></script>
		</div>
		<div id="cont">
			<span>马拉松配速指南<em>（Marathon Pace Guide）</em></span>
			<p>
				输入你马拉松 预计完赛的时间（？小时?分？秒）或预计配速（？分？秒/公里），计算出另外一项和每公里所用的时间（1-42公里）
			</p>
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
			<table id="tab" width="100">
			<tr>
				<td nowrap align="right">
					预计完赛的时间：
				</td>
				<td nowrap>
					<% =GCommon.HMS("hours", 2, 12, 2) %> 时
					<% =GCommon.HMS("minutes", 0, 59, 0) %> 分
					<% =GCommon.HMS("seconds", 0, 59, 0) %> 秒
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					或 预计配速：
				</td>
				<td nowrap>
					<input type="text" class="ik" id="minutes2" name="minutes2" size="3" maxlength="2" value=""> 分
					<input type="text" class="ik" id="seconds2" name="seconds2" size="3" maxlength="2" value=""> 秒 / 公里
				</td>
			</tr>
			</table>
			<div class="tj">
					<a id="btn2" class="calcu" onclick="OK()">计算 </a>
					<a id="btn" class="calcure" onclick="Clear()">重置</a>
					<a id="calorie"></a>				
			</div>
			<div id="jieguo">
				每公里所用的时间：
			</div>		
			<a class="appdownv" href="/down/indexwap.html"><img src="/Html/images/appdownv.jpg"></a>	
			</form>
		</div>
	</div>
</div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
<script language="javascript">

function Clear()
{
	document.getElementById("hours").value = "";
	document.getElementById("minutes").value = "";
	document.getElementById("seconds").value = "";
	document.getElementById("minutes2").value = "";
	document.getElementById("seconds2").value = "";
	document.getElementById("calorie").innerHTML = "";
}

function OK()
{
	var hours = document.getElementById("hours").value;
	var minutes = document.getElementById("minutes").value;
	var seconds = document.getElementById("seconds").value;
	var minutes2 = document.getElementById("minutes2").value;
	var seconds2 = document.getElementById("seconds2").value;
	
	document.getElementById("calorie").innerHTML = "";

	if(hours.length > 0 && minutes.length > 0 && seconds.length > 0)
	{
		var speed = parseInt(hours) * 3600 + parseInt(minutes) * 60 + parseInt(seconds);
		//alert(speed);
		$.get("/channels/tools/ajax/marathonpace.aspx", { seconds : speed, mode : 0 }, function(result) {
			document.getElementById("jieguo").innerHTML = result;
		});
		return;
	}

	if(minutes2.length > 0 && seconds2.length > 0)
	{
		var speed = parseInt(minutes2) * 60 + parseInt(seconds2);
		$.get("/channels/tools/ajax/marathonpace.aspx", { seconds : speed, mode : 1 }, function(result) {
			document.getElementById("jieguo").innerHTML = result;
		});
		return;
	}

	document.getElementById("calorie").innerHTML = "输入数据不够";
}

</script>
</body>
</html>
