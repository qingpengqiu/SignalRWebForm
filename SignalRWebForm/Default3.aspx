<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Default3" %>

<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/mediaIndex.css" />
    <script type="text/javascript" src="/Common/jWeibo.js"></script>
    <script type="text/javascript" src="/Common/jQuery1.8.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Common/jquery.colorbox.js"></script>
    <style type="text/css">
        .nav li.h_sy em {
            background: url(/Images/index/adqbj.png) no-repeat center 49px;
        }

        .qrcodex {
            position: fixed;
            top: 0;
            right: 50%;
            margin-right: -540px;
            z-index: 99999;
            width: 45px;
            height: 45px;
            background: url(/images/qrcodex.png);
            box-shadow: 0 0 4px #000;
        }

        .qrcoded {
            width: 258px;
            height: 289px;
            background: url(/images/qrcoded.png);
            box-shadow: 0 0 13px #000;
        }

        .gg {
            margin-top: 17px;
        }
    </style>
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <a class="qrcodex iframe" href="/qrcode-help.html"></a>
    <div class="indecen ">
        <div class="connav">
            <form id="frmSearch" name="frmSearch" action="/infocenter/Search.aspx" method="post">
                <select id="fname" name="fname" style="display: none">
                    <option value="loginname">找人</option>
                    <option selected value="title">找标题</option>
                    <option selected value="content">找内容</option>
                </select>
                <input type="text" id="word" name="word" value="人名、标题、关键字" onfocus="if(this.value=='人名、标题、关键字'){this.value='';this.style.color='#000000'}" onblur="if(this.value==''){this.value='人名、标题、关键字';this.style.color='#a9a9a9'}">
                <a id="serch" class="serch"></a>
                <div id="result">
                </div>
            </form>
            <script type="text/javascript" language="javascript">
                jQuery(document).ready(function ($) {
                    $(".qrcodex").hover(function () {
                        $(this).addClass("qrcoded");
                    }, function () {
                        $(this).removeClass("qrcoded");
                    })
                    $(".iframe").colorbox({ iframe: true, width: "394px", height: "606px", opacity: 0.7, });
                    $("#word").keyup(function () {
                        key = $(this).val().replace(/(^\s*)|(\s*$)/g, "");
                        xskey = key;
                        function cutstr(str, len) {
                            var str_length = 0;
                            var str_len = 0;
                            str_cut = new String();
                            str_len = str.length;
                            for (var i = 0; i < str_len; i++) {
                                a = str.charAt(i);
                                str_length++;
                                if (escape(a).length > 4) {
                                    //中文字符的长度经编码之后大于4
                                    str_length++;
                                }
                                str_cut = str_cut.concat(a);
                                if (str_length >= len) {
                                    str_cut = str_cut.concat("...");
                                    return str_cut;
                                }
                            }
                            //如果给定字符串小于指定长度，则返回源字符串；
                            if (str_length < len) {
                                return str;
                            }
                        }
                        xskey = cutstr(xskey, 10);
                        html = "<ul><li><a href=\"/infocenter/Searchuser.aspx?searchname=" + key + "\">搜“<em>" + xskey + "</em>”相关的用户</a></li><li><a href=\"/infocenter/Search.aspx?fname=title&word=" + key + "\">搜“<em>" + xskey + "</em>”相关的标题</a></li><li style=\"border-bottom: 0\"><a href=\"/infocenter/Search.aspx?fname=content&word=" + key + "\">搜“<em>" + xskey + "</em>”相关的内容</a></li></ul>";
                        $("#result").empty("");
                        if (key == "") {
                            $("#result").hide();
                        } else {
                            $("#result").append(html);
                            $("#result").show();
                            $("#serch").attr('href', '/infocenter/Search.aspx??fname=title&word=' + key);
                        }
                        $("html").click(function () {
                            $("#result").hide();
                        })

                    })
                });
                // function SearchIt(){
                //     if(document.getElementById("word").value.length > 0){
                //         document.frmSearch.submit();
                //         return true;
                //     }
                //     return false;
                // }
            </script>
            <a href="/infocenter/Search.aspx">最新博文</a>&nbsp;|
        <a href="/infocenter/Search.aspx?word=.">博文排行</a>&nbsp;|
        <!-- <a href="">博客排行</a>&nbsp;| -->
            <a href="/zt.aspx">专题</a>&nbsp;|
            <a href="/Channels/Competetion/Album.aspx">赛事相册</a>&nbsp;|
            <a href="/Competetion/SearchEvent.aspx">赛事报名</a>&nbsp;|
            <a href="/Channels/Competetion/internationalEvents.aspx">国际直通车</a>
            <!-- <a href="">俱乐部</a>&nbsp;| 
        <a href="">厂商</a> -->
            <a class="topkong"></a>
            <span>热门搜索：</span>
            <a href="/infocenter/Search.aspx?fname=title&word=%D0%C2%CA%D6">新手</a>&nbsp;&nbsp;&nbsp;
        <a href="/infocenter/Search.aspx?fname=title&word=%C2%ED%C0%AD%CB%C9">马拉松</a>&nbsp;&nbsp;&nbsp;
        <a href="/infocenter/Search.aspx?fname=title&word=%BC%F5%B7%CA">减肥</a>
        </div>
        <div class="indexctop">
            <div class="left">
                <%--<% =pf.Show(300101100) %>--%>
                <%=pf.Focusmap() %>
            </div>
            <div class="right" id="preview">
            </div>
            <script type="text/javascript">
                $.get("/Utility/Ajax/News.aspx", { rnd: MinuteRand() }, function (result) {
                    document.getElementById("preview").innerHTML = result;
                });
            </script>
        </div>
        <div class="left">
            <%=Gg.Advert(1) %>
            <div class="bjtj">
                <a href="/topics/300104100.aspx">编辑推荐</a>
            </div>
            <ul class="ypzlx">
                <% =pf.Show(300104100) %>
            </ul>
            <%=Gg.Advert(2) %>
            <div class="ypzl">
                <a href="/topics/300103100.aspx">益跑专栏</a>
            </div>
            <ul class="ypzlx">
                <% =pf.Show(300103100) %>
            </ul>
            <%=Gg.Advert(3) %>
            <div class="ht httong">
                <a href="/channels/competetion/" class="httitle">赛事&bull;城市</a>
                <% =pf.Show(300117100) %>
            </div>

            <div class="ht">
                <a href="/channels/shoe/" class="httitle">跑步装备</a>
                <% =pf.Show(300112100) %>
            </div>
            <div class="ht htr">
                <a href="/channels/train/" class="httitle">跑步训练</a>
                <% =pf.Show(300111100) %>
            </div>
            <div class="ht">
                <a href="/channels/nutrition/" class="httitle">营养&bull;瘦身</a>
                <% =pf.Show(300114100) %>
            </div>
            <div class="ht htr">
                <a href="/channels/health/" class="httitle">健康&bull;恢复</a>
                <% =pf.Show(300118100) %>
            </div>
            <div class="ht ">
                <a href="/channels/beginner/" class="httitle">初级跑者</a>
                <% =pf.Show(300115100) %>
            </div>
            <div class="ht htr">
                <a href="/channels/life/" class="httitle">跑步人生</a>
                <% =pf.Show(300116100) %>
            </div>
        </div>
        <div class="right">
            <%=Gg.Advert(4) %>
            <div class="rkuang wb">
                <div class="rkuangtitle">
                    <a href="/Competetion/SearchEvent.aspx"><span>赛事报名</span></a>
                </div>
                <div class="wbnr">
                    <ul id="slider" class="event">
                    </ul>
                    <script type="text/javascript">
                        $.get("/Utility/Ajax/NewEvent.aspx", { rnd: MinuteRand() }, function (result) {
                            document.getElementById("slider").innerHTML = result;
                            new slider({ id: 'slider' });
                        });
                    </script>
                </div>
            </div>
            <%=Gg.Advert(5) %>
            <%=Gg.Advert(6) %>
            <div class="rkuang wb xiaok">
                <div class="rkuangtitle">
                    <span><a href="javascript:void(0)">益跑精选</a></span>
                </div>
                <div class="wbnr" id="Choice">
                </div>
                <script type="text/javascript">
                    $.get("/Utility/Ajax/Choice.aspx", { rnd: MinuteRand() }, function (result) {
                        document.getElementById("Choice").innerHTML = result;
                    });
                </script>
            </div>
            <!-- <div class="rkuang xiaogj">
                <a href="" class="rkuangtitle">益跑小工具</a>
                <form method="post" action="/Utility/RaceHistory.aspx" name="searchFrm" id="searchFrm">
                    我今天跑了：
                    <input type="hidden" value="" name="UpdatedFields" id="UpdatedFields">
                    <select onchange="UpdateHistory(this)" name="idRoadStyle" id="idRoadStyle">
                        <option selected="" value="0">公园</option>
                        <option value="1">田径场</option>
                        <option value="2">公路</option>
                        <option value="3">山路</option>
                        <option value="4">跑步机</option>
                        <option value="5">其它</option>
                    </select>
                    <input type="text" onblur="this.className='input_cls1';" onmouseout="this.className='input_cls1';" onmouseover="this.className='input_cls2';" value="" class="input_cls1" maxlength="3" id="iDistance" name="iDistance">&nbsp;公里，<br>
                    用时：
                    <input type="text" onblur="this.className='input_cls1';" onmouseout="this.className='input_cls1';" onmouseover="this.className='input_cls2';" value="" class="input_cls1" maxlength="2" id="iHours" name="iHours">时 
                    <input type="text" onblur="this.className='input_cls1';" onmouseout="this.className='input_cls1';" onmouseover="this.className='input_cls2';" value="" class="input_cls1" maxlength="2" id="iMinutes" name="iMinutes">分 
                    <input type="text" onblur="this.className='input_cls1';" onmouseout="this.className='input_cls1';" onmouseover="this.className='input_cls2';" value="0" class="input_cls1" maxlength="2" id="iSeconds" name="iSeconds">&nbsp;秒 
                    <img onclick="document.searchFrm.submit();return true;" src="/Images/index/tijiao.png">
                </form>
            </div> -->
            <%=Gg.Advert(7) %>
            <div class="rkuang shipin">
                <a class="rkuangtitle" href="/topics/300130100.aspx">益跑视频</a>
                <ul>
                    <% =pf.Show(300130100) %>
                </ul>
            </div>
            <div class="rkuang yiptp">
                <a class="rkuangtitle" href="/topics/300140100.aspx">益跑图片</a>
                <ul>
                    <% =pf.Show(300140100) %>
                </ul>
            </div>
            <div class="rkuang yphd" style="display: none">
                <div class="rkuangtitle">益跑活动</div>
                <form id="frmRace" name="frmRace" action="/Utility/MyRace.aspx" method="post">
                    <table id="smart">
                        <tr>
                            <td align="right" style="width: 60px;">城市：</td>
                            <td>
                                <script type="text/javascript" src="/Common/jCity.js"></script>
                                <select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)">
                                </select>
                                <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)">
                                </select>
                                <script type="text/javascript" language="javascript">
                    <!--
    BindProvince("北京");
    // -->
                                </script>
                                <input type="hidden" id="idCity" name="idCity" size="5" readonly value="" onchange="UpdateHistory(this)">
                                <input type="hidden" id="cCityname" name="cCityname" size="16" readonly value="" onchange="UpdateHistory(this)">
                            </td>
                        </tr>
                        <tr>
                            <td align="right">时间：</td>
                            <td>
                                <input type="radio" id="rtime" name="rtime" checked value="week1">本周 
                    <input type="radio" id="Radio1" name="rtime" value="day">今天
                    <input type="radio" id="Radio2" name="rtime" value="week2">下周
                            </td>
                        </tr>
                        <tr>
                            <td align="right"></td>
                            <td>
                                <img src="/Images/index/yphdss.png" onclick="Finish()">
                            </td>
                        </tr>
                    </table>
                </form>
                <script type="text/javascript" language="javascript">
<!--
    function Finish() {
        if (document.getElementById("idCity").value.length < 1) {
            alert("请选择所在城市和区域!");
            return false;
        }
        document.frmRace.submit();
        return true;
    }
    // -->
                </script>
            </div>
        </div>
        <div class="hezhb">
            <span>合作伙伴</span>
            <a href="http://www.athletics.org.cn/" target="_blank" title="中国田径协会">
                <img src="/Images/index/tjxh.png" alt="中国田径协会">
            </a>
            <a href="http://sports.163.com/running/" target="_blank" title="网易跑步">
                <img src="/Images/index/wypb.png" alt="网易跑步">
            </a>
            <a href="http://running.sports.sohu.com/" target="_blank" title="搜狐体育">
                <img src="/Images/index/shty.png" alt="搜狐体育">
            </a>
            <a href="http://www.51running.com/" target="_blank" title="多威">
                <img src="/Images/index/duowei.png" alt="多威">
            </a>
            <a href="http://bbs.running8.com" target="_blank" title="跑吧">
                <img src="/Images/index/pb.png" alt="跑吧">
            </a>
            <a href="http://www.leevy.net/" target="_blank" title="力维">
                <img src="/Images/index/liwei.gif" alt="力维"></a>
            <a href="http://run.hupu.com/" target="_blank" title="虎扑跑步" style="margin-right: 0">
                <img src="/Images/index/hp_logo_run.jpg" alt="虎扑跑步"></a>
            <a href="http://zuicool.com/" target="_blank" title="最酷运动社区">
                <img src="/Html/images/erun360-zuicool.png" title="最酷运动社区 - 最专业的中文耐力运动资料库和社区"></a>
            <a href="http://run.gmw.cn/" target="_blank" title="光明乐跑">
                <img src="/Html/images/gmbbs.jpg" title="光明乐跑"></a>
            <!-- <a href="http://www.sportgd.com/" target="_blank" >
                <img src="/Html/images/tbh.jpg" title="体博会"></a> -->
            <a href="http://www.42trip.com/" target="_blank" title="42旅">
                <img src="/Html/images/42trip.png" title="42旅"></a>
            <a href="http://www.xnuts.cn/" target="_blank" title="极致玩家">
                <img src="/images/xnuts.jpg" title="极致玩家：中国第一户外媒体平台"></a>
            <a href="http://tw.running.biji.co/index.php" target="_blank" title="运动笔记">
                <img src="/images/ydbj.jpg" title="运动笔记"></a>
            <a href="http://www.asian-outdoor.com" target="_blank" title="南京户外展" style="margin-right: 0">
                <img src="/images/huwai.jpg" title="南京户外展"></a>

        </div>
        <div class="yqljwz">
            <a href="http://bbs.runbible.cn/" target="_blank">跑步圣经</a>
            <a href="http://fashion.junzimen.com/" target="_blank">君子门</a>
            <a href="http://edooon.com/running/" target="_blank">益动</a>
            <a href="http://www.out99.org/Home/Link#%E5%AA%92%E4%BD%93" target="_blank">户外探险</a>
            <a href="http://www.friends8.com/" target="_blank">友吧运动</a>
        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
