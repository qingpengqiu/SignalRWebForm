<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Grade.aspx.cs" Inherits="_Channels_Tools_Grade" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>国家运动员等级</title>
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
<div id="H2_w" >
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
				<li><a href="Training.aspx">训练计算器</a></li>
				<li class="dq"><a href="Grade.aspx">国家运动员等级</a></li>
				<li><a href="BMR.aspx">基础代谢计算器</a></li>
				<li><a href="ShoeSize.aspx">鞋码对照表</a></li>
				<li><a href="Converter.aspx">公英制转换</a>	</li>
			</ul>	
			<script language="javascript" src="/common/jtools.js"></script>
		</div>
		<div id="cont">
			<span>国家运动员等级</span>
			<p>
			输入性别，年龄和成绩（5K，10K，半程马拉松，全程马拉松），给出等级，分业余和专业（专业不论年龄，也不含半程马拉松）
			</p>	
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
			<table id="tab" width="100">
			<tr>
				<td nowrap align="right">
					性别：
				</td>
				<td nowrap>
					<div class="radio1" id="gender_radio" name="gender_radio" value="male">男</div>
					<div class="radio2" id="gender_radio" name="gender_radio" value="female">女</div>
					<input type="hidden" id="gender" name="gender" value="male">
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					年龄：
				</td>
				<td nowrap>
					<input type="text" class="ik" id="age" name="age" size="3" maxlength="2" value="<% =PageAge %>">
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					跑了：
				</td>
				<td nowrap>
					<select id="style" name="style" class="ik" style="width:180px;">
					<option value="5km">5000米</option>
					<option value="10km">10000米</option>
					<option value="halfmarathon">半程马拉松</option>
					<option value="marathon">全程马拉松</option>
					</select>
				</td>
			</tr>
			<tr>
				<td nowrap align="right">
					用时：
				</td>
				<td nowrap>
					<% =GCommon.HMS("hours", 0, 24, 0) %> 时
					<% =GCommon.HMS("minutes", 0, 59, 0) %> 分
					<% =GCommon.HMS("seconds", 0, 59, 0) %> 秒
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
			</form>
		</div>
	</div>
</div>
<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
<script language="javascript">
function Clear()
{
	document.getElementById("age").value = "";
	document.getElementById("hours").value = "";
	document.getElementById("minutes").value = "";
	document.getElementById("seconds").value = "";
	document.getElementById("calorie").innerHTML = "";
}

function getElementsByName(name) 
{ 
	var returns = document.getElementsByName(name); 
	if(returns.length > 0) return returns; 
	returns = new Array(); 
	var e = document.getElementsByTagName("input"); 
	for(i = 0; i < e.length; i++) {
		if(e[i].getAttribute("name") == name) { 
			returns[returns.length] = e[i]; 
		} 
	} 
	return returns; 
}

function OK()
{
	//var gobj = getElementsByName("gender");
	//var gender = (gobj[0].checked) ? "male" : "female";
	var gender = document.getElementById("gender").value;
	var style = document.getElementById("style").options[document.getElementById("style").selectedIndex].value;
	var age = document.getElementById("age").value;
	var hours = document.getElementById("hours").value;
	var minutes = document.getElementById("minutes").value;
	var seconds = document.getElementById("seconds").value;
	
	document.getElementById("calorie").innerHTML = "";

	if(age.length > 0 && hours.length > 0 && minutes.length > 0 && seconds.length > 0)
	{
		var speed = parseInt(hours) * 3600 + parseInt(minutes) * 60 + parseInt(seconds);
		$.get("/channels/tools/ajax/grade.aspx", { gender : gender, style : style, age : age, seconds : speed }, function(result) {
			document.getElementById("jieguo").innerHTML = result;
		});
		return;
	}

	document.getElementById("calorie").innerHTML = "输入数据不够";
}

Bind();
</script>
</body>
</html>
