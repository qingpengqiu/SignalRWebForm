<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoeFind.aspx.cs" Inherits="infocenter_ShoeFind" %>
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
                查找跑鞋
            </h3>
        </div>
        <div class="shoelt">
            <a href="ShoeFind.aspx" class="this">查找跑鞋</a><a href="ShoesMine.aspx">同类搜索</a><a href="ShoeCounselor.aspx">智能选鞋</a>
        </div>
        <div class="sftit">
            请您根据实际情况填写：
        </div>
		<div class="shoefind pshoefind">
            <div class="table">
            <div class="tr">
                <div class="td">
                    <label for="idgender_0">性别</label>
                </div>
                <div class="td">
                    <label><input id="idgender_0" name="idgender" value="0" checked="checked" type="radio">男</label>
                    <label><input id="idgender_1" name="idgender" value="1" type="radio">女</label>
                </div>
                <div class="td">
                    <label for="HeelCushioning">前脚掌缓冲</label>
                </div>
                <div class="td">
                    <select name="HeelCushioning " id="HeelCushioning">
                    <option value="0">所有</option>
                    <option value="1">非常硬</option>
                    <option value="2">硬</option>
                    <option value="3">中等</option>
                    <option value="4">软</option>
                    <option value="5">非常软</option>
                    </select>
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label for="Manufacturer">制造商</label>
                </div>
                <div class="td">
                    <select name="Manufacturer" id="Manufacturer">
                        <option value="0">所有</option>
                        <option value="Adidas">Adidas</option>
                        <option value="Aetrex">Aetrex</option>
                        <option value="Altra">Altra</option>
                        <option value="Anatom">Anatom</option>
                        <option value="Asics">Asics</option>
                        <option value="Brooks">Brooks</option>
                        <option value="Columbia">Columbia</option>
                        <option value="Ecco">Ecco</option>
                        <option value="Etonic">Etonic</option>
                        <option value="Hoka One One">Hoka One One</option>
                        <option value="Icebug">Icebug</option>
                        <option value="Inov-8">Inov-8</option>
                        <option value="Kalenji">Kalenji</option>
                        <option value="Karhu">Karhu</option>
                        <option value="K-Swiss">K-Swiss</option>
                        <option value="La Sportiva">La Sportiva</option>
                        <option value="Merrell">Merrell</option>
                        <option value="Mizuno">Mizuno</option>
                        <option value="Montrail">Montrail</option>
                        <option value="New Balance">New Balance</option>
                        <option value="Newton">Newton</option>
                        <option value="Nike">Nike</option>
                        <option value="On">On</option>
                        <option value="Patagonia">Patagonia</option>
                        <option value="Pearl Izumi">Pearl Izumi</option>
                        <option value="Puma">Puma</option>
                        <option value="Reebok">Reebok</option>
                        <option value="Salomon">Salomon</option>
                        <option value="Saucony">Saucony</option>
                        <option value="Scarpa">Scarpa</option>
                        <option value="Scott">Scott</option>
                        <option value="Skechers">Skechers</option>
                        <option value="Skora">Skora</option>
                        <option value="Speedo">Speedo</option>
                        <option value="Spira">Spira</option>
                        <option value="Tecnica">Tecnica</option>
                        <option value="Terra Plana">Terra Plana</option>
                        <option value="Teva">Teva</option>
                        <option value="The North Face">The North Face</option>
                        <option value="Topo Athletic">Topo Athletic</option>
                        <option value="Treksta">Treksta</option>
                        <option value="Under Armour">Under Armour</option>
                        <option value="Vibram">Vibram</option>
                        <option value="Vivobarefoot">Vivobarefoot</option>
                        <option value="Zoot">Zoot</option>
                    </select>
                </div>
                <div class="td">
                    <label for="Flexibility">灵活性</label>
                </div>
                <div class="td">
                    <select name="Flexibility" id="Flexibility">
                        <option value="0">所有</option>
                        <option value="1">非常硬</option>
                        <option value="2">硬</option>
                        <option value="3">中度</option>
                        <option value="4">灵活</option>
                        <option value="5">非常灵活</option>
                    </select>
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label for="shoename">鞋的名字</label>
                </div>
                <div class="td">
                    <input type="text" id="shoename" name="shoename">
                </div>
                <div class="td">
                    <label for="HeelToe">前后跟差</label>
                </div>
                <div class="td">
                    <select name="HeelToe" id="HeelToe">
                        <option value="0">所有</option>
                        <option value="1">0mm</option>
                        <option value="2">1mm - 4mm</option>
                        <option value="3">5mm - 8mm</option>
                        <option value="4">9mm - 12mm</option>
                        <option value="5">13mm+</option>
                    </select>
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label for="ShoeType">鞋型</label>
                </div>
                <div class="td">
                    <select name="ShoeType" id="ShoeType">
                        <option value="0">所有</option>
                        <option value="1">公路</option>
                        <option value="2">越野</option>
                    </select>
                </div>
                <div class="td">
                    <label for="StabilityFeatures">稳定性</label>
                </div>
                <div class="td">
                    <select name="StabilityFeatures" id="StabilityFeatures">
                        <option value="0">所有</option>
                        <option value="1">非常低</option>
                        <option value="2">低</option>
                        <option value="3">中等</option>
                        <option value="4">高</option>
                        <option value="5">非常高</option>
                    </select>
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label for="Price">价格</label>
                </div>
                <div class="td">
                    <select name="Price" id="Price">
                        <option value="0">所有</option>
                        <option value="1">400以下</option>
                        <option value="2">400-600</option>
                        <option value="3">600-1000</option>
                        <option value="4">1000以上</option>
                    </select>
                </div>
                <div class="td">
                    <label for="Weight">重量</label>
                </div>
                <div class="td">
                    <select name="Weight" id="Weight">
                        <option value="0">所有</option>
                        <option value="1">非常轻</option>
                        <option value="2">轻</option>
                        <option value="3">中等</option>
                        <option value="4">重</option>
                        <option value="5">非常重</option>
                    </select>
                </div>
            </div>
            <div class="tr">
                <div class="td">
                    <label for="footCushioning">足跟缓冲</label>
                </div>
                <div class="td">
                    <select name="footCushioning" id="footCushioning">
                        <option value="0">所有</option>
                        <option value="1">非常硬</option>
                        <option value="2">硬</option>
                        <option value="3">中等</option>
                        <option value="4">软</option>
                        <option value="5">非常软</option>
                    </select>
                </div>
                <div class="td">
                    <label for="Profile">高度</label>
                </div>
                <div class="td">
                    <select name="Profile" id="Profile">
                        <option value="0">所有</option>
                        <option value="1">非常低</option>
                        <option value="2">低</option>
                        <option value="3">中等</option>
                        <option value="4">高</option>
                        <option value="5">非常高</option>
                    </select>
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
$(".findshoe").click(function(event) {
var xb = $("input[name='idgender']:checked").val(),
    qjzhc = $("#HeelCushioning").val(),
    zzs   = $("#Manufacturer").val(),
    lhx   = $("#Flexibility").val(),
    mz    = $("#shoename").val()?$("#shoename").val():"",
    qhgc  = $("#HeelToe").val(),
    xx    = $("#ShoeType").val(),
    wdx   = $("#StabilityFeatures").val(),
    jg    = $("#Price").val(),
    zl    = $("#Weight").val(),
    zghc  = $("#footCushioning").val(),
    gd    = $("#Profile").val()
location.href = "/SmartChooseShoe/ShoeList.aspx?action=search&xb=" + xb + "&qjzhc=" + qjzhc + "&zzs=" + zzs + "&lhx=" + lhx + "&mz=" + mz + "&qhgc=" + qhgc + "&xx=" + xx + "&wdx=" + wdx + "&jg=" + jg + "&zl=" + zl + "&zghc=" + zghc + "&gd=" + gd + "&m=Seach&p=1"
});
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />