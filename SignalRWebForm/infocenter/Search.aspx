<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="infocenter_Search" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title>搜索</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <style type="text/css">
        .wzph li {
            overflow: hidden;
        }

        .column-title {
            font-size: 15px;
            color: #666;
            height: 38px;
            line-height: 38px;
            border: 1px solid #ddd;
            background: #f5f5f5;
            margin-top: 12px;
        }

            .column-title span {
                　font-weight: bold;
            }

            .column-title em {
                font-weight: bold;
                color: #4c98cc;
                　;
            }

        .column-list .title {
            　 font-size: 22px;
            color: #4c98cc;
        }

            .column-list .title em {
                color: #ff6633;
            }

        .column-list ul {
            border: 1px solid #ddd;
            border-top: 0;
            padding: 0px 20px 20px 20px;
        }

            .column-list ul span {
                display: block;
                font-size: 12px;
                color: #999;
                padding: 4px 0 2px 0;
            }

            .column-list ul p {
                font-size: 14px;
                color: #666;
                line-height: 24px;
                word-wrap: break-word;
            }

            .column-list ul li {
                border-bottom: 1px dotted #b3ccc0;
                padding: 20px 0;
            }

        .column-list .article-bot {
            font-size: 12px;
            color: #666;
            padding-top: 6px;
        }

            .column-list .article-bot a {
                float: right;
            }

        .column-list .page {
            margin-top: 20px;
        }

        .search-title {
            border: 1px solid #ddd;
            background: #f5f5f5;
            margin-top: 12px;
            padding: 0 0 0 18px;
        }

            .search-title #frmSearch {
                float: none;
            }

            .search-title p {
                font-size: 14px;
                color: #666;
                padding: 6px 0;
            }

            .search-title em {
                color: #ff6633;
            }

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
    </style>
</head>
<script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Common/jPopup.js"></script>
    <script language="javascript" src="/Common/jCalendar.js"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<body>
    
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
        <div class="left column-list">
            <div class="search-title">
                <form method="post" action="/infocenter/Search.aspx" name="frmSearch" id="frmSearch">
                    <select id="fname" name="fname" style="display: none">
                        <option value="loginname">找人</option>
                        <option selected value="title">找标题</option>
                        <option selected value="content">找内容</option>
                    </select>
                    <input type="text" id="word" name="word" value="人名、标题、关键字" onfocus="if(this.value=='人名、标题、关键字'){this.value='';this.style.color='#000000'}" onblur="if(this.value==''){this.value='人名、标题、关键字';this.style.color='#a9a9a9'}">
                    <a onclick="SearchIt();" class="serch"></a>
                    <%-- <select style="display: none" name="fname" id="fname">
                        <option value="loginname">找人</option>
                        <option value="title" selected="">找标题</option>
                        <option value="content" selected="">找内容</option>
                    </select>
                    <input type="text" onblur="if(this.value==''){this.value='人名、标题、关键字';this.style.color='#a9a9a9'}" onfocus="if(this.value=='人名、标题、关键字'){this.value='';this.style.color='#000000'}" value="人名、标题、关键字" name="word" id="word">
                    <a class="serch" onclick="SearchIt();"></a>--%>
                    <div id="result">
                    </div>
                </form>
                <script type="text/javascript" language="javascript">
                    jQuery(document).ready(function($) {
                        $("#word").keyup(function(){
                            key = $(this).val().replace(/(^\s*)|(\s*$)/g, "");  
                            xskey = key;

                            function cutstr(str,len)
                            {
                                var str_length = 0;
                                var str_len = 0;
                                str_cut = new String();
                                str_len = str.length;
                                for(var i = 0;i<str_len;i++)
                                {
                                    a = str.charAt(i);
                                    str_length++;
                                    if(escape(a).length > 4)
                                    {
                                        //中文字符的长度经编码之后大于4
                                        str_length++;
                                    }
                                    str_cut = str_cut.concat(a);
                                    if(str_length>=len)
                                    {
                                        str_cut = str_cut.concat("...");
                                        return str_cut;
                                    }
                                }
                                //如果给定字符串小于指定长度，则返回源字符串；
                                if(str_length<len){
                                    return  str;
                                }
                            }   
                            xskey = cutstr(xskey,10);
                            html = "<ul><li><a href=\"/infocenter/Searchuser.aspx?searchname="+key+"\">搜“<em>"+xskey+"</em>”相关的用户</a></li><li><a href=\"/infocenter/Search.aspx?fname=title&word="+key+"\">搜“<em>"+xskey+"</em>”相关的标题</a></li><li style=\"border-bottom: 0\"><a href=\"/infocenter/Search.aspx?fname=content&word="+key+"\">搜“<em>"+xskey+"</em>”相关的内容</a></li></ul>";
                            $("#result").empty("");
                            if(key == ""){
                                $("#result").hide();    
                            }else{
                                $("#result").append(html);
                                $("#result").show();    
                            }
                            $("html").click(function(){
                                $("#result").hide();    
                            })
                
                        })
                    });     
                    //<!--
                    function SearchIt(){
                        if(document.getElementById("word").value.length > 0 && document.getElementById("word").value != "人名、标题、关键字"){
                           
                          window.location.href="/infocenter/Search.aspx?fname=title&word="+document.getElementById("word").value;
                            
                        }
                        return false;
                    }
                    //-->
                </script>
                <p>搜索“<em><% =PageWord %></em>”相关关键字，找到<%=num %>条结果</p>
            </div>
            <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <webdiyer:AspNetPager ID="pager1" runat="server" FirstPageText="<<" LastPageText=">>"
                        NextPageText="下一页" CssClass="pages pagetop"
                        CurrentPageButtonClass="cpb" PrevPageText="上一页"
                        OnPageChanged="pager1_PageChanged" PageSize="10">
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
            </form>
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
                // function SearchIt() {
                //     if (document.getElementById("word").value.length > 0) {
                //         document.frmSearch.submit();
                //         return true;
                //     }
                //     return false;
                // }
            </script>

        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
