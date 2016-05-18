<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoeLike.aspx.cs" Inherits="infocenter_ShoeLike" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title>同类搜索-跑步装备-益跑网-ERUN360.COM</title>
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
			<div class="shoefind">
				<div class="sftit">
                    告诉我们你喜欢鞋子什么的，我们会发现其他相似的是。如果你要找的是鞋不在此列，请尝试使用鞋搜索。            
                </div>
<table>
    <tr>
        <td class="idgender">
<span>
    <label for="idgender_0">性别</label>
</span>
<em><ul id="idgender">
<li><input id="idgender_0" name="idgender" value="0" checked="checked" tabindex="2" type="radio"><label for="idgender_0">男</label></li>
<li><input id="idgender_1" name="idgender" value="1" tabindex="2" type="radio"><label for="idgender_1">女</label></li>
</ul></em>
       	</td>
    </tr>
    <tr>
        <td>
<span>
<label for="Manufacturer">制造商</label>
</span>
<em>
<select name="Manufacturer" id="Manufacturer" tabindex="5">
    <option value="0">所有</option>
    <option value="Adidas">Adidas</option>
	<option value="Aetrex">Aetrex</option>
	<option value="Altra">Altra</option>
	<option value="Anatom">Anatom</option>
	<option value="Asics">Asics</option>
	<option value="Brooks">Brooks</option>
	<option value="Columbia">Columbia</option>
	<option value="Ecco">Ecco</option>
	<option value="Etonic">Etonic</option>
	<option value="Hoka One One">Hoka One One</option>
	<option value="Icebug">Icebug</option>
	<option value="Inov-8">Inov-8</option>
	<option value="Kalenji">Kalenji</option>
	<option value="Karhu">Karhu</option>
	<option value="K-Swiss">K-Swiss</option>
	<option value="La Sportiva">La Sportiva</option>
	<option value="Merrell">Merrell</option>
	<option value="Mizuno">Mizuno</option>
	<option value="Montrail">Montrail</option>
	<option value="New Balance">New Balance</option>
	<option value="Newton">Newton</option>
	<option value="Nike">Nike</option>
	<option value="On">On</option>
	<option value="Patagonia">Patagonia</option>
	<option value="Pearl Izumi">Pearl Izumi</option>
	<option value="Puma">Puma</option>
	<option value="Reebok">Reebok</option>
	<option value="Salomon">Salomon</option>
	<option value="Saucony">Saucony</option>
	<option value="Scarpa">Scarpa</option>
	<option value="Scott">Scott</option>
	<option value="Skechers">Skechers</option>
	<option value="Skora">Skora</option>
	<option value="Speedo">Speedo</option>
	<option value="Spira">Spira</option>
	<option value="Tecnica">Tecnica</option>
	<option value="Terra Plana">Terra Plana</option>
	<option value="Teva">Teva</option>
	<option value="The North Face">The North Face</option>
	<option value="Topo Athletic">Topo Athletic</option>
	<option value="Treksta">Treksta</option>
	<option value="Under Armour">Under Armour</option>
	<option value="Vibram">Vibram</option>
	<option value="Vivobarefoot">Vivobarefoot</option>
	<option value="Zoot">Zoot</option>
</select></em></td>
    </tr>
    <tr>
        <td>
<span>
<label for="ShoeType">鞋型</label>
</span>
<em>
<select name="ShoeType" id="ShoeType" tabindex="5">
<option value="0">所有</option>
<option value="1">公路</option>
<option value="2">越野</option>
</select>
</em>            
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