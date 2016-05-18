<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Training.aspx.cs" Inherits="_Channels_Tools_Training" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>训练计算器（Training Calculator）</title>
<meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
<meta name="keywords" content="2013厦门国际马拉松,厦马,兔子军团,初马指南,跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta name="distribution" content="global" />
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
<link href="/Common/tools.css" rel="stylesheet" type="text/css"/>
<script language="javascript" src="/Common/jQuery.js?2012111"></script>
<script language="javascript" src="/Common/jCheck.js?2012111"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<script language="javascript" src="/Common/jCalendar.js?2012111"></script>	
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
<!--第二段-->
<div id="H2_w">
	<div id="cal_main">
		<div id="guide">
			<ul>
				<li><a href="PaceCalculator.aspx">配速计算器（Pace Calculator）</a></li>
				<li><a href="PaceConverter.aspx">配速转换器（Pace Converter）</a></li>
				<li><a href="FinishTime.aspx">完跑计算器（Finish Time）</a></li>
				<li><a href="MarathonPace.aspx">马拉松配速指南<em>（Marathon Pace）</em></a></li>
				<li><a href="AgeGrade.aspx">年龄等级计算器（Age-graded）</a></li>
				<li><a href="BMI.aspx">BMI体重指数计算器</a></li>
				<li><a href="Calorie.aspx">卡路里计算器（Calorie）</a></li>
				<li class="dq"><a href="Training.aspx">训练计算器</a></li>
				<li><a href="Grade.aspx">国家运动员等级</a></li>
				<li><a href="BMR.aspx">基础代谢计算器</a></li>
				<li><a href="ShoeSize.aspx">鞋码对照表</a></li>
				<li><a href="Converter.aspx">公英制转换</a>	</li>
			</ul>			
			<script language="javascript" src="/common/jtools.js"></script>	
		</div>
		<div id="cont">
			<span>训练计算器<em>（Training Calculator）</em></span>
			<p>
			
			</p>	
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
			<table id="tab" width="100" autocomplete="off">
			<tr>
				<td nowrap align="right">
					最新的跑步距离：
				</td>
				<td nowrap>
					<input type="text" class="ik" id="distance" name="distance" size="3" value=""> 公里
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					最新的跑步用时：
				</td>
				<td nowrap>
					<% =GCommon.HMS("hours", 0, 24, 0) %> 时
					<% =GCommon.HMS("minutes", 0, 59, 0) %> 分
					<% =GCommon.HMS("seconds", 0, 59, 0) %> 秒
				</td>
			</tr>
			<tr>
				<td nowrap>
				</td>
				<td id="calorie" nowrap>
				</td>
			</tr>
			</table>
			<div class="tj">
					<a id="btn2" class="calcu" onclick="OK()">计算 </a>
					<a id="btn" class="calcure" onclick="Clear()">重置</a>
					<a id="calorie"></a>				
			</div>
			<div id="jieguo">
				预计用时：
					<table id="tab2" width="482" border="1" bordercolor="#CCCCCC" cellpadding="0" cellspacing="0">
					<tr class="title">
						<td colspan="2">用时</td>
						<td colspan="2">配速</td>
					</tr>
					<tr>
						<td width="25%">1.5 Km</td>
						<td width="25%"id="s1">&nbsp;</td>
						<td width="25%"id="p1">&nbsp;</td>
						<td width="25%">公里/分</td>
					</tr>
					<tr>
						<td>3 Km</td>
						<td id="s2">&nbsp;</td>
						<td id="p2">&nbsp;</td>
						<td>公里/小时</td>
					</tr>
					<tr>
						<td>5 Km</td>
						<td id="s3">&nbsp;</td>
						<td id="p3">&nbsp;</td>
						<td>米/秒</td>
					</tr>
					<tr>
						<td>10 Km</td>
						<td id="s4">&nbsp;</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>半程马拉松</td>
						<td id="s5">&nbsp;</td>
						<td></td>
						<td></td>
					</tr>
					<tr>
						<td>全程马拉松</td>
						<td id="s6">&nbsp;</td>
						<td></td>
						<td></td>
					</tr>
					</table>							
			</div>					
			</form>
		</div>
	</div>

	<div style="h_clear"></div>
</div>

<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />

<script language="javascript">

function Clear()
{
	document.getElementById("distance").value = "";
	document.getElementById("hours").value = "";
	document.getElementById("minutes").value = "";
	document.getElementById("seconds").value = "";
	document.getElementById("calorie").innerHTML = "";
}

function OK()
{
	var distance = document.getElementById("distance").value;
	var hours = document.getElementById("hours").value;
	var minutes = document.getElementById("minutes").value;
	var seconds = document.getElementById("seconds").value;

	document.getElementById("calorie").innerHTML = "";

	if(distance.length > 0 && hours.length > 0 && minutes.length > 0 && seconds.length > 0)
	{
		// 计算每公里的速度
		var speed = parseFloat(hours) * 60.0 + parseFloat(minutes) + parseFloat(seconds) / 60.0;
		//var speed2 = speed;
		//speed = speed / parseFloat(distance);

		//T2 = T1 x (D2/D1)^1.06;
		// speed = Math.pow(, 1.06);
		document.getElementById("s1").innerHTML = MinuteToHMS(speed * Math.pow(1.5 / parseFloat(distance), 1.06));
		document.getElementById("s2").innerHTML = MinuteToHMS(speed * Math.pow(3.0 / parseFloat(distance), 1.06));
		document.getElementById("s3").innerHTML = MinuteToHMS(speed * Math.pow(5.0 / parseFloat(distance), 1.06));
		document.getElementById("s4").innerHTML = MinuteToHMS(speed * Math.pow(10.0 / parseFloat(distance), 1.06));
		document.getElementById("s5").innerHTML = MinuteToHMS(speed * Math.pow(21.1 / parseFloat(distance), 1.06));
		document.getElementById("s6").innerHTML = MinuteToHMS(speed * Math.pow(42.195 / parseFloat(distance), 1.06));

		speed = speed / parseFloat(distance);
		document.getElementById("p1").innerHTML = (1.0/speed).toFixed(2);
		document.getElementById("p2").innerHTML = (60.0/speed).toFixed(2);
		document.getElementById("p3").innerHTML = (1000.0/speed/60.0).toFixed(2);
		return;
	}

	document.getElementById("calorie").innerHTML = "输入数据不够";
}

function I2(v)
{
	return (v<10) ? "0" + v : v;
}

function MinuteToHMS(atime)
{
	var hours = Math.floor(atime / 60.0);
	var minutes = Math.floor(atime - hours * 60.0);
	var seconds = Math.floor((atime - hours * 60.0 - minutes) * 60.0)
	return I2(hours) + ":" + I2(minutes) + ":" + I2(seconds);
}

</script>

</center>
</body>
</html>
