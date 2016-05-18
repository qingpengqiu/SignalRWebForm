<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Rlist.aspx.cs" Inherits="infocenter_Rlist" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right">
        <div class="equip">
            <span data-do="tour">团购记录</span>
            <span data-do="cash">兑换记录</span>
            <span data-do="flight">机票记录</span>
        </div>
        <div class="v3dh"></div>
	</div>    
</article>
<script type="text/javascript">
var loca = GetQueryString("tablep")
    if ((loca != 'tour') && (loca != 'cash') && (loca != 'flight') ) {
        loca = 'tour'
    };
 custom = function(){
    getdh(loca)
 }
function getdh(loca){
    $.AMUI.progress.start();
    $(".equip span[data-do="+loca+"]").addClass('equip-ous').siblings('span').removeClass('equip-ous')
    $.get('/action/ajaxrecord.ashx?op='+loca, function(data) {
        if(data.status == 0){
            $(".toast").html(data.msg).show().addClass('toast-error')
            errorboxhide()   
            setTimeout(function(){PopupShowdl();StatusCheck();},1000)
            return false
        }
        var dhlist = '',
            fkstatus = ['已过期','待付款','已付款'],
            dhstatus = ['已过期','未兑换','已兑换'],
            idname = ''
        switch(loca)
        {
        case 'tour':
            idname = 'v3tourbox'
            $(".v3dh").html('<div class="tuant">您有 <em>'+data.count+'</em> 笔订单，待付款 <i>'+data.num+'</i> 笔订单</div>')
            dhlist += '<div class="dhrow"><div class="dhcell">团购商品</div><div class="dhcell">数量</div><div class="dhcell">总价</div><div class="dhcell">兑换码</div><div class="dhcell">状态</div><div class="dhcell">操作</div></div>'
            $.each(data.list, function(index, val) {
                var gob = val.iState==2?'<a href="/GroupBuy/Group.aspx?id=' + val.idGood + '" target="_blank">查看</a>':'<a href="/GroupBuy/GetOrderInfo.aspx?idorder=' + val.idOrder + '" target="_blank">付款</a>'
                dhlist += '<div class="dhrow"><div class="dhcell"><img src="' + val.cImage + '">订单编号：' + val.idOrder + '<br>' + val.cGoodName + '</div><div class="dhcell">' + val.iBuyNum + '</div><div class="dhcell">' + val.iCost + '</div><div class="dhcell">' + val.code + '</div><div class="dhcell">' + fkstatus[val.iState] + '</div><div class="dhcell">'+gob+'</div></div>'
            });
          break;
        case 'cash':
            idname = 'v3cashbox'
            $(".v3dh").html('<div class="tuant">您已兑换 <em>'+data.count+'</em> 件物品，待付款 <i>'+data.num+'</i> 笔订单</div>')
            dhlist += '<div class="dhrow"><div class="dhcell">兑换商品</div><div class="dhcell">总价</div><div class="dhcell">兑换码</div><div class="dhcell">状态</div><div class="dhcell">操作</div></div>'
            $.each(data.list, function(index, val) {
                var mn = val.iCost?val.iCost+'元+':''
                var gob = val.iState==2?'<a href="/infocenter/Integral.aspx?uId=' + val.idUser + '" target="_blank">查看</a>':'<a href="/GroupBuy/IOrder.aspx?idorder=' + val.idOrder + '" target="_blank">付款</a>'
                dhlist += '<div class="dhrow"><div class="dhcell"><img src="'+val.cImage+'">订单编号：'+val.idOrder+'<br>'+val.cGoodName+'</div><div class="dhcell">'+mn+val.cScore+'积分</div><div class="dhcell">'+val.code+'<br>'+val.codeState+'</div><div class="dhcell">'+dhstatus[val.iState]+'</div><div class="dhcell">'+gob+'</div></div>'
            });
          break;
        case 'flight':
            idname = 'v3flightbox'
            $(".v3dh").html('<div class="tuant">您有 <em>'+data.count+'</em> 笔订单，待付款 <i>'+data.num+'</i> 笔订单</div>')
            dhlist += '<div class="dhrow"><div class="dhcell">名称</div><div class="dhcell">时间</div><div class="dhcell">总价</div><div class="dhcell">状态</div><div class="dhcell">下单时间</div><div class="dhcell">操作</div></div>'
            $.each(data.list, function(index, val) {
                var gob = val.iState==2?'<a href="/GroupBuy/Group.aspx?uId=' + val.id + '" target="_blank">查看</a>':'<a href="/Flight/flightpay.aspx?id=' + val.id + '&order='+val.cOrder_no+'" target="_blank">付款</a>'
                dhlist += '<div class="dhrow"><div class="dhcell">订单编号：'+val.cOrder_no+'<br>'+val.cItemName+'</div><div class="dhcell">'+val.FlightDate+'</div><div class="dhcell">'+val.iCost+'</div><div class="dhcell">'+fkstatus[val.iStatus]+'</div><div class="dhcell">'+val.dConfirmTime+'</div><div class="dhcell">'+gob+'</div></div>'
            });
          break;
        }
        $(".v3dh").append('<div class="dhlistbox '+idname+'">'+dhlist+'</div>')
        $.AMUI.progress.done();
    }); 
}
    jQuery(document).ready(function ($) {
        $.get('/action/AjaxUser.ashx?op=getuser', function(data) {
            if (data.msg != $.AMUI.store.get('leftuserinfo').id) {
                $(".toast").html('没有权限').show().addClass('toast-error')
                errorboxhide()
                setTimeout(function(){history.go(-1)},2000)
                return false
            }
        });
        getdh(loca)
    });
    // 信息切换
    $(".equip span").click(function () {
        loca = $(this).data('do')
        getdh(loca)
        $(".equip span[data-do="+loca+"]").addClass('equip-ous').siblings('span').removeClass('equip-ous')
    })
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />