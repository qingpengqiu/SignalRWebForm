<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Competition.aspx.cs" Inherits="infocenter_Competition" %>

<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Src="~/Controls/Erun_Right.ascx" TagPrefix="ERUN360" TagName="Erun_Right" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right">
        <div class="equip">
            <span data-do="signupevent" class="tashow">我报名的赛事</span>
            <!-- <span data-do="allevent" class="equipnone">全部赛事</span> -->
            <span data-do="foucsevent" class="equipnone">关注的赛事</span>
            <span data-do="myevent" class="v3posteven">发布的赛事</span>
            <a href="/Competetion/PostEvent.aspx?uId=<%=cId %>" class="v3posteven">发布新版赛事</a>
        </div>
        <div class="v3dh"></div>
        <div class="v3page" id="v3page"></div>
    </div>
</article>
<script type="text/javascript">
    var loca = GetQueryString("tablep")
    if ((loca != 'allevent') && (loca != 'signupevent') && (loca != 'foucsevent') && (loca != 'myevent')) {
        loca = 'signupevent'
    };
    custom = function () {
        getdh(loca, 1)
        $.get('/action/AjaxUser.ashx?op=getuser', function (data) {
            if (data.msg == $.AMUI.store.get('leftuserinfo').id) {
                $(".tashow").html('我报名的赛事')
                $(".equipnone").show()
                if (data.msg == '100001183' || data.msg == '100055041' || data.msg == '100000002') {
                    $(".v3posteven").show()
                };
            }

        });
    }
    jQuery(document).ready(function ($) {
        custom()
    });
    function getdh(loca, p) {
        $.AMUI.progress.start();
        $(".equip span[data-do=" + loca + "]").addClass('equip-ous').siblings('span').removeClass('equip-ous')
        if (loca == 'foucsevent') {
            var url = '/action/ajaxevent.ashx?op=' + loca + '&p=' + p + '&uid=' + id
        } else {
            var url = '/action/ajaxevent.ashx?op=' + loca + '&p=' + p
        }
        $.get(url, function (data) {
            if (data.status == 0) {
                $(".toast").html(data.msg).show().addClass('toast-error')
                errorboxhide()
                setTimeout(function () { PopupShowdl(); StatusCheck(); }, 1000)
                return false
            }
            var dhlist = '',
                idname = ''
            switch (loca) {
                case 'allevent':
                    idname = 'alleventbox'
                    $(".v3dh").html('')
                    dhlist += '<div class="dhrow"><div class="dhcell">赛事名称</div><div class="dhcell">举办地点</div><div class="dhcell">比赛时间</div><div class="dhcell">报名时间</div></div>'
                    $.each(data.list, function (index, val) {
                        var turl = val.idBlog == 0 ? '<a href="/Competetion/EventDetails.aspx?sid=' + val.id + '" target="_blank">' + val.cTitle + '</a>' : '<a href="/blog/' + val.idBlog + '.aspx" target="_blank">' + val.cTitle + '</a>'
                        dhlist += '<div class="dhrow"><div class="dhcell">' + turl + '</div><div class="dhcell">' + val.cCityname + '</div><div class="dhcell">' + val.dRaceBegin + '</div><div class="dhcell">' + val.dJoinBegin + '</div></div>'
                    });
                    break;
                case 'signupevent':
                    idname = 'signupeventbox'
                    $(".v3dh").html('')
                    dhlist += '<div class="dhrow"><div class="dhcell">赛事名称</div><div class="dhcell">费用</div><div class="dhcell">状态</div><div class="dhcell">参赛号码</div></div>'
                    $.each(data.list, function (index, val) {
                        var turl = val.idBlog == 0 ? '<a href="/Competetion/EventDetails.aspx?sid=' + val.id + '" target="_blank">' + val.cTitle + '</a>' : '<a href="/blog/' + val.idBlog + '.aspx" target="_blank">' + val.cTitle + '</a>',
                            zurl = val.iState != '已过期' ? '<a href="/Competetion/OrderDetails.aspx?sid=' + val.id + '&nav=2&orderid=' + val.idOrder + '" target="_blank">' + val.iState + '</a>' : val.iState
                        dhlist += '<div class="dhrow"><div class="dhcell">' + turl + '</div><div class="dhcell">' + val.iCost + '</div><div class="dhcell">' + zurl + '</div><div class="dhcell">' + val.cMember + '</div></div>'
                    });
                    break;
                case 'foucsevent':
                    idname = 'foucseventbox'
                    $(".v3dh").html('')
                    dhlist += '<div class="dhrow"><div class="dhcell">赛事名称</div><div class="dhcell">举办地点</div><div class="dhcell">比赛时间</div><div class="dhcell">报名时间</div></div>'
                    $.each(data.list, function (index, val) {
                        var turl = val.idBlog == 0 ? '<a href="/Competetion/EventDetails.aspx?sid=' + val.id + '" target="_blank">' + val.cTitle + '</a>' : '<a href="/blog/' + val.idBlog + '.aspx" target="_blank">' + val.cTitle + '</a>'
                        dhlist += '<div class="dhrow"><div class="dhcell">' + turl + '</div><div class="dhcell">' + val.cCityname + '</div><div class="dhcell">' + val.dRaceBegin + '</div><div class="dhcell">' + val.dJoinBegin + '</div></div>'
                    });
                    break;
                case 'myevent':
                    idname = 'myeventbox'
                    $(".v3dh").html('')
                    dhlist += '<div class="dhrow"><div class="dhcell">赛事名称</div><div class="dhcell">比赛时间</div><div class="dhcell">状态</div><div class="dhcell">编辑</div></div>'
                    $.each(data.list, function (index, val) {
                        var turl = '<a href="/Competetion/EventDetails.aspx?sid=' + val.id + '" target="_blank">' + val.cTitle + '</a>'
                        dhlist += '<div class="dhrow"><div class="dhcell">' + turl + '</div><div class="dhcell">' + val.dRaceBegin + '</div><div class="dhcell">' + val.iStatus + '</div><div class="dhcell"><a href="/Competetion/PostEvent.aspx?sid=' + val.id + '">编辑</a></div></div>'
                    });
                    break;
            }
            $(".v3dh").append('<div class="dhlistbox sslistbox ' + idname + '">' + dhlist + '</div>')
            if (data.count > 20) {
                v3page.cview('#v3page', data.count, p)
            } else {
                $("#v3page").html('')
            }
            $.AMUI.progress.done();
        });
    }
    var v3page = {
        "rview": function (tp, p) {
            return '\u5f53\u524d\u7b2c<i>' + tp + '</i>\u9875 , \u5171<i>' + p + '</i>\u9875 \u002c \u53bb<input type="text" id="v3gopage">\u9875 <button type="button" class="am-btn am-btn-success am-radius">go</button>'
        },
        "cview": function (id, num, g) {
            var p = Math.ceil(num / 20)
            $(id).html(this.rview(g, p)).find('button').click(function (event) {
                var g = $("#v3gopage").val()
                if (g <= p && g > 0) {
                    getdh(loca, g)
                } else {
                    $(".toast").html('页数不存在').show().addClass('toast-error')
                    errorboxhide()
                }
            });
        }

    }

    // 信息切换
    $(".equip span").click(function () {
        loca = $(this).data('do')
        getdh(loca, 1)
        $(".equip span[data-do=" + loca + "]").addClass('equip-ous').siblings('span').removeClass('equip-ous')
    })
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />
