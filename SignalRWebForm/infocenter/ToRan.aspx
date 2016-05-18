<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ToRan.aspx.cs" Inherits="infocenter_ToRan" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<script type="text/javascript" src="/Common/jCity.js"></script>
<script src="../Common/jCheck.js"></script>
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
<link rel="stylesheet" href="/assets/css/amazeui.datetimepicker.css">
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right postblog">
        <form id="form1" >
        <input type="text" name="hdtitle" id="hdtitle" runat="server" value="" placeholder="活动名称" class="v3putbt"/>
        <input type="hidden" name="op" id="op" value="savejoininfo">
        <input type="hidden" name="bId" id="bId" value="0">
            <div class="dhlistbox torunbox">
                <div class="dhrow">
                    <div class="dhcell">
                        <label for="hdadd">活动地点:</label>
                    </div>
                    <div class="dhcell">
                        <select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)" >
                        </select>
                        <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)">
                        </select>
                        <input type="text" id="idCity" name="idCity" readonly value="0"  runat="server" >
                        <input type="text" id="cCityname" name="cCityname" readonly value=""  runat="server">
                        <input type="text" name="hdadd" id="hdadd" runat="server" value="" class="v3putbt"/>
                        <input name="UpdatedFields" type="hidden" id="UpdatedFields" value=";cCityname;idCity"  />
                    </div>
                    <div class="dhcell"></div>
                    <div class="dhcell"></div>
                </div>
                <div class="dhrow">
                    <div class="dhcell">
                        <label for="hdtype">活动类型:</label>
                    </div>
                    <div class="dhcell">
                        <select runat="server" id="hdtype" name="hdtype">
                            <option value="1">路跑</option>
                            <option value="2">越野</option>
                            <option value="3">徒步</option>
                            <option value="4">分享会</option>
                        </select>
                    </div>
                    <div class="dhcell">
                        <label for="hdtime">活动时间:</label>
                    </div>
                    <div class="dhcell">
                        <input type="text" readonly="" id="hdtime" name="hdtime" runat="server" class="datahms v3putbt" placeholder="请选择" />
                    </div>
                </div>
                <div class="dhrow">
                    <div class="dhcell">
                        <label for="hdjime">集合时间:</label>
                    </div>
                    <div class="dhcell">
                        <input id="hdjime" name="hdjime" runat="server" type="text"  placeholder="请选择"  readonly="" class="datahms v3putbt" />
                    </div>
                    <div class="dhcell">
                        <label for="hdjadd">集合地点:</label>
                    </div>
                    <div class="dhcell">
                        <input type="text" name="hdjadd" id="hdjadd" runat="server" value="" class="v3putbt" />
                        <a class="hdjmap">显示地图</a>
                        <input type="hidden" name="coordinates" id="coordinates" runat="server" value="" class="v3putbt"   />
                    </div>
                </div>
                <div class="dhrow">
                    <div class="dhcell">
                        <label for="hdatime">报名时间:</label>
                    </div>
                    <div class="dhcell">
                        <input id="hdatime" name="hdatime" runat="server" type="text" class="datahms v3putbt" placeholder="请选择"  readonly="" /> 至 <input id="hdbtime" runat="server" type="text" class="datahms v3putbt" placeholder="请选择" readonly="" />
                    </div>
                    <div class="dhcell">
                        <label for="hdpeople">人数限制:</label>
                    </div>
                    <div class="dhcell">
                        <input type="text" name="hdpeople" id="hdpeople" runat="server" value=""  />
                    </div>
                </div>
                <div class="dhrow">
                    <div class="dhcell">
                        <label for="hdqd">强度:</label>
                    </div>
                    <div class="dhcell">
                        <select id="hdqd" name="hdqd" runat="server">
                            <option value="1">高</option>
                            <option value="2">中</option>
                            <option value="3">低</option>
                        </select>
                    </div>
                    <div class="dhcell">
                        <label for="hdallkm">总里程:</label>
                    </div>
                    <div class="dhcell">
                        <input type="text" name="hdallkm" id="hdallkm" runat="server" value="" /> 公里
                    </div>
                </div>
                <div class="dhrow" id="hdjf" runat="server">
                    <div class="dhcell">
                        <label for="hdrmb">活动经费:</label>
                    </div>
                    <div class="dhcell">
                        <input type="text" name="hdrmb" id="hdrmb" runat="server" value="0" /> 元
                    </div>
                </div>
                <div class="dhrow">
                    <div class="dhcell">
                        <label for="hdts">活动特色:</label>
                    </div>
                    <div class="dhcell">
                        <select id="hdts" name="hdts" runat="server">
                            <option value="0">无福利</option>
                            <option value="1">有奖品</option>
                            <option value="2">有饭</option>
                            <option value="3">有班车</option>
                            <option value="4">有装备</option>
                            <option value="5">主题活动</option>
                            <option value="6">专业教练</option>
                        </select>
                    </div>
                    <div class="dhcell">
                        <label for="hoteleditimg">活动头图:</label>
                    </div>
                    <div class="dhcell">
                        <label for="hoteleditimg" class="upimg"></label>
                        <input type="file" class="fileupload" id="hoteleditimg" style="display:none" name="hoteleditimg">
                        <input name="hdtt" type="hidden" id="hdtt" value="" class="v3putbt" runat="server"><label for="hoteleditimg" class="upimgsize">图片大小1M以下，建议尺寸300*300</label>
                    </div>
                </div>
            </div>
            <textarea name="cContentUEditor" id="cContentUEditor" runat="server" class="v3putbt"></textarea>
            <div class="postbuttonbox">
                <a class="postblogbutton" href="javascript:void(0)">发布约跑</a>
            </div>
        </form>
    </div>
</article>
    <div style="display: none">
        <div id="tips">
        </div>
        <div id="bdmap">
            <div id="hdjmap">
            </div>
            <a href="javascript:void(0)" onclick="mapqd()" class="mapqd"></a>
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
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=B270492b31673137d9b3d5b1c8c8903a"></script>
<script type="text/javascript" src="/assets/js/amazeui.datetimepicker.min.js"></script>
<script type="text/javascript">
var d = new Date();
var td = d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate()
$('.datahms').datetimepicker('setStartDate', td);
$('#cContentUEditor').froalaEditor({
    theme: 'gray',
    language: 'zh_cn',
    toolbarButtons: ["fullscreen", "bold", "italic", "underline", "strikeThrough", "fontSize", "color", "emoticons", "|", "paragraphFormat", "align", "formatOL", "formatUL", "outdent", "indent", "quote", "insertHR", "insertLink", "insertImage", "insertVideo", "insertTable", "undo", "redo", "clearFormatting", "html"],
    key: 'ImA-65B-31eC1E2D1D5sB-7J-7=='
})
$(".fileupload").change(function(){
    var data = new FormData(),
    sthis = $(this)
    $.each(sthis[0].files, function(i, file) {
     data.append('upload_file', file);
    });
    $.ajax({
     url:'/action/fileUp.ashx?name=Filedata',
     type:'POST',
     data:data,
     cache: false,
     contentType: false,
     processData: false,
     success:function(data){
        var data = data[0]
        if(data.status == 1){
            sthis.next("input").val(data.url)
            $(".upimg").addClass('upimgright')
            $(".toast").html(data.message).show().addClass('toast-success')
                errorboxhide()

        }else{
            $(".toast").html(data.message).show().addClass('toast-error')
                errorboxhide()
        }
     }
    });
});

$(".postblogbutton").click(function(event) {
    var go = 0
    $("#form1 .v3putbt").each(function(index, el) {
        if (!$(this).val()) {
            var n = $(this).attr('name')
            switch(n)
            {
            case 'coordinates':
                $('#hdjadd').focus().click();
                $(".toast").html('请在地图上标注位置').show().addClass('toast-error')
              break;
            case 'hdtt':
                $('#hdallkm').focus().click();
                $(".toast").html('请上传活动头图').show().addClass('toast-error')
              break;
            default:
                $(this).focus().click();
                $(".toast").html('请填写完整后发布').show().addClass('toast-error')
            }
            errorboxhide()
            go = 1
            return false
        };
    });

    if (go == 0) {
        $.post('/action/HandlerJoin.ashx', $("#form1").serialize(), function(data, textStatus, xhr) {
            if (data.status > 1) {
                $(".toast").html(data.msg).show().addClass('toast-success')
                setTimeout(function(){window.location.href="/race/"+data.status+".aspx"},2000)
            }else{
                $(".toast").html(data.msg).show().addClass('toast-error')
            }
            errorboxhide()
        });
    };
});
BindProvince("北京");
var iCityid = '1',
    iAreaid = '01'
if (iCityid == "") {
    iCityid = 1
}
if (iAreaid == "") {
    iAreaid = 1
}
$("#idCity").val(101)
var iCity = parseInt(iCityid) - 1,
    iArea = parseInt(iAreaid)

$("#cCityname").val(china[iCity][0] + china[iCity][iArea])
$("#ddlProvince").val(china[iCity])
for (x in china[iCity]) {
    if (x != 0) {
        if (x == [01]) {
        $("#ddlCity").append('<option selected=\"selected\" value=' + china[iCity][x] + '>' + china[iCity][x] + '</option>')
        } else {
            $("#ddlCity").append('<option value=' + china[iCity][x] + '>' + china[iCity][x] + '</option>')
        }
    }
}








        var bdmapkey = "0",
            newzbkey = "0"
        $(".hdjmap").click(function(event) {
            $.colorbox({ inline: true,href:"#bdmap", width: "800px", height: "460px", opacity: "0.4" });
            cityname = $("#ddlProvince").val()+$("#ddlCity").val()
            if(cityname == 'null'){
                cityname = "北京"
                
            }
            if(bdmapkey == "0"){
                baidumap(cityname)
            }
        });
        function baidumap(cityname){
            var map = new BMap.Map("hdjmap");
            map.centerAndZoom(cityname,15); 
            map.enableScrollWheelZoom();
            function showInfo(e){
                if(newzbkey == "0"){
               var myIcon = new BMap.Icon("/Html/images/star.png", new BMap.Size(35, 36));
                var newzb = new BMap.Point(e.point.lng,e.point.lat);
                $("#coordinates").val(e.point.lng + ", " + e.point.lat);    
                var marker = new BMap.Marker(newzb,{icon:myIcon});
                map.addOverlay(marker);
                marker.enableDragging();    
                marker.addEventListener("dragend", function(f){    
                 $("#coordinates").val(f.point.lng + ", " + f.point.lat);    
                })
                newzbkey = "1"
                }   
            }
            map.addEventListener("click", showInfo);
            bdmapkey = "1";
        }
        function mapqd(){
            $.colorbox.close();
        }
    </script>
<ERUN360:footerv3 runat="server" ID="footerv3" />