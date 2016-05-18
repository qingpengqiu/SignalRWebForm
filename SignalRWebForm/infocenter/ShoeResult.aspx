<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoeResult.aspx.cs" Inherits="infocenter_ShoeResult" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title>跑鞋搜索结果-跑步装备-益跑网-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
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
  <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
     <form id="form1" runat="server">
    <div class="indecen">
        <div class="shoel">
            <div class="shoelt">
                <img src="/Html/images/shoe.png" alt="" />
                <span>跑步鞋</span>
                <a href="/infocenter/ShoeFind.aspx" class="shoed">查找跑鞋</a>
				<a href="/SmartChooseShoe/ShoesMine.aspx">同类搜索</a>
				<a href="/SmartChooseShoe/ShoeCounselor.aspx">智能选鞋</a>
        <!-- <a href="" >同类搜索</a>
        <a href="">高级搜索</a> -->
            </div>
            <div class="shoefind">
               <div class="sfresult">
                   
               </div>
                <ul class="findresult">
                </ul>
                <div class="fshoepage"></div>
            </div>
        </div>
        <div class="shoer">
          <a target="_blank" href="/zt/runbook/index.aspx"><img width="300" height="300" border="0" alt="初级跑者全书" title="初级跑者全书" src="http://www.erun360.com/adm/ad300.jpg"></a>
                <a target="_blank" href="/blog/200014474.aspx"><img width="300" height="300" border="0" alt="2014年The North Face 100北京国际越野挑战赛暨市民徒步大会" title="初级跑者全书" src="/Html/images/shoetnf.png"></a>
        </div>
    </div>

<script>
var xba = ['男','女'],
    qjzhca = ['所有','非常硬','硬','中等','软','非常软'],
    lhxa = ['所有','非常硬','硬','中度','灵活','非常灵活'],
    qhgca = ['所有','0mm','1mm - 4mm','5mm - 8mm','9mm - 12mm','13mm+'],
    xxa = ['所有','公路','越野'],
    wdxa = ['所有','非常低','低','中等','高','非常高'],
    jga = ['所有','400以下','400-600','600-1000','1000以上'],
    zla = ['所有','非常轻','轻','中等','重','非常重'],
    zghca = ['所有','非常硬','硬','中等','软','非常重'],
    gda = ['所有','非常低','低','中等','高','非常高']
jQuery(document).ready(function($) {
    var data =<%=Result%>
    if(data == ""){
        $(".findresult").append('<li>没有找到匹配的鞋子</li>');
    }
    $.each(data, function (i,item) {
        var shoeimg = data[i].cImage?data[i].cImage:'/Html/images/noshoe.png',
            shoermb = data[i].fPrice?'<em>价格：￥'+data[i].fPrice+'</em>':'',
            cSum    = data[i].cSum?data[i].cSum:''
        $(".findresult").append('<li><a href="/shoe/'+data[i].id+'.aspx" target="_blank"><img src="'+shoeimg+'" alt="'+data[i].cName+'" /></a><div class="shoenr"><a href="/shoe/'+data[i].id+'.aspx" target="_blank">'+data[i].cName+'</a><p>'+cSum+'</p>'+shoermb+'</div></li>')
                               })
    setPage(document.getElementsByClassName("fshoepage")[0],Math.ceil(<%=RecordCount%>/20),<%=pageIndex%>);
var xbb = xba[GetQueryString("xb")],
    qjzhcb = GetQueryString("qjzhc")==0 ? '' : '，前脚掌缓冲'+lhxa[GetQueryString("qjzhc")],
    zzsb   = GetQueryString("zzs")==0 ? '' : '，制造商是'+GetQueryString("zzs"),
    mzb    = GetQueryString("mz")?'，名字是'+GetQueryString("mz"):'',
    lhxb = GetQueryString("lhx")==0 ? '' : '，灵活性'+lhxa[GetQueryString("lhx")],
    qhgcb = GetQueryString("qhgc")==0 ? '' : '，前后跟差'+qhgca[GetQueryString("qhgc")],
    xxb = GetQueryString("xx")==0 ? '' : '，鞋型'+xxa[GetQueryString("xx")],
    wdxb = GetQueryString("wdx")==0 ? '' : '，稳定性'+wdxa[GetQueryString("wdx")],
    jgb = GetQueryString("jg")==0 ? '' : '，价格'+jga[GetQueryString("jg")],
    zlb = GetQueryString("zl")==0 ? '' : '，重量'+zla[GetQueryString("zl")],
    zghcb = GetQueryString("zghc")==0 ? '' : '，足跟缓冲'+zghca[GetQueryString("zghc")],
    gdb = GetQueryString("gd")==0 ? '' : '，高度'+gda[GetQueryString("gd")]
if(GetQueryString("xb")){
  $(".sfresult").html('您的搜索结果是基于下面的要求:性别是'+xbb+zzsb+qjzhcb+mzb+lhxb+qhgcb+xxb+wdxb+jgb+zlb+gdb+zghcb+'。搜索结果不满意，你可以<a href="/infocenter/ShoeFind.aspx">重新搜索</a>或<a href="javascript:history.go(-1)">返回修改</a>')
}else{
  $(".sfresult").html('没有搜索要求,请<a href="/infocenter/ShoeFind.aspx">重新搜索</a>')
}
    
    
});
function replaceParamVal(oldUrl, paramName, replaceWith) {
    var re = eval('/(' + paramName + '=)([^&]*)/gi');
    var nUrl = oldUrl.replace(re, paramName + '=' + replaceWith);
    return nUrl;
}
function setPage(container, count, pageindex) {
var container = container,
    count = count,
    pageindex = pageindex,
    yurl = window.location.href,
    a = []
  //总页数少于10 全部显示,大于10 显示前3 后3 中间3 其余....
  if (pageindex == 1) {
    a[a.length] = "<a href=\"#\" class=\"prev unclick\">上一页</a>";
  } else {
    a[a.length] = "<a href=\"#\" class=\"prev\">上一页</a>";
  }
  function setPageList() {
    if (pageindex == i) {
      a[a.length] = "<a href=\"#\" class=\"on\">" + i + "</a>";
    } else {
      a[a.length] = "<a href=\"#\">" + i + "</a>";
    }
  }
  //总页数小于10
  if (count <= 10) {
    for (var i = 1; i <= count; i++) {
      setPageList();
    }
  }
  //总页数大于10页
  else {
    if (pageindex <= 4) {
      for (var i = 1; i <= 5; i++) {
        setPageList();
      }
      a[a.length] = "<em>...</em><a href=\"#\">" + count + "</a>";
    } else if (pageindex >= count - 3) {
      a[a.length] = "<a href=\"#\">1</a><em>...</em>";
      for (var i = count - 4; i <= count; i++) {
        setPageList();
      }
    }
    else { //当前页在中间部分
      a[a.length] = "<a href=\"#\">1</a><em>...</em>";
      for (var i = pageindex - 2; i <= pageindex + 2; i++) {
        setPageList();
      }
      a[a.length] = "<em>...</em><a href=\"#\">" + count + "</a>";
    }
  }
  if (pageindex == count) {
    a[a.length] = "<a href=\"#\" class=\"next unclick\">下一页</a>";
  } else {
    a[a.length] = "<a href=\"#\" class=\"next\">下一页</a>";
  }
  container.innerHTML = a.join("");
  //事件点击
  var pageClick = function() {
    var oAlink = container.getElementsByTagName("a");
    var inx = pageindex; //初始的页码
    oAlink[0].onclick = function() { //点击上一页
      if (inx == 1) {
        return false;
      }
      inx--;
      location.href = replaceParamVal(yurl,"p",inx)
      return false;
    }
    for (var i = 1; i < oAlink.length - 1; i++) { //点击页码
      oAlink[i].onclick = function() {
        inx = parseInt(this.innerHTML);
        location.href = replaceParamVal(yurl,"p",inx)
        return false;
      }
    }
    oAlink[oAlink.length - 1].onclick = function() { //点击下一页
      if (inx == count) {
        return false;
      }
      inx++;
      location.href = replaceParamVal(yurl,"p",inx)
      return false;
    }

  } ()
}
function GetQueryString(name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                    }



</script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
         </form>
</body>
</html>