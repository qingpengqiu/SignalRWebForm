<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Plaza.aspx.cs" Inherits="infocenter_Plaza" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title>跑者广场-益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <script type="text/javascript" src="/Common/jQuery1.8.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="../Html/js/jquery.emotions.js"></script>
    <style type="text/css">
        .nav li.h_gc em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}
    </style>
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
    	<div class="plazal">
    		<div class="npblog">
    			<div class="pltit">
    				最新博文
    			</div>
    			<ul class="plazall">
                    <%=strBolg %>
    				<%--<li>
    					<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>马拉松Sean :</span> </a>
    					<a href="">《倾其所有》一名马拉松运动员、一位真正男人的不朽遗赠</a>
    				</li>--%>
    			</ul>
    		</div>
    		<div class="nppl">
    			<div class="pltit">
    				最新评论
    			</div>
    			<ul class="plazall">
                     <%=strDiscuss %>
    				<%--<li>
    					<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>马拉松Sean </span> </a>评论了:
    					<a href="">《倾其所有》一名马拉松运动员、一位真正男人的不朽遗赠</a>
    				</li>--%>
    			</ul>
    		</div>
    		<div class="nprun">
    			<div class="pltit">
    				最新跑量
    			</div>
    			<ul class="plazall">
                     <%=strAmount %>
    				<%--<li>
    					<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>马拉松Sean :</span> </a>跑了 <span>5KM</span> <br>
    					地点：奥林匹克森林公园
    				</li>--%>
    			</ul>
    		</div>
    		<div class="npyp">
    			<div class="pltit">
    				最新约跑
    			</div>
    			<ul class="plazall">
                     <%=strRace %>
    				<%--<li>
    					<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>马拉松Sean :</span> </a>12月5日 9:00 
    					<a href="">奥森南园 LSD 20KM约跑</a>
    				</li>--%>
    			</ul>
    		</div>
    	</div>
    	<div class="plazar">
    		<div class="prtit">
    			他们刚刚加入益跑
    		</div>
    		<ul class="pljion">
                <%=strUser %>
    			<%--<li><a href=""><img src="/Html/images/cAvatar.png" alt="">马拉松Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">马拉松Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">马拉松Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">马拉松Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">马拉松Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">马拉松Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">马拉松Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">马拉松Sean</a></li>
    			<li><a href=""><img src="/Html/images/cAvatar.png" alt="">马拉松Sean</a></li>--%>
    		</ul>
    		<div class="prtit">
    			推荐博文
    		</div>
    		<ul class="plazall">
                <%=strIssue %>
    				<%--<li>
    					<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>马拉松Sean :</span> </a>
    					<a href="">《倾其所有》一名马拉松运动员、一位真正男人的不朽遗赠</a>
    				</li>
    				<li>
    					<a href=""><img src="/Html/images/cAvatar.png" alt=""><span>马拉松Sean :</span> </a>
    					<a href="">《倾其所有》一名马拉松运动员、一位真正男人的不朽遗赠</a>
    				</li>--%>
    			</ul>
    	</div>
    </div>
    <script>
$('.nppl').emotions();
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>