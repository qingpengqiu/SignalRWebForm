<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClubSearch.aspx.cs" Inherits="infocenter_ClubSearch" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="��http://open.weibo.com/wb��">
<head>
    <title>Լ������</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
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
                �����
            </div>
            <div class="serlist">
                <div class="seroption">
                    <div class="searchtop">
                        ѡ����У�
                        <div class="runcity">
                            <span>������</span>&nbsp;&nbsp;<a href="javascript:void(0)">[ �л����� ]</a>
                            <div class="cityselect">
                                <div class="citygb" href="javascript:void(0)" title="�ر�">x</div>
                                <em></em>
                            </div>
                        </div>
                        �����ؼ��֣�<input class="serchkey" type="text"><a href="javascript:void(0)" class="searchinput"><img src="/Html/images/searchs.png" alt="" /></a>
                    </div>
                    <div class="serchoptions">
                        <ul>
                            <li class="region">
                                <i class="csicon1"></i>
                                ������<a href="javascript:void(0)" data-area="ȫ��" data-areanum="0">ȫ��</a>
                                <em href="javascript:void(0)" class="regionall">ȫ��</em>
                            </li>
                            <li class="serchtime">
                                <i class="csicon2"></i>
                                ʱ�䣺<a href="javascript:void(0)" data-time="0">ȫ��</a> <a href="javascript:void(0)" data-time="1">����</a> <a href="javascript:void(0)" data-time="2">2����</a> <a href="javascript:void(0)" data-time="3">1�ܺ�</a>
                            </li>
                            <li class="serchgame">
                                <i class="csicon3"></i>
                                ���ͣ�<a href="javascript:void(0)" data-game="0">ȫ��</a> <a href="javascript:void(0)" data-game="1">·��</a> <a href="javascript:void(0)" data-game="2">ԽҰ</a> <a href="javascript:void(0)" data-game="3">ͽ��</a> <a href="javascript:void(0)" data-game="4">�����</a>
                            </li>
                            <li class="serchlevel">
                                <i class="csicon4"></i>
                                ǿ�ȣ�<a href="javascript:void(0)" data-level="0">ȫ��</a> <a href="javascript:void(0)" data-level="1">��</a> <a href="javascript:void(0)" data-level="2">��</a> <a href="javascript:void(0)" data-level="3">��</a>
                            </li>
                            <li class="serchkm">
                                <i class="csicon5"></i>
                                ���룺<a href="javascript:void(0)" data-km="0">ȫ��</a> <a href="javascript:void(0)" data-km="1">5��������</a> <a href="javascript:void(0)" data-km="2">5-10����</a> <a href="javascript:void(0)" data-km="3">21����</a>
                            </li>
                            <li class="serchfeatures">
                                <i class="csicon6"></i>
                                ��ɫ��<a href="javascript:void(0)" data-features="100">ȫ��</a> <a href="javascript:void(0)" data-features="1">�н�Ʒ</a> <a href="javascript:void(0)" data-features="2">�з�</a> <a href="javascript:void(0)" data-features="3">�а೵</a><a href="javascript:void(0)" data-features="4">��װ��</a><a href="javascript:void(0)" data-features="5">����</a><a href="javascript:void(0)" data-features="6">רҵ����</a><a href="javascript:void(0)" data-features="0">�޸���</a>
                            </li>
                        </ul>
                    </div>
                    <div class="searchnr">
                        <ul>
                            <li class="listmore" id="c01">������ظ���...</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="hdserchr">
            <div class="hdfr hdhot">
                <span>���Ż</span>
            </div>
            <div class="hdfr ndfr">
                <span>���»</span>
            </div>
            <div class="hdfu">
                <span>��Ծ��Ա</span>
            </div>
            <div class="hddr">
                <span>�����</span>
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
            var city = "������",
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
        //����ؼ���
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
        //ѭ���������
        for (x in china) {
            var i = parseInt(x) + 1;
            $(".cityselect").append("<a href=\"javascript:void(0)\" data-citynum=\"" + i + "\" data-city=\"" + china[x][0] + "\">" + china[x][0] + "</a>")
        }
        //ѭ���������
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
                    $(divid).html("<span class=\"load\"></span>���ڼ�����...");
                },
                success: function (data) {
                    var pagenum = data.count,
                        pagedata = data.ds
                    $.each(pagedata, function (i) {
                            $(divid).before("<li><a target=\"_blank\" href=\"/race/" + pagedata[i].id + ".aspx\" class=\"title\">" + pagedata[i].cTitle + "</a>" + pagedata[i].state + "<br/><span>  �����ˣ�<a target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cLoginname + "</a>  �ʱ�䣺" + pagedata[i].dOpen + "</span><p>" + pagedata[i].cContent + "" + pagedata[i].Thumbnails + "</p><div class=\"article-bot\"><a target=\"_blank\" href=\"/race/" + pagedata[i].id + ".aspx\">�鿴ȫ��>></a>�Ķ�(" + pagedata[i].iShowTimes + ") ��ע(" + pagedata[i].iFocus + ") ��(" + pagedata[i].iDing + ") ����(" + pagedata[i].iDiscuss + ")</div></li>");
                    })
                    thiscount = data.count;
                },
                complete: function () { //���ɷ�ҳ��
                    if (thiscount == "") {
                        $(divid).html("ľ����...");
                    } else {
                        $(divid).html("������ظ���...");
                    }
                },
                error: function (xhr) {
                }

            });
        }
        jQuery(document).ready(function ($) {

            //��ʼ�����ؼ���
            var gkey = decodeURI(GetQueryString("key"))
            if (GetQueryString("key")) {
                $(".serchkey").val(gkey)
            };
            //��ʼ������
            var gcity = decodeURI(GetQueryString("city"))
            if (GetQueryString("city")) {
                $(".runcity span").html(gcity)
            };
            //��ʼ����������ʽ
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
            //��ʼ��ʱ����ʽ
            if (GetQueryString("time")) {
                $(".serchtime a[data-time=" + GetQueryString("time") + "]").addClass('runthis')
            } else {
                $(".serchtime a[data-time=" + time + "]").addClass('runthis')
            }
            //��ʼ��������ʽ
            if (GetQueryString("game")) {
                $(".serchgame a[data-game=" + GetQueryString("game") + "]").addClass('runthis')
            } else {
                $(".serchgame a[data-game=" + game + "]").addClass('runthis')
            }
            //��ʼ��������ʽ
            if (GetQueryString("level")) {
                $(".serchlevel a[data-level=" + GetQueryString("level") + "]").addClass('runthis')
            } else {
                $(".serchlevel a[data-level=" + level + "]").addClass('runthis')
            }
            //��ʼ��������ʽ
            if (GetQueryString("km")) {
                $(".serchkm a[data-km=" + GetQueryString("km") + "]").addClass('runthis')
            } else {
                $(".serchkm a[data-km=" + km + "]").addClass('runthis')
            }
            //��ʼ����ɫ��ʽ
            if (GetQueryString("features")) {
                $(".serchfeatures a[data-features=" + GetQueryString("features") + "]").addClass('runthis')
            } else {
                $(".serchfeatures a[data-features=" + features + "]").addClass('runthis')
            }
            //ѡ�����
            $(".cityselect a").on('click', function () {
                city = $(this).data("city")
                cityid = $(this).data("citynum")
                $(".runcity span").html(city)
                jump()
            });
            //ѡ�����
            $(".region a").on('click', function () {
                areaid = $(this).data("areanum")
                jump()
            });
            //ѡ��ʱ��
            $(".serchtime a").on('click', function () {
                time = $(this).data("time")
                jump()
            });
            //ѡ������
            $(".serchgame a").on('click', function () {
                game = $(this).data("game")
                jump()
            });
            //ѡ�񼶱�
            $(".serchlevel a").on('click', function () {
                level = $(this).data("level")
                jump()
            });
            //ѡ�����
            $(".serchkm a").on('click', function () {
                km = $(this).data("km")
                jump()
            });
            //ѡ����ɫ
            $(".serchfeatures a").on('click', function () {
                features = $(this).data("features")
                jump()
            });
            //������������
            
            SerachPage();
            $("#c01").click(function () {
                pageIndex++
                SerachPage();                
            })
            
        });
        function iFocus(idx,thisa) {
                function thisare() {
                    $(".hddr a[data-li=" + thisa + "]").replaceWith("<a class=\"focus-a hdgz\">�ѹ�ע</a>")
                }
            if (confirm("ȷ��Ҫ��ע��") == true) {
                $.get("/action/GetFoucsList.ashx", { uId: idx, command: "addFoucs", timestamp: new Date().getTime() }, function (data) {
                    if (data == "1") {
                        focuscont = "<img src=\"/Html/images/right.png\"> ��ע�ɹ�";
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
        //���Ż
        $.ajax({
            url: '/action/AjaxRace.ashx?command=toprace',
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
                $("body").append("<div class=\"cluberror\">���ڼ�����...</div>");
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
                $("body").append("<div class=\"cluberror\">���ݼ���ʧ��</div>");
            }
        });
        //���»
        $.ajax({
            url: '/action/AjaxRace.ashx?command=newrace',
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
                $("body").append("<div class=\"cluberror\">���ڼ�����...</div>");
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
                $("body").append("<div class=\"cluberror\">���ݼ���ʧ��</div>");
            }
        });
        //��Ծ��Ա
        $.ajax({
            url: '/action/AjaxRace.ashx?command=ActiveMember',
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
                $("body").append("<div class=\"cluberror\">���ڼ�����...</div>");
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
                $("body").append("<div class=\"cluberror\">���ݼ���ʧ��</div>");
            }
        });
        //�����
        $.ajax({
            url: '/action/AjaxRace.ashx?command=Daren',
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
                $("body").append("<div class=\"cluberror\">���ڼ�����...</div>");
            },
            success: function (data) {
                $.each(data.ds, function (i,item) {
                    if(gId == "-1"){
                        ggz = ""
                    }else{
                        ggz = '<a class=\"hdgz\" data-li=\"'+i+'\" href=\"javascript:void(0)\" onclick=\"iFocus('+item.idUser+','+i+')\">+ ��עTA</a><a class=\"hdly\" href=\"javascript:void(0)\" rel=\"/infocenter/PostMessage.aspx?uId='+item.idUser+'\">��TA����</a>'
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
                $("body").append("<div class=\"cluberror\">���ݼ���ʧ��</div>");
            }
        });
    </script>
</body>
</html>
