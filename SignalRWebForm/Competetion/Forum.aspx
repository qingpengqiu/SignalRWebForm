<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Forum.aspx.cs" Inherits="Competetion_Forum" %>

<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    #cContent{width: 830px;}
    body{background: #f6f6f6}
</style>
<script type="text/javascript" src="../Html/js/jquery.emotions.js"></script>
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
                <div class="forumt"></div>
                <div class="discuss-border">
                    <div class="discuss-text">
                        <div class="faceimg"></div>
                        <textarea name="cContent" id="cContent" style="font-size: 14px; padding: 5px;" rows="3" cols="70"></textarea><br>
                        <span id="lbtip" style="color: Red;"></span>
                        <input type="submit" name="btnDiscuss" value="提交" id="btnDiscuss" class="submit" />
                        <ul id="text">
                        </ul>
                        <div class="mored" onclick="mored()">更多</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var id = '',
        pt = 0,
        p = 1,
        t = '',
mea = ['','微笑','憨笑','调皮','惊讶','耍酷','发火','呵呵','汗水','大哭','尴尬','鄙视','难过','夸奖','财迷','疑问','哼哼','狂吐','哟呵','害羞','亲吻','发愁','大笑','晕倒','可爱','坏笑','呲牙','暴汗','楚楚可怜','困','哭','生气','吃惊','口水','爱','心碎','玫瑰','礼物','彩虹','月亮','太阳','钱钱','灯泡','咖啡','蛋糕','音乐','爱你','胜利','赞','弱','OK','D哭','D加油','D必胜','D贱贱','D牛逼','D想静静','D颠球','D生气','D得瑟','D狂奔','D赞','E加油','D大哭','D红牌罚下','D激动','D哈哈']
createEx()
        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }

        jQuery(document).ready(function ($) {
            id = GetQueryString("sid")
            if (id) {
                $(".forumt").html('<a href="javascript:void(0)" class="this" data-pt="0">赛事咨询</a><a href="javascript:void(0)" data-pt="1">参赛者讨论组</a><a href="javascript:void(0)" data-pt="2">同城讨论组</a>').find('a').click(function (event) {
                    pt = $(this).data('pt')
                    $(this).addClass('this').siblings().removeClass('this')
                    $("#text").html('')
                    getlist(id, pt, 1)
                    p = 1
                });
                getlist(id, pt, 1)
            }
        });
        function getlist(id, pt, p) {
            var dlist = '';
            $.get('/action/AjaxForum.ashx?op=forums&idrace=' + id + '&pt=' + pt + '&p=' + p, function (data) {

                if (data.status == 0) {
                    $("#text").html('<li class="forumerror">' + data.msg + '</li>')
                    if (pt == 0) {
                        $(".discuss-icon").show()
                        $("#cContent").show()
                        $(".mored").show()
                        $("#btnDiscuss").show()
                    }
                    else {
                        $(".discuss-icon").hide()
                        $(".mored").hide()
                        $("#cContent").hide()
                        $("#btnDiscuss").hide()
                    }
                    return false
                } else if (data.status == 1) {
                    if (p == 1) {
                        $("#text").html('<li class="forumerror">' + data.msg + '</li>')
                        $(".discuss-icon").show()
                        $("#cContent").show()
                        $("#btnDiscuss").show()
                        return false
                    }else{
                        $(".mored").html('没有更多评论')
                        return false
                    }
                    
                } else if (data.status == -2) {
                    window.location.href = "/Competetion/SearchEvent.aspx";
                }
                $(".mored").show()
                $(".discuss-icon").show()
                $("#cContent").show()
                $("#btnDiscuss").show()
                $.each(data, function (index, val) {
                    dlist += '<li id="li' + index + '"><a href="/user/' + val.User[0].id + '.aspx" target="_blank"><img src="' + val.User[0].cAvatar + '" alt="">' + val.User[0].cNickName + '</a><span>' + val.dCreate + '</span><p>' + val.cContent + '</p><a href="javascript:void(0)" class="huifu" onclick="huifuta(' + val.User[0].id + ',' + index + ')">[回复]</a></li>'
                });
                $("#text").html(dlist).emotions();
            });
        }
        function EmotionAdd(v) {
            document.getElementById("cContent").value += "[" + v + "]";
        }
        function huifuta(bid, id) {
            $("#text .huifuk").remove();
            $("#li" + id).append("<div class=\"huifuk\"><em></em>回复：<br><textarea id=\"reply\"></textarea><a class=\"reply\" onclick=\"replyd(" + bid + ")\" href=\"javascript:void(0)\">发送</a><a class=\"qreply\" onclick=\"qreply()\" href=\"javascript:void(0)\">取消</a></div>")
            //$.get("/action/GetMessageList.ashx", { command: "state" }, function (data) {
            //    if (data == "-1") {
            //        PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
            //    } else {
            //        $("#li" + id).append("<div class=\"huifuk\"><em></em>回复：<br><textarea id=\"reply\"></textarea><a class=\"reply\" onclick=\"replyd(" + bid + ")\" href=\"javascript:void(0)\">发送</a><a class=\"qreply\" onclick=\"qreply()\" href=\"javascript:void(0)\">取消</a></div>")
            //    }
            //});
        }
        function qreply() {
            $(".huifuk").remove()
        }
        function mored(){
            p++
            getlist(id, pt, p)
        }
        $("#btnDiscuss").click(function (event) {
            $.post('/action/AjaxForum.ashx', { op: 'addforums', idrace: id, msg: $("#cContent").val(), pt: pt }, function (data, textStatus, xhr) {
                if (data.status == '-1') {
                    PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
                } else {
                    $("#cContent").val('')
                    getlist(id, pt, 1)
                }
            });
        });
        function replyd(bid) {
            msg = encodeURIComponent($("#reply").val());
            $.get("/action/AjaxForum.ashx", { op: "replyforum", idrace: id, msg: msg, pt: pt, user: bid }, function (data) {
                if (data.status == "-1") {
                    PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
                } else if (data.status == "1") {
                    getlist(id, pt, 1)
                } else if (data.status == "0") {
                }
            });
        }
        function createEx(){
    for (var i = 1; i <= 66; i++) {
    var l = (i-1)*30
    if (i > 50 ) {
        t+='<a data-img="/assets/face/i_f'+i+'.gif" data-t="'+ mea[i] +'" style="background-position: left -'+l+'px"></a>'
    }else{
        t+='<a data-img="/assets/face/i_f'+i+'.png" data-t="'+ mea[i] +'" style="background-position: left -'+l+'px"></a>'
        }
    };
    $(".faceimg").append(t).find('a').hover(function() {
        var x = $(this).offset().left+35,
            y = $(this).offset().top+15,
            url = $(this).data('img'),
            bigface = '<div class="bigface" style="top:'+y+'px;left:'+x+'px"><img src="'+url+'"></div>'
        $("body").append(bigface)
    }, function() {
        $("body").find('.bigface').remove()
    }).click(function(event) {
        var p = $(this).data('t')
        document.getElementById("cContent").value += '['+ p + ']';
    });
}

    </script>
<ERUN360:footerv3 runat="server" ID="footerv3" />
