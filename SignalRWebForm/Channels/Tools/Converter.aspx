<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Converter.aspx.cs" Inherits="_Channels_Tools_Converter" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>公英制转换</title>
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
				<li><a href="Grade.aspx">国家运动员等级</a></li>
				<li><a href="BMR.aspx">基础代谢计算器</a></li>
				<li><a href="ShoeSize.aspx">鞋码对照表</a></li>
				<li class="dq"><a href="Converter.aspx">公英制转换</a>	</li>
			</ul>	
			<script language="javascript" src="/common/jtools.js"></script>	
		</div>
		<div id="cont">
			<span>公英制转换</span>			
			<form id="form1" name="form1" action="" method="post" autocomplete="off">
				<ul>
					<li>
						<span id="btn" onclick="Clear1()"><img src="/Images/index/chz.png" alt="" /></span>
						<input type="text" class="ik" id="mile" name="mile" size="3" value=""> 英里
						<span id="btn2" onclick="OK1()"><img src="/Images/index/dhao.png" alt="" /></span>
						<input type="text" class="ik" id="km" name="km" size="3" value=""> 公里
						
					</li>
					<li>
						<span id="btn" onclick="Clear2()"><img src="/Images/index/chz.png" alt="" /></span>
						<input type="text" class="ik" id="foot" name="foot" size="3" value=""> 英寸
						<span id="btn2" onclick="OK2()"><img src="/Images/index/dhao.png" alt="" /></span>
						<input type="text" class="ik" id="cm2" name="cm2" size="3" value=""> 厘米
						
					</li>
					<li>
						<span id="btn" onclick="Clear3()"><img src="/Images/index/chz.png" alt="" /></span>
						<input type="text" class="ik" id="inch" name="inch" size="3" value=""> 英尺
						<span id="btn2" onclick="OK3()"><img src="/Images/index/dhao.png" alt="" /></span>
						<input type="text" class="ik" id="cm3" name="cm3" size="3" value=""> 厘米
						
					</li>
					<li>
						<span id="btn" onclick="Clear4()"><img src="/Images/index/chz.png" alt="" /></span>
						<input type="text" class="ik" id="pound" name="pound" size="3" value=""> 英磅
						<span id="btn2" onclick="OK4()"><img src="/Images/index/dhao.png" alt="" /></span>
						<input type="text" class="ik" id="kg" name="kg" size="3" value=""> 公斤
						
					</li>
					<li>
						<span id="btn" onclick="Clear5()"><img src="/Images/index/chz.png" alt="" /></span>
						<input type="text" class="ik" id="oz" name="oz" size="3" value=""> 盎司
						<span id="btn2" onclick="OK5()"><img src="/Images/index/dhao.png" alt="" /></span>
						<input type="text" class="ik" id="g" name="g" size="3" value=""> 克
						
					</li>
					<li>
						<span id="btn" onclick="Clear6()"><img src="/Images/index/chz.png" alt="" /></span>
						<input type="text" class="ik" id="clm" name="clm" size="3" value=""> 加仑 
						<span id="btn2" onclick="OK6()"><img src="/Images/index/dhao.png" alt="" /></span>
						<input type="text" class="ik" id="sh" name="sh" size="3" value=""> 升
						
					</li>
				</ul>
			</form>
		</div>
	</div>
</div>

<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />

<script language="javascript">

function Clear1()
{
	document.getElementById("mile").value = "";
	document.getElementById("km").value = "";
}

function OK1()
{
	if(document.getElementById("mile").value != "")
	{
		document.getElementById("km").value = (parseFloat(document.getElementById("mile").value) * 1.609).toFixed(2);
		return;
	}

	if(document.getElementById("km").value != "")
	{
		document.getElementById("mile").value = (parseFloat(document.getElementById("km").value) / 1.609).toFixed(2);
		return;
	}
}

function Clear2()
{
	document.getElementById("foot").value = "";
	document.getElementById("cm2").value = "";
}

function OK2()
{
	if(document.getElementById("foot").value != "")
	{
		document.getElementById("cm2").value = (parseFloat(document.getElementById("foot").value) * 2.54).toFixed(2);
		return;
	}

	if(document.getElementById("cm2").value != "")
	{
		document.getElementById("foot").value = (parseFloat(document.getElementById("cm2").value) / 2.54).toFixed(2);
		return;
	}
}

function Clear3()
{
	document.getElementById("inch").value = "";
	document.getElementById("cm3").value = "";
}

function OK3()
{
	if(document.getElementById("inch").value != "")
	{
		document.getElementById("cm3").value = (parseFloat(document.getElementById("inch").value) * 2.54 * 12.0).toFixed(2);
		return;
	}

	if(document.getElementById("cm3").value != "")
	{
		document.getElementById("inch").value = (parseFloat(document.getElementById("cm3").value) / 2.54 / 12.0).toFixed(2);
		return;
	}
}

function Clear4()
{
	document.getElementById("pound").value = "";
	document.getElementById("kg").value = "";
}

function OK4()
{
	if(document.getElementById("pound").value != "")
	{
		document.getElementById("kg").value = (parseFloat(document.getElementById("pound").value) * 0.45359237).toFixed(2);
		return;
	}

	if(document.getElementById("kg").value != "")
	{
		document.getElementById("pound").value = (parseFloat(document.getElementById("kg").value) / 0.45359237).toFixed(2);
		return;
	}
}


function Clear5()
{
	document.getElementById("oz").value = "";
	document.getElementById("g").value = "";
}

function OK5()
{
	if(document.getElementById("oz").value != "")
	{
		document.getElementById("g").value = (parseFloat(document.getElementById("oz").value) * 28.349523125).toFixed(2);
		return;
	}

	if(document.getElementById("g").value != "")
	{
		document.getElementById("oz").value = (parseFloat(document.getElementById("g").value) / 28.349523125).toFixed(2);
		return;
	}
}

function Clear6()
{
	document.getElementById("clm").value = "";
	document.getElementById("sh").value = "";
}

function OK6()
{
	if(document.getElementById("clm").value != "")
	{
		document.getElementById("sh").value = (parseFloat(document.getElementById("clm").value) * 3.785411784).toFixed(2);
		return;
	}

	if(document.getElementById("sh").value != "")
	{
		document.getElementById("clm").value = (parseFloat(document.getElementById("sh").value) / 3.785411784).toFixed(2);
		return;
	}
}
</script>
</body>
</html>
