<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Topics.aspx.cs" Inherits="infocenter_Topics" %><%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html >
<head>
    <title><% =PageName %>-<% =PageName1 %>-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />

<style type="text/css">
	.wzph li{overflow: hidden;}
	.column-title{font-size: 15px;color: #666;height: 50px;border: 1px solid #ddd;margin-top: 12px;border-bottom: 0;background: url(/Html/images/lanmu.png) no-repeat -1px -1px;font-size: 22px;padding: 50px 0 0 0}
	.column-title p{background: url(/Html/images/lan.png) no-repeat ;width: 322px;height: 41px;float: left;}
	.column-title span{color: #c67e00;float: left;padding-left: 86px;}
	.column-title em{color: #ff7800;padding-left: 6px;float: left;}
	.column-list .title{font-size: 22px;color: #4c98cc;}
	.column-list ul{border: 1px solid #ddd;border-top: 0;padding: 0px 20px 20px 20px;}
	.column-list ul span{display: block;font-size: 12px;color: #999;padding: 4px 0 2px 0}
	.column-list ul p{font-size: 14px;color: #666;line-height: 24px;}
	.column-list ul li{border-bottom: 1px dotted #b3ccc0;padding: 20px 0}
	.column-list .article-bot{font-size: 12px; color:#666;padding-top: 6px;}
	.column-list .article-bot a{float: right;}
	.column-list .page{margin-top: 20px;}
    .column-list ul li img{width: 150px}
</style>
<link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jPopup.js"></script>
<script language="javascript" src="/Common/jCalendar.js"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
        <form id="form1" runat="server">
            <div class="left column-list">
                <div class="column-title">
                    <span><% =PageName1 %></span><p></p>
                    <em><% =PageName %></em>
                </div>
                <asp:ScriptManager ID="ScriptManager1" runat="server">
                </asp:ScriptManager>

                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>                        
                        <webdiyer:AspNetPager ID="pager1" runat="server" FirstPageText="<<" LastPageText=">>"
                            NextPageText="下一页" CssClass="pages pagetop"
                            CurrentPageButtonClass="cpb" PrevPageText="上一页"
                            OnPageChanged="pager1_PageChanged" PageSize="10" >
                        </webdiyer:AspNetPager>
                        <ul>
                            <% =PageBuffer %>
                        </ul>
                        <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
                            NextPageText="下一页" CssClass="pages"
                            CurrentPageButtonClass="cpb" PrevPageText="上一页"
                            OnPageChanged="pager_PageChanged" PageSize="10">
                        </webdiyer:AspNetPager>
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
        </form>
        <div class="right">
            <div class="rkuang wzph">
                <div class="rkuangtitle">文章排行</div>
                <ul>
                    <% =pf.Focus(303100100, 26) %>
                </ul>
            </div>
        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>