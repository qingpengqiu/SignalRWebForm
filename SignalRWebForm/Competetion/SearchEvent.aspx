<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SearchEvent.aspx.cs" Inherits="Competetion_SearchEvent" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body {
        background: #f6f6f6;
    }
</style>
<div class="banner SearchEventbanner">
    <div class="mine">
        <img src="/Html/images/searchb.jpg" alt="">
        <i>全球赛事精选</i>
        <em>讓心和身體一起奔向遠方~</em>
    </div>
</div>
<div class="tbody">
    <div class="mine">
        <div class="tbodyBox">
            <div class="event this clearfix">
                <div class="serchaction">
                    <h3>赛事搜索：</h3>
                    <div class="keyserch">
                        请输入赛事名称
                        <input type="text" id="keyserch">
                        <button type="button" class="keybuttom">查询</button>
                    </div>
                    <div class="salist"><em>地区：</em><i data-g="0" data-type="g" class="this">全部</i><i data-g="1" data-type="g">国内</i><i data-g="2" data-type="g">国外</i></div>
                    <div class="salist"><em>时间：</em><i data-t="0" data-type="t" class="this">全部</i><i data-t="1" data-type="t">最近1个月</i><i data-type="t" data-t="2">1-3个月</i><i data-type="t" data-t="3">3-6个月</i><i data-type="t" data-t="4">6个月以上</i><i data-type="t" data-t="5">已结束赛事</i></div>
                    <div class="salist"><em>类型：</em><i data-type="lx" data-lx="99" class="this">全部</i><i data-type="lx" data-lx="0">超级马拉松</i><i data-type="lx" data-lx="1">全程马拉松</i><i data-type="lx" data-lx="2">半程马拉松</i><i data-type="lx" data-lx="3">路跑</i><i data-type="lx" data-lx="4">越野跑</i><i data-type="lx" data-lx="5">其它</i></div>
                    <h3>搜索结果：</h3>
                </div>
                <div class="actionresult">
                    <div class="armore">
                        <img src="/images/ajax-loader.gif">
                        正在加载中</div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
var g = 0,
	t = 0,
	lx = 99,
	p = 1,
    key = '';
jQuery(document).ready(function ($) {
    jzss(g, t, lx, p, key)
});
$(window).scroll(function() {  
    if($(this).scrollTop() + $(window).height()  >= $(document).height() && $(this).scrollTop() > 0) { 
        p++
        jzss(g, t, lx, p, key)
        var top = $(this).scrollTop()-10
        $("html,body").scrollTop(top)
    }
})
$(".armore").click(function (event) {
    p++
    jzss(g, t, lx, p, key)
});
function jzss(g, t, lx, p, key) {
    $(".armore").html('<img src="/images/ajax-loader.gif"> 正在加载中')

    var list = '',
    gzzc = ['立即关注', '已关注']
    template = '<div class="arli clearfix"><img src="{cPictures}"><a href="{alink}" class="artitle"  target="_blank">{cTitle}</a>比赛时间：{dRaceBegin}  <br>报名时间：{dJoinBegin} 到 {dJoinEnd}  <br>比赛费用： {item} <br>已关注 {gzrs}人   已报名{bmrs}人 <div class="serchlistbuttom"><a class="argz argz{gz}" data-gzid="{id}" data-gz="{gz}" href="javascript:void(0)">{gzz}</a>{link}</div></div>'
    if (p == 1) {
        $(".actionresult").find('.arli').remove()
    }
    $.get('/action/EventService.ashx?op=seach', { g: g, t: t, lx: lx, p: p, key: key }, function (data) {
        $.each(data, function (index, val) {
            val.alink = val.bid ? '/blog/' + val.bid + '.aspx' : '/Competetion/EventDetails.aspx?sid=' + val.id + '&nav=1'
            val.gzz = gzzc[val.gz]
            list += nano(template, val)
        });
        $(".armore").before(list)
        if (jQuery.isEmptyObject(data)) {
            $(".armore").html('当前无赛事')
        } else {
            $(".armore").html('点击加载更多')
        }
    });
}

function nano(template, data) {
    return template.replace(/\{([\w\.]*)\}/g, function (str, key) {
        var keys = key.split("."), v = data[keys.shift()];
        for (i = 0, l = keys.length; i < l; _i++) v = v[this];
        return (typeof v !== "undefined" && v !== null) ? v : "";
    });
};
$(".actionresult").on('click', '.argz', function (event) {
    event.preventDefault();
    var cthis = $(this)
    if ($(this).data('gz') == 0) {
        $.get("/action/EventService.ashx", { id: $(this).data("gzid"), op: "gzss", rnd: Math.random() }, function (result) {
            if (result.status == 1) {
                cthis.html('已关注').addClass('argz1');
            }
            else if (result.status == 0) {
                PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
            }
        });
    };
});
$(".keybuttom").click(function (event) {
    serchkey()
});
function serchkey() {
    var keyi = encodeURIComponent($("#keyserch").val())
    if (keyi) {
        g = 0
        t = 0
        lx = 99
        p = 1
        key = keyi
        $(".salist").each(function (index, el) {
            $(this).find('i').eq(0).addClass('this').siblings().removeClass('this')
        });
        jzss(g, t, lx, p, key)
    } else {
        $("#keyserch").focus().attr('placeholder', '请输入关键字');
    }
}
$('#keyserch').bind('keypress', function (event) {
    if (event.keyCode == "13") {
        serchkey()
    }
});
$(".salist i").click(function (event) {
    key = '';
    $("#keyserch").val('').attr('placeholder', '')
    $(this).addClass('this').siblings().removeClass('this')
    var type = $(this).data("type")
    eval(type + '=' + $(this).data(type))
    p = 1
    jzss(g, t, lx, p, key)
});
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />