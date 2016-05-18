<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Blog.aspx.cs" Inherits="infocenter_Blog" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Src="~/Controls/Erun_Right.ascx" TagPrefix="ERUN360" TagName="Erun_Right" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right">
        <div class="equip"><span class="equip-ous tashow" data-bind="bloglist">TA发布的</span><span data-bind="focuslist" class="equipnone">我收藏的</span></div>
        <ul class="article"></ul>
        <div class="articlemore">更多</div>
    </div>
</article>
<script type="text/javascript">
    var p = 1,
        bd = 'bloglist'
custom = function(){
    $(".article").html('')
    GetBlogList(bd,p)
    $.get('/action/AjaxUser.ashx?op=getuser', function(data) {
        if (data.msg == $.AMUI.store.get('leftuserinfo').id) {
                $(".tashow").html('我发布的')
                $(".equip").append('<a class="article-up" href="../infocenter/postBlog.aspx">发布博文</a>')
                $(".equipnone").show()
        }
    });
}
    jQuery(document).ready(function ($) {
        custom()
    });
    $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
    $(".close").click(function () {
        $(".message").hide();
    });
    $(".gzqx").click(function (event) {
        data = $(this).data('zbid')
        thismun = $(this).parent("li").index()
        $.ajax({
            url: '/action/GetBlogList.ashx',
            type: 'GET',
            dataType: 'text',
            data: { command: "qxgz", b: data },
            success: function (data) {
                if (data == "1") {
                    $("#UpdatePanel1 li").eq(thismun).remove()
                }
            }
        });
    });
    $(".articlemore").click(function(event) {
        p++
        GetBlogList(bd,p)
    });
    $(".equip span").click(function () {
        $(".article").html('')
        p = 1
        $(this).addClass("equip-ous").siblings().removeClass('equip-ous')
        bd = $(this).data("bind")
        GetBlogList(bd,p)
    })
    function GetBlogList(b,p){
    $.AMUI.progress.start();
        $.get('/action/AjaxBlog.ashx?op='+b+'&type=0&uid='+id+'&p='+p, function(data) {
            if (data.length == 0) {
                $(".articlemore").html('没有更多内容')
            };
            var d = ''
            $.each(data, function(index, val) {
                var t = '',
                    edit = ''
                if (b == 'bloglist') {
                    edit = val.status == 0?'':' <a href="/infocenter/postBlog.aspx?bId='+val.id+'">编辑</a> <a href="javascript:void(0)" data-id="'+val.id+'" class="delbolg">删除</a>'
                }else{
                    edit = val.status == 0?'':' <a href="javascript:void(0)" data-id="'+val.id+'" class="delbolg">取消收藏</a>'
                }
                    
                $.each(val.cThumbUrl, function(index, val) {
                     t+= '<a><img src="'+val.cImageUrl+'"></a>'
                });

                d+='<li><a href="/blog/'+val.id+'.aspx" class="title" target="_blank">'+val.cTitle+'</a> <span>'+val.dCreate+'</span>'+edit+'<p>'+val.cContent+'</p><div class="atriclelistthumb">'+t+'</div><div class="article-bot"><span>阅读('+val.show.iShowTimes+') 收藏('+val.show.iFocus+') 赞('+val.show.iDing+') 评论('+val.show.iDiscuss+') </span></div></li>'
            });
            if (p == 1) {
                $(".article").html(d).find('.delbolg').click(function(event) {
                    var id = $(this).data('id')
                    delblog(id)
                }).end().exthumb();
            }else{
                $(".article").append(d).find('.delbolg').click(function(event) {
                    delblog(id)
                }).end().exthumb();
            }
        $.AMUI.progress.done();
        });
    }
    function delblog(id){
        if (bd == 'bloglist') {
            var tip = '确定删除此文章？',
                operation = '删除',
                op = 'DeleteBlog'
        }else{
            var tip = '取消收藏此文章？',
                operation = '取消收藏',
                op = 'qxgz'
        }
         if(confirm(tip)){
            $.get('/action/AjaxBlog.ashx?op='+op+'&bId='+id, function(data) {
                if (data.status == -1) {
                    //weidenglu
                }else if(data.status == 1){
                    $(".toast").html(operation+'成功').show().addClass('toast-success')
                    errorboxhide()
                    p = 1
                    GetBlogList(bd,p)

                }else{
                    $(".toast").html(operation+'失败').show().addClass('toast-error')
                    errorboxhide()
                }
            });
             }
        
    }
    jQuery.fn.exthumb = function() {
        this.find('img').each(function(index, el) {
                $(this).load(function() {
            var w = this.width
                h = this.height
            if (w > h) {
                $(this).css({
                    width: 'auto',
                    height: '100%'
                });
            }else{
                $(this).css({
                    width: '100%',
                    height: 'auto'
                });
            }

                });
            
        });
    }
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />