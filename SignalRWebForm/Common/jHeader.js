document.write("<div class=\"header\">");
document.write("	<div class=\"indecen\">		");
document.write("		<div class=\"topnav\" id=\"user_info\">");
document.write("		</div>");
document.write("		<a href=\"/\"><img src=\"/Images/index/logo.png\" alt=\"\"> </a>");
document.write("		<ul class=\"nav\">");
document.write("			<li class=\"h_sy\"><a href=\"/\">��ҳ</a> </li>");

document.write("			<li class=\"h_js\"><a href=\"/channels/competetion/\">����&bull;����</a> </li>");
document.write("			<li class=\"h_xl\"><a href=\"/channels/train/\">�ܲ�ѵ��</a> </li>");
document.write("			<li class=\"h_zb\"><a href=\"/channels/shoe/\">�ܲ�װ��</a> </li>");
document.write("			<li class=\"h_yy\"><a href=\"/channels/nutrition/\">Ӫ��&bull;����</a> </li>");
document.write("			<li class=\"h_jk\"><a href=\"/channels/health/\">�����ָ�</a> </li>");
document.write("			<li class=\"h_cj\"><a href=\"/channels/beginner/\">��������</a> </li>");
document.write("			<li class=\"h_rs\"><a href=\"/channels/life/\">�ܲ�����</a> </li>");
document.write("			<li class=\"h_zl\"><a href=\"/channels/expert/\">����ר��</a> </li>");
document.write("			<li class=\"h_gj\"><a href=\"/channels/tools/\">С����</a> </li>");
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
//ͷ������js
$(".topr").on('click', function() {
    $(this).addClass('toprb');
});
