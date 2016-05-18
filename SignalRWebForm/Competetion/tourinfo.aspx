<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tourinfo.aspx.cs" Inherits="Competetion_tourinfo" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>
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
                <a class="backlisteq" href="/Competetion/equipment.aspx?sid=<%=sid %>&nav=5">>返回旅游列表</a>
                <div class="equipinfo">                       
                	<div class="eqinfothumb">                             
                         <asp:Literal ID="ltltu" runat="server"></asp:Literal>
                        <%--<img src="http://img.erun360.com/shoe/Adidas_Adistar_Boost_2.jpg" class="eqinbigthumb">                            --%>
                         <asp:Literal ID="ltlprice" runat="server"></asp:Literal>
                        <asp:Literal ID="ltlcolor" runat="server"></asp:Literal>
                        <div class="equicolor equicolorshow"></div>
                        <asp:Literal ID="ltlsize" runat="server"></asp:Literal>
                        <div class="equisize"></div>
                        <asp:Literal ID="ltlnum" runat="server"></asp:Literal>
                        <form id="eq1">
                        <div class="eqlistjf"><label>积分抵扣：<input id="jf" type="checkbox" name="jf"><div class="jftip"></div></label></div>
                       <div class="equinum">
                        数量：<input type="number" name="num" class="fen" value="1" min="1" max="6"><input type="hidden" value="" id="zbid" name="zbid">
                        </div>
                        </form>
                        <a href="javascript:void(0)" class="equilgo">加入购物车</a>
                	</div>
                     <asp:Literal ID="ltljs" runat="server"></asp:Literal>
                 <%--   <h3>PWX FLEX 面料提供了最佳的力量和灵活性PWX FLEX 面料提供了最佳的力量和灵活性</h3>--%>
                     <asp:Literal ID="ltlyy" runat="server"></asp:Literal>
					<%--<h4>推荐原因</h4>
					促进血液回流带来更大的供氧量以加快恢复
					通过减少肌肉震动来减少疲劳
					减少肌肉酸痛
					避免长时间重复运动带来的损伤
					在运动前保存更多热量，让你更快的热身
					助你输出所有能量
					高灵活性带来绝佳穿着体验  
					<hr>--%>
                    <asp:Literal ID="ltltd" runat="server"></asp:Literal>
					<%--<h4>特点</h4>--%>
                </div>

            </div>
        </div>
    </div>
</div>
<div id="dpbg"></div>
<div class="dpbox equitopbox" id="dpbox">
    <div class="dptitle">旅游产品 <i></i></div>
    <div class="equinbox am-form hoteltbox">
        <form id="linkp">
        <asp:Literal ID="ltlInfo" runat="server"></asp:Literal>
        <%--<div class="equipop">
        选择常用联系人： <br>
           
            <label><input type="radio" data-id="8" data-fristname="王" data-lastname="眼" data-tel="12312313" data-add="12312313" name="lxr"> 王眼</label>
            <label><input type="radio" data-id="8" data-fristname="王" data-lastname="眼" data-tel="12312313" data-add="12312313" name="lxr"> 王眼</label>
            <label><input type="radio" data-id="8" data-fristname="王" data-lastname="眼" data-tel="12312313" data-add="12312313" name="lxr"> 王眼</label>
        </div>--%>
        <hr>
            <input type='hidden' value='tjlv' name="op">
            <input type='hidden' value='<%=sid%>' name="sid">
            <input type='hidden' value='<%=id%>' name="id">
            <input type='hidden' name="linkid"  id="linkid" value="0">
            <label><em>姓名：</em><input type="text" value="" name="fristname" id="fristname" placeholder="姓" style="width:60px;margin-right:8px;"><input type="text" value="" name="lastname" id="lastname" placeholder="名" style="width:60px"></label>
            <label><em>电话：</em><input type="text" name="tel" id="tel"></label>
            <label><em>地址：</em><input type="text" name="add" id="add"></label>
            <label><em>备注：</em><textarea name="beizhu" id="beizhu"></textarea></label> 
           

        </form>
        <div class="equibuttom">确认定单</div>
    </div>
</div>
    <style>.dpbox{width: 680px;min-height: 400px;background: #fff;position: absolute;z-index: 1000;top: 400px;left: 50%;margin-left: -340px;margin-bottom: 44px;display: none;}</style>
<script type="text/javascript">
    var colorjson = <%=colorjson %>,
        sizejson  = <%=sizejson %>,
    onsize = 0,
    oncolor = 0,
    onmodel = 0,
    mscore = <%=iScore%>,
    idUser = <%=idUser%>
jQuery(document).ready(function($) {
    colorhtml(colorjson)
    sizehtml(sizejson)
});
$(".equipop input").change(function(event) {
    var t = $(this)
    $("#fristname").val(t.data('fristname'))
    $("#lastname").val(t.data('lastname'))
    $("#add").val(t.data('add'))
    $("#tel").val(t.data('tel'))
    $("#linkid").val(t.data('id'))
});
function colorhtml(array){
    var colorhtml = '可选类型：'
    $.each(array, function(index, val) {
        colorhtml+='<img src="'+val.cURL+'" data-on="0" >'
    });
    $(".equicolor").html(colorhtml).find('img').click(function(event) {
        var i = $(this).index()
        $(".eqinbigthumb").attr("src",$(this).attr("src"));	
        if (onmodel == 0 || onmodel == 2) {
            if (oncolor == 0) {
                $(this).data('on', '1').addClass('this').siblings('img').removeClass('this')
                sizehtmlde(colorjson[i].cSize)
                oncolor = 1
                onmodel = 2
            }else{
                if ($(this).data('on') == 0) {
                    $(this).addClass('this').data('on', '1').siblings('img').removeClass('this').data('on', '0')
                    sizehtmlde(colorjson[i].cSize)
                    onsize = 0
                }else{
                    $(this).removeClass('this').data('on', '0').siblings('img').removeClass('this').data('on', '0')
                    sizehtml(sizejson)
                    onsize = 0
                    oncolor = 0
                    onmodel = 0
                }
            }
        };
    });
}
function sizehtmlde(array){
    var sizehtml = '可选项目：'
    $.each(array, function(index, val) {
        sizehtml+='<a data-fm="'+val.fMarketPrice+'" data-id="'+val.id+'" data-on="0" data-is="'+val.iScore+'" data-im="'+val.iMoney+'"  data-fs="'+val.fSellPrice+'" data-il="'+val.iLimit+'" >'+val.cSize+'</a>'
    });
    $(".equisize").html(sizehtml).find('a').click(function(event) {
        if (onsize == 0) {
            $(this).addClass('this').data('on', '1').siblings('a').removeClass('this').data('on', '0')
            var d = $(this),
            idmax = <%=iBuyMax%>,
            ndmax = d.data('il'),
            max = (idmax>ndmax || idmax == 0)?ndmax:idmax
            $(".eqinfothumb i").html('&yen'+d.data('fm'))
            $(".eqinfothumb em").html('&yen'+d.data('fs'))
            $(".fen").attr('max', max);
            $("#zbid").val(d.data('id'))
            jfdk(d.data('is'),d.data('im'))
            onsize = 1
            }else{
                if ($(this).data('on') == 0) {
                    $(this).addClass('this').data('on', '1').siblings('a').removeClass('this').data('on', '0')
                    var d = $(this),
                    idmax = <%=iBuyMax%>,
                ndmax = d.data('il'),
                max = (idmax>ndmax || idmax == 0)?ndmax:idmax
                $(".eqinfothumb i").html('&yen'+d.data('fm'))
                $(".eqinfothumb em").html('&yen'+d.data('fs'))
                $(".fen").attr('max', max);
                $("#zbid").val(d.data('id'))
                jfdk(d.data('is'),d.data('im'))
                }else{
                    $(this).removeClass('this').data('on', '0').siblings('img').removeClass('this').data('on', '0')
                    onsize = 0
                }
            }
    }); 
    }
    function sizehtml(array){
        var sizehtml = '可选项目：'
        $.each(array, function(index, val) {
            sizehtml+='<a data-on="0">'+val.cSize+'</a>'
        });
        $(".equisize").html(sizehtml).find('a').click(function(event) {
            var i = $(this).index();
            if (onmodel == 0 || onmodel == 1 ) {
                if (onsize == 0) {
                    $(this).data('on', '1').addClass('this').siblings('a').removeClass('this').data('on', '0')
                    colorhtmlde(sizejson[i].cColor)
                    onsize = 1
                    onmodel = 1
                }else{
                    if ($(this).data('on') == 0) {
                        $(this).data('on', '1').addClass('this').siblings('a').removeClass('this').data('on', '0')
                        colorhtmlde(sizejson[i].cColor)
                        oncolor = 0
                    }else{
                        $(this).removeClass('this').data('on', '0').siblings('a').removeClass('this').data('on', '0')
                        colorhtml(colorjson)
                        onsize = 0
                        oncolor = 0
                        onmodel = 0
                    }
                }
            };
        }); 
    }
    function colorhtmlde(array){
        var colorhtml = '可选类型：'
        $.each(array, function(index, val) {
            colorhtml+='<img src="'+val.cURL+'" data-on="0" data-fm="'+val.fMarketPrice+'" data-id="'+val.id+'" data-is="'+val.iScore+'" data-im="'+val.iMoney+'"  data-fs="'+val.fSellPrice+'" data-il="'+val.iLimit+'" >'
        });
        $(".equicolor").html(colorhtml).find('img').click(function(event) {
            if (oncolor == 0) {
                $(this).addClass('this').data('on', '1').siblings('img').removeClass('this').data('on', '0')
                var d = $(this),
                idmax = <%=iBuyMax%>,
            ndmax = d.data('il'),
            max = (idmax>ndmax)?ndmax:idmax
            $(".eqinfothumb i").html('&yen'+d.data('fm'))
            $(".eqinfothumb em").html('&yen'+d.data('fs'))
            $(".fen").attr('max', max);
            $("#zbid").val(d.data('id'))        
            jfdk(d.data('is'),d.data('im'))
            oncolor = 1
            }else{
                if ($(this).data('on') == 0) {
                    $(this).addClass('this').data('on', '1').siblings('img').removeClass('this').data('on', '0')
                    var d = $(this),
                    idmax = <%=iBuyMax%>,
                ndmax = d.data('il'),
                max = (idmax>ndmax)?ndmax:idmax
                $(".eqinfothumb i").html('&yen'+d.data('fm'))
                $(".eqinfothumb em").html('&yen'+d.data('fs'))
                $(".fen").attr('max', max);
                $("#zbid").val(d.data('id'))
                jfdk(d.data('is'),d.data('im'))
                }else{
                    $(this).removeClass('this').data('on', '0').siblings('img').removeClass('this').data('on', '0')
                    oncolor = 0
                }
            }
    });
    }
    $(".equilgo").click(function(event) {
        if (idUser == 0) {
            PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();
            return false
        };
        if (onsize == 1 && oncolor == 1) {
            dpb()
        }else{
            $(".toast").html('请选择类型和项目').show().addClass('toast-error')
            errorboxhide()
        }
    });
    $(".equibuttom").click(function(event) {
        var go = 0
        $("#linkp input").each(function(index, el) {
            if ($(this).val()) {
                go = 0
            }else{
                go = 1
                $(".toast").html('邮寄信息请完善').show().addClass('toast-error')
                errorboxhide()
                $(this).focus();
                return false
            }
        });
        if (go == 0) {
            $.ajax({
                type: "POST",
                dataType: "json",
                url:'/action/EventService.ashx',
                data:$("#linkp").serialize()+'&'+$("#eq1").serialize(),
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
    function jfdk(is,im){
        if (is != 0 && idUser != 0) {
            $(".eqlistjf").show()
            if (is < mscore) {
                $(".jftip").html('您有<em>'+mscore+'</em>积分,可使用<em>'+is+'</em>积分 抵扣<em>'+im+'</em>元')
                $("#jf").removeAttr('disabled')
            }else{
                $(".jftip").html('<em>当前积分不足以抵扣</em>，<a href="/blog/200016255.aspx" target="_blank">点击查看积分来源</a>')
                $("#jf").removeAttr('checked').attr('disabled', 'disabled');
            }
        }else{
            $(".eqlistjf").hide()
        }
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

</script>
<ERUN360:ICart runat="server" ID="ICart" />
<ERUN360:footerv3 runat="server" ID="footerv3" />