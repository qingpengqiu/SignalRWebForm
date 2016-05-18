<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PostEvent.aspx.cs" Inherits="infocenter_PostEvent" %>
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

<script type="text/javascript" src="/Common/jCity.js"></script>
<script src="/Common/jCheck.js"></script>
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <style type="text/css">
.postsaishi{}
.postsaishi .tr .td:first-child{width: 12%;text-align: right;}
.postsaishi .tr .td{padding:4px 0 ;}
.to-run{padding-top: 0;}
.postblog #title{padding-left: 0;}
.temx img{width: 100%;}
.temx input[type="radio"]{display: none;}
.temx label{border: 1px solid #fff;float: left;width: 32%;margin-right: 1%;}
.temx .this{border: 1px solid red}
    </style>
    <div class="main-right postblog">
        <form id="form1" runat="server">
            <div class="blog-top">发赛事</div>
            <div class="to-run">
                <div class="table postsaishi">
                    <div class="tr">
                        <div class="td"></div>
                        <div class="td">
                            <input type="text" runat="server" name="title" id="title" value="" placeholder="赛事名称"/>
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">国内/国际：</div>
                        <div class="td">
                            <select id="iType" name="iType" runat="server">
                                <option value="1">国内</option>
                                <option value="2">国际</option>
                                <option value="3">港澳台</option>
                            </select>
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">竞赛类型：</div>
                        <div class="td">
                            <select id="idCompeteStyle" name="idCompeteStyle" runat="server">
                                <option value="0">U超级马拉松</option>
                                <option value="1">M全程马拉松</option>
                                <option value="2">H半程马拉松</option>
                                <option value="3">R路跑</option>
                                <option value="4">C越野跑</option>
                                <option value="5">T其它</option>
                            </select>
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">所在城市：</div>
                        <div class="td">
                            <select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)" runat="server">
                            </select>
                            -
                            <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)" runat="server">
                            </select>
                            <script type="text/javascript">
                                BindProvince("北京");
                            </script>

                            <input type="text" id="idCity" name="idCity"  readonly value="0" runat="server">
                            <input type="text" id="cCityname" name="cCityname" readonly runat="server">
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">赛事时间：</div>
                        <div class="td">
                            <input id="dRaceBegin" runat="server" name="dRaceBegin" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'%y-%M-#{%d}'})" />
                            - 
                            <input id="dRaceEnd" runat="server" name="dRaceEnd" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'%y-%M-#{%d}'})" />
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">报名时间：</div>
                        <div class="td">
                           <input id="dJoinBegin" runat="server" name="dJoinBegin" class="Wdate input-large" type="text" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm'})" />
                            - 
                            <input id="dJoinEnd" runat="server" name="dJoinEnd" class="Wdate input-large" type="text"  onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm'})" />
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">赛事头图：</div>
                        <div class="td temx">
                            <%=tempModel.ToString() %>
                            <asp:HiddenField ID="radiotemp" runat="server" Value="../Images/toutu/tu1.jpg" />
                            <asp:FileUpload ID="hdtt" runat="server" />
                            <asp:Label ID="lbtt" runat="server" Text="" Enabled="false" Visible="False"></asp:Label>
                            图片大小1M以下，建议分辨率1200*256
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">焦点图：</div>
                        <div class="td">
                            <asp:FileUpload ID="jdt" runat="server" class="input-large"/><asp:Label ID="jdtdz" runat="server" Text="" Enabled="false" Visible="False"></asp:Label><a id="jd" target=_blank runat="server"><img width="20" height="20" src="<%=jdtt %>" /></a>图片大小1M以下，建议分辨率636*386
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">发布类型：</div>
                        <div class="td">
                            <select id="iStatus" name="iStatus" runat="server" >
                                <option value="0">草稿</option>
                                <option value="1">发布</option>
                            </select>
                        </div>
                    </div>
                </div>
<textarea name="content" id="cContentUEditor" runat="server" class="postblogtext" data-newbox="0" ></textarea>
<input type="hidden" runat="server" id="UpdatedFields" name="UpdatedFields" value="">
<asp:ImageButton ID="imgbtCompetetion" runat="server" ImageUrl="~/Html/images/save.png" OnClick="imgbtCompetetion_Click" />
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
    var bid = GetQueryString('bId')
    $(function(){
      $('#cContentUEditor').froalaEditor({
        theme: 'gray',
        language: 'zh_cn',
        toolbarButtons: ["fullscreen", "bold", "italic", "underline", "strikeThrough", "fontSize", "color", "emoticons", "|", "paragraphFormat", "align", "formatOL", "formatUL", "outdent", "indent", "quote", "insertHR", "insertLink", "insertImage", "insertVideo", "insertTable", "undo", "redo", "clearFormatting", "html"],
        key: 'ImA-65B-31eC1E2D1D5sB-7J-7=='
      }).on('froalaEditor.contentChanged', function (e, editor) {
            autosave.setdata(bid?bid:'b0',"#title","#cContentUEditor")
        })
    });
    jQuery(document).ready(function ($) {
        $(".close").click(function () {
            $(".message").hide();
        });
    });
    $(".uicon img").click(function (event) {
        $(".uicon img").removeAttr('style')

        $(this).css({
            border: '3px solid #9bd116',
            margin: '-3px 3px -3px -3px',
            opacity: '1'
        });
        $("#cAvatar").val($(this).data('icon'))
    });
    $(".newicon").colorbox({ inline: true, href: "#thumb", width: "641px", height: "504px", opacity: "0.4" });
    $(".new-classify").colorbox({ iframe: true, width: "647px", height: "423px" });
    $(".temx input[name=temp]").change(function (event) {
        $(this).parent('label').addClass('this').siblings('label').removeClass('this')
        $("#radiotemp").val($(this).val())
    });
    function tips(msg, url, imgname) {
        var img = "<img src=\"\/Html\/images\/" + imgname + "\.png\">"
        $("#tips").append(img).append(msg);


        $.colorbox({ inline: true, width: "50%", href: "#tips", width: "254px", height: "141px", opacity: "0.4" });
        var url = url;
        if (url == "") {
            setTimeout("$.colorbox.close();", 5000)

        } else {
            setTimeout("location.href = \"" + url + "\"", 3000)
        }

    }
    $(".tshirt").colorbox({ rel: 'tshirt' });
    var cityn = <% =iCity %>
    iCity = parseInt(cityn?cityn:1) - 1
	_province = china[iCity][0];
    $("#ddlProvince").val(china[iCity])
    for (x in china[iCity]) {
        if (x != 0) {
            if (x == [<% =iArea  %>]) {
                $("#ddlCity").append('<option selected=\"selected\" value=' + china[iCity][x] + '>' + china[iCity][x] + '</option>')
            } else {
                $("#ddlCity").append('<option value=' + china[iCity][x] + '>' + china[iCity][x] + '</option>')
            }
        }
    }
    var bdmapkey = "0",
        newzbkey = "0"
    $(".hdjmap").click(function (event) {
        $.colorbox({ inline: true, href: "#bdmap", width: "800px", height: "460px", opacity: "0.4" });
        cityname = $("#ddlProvince").val() + $("#ddlCity").val()
        if (cityname) {
            cityname = "北京"
        }
        if (bdmapkey == "0") {
            baidumap(cityname)
        }
    });
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />