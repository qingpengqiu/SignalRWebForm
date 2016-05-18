<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoeList.aspx.cs" Inherits="SmartChooseShoe_ShoeList" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
<link href="/Html/css/shoemedia.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/Html/js/echarts.js" charset="UTF-8"></script>
<form id="form1" runat="server">
<article>
  <div class="V3Left">
    <div class="listtitlel">
        <img src="/Images/classify/1009.jpg">
        <h3>
            智能选鞋
        </h3>
    </div>
    <div class="shoelt">
      <a href="ShoeFind.aspx" class="<%=cssSearch %>" >查找跑鞋</a><a href="ShoesMine.aspx" class="<%=cssLikeMine %>">同类搜索</a><a href="ShoeCounselor.aspx" class="<%=cssAdvisor %>">智能选鞋</a>
    </div>
    <div class="shoefind shoefindresult">              
      <div class="shoem">
        <div class="shoeresultstip"></div>
        <div id="container"></div>
      </div>
      <ul class="findresult">
        <%=Result%>
      </ul>
      <div class="fshoepage"></div>
    </div>
  </div>
    <div class="V3Righr">
        <%= addgg.ADList(90000,1,0) %>
        <asp:Literal ID="ltlTour" runat="server"></asp:Literal>
        <%= addgg.ADList(90000,2,0) %>
        <%= addgg.ADList(90000,3,0) %>
        <%= addgg.ADList(90000,4,0) %>
        <%= addgg.ADList(90000,5,0) %>
        <%= addgg.ADList(90000,6,0) %>
        <%= addgg.ADList(90000,7,0) %>
    </div>
        <%= addgg.ADList(90000,8,0) %>
</article>
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
    gda = ['所有','非常低','低','中等','高','非常高'],
    action =GetQueryString("action"),
    shoetype = {"road":"公路","trail":"越野"},
    runlevel = {"beginner":"初级","intermediate":"中级","advanced":"高级"},
    // WeekRunKM = {"1\-8":"1\-8 km","8\-16":"8\-16 km","16\-32":"16\-32 km","32\-48":"32\-48 km","\>48":"\>48 km"},
    injured = {"notatall":"没有","minor":"轻伤","major":"重伤"},
    highofarch = {"flat":"低","medium":"中","high":"高","dontknow":"不清楚"},
    motionmechanics = {"underpronator":"内翻 (左脚)","normal":"正常 (左脚)","overpronator":"外翻 (左脚)","dontknow":"不清楚"},
    strikeground = {"forefoot":"前脚掌","midfoot":"全脚掌","heel":"脚跟","extremheel":"极端脚跟"}
    var rWeight     = <%=weightpercent%>,
        rHeight     = <%=heightpercent%>,
        rHeel       = <%=heelpercent%>,
        rForefeet   = <%=forefootpercent%>,
        rStiffness  = <%=stiffnesspercent%>,
        rStability  = <%=stabilitypercent%>
option = {
    title : {
        subtext: '中心点为0，最大值100'
    },
    tooltip : {
        trigger: 'axis'
    },
    toolbox: {
        show : true,
        feature : {
            restore : {show: true},
            saveAsImage : {show: true}
        }
    },
    calculable : true,
    polar : [
        {
            indicator : [
                {text : '重量', max  : 100},
                {text : '高度', max  : 100},
                {text : '后跟减震', max  : 100},
                {text : '前脚掌减震', max  : 100},
                {text : '硬度', max  : 100},
                {text : '稳定性', max  : 100}
            ],
            radius : 130
        }
    ],
    series : [
        {
            name: '当前选鞋数据',
            type: 'radar',
            itemStyle: {
                normal: {
                    areaStyle: {
                        type: 'default'
                    }
                }
            },
            data : [
                {
                    value : [rWeight, rHeight, rHeel, rForefeet, rStiffness, rStability],
                    name : '当前数据'
                }
            ]
        }
    ]
};
if (rWeight) {
  $("#container").show()
  var myChart1 = echarts.init(document.getElementById('container'),'macarons');
  myChart1.setOption(option);
};
jQuery(document).ready(function($) {
    var shoetip = ''
    setPage(document.getElementsByClassName("fshoepage")[0],Math.ceil(<%=RecordCount%>/20),<%=pageIndex%>);
  switch(action)
  {
  case 'search':
  var xbb = xba[GetQueryString("xb")],
      qjzhcb = GetQueryString("qjzhc")==0 ? '' : '<i>|</i>前脚掌缓冲：'+lhxa[GetQueryString("qjzhc")],
      zzsb   = GetQueryString("zzs")==0 ? '' : '<i>|</i>制造商：'+GetQueryString("zzs"),
      mzb    = GetQueryString("mz")?'<i>|</i>名字：'+GetQueryString("mz"):'',
      lhxb = GetQueryString("lhx")==0 ? '' : '<i>|</i>灵活性：'+lhxa[GetQueryString("lhx")],
      qhgcb = GetQueryString("qhgc")==0 ? '' : '<i>|</i>前后跟差：'+qhgca[GetQueryString("qhgc")],
      xxb = GetQueryString("xx")==0 ? '' : '<i>|</i>鞋型：'+xxa[GetQueryString("xx")],
      wdxb = GetQueryString("wdx")==0 ? '' : '<i>|</i>稳定性：'+wdxa[GetQueryString("wdx")],
      jgb = GetQueryString("jg")==0 ? '' : '<i>|</i>价格：'+jga[GetQueryString("jg")],
      zlb = GetQueryString("zl")==0 ? '' : '<i>|</i>重量：'+zla[GetQueryString("zl")],
      zghcb = GetQueryString("zghc")==0 ? '' : '<i>|</i>足跟缓冲：'+zghca[GetQueryString("zghc")],
      gdb = GetQueryString("gd")==0 ? '' : '<i>|</i>高度：'+gda[GetQueryString("gd")]
      shoetip = '您的搜索结果是基于下面的要求:<p>性别：'+xbb+zzsb+qjzhcb+mzb+lhxb+qhgcb+xxb+wdxb+jgb+zlb+gdb+zghcb+'</p>搜索结果不满意，您可以<a href="ShoeFind.aspx">重新搜索</a>或<a href="">返回修改</a>'
    break;
  case 'likemine':
  var xbb = xba[GetQueryString("gender")],
      pp  = GetQueryString("manufacturer"),
      model = GetQueryString("model")
      shoetip = '您的搜索结果是基于下面的要求:<p>性别：'+xbb+'<i>|</i>品牌：'+pp+'<i>|</i>系列：'+model+'</p>搜索结果不满意，您可以<a href="ShoesMine.aspx">重新搜索</a>'
    break;
  case 'advisor':
      var xbb = xba[GetQueryString("gender")],
          shoetypes = GetQueryString("shoetype"),
          runlevels = GetQueryString("runlevel"),
          WeekRunKMs = GetQueryString("WeekRunKM"),
          injureds = GetQueryString("injured"),
          highofarchs = GetQueryString("highofarch"),
          motionmechanicss = GetQueryString("motionmechanics"),
          strikegrounds = GetQueryString("strikeground")
      shoetip = '您的搜索结果是基于下面的要求:<p>性别：'+xbb+'<i>|</i>身高：'+GetQueryString("tall")+'cm<i>|</i>体重：'+GetQueryString("weight")+'kg<i>|</i>鞋型：'+eval("shoetype." + shoetypes)+'<i>|</i>跑步水平：'+eval("runlevel." + runlevels)+'<i>|</i>平均配速：'+GetQueryString("pacemin")+'分'+GetQueryString("PaceSec")+'秒<i>|</i>近一年是否有受伤：'+eval("injured." + injureds)+'<i>|</i>足弓高度：'+eval("highofarch." + highofarchs)+'<i>|</i>内外翻：'+eval("motionmechanics." + motionmechanicss)+'<i>|</i>着地位置：'+eval("strikeground." + strikegrounds)+'</p>搜索结果不满意，您可以<a href="ShoeCounselor.aspx">重新搜索</a>'
      // <i>|</i>周跑量：'+eval("WeekRunKM." + WeekRunKMs)+'
    break;
  default:
      $(".toast").html('非法来源').show().addClass('toast-error')
      setTimeout(function(){location.href = 'ShoeFind.aspx'},3000)
  }
  $(".shoeresultstip").html(shoetip)
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
</script>
</form>
<ERUN360:footerv3 runat="server" ID="footerv3" />