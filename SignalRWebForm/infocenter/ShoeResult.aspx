<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoeResult.aspx.cs" Inherits="infocenter_ShoeResult" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="��http://open.weibo.com/wb��">
<head>
    <title>��Ь�������-�ܲ�װ��-������-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
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
                <span>�ܲ�Ь</span>
                <a href="/infocenter/ShoeFind.aspx" class="shoed">������Ь</a>
				<a href="/SmartChooseShoe/ShoesMine.aspx">ͬ������</a>
				<a href="/SmartChooseShoe/ShoeCounselor.aspx">����ѡЬ</a>
        <!-- <a href="" >ͬ������</a>
        <a href="">�߼�����</a> -->
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
          <a target="_blank" href="/zt/runbook/index.aspx"><img width="300" height="300" border="0" alt="��������ȫ��" title="��������ȫ��" src="http://www.erun360.com/adm/ad300.jpg"></a>
                <a target="_blank" href="/blog/200014474.aspx"><img width="300" height="300" border="0" alt="2014��The North Face 100��������ԽҰ��ս��������ͽ�����" title="��������ȫ��" src="/Html/images/shoetnf.png"></a>
        </div>
    </div>

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
    gda = ['����','�ǳ���','��','�е�','��','�ǳ���']
jQuery(document).ready(function($) {
    var data =<%=Result%>
    if(data == ""){
        $(".findresult").append('<li>û���ҵ�ƥ���Ь��</li>');
    }
    $.each(data, function (i,item) {
        var shoeimg = data[i].cImage?data[i].cImage:'/Html/images/noshoe.png',
            shoermb = data[i].fPrice?'<em>�۸񣺣�'+data[i].fPrice+'</em>':'',
            cSum    = data[i].cSum?data[i].cSum:''
        $(".findresult").append('<li><a href="/shoe/'+data[i].id+'.aspx" target="_blank"><img src="'+shoeimg+'" alt="'+data[i].cName+'" /></a><div class="shoenr"><a href="/shoe/'+data[i].id+'.aspx" target="_blank">'+data[i].cName+'</a><p>'+cSum+'</p>'+shoermb+'</div></li>')
                               })
    setPage(document.getElementsByClassName("fshoepage")[0],Math.ceil(<%=RecordCount%>/20),<%=pageIndex%>);
var xbb = xba[GetQueryString("xb")],
    qjzhcb = GetQueryString("qjzhc")==0 ? '' : '��ǰ���ƻ���'+lhxa[GetQueryString("qjzhc")],
    zzsb   = GetQueryString("zzs")==0 ? '' : '����������'+GetQueryString("zzs"),
    mzb    = GetQueryString("mz")?'��������'+GetQueryString("mz"):'',
    lhxb = GetQueryString("lhx")==0 ? '' : '�������'+lhxa[GetQueryString("lhx")],
    qhgcb = GetQueryString("qhgc")==0 ? '' : '��ǰ�����'+qhgca[GetQueryString("qhgc")],
    xxb = GetQueryString("xx")==0 ? '' : '��Ь��'+xxa[GetQueryString("xx")],
    wdxb = GetQueryString("wdx")==0 ? '' : '���ȶ���'+wdxa[GetQueryString("wdx")],
    jgb = GetQueryString("jg")==0 ? '' : '���۸�'+jga[GetQueryString("jg")],
    zlb = GetQueryString("zl")==0 ? '' : '������'+zla[GetQueryString("zl")],
    zghcb = GetQueryString("zghc")==0 ? '' : '���������'+zghca[GetQueryString("zghc")],
    gdb = GetQueryString("gd")==0 ? '' : '���߶�'+gda[GetQueryString("gd")]
if(GetQueryString("xb")){
  $(".sfresult").html('������������ǻ��������Ҫ��:�Ա���'+xbb+zzsb+qjzhcb+mzb+lhxb+qhgcb+xxb+wdxb+jgb+zlb+gdb+zghcb+'��������������⣬�����<a href="/infocenter/ShoeFind.aspx">��������</a>��<a href="javascript:history.go(-1)">�����޸�</a>')
}else{
  $(".sfresult").html('û������Ҫ��,��<a href="/infocenter/ShoeFind.aspx">��������</a>')
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