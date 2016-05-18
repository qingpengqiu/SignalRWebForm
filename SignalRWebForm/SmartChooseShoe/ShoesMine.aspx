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
                ͬ������
            </h3>
        </div>
        <div class="shoelt">
            <a href="ShoeFind.aspx" >������Ь</a><a href="ShoesMine.aspx" class="this">ͬ������</a><a href="ShoeCounselor.aspx">����ѡЬ</a>
        </div>
        <div class="sftit">
            ����������ϲ��Ь��ʲô�ģ����ǻᷢ���������Ƶ��ǡ������Ҫ�ҵ���Ь���ڴ��У��볢��ʹ��Ь������            
        </div>
		<div class="shoefind">

            <div class="table">
            <div class="tr">
                <div class="td"><label for="idgender_0">�Ա�</label></div>
                <div class="td">
                    <label><input type="radio" name="gender" id="man" value="0" onchange="infochange()" checked="checked"/> �� </label>
                    <label><input type="radio" name="gender" id="woman" value="1"  onchange="infochange()"/> Ů </label>
                </div>
            </div>
            <div class="tr">
                <div class="td"><label for="Manufacturer">������</label></div>
                <div class="td">
                    <select name="manufacturer" id="manufacturer" onchange="infochange()"></select>
                </div>
            </div>
            <div class="tr">
                <div class="td"><label for="ShoeType">Ь��</label></div>
                <div class="td">
                    <select id="model" name="model"></select>
                </div>
            </div>
            </div>
            <input type="hidden" name="p" value="1">
            <div class="findshoe" id="findshoe">��ʼ����</div>
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
            $(".toast").html('��ѡ��һ˫����Ь').show().addClass('toast-error')
            errorboxhide()
        }
    });
</script>
</form>
<ERUN360:footerv3 runat="server" ID="footerv3" />