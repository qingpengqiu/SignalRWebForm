document.write("<div class=\"header\">");
document.write("	<div class=\"indecen\">		");
document.write("		<div class=\"topnav\" id=\"user_info\">");
document.write("		</div>");
document.write("		<a href=\"/\"><img src=\"/Images/index/logo.png\" alt=\"\"> </a>");
document.write("		<ul class=\"nav\">");
document.write("			<li class=\"h_sy\"><a href=\"/\">首页</a> </li>");

document.write("			<li class=\"h_js\"><a href=\"/channels/competetion/\">赛事&bull;城市</a> </li>");
document.write("			<li class=\"h_xl\"><a href=\"/channels/train/\">跑步训练</a> </li>");
document.write("			<li class=\"h_zb\"><a href=\"/channels/shoe/\">跑步装备</a> </li>");
document.write("			<li class=\"h_yy\"><a href=\"/channels/nutrition/\">营养&bull;瘦身</a> </li>");
document.write("			<li class=\"h_jk\"><a href=\"/channels/health/\">健康恢复</a> </li>");
document.write("			<li class=\"h_cj\"><a href=\"/channels/beginner/\">初级跑者</a> </li>");
document.write("			<li class=\"h_rs\"><a href=\"/channels/life/\">跑步人生</a> </li>");
document.write("			<li class=\"h_zl\"><a href=\"/channels/expert/\">益跑专栏</a> </li>");
document.write("			<li class=\"h_gj\"><a href=\"/channels/tools/\">小工具</a> </li>");
document.write("		</ul>");
document.write("	</div>");
document.write("</div>");
function gettwo() {
$.ajax({
   type: "GET",
   url: "/infocenter/Include/AjaxCount.aspx",
   data:{rnd:Math.random()},
   contentType: "application/json; charset=utf-8",
   dataType: "json",
   success: function(msg){
        if(msg.hea > "0"){
            $(".msgshowa").append("<em>"+msg.hea+"</em>")
        }
        if(msg.count > "0"){
            $(".msgshowl").append("<em>"+msg.count+"</em>")
        }
        if(msg.msgcount > "0"){
            $(".msgshowb").append("<em>"+msg.msgcount+"</em>")
            $(".msgshowf").append("<em>"+msg.msgcount+"</em>")
        }
        if(msg.dcscount > "0"){
            $(".msgshowpl").append("<em>"+msg.dcscount+"</em>")
        }
   }
}); 
setTimeout("gettwo()", 60000)
}
$(function () {
    gettwo()
});
//头部下拉js
$(".topr").on('click', function() {
    $(this).addClass('toprb');
});
