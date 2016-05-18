<%@ Page Language="C#" AutoEventWireup="true" CodeFile="c2_10_6.aspx.cs" Inherits="plan_c2_10_6" %><%@ Register Src="~/Controls/tHeader.ascx" TagPrefix="ERUN360" TagName="tHeader" %><%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title>训练计划-跑步装备-益跑网-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <meta property="wb:webmaster" content="a859eadcc5aee52a" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link href="/Common/index.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/plan.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<style>
</style>
<body>
<ERUN360:tHeader runat="server" id="tHeader" />
	<div class="plan">
<table cellspacing="0">
	<tr><th>日期</th><th>周一</th><th>周二</th><th>周三</th><th>周四</th><th>周五</th><th>周六</th><th>周日</th></tr>
	<tr><td>Week 1</td>
		<td>45 min GR</td>
		<td>10min LL<i class="dd0705">10X400m 休息: 200m</i>10min LL</td>
		<td>45 min GR</td>
		<td>15min LL<i class="ff6602">4*5min 休息: 3min</i>10min LL</td>
		<td>20 min GR</td>
		<td class="ffffff">休息</td>
		<td>30min GR<i class="fcf304">40min GE</i>20min GR</td>
	</tr>
	<tr><td>Week 2</td>
		<td>45 min GR</td>
		<td>1h15 GR <br>4*100m加速跑</td>
		<td>45 min GR</td>
		<td>45 min GR</td>
		<td class="ffffff">休息</td>
		<td class="ffffff">休息</td>
		<td>30min GR<i class="fcf304">50min GE</i>25min GR</td>
	</tr>
	<tr><td>Week 3</td>
		<td>45 min GR</td>
		<td>15min LL<i class="ff6602">3X8min 休息: 3min</i>10min LL</td>
		<td>45 min GR</td>
		<td>10min LL<i class="dd0705">5X800m 休息: 400m</i>10min LL</td>
		<td>20 min GR</td>
		<td class="ffffff">休息</td>
		<td>30min GR<i class="fcf304">1h GE</i>30min GR</td>
	</tr>
	<tr><td>Week 4</td>
		<td>45 min GR<br>4*100m加速跑</td>
		<td>90 min GR<br></td>
		<td class="ffffff">休息</td>
		<td>15min LL<i class="ff6602">4*7min 休息: 3min</i>10min LL</td>
		<td class="ffffff">休息</td>
		<td class="ffffff">休息</td>
		<td>2h30min <br>GR</td>
	</tr>
	<tr><td>Week 5</td>
		<td>45 min GR<br></td>
		<td>15min LL<i class="ff6602">3*12min 休息: 4min</i>10min LL</td>
		<td>1h GR</td>
		<td>15min LL<i class="dd0705">6X1000m 休息: 400m</i>10min LL</td>
		<td>20min GR</td>
		<td class="ffffff">休息</td>
		<td>50min GR<i class="fcf304">50min GE/10min OR</i>40min GR</td>
	</tr>
	<tr><td>Week 6</td>
		<td>30 min GR<br></td>
		<td>45 min GR<br>4*100m加速跑</td>
		<td class="ffffff">休息</td>
		<td>30 min GR<br></td>
		<td class="ffffff">休息</td>
		<td class="ffffff">休息</td>
		<td>20min LL <i class="ff6602">20min OR</i>20min LL</td>
	</tr>
	<tr><td>Week 7</td>
		<td>45 min GR<br></td>
		<td>15min LL<i class="dd0705">6X800m 休息: 200m</i>10min LL</td>
		<td>1h GR<br>4*100m加速跑</td>
		<td>15min LL<i class="ff9901">4X2000m 休息: 3min</i>10min LL</td>
		<td class="ffffff">休息</td>
		<td class="ffffff">休息</td>
		<td>60min GR <i class="fcf304">1h GE/10min OR</i>50min GR</td>
	</tr>
	<tr><td>Week 8</td>
		<td>45 min GR<br>4*100m加速跑</td>
		<td>75 min GR</td>
		<td>45 min GR</td>
		<td>15min LL<i class="dd0705">8X1000m 休息: 400m</i>10min LL</td>
		<td>20 min GR</td>
		<td class="ffffff">休息</td>
		<td>30min GR <i class="fcf304">1h GE/20min OR</i>30min GR</td>
	</tr>
	<tr><td>Week 9</td>
		<td>45 min GR<br></td>
		<td>15min LL<i class="ff9901">3*15min 休息: 4min</i>10min LL</td>
		<td>1h GR</td>
		<td>15min LL<i class="ff9901">4X4min 休息: 3min</i>10min LL</td>
		<td class="ffffff">休息</td>
		<td class="ffffff">休息</td>
		<td>45 min GR</td>
	</tr>
	<tr><td>Week 10</td>
		<td>45 min GR<br></td>
		<td>20 min GR<br></td>
		<td>20 min GR<br></td>
		<td class="ffffff">休息</td>
		<td>30 min <br>逐渐加速跑<br></td>
		<td class="ffffff">休息</td>
		<td class="fcf304">测试马拉松成功！</td>
	</tr>
</table>
	</div>
<div class="planExplain">
	附注
	<table cellspacing="0">
		<tr><th></th><th>对应颜色</th><th>速度</th><th>训练强度</th></tr>
		<tr class="gr"><td>GR</td><td>绿色</td><td>慢跑速度</td><td>60-70% 最大心跳</td></tr>
		<tr class="ge"><td>GE</td><td>浅黄色</td><td>中速慢跑速度</td><td>70-80% 最大心跳</td></tr>
		<tr class="or"><td>OR</td><td>橙色</td><td>中速跑速度</td><td>80-90%最大心跳</td></tr>
		<tr class="ro"><td>RO</td><td>红色</td><td>快跑速度</td><td>90-95% 最大心跳</td></tr>
	</table> <br>
	<p>LL: 自由跑；week:周；min:分；h:小时；km:千米； <br>
	休息: 放松的跑动 <br>
	完成耐力跑后，请立即进行100m加速跑训练冲刺能力 <br>
	在比赛前和后请做15分钟的放松训练 <br>
	训练计划表中的英文和颜色请对照附注，例如20min GR，即以最大心跳60%-70%的强度慢速跑20min。 </p>
</div>
<ERUN360:footer ID="footer" runat="server" />
</body>
</html>