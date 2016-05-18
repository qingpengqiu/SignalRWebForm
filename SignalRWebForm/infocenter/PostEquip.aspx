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
            <input type="text" name="title" id="title" runat="server" value="" maxlength="60" placeholder="װ������"/>
                <div class="equipotherbox">
                    <label for="group">���ࣺ</label>
<select name="group" id="group">
    <option value="201000000">Ь</option>
    <option value="201100000">�ﾶ����</option>
    <option value="201101000">�ﾶ����</option>
    <option value="201102000">��·��</option>
    <option value="201103000">ԽҰ��</option>
    <option value="202000000">��װ</option>
    <option value="202100000">���䡤����</option>
    <option value="202101000">����</option>
    <option value="202102000">����</option>
    <option value="202103000">�̿�</option>
    <option value="202104000">���ӡ������</option>
    <option value="202105000">�пˡ����</option>
    <option value="202106000">����</option>
    <option value="202107000">���ӡ�Ь��</option>
    <option value="202108000">ѹ�����ָ�</option>
    <option value="203000000">���</option>
    <option value="203100000">���Ӳ�Ʒ</option>
    <option value="203100100">GPS</option>
    <option value="203100101">����</option>
    <option value="203100102">�ֱ�</option>
    <option value="203101000">����</option>
    <option value="203101100">����������Ƭ</option>
    <option value="203101101">��Ʒ����Һ</option>
    <option value="203101102">������</option>
    <option value="203102000">���ס�����</option>
    <option value="203103000">����������</option>
    <option value="203104000">�顤DVD</option>
    <option value="203105000">����</option>
    <option value="203106000">ñ�ӡ�ͷ��</option>
    <option value="203107000">��ˮϵͳ</option>
    <option value="203108000">���⡤����</option>
    <option value="203109000">��������</option>
    <option value="203110000">Ь��</option>
    <option value="203111000">�˶���</option>
    <option value="203112000">̫����</option>

</select>
                    <label for="brand">Ʒ�ƣ�</label>
<select name="brand" id="brand" >
    <option value="600201000">ASICS ��ɪʿ</option>
    <option value="600202000">ADIDAS ���ϴ�˹</option>
    <option value="600203000">BROOKS ��³��˹</option>
    <option value="600204000">CAMELBAK �շ�</option>
    <option value="600205000">COLOMBIA ���ױ���</option>
    <option value="600206000">CW-X</option>
    <option value="600207000">ECCO ����</option>
    <option value="600208000">GARMIN ����</option>
    <option value="600209000">INOV-8</option>
    <option value="600210000">JACK WOLFSKIN ��צ</option>
    <option value="600211000">LA SPORTIVIA</option>
    <option value="600212000">LAFUMA �ַ�Ҷ</option>
    <option value="600213000">MIZUNO ����Ũ</option>
    <option value="600214000">MONTRAIL</option>
    <option value="600215000">MOUNTAINHARDWARE ɽ��</option>
    <option value="600216000">NATHAN</option>
    <option value="600217000">NIKE �Ϳ�</option>
    <option value="600218000">NEW BALANCE �°���</option>
    <option value="600219000">NEWTON</option>
    <option value="600220000">OAKLEY �¿���</option>
    <option value="600221000">PEARL IZUMI</option>
    <option value="600222000">REEBOK ��</option>
    <option value="600223000">RUDY PROJECT ±��</option>
    <option value="600224000">SALOMON ������</option>
    <option value="600225000">SAUCONY ������</option>
    <option value="600226000">SKECHERS ˹����</option>
    <option value="600227000">SKINS ˼��˼</option>
    <option value="600228000">SUUNTO ����</option>
    <option value="600229000">TECNICA ̩�Ῠ</option>
    <option value="600230000">TIMEX ����ʱ</option>
    <option value="600231000">THE NORTH FACE ����</option>
    <option value="600232000">UNDER ARMOUR ������</option>
    <option value="600233000">VFF Ρ��Ȼ</option>
    <option value="600234000">X-BIONIC</option>
    <option value="600235000">ZOOT</option>
    <option value="600236000">2XU</option>
    <option value="600237000">THREE RUNNERS ������</option>
    <option value="600238000">DECATHLON �Ͽ�ٯ</option>
    <option value="600239000">DOWIN ����</option>
    <option value="600299000">����</option>

</select>
                    <label for="buytime">����ʱ�䣺</label>
                    <input type="text" id="buytime" name="buytime" runat="server" placeholder="��ѡ��"  readonly /><label for="price">�۸�</label>
                    <input type="text" name="title" id="price" runat="server" /> Ԫ
                </div>
            <textarea name="content" id="content" runat="server" class="postblogtext"></textarea>
    <div class="postbuttonbox">
        <a class="postblogbutton" href="javascript:void(0)">����</a>
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
    // Ĭ�� days ��ͼ���뵱ǰ���ڱȽ�
    var viewDate = nowDay;

    switch (viewMode) {
      // moths ��ͼ���뵱ǰ�·ݱȽ�
      case 1:
        viewDate = nowMoth;
        break;
      // years ��ͼ���뵱ǰ��ݱȽ�
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
            $(".toast").html('���ⲻ��Ϊ��').show().addClass('toast-error')
            errorboxhide()
            return false
        }
        if (!$("#content").val()) {
            $(".toast").html('���ݲ���Ϊ��').show().addClass('toast-error')
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