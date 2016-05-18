<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="infocenter_Default" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Src="~/Controls/Erun_Right.ascx" TagPrefix="ERUN360" TagName="Erun_Right" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<script type="text/javascript" src="/Html/js/echarts.js" charset="UTF-8"></script>
<form id="form1" runat="server">
<article>
    <style type="text/css">
        .main-left{left: 0;}
    </style>
<ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right">
        <div class="main-right-a">
            <%if (cId == uId) %>
            <%{ %>
            <div class="chart" >
                <div class="chartdtitle">我的训练记录</div>
                <div id="chart">

                </div>
            </div>
            <div class="gofunctionbox">
                <a href="/infocenter/postBlog.aspx">发布博文</a>
                <a href="/infocenter/Trained.aspx">发布训练成绩</a>
                <a href="/infocenter/PostEquip.aspx">发布装备</a>
                <a href="/infocenter/Competition.aspx?tablep=signupevent">报名的赛事</a>
            </div>
            <ul class="c-list">
                <li id="b00" class="c-dq">全部内容</li>
                <li id="b01">博文</li>
                <!-- <li>约跑<em></em></li> -->
                <li id="b03">活动</li>
                <li id="b04">赛事</li>
            </ul>
            <%--好友的全部内容--%>
            <ul class="content">
                <li id="c01" class="listmore">查看更多</li>
            </ul>
            <%--好友的博文--%>
            <ul class="content account infonone">
                <li id="c02" class="listmore">查看更多</li>
            </ul>
            <!-- <div class="pages">
            </div> -->
            <%--好友的约跑--%>
            <!-- <ul class="content account">
            <li><a href="/" class="user-head" target="_blank">
                <img src="../Html/images/wl/2.png" alt=""></a>
                <a href="/">赵小钊 </a>发布约跑：<a href="/">一位真正男人的不朽遗赠</a>
                <p>
                    约跑时间：2013.1.2       地点：奥森南园
	<img src="../Html/images/wl/2.png" alt="">
                </p>
                <div class="relevance">
                    2012-12-12  15:12:50
			<span>阅读(333) 关注(1) 顶(5) 评论(5) </span>
                </div>
            </li>
        </ul> -->
            <%--好友的活动--%>
            <ul class="content account infonone">
                <li id="c03" class="listmore">查看更多</li>
            </ul>
            <%--好友的赛事--%>
            <ul class="content account infonone">
                <li id="c04" class="listmore">查看更多</li>
            </ul>
            <%} %>
            <%else %>
            <%{ %>
            <div class="iscard">
                <div class="iscardl">跑界名片</div>
                <div class="iscardr">
                    <%if (iMarathontype != 0) %>
                    <%{ %>
                    + <%=iRunyear %>年 开始跑步
                <br>
                    + 参加过<%=iMarathon %>场马拉松 | 越野跑<%=iTrail %>场
                <br>
                    + 最好成绩：<%=(iMarathontype==1)?"全程马拉松":"半程马拉松" %>  <%=tMarathontime %>
                    <br>
                    + 最满意的比赛：<%=cBio %>
                    <br>
                    + 参加过的赛事：<%=cRacename %>
                    <%} %>
                    <%else %>
                    <%{ %>Ta还没有填写名片
                <%} %>
                </div>
                <a class="iscardmore" href="/infocenter/baseinfo.aspx?uid=<%=Request["uid"] %>">查看全部</a>
            </div>
            <ul class="c-list c-list-frid">
                <li class="c-dq">TA的全部内容<em></em></li>
            </ul>
            <ul class="content">
                <li id="f01" class="listmore">查看更多</li>
            </ul>
            <%} %>
        </div>
        <%--右侧--%>
        <ERUN360:Erun_Right runat="server" ID="Erun_Right" />
    </div>
</article>
<script type="text/javascript">
    custom = function(){
       setTimeout(function(){location.reload() },1000) 
    }
<%if (cId == uId) %>
<%{ %>
var myChart1 = echarts.init(document.getElementById('chart'));
var option1 = {
    tooltip: {
        trigger: 'item'
    },
    toolbox: {
        show: true,
        feature: {
            dataView: {show: false},
            restore: {show: true},
            saveAsImage: {show: true}
        }
    },
    calculable: true,
    grid: {
        borderWidth: 0,
        y2: 0,
        x:10,
        x2:10
    },
    xAxis: [
        {
            type: 'category',
            show: false,
            data: ['前11周','前10周','前9周','前8周','前7周','前6周','前5周','前4周','前3周','前2周','上周','本周']
        }
    ],
    yAxis: [
        {
            type: 'value',
            show: false
        }
    ],
    series: [
        {
            name: '训练统计',
            type: 'bar',
            itemStyle: {
                normal: {
                    color: function(params) {
                        var colorList = [
                          '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
                        ];
                        return colorList[params.dataIndex]
                    },
                    label: {
                        show: true,
                        position: 'top',
                        formatter: '{b}\n{c}km'
                    }
                }
            },
            data: <%=weekData%>
        }
    ]
};
// 

myChart1.setOption(option1);
<%} %>

    jQuery(document).ready(function ($) {
        function pageup(pageIndex, pageSize, uid, divid, group) {
    $.AMUI.progress.start();
            //data = "pageIndex="+pageIndex+"&pageSize="+pageSize;
            $.ajax({
                url: '/action/AjaxJson.ashx?command=HomeList&pageIndex=' + pageIndex + '&pageSize=' + pageSize + '&uId=<%=uId%>&group=' + group,
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
                        if (pagedata[i].cImageUrl) {
                            cimg = "<img src=\"" + pagedata[i].cImageUrl + "\">"
                        } else {
                            cimg = ""
                        }
                        switch (pagedata[i].idGroup) {
                            case "11":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> 关注了：<a target=\"_blank\"  href=\"/user/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><div class=\"relevance\">" + pagedata[i].dCreate + "</div></li>");
                                break;
                            case "12":;
                            case "14":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> 关注了：<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><div class=\"relevance\">" + pagedata[i].dCreate + "</div></li>");
                                break;
                            case "13":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> 关注了：<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a>&nbsp;&nbsp;</li>");
                                break;
                            case "22":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> 发布博文：<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><p><span>" + pagedata[i].dCreate +"</span>"+ pagedata[i].cBio + cimg+"</p><div class=\"relevance\">阅读(" + pagedata[i].iShowTimes + ") 关注(" + pagedata[i].iFocus + ") 顶(" + pagedata[i].iDing + ") 评论(" + pagedata[i].iDiscuss + ") </div></li>");
                                break;
                            case "23":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> 发布赛事：<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><p>" + pagedata[i].cBio + cimg + "</p><div class=\"relevance\">" + pagedata[i].dCreate + "<span>阅读(" + pagedata[i].iShowTimes + ") 关注(" + pagedata[i].iFocus + ") 顶(" + pagedata[i].iDing + ") 评论(" + pagedata[i].iDiscuss + ") </span></div></li>");
                                break;
                            case "24":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> 发布装备：<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><p>" + pagedata[i].cBio + cimg + "</p><div class=\"relevance\">" + pagedata[i].dCreate + "<span>阅读(" + pagedata[i].iShowTimes + ") 关注(" + pagedata[i].iFocus + ") 顶(" + pagedata[i].iDing + ") 评论(" + pagedata[i].iDiscuss + ") </span></div></li>");
                                break;
                            case "25":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a>&nbsp;&nbsp;<em>" + pagedata[i].cTitle + "</em></li>");
                                break;
                            case "26":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> 发布约跑：<a target=\"_blank\" href=\"/race/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><p>" + pagedata[i].cBio + (pagedata[i].cImageUrl==''?"":"<img src=\"" + pagedata[i].cImageUrl + "\">") +"</p><div class=\"relevance\">" + pagedata[i].dCreate + "</div></li>");
                                break;
                            case "32":;
                            case "33":;
                            case "34":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> 评论了：<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><div class=\"relevance\">" + pagedata[i].dCreate + "</div></li>");
                                break;
                            case "44":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a>    " + pagedata[i].cTitle + "</a><div class=\"relevance\">" + pagedata[i].dCreate + "</div></li>");
                                break;
                            case "46":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> 在约跑赛" + pagedata[i].cTitle + "</a><p>" + pagedata[i].cBio + cimg + "</p><div class=\"relevance\">" + pagedata[i].dCreate + "<span>阅读(" + pagedata[i].iShowTimes + ") 关注(" + pagedata[i].iFocus + ") 顶(" + pagedata[i].iDing + ") 评论(" + pagedata[i].iDiscuss + ") </span></div></li>");
                                break;
                            case "51":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a>    " + pagedata[i].cTitle + "</a><div class=\"relevance\">" + pagedata[i].dCreate + "</div></li>");
                                break;
                        }
                    })
                    thiscount = data.count;
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
        <%if (cId == uId) %>
             <%{ %>
        //全部内容
        pageup("1", "10", '<%=uId%>', "#c01", "0");
        var thispage = "2"
        $("#c01").click(function () {
            pageup(thispage, "10", '<%=uId%>', "#c01", "0");
            thispage++
        })
        <%} %><%else %><%{ %>
        //他人的全部内容
        pageup("1", "10", '<%=uId%>', "#f01", "0");
        var thispage = "2"
        $("#f01").click(function () {
            pageup(thispage, "10", '<%=uId%>', "#f01", "0");
            thispage++
        })
                <%} %>
        //好友的博文
        var page22state = "on";
        $("#b01").click(function () {
            if (page22state == "on") {
                pageup("1", "10", '<%=uId%>', "#c02", "22");
                page22state = "off";
            }
        })
        var thispage22 = "2";
        $("#c02").click(function () {
            pageup(thispage22, "10", '<%=uId%>', "#c02", "22");
            thispage22++
        })
        //好友的活动
        var page25state = "on";
        $("#b03").click(function () {
            if (page25state == "on") {
                pageup("1", "10", '<%=uId%>', "#c03", "25");
                page25state = "off";
            }
        })
        var thispage25 = "2"
        $("#c03").click(function () {
            pageup(thispage25, "10", '<%=uId%>', "#c03", "25");
            thispage25++
        })
        //好友的赛事
        var page13state = "on";
        $("#b04").click(function () {
            if (page13state == "on") {
                pageup("1", "10", '<%=uId%>', "#c04", "13");
                page13state = "off";
            }
        })
        var thispage13 = "2"
        $("#c04").click(function () {
            pageup(thispage13, "10", '<%=uId%>', "#c04", "13");
            thispage13++
        })
        //分页end***************************************************      
        //留言
        $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
        //跑量提交
        $(".chartbot").click(function () {
            document.getElementById("_contents").style.visibility = "hidden";
            var idRoadStyle = $("#idRoadStyle").val(),
                roadtime = $("#roadtime").val()=="选择时间"?"":$("#roadtime").val(),
                iDistance = $("#iDistance").val()
                location.href="/infocenter/Trained.aspx?uId=<%=uId%>&idRoadStyle=" + idRoadStyle + "&time=" + roadtime + "&iDistance=" + iDistance
            // $.ajax({
            //     url: "/infocenter/Include/AjaxQuery.aspx?method=trained&idRoadStyle=" + idRoadStyle + "&time=" + roadtime + "&iDistance=" + iDistance,
            //     type: 'GET',
            //     dataType: 'text',
            //     cache: false,
            //     success: function (data, textStatus, xhr) {
            //         if (data == "1") {
            //             focuscont = "<img src=\"/Html/images/right.png\"> 提交成功";
            //         } else if (data == "0") {
            //             focuscont = "<img src=\"/Html/images/false.png\">请填写时间跑量";
            //         } else {
            //             focuscont = "<img src=\"/Html/images/false.png\">" + data;
            //         }

            //         function thisare() {
            //             $(".focusalert").remove()
            //         }

            //         $(".chartbot").append("<div class=\"focusalert\">" + focuscont + "</div>");
            //         setTimeout(thisare, 2000);
            //     },
            //     error: function (xhr, textStatus, errorThrown) {
            //         //called when there is an error
            //     }
            // });
        })
        $(".closemsg").click(function () {
            $(".messageadmin").hide();
        });
        $(".c-list li").click(function () {
            var a = $(this).index();
            $(".main-right-a .content").hide();
            $(".main-right-a .content").eq(a).show();
            $(".c-list li").removeClass("c-dq");
            $(this).addClass("c-dq");
        })
        // 关注ajax
        $(".recomul li").each(function () {
            var thisurl = $(this).find(".focus").attr("href"),
                thisnum = $(this).index()
            $(this).find(".focus").attr("href", "javascript:void(0)");
            $(this).find(".focus").attr("rel", thisurl)
            $(this).find(".focus").addClass("focus" + thisnum);
            $(this).find(".focus-ta").addClass("focus" + thisnum);
        })
        $(".focus").click(function () {
            var focusurl = $(this).attr("rel"),
                focuscont = "",
                thisindex = $(this).attr("class").substr(6)
            $.ajax({
                url: focusurl,
                type: 'GET',
                dataType: 'text',
                cache: false,
                success: function (data, textStatus, xhr) {
                    if (data == "1") {
                        $(".toast").html('关注成功').show().addClass('toast-success')
                    } else {
                        $(".toast").html(data).show().addClass('toast-success')
                        focuscont = "<img src=\"/Html/images/false.png\">" + data;
                    }
                    errorboxhide()   
                    var thisa = "." + thisindex;
                    function thisare() {
                        $(thisa).parent("li").remove()
                    }
                    setTimeout(thisare, 2000);
                },
                error: function (xhr, textStatus, errorThrown) {
                    //called when there is an error
                }
            });
        })
        //关注他的粉丝
        $(".focus-ta").click(function () {
            var focusurl = $(this).attr("rel"),
                focuscont = "",
                thisindex = $(this).attr("class").substr(9)
            $.ajax({
                url: focusurl,
                type: 'GET',
                dataType: 'text',
                cache: false,
                success: function (data, textStatus, xhr) {
                    if (data == "1") {
                        focuscont = "<img src=\"/Html/images/right.png\"> 关注成功";
                    } else {
                        focuscont = "<img src=\"/Html/images/false.png\">" + data;
                    }
                    var thisa = "." + thisindex;
                    function thisare() {
                        $(".focusalert").remove()
                    }
                    $(thisa).append("<div class=\"focusalert\">" + focuscont + "</div>");
                    setTimeout(thisare, 2000);
                },
                error: function (xhr, textStatus, errorThrown) {
                    //called when there is an error
                }
            });
        })
    });
</script>
</form>
<ERUN360:footerv3 runat="server" ID="footerv3" />