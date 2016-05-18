<%@ Page Language="C#" AutoEventWireup="true" CodeFile="hotelinfo.aspx.cs" Inherits="Competetion_hotelinfo" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>
    <script type="text/javascript" src="/Html/js/My97DatePicker/WdatePicker.js"></script>

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
                    <asp:Literal ID="ltlhotel" runat="server"></asp:Literal>
                    <div class="equipinfo hotelinfo">
                    	<div class="hotels clearfix">
	                    	<div class="hotelthumbbox">
                                <asp:Literal ID="ltltu" runat="server"></asp:Literal>
	                    	</div>
                             <asp:Literal ID="ltlitem" runat="server"></asp:Literal>
	                    	<div class="hotelxx">
	                    	</div>
                    	</div>
                         <asp:Literal ID="ltlzz" runat="server"></asp:Literal>
                        <asp:Literal ID="ltljs" runat="server"></asp:Literal>
                        <asp:Literal ID="ltlss" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>
        </div>
    </div>
<div id="dpbg"></div>
<div class="dpbox  hotelpbox" id="dpbox">
    <div class="dptitle">酒店预订 <i></i></div>
    <div class="equinbox am-form hoteltbox">
        <form id="hoteltbox">
        <input type="hidden" name="op" id="op" value="tjHotel">
        <input type="hidden" name="sid" id="sid" value="<%=sid%>">
        <input type="hidden" name="hid" id="hid" value="<%=id%>">
        <label class="hoteltype"></label><input type="hidden" name="fid" id="fid" value="">
        <label class="hotelprice"></label>
        <label><em>房间数量：</em><input type="number" name="num" class="fen" value="1" min="1" max="6"> 间 ( 每ID限购<i class="xg"></i>间 )</label>
        <label class="jfbox"><em>积分抵扣：</em><input id="jf" type="checkbox" name="jf"/><i class="jftip"></i></label>
        <hr>
        <div class="hotelpop">
        选择常用客人或填写住客姓名： <br>
            <asp:Literal ID="ltlInfo" runat="server"></asp:Literal>
        <div class="hotelpopinfo">
            <div class="hotelpoptr">
                <input type="text" placeholder="姓" name="fname0"><input type="text" placeholder="名" name="lname0"><input type="text" placeholder="身份证" name="idcard0"><input type="hidden" name="id0" value="0">
            </div>
        </div>
        住客信息必须填写。所填姓名需与入住时所持证件一致。
        </div>
        <hr>
        联系信息
         <asp:Literal ID="ltlLink" runat="server"></asp:Literal>
         <label><em>备注：</em><textarea name="beizhu" id="beizhu"></textarea></label> 
        <div class="equibuttom">确认定单</div>
        </form>
    </div>
</div>
<script type="text/javascript">
var idUser = <%=idUser%>,
    array =[]
$(".hotels input").change(function(event) {
    $(".hotels i").html('&yen;'+$(this).data('price'))
    $(".hotels b").html('&yen;'+$(this).data('sprice'))

});
$(".buyhotel").click(function(event) {
    if (idUser == 0) {
        PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();
        return false
    };    
    if ($('input[name="hotel"]:checked').val()) {
       
     } else {
        $(".toast").html('请选择房型').show().addClass('toast-error')
        errorboxhide()
        return false
     }
 
    dpb()
    var input = $('.hotels input:checked')
    $("#fid").val(input.val())
    $(".hoteltype").html('<em>房型：</em>'+input.data('name'))
    $(".hotelprice").html('<em>房费：</em>&yen;<i>'+input.data('price')+'</i>')
    $(".fen").attr('max', input.data('max'));
    if (input.data('jf') == 0) {
        $(".jfbox").hide()
    }else{
        $(".jftip").html()
    }
    $(".xg").html(input.data('max'))

});
$(".fen").keyup(function(event) {
    this.value=this.value.replace(/\D/g,'') 
}).change(function(event) {
    var val = $(this).val()-0,
        max = $(this).attr('max')-0
    if (val > max) {
        $(".fen").val(max)
    }
    addzhuke($(this).val(),array)
});
$(".hotelpop input").change(function(event) {
    array = []
    var input = $(this),
        cnum = $(".hotelpop input:checked").length
        if (cnum > $(".fen").val()) {
            $(".toast").html('登记住客数量不能多于房间数量').show().addClass('toast-error')
            errorboxhide()
            input.removeAttr('checked');
        };
        $(".hotelpop input:checked").each(function(index, el) {
            var arry = {"fname":$(this).data('fristname'),"lname":$(this).data('lastname'),"idcard":$(this).data('idcard'),"id":$(this).data('id')}
            array.push(arry)
        });
        addzhuke($(".fen").val(),array)
});
function addzhuke(o,array){
    var t = ''
    for (var i = 0; i < o; i++) {
        if(array[i] != undefined ){
            t+=('<div class="hotelpoptr"><input type="text" placeholder="姓" name="fname'+i+'" value="'+array[i].fname+'"><input type="text" placeholder="名" name="lname'+i+'" value="'+array[i].lname+'"><input type="text" placeholder="证件号码" name="idcard'+i+'" value="'+array[i].idcard+'"><input type="hidden" name="id'+i+'" value="'+array[i].id+'"></div>')
            }else{
                t+=('<div class="hotelpoptr"><input type="text" placeholder="姓" name="fname'+i+'" value=""><input type="text" placeholder="名" name="lname'+i+'" value=""><input type="text" placeholder="证件号码" name="idcard'+i+'" value=""><input type="hidden" name="id'+i+'" value="0"></div>')
            }
    };
    $(".hotelpopinfo").html(t)
}
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
$(".hotelthumbsmall img").click(function(event) {
    var img = $(this).attr('src');
    $(this).addClass('this').siblings().removeClass('this')
    $(".hotelthumbbig").attr('src', img);
});
$(".equibuttom").click(function(event) {
    var go = 0
    $(".hoteltbox input").each(function(index, el) {
        if (!$(this).val()) {
            $(this).focus();
            $(".toast").html('酒店预订全部必填').show().addClass('toast-error')
            errorboxhide()
            go = 1
        };
    });
    if (go == 0) {
        console.log()
$.ajax({
    type: "POST",
    dataType: "json",
    url:'/action/EventService.ashx',
    data:$("#hoteltbox").serialize(),
    success: function(msg){
        if (msg.status == "-1") {
            PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
            return false
        } else if (msg.status == "0") {
            $(".toast").html(msg.msg).show().addClass('toast-error')
            errorboxhide()
        }
        else if (msg.status == "1") {
            $(".toast").html(msg.msg).show().addClass('toast-success')
            geticart()
            errorboxhide()
            dpc()
        }
    }
});
    };
});
</script>
<ERUN360:ICart runat="server" ID="ICart" />
<ERUN360:footerv3 runat="server" ID="footerv3" />