<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoeSize.aspx.cs" Inherits="_Channels_Tools_ShoeSize" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>鞋码对照表</title>
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
				<li><a href="Training.aspx">训练计算器</a></li>
				<li><a href="Grade.aspx">国家运动员等级</a></li>
				<li><a href="BMR.aspx">基础代谢计算器</a></li>
				<li class="dq"><a href="ShoeSize.aspx">鞋码对照表</a></li>
				<li><a href="Converter.aspx">公英制转换</a>	</li>
			</ul>			
			<script language="javascript" src="/common/jtools.js"></script>	
		</div>
		<div id="cont">
			<span>鞋码对照表</span>
			<p>
			</p>	
			<div id="jieguo">											
			男鞋：<br>
			<table id="tab" width="100%" border="1" bordercolor="#CCCCCC" cellpadding="0" cellspacing="0">
			<tr><td>US Men's</td><td>6.0</td><td>6.5</td><td>7.0</td><td>7.5</td><td>8.0</td><td>8.5</td><td>9.0</td><td>9.5</td><td>10.0</td></tr>
			<tr><td>英码(UK)</td><td>5.5</td><td>6.0</td><td>6.5</td><td>7.0</td><td>7.5</td><td>8.0</td><td>8.5</td><td>9.0</td><td>9.5</td></tr>
			<tr><td>欧洲码(EU、FR)</td><td>38 2/3</td><td>39 1/3</td><td>40</td><td>40 2/3</td><td>41 1/3</td><td>42</td><td>42 2/3</td><td>43 1/3</td><td>44</td></tr>
			<tr><td>日本鞋码（JP）</td><td>240</td><td>245</td><td>250</td><td>255</td><td>260</td><td>265</td><td>270</td><td>275</td><td>280</td></tr>
			<tr><td>中国大陆新鞋码</td><td>38</td><td>39</td><td>40</td><td>41</td><td>42</td><td>43</td><td>44</td><td>45</td><td>46</td></tr>
			</table>
			女鞋：<br>
			<table id="tab" width="100%" border="1" bordercolor="#CCCCCC" cellpadding="0" cellspacing="0">
			<tr><td>US Women's</td><td>5.0</td><td>5.5</td><td>6.0</td><td>6.5</td><td>7.0</td><td>7.5</td><td>8.0</td><td>8.5</td><td>9.0</td></tr>
			<tr><td>英码(UK)</td><td>4.0</td><td>4.5</td><td>5.0</td><td>5.5</td><td>6.0</td><td>6.5</td><td>7.0</td><td>7.5</td><td>8.0</td></tr>
			<tr><td>欧洲码(EU、FR)</td><td>36</td><td>36 2/3</td><td>37 1/3</td><td>38</td><td>38 2/3</td><td>39 1/3</td><td>40</td><td>40 2/3</td><td>41 1/3</td></tr>
			<tr><td>日本鞋码（JP）</td><td>220</td><td>225</td><td>230</td><td>235</td><td>240</td><td>245</td><td>250</td><td>255</td><td>260</td></tr>
			<tr><td>中国大陆新鞋码</td><td>34</td><td>35</td><td>36</td><td>37</td><td>38</td><td>39</td><td>40</td><td>41</td><td>42</tr>
			</table>
			</div>			
		</div>
	</div>
</div>
<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
