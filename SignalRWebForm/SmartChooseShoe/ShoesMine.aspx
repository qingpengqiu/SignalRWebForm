<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoesMine.aspx.cs" Inherits="SmartChooseShoe_ShoesMine" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<link href="/Html/css/shoe.css" rel="stylesheet" type="text/css" />
<form id="form1"  action="/SmartChooseShoe/ShoeList.aspx?action=likemine" method="post">
<article>
	<div class="V3Left">
        <div class="listtitlel">
            <img src="/Images/classify/1009.jpg">
            <h3>
                同类搜索
            </h3>
        </div>
        <div class="shoelt">
            <a href="ShoeFind.aspx" >查找跑鞋</a><a href="ShoesMine.aspx" class="this">同类搜索</a><a href="ShoeCounselor.aspx">智能选鞋</a>
        </div>
        <div class="sftit">
            告诉我们你喜欢鞋子什么的，我们会发现其他相似的是。如果你要找的是鞋不在此列，请尝试使用鞋搜索。            
        </div>
		<div class="shoefind">

            <div class="table">
            <div class="tr">
                <div class="td"><label for="idgender_0">性别</label></div>
                <div class="td">
                    <label><input type="radio" name="gender" id="man" value="0" onchange="infochange()" checked="checked"/> 男 </label>
                    <label><input type="radio" name="gender" id="woman" value="1"  onchange="infochange()"/> 女 </label>
                </div>
            </div>
            <div class="tr">
                <div class="td"><label for="Manufacturer">制造商</label></div>
                <div class="td">
                    <select name="manufacturer" id="manufacturer" onchange="infochange()"></select>
                </div>
            </div>
            <div class="tr">
                <div class="td"><label for="ShoeType">鞋型</label></div>
                <div class="td">
                    <select id="model" name="model"></select>
                </div>
            </div>
            </div>
            <input type="hidden" name="p" value="1">
            <div class="findshoe" id="findshoe">开始查找</div>
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
<script type="text/javascript">
    $(function () {
        var postdata = { type: 'manufacturerinfo' }
        $.post("/SmartChooseShoe/getInfo.ashx", postdata, function (result) {
            $("#manufacturer").html(result);
        })
    })
    function infochange()
    {
        var gender = $("input[name=gender]").val();
        var manufacturer = $("#manufacturer").val();
        if (gender!="" && manufacturer!="") {
            $("#modeltr").show();
            var postdata = { gender: gender, manufacturer: manufacturer, type: 'modeinfo' }
            $.post("/SmartChooseShoe/getInfo.ashx", postdata, function (result) {
                $("#model").html(result);
            })
        }
    }
    $("#findshoe").click(function(event) {
        if ($("#model").val()) {
            location.href = '/SmartChooseShoe/ShoeList.aspx?action=likemine&'+$('#form1').serialize()
        }else{
            $(".toast").html('请选择一双样板鞋').show().addClass('toast-error')
            errorboxhide()
        }
    });
</script>
</form>
<ERUN360:footerv3 runat="server" ID="footerv3" />