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
            ����ѡЬ
        </h3>
    </div>
    <div class="shoelt">
      <a href="ShoeFind.aspx" class="<%=cssSearch %>" >������Ь</a><a href="ShoesMine.aspx" class="<%=cssLikeMine %>">ͬ������</a><a href="ShoeCounselor.aspx" class="<%=cssAdvisor %>">����ѡЬ</a>
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
var xba = ['��','Ů'],
    qjzhca = ['����','�ǳ�Ӳ','Ӳ','�е�','��','�ǳ���'],
    lhxa = ['����','�ǳ�Ӳ','Ӳ','�ж�','���','�ǳ����'],
    qhgca = ['����','0mm','1mm - 4mm','5mm - 8mm','9mm - 12mm','13mm+'],
    xxa = ['����','��·','ԽҰ'],
    wdxa = ['����','�ǳ���','��','�е�','��','�ǳ���'],
    jga = ['����','400����','400-600','600-1000','1000����'],
    zla = ['����','�ǳ���','��','�е�','��','�ǳ���'],
    zghca = ['����','�ǳ�Ӳ','Ӳ','�е�','��','�ǳ���'],
    gda = ['����','�ǳ���','��','�е�','��','�ǳ���'],
    action =GetQueryString("action"),
    shoetype = {"road":"��·","trail":"ԽҰ"},
    runlevel = {"beginner":"����","intermediate":"�м�","advanced":"�߼�"},
    // WeekRunKM = {"1\-8":"1\-8 km","8\-16":"8\-16 km","16\-32":"16\-32 km","32\-48":"32\-48 km","\>48":"\>48 km"},
    injured = {"notatall":"û��","minor":"����","major":"����"},
    highofarch = {"flat":"��","medium":"��","high":"��","dontknow":"�����"},
    motionmechanics = {"underpronator":"�ڷ� (���)","normal":"���� (���)","overpronator":"�ⷭ (���)","dontknow":"�����"},
    strikeground = {"forefoot":"ǰ����","midfoot":"ȫ����","heel":"�Ÿ�","extremheel":"���˽Ÿ�"}
    var rWeight     = <%=weightpercent%>,
        rHeight     = <%=heightpercent%>,
        rHeel       = <%=heelpercent%>,
        rForefeet   = <%=forefootpercent%>,
        rStiffness  = <%=stiffnesspercent%>,
        rStability  = <%=stabilitypercent%>
option = {
    title : {
        subtext: '���ĵ�Ϊ0�����ֵ100'
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
                {text : '����', max  : 100},
                {text : '�߶�', max  : 100},
                {text : '�������', max  : 100},
                {text : 'ǰ���Ƽ���', max  : 100},
                {text : 'Ӳ��', max  : 100},
                {text : '�ȶ���', max  : 100}
            ],
            radius : 130
        }
    ],
    series : [
        {
            name: '��ǰѡЬ����',
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
                    name : '��ǰ����'
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
      qjzhcb = GetQueryString("qjzhc")==0 ? '' : '<i>|</i>ǰ���ƻ��壺'+lhxa[GetQueryString("qjzhc")],
      zzsb   = GetQueryString("zzs")==0 ? '' : '<i>|</i>�����̣�'+GetQueryString("zzs"),
      mzb    = GetQueryString("mz")?'<i>|</i>���֣�'+GetQueryString("mz"):'',
      lhxb = GetQueryString("lhx")==0 ? '' : '<i>|</i>����ԣ�'+lhxa[GetQueryString("lhx")],
      qhgcb = GetQueryString("qhgc")==0 ? '' : '<i>|</i>ǰ����'+qhgca[GetQueryString("qhgc")],
      xxb = GetQueryString("xx")==0 ? '' : '<i>|</i>Ь�ͣ�'+xxa[GetQueryString("xx")],
      wdxb = GetQueryString("wdx")==0 ? '' : '<i>|</i>�ȶ��ԣ�'+wdxa[GetQueryString("wdx")],
      jgb = GetQueryString("jg")==0 ? '' : '<i>|</i>�۸�'+jga[GetQueryString("jg")],
      zlb = GetQueryString("zl")==0 ? '' : '<i>|</i>������'+zla[GetQueryString("zl")],
      zghcb = GetQueryString("zghc")==0 ? '' : '<i>|</i>������壺'+zghca[GetQueryString("zghc")],
      gdb = GetQueryString("gd")==0 ? '' : '<i>|</i>�߶ȣ�'+gda[GetQueryString("gd")]
      shoetip = '������������ǻ��������Ҫ��:<p>�Ա�'+xbb+zzsb+qjzhcb+mzb+lhxb+qhgcb+xxb+wdxb+jgb+zlb+gdb+zghcb+'</p>������������⣬������<a href="ShoeFind.aspx">��������</a>��<a href="">�����޸�</a>'
    break;
  case 'likemine':
  var xbb = xba[GetQueryString("gender")],
      pp  = GetQueryString("manufacturer"),
      model = GetQueryString("model")
      shoetip = '������������ǻ��������Ҫ��:<p>�Ա�'+xbb+'<i>|</i>Ʒ�ƣ�'+pp+'<i>|</i>ϵ�У�'+model+'</p>������������⣬������<a href="ShoesMine.aspx">��������</a>'
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
      shoetip = '������������ǻ��������Ҫ��:<p>�Ա�'+xbb+'<i>|</i>��ߣ�'+GetQueryString("tall")+'cm<i>|</i>���أ�'+GetQueryString("weight")+'kg<i>|</i>Ь�ͣ�'+eval("shoetype." + shoetypes)+'<i>|</i>�ܲ�ˮƽ��'+eval("runlevel." + runlevels)+'<i>|</i>ƽ�����٣�'+GetQueryString("pacemin")+'��'+GetQueryString("PaceSec")+'��<i>|</i>��һ���Ƿ������ˣ�'+eval("injured." + injureds)+'<i>|</i>�㹭�߶ȣ�'+eval("highofarch." + highofarchs)+'<i>|</i>���ⷭ��'+eval("motionmechanics." + motionmechanicss)+'<i>|</i>�ŵ�λ�ã�'+eval("strikeground." + strikegrounds)+'</p>������������⣬������<a href="ShoeCounselor.aspx">��������</a>'
      // <i>|</i>��������'+eval("WeekRunKM." + WeekRunKMs)+'
    break;
  default:
      $(".toast").html('�Ƿ���Դ').show().addClass('toast-error')
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
  //��ҳ������10 ȫ����ʾ,����10 ��ʾǰ3 ��3 �м�3 ����....
  if (pageindex == 1) {
    a[a.length] = "<a href=\"#\" class=\"prev unclick\">��һҳ</a>";
  } else {
    a[a.length] = "<a href=\"#\" class=\"prev\">��һҳ</a>";
  }
  function setPageList() {
    if (pageindex == i) {
      a[a.length] = "<a href=\"#\" class=\"on\">" + i + "</a>";
    } else {
      a[a.length] = "<a href=\"#\">" + i + "</a>";
    }
  }
  //��ҳ��С��10
  if (count <= 10) {
    for (var i = 1; i <= count; i++) {
      setPageList();
    }
  }
  //��ҳ������10ҳ
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
    else { //��ǰҳ���м䲿��
      a[a.length] = "<a href=\"#\">1</a><em>...</em>";
      for (var i = pageindex - 2; i <= pageindex + 2; i++) {
        setPageList();
      }
      a[a.length] = "<em>...</em><a href=\"#\">" + count + "</a>";
    }
  }
  if (pageindex == count) {
    a[a.length] = "<a href=\"#\" class=\"next unclick\">��һҳ</a>";
  } else {
    a[a.length] = "<a href=\"#\" class=\"next\">��һҳ</a>";
  }
  container.innerHTML = a.join("");
  //�¼����
  var pageClick = function() {
    var oAlink = container.getElementsByTagName("a");
    var inx = pageindex; //��ʼ��ҳ��
    oAlink[0].onclick = function() { //�����һҳ
      if (inx == 1) {
        return false;
      }
      inx--;
      location.href = replaceParamVal(yurl,"p",inx)
      return false;
    }
    for (var i = 1; i < oAlink.length - 1; i++) { //���ҳ��
      oAlink[i].onclick = function() {
        inx = parseInt(this.innerHTML);
        location.href = replaceParamVal(yurl,"p",inx)
        return false;
      }
    }
    oAlink[oAlink.length - 1].onclick = function() { //�����һҳ
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