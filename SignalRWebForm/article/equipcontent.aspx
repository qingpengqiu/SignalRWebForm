<%@ Page Language="C#" AutoEventWireup="true" CodeFile="equipcontent.aspx.cs" Inherits="article_equipcontent" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<script src="/Html/js/jquery.zclip.min.js"></script>
<script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
<article>
    <div class="blogleft">
        <div class="blogmun">文章正文</div> 
        <h1><%=modelBlog.cTitle %></h1>
        <div class="bloginfo">by: <a href="/user/<%=ArticleAuthorId%>.aspx"><%=modelBlog.cLoginname %></a>   <em><%=modelBlog.dCreate.ToString() %></em></div>
        <div class="blogshow fr-view">
            <%=equipinfo %>
        </div>
        <div class="share">
            <!--<a class="Collection" href="javascript:void(0)" data-up="on"><img src="/assets/css/images/x.png">收藏</a>--><%=strColllection %> | <a class="Zambia" href="javascript:void(0)" data-up="on"><img src="/assets/css/images/z.png">赞</a>|
            <a id="sharewb" href="javascript:void(0)">
            <img src="/Html/images/weiboc.png" alt="">
            分享到新浪微博</a> | <a href="javascript:void(0)" id="copyUrl">
            <img src="/Html/images/fuzhi.png" alt="">复制地址</a> | <a href="javascript:void(0)" data-url="/infocenter/PostMessage.aspx" class="article-up-iframe">
            <img src="/Html/images/friend.png" alt="">分享给站内好友</a>
            <div class="blogl">阅读(<%=modelBlogsummary.iShowTimes %>) 关注(<%=modelBlogsummary.iFocus %>) 顶(<%=modelBlogsummary.iDing %>) 评论(<%=modelBlogsummary.iDiscuss %>)</div>
        </div>
        <div class="blogpage">
            <%=Previous %><br>
            <%=Next %>
        </div>
        <div class="blogComment">
            <div class="commentmun">我要评论：</div>
            <div class="faceimg"></div>
            <textarea name="content" id="content"></textarea>
            <button class="discussSubmit">提交</button>
            <ul class="contentdiscusslist" id="discusslist">
            </ul>
            <div class="discussmore">更多</div>
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
var t = '',
mea = ['','微笑','憨笑','调皮','惊讶','耍酷','发火','呵呵','汗水','大哭','尴尬','鄙视','难过','夸奖','财迷','疑问','哼哼','狂吐','哟呵','害羞','亲吻','发愁','大笑','晕倒','可爱','坏笑','呲牙','暴汗','楚楚可怜','困','哭','生气','吃惊','口水','爱','心碎','玫瑰','礼物','彩虹','月亮','太阳','钱钱','灯泡','咖啡','蛋糕','音乐','爱你','胜利','赞','弱','OK','D哭','D加油','D必胜','D贱贱','D牛逼','D想静静','D颠球','D生气','D得瑟','D狂奔','D赞','D加油','D大哭','D红牌罚下','D激动','D哈哈'],
p = 1,
thisurl = window.location.href,
id =<%=sid%>
jQuery(document).ready(function($) {
    createEx()
    getlist(id, p)
    $.get('/action/AjaxUser.ashx?op=getuser', function(data) {
        if (data.status == 1 && data.msg == '<%=ArticleAuthorId%>') {
            $(".bloginfo").append(' <a href="/infocenter/postBlog.aspx?uId=<%=ArticleAuthorId%>&bId='+id+'">编辑</a> <a href="javascript:void(0)" data-id="'+id+'" class="delbolg">删除</a>').find('.delbolg').click(function(event) {
                delblog(id)
            });
        }
    });
});
    function delblog(id){
            var tip = '确定删除此文章？',
                operation = '删除',
                op = 'DeleteBlog'
         if(confirm(tip)){
            $.get('/action/AjaxBlog.ashx?op='+op+'&bId='+id, function(data) {
                if (data.status == -1) {
                    //weidenglu
                }else if(data.status == 1){
                    $(".toast").html(operation+'成功').show().addClass('toast-success')
                    errorboxhide()
                    setTimeout(function(){
                        window.location.href="/infocenter/Blog.aspx?uId=<%=ArticleAuthorId%>"; 
                    }, 3000 )
                    
                }else{
                    $(".toast").html(operation+'失败').show().addClass('toast-error')
                    errorboxhide()
                }
            });
        }
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
        document.getElementById("content").value += '['+ p + ']';
    });
}
function getlist(id, p) {
    var dlist = '';
    $.get('/action/ajaxBlog.ashx?op=forums&idBlog=' + id + '&p=' + p, function (data) {

        if (data.status == 0) {
            $("#discusslist").html('<li class="forumerror">' + data.msg + '</li>')
            return false
        } else if (data.status == 1) {
            if (p == 1) {
                $("#discusslist").html('<li class="forumerror">' + data.msg + '</li>')
                return false
            }else{
                $(".discussmore").html('没有更多评论')
                return false
            }
            
        } else if (data.status == -2) {
            window.location.href = "/";
        }
        $.each(data, function (index, val) {
            dlist += '<li><a href="/user/' + val.User[0].id + '.aspx" target="_blank" class="discussthumb"><img src="' + val.User[0].cAvatar + '" alt="">' + val.User[0].cNickName + '</a><span>' + val.dCreate + '</span><p>' + val.cContent + '</p><a href="javascript:void(0)" class="huifu" data-uid="' + val.User[0].id + '" >[回复]</a></li>'
        });
        if (p == 1) {
            $("#discusslist").html(dlist).find('.huifu').click(function(event) {
                var uid = $(this).data('uid')
                removediscussbox()
                $(this).after('<div class="huifubox">回复：<br><textarea id="reply"></textarea><a class="reply" onclick="replyd('+ uid +')" href="javascript:void(0)">发送</a><a class="qreply" onclick="removediscussbox()" href="javascript:void(0)">取消</a></div>')
                $("#reply").focus();
            }).end().find('p').emotions()
        }else{
            $("#discusslist").append(dlist).find('.huifu').click(function(event) {
                var uid = $(this).data('uid')
                removediscussbox()
                $(this).after('<div class="huifubox">回复：<br><textarea id="reply"></textarea><a class="reply" onclick="replyd('+ uid +')" href="javascript:void(0)">发送</a><a class="qreply" onclick="removediscussbox()" href="javascript:void(0)">取消</a></div>')
                $("#reply").focus();
            }).end().find('p').emotions()
        }
    });
}
function removediscussbox(){
    $("#discusslist").find('.huifubox').remove()
}
function replyd(uid){
    msg = encodeURIComponent($("#reply").val());
    if (msg) {
           $.get("/action/AjaxBlog.ashx", { op: "replyforum", idBlog: id, msg: msg, user: uid }, function (data) {
            if (data.status == "-1") {
                PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
            } else if (data.status == "1") {
                p = 1
                getlist(id, p)
            } else if (data.status == "0") {
            }
        }); 
       }else{
            $("#reply").focus().attr('placeholder', '回复内容不能为空');
       }
}
$(".discussmore").click(function(event) {
    p++
    getlist(id, p)
});
$(".discussSubmit").click(function (event) {
    var contenttext = $("#content").val()
    if (contenttext) {
        $.post('/action/AjaxBlog.ashx', { op: 'addforums', idBlog: id, msg: contenttext}, function (data, textStatus, xhr) {
            if (data.status == '-1') {
                PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
            } else {
                $("#content").val('').attr('placeholder', '');
                p=1
                getlist(id, p)
            }
        });
    }else{
        $("#content").focus().attr('placeholder', '评论内容不能为空');
    }
});
function iHouse() {
    $.get('/action/AjaxBlog.ashx?op=iHouse&idBlog='+id+'&rnd=' + Math.random(), function (result) {
        if (result.status == "1") {
            $(".toast").html('收藏成功').show().addClass('toast-success')
            errorboxhide()
            $(".Collection").html('<img src="/assets/css/images/x.png">已收藏').data('up', 'off')
        }else if(result.status == -1){
                PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
        }
    });
}
$(".Collection").click(function(event) {
    if ($(this).data('up') == "on") {
        iHouse()
    }
});
$(".Zambia").click(function(event) {
    if ($(this).data('up') == "on") {
        Ding()
    }
});
$("#sharewb").click(function(event) {
    window.open("http://service.weibo.com/share/share.php?url="+thisurl+"&type=button&ralateUid=2961848493&language=zh_cn&appkey=1VDwW4&searchPic=true&style=simple")
});
$('#copyUrl').zclip({
    path:'/Html/js/ZeroClipboard.swf',
    copy:thisurl
});
$(".article-up-iframe").on('click', function(e){
    var url = $(this).data('url')
    $.get('/action/AjaxUser.ashx?op=getuser', function(data) {
        if (data.status == 1) {
            $(this).colorbox({href: url, iframe:true, width: 432, innerHeight:200, open:true,opacity: "0.4"});
            e.preventDefault();
        }else{
            PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
            e.preventDefault();
        }
    });
    
}); 
function Ding() {
    $.get('/action/AjaxBlog.ashx?op=Ding&idBlog='+id+'&rnd=' + Math.random(), function (result) {
        if (result.status == "1") {
            $(".toast").html('<img src="/assets/css/images/z.png">已赞'+result.msg).show().addClass('toast-success')
            errorboxhide()
            $(".Zambia").html('<img src="/assets/css/images/z.png">已赞').data('up', 'off')
        }else if(result.status == -1){
                PopupShowdl(520, 305, '登录', '/utility/include/login.aspx'); StatusCheck();
        }
    });
}
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />
