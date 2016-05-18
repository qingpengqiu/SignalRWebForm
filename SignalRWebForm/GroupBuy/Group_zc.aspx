<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Group_zc.aspx.cs" Inherits="GroupBuy_Group" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title><%=cname%>-众筹-益跑网个人中心</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/user-more.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/Group.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/groupmedia.css" />
    <script type="text/javascript" src="../Common/jCalendar.js"></script>
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../Html/js/modernizr.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="../Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="../Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Html/js/bootstrap-validation.min.js"></script>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="../Common/jCity.js"></script>
    <script src="../Common/jCheck.js"></script>
    <script src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <style>
        .main-left ul .user-dq {
            filter: alpha(Opacity=100);
            -moz-opacity: 1;
            opacity: 1;
        }
    </style>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
</head>
<body>
    <form id="form1" runat="server">
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="wrap">
    	<article>
        <div class="groupnt groupnts">
                    <a href="/GroupBuy/GroupList_zc.aspx">返回众筹首页>></a>
                    <img src="/Html/images/pbg.png">
        </div>
    		<div class="shopimg">
    			<img src="" alt="" id="thumbtg">
                <div class="thumblist"></div>
    			<div class="fenxiang"><a id="sharewb" href="javascript:void(0)"><img src="/Html/images/weiboc.png" alt=""> 分享到新浪微博</a> | <a href="javascript:void(0)" id="copyUrl"><img src="/Html/images/fuzhi.png" alt="" >复制地址</a> | <a href="/infocenter/PostMessage.aspx" class="article-up-iframe"><img src="/Html/images/friend.png" alt="" >分享给站内好友</a></div>
    		</div>
    		<div class="shopt">
    			<h1></h1>
				<p class="sc">市场价：<span>&yen;</span><strong></strong><i></i></p>
				<p class="dc">当前价格：<em><span>&yen;</span><strong></strong></em></p>
                <div class="tpopn">
                    <div class="tpop">
                        <div class="tpoph">

                        </div>
                        <ul class="jieti">
                        
                        </ul>
                    </div>
                    <div class="tpopr">
<a class="ptbotton pingtuan" href="javascript:void(0)">立即众筹</a>
<a class="ptbotton ptover" href="javascript:void(0)"></a>
<a class="ptbotton ptno" href="javascript:void(0)"></a>
<div class="onbuy"></div>
<div class="endtime"></div>
                    </div>
                    <div class="pnbg"></div>
                </div>
				<div class="tuantip">
					玩转众筹<br>
				当众筹顾客达到一定数量则商品价格进入更高的价格阶梯，直至达到最高价或众筹结束
快叫你的跑友一起来冲击更高
                     <%=CurrentUser == null?"<a class=\"kfbutton\" onclick=\"PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();\" href=\"javascript:\"><img src=\"/Html/images/kf.png\"></a>":" <a class=\"kfbutton article-up-iframe\" href=\"/infocenter/PostMessage.aspx?uId="+idUser+"\"><img src=\"/Html/images/kf.png\"></a>"%>
				</div>

    		</div>
            <div class="cpst">产品介绍</div>
            <div class="cpshow">

            </div>
            <div class="cpst">规格参数</div>
            <div class="cpgge">

            </div>
    	</article> 
    </div>
    <script>
    var Result = <%=Result%>,
       cImage = "",
       jieti = "",
       dh   = 0,
       Current = Result[0].Current,
       Begin = Result[0].Begin,
       End = Result[0].End,
       tournum = Result[0].Tour[0].iBuyNum,
       maxn = 0,
       mthis = 0
$(document).ready(function(){
   
   $("#thumbtg").attr('src', Result[0].Image);
    $.each(Result[0].Reserve, function(i, v) {
         var on = Result[0].BuyNum > v.iBuyNum?'on':''
    });
    $.each(Result[0].Reserve, function(i, v) {
        if(v.cImage){
          cImage += '<img src="'+v.cImage+'">'
        }
         
    });
    $.each(Result[0].Tour, function(i, v) {
        var liheight = (dh - v.iBuyNum)/tournum*270
        dh =  v.iBuyNum
         var on = Result[0].BuyNum > v.iBuyNum?'on':''
         $(".jieti").append('<li class="'+on+'" style="height:'+liheight+'px"><span>满'+v.iBuyNum+'人</span><em><i>&yen;</i>'+v.fBuyPrice+'</em> '+'</li>')
    });
   $(".thumblist").html(cImage).prepend('<img src="'+Result[0].Image+'" class="this">')
   var dkicon = Result[0].fScore==1?'<img src="/Html/images/dkicon.png">':''
   var ms = Result[0].Tour[1]?'':'<i>【益秒杀】</i>'
   var ptbottontit = Result[0].Tour[1]?'立即众筹':'立即秒杀'
   $(".pingtuan").html(ptbottontit)
   if(Result[0].myend=="0"){
    $(".pingtuan").replaceWith('<div class="ptbotton maiguangle">卖光了</div>');
   }
   $("h1").html(ms+Result[0].Name+dkicon)
   $(".sc strong").html(Result[0].MarketPrice)
   $(".dc strong").html(Result[0].TourPrice)
   $(".sc i").html((Result[0].TourPrice/Result[0].MarketPrice*10).toFixed(2)+'折')
   $(".onbuy").html('( 已有'+Result[0].BuyNum+'人购买 )')
   $(".pnbg").html(Result[0].BuyNum+'人')
   $(".cpshow").html(Result[0].Bio)
   $(".cpgge").html(Result[0].Norm)
   if(Begin > Current){
         //未开始
         timer(parseInt(Begin - Current),'距开始');
        $(".ptno").show()
        $(".onbuy").hide()
   }else if(End < Current){
        //已结束
        $(".ptover").show()
   }else if(Begin < Current && End > Current && End > Begin){
        //进行中
        timer(parseInt(End - Current),'仅剩');
        $(".pingtuan").show()
   }

   
   if (Result[0].BuyNum == tournum) {
    $(".tpoph").css('height', '324px');
   }else{
    $(".tpoph").css('height', Result[0].BuyNum/tournum*270+'px');
   }
});
$(".pingtuan").on('click', function(event) {
    window.location.href="Cart_zc.aspx?id="+GetQueryString("id"); 
});
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
    }
//倒计时总秒数量
function timer(intDiff,tname){
window.setInterval(function(){
var day=0,
hour=0,
minute=0,
second=0;//时间默认值        
if(intDiff > 0){
day = Math.floor(intDiff / (60 * 60 * 24));
hour = Math.floor(intDiff / (60 * 60)) - (day * 24);
minute = Math.floor(intDiff / 60) - (day * 24 * 60) - (hour * 60);
second = Math.floor(intDiff) - (day * 24 * 60 * 60) - (hour * 60 * 60) - (minute * 60);
}
if (minute <= 9) minute = '0' + minute;
if (second <= 9) second = '0' + second;
$('.endtime').html(tname+'<em>'+day+'</em>天<em>'+hour+'</em>小时<em>'+minute+'</em>分钟<em>'+second+'</em>秒')
intDiff--;
}, 1000);
}
//复制插件
thisurl = window.location.href
    $('#copyUrl').zclip({
        path:'/Html/js/ZeroClipboard.swf',
        copy:thisurl
    });
    $("#sharewb").click(function(event) {
        window.open("http://service.weibo.com/share/share.php?url="+thisurl+"&type=button&ralateUid=2961848493&language=zh_cn&appkey=1VDwW4&searchPic=true&style=simple")
    });
$(document).on("click",".thumblist img",function(){
        var src= $(this).attr('src');
        $(this).addClass('this').siblings().removeClass('this')
        $("#thumbtg").attr('src',src);
});
$(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });

    </script>
            </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>