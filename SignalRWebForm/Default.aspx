<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Home_Default" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<div class="V3Banner">
    <div class="V3BannerBox">
        <ul>
            <asp:literal id="ltljdt" runat="server"></asp:literal>
        </ul>
    </div>
</div>
<div class="V3Center">
    <div class="V3Left">
        <div class="V3Hot">
            <div class="v3hotbox">
                <i>热门搜索</i><a href="/infocenter/Search.aspx?fname=title&word=%D0%C2%CA%D6">新手</a><a href="/infocenter/Search.aspx?fname=title&word=%BC%F5%B7%CA">减肥</a><a href="/infocenter/Search.aspx?fname=title&word=%C2%ED%C0%AD%CB%C9">马拉松</a>
            </div>
            <div class="serchbox">
                <input type="text" name="serchkey" id="serchkey" placeholder="人名、标题、关键字"><a class="hotserch">搜索</a>
                <div class="serchresult"></div>
            </div>
        </div>
        <!-- <div class="V3Train">
    			<i>训练计划</i><p><em>周一 . 5公里间歇跑</em>
				10min LL  |   10X400m 休息: 200m   |   10min LL    |   10min LL 完成训练</p><a class="V3TrainClose">完成训练</a>
				<div class="V3TrainAdd">
					<img src="/Html/images/train.jpg">
					<a class="V3TrainAddButtom">创建训练计划</a>
				</div>
    		</div> -->
        <div class="V3APPBox">
            <a href="/Competetion/SearchEvent.aspx">
                <img src="/Html/images/blank.gif" data-echo="/Html/images/v3marath.png">
                { 赛事报名 }
            </a>
            <a href="/Channels/Competetion/CompetitionCalendar.aspx">
                <img src="/Html/images/blank.gif" data-echo="/Html/images/v3rili.png">
                { 赛事日历 }
            </a>
            <a href="//shop.erun360.com/" target="_blank">
                <img src="/Html/images/blank.gif" data-echo="/Html/images/mall1.png">
                { 合作商城 }
            </a>
            <a href="/SmartChooseShoe/ShoeFind.aspx">
    				<img src="/Html/images/v3shoe.png">
    				{ 智能选鞋 }
    			</a>
            <a href="/channels/tools/PaceCalculator.aspx">
                <img src="/Html/images/blank.gif" data-echo="/Html/images/v3tool.png">
                { 益跑工具箱 }
            </a>
        </div>
        <div class="V3ConsultList">
            <asp:literal id="ltlBlog" runat="server"></asp:literal>
            <div class="newsmore" id="newsmore">更多文章</div>
        </div>
      <%--  <div class="V3HotUserList">
            <div class="V3HotUserLeft">
            </div>
            <div id="V3HotUserCenter">
                <asp:literal id="ltlUser" runat="server"></asp:literal>
            </div>
            <div class="V3HotUserRight">
            </div>
        </div>--%>
        <div class="V3Tools">
            <i><a href="/channels/tools/PaceCalculator.aspx">益跑工具</a></i>
            <img src="Html/images/sl3.jpg">
            <div class="toolsbox">
                <h4>配速计算器</h4>
                输入配速、时间、距离三项中的任意两项计算出第三项。 
                <br>
                距离：<input type="text" id="distance" name="distance" size="3">公里<br>
                时间：<input type="text" id="hours" name="hours" size="3">时<input type="text" id="minutes" name="minutes" size="3">分<input type="text" id="seconds" name="seconds" size="3">秒
                <br>
                配速：<input type="text" id="speed_minutes" name="speed_minutes" size="3">分<input type="text" id="speed_seconds" name="speed_seconds" size="3">秒/公里
                <br>
                <a class="toolsgo" href="javascript:void(0)" onclick="OK()">计算</a><a class="toolsre" href="javascript:void(0)" onclick="Clear()">重置</a><a id="calorie" class="toolerror"></a>
            </div>
        </div>
    </div>
    <div class="V3Righr">
        <%= addgg.ADList(30000,1,0) %>
        <asp:literal id="ltlTour" runat="server"></asp:literal>
        <%= addgg.ADList(30000,2,0) %>
        <%= addgg.ADList(30000,3,0) %>
        <%= addgg.ADList(30000,4,0) %>
        <%= addgg.ADList(30000,5,0) %>
        <%= addgg.ADList(30000,6,0) %>
        <%= addgg.ADList(30000,7,0) %>
    </div>
        <%= addgg.ADList(30000,8,0) %>
    <div class="hlink">
        <div class="hlinktitle">合作伙伴</div>
        <%= addgg.ADList(30000,9,0) %>
    </div>
</div>
<div class="navtipone">
    <div class="mine">
        <img src="/Html/images/tiphand.png" class="navtiphead">
        <div class="mh"></div>
        <div class="nav navrighrf"></div>
    </div>
    <div class="closexhbody">
        点击图标“<i></i>”展开全部导航
    </div>
</div>
<script type="text/javascript">
    var store = $.AMUI.store;
    if (!store.get('xhbody')) {
        var nav = $(".nav").html()
        $("body").addClass('xhbody')
        $(".navtipone").show().find('.nav').append(nav).find('.nava').eq(1).addClass('this');
    };
    $(".closexhbody,.navtipone .mh,.navtiphead").click(function (event) {
        $("body").removeClass('xhbody')
        $(".navtipone").hide()
        store.set('xhbody', '1')
    });
jQuery(document).ready(function($) {
    cachedom(1,'null','list')
});
$(window).scroll(function() {  
    if($(this).scrollTop() + $(window).height() + 100 >= $(document).height() && $(this).scrollTop() > 100) { 
        p++
        getmoreaction(p,GetQueryString('id'),'list')
    }
})

</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />
