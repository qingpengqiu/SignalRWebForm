<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ticket.aspx.cs" Inherits="Competetion_ticket" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>  
<script type="text/javascript" src="/Html/js/aircity.js"></script>
<script type="text/javascript" src="/Html/js/j.dimensions.js"></script>
<script type="text/javascript" src="/Html/js/j.suggest.js"></script>
<div class="banner">
    <div class="mine">
        <h1><%=title %></h1>
        <asp:Literal ID="ltlbanner" runat="server"></asp:Literal>
    </div>
</div>
<div class="tbody">
    <div class="mine">
        <ERUN360:bmnav runat="server" ID="bmnav" />
        <div class="tbodyBox">
            <div class="event this clearfix">
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
    				<div class="flitrl">出发日期</div><input type="text" readonly id="datatime" data-am-datepicker readonly>
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

            </div>
        </div>
    </div>
</div>
    <script type="text/javascript">

        $(function () {
            $("#arrcity").suggest(citys, {
                hot_list: commoncitys,
                dataContainer: '#flightfrome',
                onSelect: function () {
                    $("#city2").click();
                },
                attachObject: '#suggest'
            });
            $("#city2").suggest(citys, {
                hot_list: commoncitys,
                dataContainer: '#flightend',
                onSelect: function () {
                    $("#datatime").focus();
                },
                attachObject: "#suggest2"
            });
        });
        $(".huan").click(function (event) {
            var c1 = $("#arrcity").val(),
                c2 = $("#city2").val(),
                k1 = $("#flightfrome").val(),
                k2 = $("#flightend").val()
            $("#arrcity").val(c2)
            $("#city2").val(c1)
            $("#flightfrome").val(k2)
            $("#flightend").val(k1)
        });
        $('.goflight').click(function (event) {
            var begin = $("#flightfrome").val(),
            end = $("#flightend").val(),
            time = $("#datatime").val()
            window.location.href = "/Flight/Flight_Search.aspx?begin=" + begin + "&end=" + end + "&time=" + time
        });

        $("[name=fltype]").change(function (event) {
            if ($(this).val() == 2) {
                $(".flifan").show()
            } else {
                $(".flifan").hide()
            }
        });
        jQuery(document).ready(function ($) {

            $("#datatime").val(todydata())

        });
        function eachcity(items) {
            for (var i = 0; i < citys.length; i++) {//国内城市匹配
                var reg = new RegExp('^' + items + '.*$', 'im');
                if (reg.test(citys[i][0]) || reg.test(citys[i][1]) || reg.test(citys[i][2]) || reg.test(citys[i][3])) {
                    return citys[i][1]
                }
            }

        }
        function todydata() {
            var day = new Date()
            var Year = day.getFullYear();
            var Month = day.getMonth() + 1;
            var Day = day.getDate();
            return Year + '-' + Month + '-' + Day
        }
  </script>
<ERUN360:footerv3 runat="server" ID="footerv3" />