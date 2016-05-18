<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Channels_Competetion_Default" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>跑步竞赛,城市-ERUN360.COM</title>
<meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
<meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
<script type="text/javascript" src="/Common/jWeibo.js"></script>
<script language="javascript" src="/Common/jQuery1.8.js"></script>
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jCalendar.js"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<style>
.nav li.h_js em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}
</style>
</head>
<body>
	<ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="evca">
<div class="indecen">
<div id="H1_L_0">
		<div class="bsrl">
			<style>			
				#cal_href_w { float:left;width:97px;height:33px;font-size:12px;color:#000000;line-height: 33px;color: #ff9b37 } 
				#cal_space { float:left;width:97px;height:80px;border-bottom:solid 1px #edeff1;font-size:12px;color:#FFFFFF; } 
				#cal_spacen { float:left;width:97px;height:80px;border-bottom:0;font-size:12px;color:#FFFFFF; } 
				#cal_href_h { float:left;width:97px;height:80px;border-bottom:solid 1px #edeff1;cursor:pointer;font-size:15px;color:#fff; line-height: 18px;background: url(/Html/images/href_h.png) no-repeat center top;} 
				#cal_href_n { float:left;width:97px;height:80px;border-bottom:solid 1px #edeff1;cursor:pointer;font-size:16px;color:#a4aeb9; line-height: 20px;} 
				#comp_icon_u { background: url(/Html/images/comp_icon_v.png);} 
				#comp_icon_m { background: url(/Html/images/comp_icon_m.png);} 
				#comp_icon_h { background: url(/Html/images/comp_icon_h.png);} 
				#comp_icon_r { background: url(/Html/images/comp_icon_r.png);} 
				#comp_icon_c { background: url(/Html/images/comp_icon_c.png);} 
				#comp_icon_t { background: url(/Html/images/comp_icon_t.png);} 
				#competInfos a { font-size:14px;color:#4C98CC; }
				#competInfos a:hover { font-size:14px;color:#FF6701; }
				.chaoguo{position: relative;background:url(/images/index/jiantou.png)  no-repeat right bottom}
				.chaoguo span{float:left;margin-left:3px;line-height:16px!important;}
				#cal_href_h span,#cal_href_n span,#competInfos span{height: 15px;display: inline-block;width: 15px;margin:4px 0 -2px 1px;overflow: hidden;}
				.chaoguo p{padding:7px 17px 7px 14px;border: 3px solid #b0b0b0;left: 37px;position: absolute; top: 25px;background:url(/images/index/jiantoux.png) no-repeat left top #fff;display: none;  width: 65px; z-index: 100;}
				.chaoguo:hover p{display:block}
				#cal_href_h em,#cal_href_n em{display:block;height:41px;line-height: 41px;}
				#competInfos #comp_join{width: 49px;height: 19px;background: url(/Html/images/jgz.png);margin-bottom: -3px;cursor: pointer;}
				#competInfos .comp_join{width: 49px;height: 19px;background: url(/Html/images/jgz.png);margin-bottom: -3px;cursor: pointer;}
				#competInfos .comp_ygz{width: 49px;height: 19px;background: url(/Html/images/tygz.png);margin-bottom: -3px;cursor: pointer;}
				#competInfos .comp_yjz{width: 49px;height: 19px;background: url(/Html/images/yjz.png);margin-bottom: -3px;cursor: pointer;}
				#competInfos .comp_lbm{width: 49px;height: 19px;background: url(/Html/images/lbm.png);margin-bottom: -3px;cursor: pointer;}
				#competInfos .comp_ybm{width: 49px;height: 19px;background: url(/Html/images/ybm.png);margin-bottom: -3px;cursor: pointer;}
				.todyno{font-size: 14px;}
			</style>
			<% =DateBuffer %>
			<script language="javascript" >
// $("td[valign='top']:first-child div:has(span)").each(function(){
// 	if($(this).children("span").length > 3){
// 		$(this).children("span:gt(1)").hide();		
// 		$(this).addClass("chaoguo").append("<p></p>"); 
// 		$(this).children("p").append($(this).children("span:gt(1)"));			
// 		$(this).mousemove(function(){
// 			$(".chaoguo P span").show();
			
// 		})
// 	}	
// })
			</script>
		</div>
		</div>	
</div>
    </div>
<div class="indecen">
	<div class="left">
		<div class="ht ht16">
			<a href="<% =UrlHelper.TopicsUrl(302111100) %>" class="httitle">国内赛事</a>
			<% =pf.Show(302111100) %>
		</div>
		<div class="ht ht16 htr">
			<a href="<% =UrlHelper.TopicsUrl(302112100) %>" class="httitle">国际赛事</a>
			<% =pf.Show(302112100) %>
		</div>
		<div class="ht ht16">
			<a href="<% =UrlHelper.TopicsUrl(302113100) %>" class="httitle">越野.超马</a>
			<% =pf.Show(302113100) %>
		</div>
		<div class="ht ht16 htr">
			<a href="<% =UrlHelper.TopicsUrl(302114100) %>" class="httitle">精彩赛记</a>
			<% =pf.Show(302114100) %>
		</div>		
	</div>
	<div class="right">
		<div class="rkuang wb">
                <div class="rkuangtitle">
                    <a href="/Channels/Competetion/RaceList.aspx"><span>赛事报名</span></a>
                </div>
                <div class="wbnr">
                    <ul id="slider" class="event">
                    </ul>
                    <script type="text/javascript">
                        $.get("/Utility/Ajax/NewEvent.aspx", { rnd : MinuteRand() }, function(result) {
                            document.getElementById("slider").innerHTML = result;
                            new slider({id:'slider'});
                        });
                    </script>
                </div>
            </div>
		<div class="rkuang wzph">
			<div class="rkuangtitle">赛事关注排行</div>
			<ul>
			<% =pf.Focus(302100100, 21) %>
			</ul>
		</div>		
	</div>
</div>
<div id="comp_join" style="display: none;"></div>
<script language="javascript">
function JoinCreate(user, idx)
{
	$.get("/Utility/Ajax/RaceJoinCreate.aspx", { onwer : user , id : idx }, function(result) {
		if(result == "OK") {
			document.getElementById("comp_join"+idx).outerHTML = "<span class=\"comp_ygz\"></span>";
		}
		else { alert(result); document.getElementById("comp_join").innerHTML = result; }
	});
}
function ComptOfDay(y,m,d)
{
	$.get("/Utility/Ajax/Competetion.aspx", { year : y , month : m, day : d }, function(result) {
		document.getElementById("competInfos").innerHTML = result;
	});
}
$(".moremoth").click(function() {
    $(".moremotha").toggle();
});
</script>
<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>