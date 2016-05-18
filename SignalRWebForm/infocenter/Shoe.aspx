<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Shoe.aspx.cs" Inherits="infocenter_Shoe" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title><%=ctitle%>-跑步装备-益跑网-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <meta property="wb:webmaster" content="a859eadcc5aee52a" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<style>
.nav li.h_zb em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}
</style>
<body>
     <form id="form1" runat="server">
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
		<div class="shoel">
			<div class="shoelt">
				<img src="/Html/images/shoe.png" alt="" />
				<span>跑步鞋</span>
                <a href="/infocenter/ShoeFind.aspx">查找跑鞋</a>
                <a href="/SmartChooseShoe/ShoesMine.aspx">同类搜索</a>
				<a href="/SmartChooseShoe/ShoeCounselor.aspx">智能选鞋</a>
        <!-- <a href=""class="shoed" >同类搜索</a>
        <a href="">高级搜索</a> -->
			</div>
			<div class="shoen">
				<h1></h1>
				<div class="shoex">
					<img src="/Html/images/shoe1.jpg" alt="" />
					<ul></ul>
				</div>
				<div class="shoem">
					<div class="shoei">
						<h2>产品介绍：</h2>
					</div>
					<div class="shoez">
						<span>总结：</span>
					</div>
					
					<div class="shoev" id="youkuplayer" style="display: none;">
						
					</div>
					<div class="shoeda">
						<h2>数据分析：</h2>
						<div id="container"></div>
					</div>
					<div class="shoeda shoec">
						<h2>评测员评论：</h2>
					</div>
					<!-- <div class="shoeda">
						<h2>测评分析：</h2>
						<ul>
							<li>后跟减震：2.2 <span><em data-b="40"></em></span></li>
							<li>灵活性：88.3 <span><em data-b="60"></em></span></li>
							<li>重    量：2.2 <span><em data-b="70"></em></span></li>
							<li>灵活性：88.3 <span><em data-b="50"></em></span></li>
							<li>重    量：2.2 <span><em data-b="55"></em></span></li>
							<li>灵活性：88.3 <span><em data-b="90"></em></span></li>
						</ul>
					</div> -->
					<div class="shoep">
						<h2>我要评论：</h2>
						<asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
						<div class="blog-content">

                        <div class="discuss-border">
                            <div class="discuss-text">
                                <ERUN360:Phiz runat="server" ID="Phiz" />
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <textarea style="font-size: 14px; padding: 5px;" rows="3" cols="70" name="cContent" id="cContent" runat="server"></textarea><br>
                                        <asp:Label ID="lbtip" runat="server" ForeColor="Red"></asp:Label>
                                        <%if (cId == 0) %>
                                        <%{ %>
                                        <div class="discuss-login">
                                            <a href="/Member/">注册</a>|
                                            <a onclick="PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();" href="javascript:">登录</a>

                                        </div>
                                        <%} %>
                                        <%else %>
                                        <%{ %>
                                        <asp:Button ID="btnDiscuss" class="submit" runat="server" Text="提交" OnClick="btnDiscuss_Click" />
                                        <%} %>
                            
                                    <%=DiscussList %>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
					</div>
				</div>
			</div>
		</div>
        <div class="shoer">
          <a target="_blank" href="/zt/runbook/index.aspx"><img width="300" height="300" border="0" alt="初级跑者全书" title="初级跑者全书" src="http://www.erun360.com/adm/ad300.jpg"></a>
                <a target="_blank" href="/blog/200014474.aspx"><img width="300" height="300" border="0" alt="2014年The North Face 100北京国际越野挑战赛暨市民徒步大会" title="初级跑者全书" src="/Html/images/shoetnf.png"></a>
        </div>
    </div>

<script>
   
var id = <%=bId%>,
    data = <%=Result%>,
    shoedata = 0,
    idGender = ["男", "女", "中性"],
    cha = data.fHeel-data.fForefeet,
    idGender = data.idGender?"<li>性别："+idGender[data.idGender]+"</li>":"",
    cType    = "<li>类型："+data.cType+"</li>",
    cBrand   = "<li>品牌："+data.cBrand+"</li>",
    cSeries  = data.cSeries?"<li>系列："+data.cSeries+"</li>":"",
    fPrice   = data.fPrice!=0?"<li>价格：&#65509;"+data.fPrice+"</li>":"",
    fWeight  = "<li>重量："+data.fWeight+"g</li>",
    fForefeet= "<li>前脚高："+data.fForefeet+"mm</li>",
    fHeel    = "<li>后跟高："+data.fHeel+"mm</li>",
    cfeature = data.cfeature?"<li>特点："+data.cfeature+"</li>":"",
    toFixed  = "<li>前后脚高差："+cha.toFixed(1)+"mm</li>",
    dTimetm  = data.dTimetm?"<li>上市时间："+data.dTimetm+"</li>":""

                $(".shoen h1").html(data.cName)
                $(".shoex ul").html(idGender+cType+cBrand+cSeries+fPrice+fWeight+fForefeet+fHeel+cfeature+toFixed+dTimetm)
                data.cImage?$(".shoex img").attr('src', data.cImage):""
                data.cReview?$(".shoei").append(data.cReview):$(".shoei").hide()
                data.cSum?$(".shoez").append(data.cSum):$(".shoez").hide()
                data.cTester?$(".shoec").append(data.cTester):$(".shoec").hide()
                vid = data.cVideo?data.cVideo:''
                rWeight     = data.rWeight
                rHeight     = data.rHeight
                rHeel       = data.rHeel
                rForefeet   = data.rForefeet
                rStiffness  = data.rStiffness
                rStability  = data.rStability
function EmotionAdd(v) {
                document.getElementById("cContent").value += "[" + v + "]";
            }
function huifuta(bid,uid,id){
                $("#text .huifuk").remove();
                $.get("/action/GetMessageList.ashx",{ command: "state"}, function (data) {
                    console.log(data)
                   if(data == "-1"){
                    PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();
                   }else {
                    $("#li"+id).append("<div class=\"huifuk\"><em></em>回复：<br><textarea id=\"reply\"></textarea><a class=\"reply\" onclick=\"replyd("+bid+","+uid+")\" href=\"javascript:void(0)\">发送</a><a class=\"qreply\" onclick=\"qreply()\" href=\"javascript:void(0)\">取消</a></div>")
                   }
                });
            }
function replyd(bid,uid){
                msg = encodeURIComponent($("#reply").val());
                

                $.get("/action/GetMessageList.ashx", { command: "AddHuiFuByShoe", id:bid,idUser: uid,op: "1",msg: msg}, function (data) {
                   if(data == "-1"){
                    PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();
                   }else if(data == "1"){
                       //location.replace(location+ "#text")
                       var replaceRegex = /\#text/g;
                       date = window.location.href.replace(replaceRegex, '')
                       location = date + "#text";
                       window.location.reload()
                    $("#reply").val("");
                    $(".huifuk").remove()
                   }else if(data == "0"){
                   }
                    
                });
            }
            function qreply(){
                $(".huifuk").remove()
            }        		            
$(".shoeda em").each(function() {
	$(this).animate({left:$(this).data("b")+'%'},2100);
});

</script>
<script type="text/javascript" src="/Html/Flotr2/lib/yepnope.js"></script>
<script type="text/javascript" src="/Html/Flotr2/lib/includes.dev.js"></script>
<script type="text/javascript" src="http://player.youku.com/jsapi">
jQuery(document).ready(function($) {
	if(vid){
$("#youkuplayer").show()
    player = new YKU.Player('youkuplayer',{
    client_id: 'bf9a4d4a668be0b8',
    vid: vid
});
}
});
</script> 
          
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
         </form>
</body>
</html>