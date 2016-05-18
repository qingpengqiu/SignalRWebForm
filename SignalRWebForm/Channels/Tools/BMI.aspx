<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BMI.aspx.cs" Inherits="_Channels_Tools_BMI" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>BMI体重指数计算器（Body Mass Index Calculator）</title>
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
<div id="H2_w">
	<div id="cal_main">
		<div id="guide">
			<ul>
				<li><a href="PaceCalculator.aspx">配速计算器<i>（Pace Calculator）</i></a></li>
				<li><a href="PaceConverter.aspx">配速转换器（Pace Converter）</a></li>
				<li><a href="FinishTime.aspx">完跑计算器（Finish Time）</a></li>
				<li><a href="MarathonPace.aspx">马拉松配速指南<em>（Marathon Pace）</em></a></li>
				<li><a href="AgeGrade.aspx">年龄等级计算器（Age-graded）</a></li>
				<li class="dq"><a href="BMI.aspx">BMI体重指数计算器</a></li>
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
			<span>BMI体重指数计算器<em>（Body Mass Index Calculator）</em></span>
			<p>
			输入体重（公斤）、身高（厘米），计算BMI=体重（公斤）/身高（米）平方<br>
			75KM 175CM BMI=75/1.75×1.75=24.49<br>
			偏轻（低于18.5）、正常（18.5-24.9）、偏重（25-29.9）、肥胖（30及以上）
			</p>
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
			<table id="tab" width="300">
			<tr>
				<td nowrap align="right">
					身高：
				</td>
				<td nowrap>
					<input type="text" class="ik" id="height" name="height" size="3" value="<% =PageHeight %>"> 厘米
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					体重：
				</td>
				<td nowrap>
					<input type="text" class="ik" id="weight" name="weight" size="3" value="<% =PageWeight %>"> 公斤
				</td>
			</tr>
			</table>
			<div class="tj">
					<a id="btn2" class="calcu" onclick="OK()">计算 </a>
					<a id="btn" class="calcure" onclick="Clear()">重置</a>
					<a id="calorie"></a>				
			</div>
			<div id="jieguo">
			</div>
			<a class="appdownv" href="/down/indexwap.html"><img src="/Html/images/appdownv.jpg"></a>				
			</form>
		</div>
	</div>

	<div style="h_clear"></div>
</div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
<script language="javascript">

function Clear()
{
	document.getElementById("height").value = "";
	document.getElementById("weight").value = "";
	document.getElementById("calorie").innerHTML = "";
}

function OK()
{
	if(document.getElementById("height").value.length > 0 && document.getElementById("weight").value.length > 0)
	{
		var dist = parseInt(document.getElementById("height").value);
		var wght = parseInt(document.getElementById("weight").value);

		var fac = wght / ((dist / 100.0)*(dist / 100.0));

		var fst = "";
		if(fac<18.5) fst = "偏轻";
		if(fac>=18.5 && fac<25) fst = "正常";
		if(fac>=25 && fac<30) fst = "偏重";
		if(fac>=30) fst = "肥胖";

		document.getElementById("jieguo").innerHTML = "您的体重指数为 " + fac.toFixed(2) + " 属于：" + fst;
	}
	else
	{
		document.getElementById("calorie").innerHTML = "数据错误";
	}
}

</script>
</body>
</html>
