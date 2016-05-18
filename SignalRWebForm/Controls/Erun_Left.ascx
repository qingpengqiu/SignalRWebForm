<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Erun_Left.ascx.cs" Inherits="Controls_Erun_Left" %>
<div class="main-left">
<div class="user-ico"><img src="/Html/images/hthumb.png"></div>
<div class="name"><div class="fixname" style="display: none;"><input id="alternr" value="" class="span2" type="text"><a class="btn" id="alter" type="button">确定</a><a class="fixrex" type="button">取消</a></div><div class="namenr"><em></em><a href="javascript:void(0)" id="altername"> [修改]</a></div></div>
<p class="abstract"><em></em><a href="javascript:void(0)" id="alteabstract"> [修改]</a></p><div class="alterabstract" style="display: none;"><textarea class="abstracttext"></textarea><a class="btn" id="abstract" href="javascript:void(0)">[确定]</a><a class="fixrex" href="javascript:void(0)">[取消]</a></div>
<div class="focus-other">
<a class="leftgz" href="javascript:void(0)">+ 关注TA</a>
<a class="article-up-iframe" href="">给TA留言</a>
 </div>
 <ul id="usertype"></ul>
</div>
<script type="text/javascript">
    var id = <%= uId%>
jQuery(document).ready(function ($) {
    $.get('/action/ajaxUser.ashx?op=uleft&uid='+id, function(data) {
        if (id == 0) {
            $(".toast").html('用户不存在').show().addClass('toast-error')
            setTimeout(function(){window.location.href="/"},1500)
            if ($.AMUI) {
                $.AMUI.store.cleardata('leftuserinfo')
            };
            return false
        };
        if ($.AMUI) {
            $.AMUI.store.set('leftuserinfo',data)
        }
    $.get('/action/AjaxUser.ashx?op=getuser', function(data) {
        if (data.msg > 0 && data.msg != id) {
            $(".focus-other").show()
            $(".article-up-iframe").attr('href', '/infocenter/PostMessage.aspx?uId='+id);
        }
    });
        $(".user-ico img").attr('src', data.cAvatar);
        $(".namenr em").html(data.cNickName)
        $("#alternr").val(data.cNickName)
        $("#usertype").html('<li><a href="/user/'+data.id+'.aspx">首页</a></li><li class="mpleft"><a href="/infocenter/BaseInfo.aspx?uId='+data.id+'">跑界名片</a></li><li><a href="/infocenter/Blog.aspx?uId='+data.id+'">博客</a></li><li><a href="/infocenter/Running.aspx?uId='+data.id+'">约跑</a></li><li><a href="/infocenter/Equip.aspx?uId='+data.id+'">装备</li><li><a href="/infocenter/Trained.aspx?uId='+data.id+'">训练成绩</a></li><li class="dhleft"><a href="/infocenter/Competition.aspx?uId='+data.id+'">赛事</a></li><li class="dhleft"><a href="/infocenter/Rlist.aspx?uId='+data.id+'">购买兑换</a></li>')
        if (data.cBio) {
            $(".abstract em").html(data.cBio)
            $(".abstracttext").val(data.cBio)
        }else{
            $(".abstract em").html('这里是描述')
            $(".abstracttext").val('这里是描述')
        }
        if (data.status == 1) {
            $("#altername").show()
            $("#alteabstract").show()
            $("#usertype").find(".dhleft").show()
            // $("#usertype").find(".mpleft").hide()

        };
    });
    $(window).scroll(function() {
        if ($(window).scrollTop() > 100) {
            $(".main-left").addClass('mleftb')
        } else {
            $(".main-left").removeClass('mleftb')
        }
    });
    $("body").on("swiperight",function(){
        $(".main-left").animate({left: "0"},100);
    }); 
    $("body").on("swipeleft",function(){
        $(".main-left").animate({left: "-240px"},100);
    });
    $(".main-right").click(function(event) {
        $(".main-left").animate({left: "-240px"},100);
    }); 
    $("#altername").click(function () {
        $(".fixname").show();
        $(".namenr").hide();
        $(".abstract").show();
        $(".alterabstract").hide();
    })
    $("#alteabstract").click(function () {
        $(".alterabstract").show();
        $(".abstract").hide();
        $(".namenr").show();
        $(".fixname").hide();
    })
    $("#alter").click(function () {
        var altername = encodeURIComponent($("#alternr").val())
        if (altername == "" || altername == "fail") {
            $("#alternr").attr('placeholder', '昵称不能为空');
            return false;
        }
        $.ajax({
            url: '/infocenter/Include/AjaxQuery.aspx?=' + Math.random(),
            type: 'GET',
            dataType: 'text',
            data: { nick: altername, method: "nick" },
            complete: function (xhr, textStatus) {
                //called when complete
            },
            success: function (data, textStatus, xhr) {
                if (data == "fail") {
                    $("#alternr").val("").attr('placeholder', '昵称已存在');;
                }else{
                $(".namenr em").replaceWith("<em>" + data + "</em>");
                $(".namenr").show();
                $(".fixname").hide();
                $(".username em").replaceWith("<em>" + data + "</em>");
                $("#alternr").removeAttr('style')
                }
            },
            error: function (xhr, textStatus, errorThrown) {
            }
        });
    })
    $(".fixrex").click(function(event) {
        $(".abstract").show();
        $(".alterabstract").hide();
        $(".namenr").show();
        $(".fixname").hide();
    });
    $("#abstract").click(function () {
        var alterabstract = encodeURIComponent($(".abstracttext").val());
        $.ajax({
            url: '/infocenter/Include/AjaxQuery.aspx',
            type: 'GET',
            dataType: 'text',

            data: { bio: alterabstract, method: "bio" },
            complete: function (xhr, textStatus) {
                //called when complete
            },
            success: function (data, textStatus, xhr) {
                if (data == "") {
                    $(".abstract em").replaceWith("<em>介绍一下自己吧!</em>")
                } else {
                    $(".abstract em").replaceWith("<em>" + data + "</em>")
                }
                $(".abstract").show();
                $(".alterabstract").hide();
            },
            error: function (xhr, textStatus, errorThrown) {
            }
        });
    })
    $(".focuson,.msgon").click(function () {
    var userid = $(this).attr("data-id"),
        thisurl = $(this).attr("data-url"),
        datamsg = $(this).attr("data-msg")
    $.ajax({
            url: thisurl,
            type: 'GET',
            dataType: 'text',
            complete: function (xhr, textStatus) {
                //called when complete
            },
            success: function (data, textStatus, xhr) {
                focuscont = "<img src=\"/Html/images/true.png\"> " + datamsg;
                function blogDelHref() {
                    setTimeout("location.href = window.location", 3000)
                }
                $(".focuson").append("<div class=\"focusalert\">" + focuscont + "</div>");
                setTimeout(blogDelHref, 200);
            },
            error: function (xhr, textStatus, errorThrown) {
            }
        });
    })
    <%=ctips%>
});
$(".leftgz").click(function(event) {
    $.get('/action/GetFoucsList.ashx?command=addFoucs&uId='+id, function(data) {
        if (data == "1") {
            $(".toast").html('关注成功').show().addClass('toast-success')
            $(".leftgz").html('已关注')
        } else {
            $(".toast").html(data).show().addClass('toast-success')
            focuscont = "<img src=\"/Html/images/false.png\">" + data;
        }
        if (data == '您已关注过！！！') {
            $(".leftgz").html('已关注')
        };
        errorboxhide()
    });
});
</script>