<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Images.aspx.cs" Inherits="infocenter_Images" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title>赛事相册</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <meta property="wb:webmaster" content="a859eadcc5aee52a" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico"/>
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link href="/Common/index.css?2012111" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
</head>
<body>
    <script type="text/javascript" src="/Common/jWeibo.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Common/jHeader.js?2012111"></script>
    <div class="indecen">
        <div class="left">
            <div class="gameimg">
                <div class="gameimgtitle">
                </div>
                <div class="crumbs"></div>
                <ul>
                    <li class="listmore" id="c01">点击加载更多</li>
                </ul>
            </div>
        </div>
        <div class="right">
            <div class="rkuang wb">
                <div class="rkuangtitle">
                    <span><a href="/Channels/Competetion/RaceList.aspx">赛事报名</a></span>
                </div>
                <div class="wbnr">
                    <ul class="event" id="slider" style="top: 0px;"></ul>
                    <script type="text/javascript">
                        $.get("/Utility/Ajax/Weibo.aspx", { rnd: MinuteRand() }, function (result) {
                            document.getElementById("slider").innerHTML = result;
                            new slider({ id: 'slider' });
                        });
                    </script>
                </div>
            </div>
            <div class="rkuang wzph">
                <div class="rkuangtitle">赛事关注排行</div>
                <ul>
                    <% =pf.Focus(302100100, 26) %>
                </ul>
            </div>
        </div>
    </div>
    <ERUN360:footer ID="footer" runat="server" />
    <script>

        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        if (GetQueryString("f")) {
            id = GetQueryString("f")
        } else {
            id = "1"
        }
        function SerachPage() {
            divid = "#c01";
            $.ajax({
                url: '/action/GetPhoto.ashx',
                data: { m: "photo2", p: pageIndex, f: id },
                type: 'get',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                cache: false,
                beforeSend: function () {
                    $(divid).html("<span class=\"load\"></span>正在加载中");
                },
                success: function (data) {

                    var pagenum = data.count,
                        pagedata = data.ds
                    $.each(pagedata, function (i) {
                        if (pagedata[i].tag == "True") {
                            $(divid).before("<li><a href=\"/infocenter/images.aspx?f=" + pagedata[i].id + "\"><img src=\"" + pagedata[i].cImg + "\" alt=\"\" /><p>" + pagedata[i].cName + "</p></a></li>");
                        } else {
                            $(divid).before("<li><a href=\"/infocenter/PhotoAlbum.aspx?id=" + pagedata[i].id + "\"><img src=\"" + pagedata[i].cImg + "\" alt=\"\" /><p>" + pagedata[i].cName + "</p></a></li>");
                        }

                    })
                    thiscount = data.count;
                    if (data.parent == 0) {
                        pname = ""
                    } else {
                        pname = "<a href=\"/infocenter/images.aspx?f=" + data.parent + "\">" + data.pname + "</a> > "
                    }

                    tname = data.name
                    $(".crumbs").html(pname + tname)
                },
                complete: function () { //生成分页条
                    if (thiscount == "") {
                        $(divid).html("木有了");
                    } else {
                        $(divid).html("点击加载更多");
                    }
                },
                error: function (xhr) {
                }

            });
        }
        pageIndex = 1;
        SerachPage();
        $("#c01").click(function () {
            pageIndex++
            SerachPage();

        })
    </script>
</body>
</html>
