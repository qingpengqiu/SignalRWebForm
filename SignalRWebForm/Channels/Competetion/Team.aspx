<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Team.aspx.cs" Inherits="Channels_Competetion_Team" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head >
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/race.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCity.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
</head>
<body >
	<ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form id="form1" runat="server">
    <div class="indecen ">
        <div class="racebody racetimew">
            <h1>
                <asp:Literal ID="ltlTitle" runat="server"></asp:Literal></h1>
            <div class="racetip">
                1、请登陆并报名付款成功后进行组队 <br>
                2、加入队伍后不可以退出，请慎重加入 <br>
                3、有锁即代表输入密码才能加入，请与队长沟通
            </div>
            <div class="racetime">
                <asp:Literal ID="ltlTeam" runat="server"></asp:Literal>
            	<a class="timemm teamthis teamx" data-listid="0">未满团队</a><a class="timem teamx" data-listid="1">已满团队</a>
            	<ul class="timelist wmteam">
                    <li class="noteam">当前无队伍</li>
            		<li class="pageli"><div class="racetimem racetimemn"  onclick="moreteam();">显示更多内容</div></li>
            	</ul>
            	<ul class="timelist" style="display: none">
                    <li class="noteam">当前无队伍</li>
            		<li class="pageliman"><div class="racetimem racetimemman" onclick="moreteamman();">显示更多内容</div></li>
            	</ul>
            </div>
        </div>
    </div>
    
    </form>
    <div style="display: none;">
<div id="newteam">
<span>创建团队 . 设置</span>
<table>
	<tr>
		<td><label for="teamo">公开团队</label><input type="radio" value="1" id="teamo" name="team" checked> </td><td>（任何人都可以加入）</td>
	</tr>
	<tr>
		<td><label for="teamm">私密团队</label><input type="radio" value="0" id="teamm" name="team"> </td><td>（队员需要密码才能加入）</td>
	</tr>
	<tr>
		<td>设定密码</td>
		<td>
			<input type="text" value="" tabindex="1" maxlength="6" id="passwd" disabled="disabled" class="teampass">            
		</td>
	</tr>
    <tr><td></td><td><div class="teampasstip">只能填写小于6位的数字,如为空视为<br>公开团队</div></td></tr>
	<tr>
		<td></td>
		<td><a href="javascript:void(0)" class="teament" onclick="maketeam();"></a><a href="javascript:void(0)" class="teamqx" onclick="cloxebox();"></a></td>
	</tr>
</table>
    </div>
    <div id="sessteam">
    	<span>创建团队 . 设置</span>
    	<h1>团队创建成功！</h1>
    	<div class="shareteam">
    	您可以将团队链接分享给朋友 <br>
    	http://www.baidu.com/#wd=%E5%BA%A6
    	<div class="fenxiang" style="height: auto;">
    		<a href="javascript:void(0)" id="sharewb"><img alt="" src="/Html/images/weiboc.png"> 分享到新浪微博</a> | <a id="copyUrl" href="javascript:void(0)" class=""><img alt="" src="/Html/images/fuzhi.png">复制地址</a> | <a class="article-up-iframe" href="/infocenter/PostMessage.aspx?idClub=600000000"><img alt="" src="/Html/images/friend.png">分享给站内好友</a><div class="zclip" id="zclip-ZeroClipboardMovie_1" style="position: absolute; left: 338px; top: 127px; width: 68px; height: 15px; z-index: 99;"><embed width="68" height="15" align="middle" wmode="transparent" flashvars="id=1&amp;width=68&amp;height=15" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" allowfullscreen="false" allowscriptaccess="always" name="ZeroClipboardMovie_1" bgcolor="#ffffff" quality="best" menu="false" loop="false" src="/Html/js/ZeroClipboard.swf" id="ZeroClipboardMovie_1"></div>
    		</div>
    	</div>
    </div>
    <div id="jionteam">
    	<span>加入团队</span>
    	<div class="ifteam">
    		<img src="/Html/images/question.png" >  是否加入该团队,加入后将无法退出? <br>
        <a class="teament" href="javascript:void(0)" onclick="jionteamok();"></a><a class="teamqx" href="javascript:void(0)" onclick="cloxebox();"></a>
    	</div>
    </div>
	<div id="jionteamm">
    	<span>加入团队</span>
    	<div class="passteam">
    		请输入团队密码，加入后将无法退出<br>
    		<input type="password" id="joinpasswd"><br>
        <a class="teament" href="javascript:void(0)" onclick="jionteamok();"></a><a class="teamqx" href="javascript:void(0)" onclick="cloxebox();"></a>
    	</div>
    </div>
    <div id="okteam">
    	<span>成功加入</span>
    	<div class="okteam">
    		<img src="/Html/images/right.png" >  您已成功加入该团队
    	</div>
    </div>
    <div id="tipsbox">
        
    </div>
</div>
    <script>
var teamidd,
    pageSize = 1,
    manfou = 0,
    pageSizeman = 1;
var sUserAgent = navigator.userAgent.toLowerCase();
var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
var bIsMidp = sUserAgent.match(/midp/i) == "midp";
var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
var bIsAndroid = sUserAgent.match(/android/i) == "android";
var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
$(".racetime .teamx").click(function(event) {
	$(".racetime .teamx").removeClass('teamthis')
	$(this).addClass('teamthis')
	$(".racetime .timelist").hide()
	$(".racetime .timelist").eq($(this).data('listid')).show()
});
$(".timem").click(function(event) {
    
    if(manfou == "0"){
$.ajax({
    url: '/action/Team.ashx',
    data: { m: "team", id: "<%=idItem%>", op: 2, p: pageSizeman, rnd: Math.random() },
    type: 'get',
    dataType: 'json',
    contentType: 'application/json;charset=utf-8',
    cache: false,
    beforeSend: function () {
        $(".noteam").html("正在加载中...").show();
    },
    success: function (data) {
        var wmteam = ""
$.each(data, function (i) {
    var teamuser = "",
        usergrouo = data[i].Group,
        suo = data[i].isOpen==0?'<b></b> ':''
    $.each(usergrouo, function(b) {
        teamuser += '<tr><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank"><img src="'+usergrouo[b].cAvatar+'" alt=""></a></td><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank">'+usergrouo[b].cName+'</a>'+usergrouo[b].cBio.substr(0, 14)+'</td></tr>'
    });
    wmteam +='<li><span><em>'+data[i].iSNo+'号队</em>'+suo+data[i].iNum+'/'+data[i].iTotal+'</span><p>组内成员：</p><table>'+teamuser+'</table></li>'
})
$(".noteam").remove()
if(wmteam){
    $(".pageliman").before(wmteam)
}else{
    $(".pageliman").before('<li class="noteam">当前无队伍</li>')
}
    }
});
    }
    manfou = 1
});
jQuery(document).ready(function($) {
$.ajax({
    url: '/action/Team.ashx',
    data: { m: "team", id: "<%=idItem%>", op: 1, p: pageSize, rnd: Math.random() },
    type: 'get',
    dataType: 'json',
    contentType: 'application/json;charset=utf-8',
    cache: false,
    beforeSend: function () {
        $(".noteam").html("正在加载中...").show();
    },
    success: function (data) {
        var wmteam = ""
$.each(data, function (i) {
    var teamuser = "",
        jionbott = "",
        isShow = <%=isShow%>,
        usergrouo = data[i].Group,
        suo = data[i].isOpen==0?'<b></b> ':''
    $.each(usergrouo, function(b) {
        teamuser += '<tr><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank"><img src="'+usergrouo[b].cAvatar+'" alt=""></a></td><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank">'+usergrouo[b].cName+'</a>'+usergrouo[b].cBio.substr(0, 14)+'</td></tr>'
    });
    jionbott = isShow==0?'style="display: none;"':'onclick="jionteam('+data[i].iSNo+','+data[i].isOpen+');"'
    wmteam +='<li><span><em>'+data[i].iSNo+'号队</em>'+suo+data[i].iNum+'/'+data[i].iTotal+'</span><p>组内成员：</p><table>'+teamuser+'</table><div class="jointime" '+jionbott+' >加入团队</div></li>'
})
$(".noteam").remove()
if(wmteam){
    $(".pageli").before(wmteam)
}else{
    $(".pageli").before('<li class="noteam">当前无队伍</li>')
}
    }
});
});
function moreteam(){
    var date = "";
    pageSize++
$.ajax({
    url: '/action/Team.ashx',
    data: { m: "team", id: "<%=idItem%>", op: 1, p: pageSize, rnd: Math.random() },
    type: 'get',
    dataType: 'json',
    contentType: 'application/json;charset=utf-8',
    cache: false,
    success: function (data) {
        var wmteam = ""
$.each(data, function (i) {
    var teamuser = "",
        jionbott = "",
        isShow = <%=isShow%>,
        usergrouo = data[i].Group,
        suo = data[i].isOpen==0?'<b></b> ':''
    $.each(usergrouo, function(b) {
        teamuser += '<tr><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank"><img src="'+usergrouo[b].cAvatar+'" alt=""></a></td><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank">'+usergrouo[b].cName+'</a>'+usergrouo[b].cBio.substr(0, 14)+'</td></tr>'
    });
    jionbott = isShow==0?'style="display: none;"':'onclick="jionteam('+data[i].iSNo+','+data[i].isOpen+');"'
    wmteam +='<li><span><em>'+data[i].iSNo+'号队</em>'+suo+data[i].iNum+'/'+data[i].iTotal+'</span><p>组内成员：</p><table>'+teamuser+'</table><div class="jointime" '+jionbott+' >加入团队</div></li>'
})
$(".pageli").before(wmteam)
date = wmteam
    },complete: function () { 
            if (date) {
               
            } else {
                $(".racetimemn").html("木有了");
            }
        }
});
}
function moreteamman(){
    var date = "";
    pageSizeman++
$.ajax({
    url: '/action/Team.ashx',
    data: { m: "team", id: "<%=idItem%>", op: 2, p: pageSizeman, rnd: Math.random() },
    type: 'get',
    dataType: 'json',
    contentType: 'application/json;charset=utf-8',
    cache: false,
    success: function (data) {
        var wmteam = ""
$.each(data, function (i) {
    var teamuser = "",
        usergrouo = data[i].Group,
        suo = data[i].isOpen==0?'<b></b> ':''
    $.each(usergrouo, function(b) {
        teamuser += '<tr><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank"><img src="'+usergrouo[b].cAvatar+'" alt=""></a></td><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank">'+usergrouo[b].cName+'</a>'+usergrouo[b].cBio.substr(0, 14)+'</td></tr>'
    });
    wmteam +='<li><span><em>'+data[i].iSNo+'号队</em>'+suo+data[i].iNum+'/'+data[i].iTotal+'</span><p>组内成员：</p><table>'+teamuser+'</table></li>'
})
$(".pageliman").before(wmteam)
date = wmteam
    },complete: function () { 
            if (date) {
               
            } else {
                $(".racetimemman").html("木有了");
            }
        }
});
}
function newteam(){
    if(bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM){
        $.colorbox({ inline: true,href:"#newteam", width: "100%", height: "296px", opacity: "0.4" });
        }else{
        $.colorbox({ inline: true,href:"#newteam", width: "425px", height: "296px", opacity: "0.4" });  
        }
    
}
function sessteam(){
	$.colorbox({ inline: true,href:"#sessteam", width: "425px", height: "296px", opacity: "0.4" });
}
function jionteam(teamid,teammm){
    teamidd = teamid
    if(teammm == 0){
        if(bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM){
        $.colorbox({ inline: true,href:"#jionteamm", width: '100%', height: "231px", opacity: "0.4",overlayClose:false });
        }else{
        $.colorbox({ inline: true,href:"#jionteamm", width: "425px", height: "231px", opacity: "0.4",overlayClose:false });    
        }
    }else if(teammm = 1){
        if(bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM){
        $.colorbox({ inline: true,href:"#jionteam", width: "100%", height: "231px", opacity: "0.4",overlayClose:false });
        }else{
        $.colorbox({ inline: true,href:"#jionteam", width: "425px", height: "231px", opacity: "0.4",overlayClose:false });
        }
    }
}
function jionteamok(){
    var psd = $("#joinpasswd").val()
    $.ajax({
        url: '/action/Team.ashx',
        type: 'GET',
        dataType: 'text',
        data: { m: "Join", id: teamidd,psd:psd},
        success: function (data) {
            var teamtips = ""
            if(data == 0){
                 teamtips = "<img src=\"/Html/images/false.png\"> 加入失败";
            }else if(data == 1){
                teamtips = "<img src=\"/Html/images/right.png\"> 加入成功";
            }
            else if(data == -1){
                teamtips = "<img src=\"/Html/images/false.png\"> 请重新登录";
            }
            else if(data == -2){
                teamtips = "<img src=\"/Html/images/false.png\"> 队伍不存在";
            }
            else if(data == -3){
                teamtips = "<img src=\"/Html/images/false.png\"> 该队已删除";
            }
            else if(data == -4){
                teamtips = "<img src=\"/Html/images/false.png\"> 该队已满";
            }
            else if(data == -5){
                teamtips = "<img src=\"/Html/images/false.png\"> 不能重复加入";
            }
            else if(data == -6){
                teamtips = "<img src=\"/Html/images/false.png\"> 未报名";
            }
            else if(data == -8){
                teamtips = "<img src=\"/Html/images/false.png\"> 赛事过期";
            }
            else if(data == -10){
                teamtips = "<img src=\"/Html/images/false.png\"> 不是混合组队";
            }
            else if(data == -11){
                teamtips = "<img src=\"/Html/images/false.png\"> 密码错误";
            }
            else { teamtips = "<img src=\"/Html/images/false.png\"> 您不符合条件加入队伍"; }
            $("#tipsbox").html(teamtips)
            tipsbox();
            setTimeout("location.reload()", 2000)
        }
    })
}
function tipsbox(){
    if(bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM){
        $.colorbox({ inline: true,href:"#tipsbox", width: "100%", height: "161px", opacity: "0.4" });
        }else{
        $.colorbox({ inline: true,href:"#tipsbox", width: "325px", height: "161px", opacity: "0.4" });
        }
    
}
function maketeam(){
    var op  = $("input[name='team']:checked").val(),
        psd = $("#passwd").val()
    $.ajax({
        url: '/action/Team.ashx',
        type: 'GET',
        dataType: 'text',
        data: { m: "Create", id: "<%=idItem%>",op:op,psd:psd},
        success: function (data) {
            var teamtips = ""
            if(data == 0){
                 teamtips = "<img src=\"/Html/images/false.png\"> 创建失败";
            }else if(data == 1){
                teamtips = "<img src=\"/Html/images/right.png\"> 创建成功";
            }
            else if(data == -1){
                teamtips = "<img src=\"/Html/images/false.png\"> 请重新登录";
            }
            else if(data == -2){
                teamtips = "<img src=\"/Html/images/false.png\"> 请勿重复创建";
            }
            else if(data == -6){
                teamtips = "<img src=\"/Html/images/false.png\"> 已加入其他队伍";
            }
            else { teamtips = "<img src=\"/Html/images/false.png\"> 您不符合条件创建队伍"; }
            $("#tipsbox").html(teamtips)
            tipsbox();
            setTimeout("location.reload()", 2000)
        }
    })
         
}
function okteam(){
    $.colorbox({ inline: true,href:"#okteam", width: "425px", height: "191px", opacity: "0.4" });
    setTimeout("location.reload()", 2000)
}
$("#passwd").keyup(function(){ 
    $(this).val($(this).val().replace(/\D|^0/g,''));  
}).bind("paste",function(){
    $(this).val($(this).val().replace(/\D|^0/g,''));  
}).css("ime-mode", "disabled");  
function cloxebox(){
    $.colorbox.close();
    $("#joinpasswd").val("")
}
$("#teamo").click(function(event) {
    $("#passwd").attr("disabled", "disabled");
});
$("#teamm").click(function(event) {
    $("#passwd").removeAttr("disabled"); 
});
$(".article-up-iframe").on('click', function(e){
    $(this).colorbox({href: $(this).attr('href'), iframe:true, width: 432, innerHeight:200, open:true,opacity: "0.4"});
    e.preventDefault();
    return false;
    }); 
thisurl = window.location.href
    $('#copyUrl').zclip({
        path:'/Html/js/ZeroClipboard.swf',
        copy:thisurl
    });
    $("#sharewb").click(function(event) {
        window.open("http://service.weibo.com/share/share.php?url="+thisurl+"&type=button&ralateUid=2961848493&language=zh_cn&appkey=1VDwW4&searchPic=true&style=simple")
    });
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>