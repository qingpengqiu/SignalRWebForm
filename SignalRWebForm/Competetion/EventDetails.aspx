<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EventDetails.aspx.cs" Inherits="Competetion_EventDetails" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>
<script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
<link rel="stylesheet" href="/froala/css/froala_style.css">

<div class="banner">
    <div class="mine"><h1><%=title %></h1>
        <asp:Literal ID="ltlbanner" runat="server"></asp:Literal>
    </div>
</div>
<div class="tbody">
    <div class="mine">
        <ERUN360:bmnav runat="server" ID="bmnav" />
        <div class="tbodyBox">
            <div class="present this">
                <div class="Introduction">
                    <div class="mthumb">
                        <asp:Literal ID="ltljdt" runat="server"></asp:Literal>
                       <%-- <img src="/Html/images/mthumb.jpg" alt="" >--%>
                    </div>
                    <div class="manue" id="information">
                        <asp:Literal ID="ltlRace" runat="server"></asp:Literal>
                    </div>
                    <div class="both"></div>
                    <div class="share">
                        <a id="sharewb" href="javascript:void(0)">
                            <img src="http://erun360.com/Html/images/weiboc.png" alt="">
                            分享到新浪微博</a> | <a href="javascript:void(0)" id="copyUrl">
                                <img src="http://erun360.com/Html/images/fuzhi.png" alt="">复制地址</a> | <a href="/infocenter/PostMessage.aspx" class="article-up-iframe">
                                    <img src="http://erun360.com/Html/images/friend.png" alt="">分享给站内好友</a>

                        </div>
                    </div>
                      <form id="from1" runat="server">
                    <div class="czbox">
                        <asp:Literal ID="ltlgz" runat="server"></asp:Literal>
                        <asp:Literal ID="ltlbm" runat="server"></asp:Literal>
                    </div>
                    <div class="manuenr fr-view">
                        <asp:Literal ID="ltlContent" runat="server"></asp:Literal>
                    </div>
                    <div class="czbox">
                        <asp:Literal ID="ltlgz1" runat="server"></asp:Literal>
                        <asp:Literal ID="ltlbm1" runat="server"></asp:Literal>
                        <%--<a href="javascript:void(0)" class="gz">立即关注</a>--%>
                        <%--<a href="javascript:void(0)" class="bm">立即报名</a>--%>
                    </div>
                          </form>
                    <div class="both"></div>
                </div>
                <div class="event">
                    <div class="eventTip">
                        以下信息为必填项，请认真填写；凡在线报名过的用户我们将自动为您填写部分信息,若您需要修改信息，请直接修改表单内容即可;若您帮朋友报名，请注册新的账号再进行报名
                    </div>
                    赛事报名
                </div>
        </div>
    </div>
</div>
<div class="eventtip">
    <h4><<<  滑动菜单 查看更多 >>></h4>
    <div class="bnav">
    </div>
    <img src="/Html/images/tipshou.png" class="tipshou">
    <div class="eventtipkn">知道了</div>
</div>
<ERUN360:ICart runat="server" ID="ICart" />
<script type="text/javascript">
    var store = $.AMUI.store;
    // if (!store.get('eventtip') && $(window).width()<800) {
    //     var nav = $(".bnav").html()
    //     $("body").addClass('xhbody')
    //     $(".eventtip").show().find('.bnav').append(nav)
    // };
    // $(".eventtip").click(function (event) {
    //     $("body").removeClass('xhbody')
    //     $(".eventtip").hide()
    //     store.set('eventtip', '1')
    // });
    function JoinCreate(idx) {
        $.get("/action/EventService.ashx", { id: idx, op: "gzss", rnd: Math.random() }, function (result) {
            if (result.status == 1) {
                $(".gz").html('已关注').addClass('gzcg');
            }
            else if (result.status == 0) {
                PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
            }
            else {
                $(".gz").html('立即关注').removeClass('gzcg')
            }
        });
    }
    $(".openm").click(function(event) {
        $(".manueb").toggleClass('.hauto');
    });
    //复制插件
$(document).ready(function(){
    thisurl = window.location.href
    $('#copyUrl').zclip({
        path:'/Html/js/ZeroClipboard.swf',
        copy:thisurl
    });
    $("#sharewb").click(function(event) {
        window.open("http://service.weibo.com/share/share.php?url="+thisurl+"&type=button&ralateUid=2961848493&language=zh_cn&appkey=1VDwW4&searchPic=true&style=simple")
    });
});
$(".article-up-iframe").on('click', function(e){
    $(this).colorbox({href: $(this).attr('href'), iframe:true, width: 432, innerHeight:200, open:true,opacity: "0.4"});
    e.preventDefault();
    return false;
}); 

</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />