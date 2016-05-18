<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Flight_Search.aspx.cs" Inherits="Flight_Flight_Search" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>��Ʊ-��������������</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../Html/bootstrap_v2/css/bootstrap-datetimepicker.min.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/user-more.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/flight.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/loaders.min.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/vendor.min.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="../Common/jCalendar.js"></script>
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../Html/js/modernizr.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="../Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="../Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Html/js/bootstrap-validation.min.js"></script>

    <script type="text/javascript" src="../Html/bootstrap_v2/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="../Html/bootstrap_v2/js/locales/bootstrap-datetimepicker.zh-CN.js"></script>

    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="../Common/jCity.js"></script>
    <script src="../Common/jCheck.js"></script>
    <script src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/aircity.js"></script>
		<script type="text/javascript" src="/Html/js/j.dimensions.js"></script>
		<script type="text/javascript" src="/Html/js/j.suggest.js"></script>
    <style>
        .main-left ul .user-dq {
            filter: alpha(Opacity=100);
            -moz-opacity: 1;
            opacity: 1;
        }
        .sbox .sboxtr .sboxth:last-child{width: 302px;}
        .loaders{box-sizing: border-box;display: flex;flex: 0 1 auto;flex-direction: column;flex-grow: 1;flex-shrink: 0;flex-basis: 25%;max-width: 25%;height: 200px;align-items: center;justify-content: center;margin: 0 auto;display: none}
        .ball-spin-fade-loader>div{background-color: #999}
        .pages span{margin-right: 6px;}
        .pages li{list-style-type: none;display: inline-block;}
    </style>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
</head>
<body>    
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="wrap">
        <article>
           <div class="flightserch">
           		<img src="/Html/images/flighticon.png" class="flightfly">��<input type="text" id="arrcity"><img src="/Html/images/flright.png" class="flightright">��<input type="text" id="city2">����<input type="text" readonly id="datatime"><a class="fsbuttom" href="javascript:void(0)">��ѯ</a>
           		<div id='suggest' class="ac_results"></div>
           		<div id='suggest2' class="ac_results"></div>
              <input type="hidden" name="flightfrome" id="flightfrome" value="" />
              <input type="hidden" name="flightend" id="flightend" value="" />
           </div>
           <div class="flightable">
           		<div class="flightr flighth">
           			<div class="flightd">������Ϣ</div>
           			<div class="flightd"><a href="javascript:void(0)" id="sj">��ʱ��</a></div>
           			<div class="flightd">�𽵻���</div>
                <div class="flightd">��λ</div>
           			<div class="flightd"><a  href="javascript:void(0)" id="jg">Ʊ��</a></div>
           			<div class="flightd"></div>
           		</div>
              <div class="flighterrot"></div>
              <div class="loaders">
                <div class="loader-inner ball-spin-fade-loader"><div></div><div></div><div></div><div></div><div></div><div></div><div></div><div></div></div>
              </div>
              <div class="flightbox"></div>
              <div id="pager" class="pages"></div>
           </div>	
        </article> 
    </div>
<div id="dpbg"></div>
<div class="dpbox" id="dpbox">
  <form id="fromuser">
  <input name="oldid" id="oldid" type="hidden" value="0">
  <input name="op" id="op" type="hidden" value="order">
  <input name="Sid" id="Sid" type="hidden">
  <input name="ItemId" id="ItemId" type="hidden">
  <div class="dptitle">��ƱԤ�� <i></i></div>
  <div class="contact dashed linkp">
    <div class="contl">
      <label><i>���ó˻��ˣ�</i></label>
    </div>
    <div class="contr Contact">
        <asp:Literal ID="ltlInfo" runat="server"></asp:Literal><i class="perrotbox"></i>
    </div>
    <div class="both"></div>
  </div>
  <div class="contact addbox">
    <div class="contl linkshow">
      <a href="javascript:void(0)" class="addpeople">+ ��ӳ˿�</a>
      <label><i>��ϵ��Ϣ&nbsp;&nbsp;&nbsp;</i></label>
    </div>
    <div class="contr">
      <i class="perrotbox"></i>
    </div>
    <div class="both"></div>
  </div>
  <div class="contact putbox">
    <div class="contl">
      <label>������</label>
    </div>
    <div class="contr">
        <asp:Literal ID="ltlcontactName" runat="server"></asp:Literal>
    </div>
    <div class="both"></div>
  </div>
  <div class="contact putbox">
    <div class="contl">
      <label>�ֻ����룺</label>
    </div>
    <div class="contr">
        <asp:Literal ID="ltlcontactTel" runat="server"></asp:Literal>
    </div>
    <div class="both"></div>
  </div>
  <div class="contact putbox">
    <div class="contl">
      <label>Email��</label>
    </div>
    <div class="contr">
        <asp:Literal ID="ltlemail" runat="server"></asp:Literal>
    </div>
    <div class="both"></div>
  </div>
  <div class="contact putbox">
    <div class="contl">
      <label>��ϵ��ַ��</label>
    </div>
    <div class="contr">
        <asp:Literal ID="ltlcontactAdd" runat="server"></asp:Literal>
    </div>
    <div class="both"></div>
  </div>
  <div class="contact putbox">
    <div class="contl">
      <label>��ע��</label>
    </div>
    <div class="contr">
      <textarea name="remark" class="remark"></textarea>
    </div>
    <div class="both"></div>
  </div>
  <div class="contact putbox linke">
      <div class="contl">&nbsp;</div>    
      <div class="contr"><label><input type="checkbox" name="trip" class="trip">����г̵�������,������2Ԫ��</label>    </div>    
      <div class="both"></div>  
  </div>
  <div class="contact putbox linke">
      <div class="contl">&nbsp;</div>    
      <div class="contr"><label><input type="checkbox" name="iScore" class="iScore">����<%=iScore%>����,��ʹ��500���� �ֿ�5Ԫ</label>    </div>
      <div class="both"></div>  
  </div>
  <div class="postfli">ȷ�϶���<div class="dderrorbox"></div></div>
  </form>
</div>
<div class="dpbox" id="qrdd"style="min-height: 200px;">
  <div class="dptitle">������ʾ </div>
  <div class="qrnr" style="  padding-top:50px;;text-align: center;">
    ��ȷ�����ύ����Ϣ�Ƿ�׼ȷ��һ��ȷ�Ͻ��޷��޸� ;��۸�仯�ܿ죬��ȷ�Ϻ���20�����ڸ��лл��
  </div>
  <div class="returnbox">
        <a class="jiancha" href="javascript:void(0)">���һ��</a>
        <a class="ddqrok" href="javascript:void(0)">ȷ��</a>
    </div>  
</div>
<div id="qrbox" class="dpbox" >
  <div class="dptitle">����ȷ�� <i></i></div>
  <div class="qrnr">
    <div class="hbbox">
      <div class="fddt"></div>
      <div class="fdxl"></div>
    </div>
    <div class="hbbox">
      <div class="hbtitle">�˿���Ϣ</div>
      <div class="ckinfo"></div>
    </div>
    <div class="hbbox">
      <div class="hbtitle">������Ϣ</div>
        <div class="bxinfo"></div>
    </div>
    <div class="hbbox xcdbox">
      <div class="hbtitle">��ϵ����Ϣ</div>
      <div class="xcdinfo"></div>
    </div>
    <div class="hbbox hbboxl">
      <div class="hbtitle">���˼۸�</div>
        <div class="jginfo"></div>
          �ܽ�&yen;<i class="zin"></i>
    </div>
    <div class="returnbox">
        <!-- <a class="returnxg" href="javascript:void(0)">�޸Ķ���</a> -->
        <a class="returnfk" href="javascript:void(0)">���ϸ���</a>
    </div>
  </div> 
</div>
<div class="tcloding">
  <div class="loader"><div class="loader-inner ball-rotate"><div></div></div></div>
</div>
<script type="text/javascript">
var destiny = window.location.href
    destinyyuan = location.protocol+'//'+location.hostname+':'+location.port+location.pathname,
    Flight = '',
    pagenum = '',
    p='',
    zp = 1,
    yp = '',
    login = '',
    oldid = '',
    reinfo = '0'
    ck = 0,
    iiScore = <%=iScore%>
if(iiScore< 500){
  $(".iScore").attr('disabled', 'true');
}
$(".jiancha").click(function(event) {
    $(".dpbox").hide()
    $("#dpbox").show()
});
$(".ddqrok").click(function(event) {
  $(".dpbox").hide()
  $("#dpbox").show()
  $('body,html').animate({scrollTop:0},1000);
  $(".tcloding").show()
  $.ajax({
    url: '/action/Flight.ashx',
    type: 'get',
    dataType: 'json',
    data: encodeURI($("#fromuser").serialize()),
    success:function(sdata){
    $(".tcloding").hide()
      if (sdata.status!=0) {
        alert(sdata.msg)
        return false
      };
// ����ȷ��
  var tflight = ''
      ckinfo = '',
      catdtypearr = {
    IN:'���֤',
    PP:'����',
    GA:'�۰�ͨ��֤',
    TW:'̨��ͨ��֤',
    TB:'̨��֤',
    HX:'����֤',
    HY:'���ʺ�Ա֤'
},
    bxlist = ''
  $.each(Flight,function(index, el) {
    if (el.Id == sdata.ItemId) {
      tflight = el
    };
  });
  $("#fromuser").find('.newpass').each(function(index, el) {
    var name = $(this).find('.firstname').val()+$(this).find('.lastname').val(),
        catdtype = $(this).find('.catdtype').val(),
        cardnum = $(this).find('.cardnum').val(),
        iph = $(this).find('.iph').val()
    ckinfo+='<i>������'+name+'</i><em>'+catdtypearr[catdtype]+'��'+cardnum+'</em>�ֻ��ţ�'+iph+'<br>'
    if ($(this).find('.bx').is(":checked")) {
      bxlist+=name+'&nbsp;&nbsp;'
    };
  });
  $("#dpbox").hide();
  $("#qrbox").show();
  $(".fddt").html('<i>'+$("#datatime").val()+'</i>'+$("#arrcity").val()+' �� '+$("#city2").val())
  $(".fdxl").html('<i>'+tflight.Airline_Name+'</i><em>'+tflight.from_Time+'</em>'+tflight.from_Airport+'<br><i>'+tflight.AircraftType+'</i><em>'+tflight.to_Time+'</em>'+tflight.to_Airport+'<img src="/Html/images/small/'+tflight.Airline_No+'.gif">')
  $(".ckinfo").html(ckinfo)
  $(".bxinfo").html('�����ˣ�'+bxlist)
  $(".xcdinfo").html('������'+$(".contactName").val()+'&nbsp;&nbsp;�ֻ����룺'+$(".contactTel").val()+'&nbsp;&nbsp;��ϵ��ַ��'+$(".contactAdd").val()+'&nbsp;&nbsp;��ע��'+$(".remark").val())
  if ($(".trip").is(":checked")) 
  {
    $(".xcdbox").show()
  }else{
    $(".xcdbox").hide()
  }
  $(".jginfo").html('��Ʊ�ۣ�&yen;'+sdata.Price+'&nbsp;&nbsp;����/ȼ�ͣ�&yen;'+sdata.AirportConstruction_FuelTax+'&nbsp;&nbsp;���գ�&yen;'+sdata.bx+'&nbsp;&nbsp;'+sdata.iScore+'&nbsp;&nbsp;'+sdata.kdf)
  $(".zin").html(sdata.TotalPrice)
  $(".returnfk").attr('href', '/Flight/flightpay.aspx?id='+sdata.ID+'&order='+sdata.orderid+'&wap=0');
  oldid = sdata.ID
// ����ȷ��
    }
  })
});
$(".postfli").click(function(event) {
  var go = 0;
  if (ck == 0) {
    $(".dderrorbox").html('����������һλ�˿�')
    return false
  }else{
    $(".dderrorbox").html('')
  }

  $("#fromuser").find('input').each(function(index, el) {
    if (!$(this).val()) {
      go = 1
      $(this).addClass('errorinput').attr('placeholder', '����Ϊ��').focus()
      $(".dderrorbox").html('��������д����')
      return false
    }else{
      $(this).removeClass('errorinput').attr('placeholder', '');
    }
    if ($(this).attr('class') == 'birth iph' || $(this).attr('class') == 'contactTel') {
      if (!/^1\d{10}$/.test($(this).val())) {
        go = 1
        $(this).addClass('errorinput').focus()
        $(".dderrorbox").html('�ֻ��Ų���ȷ')
        return false
      };
    };
    if ($(this).attr('class') == 'email') {
      if (!/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/.test($(this).val())) {
        go = 1
        $(this).addClass('errorinput').focus()
        $(".dderrorbox").html('Email����ȷ')
        return false
      };
    };
  });
  if (go == 1) {
    return false
  };
  $(".dderrorbox").html('')
  
  if (reinfo>2) {
      alert('���ֻ���޸����ζ�����������ˢ��ҳ�����¶�Ʊ')
      return false
  };
  $('body,html').animate({scrollTop:0},1000);
  $(".dpbox").hide()
  $("#qrdd").show()

});
$(".returnxg").click(function(event) {
  reinfo++
  $("#oldid").val(oldid)
  $("#dpbox").show();
  $("#qrbox").hide();
});
$(function() {
  $("#arrcity").suggest(citys, {
    hot_list: commoncitys,
    dataContainer: '#flightfrome',
    onSelect: function() {
      $("#city2").click();
    },
    attachObject: '#suggest'
  });
  $("#city2").suggest(citys, {
    hot_list: commoncitys,
    dataContainer: '#flightend',
    onSelect: function() {
      $("#datatime").focus();
    },
    attachObject: "#suggest2"
  });
});

$(".addpeople").click(function(event) {
  gpcheck()
});
function gpcheck(zpc,fn,ln,it,id,ip){
  ck = 1
  var mp = yp>5?4:yp;
  if (zp<5&&zp<=yp) {
    passinfo(zp,fn,ln,it,id,ip)
    zp++
  }else{
    $('.perrotbox').html('��๺��'+mp+'��Ʊ')
  }
}
function passinfo(i,fn,ln,it,id,ip){
  var fn = fn||'',
      ln = ln||'',
      it = it||'IN',
      id = id||'',
      ip = ip||'',
      ins = it=='IN'?'selected="selected"':'',
      PP = it=='PP'?'selected="selected"':'',
      GA = it=='GA'?'selected="selected"':'',
      TW = it=='TW'?'selected="selected"':'',
      TB = it=='TB'?'selected="selected"':'',
      HX = it=='HX'?'selected="selected"':'',
      HY = it=='HY'?'selected="selected"':'',
      delid = id?id:new Date().valueOf()
      selectcode = '<option value="IN" '+ ins +'>���֤</option>\
        <option value="PP" '+ PP +'>����</option>\
        <option value="GA" '+ GA +'>�۰�ͨ��֤</option>\
        <option value="TW" '+ TW +'>̨��ͨ��֤</option>\
        <option value="TB" '+ TB +'>̨��֤</option>\
        <option value="HX" '+ HX +'>����֤</option>\
        <option value="HY" '+ HY +'>���ʺ�Ա֤</option>'
      var demo = '<div class="newpass cont'+delid+'">\
  <div class="contact delbox ">\
    <div class="contl">\
      <label><i class="cknum">��'+i+'λ�˿�&nbsp;&nbsp;&nbsp;</i></label>\
    </div>\
    <div class="contr">\
      <label><a class="delpass" data-delid="'+delid+'">ɾ��</a></label>\
    </div>\
    <div class="both"></div>\
  </div>\
  <div class="contact putbox cnname">\
    <div class="contl">\
      <label>�˻��ˣ�</label>\
    </div>\
    <div class="contr">\
      <input type="text" class="firstname" name="firstname'+i+'" value="'+fn+'" placeholder="��"><input type="text" class="lastname" name="lastname'+i+'" value="'+ln+'" placeholder="��">\
    </div>\
    <div class="both"></div>\
  </div>\
  <div class="contact putbox">\
    <div class="contl">\
      <label>֤�����ͣ�</label>\
    </div>\
    <div class="contr">\
      <select class="catdtype" name="catdtype'+i+'" value="'+it+'">'+selectcode+'</select>\
      <input type="text" class="cardnum" name="cardnum'+i+'" value="'+id+'">\
    </div>\
    <div class="both"></div>\
  </div>\
  <div class="contact putbox">\
    <div class="contl">\
      <label>�ֻ��ţ�</label>\
    </div>\
    <div class="contr">\
      <input type="text" class="birth iph" name="iph'+i+'" value="'+ip+'">\
    </div>\
    <div class="both"></div>\
  </div>\
  <div class="contact putbox linke">\
    <div class="contl">\
      <label>���գ�</label>\
    </div>\
    <div class="contr">\
      <label><input type="checkbox" class="bx" name="bx'+i+'" checked>����������</label>\
    </div>\
    <div class="both"></div>\
  </div>\
  <div class="contact dashed flitb"></div>\
</div>'
$(".addbox").before(demo)
}

jQuery(document).ready(function($) {
var begin = GetQueryString('begin')||'',
    end = GetQueryString('end')||'',
    time = GetQueryString('time')||'',
    order = GetQueryString('order')||'',
    p = GetQueryString('p')||''
    $("#datatime").val(todydata())
    if (begin) {
      $("#arrcity").val(eachcity(begin))
      $("#flightfrome").val(begin)
      serchflight(begin,end,time,order)
    };
    if (end) {
      $("#city2").val(eachcity(end))
      $("#flightend").val(end)
    };
    if (begin) {
      $("#datatime").val(time)
    };
});
function eachcity(items){
for (var i = 0; i < citys.length; i++) {//���ڳ���ƥ��
    var reg = new RegExp('^' + items + '.*$', 'im');
    if (reg.test(citys[i][0]) || reg.test(citys[i][1]) || reg.test(citys[i][2]) || reg.test(citys[i][3])) {
      return citys[i][1]
    }
  }

}
$(".Contact input").change(function(event) {
  var fn = $(this).data('fristname'),
      ln = $(this).data('lastname'),
      it = $(this).data('idtype'),
      id = $(this).data('idno'),
      ip = $(this).data('phone')
  if ($(this).is(":checked")) {
    gpcheck(zp,fn,ln,it,id,ip)
    if (zp>4) {
      $(this).removeAttr('checked')
    };
    $(this).data('zpid', id)
  }else{
    removck($(this).data('zpid'))
  }
});
function removck(i){
  $(".perrotbox").html('')
  $("#dpbox").find('.cont'+i).remove()
  $('[data-idno="'+i+'"]').removeAttr('checked')
  zp--
  $("#dpbox").find('.cknum').each(function(index, el) {
    $(this).html('��'+(index+1)+'λ�˿�&nbsp;&nbsp;&nbsp;')
     
  });
  $("#dpbox").find('.firstname').each(function(index, el) {
    $(this).attr('name', 'firstname'+(index+1));
  });
  $("#dpbox").find('.lastname').each(function(index, el) {
    $(this).attr('name', 'lastname'+(index+1));
  });
  $("#dpbox").find('.catdtype').each(function(index, el) {
    $(this).attr('name', 'catdtype'+(index+1));
  });
  $("#dpbox").find('.cardnum').each(function(index, el) {
    $(this).attr('name', 'cardnum'+(index+1));
  });
  $("#dpbox").find('.iph').each(function(index, el) {
    $(this).attr('name', 'iph'+(index+1));
  });
  $("#dpbox").find('.bx').each(function(index, el) {
    $(this).attr('name', 'bx'+(index+1));
  });


}
$('#dpbox').on('click','.delpass', function(event) {
  removck($(this).data('delid'))
});
$(".fsbuttom").click(function(event) {
  reinfo = 0
      $(".pages").html('')
      begin = $("#flightfrome").val()
      end = $("#flightend").val()
      time = $("#datatime").val()
      order='sj'
      destiny = destinyyuan+'?begin='+begin+'&end='+end+'&time='+time+'&order'+order
      history.pushState(1, '', destiny)
      serchflight(begin,end,time,order)
      p=1
});
$("#sj").click(function(event) {
    reinfo = 0
    $(".pages").html('')
    begin = $("#flightfrome").val()
    end = $("#flightend").val()
    time = $("#datatime").val()
    order='sj'
    destiny = destinyyuan+'?begin='+begin+'&end='+end+'&time='+time+'&order='+order
    history.pushState(1, '', destiny)
    serchflight(begin,end,time,order)
    p=1
});
$("#jg").click(function(event) {
    reinfo = 0
    $(".pages").html('')
    begin = $("#flightfrome").val()
    end = $("#flightend").val()
    time = $("#datatime").val()
    order='jg'
    destiny = destinyyuan+'?begin='+begin+'&end='+end+'&time='+time+'&order='+order
    history.pushState(1, '', destiny)
    serchflight(begin,end,time,order)
    p=1
});
function GetQueryString(name) {
  var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
  var r = window.location.search.substr(1).match(reg);
  if (r != null) return unescape(r[2]); return null;
  }
function serchflight(begin,end,time,order){
  $(".flightbox").html('')
  $(".loaders").css('display', 'flex');
  $(".flighterrot").hide()
  $.ajax({
    url: '/action/Flight.ashx',
    type: 'get',
    dataType: 'json',
    data: {op: 'search',begin:begin,end:end,time:time,order:order},
    success:function(data){
      if (data.msg) {
        $(".flighterrot").html('��ֱ�ﺽ���ʱ�����������ѡ��').show()
        $(".loaders").hide()
        return false
      };
      Flight = data[0].items
      login = data[0].login
      $("#Sid").val(data[0].Sid)
      $(".loaders").hide()
      $(".flighterrot").hide()
      pagenum = Flight.length
      if (p>1) {
        pagelist(pagenum,'pages',p)
      }else{
        pagelist(pagenum,'pages',1)
      }
      eachflight(Flight,1)
    }
  })
}
function eachflight(Flight,page){
  var flighttext = '',
      starval = page*10-10,
      endval = page*10-1,
      AircraftType = '',
      to_Time = ''
  $.each(Flight, function(index, val) {
      if(index>=starval&&index<=endval){
        AircraftType = val.AircraftType
        to_Time = val.to_Time
        flighttext+='<div class="flightr"><div class="flightd"><img src="/Html/images/small/'+val.Airline_No+'.gif"><i>'+val.Airline_Name+'</i>'+AircraftType+'</div><div class="flightd"><em>'+val.from_Time+'</em>'+to_Time+'</div><div class="flightd"><em>'+val.from_Airport+'</em>'+val.to_Airport+'</div><div class="flightd">'+val.HippingSpace+'</div><div class="flightd"><div class="pj"><em>&yen;</em><i>'+val.Price+'</i>'+val.Discount/10+'��</div></div><div class="flightd"><a class="dpbuttom" href="javascript:void(0)" data-hbid='+val.Id+' data-yp="'+val.RemainingSeats+'">��Ʊ</a></div></div>'
      }
  });
  $(".flightbox").html(flighttext).find('.dpbuttom').click(function(event) {
    reinfo = 0
    if (login == 0 ) {
      PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();
      return false
    };
    yp = $(this).data('yp').substr(1,1)
    $("#ItemId").val($(this).data('hbid'))
    dpb()
  });
}
// $("#dpbg").click(function(event) {
//    dpc()
// });
function dpb(){
  $("#dpbg").show()
  $("#dpbox").show()
}
function dpc(){
  $("#dpbg").hide()
  $(".dpbox").hide()
}
$(".dptitle i").click(function(event) {
  dpc()
});
function pagelist(num,pageclass,pageindex){
    eachflight(Flight,pageindex)
    var pagedata = '',
        pagenum = Math.ceil(num/10),
        page = pageindex
    if (page == 1) {
        pagedata+='<li class="disabled" ><a href="javascript:void(0)">&lt;&lt;</a></li>'
    }else{
        pagedata+='<li data-page="up"><a href="javascript:void(0)">&lt;&lt;</a></li>'
    }
    if (page == 1) {
        pagedata+='<li class="disabled"><a href="javascript:void(0)">up</a></li>'
    }else{
        pagedata+='<li data-page="'+(page-1)+'"><a href="javascript:void(0)">up</a></li>'
    }
        pagedata+='<li><a href="javascript:void(0)">��ǰ��'+page+'ҳ,��'+pagenum+'ҳ</a></li>'
    if (page == pagenum ) {
        pagedata+='<li class="disabled"><a href="javascript:void(0)">down</a></li>'
    }else{
        pagedata+='<li data-page="'+(page+1)+'"><a href="javascript:void(0)">down</a></li>'
    }
    if (page == pagenum ) {
        pagedata+='<li class="disabled"><a href="javascript:void(0)">&gt;&gt;</a></li>'
    }else{
        pagedata+='<li data-page="down"><a href="javascript:void(0)">&gt;&gt;</a></li>'
    }
    $("."+pageclass).html(pagedata).find('li').click(function(event) {
        var gopage = $(this).data('page')
        if (gopage == 'up') {
            history.pushState(1, '', changeURLPar(destiny, 'p', 1))
            pagelist(num,pageclass,1)
        }else if(gopage == 'down'){
            history.pushState(1, '', changeURLPar(destiny, 'p', pagenum))
            pagelist(num,pageclass,pagenum)
        }else if(gopage){
            history.pushState(1, '', changeURLPar(destiny, 'p', gopage))
            pagelist(num,pageclass,gopage)
        }
    });
}
function changeURLPar(destiny, par, par_value){
    var pattern = par+'=([^&]*)';
    var replaceText = par+'='+par_value;
    if (destiny.match(pattern)){
        var tmp = '/\\'+par+'=[^&]*/';

        console.log(destiny + '  ' + eval(tmp) + '   '+ replaceText)

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
function todydata(){
  var day = new Date()
  var Year = day.getFullYear();
  var Month = day.getMonth()+1; 
  var Day = day.getDate();
  return Year+'-'+Month+'-'+Day
}

$('#datatime').datetimepicker({
  startDate: todydata(),
  format:'yyyy-mm-dd',
      language:  'zh-CN',
      weekStart: 1,
      todayBtn:  1,
  autoclose: 1,
  todayHighlight: 1,
  startView: 2,
  minView: 2,
  forceParse: 0
  });
$(".birth").datetimepicker({
  format:'yyyy-mm-dd',
      language:  'zh-CN',
      weekStart: 1,
      todayBtn:  1,
  autoclose: 1,
  todayHighlight: 1,
  startView: 2,
  minView: 2,
  forceParse: 0
});

  </script>
<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>