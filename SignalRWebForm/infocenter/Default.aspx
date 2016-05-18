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
                <div class="chartdtitle">�ҵ�ѵ����¼</div>
                <div id="chart">

                </div>
            </div>
            <div class="gofunctionbox">
                <a href="/infocenter/postBlog.aspx">��������</a>
                <a href="/infocenter/Trained.aspx">����ѵ���ɼ�</a>
                <a href="/infocenter/PostEquip.aspx">����װ��</a>
                <a href="/infocenter/Competition.aspx?tablep=signupevent">����������</a>
            </div>
            <ul class="c-list">
                <li id="b00" class="c-dq">ȫ������</li>
                <li id="b01">����</li>
                <!-- <li>Լ��<em></em></li> -->
                <li id="b03">�</li>
                <li id="b04">����</li>
            </ul>
            <%--���ѵ�ȫ������--%>
            <ul class="content">
                <li id="c01" class="listmore">�鿴����</li>
            </ul>
            <%--���ѵĲ���--%>
            <ul class="content account infonone">
                <li id="c02" class="listmore">�鿴����</li>
            </ul>
            <!-- <div class="pages">
            </div> -->
            <%--���ѵ�Լ��--%>
            <!-- <ul class="content account">
            <li><a href="/" class="user-head" target="_blank">
                <img src="../Html/images/wl/2.png" alt=""></a>
                <a href="/">��С�� </a>����Լ�ܣ�<a href="/">һλ�������˵Ĳ�������</a>
                <p>
                    Լ��ʱ�䣺2013.1.2       �ص㣺��ɭ��԰
	<img src="../Html/images/wl/2.png" alt="">
                </p>
                <div class="relevance">
                    2012-12-12  15:12:50
			<span>�Ķ�(333) ��ע(1) ��(5) ����(5) </span>
                </div>
            </li>
        </ul> -->
            <%--���ѵĻ--%>
            <ul class="content account infonone">
                <li id="c03" class="listmore">�鿴����</li>
            </ul>
            <%--���ѵ�����--%>
            <ul class="content account infonone">
                <li id="c04" class="listmore">�鿴����</li>
            </ul>
            <%} %>
            <%else %>
            <%{ %>
            <div class="iscard">
                <div class="iscardl">�ܽ���Ƭ</div>
                <div class="iscardr">
                    <%if (iMarathontype != 0) %>
                    <%{ %>
                    + <%=iRunyear %>�� ��ʼ�ܲ�
                <br>
                    + �μӹ�<%=iMarathon %>�������� | ԽҰ��<%=iTrail %>��
                <br>
                    + ��óɼ���<%=(iMarathontype==1)?"ȫ��������":"���������" %>  <%=tMarathontime %>
                    <br>
                    + ������ı�����<%=cBio %>
                    <br>
                    + �μӹ������£�<%=cRacename %>
                    <%} %>
                    <%else %>
                    <%{ %>Ta��û����д��Ƭ
                <%} %>
                </div>
                <a class="iscardmore" href="/infocenter/baseinfo.aspx?uid=<%=Request["uid"] %>">�鿴ȫ��</a>
            </div>
            <ul class="c-list c-list-frid">
                <li class="c-dq">TA��ȫ������<em></em></li>
            </ul>
            <ul class="content">
                <li id="f01" class="listmore">�鿴����</li>
            </ul>
            <%} %>
        </div>
        <%--�Ҳ�--%>
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
            data: ['ǰ11��','ǰ10��','ǰ9��','ǰ8��','ǰ7��','ǰ6��','ǰ5��','ǰ4��','ǰ3��','ǰ2��','����','����']
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
            name: 'ѵ��ͳ��',
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
                    $(divid).html("<span class=\"load\"></span>���ڼ�����...");
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
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> ��ע�ˣ�<a target=\"_blank\"  href=\"/user/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><div class=\"relevance\">" + pagedata[i].dCreate + "</div></li>");
                                break;
                            case "12":;
                            case "14":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> ��ע�ˣ�<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><div class=\"relevance\">" + pagedata[i].dCreate + "</div></li>");
                                break;
                            case "13":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> ��ע�ˣ�<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a>&nbsp;&nbsp;</li>");
                                break;
                            case "22":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> �������ģ�<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><p><span>" + pagedata[i].dCreate +"</span>"+ pagedata[i].cBio + cimg+"</p><div class=\"relevance\">�Ķ�(" + pagedata[i].iShowTimes + ") ��ע(" + pagedata[i].iFocus + ") ��(" + pagedata[i].iDing + ") ����(" + pagedata[i].iDiscuss + ") </div></li>");
                                break;
                            case "23":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> �������£�<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><p>" + pagedata[i].cBio + cimg + "</p><div class=\"relevance\">" + pagedata[i].dCreate + "<span>�Ķ�(" + pagedata[i].iShowTimes + ") ��ע(" + pagedata[i].iFocus + ") ��(" + pagedata[i].iDing + ") ����(" + pagedata[i].iDiscuss + ") </span></div></li>");
                                break;
                            case "24":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> ����װ����<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><p>" + pagedata[i].cBio + cimg + "</p><div class=\"relevance\">" + pagedata[i].dCreate + "<span>�Ķ�(" + pagedata[i].iShowTimes + ") ��ע(" + pagedata[i].iFocus + ") ��(" + pagedata[i].iDing + ") ����(" + pagedata[i].iDiscuss + ") </span></div></li>");
                                break;
                            case "25":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a>&nbsp;&nbsp;<em>" + pagedata[i].cTitle + "</em></li>");
                                break;
                            case "26":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> ����Լ�ܣ�<a target=\"_blank\" href=\"/race/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><p>" + pagedata[i].cBio + (pagedata[i].cImageUrl==''?"":"<img src=\"" + pagedata[i].cImageUrl + "\">") +"</p><div class=\"relevance\">" + pagedata[i].dCreate + "</div></li>");
                                break;
                            case "32":;
                            case "33":;
                            case "34":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> �����ˣ�<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><div class=\"relevance\">" + pagedata[i].dCreate + "</div></li>");
                                break;
                            case "44":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a>    " + pagedata[i].cTitle + "</a><div class=\"relevance\">" + pagedata[i].dCreate + "</div></li>");
                                break;
                            case "46":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> ��Լ����" + pagedata[i].cTitle + "</a><p>" + pagedata[i].cBio + cimg + "</p><div class=\"relevance\">" + pagedata[i].dCreate + "<span>�Ķ�(" + pagedata[i].iShowTimes + ") ��ע(" + pagedata[i].iFocus + ") ��(" + pagedata[i].iDing + ") ����(" + pagedata[i].iDiscuss + ") </span></div></li>");
                                break;
                            case "51":
                                $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a>    " + pagedata[i].cTitle + "</a><div class=\"relevance\">" + pagedata[i].dCreate + "</div></li>");
                                break;
                        }
                    })
                    thiscount = data.count;
        $.AMUI.progress.done();
                },
                complete: function () { //���ɷ�ҳ��
                    if (thiscount == "") {
                        $(divid).html("ľ���ˣ������");
                    } else {
                        $(divid).html("������ظ���...");
                    }
                },
                error: function (xhr) {
                }

            });
        }
        <%if (cId == uId) %>
             <%{ %>
        //ȫ������
        pageup("1", "10", '<%=uId%>', "#c01", "0");
        var thispage = "2"
        $("#c01").click(function () {
            pageup(thispage, "10", '<%=uId%>', "#c01", "0");
            thispage++
        })
        <%} %><%else %><%{ %>
        //���˵�ȫ������
        pageup("1", "10", '<%=uId%>', "#f01", "0");
        var thispage = "2"
        $("#f01").click(function () {
            pageup(thispage, "10", '<%=uId%>', "#f01", "0");
            thispage++
        })
                <%} %>
        //���ѵĲ���
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
        //���ѵĻ
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
        //���ѵ�����
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
        //��ҳend***************************************************      
        //����
        $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
        //�����ύ
        $(".chartbot").click(function () {
            document.getElementById("_contents").style.visibility = "hidden";
            var idRoadStyle = $("#idRoadStyle").val(),
                roadtime = $("#roadtime").val()=="ѡ��ʱ��"?"":$("#roadtime").val(),
                iDistance = $("#iDistance").val()
                location.href="/infocenter/Trained.aspx?uId=<%=uId%>&idRoadStyle=" + idRoadStyle + "&time=" + roadtime + "&iDistance=" + iDistance
            // $.ajax({
            //     url: "/infocenter/Include/AjaxQuery.aspx?method=trained&idRoadStyle=" + idRoadStyle + "&time=" + roadtime + "&iDistance=" + iDistance,
            //     type: 'GET',
            //     dataType: 'text',
            //     cache: false,
            //     success: function (data, textStatus, xhr) {
            //         if (data == "1") {
            //             focuscont = "<img src=\"/Html/images/right.png\"> �ύ�ɹ�";
            //         } else if (data == "0") {
            //             focuscont = "<img src=\"/Html/images/false.png\">����дʱ������";
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
        // ��עajax
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
                        $(".toast").html('��ע�ɹ�').show().addClass('toast-success')
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
        //��ע���ķ�˿
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
                        focuscont = "<img src=\"/Html/images/right.png\"> ��ע�ɹ�";
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