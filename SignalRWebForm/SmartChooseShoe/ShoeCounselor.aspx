<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoeCounselor.aspx.cs" Inherits="SmartChooseShoe_ShowCounselor" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
<link href="/Html/css/shoemedia.css" rel="stylesheet" type="text/css" />
<form id="form1" runat="server">
</form>
<article>
	<div class="V3Left">
        <div class="listtitlel">
            <img src="/Images/classify/1009.jpg">
            <h3>
                智能选鞋
            </h3>
        </div>
		<div class="shoelt">
			<a href="ShoeFind.aspx" >查找跑鞋</a><a href="ShoesMine.aspx">同类搜索</a><a href="ShoeCounselor.aspx" class="this">智能选鞋</a>
		</div>
        <div class="sftit">
            告诉我们你喜欢鞋子什么的，我们会发现其他相似的是。如果你要找的是鞋不在此列，请尝试使用鞋搜索。            
        </div>
		<div class="shoefind">
            <div class="table">
            <div class="tr">
                <div class="td">
                    <label for="idgender_0">性别</label>
                </div>
                <div class="td">
                    <label><input id="idgender_0" name="gender" value="0" checked="checked" type="radio">男</label>
                    <label><input id="idgender_1" name="gender" value="1" type="radio">女</label>
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label for="height">身高</label>
                </div>
                <div class="td">
                    <input type="text" id="height" name="height" class="shoeminput"><label for="height">厘米</label>
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label for="weight">体重</label>
                </div>
                <div class="td">
                    <input type="text" id="weight" name="weight" class="shoeminput"><label for="weight">公斤</label>
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label for="ShoeType">鞋型</label>
                </div>
                <div class="td">
                    <select name="ShoeType" id="ShoeType">
                    <option value="road">公路</option>
                    <option value="trail">越野</option>
                    </select>
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label for="RunLevel">跑步水平</label>
                </div>
                <div class="td">
                    <select name="RunLevel" id="RunLevel">
                    <option value="beginner">初级</option>
                    <option value="intermediate">中级</option>
                    <option value="advanced">高级</option>
                    </select>
                </div>
            </div>
            <div class="tr">
                <div class="td"><label for="WeekRunKM">周跑量</label></div>
                <div class="td">
                    <select name="WeekRunKM" id="WeekRunKM" >
                    <option value="1-8">1-8 km</option>
                    <option value="8-16">8-16 km</option>
                    <option value="16-32">16-32 km</option>
                    <option value="32-48">32-48 km</option>
                    <option value=">48">>48 km</option>
                    </select>
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label for="PaceMin">平均配速</label>
                </div>
                <div class="td">
                    <select name="PaceMin" id="PaceMin" class="shoeminput" >
                    </select>
                    <label for="PaceMin">分</label>
                    <select name="PaceSec" id="PaceSec" class="shoeminput" >
                    </select>
                    <label for="PaceSec">秒</label>
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label for="InjuredOneYear">近一年是否有受伤</label>
                </div>
                <div class="td">
                    <select name="InjuredOneYear" id="InjuredOneYear">
                    <option value="notatall">没有</option>
                    <option value="minor">轻伤</option>
                    <option value="major">重伤</option>
                    </select>
                </div>
            </div>
            <div class="tr zugong">
                <div class="td">
                    <label for="_flat">足弓高度</label>
                </div>
                <div class="td hasimg">
                    <label><img src="/Html/images/Arch1.png"/><input id="_flat" name="HighOfArch" value="flat" checked="checked" type="radio"> 低</label>
                    <label><img src="/Html/images/Arch2.png"/><input id="_medium" name="HighOfArch" value="medium" type="radio">中</label>
                    <label><img src="/Html/images/Arch3.png"/><input id="_high" name="HighOfArch" value="high" type="radio">高</label>
                    <label><img src="/Html/images/tou.png"><input id="HighOfArch_dontknow" name="HighOfArch" value="dontknow" type="radio">不清楚</label>
                </div>
            </div>
            <div class="tr nwf">
                <div class="td">
                    <label for="_underpronator">内外翻</label>
                </div>
                <div class="td hasimg">
                <label><img src="/Html/images/Double1.png" /><input id="_underpronator" name="motionmechanics" value="underpronator" checked="checked" type="radio">内翻 (左脚)<p>跑动中脚不向内卷动，后蹬离地时脚外侧发力（小脚趾）</p></label>
                <label><img src="/Html/images/Double2.png" /><input id="_normal" name="motionmechanics" value="normal" type="radio">正常 (左脚)<p>跑动中脚自然向前卷动，后蹬离地时前脚掌整体发力</p></label>
                <label><img src="/Html/images/Double3.png" /><input id="_overpronator" name="motionmechanics" value="overpronator" type="radio">外翻 (左脚)<p>跑动中脚向内卷动，后蹬离地时脚内侧发力（大脚趾）</p></label>
                <label><img src="/Html/images/tou.png"><input id="motionmechanics_dontknow" name="motionmechanics" value="dontknow" type="radio">不清楚</label>
                </div>
            </div>
            <div class="tr zhaodi">
                <div class="td">
                    <label for="_forefoot">着地位置</label>
                </div>
                <div class="td hasimg">
                    <label><img src="/Html/images/Feet1.png" /><input id="_forefoot" name="strikeground" value="forefoot" checked="checked" type="radio">前脚掌</label>
                    <label><img src="/Html/images/Feet2.png" /><input id="_midfoot" name="strikeground" value="midfoot" type="radio">全脚掌</label>
                    <label><img src="/Html/images/Feet3.png" /><input id="_heel" name="strikeground" value="heel" type="radio">脚跟</label>
                    <label><img src="/Html/images/Feet4.png" /><input id="_extremheel" name="strikeground" value="extremheel" type="radio">极端脚跟</label>
                </div>
            </div>
            </div>
            <div class="findshoe">开始查找</div>
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
var PaceMindemo = '',
    PaceSecdemo     = ''
for (var i = 0; i < 15; i++) {
    PaceMindemo+= '<option value="'+i+'">'+i+'</option>'
};
for (var i = 0; i < 61; i++) {
    PaceSecdemo+= '<option value="'+i+'">'+i+'</option>'
};
$("#PaceMin").html(PaceMindemo)
$("#PaceSec").html(PaceSecdemo)
    $(".findshoe").click(function (event) {
        var g = 0
        $(".shoefind input").each(function(index, el) {
            if (!$(this).val()) {
                $(this).focus()
                $(".toast").html('请填写完整后查找').show().addClass('toast-error')
                errorboxhide()
                g = 1
                return false
            };
        });
        var gender = $("input[name='gender']:checked").val(),
            tall = $("#height").val(),
            weight = $("#weight").val(),
            shoetype = $("#ShoeType").val(),
            runlevel = $("#RunLevel").val(),
            weekrunkm = $("#WeekRunKM").val(),
            pacemin = $("#PaceMin").val(),
            pacesec = $("#PaceSec").val(),
            injured = $("#InjuredOneYear").val(),
            highofarch = $("input[name='HighOfArch']:checked").val(),
            motionmechanics = $("input[name='motionmechanics']:checked").val(),
            strikeground = $("input[name='strikeground']:checked").val()
        if (g == 0) {
            location.href = "ShoeList.aspx?gender=" + gender + "&tall=" + tall + "&weight=" + weight + "&shoetype=" + shoetype + "&runlevel=" + runlevel + "&weekrunkm=" + weekrunkm + "&pacemin=" + pacemin + "&pacesec=" + pacesec + "&injured=" + injured + "&highofarch=" + highofarch + "&motionmechanics=" + motionmechanics + "&strikeground=" + strikeground + "&action=advisor"
        };
    });
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />