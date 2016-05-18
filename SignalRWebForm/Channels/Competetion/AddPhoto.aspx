<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AddPhoto.aspx.cs" Inherits="Channels_Competetion_AddPhoto" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/race.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
</head>
<body>
	<style>
		.raceaddimg{color: #000}
		.raceaddimg tr td:first-child{text-align: right;height: 60px;}
		.raceaddimg tr{}
	</style>
   <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form  id="bcfrom" runat="server">
    <div class="indecen ">
        <div class="racebody">            
            <h1><asp:Literal ID="ltlTitle" runat="server"></asp:Literal></h1>
            <div class="racetip">
                更新赛事证明图片
            </div>
            <div class="mproject">
            	<table class="raceaddimg">
            		<tr>
            			<td>体检证明：<br>Medical Certificate：</td><td><asp:FileUpload ID="fptjzm" runat="server" /></td>
            		</tr>
            		<tr>
            			<td>心电图：<br>ECG：</td><td><asp:FileUpload ID="fpcjzs1" runat="server" /></td>
            		</tr>
            		<tr>
            			<td>成绩证书：<br>Race Results：</td><td><asp:FileUpload ID="fpcjzs2" runat="server" /></td>
            		</tr>
            	</table>
                
                <asp:Button ID="projectpos" runat="server" OnClick="btSubmit_Click"  />
                 
            </div>
        </div>
    </div>
        </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    <script>
jQuery(document).ready(function($) {
	if(GetQueryString("idcompete") == "300000445"){
                loadjscssfile("/Html/css/racetnf.css", "css")
                $(".logo").replaceWith('<div class="tnflogo"><a href="/"><img src="/Html/images/tnflogo1.png"></a><a href="http://www.quyeba.com" target="_blank"><img src="/Html/images/tnflogo2.png"></a><a href="http://www.quyeba.com/tnf100/" target="_blank"><img src="/Html/images/tnflogo3.png"></a></div>')
            }
});
function GetQueryString(name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                    }
function loadjscssfile(filename, filetype){ 
if (filetype=="js"){ //判断文件类型 
  var fileref=document.createElement('script')//创建标签 
  fileref.setAttribute("type","text/javascript")//定义属性type的值为text/javascript 
  fileref.setAttribute("src", filename)//文件的地址 
} 
else if (filetype=="css"){ //判断文件类型 
  var fileref=document.createElement("link") 
  fileref.setAttribute("rel", "stylesheet") 
  fileref.setAttribute("type", "text/css")  
  fileref.setAttribute("href", filename) 
} 
if (typeof fileref!="undefined") 
  document.getElementsByTagName("head")[0].appendChild(fileref) 
}  
    </script>
</body>
</html>
