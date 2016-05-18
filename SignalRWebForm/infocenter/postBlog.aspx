<%@ Page Language="C#" AutoEventWireup="true" ValidateRequest="false" CodeFile="postBlog.aspx.cs" Inherits="infocenter_postBlog" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Src="~/Controls/Erun_Right.ascx" TagPrefix="ERUN360" TagName="Erun_Right" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<link rel="stylesheet" href="/awesome/css/font-awesome.min.css">
<link rel="stylesheet" href="/froala/css/froala_editor.css">
<link rel="stylesheet" href="/froala/css/froala_style.css">
<link rel="stylesheet" href="/froala/css/plugins/code_view.css">
<link rel="stylesheet" href="/froala/css/plugins/colors.css">
<link rel="stylesheet" href="/froala/css/plugins/emoticons.css">
<link rel="stylesheet" href="/froala/css/plugins/image_manager.css">
<link rel="stylesheet" href="/froala/css/plugins/image.css">
<link rel="stylesheet" href="/froala/css/plugins/line_breaker.css">
<link rel="stylesheet" href="/froala/css/plugins/table.css">
<link rel="stylesheet" href="/froala/css/plugins/char_counter.css">
<link rel="stylesheet" href="/froala/css/plugins/video.css">
<link rel="stylesheet" href="/froala/css/plugins/fullscreen.css">
<link rel="stylesheet" href="/froala/css/plugins/file.css">
<link rel="stylesheet" href="/froala/css/themes/gray.css">
<link rel="stylesheet" href="/assets/css/codemirror.min.css">
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right postblog">
        <form id="form1">
            <input type="hidden" name="bid" id="bid" value="0">
            <input type="hidden" name="from" id="from" value="0">
            <input type="hidden" name="op" id="op" value="savebloginfo">
            <input type="text" name="title" id="title" runat="server" value="" maxlength="60" placeholder="请输入标题"/>
            <textarea name="content" id="content" runat="server" class="postblogtext" data-newbox="0" ></textarea>
            <div class="blogotherbox">
                <label for="blogtype" class="fllabel">文章分类</label>
                <select name="blogtype" id="blogtype"></select>
                <a href="javascript:void(0)" class="new-classify">+创建分类
                </a>
            </div>
            <label for="club" class="cblabel">同步到俱乐部</label>
            <div class="clublistblog"></div>
            <div class="postbuttonbox">
                <a class="postblogbutton" href="javascript:void(0)">发布</a>
                <a class="blogyl" href="javascript:void(0)">预览博文</a>
            </div>
        </form>
    </div>
</article>
<div class="addclassbox">
    <div class="deboxtitle"><i></i>文章分类</div><a class="closedebox"></a>
    <div class="deboxcont">
    <ul class="classlistth">
        <li><i>序号</i><i>分类名称</i><i>数量</i><i>操作</i></li>
    </ul>
    <ul class="classlist"></ul>
    <label>新建分类</label> <input type="text" name="addclass" id="addclass"> <a class="addclassbutton" href="javascript:void(0)">创建</a>
    </div>
</div>
<script type="text/javascript" src="/assets/js/codemirror.min.js"></script>
<script type="text/javascript" src="/assets/js/xml.min.js"></script>

<script type="text/javascript" src="/froala/js/froala_editor.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/align.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/code_beautifier.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/code_view.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/colors.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/emoticons.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/font_size.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/font_family.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/image.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/file.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/image_manager.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/line_breaker.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/link.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/lists.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/paragraph_format.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/paragraph_style.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/video.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/table.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/url.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/entities.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/char_counter.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/inline_style.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/save.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/fullscreen.min.js"></script>
<script type="text/javascript" src="/froala/js/plugins/quote.min.js"></script>
<script type="text/javascript" src="/froala/js/languages/zh_cn.js"></script>
<script type="text/javascript">
    var bid = GetQueryString('bId'),
        from = GetQueryString('from')
    $(function(){
      $('#content').froalaEditor({
        theme: 'gray',
        language: 'zh_cn',
        toolbarButtons: ["fullscreen", "bold", "italic", "underline", "strikeThrough", "fontSize", "color", "emoticons", "|", "paragraphFormat", "align", "formatOL", "formatUL", "outdent", "indent", "quote", "insertHR", "insertLink", "insertImage", "insertVideo", "insertTable", "undo", "redo", "clearFormatting", "html"],
        toolbarButtonsXS: ['undo', 'redo' , "fontSize", "color", 'bold', 'italic', 'underline',"insertLink",'insertImage'],
        key: 'ImA-65B-31eC1E2D1D5sB-7J-7=='
      }).on('froalaEditor.contentChanged', function (e, editor) {
            autosave.setdata(bid?bid:'b0',"#title","#content")
        })
    });
    $(".blogyl").click(function(event) {
        autosave.setdata(bid?bid:'b0',"#title","#content")
        window.open("/blog/0.aspx?yid="+(bid?bid:'b0'));
    });

    custom = function(){
       setTimeout(function(){location.reload() },1000) 
    }
    $(".new-classify").click(function(event) {
        $(".addclassbox,.loginboxbg").show()
    });
    jQuery(document).ready(function($) {
        $("#bid").val(bid?bid:'0')
        $("#from").val(from?from:'0')
        $.get('/action/AjaxUser.ashx?op=getuser', function(data) {
            if (data.status == 1) {
                setTimeout(function(){autosave.getval(bid?bid:'b0',"#title","#content")},1000)
                // setInterval(function(){autosave.getval(bid?bid:'b0',"#title","#content")},5000) //180000
            };
        });

        getclasslist.getclass(<%=pergroupid%>)
        getclasslist.getclub(<%=clubs%>)
        $(".closedebox,.loginboxbg").click(function(event) {
            $(".loginboxbg,.addclassbox").hide()
        });
        $(".addclassbutton").click(function(event) {
            getclasslist.addclass()
        });
        $(".classlist").on('click', '.delclassi', function(event) {
            event.preventDefault();
            var i = $(this).data('id')
                    getclasslist.delclass(i)
        });
    });
    var gp = 0
    $(".postblogbutton").click(function(event) {
        if (!$("#title").val()) {
            $("#title").focus();
            $(".toast").html('标题不能为空').show().addClass('toast-error')
            errorboxhide()
            return false
        }
        if (!$("#content").val()) {
            $(".toast").html('内容不能为空').show().addClass('toast-error')
            errorboxhide()
            return false
        };
        $.post('/action/HandlerBlog.ashx', $("#form1").serialize(), function(data, textStatus, xhr) {
            if (data.status > 1) {
                var b = bid?bid:'b0'
                autosave.cleardata(b)
                $(".toast").html(data.msg).show().addClass('toast-success')
                setTimeout(function(){window.location.href="/article/content.aspx?sid="+data.status},2000)
            }else{
                $(".toast").html(data.msg).show().addClass('toast-error')
            }
            errorboxhide()
        });
    });
</script>
<form id="form2" runat="server"></form>
<ERUN360:footerv3 runat="server" ID="footerv3" />