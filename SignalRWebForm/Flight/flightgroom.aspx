<%@ Page Language="C#" AutoEventWireup="true" CodeFile="flightgroom.aspx.cs" Inherits="Flight_flightgroom" %>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>机票-益跑网个人中心</title>
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
        	<div class="flightibox">
        		<div class="flightit">机票查询</div>
        		<div class="cflightbox">
        			<div class="flitr">
        				<div class="flitrl">航程类型</div><label><input type="radio" name="fltype" value="1" checked>单程</label><!-- <label><input type="radio" name="fltype" value="2">往返</label> -->
        			</div>
        			<div class="flitr">
        				<div class="flitrl">出发城市</div><input type="text" id="arrcity">
        				<div class="huan"><img src="/Html/images/huan.png"></div>
        			</div>
        			<div class="flitr ">
        				<div class="flitrl">到达城市</div><input type="text" id="city2">
        			</div>
        			<div class="flitr">
        				<div class="flitrl">出发日期</div><input type="text" readonly id="datatime">
        			</div>
        			<div class="flitr flifan">
        				<div class="flitrl">返回日期</div><input type="text" readonly id="datatimef">
        			</div>
        			<a class="goflight" href="javascript:void(0)">查询</a>
        		</div>
        		           		<div id='suggest' class="ac_results"></div>
           		<div id='suggest2' class="ac_results"></div>
              <input type="hidden" name="flightfrome" id="flightfrome" value="" />
              <input type="hidden" name="flightend" id="flightend" value="" />
        	</div>
        	<div class="slist">
        		<h1>赛事推荐</h1>
        		<div class="slisttr slistth">
        			<div class="slisttrd">赛事名称</div><div class="slisttrd">比赛地点</div><div class="slisttrd">比赛日期</div>
        		</div>
                <asp:Literal ID="ltlhot" runat="server"></asp:Literal>
        	</div>
        	<div class="both"></div>

        </article> 
    </div>
<script type="text/javascript">

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
$(".huan").click(function(event) {
	var c1 = $("#arrcity").val(),
		c2 = $("#city2").val(),
		k1 = $("#flightfrome").val(),
		k2 = $("#flightend").val()
		$("#arrcity").val(c2)
		$("#city2").val(c1)
		$("#flightfrome").val(k2)
		$("#flightend").val(k1)
});
$('.goflight').click(function(event) {
	var begin = $("#flightfrome").val(),
	end = $("#flightend").val(),
	time = $("#datatime").val()
	window.location.href = "/Flight/Flight_Search.aspx?begin="+begin+"&end="+end+"&time="+time
});

 $("[name=fltype]").change(function(event) {
 	if ($(this).val() == 2) {
 		$(".flifan").show()
 	}else{
 		$(".flifan").hide()
 	}
 });
jQuery(document).ready(function($) {

    $("#datatime").val(todydata())

});
function eachcity(items){
for (var i = 0; i < citys.length; i++) {//国内城市匹配
    var reg = new RegExp('^' + items + '.*$', 'im');
    if (reg.test(citys[i][0]) || reg.test(citys[i][1]) || reg.test(citys[i][2]) || reg.test(citys[i][3])) {
      return citys[i][1]
    }
  }

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
$('#datatimef').datetimepicker({
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
  </script>
<ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>