<%@ Page Language="C#" AutoEventWireup="true" CodeFile="internationalEvents.aspx.cs" Inherits="Channels_Competetion_internationalEvents" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="content-type" content="text/html; charset=gb2312" />
<title>马拉松国际赛事直通车-益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
<meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
<meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<meta http-equiv="content-language" content="zh-cn" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="distribution" content="global" />
<meta property="wb:webmaster" content="a859eadcc5aee52a" />
<link href="favicon.ico" rel="shortcut icon" type="image/ico">
<link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
<link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
<link href="/Common/cansai-from.css?2012111" rel="stylesheet" type="text/css"/>
<link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css"/>
<link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
<script language="javascript" src="/Common/jQuery1.8.js"></script>
<script language="javascript" src="/Common/jCity.js"></script>

</head>
<style>
.nav li.h_js em {background: url(/Images/index/adqbj.png) no-repeat center 49px;}
</style>
<body>
<script language="javascript" src="/Common/jCheck.js"></script>
<script language="javascript" src="/Common/jPopup.js"></script>
<script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
<script language="javascript" src="/Common/jCalendar.js"></script>
<script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<style type="text/css">
.mlistnav .this{background: #e0af80;color: #fff;}
</style>
<ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form id="form1" runat="server">
    <div class="indecen internation">
      <img src="/Html/images/internationaltop.png">
      <div class="internationtop">
        <span>热门赛事</span>： <asp:Literal ID="ltlhot" runat="server"></asp:Literal>
         <%-- <a href="">日本东京马拉松</a><a href="">新加坡日落马拉松</a><a href="">洛杉矶马拉松跑团</a><a href="">柏林马拉松跑团</a><a href="">巴塞罗那马拉松炎尔跑团</a>--%>
        <div class="internationselect">
          <label>时间</label>
              <select class="form-control timelist" id="fieldMonth" runat="server">
                   <option value="0">全部</option>
                    <option value="1">最近1个月</option>
                    <option value="3">最近3个月</option>
                    <option value="6">最近6个月</option>
                    <option value="12">6个月以上</option>
              </select>
          <label>地区</label>
              <select class="form-control citylist" id="form-field-select-1">
                <%=area%>
              </select>
        </div>
                                        
      </div>
	<div class="mlslist">
		<ul>
            <asp:Repeater ID="rptrunrecord" runat="server" OnItemDataBound="rptrunrecord_ItemDataBound">
                <ItemTemplate>
                    <li><span><a target="_blank" href="/blog/<%#Eval("idblog")%>.aspx"><%#Eval("cTitle")%></a></span>
				        <img src="<%#Eval("cURL").ToString()%> " width="148"/>
				        比赛时间：<%#Convert.ToDateTime(Eval("dRaceBegin")).ToString("yyyy-MM-dd")%> <br>
                        报名截止时间：<%#Convert.ToDateTime(Eval("dJoinEnd")).ToString("yyyy-MM-dd")%> <br>
				        比赛费用：<asp:Repeater runat="server" ID="rpquestionlist">
                            <ItemTemplate>
                                 <%#XString.ContentTrunc(Eval("text").ToString(), 100)%>                              
                            </ItemTemplate>
                        </asp:Repeater>				        
                         <%#DateTime.Compare(DateTime.Now,Convert.ToDateTime(Eval("dJoinEnd").ToString())) <= 0?"<a target='_blank' class='csbm' href='RaceProject.aspx?idcompete="+Eval("id")+"'>立即报名</a>":" <a class='jieshu'>报名结束</a>"%>
			        </li>
                </ItemTemplate>
            </asp:Repeater>
		</ul>
	</div>
   <div id="apage" runat="server" visible="false" class="pages">
   <asp:label ID="lblCurrentPage" runat="server"></asp:label>
   <asp:HyperLink id="lnkFrist" runat="server">首页</asp:HyperLink>
   <asp:HyperLink id="lnkPrev" runat="server">上一页</asp:HyperLink>
   <asp:HyperLink id="lnkNext" runat="server">下一页</asp:HyperLink> 
   <asp:HyperLink id="lnkEnd" runat="server">尾页</asp:HyperLink>
</div>

</div>

    </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    <script type="text/javascript">
      var destiny = window.location.href
      var gid = GetQueryString('id')
      var gcityid = GetQueryString('cityid')
      
      jQuery(document).ready(function($) {
        $(".citylist option").each(function(index, el) {
           var ohtml = $(this).html()
           if(gcityid == ohtml){
              $(this).attr('selected', 'selected');
            }
           if (ohtml > 0) {
              $(this).html(china[ohtml-1][0])
           };
        });
        $(".timelist option").each(function(index, el) {
            var oid = $(this).attr('value');
            if(oid == gid){
              $(this).attr('selected', 'selected');
            }
        });
      });

      
      


      $(".citylist").change(function(event) {
            var changeurl = changeURLPar(destiny, 'cityid', $(this).val())
            window.location.href = changeurl
          });
      $(".timelist").change(function(event) {
          window.location.href = changeURLPar('/Channels/Competetion/internationalEvents.aspx', 'id', $(this).val())
        });
function GetQueryString(name) {
  var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
  var r = window.location.search.substr(1).match(reg);
  if (r != null) return unescape(r[2]); return null;
  }
function changeURLPar(destiny, par, par_value){
    var pattern = par+'=([^&]*)';
    var replaceText = par+'='+par_value;
    if (destiny.match(pattern)){
        var tmp = '/'+par+'=[^&]*/';

        

        tmp = destiny.replace(eval(tmp), replaceText);

        return (tmp);
    }else{
        if (destiny.match('[\?]')){
            return destiny+'&'+ replaceText;
        }else{
            return destiny+'?'+replaceText;
        }
    }
    return destiny+'\n'+par+'\n'+par_value;
}
    </script>
</body>
</html>
