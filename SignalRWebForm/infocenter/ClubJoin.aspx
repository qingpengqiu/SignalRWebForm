<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClubJoin.aspx.cs" Inherits="infocenter_ClubJoin" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title>我加入的俱乐部-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Common/jWeibo.js"></script>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
    <script  type="text/javascript" src="../Html/js/jquery.blockUI.js"></script>
    <style type="text/css">
       .scleft{width: 725px;float: left;}
       .scright{width: 230px;float: right;border: 1px solid #e4e4e4;margin-bottom: 20px;}
       .slbox{border: 1px solid #ffe8c3;background: #fffaf3;height: 53px;font-size: 14px;color: #333;padding: 24px 0 0 0 }
       #idCity,#cCityname{display: none;}
       .slbox{margin-bottom: 10px;overflow: hidden;}
       .slbox label{display: inline-block;margin-left: 20px;margin-right: 4px;}
       .slbox input{width: 122px;margin-bottom: 6px;}
       .slbox select{width: 98px;margin-bottom: 6px;}
       .sltitle{line-height: 47px;height: 47px;font-size: 16px;color: #ff7800;font-weight: bold;background: url(/Html/images/oright.png) no-repeat 10px 16px  #f5f5f5;}
       .clubox li{width: 329px;height: 133px;float: left;border: 1px solid #e4e4e4;margin:9px 14px 8px 0; padding: 12px;font-size: 12px;color: #666;line-height: 24px;}
       .clubox li:nth-child(even){margin-right: 0;}
       .clubox li img{width: 50px;border: 1px solid #cecece;float: left;margin-right: 15px;}
       .clubox li a{font-size: 15px;color: #2874c1;font-weight: bold;line-height: 26px;}
       .clubox li p{line-height: 21px;padding-top: 10px;}
       .scrightt{height: 34px;background: #d9e3e7;margin: 0 -1px;font-size: 14px;color: #2874c1;font-weight: bold;line-height: 36px;}
       .scrul {padding: 0 11px;overflow: hidden;}
       .scrul li{border-bottom: 1px dotted #b3ccc0;overflow: hidden;padding: 20px 0 15px 0}
       .scrul li:last-child{border: 0;}
       .scrul img{width: 50px;float: left;margin-right: 8px;}
       .scrul p{font-size: 12px;color: #333;width: 150px;line-height: 21px;float: right;}
       .scrul p a{display: block;color: #2874c1;line-height: 23px;}
       .sctul {padding: 10px 0}
       .sctul li{background: url(/Html/images/hdd.png) no-repeat 13px center;padding-left: 24px;font-size: 12px;line-height: 30px;}
    </style>
    <script language="javascript" src="/Common/jCheck.js"></script>
        <script language="javascript" src="/Common/jPopup.js"></script>
        <script language="javascript" src="/Common/jCalendar.js"></script>
        <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
        <script language="javascript" src="/Common/jquery.colorbox.js"></script>
        <script type="text/javascript" src="../Common/jCity.js"></script> 
</head>
<body>
  <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form id="form1" runat="server">
        <div class="indecen">
            <div class="scleft">            	
            	<div class="sltitle">
            		 &nbsp;&nbsp;&nbsp;&nbsp;我加入的俱乐部
            	</div>
            	<ul class="clubox">
                    <%=mJion %>
            		<%--<li>
            			<a href=""><img src="/Html/images/rentou.png" alt=""></a><a href="">我加入的俱乐部 </a><br>
            			文章：33 | 图片：453 | 活动：2 | 成员：88
            			<p>我加入的俱乐部我加入的俱乐部我加入的俱乐部我加入的俱乐部我加入的俱乐部</p>
            		</li>
            		<li></li>--%>
            	</ul>
            </div>
            <div class="scright">
            	<div class="scrightt">&nbsp;&nbsp;热门俱乐部</div>
            	<ul class="scrul">
                    <%=hot %>
            		<%--<li><a href=""><img src="/Html/images/rentou.png" alt=""></a>
						<p><a href="">光华管理学院--戈壁挑战</a>“作为工商界的成功人士，不仅仅是行动强者</p>
            		</li>
            		<li><a href=""><img src="/Html/images/rentou.png" alt=""></a>
						<p><a href="">光华管理学院--戈壁挑战</a>“作为工商界的成功人士，不仅仅是行动强者</p>
            		</li>
            		<li><a href=""><img src="/Html/images/rentou.png" alt=""></a>
						<p><a href="">光华管理学院--戈壁挑战</a>“作为工商界的成功人士，不仅仅是行动强者</p>
            		</li>--%>
            	</ul>
            	<div class="scrightt">&nbsp;&nbsp;热门文章</div>
            	<ul class="sctul">
                    <%=hotBlog %>
            		<%--<li><a href="">首届大理苍山洱海越野赛将于11月</a></li>
            		<li><a href="">首届大理苍山洱海越野赛将于11月</a></li>
            		<li><a href="">首届大理苍山洱海越野赛将于11月</a></li>
            		<li><a href="">首届大理苍山洱海越野赛将于11月</a></li>--%>
            	</ul>
            	<div class="scrightt">&nbsp;&nbsp;最新文章</div>
            	<ul class="sctul">
                     <%=NewBlog %>
            		<%--<li><a href="">首届大理苍山洱海越野赛将于11月</a></li>
            		<li><a href="">首届大理苍山洱海越野赛将于11月</a></li>
            		<li><a href="">首届大理苍山洱海越野赛将于11月</a></li>
            		<li><a href="">首届大理苍山洱海越野赛将于11月</a></li>--%>
            	</ul>
            </div>
        </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
        
    </form>
</body>
</html>
