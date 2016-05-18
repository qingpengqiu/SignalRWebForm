<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClubSearch.aspx.cs" Inherits="infocenter_ClubSearch" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title>约跑搜索</title>
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
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
</head>
<style>
    .nav li.h_yp em {
        background: url(/Images/index/adqbj.png) no-repeat center 49px;
    }
</style>
    <script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Common/jPopup.js"></script>
    <script language="javascript" src="/Common/jCalendar.js"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jCity.js"></script>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
        <div class="hdserchl">
            <div class="hdstit">
                搜索活动
            </div>
            <div class="serlist">
                <div class="seroption">
                    <div class="searchtop">
                        选择城市：
                        <div class="runcity">
                            <span>北京市</span>&nbsp;&nbsp;<a href="javascript:void(0)">[ 切换城市 ]</a>
                            <div class="cityselect">
                                <div class="citygb" href="javascript:void(0)" title="关闭">x</div>
                                <em></em>
                            </div>
                        </div>
                        搜索关键字：<input class="serchkey" type="text"><a href="javascript:void(0)" class="searchinput"><img src="/Html/images/searchs.png" alt="" /></a>
                    </div>
                    <div class="serchoptions">
                        <ul>
                            <li class="region">
                                <i class="csicon1"></i>
                                地区：<a href="javascript:void(0)" data-area="全部" data-areanum="0">全部</a>
                                <em href="javascript:void(0)" class="regionall">全部</em>
                            </li>
                            <li class="serchtime">
                                <i class="csicon2"></i>
                                时间：<a href="javascript:void(0)" data-time="0">全部</a> <a href="javascript:void(0)" data-time="1">本周</a> <a href="javascript:void(0)" data-time="2">2周内</a> <a href="javascript:void(0)" data-time="3">1周后</a>
                            </li>
                            <li class="serchgame">
                                <i class="csicon3"></i>
                                类型：<a href="javascript:void(0)" data-game="0">全部</a> <a href="javascript:void(0)" data-game="1">路跑</a> <a href="javascript:void(0)" data-game="2">越野</a> <a href="javascript:void(0)" data-game="3">徒步</a> <a href="javascript:void(0)" data-game="4">分享会</a>
                            </li>
                            <li class="serchlevel">
                                <i class="csicon4"></i>
                                强度：<a href="javascript:void(0)" data-level="0">全部</a> <a href="javascript:void(0)" data-level="1">高</a> <a href="javascript:void(0)" data-level="2">中</a> <a href="javascript:void(0)" data-level="3">低</a>
                            </li>
                            <li class="serchkm">
                                <i class="csicon5"></i>
                                距离：<a href="javascript:void(0)" data-km="0">全部</a> <a href="javascript:void(0)" data-km="1">5公里以下</a> <a href="javascript:void(0)" data-km="2">5-10公里</a> <a href="javascript:void(0)" data-km="3">21公里</a>
                            </li>
                            <li class="serchfeatures">
                                <i class="csicon6"></i>
                                特色：<a href="javascript:void(0)" data-features="100">全部</a> <a href="javascript:void(0)" data-features="1">有奖品</a> <a href="javascript:void(0)" data-features="2">有饭</a> <a href="javascript:void(0)" data-features="3">有班车</a><a href="javascript:void(0)" data-features="4">有装备</a><a href="javascript:void(0)" data-features="5">主题活动</a><a href="javascript:void(0)" data-features="6">专业教练</a><a href="javascript:void(0)" data-features="0">无福利</a>
                            </li>
                        </ul>
                    </div>
                    <div class="searchnr">
                        <ul>
                            <li class="listmore" id="c01">点击加载更多...</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="hdserchr">
            <div class="hdfr hdhot">
                <span>热门活动</span>
            </div>
            <div class="hdfr ndfr">
                <span>最新活动</span>
            </div>
            <div class="hdfu">
                <span>活跃成员</span>
            </div>
            <div class="hddr">
                <span>活动达人</span>
                <ul>
                </ul>
            </div>
        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    <script language="javascript" charset="GB2312">
    var gId = <%=gId%>
        if (GetQueryString("city")) {
            var city = decodeURI(GetQueryString("city")),
                cityid = GetQueryString("cityid"),
                key = decodeURI(GetQueryString("key")),
                akey = decodeURI(GetQueryString("key")),
                areaid = GetQueryString("areaid"),
                time = GetQueryString("time"),
                game = GetQueryString("game"),
                level = GetQueryString("level"),
                km = GetQueryString("km"),
                features = GetQueryString("features"),
                pageIndex = 1,
                pageSize = GetQueryString("pageSize")
        } else {
            var city = "北京市",
                cityid = "1",
                key = "",
                akey="",
                areaid = "0",
                time = "0",
                game = "0",
                level = "0",
                km = "0",
                features = "100",
                pageIndex = "1",
                pageSize = "10"

        }
        $(".runcity").toggle(function() {
            $(".cityselect").show()
        }, function() {
            $(".cityselect").hide()
        });
        //输入关键字
        $(".searchinput").click(function (event) {
             key = $(".serchkey").val()
            if (key) {
                jump()
            };
        });
        function jump() {
            city = encodeURIComponent(encodeURIComponent(city))
            key = encodeURIComponent(encodeURIComponent(key))
            
            location.href = "?city=" + city + "&cityid=" + cityid + "&key=" + key + "&areaid=" + areaid + "&time=" + time + "&game=" + game + "&level=" + level + "&km=" + km + "&features=" + features + "&pageIndex=" + 1 + "&pageSize=" + pageSize
        }
        //循环输出城市
        for (x in china) {
            var i = parseInt(x) + 1;
            $(".cityselect").append("<a href=\"javascript:void(0)\" data-citynum=\"" + i + "\" data-city=\"" + china[x][0] + "\">" + china[x][0] + "</a>")
        }
        //循环输出地区
        function region(cityid) {
            cityi = parseInt(cityid) - 1;
            for (x in china[cityi]) {
                if (x != "0") {
                    $(".region").append("<a href=\"javascript:void(0)\" data-areanum=\"" + x + "\" data-area=\"" + china[cityi][x] + "\">" + china[cityi][x] + "</a>")
                }
            }
        }
        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        function SerachPage() {
            divid = "#c01";
            $.ajax({
                url: '/action/AjaxRace.ashx',
                data: { command: "search", city: city, cityid: cityid, key: encodeURIComponent(akey), areaid: areaid, time: time, game: game, level: level, km: km, features: features, pageIndex: pageIndex, pageSize: pageSize },
                type: 'get',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                cache: false,
                beforeSend: function () {
                    $(divid).html("<span class=\"load\"></span>正在加载中...");
                },
                success: function (data) {
                    var pagenum = data.count,
                        pagedata = data.ds
                    $.each(pagedata, function (i) {
                            $(divid).before("<li><a target=\"_blank\" href=\"/race/" + pagedata[i].id + ".aspx\" class=\"title\">" + pagedata[i].cTitle + "</a>" + pagedata[i].state + "<br/><span>  发起人：<a target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cLoginname + "</a>  活动时间：" + pagedata[i].dOpen + "</span><p>" + pagedata[i].cContent + "" + pagedata[i].Thumbnails + "</p><div class=\"article-bot\"><a target=\"_blank\" href=\"/race/" + pagedata[i].id + ".aspx\">查看全文>></a>阅读(" + pagedata[i].iShowTimes + ") 关注(" + pagedata[i].iFocus + ") 顶(" + pagedata[i].iDing + ") 评论(" + pagedata[i].iDiscuss + ")</div></li>");
                    })
                    thiscount = data.count;
                },
                complete: function () { //生成分页条
                    if (thiscount == "") {
                        $(divid).html("木有了...");
                    } else {
                        $(divid).html("点击加载更多...");
                    }
                },
                error: function (xhr) {
                }

            });
        }
        jQuery(document).ready(function ($) {

            //初始搜索关键字
            var gkey = decodeURI(GetQueryString("key"))
            if (GetQueryString("key")) {
                $(".serchkey").val(gkey)
            };
            //初始化城市
            var gcity = decodeURI(GetQueryString("city"))
            if (GetQueryString("city")) {
                $(".runcity span").html(gcity)
            };
            //初始化地区和样式
            if (GetQueryString("cityid")) {
                region(GetQueryString("cityid"));
            } else {
                region(cityid);
            }
            if (GetQueryString("areaid")) {
                $(".region a[data-areanum=" + GetQueryString("areaid") + "]").addClass('runthis')
            } else {
                $(".region a[data-areanum=" + areaid + "]").addClass('runthis')
            }
            //初始化时间样式
            if (GetQueryString("time")) {
                $(".serchtime a[data-time=" + GetQueryString("time") + "]").addClass('runthis')
            } else {
                $(".serchtime a[data-time=" + time + "]").addClass('runthis')
            }
            //初始化类型样式
            if (GetQueryString("game")) {
                $(".serchgame a[data-game=" + GetQueryString("game") + "]").addClass('runthis')
            } else {
                $(".serchgame a[data-game=" + game + "]").addClass('runthis')
            }
            //初始化级别样式
            if (GetQueryString("level")) {
                $(".serchlevel a[data-level=" + GetQueryString("level") + "]").addClass('runthis')
            } else {
                $(".serchlevel a[data-level=" + level + "]").addClass('runthis')
            }
            //初始化距离样式
            if (GetQueryString("km")) {
                $(".serchkm a[data-km=" + GetQueryString("km") + "]").addClass('runthis')
            } else {
                $(".serchkm a[data-km=" + km + "]").addClass('runthis')
            }
            //初始化特色样式
            if (GetQueryString("features")) {
                $(".serchfeatures a[data-features=" + GetQueryString("features") + "]").addClass('runthis')
            } else {
                $(".serchfeatures a[data-features=" + features + "]").addClass('runthis')
            }
            //选择城市
            $(".cityselect a").on('click', function () {
                city = $(this).data("city")
                cityid = $(this).data("citynum")
                $(".runcity span").html(city)
                jump()
            });
            //选择地区
            $(".region a").on('click', function () {
                areaid = $(this).data("areanum")
                jump()
            });
            //选择时间
            $(".serchtime a").on('click', function () {
                time = $(this).data("time")
                jump()
            });
            //选择类型
            $(".serchgame a").on('click', function () {
                game = $(this).data("game")
                jump()
            });
            //选择级别
            $(".serchlevel a").on('click', function () {
                level = $(this).data("level")
                jump()
            });
            //选择距离
            $(".serchkm a").on('click', function () {
                km = $(this).data("km")
                jump()
            });
            //选择特色
            $(".serchfeatures a").on('click', function () {
                features = $(this).data("features")
                jump()
            });
            //加载搜索数据
            
            SerachPage();
            $("#c01").click(function () {
                pageIndex++
                SerachPage();                
            })
            
        });
        function iFocus(idx,thisa) {
                function thisare() {
                    $(".hddr a[data-li=" + thisa + "]").replaceWith("<a class=\"focus-a hdgz\">已关注</a>")
                }
            if (confirm("确定要关注吗？") == true) {
                $.get("/action/GetFoucsList.ashx", { uId: idx, command: "addFoucs", timestamp: new Date().getTime() }, function (data) {
                    if (data == "1") {
                        focuscont = "<img src=\"/Html/images/right.png\"> 关注成功";
                    } else {
                        focuscont = "<img src=\"/Html/images/false.png\">" + data;
                    }
                    $(".hddr a[data-li=" + thisa + "]").append("<div class=\"focusalert\">" + focuscont + "</div>");
                    setTimeout(thisare, 2000);
                });
                

            }
        }
        $(".regionall").click(function(event) {
            $(".region").css({
                height: '72px',
                "line-height":  '32px',
                "padding":"10px 0 0 0"
            });
            $(this).hide()
        });
        //热门活动
        $.ajax({
            url: '/action/AjaxRace.ashx?command=toprace',
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
                $("body").append("<div class=\"cluberror\">正在加载中...</div>");
            },
            success: function (data) {
                $.each(data.ds, function (i,item) {
                    if(item.cImage){
                        cimg = item.cImage
                    }else{
                        cimg = "/Html/images/as.jpg"
                    }
                    $(".hdhot").append('<a href=\"/infocenter/ClubInfo.aspx?id='+item.id+'\" title=\"'+item.cTitle+'\"><img src=\"'+cimg+'\"></a>')
                })
            },
            complete: function () { 
                $(".cluberror").hide();
            },
            error: function (xhr) {
                $("body").append("<div class=\"cluberror\">数据加载失败</div>");
            }
        });
        //最新活动
        $.ajax({
            url: '/action/AjaxRace.ashx?command=newrace',
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
                $("body").append("<div class=\"cluberror\">正在加载中...</div>");
            },
            success: function (data) {
                $.each(data.ds, function (i,item) {
                    if(item.cImage){
                        cimg = item.cImage
                    }else{
                        cimg = "/Html/images/as.jpg"
                    }
                    $(".ndfr").append('<a href=\"/infocenter/ClubInfo.aspx?id='+item.id+'\" title=\"'+item.cTitle+'\"><img src=\"'+cimg+'\"></a>')
                })
            },
            complete: function () { 
                $(".cluberror").hide();
            },
            error: function (xhr) {
                $("body").append("<div class=\"cluberror\">数据加载失败</div>");
            }
        });
        //活跃成员
        $.ajax({
            url: '/action/AjaxRace.ashx?command=ActiveMember',
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
                $("body").append("<div class=\"cluberror\">正在加载中...</div>");
            },
            success: function (data) {
                $.each(data.ds, function (i,item) {
                    $(".hdfu").append('<a href=\"/infocenter/Default.aspx?uId='+item.idUser+'\" title=\"'+item.cLoginname+'\"><img src=\"'+item.cAvatar+'\"></a>')
                })
            },
            complete: function () { 
                $(".cluberror").hide();
            },
            error: function (xhr) {
                $("body").append("<div class=\"cluberror\">数据加载失败</div>");
            }
        });
        //活动达人
        $.ajax({
            url: '/action/AjaxRace.ashx?command=Daren',
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
                $("body").append("<div class=\"cluberror\">正在加载中...</div>");
            },
            success: function (data) {
                $.each(data.ds, function (i,item) {
                    if(gId == "-1"){
                        ggz = ""
                    }else{
                        ggz = '<a class=\"hdgz\" data-li=\"'+i+'\" href=\"javascript:void(0)\" onclick=\"iFocus('+item.idUser+','+i+')\">+ 关注TA</a><a class=\"hdly\" href=\"javascript:void(0)\" rel=\"/infocenter/PostMessage.aspx?uId='+item.idUser+'\">给TA留言</a>'
                    }
                    $(".hddr ul").append('<li><a href=\"/infocenter/Default.aspx?uId='+item.idUser+'\"><img src=\"'+item.cAvatar+'\"></a><a class=\"hdfname\" href=\"/infocenter/Default.aspx?uId='+item.idUser+'\">'+item.cLoginname+'</a>'+ggz+'</li>')
                })
                $(".hdly").on('click', function(e){
                    $(this).colorbox({href: $(this).attr('rel'), iframe:true, width: 432, innerHeight:200, open:true,opacity: "0.4"});
                    e.preventDefault();
                    return false;
                    });
            },
            complete: function () { 
                $(".cluberror").hide();
            },
            error: function (xhr) {
                $("body").append("<div class=\"cluberror\">数据加载失败</div>");
            }
        });
    </script>
</body>
</html>
