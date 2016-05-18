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
                <i>��������</i><a href="/infocenter/Search.aspx?fname=title&word=%D0%C2%CA%D6">����</a><a href="/infocenter/Search.aspx?fname=title&word=%BC%F5%B7%CA">����</a><a href="/infocenter/Search.aspx?fname=title&word=%C2%ED%C0%AD%CB%C9">������</a>
            </div>
            <div class="serchbox">
                <input type="text" name="serchkey" id="serchkey" placeholder="���������⡢�ؼ���"><a class="hotserch">����</a>
                <div class="serchresult"></div>
            </div>
        </div>
        <!-- <div class="V3Train">
    			<i>ѵ���ƻ�</i><p><em>��һ . 5�����Ъ��</em>
				10min LL  |   10X400m ��Ϣ: 200m   |   10min LL    |   10min LL ���ѵ��</p><a class="V3TrainClose">���ѵ��</a>
				<div class="V3TrainAdd">
					<img src="/Html/images/train.jpg">
					<a class="V3TrainAddButtom">����ѵ���ƻ�</a>
				</div>
    		</div> -->
        <div class="V3APPBox">
            <a href="/Competetion/SearchEvent.aspx">
                <img src="/Html/images/blank.gif" data-echo="/Html/images/v3marath.png">
                { ���±��� }
            </a>
            <a href="/Channels/Competetion/CompetitionCalendar.aspx">
                <img src="/Html/images/blank.gif" data-echo="/Html/images/v3rili.png">
                { �������� }
            </a>
            <a href="//shop.erun360.com/" target="_blank">
                <img src="/Html/images/blank.gif" data-echo="/Html/images/mall1.png">
                { �����̳� }
            </a>
            <a href="/SmartChooseShoe/ShoeFind.aspx">
    				<img src="/Html/images/v3shoe.png">
    				{ ����ѡЬ }
    			</a>
            <a href="/channels/tools/PaceCalculator.aspx">
                <img src="/Html/images/blank.gif" data-echo="/Html/images/v3tool.png">
                { ���ܹ����� }
            </a>
        </div>
        <div class="V3ConsultList">
            <asp:literal id="ltlBlog" runat="server"></asp:literal>
            <div class="newsmore" id="newsmore">��������</div>
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
            <i><a href="/channels/tools/PaceCalculator.aspx">���ܹ���</a></i>
            <img src="Html/images/sl3.jpg">
            <div class="toolsbox">
                <h4>���ټ�����</h4>
                �������١�ʱ�䡢���������е������������������ 
                <br>
                ���룺<input type="text" id="distance" name="distance" size="3">����<br>
                ʱ�䣺<input type="text" id="hours" name="hours" size="3">ʱ<input type="text" id="minutes" name="minutes" size="3">��<input type="text" id="seconds" name="seconds" size="3">��
                <br>
                ���٣�<input type="text" id="speed_minutes" name="speed_minutes" size="3">��<input type="text" id="speed_seconds" name="speed_seconds" size="3">��/����
                <br>
                <a class="toolsgo" href="javascript:void(0)" onclick="OK()">����</a><a class="toolsre" href="javascript:void(0)" onclick="Clear()">����</a><a id="calorie" class="toolerror"></a>
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
        <div class="hlinktitle">�������</div>
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
        ���ͼ�ꡰ<i></i>��չ��ȫ������
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
