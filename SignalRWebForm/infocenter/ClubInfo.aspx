<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClubInfo.aspx.cs" Inherits="infocenter_ClubInfo" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %><%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title><%=RaceName%>-益跑约跑-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=B270492b31673137d9b3d5b1c8c8903a"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
        <div class="hdserchl">
            <div class="hntit">
                <a href="javascript:void(0)" class="title">益跑约跑</a>
            </div>
            <div class="hntime">
                发表于  <a href="javascript:void(0)" class="fdata"></a>
            </div>
            <div class="hnshow">
                <img src="/Html/images/ypimg.png" class="hdthumb">
                <table>
                    <tr>
                        <td><span>活动时间</span>：<a href="javascript:void(0)" class="dOpen"></a></td>
                        <td><span>人数限制</span>：<a href="javascript:void(0)" class="iLimit"></a></td>

                    </tr>
                    <tr>
                        <td><span>集合时间</span>：<a href="javascript:void(0)" class="dCollect"></a></td>
                        <td><span>活动经费</span>：<a href="javascript:void(0)" class="iFee"></a></td>

                    </tr>
                    <tr>
                        <td><span>强度</span>：<a href="javascript:void(0)" class="iStrength"></a> </td>
                        <td><span>总里程</span>：<a href="javascript:void(0)" class="iDistance"></a></td>

                    </tr>
                    <tr>
                        <td colspan="2"><p><span>活动地点</span>：<a href="javascript:void(0)" class="cAddress"></a></p></td>
                    </tr>
                    <tr>
                        <td colspan="2"><p><span>集合地点</span>：<a href="javascript:void(0)" class="cCollectAddress"></a></p></td>
                    </tr>
                    <tr>
                        <td colspan="2"><span>报名时间</span>：<a href="javascript:void(0)" class="dJoinBegin"></a></td>
                    </tr>
                    <tr>
                        <td colspan="2"><span>活动特色</span>：<a href="javascript:void(0)" class="iWinner"></a></td>
                    </tr>
                </table>
                <a class="hnbm" href="javascript:void(0)" onclick="PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();"></a>
                <a class="hnsc" href="javascript:void(0)" onclick="PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();"></a>
            </div>
            <div class="fenxiang"><a id="sharewb" href="javascript:void(0)"><img src="/Html/images/weiboc.png" alt=""> 分享到新浪微博</a> | <a href="javascript:void(0)" id="copyUrl"><img src="/Html/images/fuzhi.png" alt="" >复制地址</a> | <a href="/infocenter/PostMessage.aspx" class="article-up-iframe"><img src="/Html/images/friend.png" alt="" >分享给站内好友</a></div>
            <div class="equip"><span class="equip-ous">活动详情<em></em></span><span class=""><em></em>讨论</span><span class="userstate">成员状态<em></em></span><span class="imgshare"><em></em>图文分享</span></div>
            <div class="blog blognr">
                <div class="showmapw">
                    集合地点 <img src="/Html/images/hqx.png" alt="" />
                    <div id="showmap"></div>
                </div>
            </div>
            <div class="blog clubdisz  account">
                <form id="Form1" runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="discuss-text">
                                <ERUN360:Phiz runat="server" ID="Phiz" />
                                <textarea runat="server" name="cContent" id="cContent" style="font-size: 14px; padding: 5px;" rows="3" cols="70"></textarea>
                                <span id="lbtip" style="color: Red;" runat="server"></span>
                                <asp:Button ID="btnDiscuss" class="submit" runat="server" Text="提交" OnClick="btnDiscuss_Click" />
                            </div>
                            <ul id="text">
                                <%=DiscussList %>
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
            <div class="blog account mest">
                <span></span>
                <ul>
                </ul>
            </div>
            <div class="blog cfx account">
                <ul>
                    <li id="f01" class="listmore">点击加载更多...</li>
                </ul>
            </div>
        </div>
        <div class="hdserchr">
            <div class="hdfq">
            </div>
            <div class="hdfo">
                <span><em></em>发起的其它活动</span>
            </div>
            <div class="hdfu">
                <span>组内成员</span>
            </div>
            <div class="hdfr">
                <span>热门活动</span>
            </div>
        </div>
    </div>
    <div style="display: none">
        <div id="delbox" class="tipbox">
            <img src="/Html/images/question.png">
            确定删除？删除后不可恢复
            <br>
            <a href="javascript:void(0)" onclick="Clubtcp()" class="closeqd"></a>&nbsp;&nbsp;
        <a href="javascript:void(0)" onclick="closeqx()" class="closeqx"></a>
        </div>
        <div id="successful">
            <img src="/Html/images/true.png">
            成功
        </div>
        <div id="failure">
            <img src="/Html/images/prompt.png">
            失败
        </div>
        <div id="apply">

            <label for="name">姓名：</label><input type="text" id="name" value="<%=Name%>"/>
            <label for="tel">电话：</label><input type="text" id="tel" value="<%=tel%>" /><br />
            <label for="applybz">备注：</label><textarea id="applybz" maxlength="50"></textarea><br />
            <p>本次活动需要支付：<em></em>元 </p>
            &nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="applyqd()" class="closeqd"></a>&nbsp;&nbsp;
        <a href="javascript:void(0)" onclick="closeqx()" class="closeqx"></a>
        </div>
        <div id="Signinyp" class="tipbox">
            <img src="/Html/images/question.png">
            对该成员进行签到？
            <br>
            <a href="javascript:void(0)" onclick="Signinypf()" class="closeqd"></a>&nbsp;&nbsp;
        <a href="javascript:void(0)" onclick="closeqx()" class="closeqx"></a>
        </div>
        <div id="deleteyp" class="tipbox">
            <img src="/Html/images/question.png">
            删除该成员？删除后不可恢复
            <br>
            <a href="javascript:void(0)" onclick="deleteypf()" class="closeqd"></a>&nbsp;&nbsp;
        <a href="javascript:void(0)" onclick="closeqx()" class="closeqx"></a>
        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    <script type="text/javascript">
        idRace = <%=idRace%>
        gId = <%=gId%>
        //热门活动
        $.ajax({
            url: '/action/AjaxRace.ashx?command=toprace',
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
            },
            success: function (data) {
                $.each(data.ds, function (i, item) {
                    if (item.cImage) {
                        cimg = item.cImage
                    } else {
                        cimg = "/Html/images/ypimg.png"
                    }
                    $(".hdfr").append('<a href=\"/race/' + item.id + '.aspx\" title=\"' + item.cTitle + '\"><img src=\"' + cimg + '\"></a>')
                })
            },
            complete: function () {
                $(".cluberror").hide();
            },
            error: function (xhr) {
                $("body").append("<div class=\"cluberror\">数据加载失败</div>");
            }
        });
        //发起的其它活动
        $.ajax({
            url: '/action/AjaxRace.ashx?command=other&idRace=' + idRace,
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
            },
            success: function (data) {
                $.each(data.ds, function (i, item) {
                    if (item.cImage) {
                        cimg = item.cImage
                    } else {
                        cimg = "/Html/images/ypimg.png"
                    }
                    $(".hdfo").append('<a href=\"/race/' + item.id + '.aspx\" title=\"' + item.cTitle + '\"><img src=\"' + cimg + '\"></a>')
                })
            },
            complete: function () {
                $(".cluberror").hide();
            },
            error: function (xhr) {
                $("body").append("<div class=\"cluberror\">数据加载失败</div>");
            }
        });
        //组内成员
        $.ajax({
            url: '/action/AjaxRace.ashx?command=ClubNewMember&op=1&idRace=' + idRace,
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
            },
            success: function (data) {
                $.each(data.ds, function (i, item) {
                    $(".hdfu").append('<a href=\"/user/' + item.idUser + '.aspx\" title=\"' + item.cLoginname + '\"><img src=\"' + item.cAvatar + '\"></a>')
                })
            },
            complete: function () {
                $(".cluberror").hide();
            },
            error: function (xhr) {
                $("body").append("<div class=\"cluberror\">数据加载失败</div>");
            }
        });
        // 信息切换
        $(".equip span").click(function () {
            var a = $(this).index();
            $(".hdserchl .blog").hide();
            $(".hdserchl .blog").eq(a).show();
            $(".equip span").removeClass("equip-ous");
            $(this).addClass("equip-ous");
        })
        //留言表情
        function EmotionAdd(v) {
            document.getElementById("cContent").value += "[" + v + "]";
        }
        //$('#text').emotions();
        //获取内容
        $.ajax({
            url: '/action/AjaxRace.ashx?command=race&idRace=' + idRace,
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
                $("body").append("<div class=\"cluberror\">正在加载中...</div>");
            },
            success: function (data) {
                var iStrength = ["无", "高", "中", "低"],
                    iWinner = ["无福利", "有奖品", "有饭", "有班车", "有装备", "主题活动", "专业教练"]
                $.each(data.ds, function (i, item) {
                    if (item.gly == "1") {
                        $(".hnbm").replaceWith('');
                        $(".hnsc").replaceWith('');
                        $('.mest span').append('<b onClick="window.open(\'/infocenter/Include/RaceToExcel.aspx?id='+idRace+'\')">下载报名名单</b>')
                    } else {
                        regist()
                        Focust()
                    }
                    if (item.iFee > "0") {
                        iFee = item.iFee + "元"
                        $("#apply p em").html(item.iFee)
                        $("#apply p").show()
                    } else {
                        iFee = "免费"
                    }
                    if (item.qx == '1') {
                        $('.hntime').append('   [<a href=\"/infocenter/ToRan.aspx?uId=' + item.idUser + '&bId=' + item.idBlog + '\">编辑</a>] [<a href=\"javascript:void(0)\" onclick=\"racedel()\">删除</a>] ')
                        
                    }
                    $(".hntit .title").html(item.cTitle)
                    $(".hntit").append(item.state)
                    $(".fdata").html(item.dCreate)
                    $(".dOpen").html(item.dOpen)
                    $(".dCollect").html(item.dCollect)
                    $(".cAddress").html(item.cCityname + item.cAddress).attr('title', item.cCityname + item.cAddress);
                    $(".cCollectAddress").html(item.cCollectAddress).attr('title', item.cCollectAddress);
                    if (item.cImage) {
                        $(".hdthumb").attr('src', item.cImage).attr('onerror', 'this.src=\'/Html/images/ypimg.png\'');
                    }
                    $(".iStrength").html(iStrength[item.iStrength])
                    $(".iLimit").html(item.iLimit + "人")
                    $(".iDistance").html(item.iDistance + "km")
                    $(".iFee").html(iFee)
                    $(".dJoinBegin").html(item.dJoinBegin + "~" + item.dJoinEnd)
                    $(".iWinner").html(iWinner[item.iWinner])
                    $(".blognr").append(item.cContent)
                    if (item.cPoints) {
                        $(".showmapw").show()
                        var zb = item.cPoints
                        var zbs = new Array();
                        zbs = zb.split(",")
                        var map = new BMap.Map("showmap");
                        var newzb = new BMap.Point(zbs[0], zbs[1]);
                        map.centerAndZoom(newzb, 15);
                        map.enableScrollWheelZoom();
                        var myIcon = new BMap.Icon("/Html/images/star.png", new BMap.Size(35, 36));
                        var marker = new BMap.Marker(newzb,{icon:myIcon});
                        map.addOverlay(marker);
                    }
                    if(item.gz == "1"){
                        gz = "<a class=\"focus-a hdgz\">已关注</a>"
                    }else{
                        gz = "<a class=\"hdgz\" href=\"javascript:void(0)\" onclick=\"iFocus(" + item.idUser + ",'hdgz')\">+ 关注TA</a>"
                    }
                    ggz = ""
                    if (gId != "-1" ) {
                        $(".equip").append('<a target=\"_blank\" href=\"/infocenter/postBlog.aspx?uId=' + gId + '&from=' + idRace + '\" class=\"sharefb\"><img src=\"/Html/images/ffenxiang.png\"></a>')
                        if(item.gly != '1'){
                            ggz = gz+"<a class=\"hdly\" href=\"javascript:void(0)\" rel=\"/infocenter/PostMessage.aspx?uId=" + item.idUser + "\">给TA留言</a>"
                            $(".article-up-iframe").show()
                        }
                    }
                    $(".hdfq").html("<span>发起人</span><a href=\"/user/" + item.idUser + ".aspx\"><img src=\"" + item.cAvatar + "\"></a><a class=\"hdfname\" href=\"/user/" + item.idUser + ".aspx\">" + item.cNickName + "</a>" + ggz)
                    $(".hdfo span em").html(item.cNickName)
                    $(".hdly").on('click', function (e) {
                        $(this).colorbox({ href: $(this).attr('rel'), iframe: true, width: 432, innerHeight: 200, open: true, opacity: "0.4" });
                        e.preventDefault();
                        return false;
                    });
                    $(".article-up-iframe").on('click', function (e) {
                        $(this).colorbox({ href: $(this).attr('rel'), iframe: true, width: 432, innerHeight: 200, open: true, opacity: "0.4" });
                        e.preventDefault();
                        return false;
                    });
                    
                })
            },
            complete: function () {
                $(".cluberror").hide();
            },
            error: function (xhr) {
                $("body").append("<div class=\"cluberror\">数据加载失败</div>");
            }
        });
        //获取报名状态
        function regist() {
            $.get("/action/AjaxRace.ashx", { idRace: idRace, command: "apply", op: 0 }, function (data) {
                if (data == "0") {
                    //未报名
                    $(".hnbm").replaceWith('<a class=\"hnbm\" href=\"javascript:void(0)\" onclick=\"apply()\"></a>');
                } else if (data == "1") {
                    //未付款
                    $(".hnbm").replaceWith('<a class=\"hnbm yppay\" href=\"javascript:void(0)\" onclick=\"pay()\"></a>');
                } else if (data == "2") {
                    //已报名
                    $(".hnbm").replaceWith('<a class=\"hnbm bmy\" href=\"javascript:void(0)\"></a>');
                } else if (data == "6") {
                    //未开始
                    $(".hnbm").replaceWith('<a class=\"hnbm wkais\" href=\"javascript:void(0)\"></a>');
                } else if (data == "4") {
                    //人已满
                    $(".hnbm").replaceWith('<a class=\"hnbm bmm\" href=\"javascript:void(0)\"></a>');
                } else if (data == "5") {
                    //报名截止
                    $(".hnbm").replaceWith('<a class=\"hnbm bmz\" href=\"javascript:void(0)\"></a>');
                } else if (data == "-2") {
                    //不存在 跳转到搜索页
                    window.location.href = '/infocenter/ClubSearch.aspx'
                }
            });
        }
        //获取关注状态
        function Focust() {
            $.get("/action/AjaxRace.ashx", { idRace: idRace, command: "focus", op: 0 }, function (data) {
                if (data == "2") {
                    //已关注
                    $(".hnsc").replaceWith('<a class=\"hnsc ygz\" href=\"javascript:void(0)\"></a>');
                } else if (data == "3") {
                    //未关注
                    $(".hnsc").replaceWith('<a class=\"hnsc\" href=\"javascript:void(0)\" onclick=\"focusyp()\"></a>');
                }
            });
        }
        function pay() {
            window.location.href = '/infocenter/RacePay.aspx?id=' + idRace;
        }

        function apply() {
            $.colorbox({ inline: true, href: "#apply", width: "471px", height: "282px", opacity: "0.4" });
        }
        function applyqd() {
            $.get("/action/AjaxRace.ashx", { idRace: idRace, command: "apply", op: 1, name: encodeURIComponent($("#name").val()), tel: $("#tel").val(), bz: encodeURIComponent($("#applybz").val()) }, function (data) {
                if (data == "-1") {
                    //未登录
                    PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();

                } else if (data == "1") {
                    //成功
                    $.colorbox({ inline: true, href: "#successful", width: "266px", height: "102px", opacity: "0.4" });
                    setTimeout("$.colorbox.close();", 2000);                    
                    $(".hnbm").replaceWith('<a class=\"hnbm bmy\" href=\"javascript:void(0)\"></a>');
                    location.href = "/infocenter/RacePay.aspx?id=" + idRace;
                } else if (data == "0") {
                    //失败
                    $.colorbox({ inline: true, href: "#failure", width: "266px", height: "102px", opacity: "0.4" });
                    setTimeout("window.location.reload()", 2000);

                }
            });
        }
        function focusyp() {
            $.get("/action/AjaxRace.ashx", { idRace: idRace, command: "focus", op: 1 }, function (data) {
                if (data == "-1") {
                    //未登录
                    PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();

                } else if (data == "1") {
                    //成功
                    $.colorbox({ inline: true, href: "#successful", width: "266px", height: "102px", opacity: "0.4" });
                    setTimeout("$.colorbox.close();", 2000);
                    $(".hnsc").replaceWith('<a class=\"hnsc ygz\" href=\"javascript:void(0)\"></a>');
                } else if (data == "0") {
                    //失败
                    $.colorbox({ inline: true, href: "#failure", width: "266px", height: "102px", opacity: "0.4" });
                    setTimeout("window.location.reload()", 2000);

                } else if (data == "2") {
                    //已关注
                    $.colorbox({ inline: true, href: "#successful", width: "266px", height: "102px", opacity: "0.4" });
                    setTimeout("$.colorbox.close();", 2000);
                    $(".hnsc").replaceWith('<a class=\"hnsc ygz\" href=\"javascript:void(0)\"></a>');
                }
            });
        }
        function iFocus(idx, thisa) {
            var thisa = "." + thisa;
            function thisare() {
                $(thisa).replaceWith("<a class=\"focus-a hdgz\">已关注</a>")
            }
            if (confirm("确定要关注吗？") == true) {
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
        }
        //成员状态
        mest = "0"
        $(".userstate").click(function (event) {
            if (mest == "0") {
                $.ajax({
                    url: '/action/AjaxRace.ashx?command=ClubNewMember&op=2&idRace=' + idRace,
                    type: 'get',
                    dataType: 'json',
                    contentType: 'application/json;charset=utf-8',
                    cache: false,
                    beforeSend: function () {
                    },
                    success: function (data) {
                        $(".mest span").append("已有" + data.bmcount + "人报名、" + data.wfkCount + "人未付款、" + data.count + "人签到")

                        $.each(data.ds, function (i, item) {
                            if (item.iStatus == "3") {
                                iStatus = '<em></em>'
                            } else {
                                iStatus = ''
                            }
                            if (item.cName) {
                                cName = item.cName
                                cstyle = "style=\"height:214px;line-height: 18px;\""
                            } else {
                                cName = ''
                                cstyle = ''
                            }
                            if (item.cTel) {
                                cTel = item.cTel
                                cstyle = "style=\"height:214px;line-height: 18px;\""
                            } else {
                                cTel = ''
                                cstyle = ''
                            }
                            var fk = ''
                            if(item.iStatus==1){
                                fk = '<i></i>'
                            }

                            $(".mest ul").append('<li '+cstyle+'><a data-mest=\"' + item.idUser + '\" href=\"/user/' + item.idUser + '.aspx\" title=\"' + item.cLoginname + '\"><img src=\"' + item.cAvatar + '\">' + item.cLoginname + '</a>' + '<br>' + cName + '&nbsp;&nbsp;' + cTel + iStatus + fk+'</li>')
                        })
                        mest = "1"
                        $(".mest a").on('click', function(event) {
                            event.preventDefault()
                            var idUser = $(this).data('mest')
                                url    = $(this).attr('href')
                            $.get("/action/AjaxRace.ashx", { command: "qdel", idRace: idRace,idUser:idUser,op:0 }, function (data) {
                                if (data == "0" || data == "-1" ) {
                                    location.href = url
                                }else if(data == "1"){
                                    //签到
                                    $.colorbox({ inline: true, href: "#Signinyp", width: "306px", height: "132px", opacity: "0.4" });
                                    $("#Signinyp .closeqd").replaceWith('<a href=\"javascript:void(0)\" onclick=\"Signinypf('+idUser+')\" class=\"closeqd\"></a>');
                                }else if(data == "2"){
                                    //删除
                                    $.colorbox({ inline: true, href: "#deleteyp", width: "306px", height: "132px", opacity: "0.4" });
                                    $("#deleteyp .closeqd").replaceWith('<a href=\"javascript:void(0)\" onclick=\"deleteypf('+idUser+')\" class=\"closeqd\"></a>');
                                }
                            });
                        });
                    },
                    complete: function () {
                        $(".cluberror").hide();
                    },
                    error: function (xhr) {
                        $("body").append("<div class=\"cluberror\">数据加载失败</div>");
                    }
                });
            }
        });
        function Signinypf(idUser){
            $.get("/action/AjaxRace.ashx", { command: "qdel", idRace: idRace,idUser:idUser,op:1 }, function (data) {
                if (data == "-2" ) {
                    location.href = "/infocenter/ClubSearch.aspx"
                }else if(data == "-1"){
                    PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
                }else if(data == "0" || data == "2"){
                    location.reload() 
                }else if(data == "1"){
                    $.colorbox({ inline: true, href: "#successful", width: "266px", height: "102px", opacity: "0.4" });
                    $(".mest a[data-mest="+idUser+"]").parent("li").append('<em></em>')
                    setTimeout("$.colorbox.close();", 2000);
                }
            });
        }
        function deleteypf(idUser){
            $.get("/action/AjaxRace.ashx", { command: "qdel", idRace: idRace,idUser:idUser,op:1 }, function (data) {
                if (data == "-2" ) {
                    location.href = "/infocenter/ClubSearch.aspx"
                }else if(data == "-1"){
                    PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
                }else if(data == "0" || data == "2"){
                    location.reload() 
                }else if(data == "1"){
                    $.colorbox({ inline: true, href: "#successful", width: "266px", height: "102px", opacity: "0.4" });
                    $(".mest a[data-mest="+idUser+"]").parent("li").remove()
                    setTimeout("$.colorbox.close();", 2000);
                }
            });
        }
        //获取博文
        function pageup(pageIndex, pageSize, divid) {
            //data = "pageIndex="+pageIndex+"&pageSize="+pageSize;
            $.ajax({
                url: '/action/AjaxRace.ashx?command=blog&pageIndex=' + pageIndex + '&pageSize=' + pageSize + '&idRace=' + idRace,
                type: 'get',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                cache: false,
                beforeSend: function () {
                },
                success: function (data) {
                    var pagenum = data.count,
                        pagedata = data.ds
                    $.each(pagedata, function (i) {
                        if (pagedata[i].Thumbnails) {
                            cimg = pagedata[i].Thumbnails
                        } else {
                            cimg = ''
                        }
                        $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\">" + pagedata[i].cAvatar + "</a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cLoginname + "</a> 发布博文：<a target=\"_blank\" href=\"/blog/" + pagedata[i].id + ".aspx\">" + pagedata[i].cTitle + "</a><p>" + pagedata[i].cContent + cimg + "</p><div class=\"relevance\">" + pagedata[i].dCreate + "<span>阅读(" + pagedata[i].iShowTimes + ") 关注(" + pagedata[i].iFocus + ") 顶(" + pagedata[i].iDing + ") 评论(" + pagedata[i].iDiscuss + ") </span></div></li>");
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
        imgshare = "0"
        $(".imgshare").click(function (event) {
            if (imgshare == "0") {
                pageup("1", "10", "#f01");
                imgshare = "1"
            }
        });
        var thispage = "2"
        $("#f01").click(function () {
            pageup(thispage, "10", "#f01");
            thispage++
        })
        function racedel() {
            $.colorbox({ inline: true, href: "#delbox", width: "306px", height: "132px", opacity: "0.4" });
        }
        function closeqx() {
            $.colorbox.close();
        }
        function Clubtcp() {
            $.ajax({
                url: '/action/AjaxRace.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "del", idRace: idRace },
                success: function (data) {
                    //$.colorbox.close();
                    if (data == "-1") {
                        //未登录弹出登录框
                        $(".Clubtc").replaceWith(shenqing)
                        PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
                    } else if (data == "0") {
                        //失败提示不存在
                        $.colorbox({ inline: true, href: "#failure", width: "266px", height: "102px", opacity: "0.4" });
                        setTimeout("window.location.href='/infocenter/Running.aspx?uId=" + gId + "'", 2000);
                    } else if (data == "1") {
                        //成功
                        $.colorbox({ inline: true, href: "#successful", width: "266px", height: "102px", opacity: "0.4" });
                        setTimeout("window.location.href='/infocenter/Running.aspx?uId=" + gId + "'", 2000);
                    }
                }
            });
        }
//复制插件
$(document).ready(function(){
    thisurl = window.location.href
    $('#copyUrl').zclip({
        path:'/Html/js/ZeroClipboard.swf',
        copy:thisurl
    });
    $("#sharewb").click(function(event) {
        window.open("http://service.weibo.com/share/share.php?url="+thisurl+"&type=button&ralateUid=2961848493&language=zh_cn&appkey=1VDwW4&searchPic=true&style=simple")
    });
});
    </script>
</body>
</html>
