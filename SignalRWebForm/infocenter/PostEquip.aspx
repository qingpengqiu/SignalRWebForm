<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PostEquip.aspx.cs" Inherits="infocenter_PostEquip" %>
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
    <div class="main-right">
        <div class="blog postblog">
        <form id="form1">
            <input type="hidden" name="bid" id="bid" value="0">
            <input type="hidden" name="op" id="op" value="saveequipinfo">
            <input type="text" name="title" id="title" runat="server" value="" maxlength="60" placeholder="装备名称"/>
                <div class="equipotherbox">
                    <label for="group">分类：</label>
<select name="group" id="group">
    <option value="201000000">鞋</option>
    <option value="201100000">田径短跑</option>
    <option value="201101000">田径赛道</option>
    <option value="201102000">公路跑</option>
    <option value="201103000">越野跑</option>
    <option value="202000000">服装</option>
    <option value="202100000">无袖·背心</option>
    <option value="202101000">短袖</option>
    <option value="202102000">长袖</option>
    <option value="202103000">短裤</option>
    <option value="202104000">裤子·紧身裤</option>
    <option value="202105000">夹克·马甲</option>
    <option value="202106000">内衣</option>
    <option value="202107000">袜子·鞋套</option>
    <option value="202108000">压缩·恢复</option>
    <option value="203000000">配件</option>
    <option value="203100000">电子产品</option>
    <option value="203100100">GPS</option>
    <option value="203100101">心率</option>
    <option value="203100102">手表</option>
    <option value="203101000">补剂</option>
    <option value="203101100">能量胶·嚼片</option>
    <option value="203101101">饮品·补液</option>
    <option value="203101102">能量棒</option>
    <option value="203102000">袖套·腿套</option>
    <option value="203103000">腰带·腰包</option>
    <option value="203104000">书·DVD</option>
    <option value="203105000">手套</option>
    <option value="203106000">帽子·头饰</option>
    <option value="203107000">饮水系统</option>
    <option value="203108000">反光·照明</option>
    <option value="203109000">保护治疗</option>
    <option value="203110000">鞋垫</option>
    <option value="203111000">运动包</option>
    <option value="203112000">太阳镜</option>

</select>
                    <label for="brand">品牌：</label>
<select name="brand" id="brand" >
    <option value="600201000">ASICS 亚瑟士</option>
    <option value="600202000">ADIDAS 阿迪达斯</option>
    <option value="600203000">BROOKS 布鲁克斯</option>
    <option value="600204000">CAMELBAK 驼峰</option>
    <option value="600205000">COLOMBIA 哥伦比亚</option>
    <option value="600206000">CW-X</option>
    <option value="600207000">ECCO 爱步</option>
    <option value="600208000">GARMIN 高明</option>
    <option value="600209000">INOV-8</option>
    <option value="600210000">JACK WOLFSKIN 狼爪</option>
    <option value="600211000">LA SPORTIVIA</option>
    <option value="600212000">LAFUMA 乐飞叶</option>
    <option value="600213000">MIZUNO 美津浓</option>
    <option value="600214000">MONTRAIL</option>
    <option value="600215000">MOUNTAINHARDWARE 山浩</option>
    <option value="600216000">NATHAN</option>
    <option value="600217000">NIKE 耐克</option>
    <option value="600218000">NEW BALANCE 新百伦</option>
    <option value="600219000">NEWTON</option>
    <option value="600220000">OAKLEY 奥克利</option>
    <option value="600221000">PEARL IZUMI</option>
    <option value="600222000">REEBOK 锐步</option>
    <option value="600223000">RUDY PROJECT 卤迪</option>
    <option value="600224000">SALOMON 萨洛蒙</option>
    <option value="600225000">SAUCONY 索康尼</option>
    <option value="600226000">SKECHERS 斯凯奇</option>
    <option value="600227000">SKINS 思金思</option>
    <option value="600228000">SUUNTO 松拓</option>
    <option value="600229000">TECNICA 泰尼卡</option>
    <option value="600230000">TIMEX 天美时</option>
    <option value="600231000">THE NORTH FACE 北面</option>
    <option value="600232000">UNDER ARMOUR 安德玛</option>
    <option value="600233000">VFF 巍跋然</option>
    <option value="600234000">X-BIONIC</option>
    <option value="600235000">ZOOT</option>
    <option value="600236000">2XU</option>
    <option value="600237000">THREE RUNNERS 仕理兰</option>
    <option value="600238000">DECATHLON 迪卡侬</option>
    <option value="600239000">DOWIN 多威</option>
    <option value="600299000">其他</option>

</select>
                    <label for="buytime">购买时间：</label>
                    <input type="text" id="buytime" name="buytime" runat="server" placeholder="请选择"  readonly /><label for="price">价格：</label>
                    <input type="text" name="title" id="price" runat="server" /> 元
                </div>
            <textarea name="content" id="content" runat="server" class="postblogtext"></textarea>
    <div class="postbuttonbox">
        <a class="postblogbutton" href="javascript:void(0)">发布</a>
    </div>
        </div>
        </form>
    </div>
</article>
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
        frome = GetQueryString('frome')
    $(function(){
      $('#content').froalaEditor({
        theme: 'gray',
        language: 'zh_cn',
        toolbarButtons: ["fullscreen", "bold", "italic", "underline", "strikeThrough", "fontSize", "color", "emoticons", "|", "paragraphFormat", "align", "formatOL", "formatUL", "outdent", "indent", "quote", "insertHR", "insertLink", "insertImage", "insertVideo", "insertTable", "undo", "redo", "clearFormatting", "html"],
        key: 'ImA-65B-31eC1E2D1D5sB-7J-7=='
      }).on('froalaEditor.contentChanged', function (e, editor) {
            autosave.setdata(bid?bid:'z0',"#title","#content")
        })
    });
    custom = function(){
       setTimeout(function(){location.reload() },1000) 
    }
$(function() {
var nowTemp = new Date();
var nowDay = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0).valueOf();
var nowMoth = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), 1, 0, 0, 0, 0).valueOf();
var nowYear = new Date(nowTemp.getFullYear(), 0, 1, 0, 0, 0, 0).valueOf();
var $myStart2 = $('#buytime');

var checkin = $myStart2.datepicker({
  onRender: function(date, viewMode) {
    // 默认 days 视图，与当前日期比较
    var viewDate = nowDay;

    switch (viewMode) {
      // moths 视图，与当前月份比较
      case 1:
        viewDate = nowMoth;
        break;
      // years 视图，与当前年份比较
      case 2:
        viewDate = nowYear;
        break;
    }

    return date.valueOf() > viewDate ? 'am-disabled' : '';
  }
})
});
$("#price").keyup(function(event) {
    $(this).val($(this).val().replace(/\D/gi,""))
});
    jQuery(document).ready(function($) {
        $("#bid").val(bid?bid:0)
        $.get('/action/AjaxUser.ashx?op=getuser', function(data) {
            if (data.status == 1) {
                setTimeout(function(){autosave.getval(bid?bid:'z0',"#title","#content")},1000)
                // setInterval(function(){autosave.getval(bid?bid:'b0',"#title","#content")},5000) //180000
            };
        });
    });
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
        $.post('/action/HandlerEquip.ashx', $("#form1").serialize(), function(data, textStatus, xhr) {
            if (data.status > 1) {
                var b = bid?bid:'z0'
                autosave.cleardata(b)
                $(".toast").html(data.msg).show().addClass('toast-success')
                if (frome == 'trained') {
                setTimeout(function(){window.location.href="/infocenter/Trained.aspx"},2000)

                }else{
                    setTimeout(function(){window.location.href="/article/equipcontent.aspx?sid="+data.status},2000)
                }
            }else{
                $(".toast").html(data.msg).show().addClass('toast-error')
            }
            errorboxhide()
        });
    });
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />