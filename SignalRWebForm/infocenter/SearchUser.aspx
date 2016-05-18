<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SearchUser.aspx.cs" Inherits="infocenter_SearchUser" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title>查找用户</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <meta property="wb:webmaster" content="a859eadcc5aee52a" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
    <style type="text/css">
        .serch-key {
            padding: 0 16px;
            line-height: 40px;
        }

            .serch-key a {
                font-size: 14px;
                color: #666;
                padding: 0 3px;
            }

                .serch-key a:hover {
                    text-decoration: none;
                }

            .serch-key .a1 {
                font-size: 30px;
                color: #ff3333;
                font-weight: bold;
            }

            .serch-key .a2 {
                font-size: 30px;
                color: #ff6600;
            }

            .serch-key .a3 {
                font-size: 24px;
                color: #666;
                font-weight: bold;
            }

            .serch-key .a4 {
                font-size: 24px;
                color: #0099cc;
            }

            .serch-key .a5 {
                font-size: 24px;
                color: #ff6600;
            }

            .serch-key .a6 {
                font-size: 18px;
                color: #666;
                font-weight: bold;
            }

            .serch-key .a7 {
                font-size: 18px;
                color: #cc66cc;
                font-weight: bold;
            }

            .serch-key .a8 {
                font-size: 18px;
                color: #0099cc;
                font-weight: bold;
            }

            .serch-key .a9 {
                font-size: 18px;
                color: #cc66cc;
            }

            .serch-key .a10 {
                font-size: 18px;
                color: #0099cc;
            }
            .searchuser{padding-top: 16px;width: 656px;}
            .sfbox{padding: 6px 0 0 0 }

.tfirend{height: 31px;background: url(/Html/images/bn5.png) no-repeat -3px top ;padding-top: 4px}
.sfbox .blog{overflow: hidden;min-height: 0px!important;margin-left: 0px;}
.tfirend input{margin: 0;padding: 0;background:none;border: 0;box-shadow:none;width: 142px;float: right;height: 28px;line-height: 28px;}
.tfirend input:focus{box-shadow:none;}
.tfirend a{float: right;width: 38px;height: 28px;margin-top: -2px;}
.tfirend a:hover{cursor: pointer;}
.focus{border: 0;background: none}
.focus .blog-top{border: 1px solid #DDDDDD}
.focus ul{margin: 0;}
.focus li{margin: 14px 0 0 0 ;width: 296px;height: 98px;border: 1px solid #e4e4e4;padding: 12px 12px 0 12px;float: left;background:hsla(0,0%,100%,0.8) ;color: #666}
.focus li:nth-child(even){margin-left: 12px;}
.focus li img{width: 50px;border: 1px solid #cecece;float: left;margin-right: 16px;margin-bottom: 40px;height: 50px;}
.focus li .focus-a img{border: 0 none; float: none; height: 21px; margin: 0;
    width: 21px;}
.focus li .focusgz:hover{background: none repeat scroll 0 0 #c3c1c1;}
.focus li a{color: #333;font-size: 14px;font-weight: bold;}    
.focus li a:hover{text-decoration: underline; color: #ff6600}
.focus li .focus-a:hover,.focus li .focus-b:hover{text-decoration: none; color: #fff}
.focus .focus-a{font-size: 12px;color: #fff;background: #afafaf;padding: 6px;line-height: 12px;float: left;border-radius: 5px;position: relative;outline: none;font-weight: 100;}
.focus .focus-b{font-size: 12px;color: #fff;background: #378ed6;padding: 6px;line-height: 12px;float: left;border-radius: 5px;margin-left: 12px;font-weight: 100;text-shadow:0.08em 0.08em 0.04em #296694}
.focus .focus-c{font-size: 12px;color: #fff;background: #ff9600;padding: 6px;line-height: 12px;float: left;border-radius: 5px;margin-left: 12px;}
.focus li p{padding-top: 4px;margin-bottom: 14px;}
.article-up-iframe{display: block;}
.focus-tly{width: 57px;height: 19px;background: url(/Html/images/tly.png);text-indent: -3333em;display: inline-block;margin-left: 4px;}
.focus-tlyn{width: 57px;height: 19px;background: url(/Html/images/tly.png);text-indent: -3333em;display: inline-block;margin-left: 4px;}
.focus-txh{width: 49px;height: 19px;background: url(/Html/images/txh.png);text-indent: -3333em;display: inline-block;}
.focus-tgz{width: 49px;height: 19px;background: url(/Html/images/tgz.png);text-indent: -3333em;display: inline-block;position: relative;}
.focus-tqx{width: 49px;height: 19px;background: url(/Html/images/tqx.png);text-indent: -3333em;display: inline-block;}
.focus-tygz{width: 49px;height: 19px;background: url(/Html/images/tygz.png);text-indent: -3333em;display: inline-block;}
.focus li .focusalert img{float: none;width: 21px;height: 21px;}
.focus li .focusalert img{float: none;width: 21px;height: 21px;border: 0;margin: 0}
.focus li .focusalert{text-indent: 0}
.ffindtip{font-size: 14px;color: #666;padding-top: 8px;}
.ffindtip span{font-weight: bold;color: #FF6633}
    </style>
</head>
<body>
    <script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Common/jPopup.js"></script>
    <script language="javascript" src="/Common/jCalendar.js"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
     <form id="form1" runat="server">
    
    <div class="indecen">
        <div class="left searchuser">
            <div class="sfbox">
						<div class="tfirend ">
							<a onclick="SearchUser();" class="serch" href="javascript:void(0)"></a>
							<input type="text" id="taword" runat="server" value="" onfocus="if(this.value=='人名'){this.value='';this.style.color='#000000'}" onblur="if(this.value==''){this.value='人名';this.style.color='#a9a9a9'}"/>
							
						</div>
                <div class="ffindtip">
							<%=searchTip %>
						</div>
						<div class="blog focus">
                           
<ul class="">
    <%=UserList %>
	<%--<li><a target="_blank" href="/user/100002013.aspx"><img src="/images/noname.gif"> 星星</a><p>1111</p>	<a class="focus-tygz">相互关注</a><a href="/infocenter/PostMessage.aspx?uId=100002013" class="focus-tly">给TA留言</a></li>
	<li><a target="_blank" href="/user/100002723.aspx"><img src="/images/noname.gif"> 王栋</a><p>好好跑步，好好生活</p>	<a class="focus-txh">相互关注</a><a href="/infocenter/PostMessage.aspx?uId=100002723" class="focus-tly">给TA留言</a></li>
	<li><a target="_blank" href="/user/100003123.aspx"><img src="/images/noname.gif"> daibo</a><p></p>	<a class="focus-tqx">相互关注</a><a href="/infocenter/PostMessage.aspx?uId=100003123" class="focus-tly">给TA留言</a></li>
	<li><a target="_blank" href="/user/100000605.aspx"><img src="/images/noname.gif"> gggso</a><p>胖子</p>	<a class="focus-txh">相互关注</a><a href="/infocenter/PostMessage.aspx?uId=100000605" class="focus-tly">给TA留言</a></li><li><a target="_blank" href="/user/100000466.aspx"><img src="/images/noname.gif"> joshuama</a><p></p>	<a class="focus-txh">相互关注</a><a href="/infocenter/PostMessage.aspx?uId=100000466" class="focus-tly">给TA留言</a></li>
	<li><a target="_blank" href="/user/100000004.aspx"><img src="/images/noname.gif"> 丁剑</a><p>跑还是不跑，这是一个问题，哈哈哈</p>	<a onclick="iFocus(100000004,'focus5')" class="focus-tgz  focus5" href="javascript:">关注TA</a><a href="/infocenter/PostMessage.aspx?uId=100000004" class="focus-tly">给TA留言</a></li>
	<li><a target="_blank" href="/user/100000691.aspx"><img src="/images/noname.gif"> 大丸子</a><p>每天跑步1小时</p>	<a onclick="iFocus(100000691,'focus6')" class="focus-tgz  focus6" href="javascript:">关注TA</a><a href="/infocenter/PostMessage.aspx?uId=100000691" class="focus-tly">给TA留言</a></li>--%>
</ul>
                             <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
                                    NextPageText="下一页" CssClass="pages"
                                    CurrentPageButtonClass="cpb" PrevPageText="上一页"
                                    OnPageChanged="pager_PageChanged" PageSize="12">
                                </webdiyer:AspNetPager>
						</div>
                    </div>
            
        </div>
        <div class="right">
            <div class="rkuang wzph">
                <div class="rkuangtitle">热门搜索</div>
                <div class="serch-key">
                    <a class="a1" href="/infocenter/Search.aspx?fname=title&word=越野跑">越野跑</a>
                    <a class="a2" href="/infocenter/Search.aspx?fname=title&word=呼吸">呼吸</a>
                    <a class="a3" href="/infocenter/Search.aspx?fname=title&word=姿势">姿势</a>
                    <a class="a4" href="/infocenter/Search.aspx?fname=title&word=膝盖">膝盖</a>
                    <a class="a5" href="/infocenter/Search.aspx?fname=title&word=选鞋">选鞋</a>
                    <a class="a6" href="/infocenter/Search.aspx?fname=title&word=核心力量">核心力量</a>
                    <a class="a7" href="/infocenter/Search.aspx?fname=title&word=健身房">健身房</a>
                    <a class="a8" href="/infocenter/Search.aspx?fname=title&word=训练计划">训练计划</a>
                    <a class="a9" href="/infocenter/Search.aspx?fname=title&word=恢复">恢复</a>
                    <a class="a10" href="/infocenter/Search.aspx?fname=title&word=装备">装备</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=越野">越野</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=马拉松">马拉松</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=比赛">比赛</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=健身房">健身房</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=跑步机">跑步机</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=热身">热身</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=放松">放松</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=呼吸">呼吸</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=姿势">姿势</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=动作">动作</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=极点">极点</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=训练计划">训练计划</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=强度">强度</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=跑量">跑量</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=速度">速度</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=频率">频率</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=业余训练">业余训练</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=交叉训练">交叉训练</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=耐力">耐力</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=LSD">LSD</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=节奏跑">节奏跑</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=间歇">间歇</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=核心力量">核心力量</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=平台">平台</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=过度训练">过度训练</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=运动疲劳">运动疲劳</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=恢复">恢复</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=心率">心率</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=腹肌">腹肌</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=家庭">家庭</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=办公室">办公室</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=选鞋">选鞋</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=手表">手表</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=压缩衣">压缩衣</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=包">包</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=眼镜">眼镜</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=护具">护具</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=经期">经期</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=节食">节食</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=减肥">减肥</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=蛋白粉">蛋白粉</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=左旋">左旋</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=共轭亚油酸CLA">共轭亚油酸CLA</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=谷氨酰胺">谷氨酰胺</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=猝死">猝死</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=乳酸">乳酸</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=抽筋">抽筋</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=备赛">备赛</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=跟腱">跟腱</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=RICE">RICE</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=氨基酸">氨基酸</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=矿物质">矿物质</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=维生素">维生素</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=抗氧化">抗氧化</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=运动员">运动员</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=预防">预防</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=关节">关节</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=韧带">韧带</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=肌肉">肌肉</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=腹泻">腹泻</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=腹痛">腹痛</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=髂胫束">髂胫束</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=赤足">赤足</a>
                </div>
            </div>
            <script type="text/javascript">
                jQuery(document).ready(function ($) {
                    $(".a11").after($(".a1"))
                });
                function SearchIt() {
                    if (document.getElementById("word").value.length > 0) {
                        document.frmSearch.submit();
                        return true;
                    }
                    return false;
                }
                function SearchUser(){
    if(document.getElementById("taword").value.length > 0){
        $(".serch").attr("href","\/infocenter\/Searchuser.aspx?searchname="+document.getElementById("taword").value)
        return true;
    }
    return false;
}
function iFocus(idx,thisa) {
    var thisa = "."+thisa;
        function thisare() {
            $(thisa).replaceWith("<a class=\"focus-tygz\">相互关注</a>")
        }
        $.get("/action/GetFoucsList.ashx", { uId: idx, command: "addFoucs", timestamp: new Date().getTime() }, function (data) {
            if (data == "1") {
                focuscont = "<img src=\"/Html/images/right.png\"> 关注成功";
            } else {
                focuscont = "<img src=\"/Html/images/false.png\">" + data;
            }
            $(thisa).append("<div class=\"focusalert\">" + focuscont + "</div>");
            setTimeout(thisare, 2000);
        });
}
$(".focus-tly").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
            </script>

        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    						</form>
</body>
</html>
