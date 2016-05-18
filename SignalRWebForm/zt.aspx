<%@ Page Language="C#" AutoEventWireup="true" CodeFile="zt.aspx.cs" Inherits="_Home_Default" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="http://open.weibo.com/wb">
<head>
<title>益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
<meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
<meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
	<script language="javascript" src="/Common/jQuery1.8.js"></script>
<script type="text/javascript" src="/Common/jWeibo.js"></script>
	
<script language="javascript" src="/Common/jCheck.js?2012111"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<script language="javascript" src="/Common/jCalendar.js?2012111"></script>	
</head>
<body>

    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
	
<div class="indecen">	
	<div class="indexctop" style="margin-top: 20px;">
		<div class="left ztlist">
			<ul>
				<li>
					<p><a href="/zt/group/index.aspx">益跑拼团</a> <em>2014.11.19</em> </p>
					<a href="/zt/group/index.aspx"> <img src="/zt/images/pingtuan.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/polar/index.aspx">polar</a> <em>2014.10.8</em> </p>
					<a href="/zt/polar/index.aspx"> <img src="/zt/images/polar.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/womanRunningBook/index.aspx">《女子跑步全书》</a> <em>2014.9.26</em> </p>
					<a href="/zt/womanRunningBook/index.aspx"> <img src="/zt/images/nbook.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/inex/index.aspx">益跑网积分兑换中心惊喜上线</a> <em>2014.7.25</em> </p>
					<a href="/zt/inex/index.aspx"> <img src="/zt/images/jf.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/infocenter/feedback.aspx">益跑网“领跑者”积分大礼包派送</a> <em>2014.6.20</em> </p>
					<a href="/infocenter/feedback.aspx"> <img src="/zt/images/dalibao.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/fitbit/index.aspx">Fitbit</a> <em>2014.6.5</em> </p>
					<a href="/zt/fitbit/index.aspx"> <img src="/zt/images/fitbit1.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/tnf100/index.aspx">TNF100</a> <em>2014.5.15</em> </p>
					<a href="/zt/tnf100/index.aspx"> <img src="/zt/images/tnf100.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/runbook/index.aspx">《初级跑者全书》</a> <em>2013.12.30</em> </p>
					<a href="/zt/runbook/index.aspx"> <img src="/zt/images/runbook.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/nike/index.aspx">跑了就懂</a> <em>2013.11.10</em> </p>
					<a href="/zt/nike/index.aspx"> <img src="/zt/images/nike.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/lzmarathon/">2013兰州国际马拉松</a> <em>2013.6.10</em> </p>
					<a href="/zt/lzmarathon/"> <img src="/zt/images/lanzhou.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/ddmarathon/">2013年丹东国际马拉松赛</a> <em>2013.5.26</em> </p>
					<a href="/zt/ddmarathon/"> <img src="/zt/images/dandong.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/game/">比赛全攻略</a> <em>2013.5.16</em> </p>
					<a href="/zt/game/"> <img src="/zt/images/game.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/paobuji/">跑步机</a> <em>2013.4.22</em> </p>
					<a href="/zt/paobuji/"> <img src="/zt/images/paobuji.jpg" alt="" /> </a>
				</li>				
				<li>
					<p><a href="/zt/huxi/">跑步呼吸</a> <em>2013.4.15</em> </p>
					<a href="/zt/huxi/"> <img src="/zt/images/huxi.jpg" alt="" /> </a>
				</li>	
				<li>
					<p><a href="/zt/weixunlian/">微训练</a> <em>2013.4.8</em> </p>
					<a href="/zt/weixunlian/"> <img src="/zt/images/weixunlian.jpg" alt="" /> </a>
				</li>
				<li>
					<p><a href="/zt/nvxing/">女生经期健康运动</a> <em>2013.3.6</em> </p>
					<a href="/zt/nvxing/"> <img src="/zt/images/nvxing.jpg" alt="" /> </a>
				</li>				
				<li>
					<p><a href="/zt/jianfei/">跑步与减肥</a> <em>2013.2.6</em> </p>
					<a href="/zt/jianfei/"> <img src="/zt/images/jianfei.jpg" alt="" /> </a>
				</li>	
				<li>
					<p><a href="/zt/xigai/">跑步与膝盖</a> <em>2013.2.6</em> </p>
					<a href="/zt/xigai/"> <img src="/zt/images/xigai.jpg" alt="" /> </a>
				</li>								
				<li>
					<p><a href="/zt/hk100/">2013香港VibramHK100</a> <em>2013.1.19</em> </p>
					<a href="/zt/hk100/"> <img src="/zt/images/xg100.jpg" alt="" /> </a>
				</li>	
				<li>
					<p><a href="/zt/xmmarathon/">2013厦门国际马拉松</a> <em>2012.12.21</em> </p>
					<a href="/zt/xmmarathon/"> <img src="/zt/images/xm.jpg" alt="" /> </a>
				</li>				
				<li>
					<p><a href="/zt/zhengping/">跑爱无疆 坚强郑平</a> <em>2012.11.22</em> </p>
					<a href="/zt/zhengping/"> <img src="/zt/images/zp.jpg" alt="" /> </a>
				</li>
				<li >
					<p><a href="/zt/bjmarathon/">2012北京马拉松</a> <em>2012.11.20</em> </p>
					<a href="/zt/bjmarathon/"> <img src="/zt/images/bm.jpg" alt="" /> </a>
				</li>
			</ul>
<!-- 			<div class="page">
				<a href="" class="up"> < </a>
				<a href="" class="dq">1</a>
				<a href="">2</a>
				<a href="">3</a>
				<a href="">4</a>
				<a href="">5</a>
				<span>......</span>
				<a href="">20</a>
				<a href="">21</a>
				<a href="">22</a>
				<a href="" class="down"> > </a>
			</div> -->
		</div>
		<div class="right">
			
			


		<div class="rkuang wb">
                <div class="rkuangtitle">
                    <span><a href="/Channels/Competetion/RaceList.aspx">赛事报名</a></span>
                </div>
                <div class="wbnr">
                    <ul id="slider" class="event">
                    </ul>
                    <script type="text/javascript">
                        $.get("/Utility/Ajax/Weibo.aspx", { rnd : MinuteRand() }, function(result) {
                            document.getElementById("slider").innerHTML = result;
                            new slider({id:'slider'});
                        });
                    </script>
                </div>
            </div>

					
	</div>		
	</div>

	
</div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />







	

</body>
</html>
