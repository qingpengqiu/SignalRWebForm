<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Trained.aspx.cs" Inherits="infocenter_Trained" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
<script type="text/javascript" src="/Html/js/jquery.maskedinput.js"></script>
<script type="text/javascript" src="/Html/js/echarts.js" charset="UTF-8"></script>
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
    <div class="main-right">
        <div class="equip">
            <span class="equip-ous tashow">TA��ѵ����¼<em></em></span>
            <span class="basechart">ͳ��<em></em></span>
            <span class="guiji">����APP��¼<em></em></span>
        </div>
        <div class="blog  results ">
        <form id="form1" class="posttrainbox">
            <div class="release-training">�����ҵ�ѵ���ɼ�</div>
            <div class="post-results">
                <label for="date" class="flabel">����</label>
                <input type="hidden" name="op" value="AddTrain">
                <input type="text" id="date" name="date" class=" traindata" placeholder="��ѡ��"  readonly/>
                <label for="my-run">������</label>
                <select id="idRoadStyle" name="idRoadStyle" >
                    <option value="0" selected>��԰</option>
                    <option value="1">�ﾶ��</option>
                    <option value="2">��·</option>
                    <option value="3">ɽ·</option>
                    <option value="4">�ܲ���</option>
                    <option value="5">����</option>
                </select>
                <input type="text" name="iDistance" id="iDistance" size="6" maxlength="6" value="" />
                <label>����(С��500����)</label><div class="hr"></div>
                <label for="time" class="flabel">��ʱ</label>
                <input type="text" class="input-medium" placeholder="ѡ��ʱ��" id="roadtime" name="roadtime" readonly>
                <div class="hr"></div>
                <label class="flabel">װ��</label><div class="trainzblist"><a href="../infocenter/PostEquip.aspx?frome=trained">[�����װ��]</a></div>
                <div class="hr"></div>
                <label class="flabel">�ĵ�</label>
                <textarea name="cMemo" id="cMemo" maxlength="128" rows="3">˵�����</textarea>
                <div class="hr"></div>
                <label class="flabel" for="hoteleditimg">��ͼ������</label>
                <label for="hoteleditimg" class="upimg"></label>
                <input type="file" class="input-large fileupload" id="hoteleditimg" style="display:none">
                <input name="avatarurl" type="hidden" id="avatarurl" value=""><label for="hoteleditimg" class="upimgsize">��ȷ��ʽΪjpg/gif/bmp/png</label>
                <a class="postTrain" href="javascript:void(0)">�ύ</a>
            </form>
            </div>
            <div class="TrainedList logintrain">
                <div class="TrainedListTh">
                    <div>ʱ��</div>
                    <div>��·</div>
                    <div>����</div>
                    <div>��ʱ</div>
                    <div>�ٶ�</div>
                    <div>װ��</div>
                    <div>�ĵ�</div>
                    <div>��ͼ������</div>
                    <div  class="traindel">����</div>
                </div>
                <div class="TrainedListTbody">
                </div>
                <div class="TrainedListPage" data-next="0">
                    ����
                </div>
            </div>
        </div>
        <div class="blog infonone account statistics">
            <div class="chartx">
                �����ڲ鿴��<a href="javascript:void(0)" class="thisch">��</a><em>|</em><a href="javascript:void(0)">��</a>
            </div>
            <div id="Newchart"></div>
            <div id="chaetmonth" style="display: none"></div>
        </div>
        <div class="blog  infonone gjbox">
            <a class="gjmore">�鿴����</a>
        </div>
        </div>
    </article>
<div class="defaultbg" onclick="closegj()"></div>
<div class="gjmapbox">
    <i class="closegj" onclick="closegj()"></i>
    <div id="map" class="gjmap"></div>
    <div class="gjinfo">
        <h4>2016�й���������Զ��Ϲ�ӵ������ճ�������</h4>
        <b>2016-11-19</b> <br>
        <em class="g-lc">��̣�<i>4.25km</i></em><em class="g-time">��ʱ��<i>03:23:05</i></em><em class="g-su">ƽ���ٶȣ�<i>4.5km/h</i></em><em class="g-ka">��·�<i>1323kcal</i></em>
        <ul></ul>
    </div>
</div>
<div class="insertPace"></div>
<script language="javascript" src="http://webapi.amap.com/maps?v=1.3&key=e8496e8ac4b0f01100b98da5bde96597"></script>
<script type="text/javascript">
var p = 1;
var gp = 1;
var myChart1 = echarts.init(document.getElementById('Newchart'));
var myChart2 = echarts.init(document.getElementById('chaetmonth'));
var option1 = {
    title: {
        x: 'center',
        text: 'ѵ���ɼ� ��'
    },
    tooltip: {
        trigger: 'item'
    },
    toolbox: {
        show: true,
        feature: {
            dataView: {show: false},
            restore: {show: true},
            saveAsImage: {show: true}
        }
    },
    calculable: true,
    grid: {
        borderWidth: 0,
        y: 80,
        y2: 60
    },
    xAxis: [
        {
            type: 'category',
            show: false,
            data: ['ǰ11��','ǰ10��','ǰ9��','ǰ8��','ǰ7��','ǰ6��','ǰ5��','ǰ4��','ǰ3��','ǰ2��','����','����']
        }
    ],
    yAxis: [
        {
            type: 'value',
            show: false
        }
    ],
    series: [
        {
            name: 'ѵ��ͳ��',
            type: 'bar',
            itemStyle: {
                normal: {
                    color: function(params) {
                        var colorList = [
                          '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
                        ];
                        return colorList[params.dataIndex]
                    },
                    label: {
                        show: true,
                        position: 'top',
                        formatter: '{b}\n{c}km'
                    }
                }
            },
            data: <%=NewCharts%>
        }
    ]
};
var option2 = {
    title: {
        x: 'center',
        text: 'ѵ���ɼ� ��'
    },
    tooltip: {
        trigger: 'item'
    },
    toolbox: {
        show: true,
        feature: {
            dataView: {show: false},
            restore: {show: true},
            saveAsImage: {show: true}
        }
    },
    calculable: true,
    grid: {
        borderWidth: 0,
        y: 80,
        y2: 60
    },
    xAxis: [
        {
            type: 'category',
            show: false,
            data: <%=NewMonth%>
        }
    ],
    yAxis: [
        {
            type: 'value',
            show: false
        }
    ],
    series: [
        {
            name: 'ѵ��ͳ��',
            type: 'bar',
            itemStyle: {
                normal: {
                    color: function(params) {
                        var colorList = [
                          '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',
                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',
                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'
                        ];
                        return colorList[params.dataIndex]
                    },
                    label: {
                        show: true,
                        position: 'top',
                        formatter: '{b}\n{c}km'
                    }
                }
            },
            data: <%=NewMonthCharts%>
        }
    ]
};
myChart1.setOption(option1);
myChart2.setOption(option2);
// $("#roadtime").mask("99:99:99");
$(function() {
var nowTemp = new Date();
var nowDay = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0).valueOf();
var nowMoth = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), 1, 0, 0, 0, 0).valueOf();
var nowYear = new Date(nowTemp.getFullYear(), 0, 1, 0, 0, 0, 0).valueOf();
var $myStart2 = $('#date');

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
$(".TrainedListPage").click(function(event) {
    var n = $(this).data('next')
        if (n == 0) {
            p++
            gettrain(p)
        }
});
$(".postTrain").click(function(event) {
    var go = 0
    $("#form1 input[type=text],#form1 textarea").each(function(index, el) {
        if (!$(this).val()) {
            $(".toast").html('����').show().addClass('toast-error')
            errorboxhide()
            $(this).focus().click();
            go = 1
            return false
        };
    });
    if (go == 0) {
    $.post('/action/ajaxtrained.ashx',$("#form1").serialize(), function(d, textStatus, xhr) {
        if (d.status == "1") {
            $(".toast").html('�ύ�ɹ�').show().addClass('toast-success')
        }else {
            $(".toast").html('�ύʧ��').show().addClass('toast-error')
        }
        $(".TrainedListTbody").html('')
        gettrain(1)
        $("#form1")[0].reset()
        errorboxhide()
    });
    };
});
jQuery(document).ready(function ($) {
    gettrain(1)
    $(".chartx a").click(function () {
        var catindex = $(this).index(".chartx a");
        $(".chartx a").css("color", "#999");
        $(this).css("color", "#ff9211");
        if (catindex == "1") {
            $("#chaetmonth").show();
            $("#Newchart").hide();
        } else {
            $("#Newchart").show();
            $("#chaetmonth").hide();
        }
    })
    $(".equip span").click(function () {
        var a = $(this).index();
        $(this).addClass("equip-ous").siblings().removeClass('equip-ous')
        $("article .blog").hide();
        $("article .blog").eq(a).show();
    });
    $.get('/action/AjaxUser.ashx?op=getuser', function(data) {
        if (data.msg == $.AMUI.store.get('leftuserinfo').id) {
            getzblist ()
            $(".tashow").html('�ҵ�ѵ����¼')
            $(".posttrainbox").show()
            $(".TrainedList").removeClass('logintrain')
            $(".basechart").show()
            $(".guiji").show()
        };
    });
    getgjdata(gp)
    $(".TrainedList").on('click', '.xlupimg', function(event) {
        event.preventDefault();
        console.log(11)
    });
});
function getgjdata(p){
    $.get('/action/HandlerTrain.ashx?op=GetPageData&p='+p, function(data) {
        if (data.status == 1) {
            var gjlist = '';
            $(".gjtitle em:nth-child(1) i").html(data.msg.totalNum)
            $(".gjtitle em:nth-child(2) i").html(data.msg.competitionNum)
            $(".gjtitle em:nth-child(3) i").html(data.msg.totalSecs)
            $(".gjtitle em:nth-child(4) i").html(data.msg.totalDistance)
            $(".gjtitle em:nth-child(5) i").html(data.msg.avgDistance)
            for (var i = 0; i < data.msg.items.length; i++) {
                var icon = data.msg.items[i].type == 1?'gjsai':'gjlian'
                gjlist+='<div class="gjli '+ icon +'"><h4>'+data.msg.items[i].eventname+'</h4>'+data.msg.items[i].starttime+'<p><em>��̣�<i>'+data.msg.items[i].distance+'</i></em><em>��ʱ��<i>'+data.msg.items[i].time+'</i></em><em>ƽ���ٶȣ�<i>'+data.msg.items[i].avgspeed+'</i></em><em>��·�<i>'+data.msg.items[i].calorie+'</i></em></p><button class="lookgj" onclick="showgj('+ data.msg.items[i].recordId +')">�鿴�켣</button></div>'
            };
            $(".gjmore").before(gjlist);
        };
    });
}
$(".gjmore").click(function(event) {
    gp++
    getgjdata(gp)
});
function getzblist () {
    $.get('/action/HandlerBlog.ashx?op=articlelist&type=5&uid='+id, function(data) {
        var zblist = ''
        if (data.length > 0) {
            $.each(data, function(index, val) {
                zblist += '<label><input type="checkbox" name="zblist" value="'+val.id+'|'+val.cTitle+'"> '+val.cTitle+'</label>'
            });
        }else{
            zblist = '��û��װ������'
        }
        $(".trainzblist").prepend(zblist)
    });
}
function gettrain (p) {
    $.AMUI.progress.start();
    $.get('/action/ajaxtrained.ashx?op=GetTrain&uid='+id+'&p='+p, function(data) {
            var trlist = ''
        if (data.length > 0 ) {
            $.each(data, function(index, val) {
                var zb = val.Equipment?'Trainzbh':''
                var xd = val.Memo?'Trainxdh':''
                var img = val.img?'<a href="'+val.img+'" target="_blank"><img src="'+val.img+'"></a>':'<a class="xlupimg" href="javascript:void(0)">�ϴ�</a>'
                var del = val.idRoadStyle > 5?'<a href="javascript:void(0)" onclick="showgj('+val.idRoadStyle+')" data-id="">�鿴</a>':'<a href="javascript:void(0)" onclick="RcDelete('+val.id+')">ɾ��</a>'
                trlist += '<div class="TrainedListTr"><div>'+val.Time+'</div><div>'+val.RoadStyle+'</div><div>'+val.Distance+'</div><div>'+val.RunTime+'</div><div>'+val.speed+'</div><div class="Trainzb '+zb+'"><i>'+val.Equipment.replace(/\|/g,"<br>")+'</i></div><div class="Trainxd '+xd+'"><i>'+val.Memo+'</i></div><div>'+img+'</div><div class="traindel">'+del+'</div></div>'
            });
            $(".TrainedListTbody").append(trlist)
        }else{
            $(".TrainedListPage").data('next', '1').html('û�и����¼')
        }
        $.AMUI.progress.done();
    });
}

function showgj(id){
    var top = document.body.scrollTop
    $(".gjmapbox").css('top', top+32+'px');
    console.log(top)
    $(".gjmapbox,.defaultbg").show()
    $.get('/action/HandlerTrain.ashx?op=GetTrainById&Id='+id, function(data) {
        if (data) {
            var pslist = ''
            var map = new AMap.Map('map', {
                resizeEnable: true,
                center: [data.items[0].lon, data.items[0].lat],
                zoom: 13
            });
            var lineArr = new Array()
            for (var i = 0; i < data.items.length; i++) {
                if (/^[0-9]*[1-9][0-9]*$/.test(data.items[i].distance)) {
                    marker = new AMap.Marker({
                        map:map,
                        position:[data.items[i].lon,data.items[i].lat],
                        offset:new AMap.Pixel(-5,-10), 
                        content: '<div class="tag_circle">'+data.items[i].distance+'</div>',
                        autoRotation:true
                    });
                    pslist+='<li><span>'+data.items[i].distance+'</span><span>'+data.items[i].speed+'</span><span>'+data.items[i].time+'</span><span>'+format(new Date(parseInt(data.items[i].timestamp)))+'</span></li>'
                };
                lineArr.push(new Array(data.items[i].lon,data.items[i].lat))
            };
            new AMap.Marker({
                map:map,
                position:[data.items[0].lon,data.items[0].lat],
                offset:new AMap.Pixel(-18,-46), 
                content: '<div class="map_start"></div>',
                autoRotation:true
            });
            var polyline = new AMap.Polyline({
                path: lineArr,          //�����߸�����·��
                strokeColor:"#5681d6",//����ɫ
                strokeOpacity:0.8,//��͸����
                strokeWeight:8,//�߿�
                strokeStyle:"solid"//����ʽ
            });
            polyline.setMap(map);
            new AMap.Marker({
                map:map,
                position:[data.items[data.items.length-1].lon,data.items[data.items.length-1].lat],
                offset:new AMap.Pixel(-20,-46), 
                content: '<div class="map_end"></div>',
                autoRotation:true
            });
            $(".gjinfo h4").html(data.eventname + (data.type == 1?'<a href="'+data.eventurl+'" target="_blank">�鿴����</a>':''));
            $(".gjinfo").removeClass('gjsai').removeClass('gjlian').addClass(data.type == 1?'gjsai':'gjlian');
            $(".gjinfo b").html(data.starttime);
            $(".gjinfo .g-lc i").html(data.distance)
            $(".gjinfo .g-time i").html(data.time)
            $(".gjinfo .g-su i").html(data.avgspeed)
            $(".gjinfo .g-ka i").html(data.calorie)
            $(".gjinfo ul").html('<li><span>�����</span><span>�׶�����</span><span>����ʱ</span><span>����ʱ��</span></li><li><span>�����</span><span>�׶�����</span><span>����ʱ</span><span>����ʱ��</span></li>'+pslist)
        };
    });
}
function format(c)
{
    console.log(c)
    var h = c.getHours();     
    var m = c.getMinutes();     
    var s = c.getSeconds();     
    return  checkTime(h)+":"+checkTime(m)+":"+checkTime(s);     
}
function checkTime(i)
{
if (i<10) 
  {i="0" + i}
  return i
}
function closegj(){
    $(".gjmapbox,.defaultbg").hide()
}
function RcDelete(idx) {
    if (confirm("ȷ��Ҫɾ�����ѵ����¼��") == true) {
        $.get("/action/ajaxtrained.ashx", { id: idx, op: "delDrill" }, function (d) {
            if (d.status == "1") {
                $(".toast").html('ɾ���ɹ�').show().addClass('toast-success')
            }else {
                $(".toast").html('ɾ��ʧ��').show().addClass('toast-error')
            }
            $(".TrainedListTbody").html('')
            gettrain(1)
            errorboxhide()
        });
    }
}
</script>
<ERUN360:footerv3 runat="server" ID="footerv3" />