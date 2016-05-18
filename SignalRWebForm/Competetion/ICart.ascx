<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ICart.ascx.cs" Inherits="Competetion_ICart" %>
<div class="mxbox">
        <div class="mxzi">
            我的购物车
			<i>0</i>
        </div>
        <div class="mxlibox">
            <div class="mxli">
                <div class="buylist">
                </div>
                <div class="mxu jpbox">
                    <div class="mxut mxui jpjg">
                        机票<i>&yen;0</i>
                    </div>
                </div>
                <div class="mxu jdbox">
                    <div class="mxut mxui jdjg">
                        酒店<i>&yen;0</i>
                    </div>
                </div>
                <div class="mxu zbbox">
                    <div class="mxut mxui zbjg">
                        装备<i>&yen;0</i>
                    </div>
                </div>
                <div class="mxu fjbox">
                    <div class="mxut mxui fjjg">
                        附加项<i>&yen;0</i>
                    </div>
                </div>
                <div class="allmx">
                    总价：&yen;0
                </div>
                <a class="gofk">
                    立即付款
                </a>
            </div>
        </div>

    </div>
    <div class="toast " ></div>
    <script type="text/javascript">
        jQuery(document).ready(function($) {
            geticart()
        });
        function geticart(){
            $(".mxu").html('').hide()
            var carttype = [0,1,'参赛报名费：','交通','酒店','旅游',6,'签证','装备','附加项']
            $.getJSON('/action/EventService.ashx', {sid: <%=sid%>,op:'icart'}, function(json, textStatus) {
                $(".mxzi i").html(json.count)
                if (json.count == 0) {
                    $(".buylist").append('<div class="buylistnone">无项目</div>')
                    $(".mxlibox").hide();
                    return false
                };
                var jd = 0,
                    zb = 0,
                    ly = 0,
                    fj = 0
                $('.gofk').attr('href','/Competetion/payall.aspx?sid=<%=sid%>'); 
                $.each(json.cart, function(index, val) {
                    if (val.iTpye == 2) {
                        $(".buylist").append('<div class="mxu mxu1"><div class="mxui">参赛报名费：<i>&yen;'+val.Price+'</i><div class="closethis" data-id="'+val.id+'">x</div></div></div>')
                    }else if (val.iTpye == 3) {
                        $(".jpjg i").html('&yen;'+val.Price)
                        $(".jpbox").append('<div class="mxuli mxui">'+val.Name+'：<i>&yen;'+val.Price+'</i><div class="closethis" data-id="'+val.id+'">x</div></div>').show()
                    }else if (val.iTpye == 4) {
                        jd += eval(val.Price)*val.num
                        $(".jdjg i").html('&yen;'+jd)
                        $(".jdbox").append('<div class="mxuli mxui">'+val.Name+'：<i>&yen;'+val.Price+'<em>('+val.num+')</em></i><div class="closethis" data-id="'+val.id+'">x</div></div>').show()
                    }else if (val.iTpye == 5) {
                        jd += eval(val.Price)*val.num
                        $(".jdjg i").html('&yen;'+ly)
                        $(".jdbox").append('<div class="mxuli mxui">'+val.Name+'：<i>&yen;'+val.Price+'<em>('+val.num+')</em></i><div class="closethis" data-id="'+val.id+'">x</div></div>').show()
                    }
                    else if (val.iTpye == 8) {
                        zb += eval(val.Price)*val.num
                        $(".zbjg i").html('&yen;'+zb)
                        $(".zbbox").append('<div class="mxuli mxui">'+val.Name+'：<i>&yen;'+val.Price+'<em>('+val.num+')</em></i><div class="closethis" data-id="'+val.id+'">x</div></div>').show()
                    }else if (val.iTpye == 9) {
                        fj += eval(val.Price)*val.num
                        $(".fjjg i").html('&yen;'+fj)
                        $(".fjbox").append('<div class="mxuli mxui">'+val.Name+'：<i>&yen;'+val.Price+'<em>('+val.num+')</em></i><div class="closethis" data-id="'+val.id+'">x</div></div>').show()
                    }
                });
                $(".allmx").html('总价：&yen;'+json.Total)
                    
            });
        }
    $(".mxlibox").on('click', '.closethis', function(event) {
        $.getJSON('/action/EventService.ashx', {sid: <%=sid%>,op:'qxdd',id:$(this).data('id')}, function(json, textStatus) {
            geticart()
            $(".toast").html('删除成功').show().addClass('toast-success')
            errorboxhide()
        });
    });
    $(".mxbox").click(function(event) {
        $(".mxlibox").toggle()
    });
    </script>