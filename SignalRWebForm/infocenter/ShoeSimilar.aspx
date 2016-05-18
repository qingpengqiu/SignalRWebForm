<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoeSimilar.aspx.cs" Inherits="infocenter_ShoeSimilar" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title>高级搜索-跑步装备-益跑网-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<style>
.nav li.h_zb em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}
</style>
<body>
     <form id="form1" runat="server">
<ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
		<div class="shoel">
			<div class="shoelt">
				<img src="/Html/images/shoe.png" alt="" />
				<span>跑步鞋</span>
				<a href="/infocenter/ShoeFind.aspx" >查找跑鞋</a>
				<a href="/infocenter/ShoeLike.aspx" class="shoed">同类搜索</a>
				<a href="">高级搜索</a>
			</div>
			<div class="shoefind shoesim">
				<div class="sftit">
                    回答这些问题，我们一定会找到适合你的鞋。            
                </div>
<table>
    <tr>
        <td class="idgender">
			<label for="idgender_0">性别</label>
       	</td>
       	<td>
       		<ul id="idgender">
			<li><input id="idgender_0" name="idgender" value="0" checked="checked" tabindex="2" type="radio"><label for="idgender_0">男</label></li>
			<li><input id="idgender_1" name="idgender" value="1" tabindex="2" type="radio"><label for="idgender_1">女</label></li>
			</ul>
       	</td>
    </tr>
    <tr>
    	<td>
    		<label for="height">身高</label>
    	</td>
    	<td>
    		<input type="text" tabindex="1" maxlength="16" id="height" name="height"><label for="height">厘米</label>
    	</td>
    </tr>
    <tr>
    	<td>
    		<label for="weight">体重</label>
    	</td>
    	<td>
    		<input type="text" tabindex="1" maxlength="16" id="weight" name="weight"><label for="weight">公斤</label>
    	</td>
    </tr>
    <tr>
    	<td><label for="ShoeType">鞋型</label></td>
    	<td>
    		<select name="ShoeType" id="ShoeType" tabindex="5">
			<option value="0">所有</option>
			<option value="1">公路</option>
			<option value="2">越野</option>
			</select>
		</td>
    </tr>
    <tr>
    	<td><label for="RunPer">跑步水平</label></td>
    	<td>
    		<select name="RunPer" id="RunPer" tabindex="5">
			<option value="0">1～10KM</option>
			<option value="1">10～15KM</option>
			<option value="2">15～35KM</option>
			<option value="3">35～50KM</option>
			<option value="4">超过50KM</option>
			</select>
		</td>
    </tr>
    <tr>
    	<td><label for="WeekMil">周跑量</label></td>
    	<td>
    		<select name="WeekMil" id="WeekMil" tabindex="5">
			<option value="0">所有</option>
			<option value="1">公路</option>
			<option value="2">越野</option>
			</select>
		</td>
    </tr>
    <tr>
    	<td><label for="PaceMin">平均配速</label></td>
    	<td><input type="text" tabindex="1" maxlength="16" id="PaceMin" name="PaceMin"><label for="PaceMin">分</label><input type="text" tabindex="1" maxlength="16" id="PaceSec" name="PaceSec"><label for="PaceSec">秒</label></td>
    </tr>
    <tr>
    	<td><label for="bruise">近一年是否有受伤</label></td>
    	<td>
    		<select name="bruise" id="bruise" tabindex="5">
			<option value="0">没有</option>
			<option value="1">轻伤</option>
			<option value="2">严重伤</option>
			</select>
		</td>
    </tr>
    <tr id="Arch">
        <td >
			<label for="ArchL">足弓形态</label>
       	</td>
       	<td>
       		<ul >
			<li><input id="ArchL" name="Arch" value="0" checked="checked" tabindex="2" type="radio"><label for="ArchL">低<br /><img src="/Html/images/Arch1.png" alt="" /></label></li>
			<li><input id="ArchM" name="Arch" value="1" tabindex="2" type="radio"><label for="ArchM">中等<br /><img src="/Html/images/Arch2.png" alt="" /></label></li>
			<li><input id="ArchH" name="Arch" value="1" tabindex="2" type="radio"><label for="ArchH">高<br /><img src="/Html/images/Arch3.png" alt="" /></label></li>
			<li><input id="ArchN" name="Arch" value="1" tabindex="2" type="radio"><label for="ArchN">不清楚</label></li>
			</ul>
       	</td>
    </tr>
    <tr id="Double">
        <td >
			<label for="DoubleI">内外翻</label>
       	</td>
       	<td>
       		<ul >
			<li><input id="DoubleI" name="Double" value="0" checked="checked" tabindex="2" type="radio"><label for="DoubleI"><span>内翻 (左脚)</span><br /><br /><img src="/Html/images/Double1.png" alt="" /><br />脚不卷，卷或向外。你推离主要从外面的脚小脚趾。</label></li>
			<li><input id="DoubleZ" name="Double" value="1" tabindex="2" type="radio"><label for="DoubleZ"><span>正常 (左脚)</span><br /><br /><img src="/Html/images/Double2.png" alt="" /><br />足辊稍。你推均匀地从脚的前部。</label></li>
			<li><input id="DoubleO" name="Double" value="1" tabindex="2" type="radio"><label for="DoubleO"><span>外翻 (左脚)</span><br /><br /><img src="/Html/images/Double3.png" alt="" /><br />足辊向内显着。你推离主要从对脚内的大脚趾。</label></li>
			<li><input id="DoubleN" name="Double" value="1" tabindex="2" type="radio"><label for="DoubleN"><span>不清楚</span></label></li>
			</ul>
       	</td>
    </tr>
    <tr id="Feet">
        <td >
			<label for="Feet1">着地位置</label>
       	</td>
       	<td>
       		<ul >
			<li><input id="Feet1" name="Feet" value="0" checked="checked" tabindex="2" type="radio"><label for="Feet1">前脚掌<br /><br /><img src="/Html/images/Feet1.png" alt="" /></label></li>
			<li><input id="Feet2" name="Feet" value="1" tabindex="2" type="radio"><label for="Feet2">全脚掌<br /><br /><img src="/Html/images/Feet2.png" alt="" /></label></li>
			<li><input id="Feet3" name="Feet" value="1" tabindex="2" type="radio"><label for="Feet3">脚跟<br /><br /><img src="/Html/images/Feet3.png" alt="" /></label></li>
			<li><input id="Feet4" name="Feet" value="1" tabindex="2" type="radio"><label for="Feet4">极端脚跟<br /><br /><img src="/Html/images/Feet4.png" alt="" /></label></li>
			</ul>
       	</td>
    </tr>
</table>
<div class="findshoe">开始查找</div>
			</div>
		</div>
        <div class="shoer">
          <a target="_blank" href="/zt/runbook/index.aspx"><img width="300" height="300" border="0" alt="初级跑者全书" title="初级跑者全书" src="http://www.erun360.com/adm/ad300.jpg"></a>
                <a target="_blank" href="/blog/200014474.aspx"><img width="300" height="300" border="0" alt="2014年The North Face 100北京国际越野挑战赛暨市民徒步大会" title="初级跑者全书" src="/Html/images/shoetnf.png"></a>
        </div>
    </div>
<script>
$(".findshoe").click(function(event) {
var xb = $("input[name='idgender']:checked").val(),
    qjzhc = $("#HeelCushioning").val(),
    zzs   = $("#Manufacturer").val(),
    lhx   = $("#Flexibility").val(),
    mz    = $("#shoename").val()?$("#shoename").val():"",
    qhgc  = $("#HeelToe").val(),
    xx    = $("#ShoeType").val(),
    wdx   = $("#StabilityFeatures").val(),
    jg    = $("#Price").val(),
    zl    = $("#Weight").val(),
    zghc  = $("#footCushioning").val(),
    gd    = $("#Profile").val()

location.href = "/infocenter/ShoeResult.aspx?xb="+xb+"&qjzhc="+qjzhc+"&zzs="+zzs+"&lhx="+lhx+"&mz="+mz+"&qhgc="+qhgc+"&xx="+xx+"&wdx="+wdx+"&jg="+jg+"&zl="+zl+"&zghc="+zghc+"&gd="+gd+"&m=Seach&p=1"

});

</script>

    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
         </form>
</body>
</html>