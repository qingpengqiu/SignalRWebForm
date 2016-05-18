<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Rlist.aspx.cs" Inherits="infocenter_Rlist" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right">
        <div class="equip">
            <span data-do="tour">�Ź���¼</span>
            <span data-do="cash">�һ���¼</span>
            <span data-do="flight">��Ʊ��¼</span>
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
            fkstatus = ['�ѹ���','������','�Ѹ���'],
            dhstatus = ['�ѹ���','δ�һ�','�Ѷһ�'],
            idname = ''
        switch(loca)
        {
        case 'tour':
            idname = 'v3tourbox'
            $(".v3dh").html('<div class="tuant">���� <em>'+data.count+'</em> �ʶ����������� <i>'+data.num+'</i> �ʶ���</div>')
            dhlist += '<div class="dhrow"><div class="dhcell">�Ź���Ʒ</div><div class="dhcell">����</div><div class="dhcell">�ܼ�</div><div class="dhcell">�һ���</div><div class="dhcell">״̬</div><div class="dhcell">����</div></div>'
            $.each(data.list, function(index, val) {
                var gob = val.iState==2?'<a href="/GroupBuy/Group.aspx?id=' + val.idGood + '" target="_blank">�鿴</a>':'<a href="/GroupBuy/GetOrderInfo.aspx?idorder=' + val.idOrder + '" target="_blank">����</a>'
                dhlist += '<div class="dhrow"><div class="dhcell"><img src="' + val.cImage + '">������ţ�' + val.idOrder + '<br>' + val.cGoodName + '</div><div class="dhcell">' + val.iBuyNum + '</div><div class="dhcell">' + val.iCost + '</div><div class="dhcell">' + val.code + '</div><div class="dhcell">' + fkstatus[val.iState] + '</div><div class="dhcell">'+gob+'</div></div>'
            });
          break;
        case 'cash':
            idname = 'v3cashbox'
            $(".v3dh").html('<div class="tuant">���Ѷһ� <em>'+data.count+'</em> ����Ʒ�������� <i>'+data.num+'</i> �ʶ���</div>')
            dhlist += '<div class="dhrow"><div class="dhcell">�һ���Ʒ</div><div class="dhcell">�ܼ�</div><div class="dhcell">�һ���</div><div class="dhcell">״̬</div><div class="dhcell">����</div></div>'
            $.each(data.list, function(index, val) {
                var mn = val.iCost?val.iCost+'Ԫ+':''
                var gob = val.iState==2?'<a href="/infocenter/Integral.aspx?uId=' + val.idUser + '" target="_blank">�鿴</a>':'<a href="/GroupBuy/IOrder.aspx?idorder=' + val.idOrder + '" target="_blank">����</a>'
                dhlist += '<div class="dhrow"><div class="dhcell"><img src="'+val.cImage+'">������ţ�'+val.idOrder+'<br>'+val.cGoodName+'</div><div class="dhcell">'+mn+val.cScore+'����</div><div class="dhcell">'+val.code+'<br>'+val.codeState+'</div><div class="dhcell">'+dhstatus[val.iState]+'</div><div class="dhcell">'+gob+'</div></div>'
            });
          break;
        case 'flight':
            idname = 'v3flightbox'
            $(".v3dh").html('<div class="tuant">���� <em>'+data.count+'</em> �ʶ����������� <i>'+data.num+'</i> �ʶ���</div>')
            dhlist += '<div class="dhrow"><div class="dhcell">����</div><div class="dhcell">ʱ��</div><div class="dhcell">�ܼ�</div><div class="dhcell">״̬</div><div class="dhcell">�µ�ʱ��</div><div class="dhcell">����</div></div>'
            $.each(data.list, function(index, val) {
                var gob = val.iState==2?'<a href="/GroupBuy/Group.aspx?uId=' + val.id + '" target="_blank">�鿴</a>':'<a href="/Flight/flightpay.aspx?id=' + val.id + '&order='+val.cOrder_no+'" target="_blank">����</a>'
                dhlist += '<div class="dhrow"><div class="dhcell">������ţ�'+val.cOrder_no+'<br>'+val.cItemName+'</div><div class="dhcell">'+val.FlightDate+'</div><div class="dhcell">'+val.iCost+'</div><div class="dhcell">'+fkstatus[val.iStatus]+'</div><div class="dhcell">'+val.dConfirmTime+'</div><div class="dhcell">'+gob+'</div></div>'
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
                $(".toast").html('û��Ȩ��').show().addClass('toast-error')
                errorboxhide()
                setTimeout(function(){history.go(-1)},2000)
                return false
            }
        });
        getdh(loca)
    });
    // ��Ϣ�л�
    $(".equip span").click(function () {
        loca = $(this).data('do')
        getdh(loca)
        $(".equip span[data-do="+loca+"]").addClass('equip-ous').siblings('span').removeClass('equip-ous')
    })
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />