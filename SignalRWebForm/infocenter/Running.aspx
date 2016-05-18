<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Running.aspx.cs" Inherits="infocenter_Running" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
    <script type="text/javascript" src="../Html/js/modernizr.js"></script>
    <div class="wrap">
        <article>
            <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
            <div class="main-right">
                <%if (cId == uId) %>
                <%{ %>
                <div class="equip"><span id="b01" class="equip-ous">全部约跑</span><span id="b02">我发起的</span><span id="b03">我参加的</span><span id="b04">我关注的</span><%=AddRace %></div>
                <ul class="article">
                    <li id="c01" class="listmore">查看更多</li>
                </ul>
                <ul class="article account">
                    <li id="c02" class="listmore">查看更多</li>
                </ul>
                <ul class="article account">
                    <li id="c03" class="listmore">查看更多</li>
                </ul>
                <ul class="article account">
                    <li id="c04" class="listmore">查看更多</li>
                </ul>
                <%} %>
                <%else %>
                <%{ %>
                <div class="equip"><span class="equip-ous">TA的约跑</span></div>
                <ul class="article running">
                    <li id="f01" class="listmore">查看更多</li>
                </ul>
                <%} %>
            </div>
        </article>
    </div>
    <script type="text/javascript">
custom = function(){
    window.location.reload()
}
        $(".equip span").click(function () {
            var a = $(this).index();
            $("article .article").hide();
            $("article .article").eq(a).show();
            $(".equip span").removeClass("equip-ous");
            $(this).addClass("equip-ous");
        })
        jQuery(document).ready(function ($) {
            //加载基本数据
            function pageup(pageIndex, pageSize, uid, divid, op) {
                $.AMUI.progress.start();
                $.ajax({
                    url: '/action/AjaxRace.ashx',
                    data: { command: "raceList", uId: uid, pageIndex: pageIndex, pageSize: pageSize, op: op, rnd: Math.random() },
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
                            if (op == "4")
                            {
                                $(divid).before("<li><a target=\"_blank\" href=\"/race/" + pagedata[i].id + ".aspx\" class=\"title\"><em>发起了：</em>" + pagedata[i].cTitle + "</a>" + pagedata[i].state + "<br/><span>" + pagedata[i].dOpen + "</span><p>" + pagedata[i].cContent + "<br>" + pagedata[i].Thumbnails + "</p><div class=\"article-bot\"><a target=\"_blank\" href=\"/race/" + pagedata[i].id + ".aspx\">查看全文>></a></div></li>");
                            }
                            else
                            {
                                $(divid).before("<li><a target=\"_blank\" href=\"/race/" + pagedata[i].id + ".aspx\" class=\"title\">" + pagedata[i].cTitle + "</a>" + pagedata[i].state + "<br/><span>  发起人：<a target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cLoginname + "</a>  活动时间：" + pagedata[i].dOpen + "</span><p>" + pagedata[i].cContent + "<br>" + pagedata[i].Thumbnails + "</p><div class=\"article-bot\"><a target=\"_blank\" href=\"/race/" + pagedata[i].id + ".aspx\">查看全文>></a></div></li>");
                            }
                        })
                        thiscount = data.count;
                        //$("ul li span a").css("float", "right");
                        $("ul li span a").css("display", "inline");
                        $.AMUI.progress.done();
                    },
                    complete: function () { //生成分页条
                        if (thiscount == "") {
                            $(divid).html("木有了，别点了");
                        } else {
                            $(divid).html("点击加载更多...");
                        }
                    },
                    error: function (xhr) {
                    }

                });
            }
            $("article .article span").addClass("float", "right");
            //加载基本数据
            function pageup1(pageIndex, pageSize, uid, divid) {
                $.ajax({
                    url: '/action/AjaxRace.ashx',
                    data: { command: "raceList", uId: uid, pageIndex: pageIndex, pageSize: pageSize, rnd: Math.random() },
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
                            $(divid).before("<li><a target=\"_blank\" href=\"/race/" + pagedata[i].id + ".aspx\" class=\"title\">" + pagedata[i].cTitle + "</a>" + pagedata[i].state + "<br/><span>  发起人：<a target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cLoginname + "</a>  活动时间：" + pagedata[i].dOpen + "</span><p>" + pagedata[i].cContent + "" + pagedata[i].Thumbnails + "</p><div class=\"article-bot\"><a target=\"_blank\" href=\"/race/" + pagedata[i].id + ".aspx\">查看全文>></a></div></li>");


                        })
                        thiscount = data.count;
                    },
                    complete: function () { //生成分页条
                        if (thiscount == "") {
                            $(divid).html("木有了，别点了");
                        } else {
                            $(divid).html("点击加载更多...");
                        }
                    },
                    error: function (xhr) {
                    }

                });
            }
            <%if (cId == uId) %>
			<%{ %>
            //全部内容0
            pageup("1", "10", '<%=uId%>', "#c01", "0");
            var thispage = "2"
            $("#c01").click(function () {
                pageup(thispage, "10", '<%=uId%>', "#c01", "0");
                thispage++
            })
			<%} %><%else %><%{ %>
            //他人的全部内容4
            pageup("1", "10", '<%=uId%>', "#f01", "4");
            var thispage = "2"
            $("#f01").click(function () {
                pageup(thispage, "10", '<%=uId%>', "#f01", "4");
                thispage++
            })
			<%} %>
            //我发起的       1
            var page22state = "on";
            $("#b02").click(function () {
                if (page22state == "on") {
                    pageup("1", "10", '<%=uId%>', "#c02", "1");
                    page22state = "off";
                }
            })
            var thispage22 = "2";
            $("#c02").click(function () {
                pageup(thispage22, "10", '<%=uId%>', "#c02", "1");
                thispage22++
            })
            //我参加的   2
            var page25state = "on";
            $("#b03").click(function () {
                if (page25state == "on") {
                    pageup("1", "10", '<%=uId%>', "#c03", "2");
                    page25state = "off";
                }
            })
            var thispage25 = "2"
            $("#c03").click(function () {
                pageup(thispage25, "10", '<%=uId%>', "#c03", "2");
                thispage25++
            })
            //我关注的        3
            var page13state = "on";
            $("#b04").click(function () {
                if (page13state == "on") {
                    pageup("1", "10", '<%=uId%>', "#c04", "3");
                    page13state = "off";
                }
            })
            var thispage13 = "2"
            $("#c04").click(function () {
                pageup(thispage13, "10", '<%=uId%>', "#c04", "3");
                thispage13++
            })
        })
    </script>
<ERUN360:footerv3 runat="server" ID="footerv3" />