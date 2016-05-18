var custom = function(){

}
function errorboxhide(t){
    setTimeout(function(){
         $(".toast").hide().removeClass('toast-error').removeClass('toast-success').html('')
    }, t?t:2000 )
}
function registback(t){
        var g = t.data('u'),
        t = window.location.href,
        store = $.AMUI.store;
        if (GetQueryString('back')) {
            store.set('registurl', GetQueryString('back'))
        }else{
            store.set('registurl', t)
        }
        window.open(g)
}
function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) return unescape(r[2]); return null;
}
//加载更多文章
function getmoreaction(p,id,g){
    var dom = $.AMUI.store.get('page'+id)
    if (dom) {
        $('.newsmore').before(dom);
    }else{
        $('.newsmore').html('\u6ca1\u6709\u66f4\u591a\u6587\u7ae0')
    }
    cachedom(p,id,g)
}
function cachedom(p,id,g){
    $.get('/action/Ajaxlist.ashx?op='+g+'&code='+id+'&p='+(p+1), function(data) {
        if (!data) {
            $('.newsmore').html('\u6ca1\u6709\u66f4\u591a\u6587\u7ae0')
        }
        $.AMUI.store.set('page'+id,data)
    });
}
//配速计算器
function Clear()
{
    document.getElementById("distance").value = "";
    document.getElementById("hours").value = "";
    document.getElementById("minutes").value = "";
    document.getElementById("seconds").value = "";
    document.getElementById("speed_minutes").value = "";
    document.getElementById("speed_seconds").value = "";
    document.getElementById("calorie").innerHTML = "";
}
function OK()
{
    var distance = document.getElementById("distance").value;
    var hours = document.getElementById("hours").value;
    var minutes = document.getElementById("minutes").value;
    var seconds = document.getElementById("seconds").value;
    var speed_minutes = document.getElementById("speed_minutes").value;
    var speed_seconds = document.getElementById("speed_seconds").value;
    document.getElementById("calorie").innerHTML = "";
    if(distance.length > 0 && hours.length > 0 && minutes.length > 0 && seconds.length > 0)
    {
        var speed = parseFloat(hours) * 60.0 + parseFloat(minutes) + parseFloat(seconds) / 60.0;
        speed = speed / parseFloat(distance);
        speed_minutes = Math.floor(speed);
        speed_seconds = Math.floor((speed - speed_minutes) * 60.0);
        document.getElementById("speed_minutes").value = speed_minutes;
        document.getElementById("speed_seconds").value = speed_seconds;
        return;
    }
    if(distance.length > 0 && speed_minutes.length > 0 && speed_seconds.length > 0)
    {
        var atime = parseFloat(speed_minutes) + parseFloat(speed_seconds) / 60.0;
        atime = atime * parseFloat(distance);
        hours = Math.floor(atime / 60.0);
        minutes = Math.floor(atime - hours * 60.0);
        seconds = Math.floor((atime - hours * 60.0 - minutes)*60.0);
        document.getElementById("hours").value =  hours;
        document.getElementById("minutes").value = minutes;
        document.getElementById("seconds").value = seconds;
        return;
    }
    if(minutes.length > 0 && seconds.length > 0 && speed_minutes.length > 0 && speed_seconds.length > 0)
    {
        var atime = parseFloat(hours) * 60 + parseFloat(minutes) + parseFloat(seconds) / 60.0;
        var speed = parseFloat(speed_minutes) + parseFloat(speed_seconds) / 60.0;
        //distance = Math.floor(atime / speed);
        distance = atime / speed;
        document.getElementById("distance").value =  distance.toFixed(1);
        return;
    }
    document.getElementById("calorie").innerHTML = "\u8f93\u5165\u6570\u636e\u4e0d\u591f";
}
// 首页推荐好友
function lbfried(){
    var fp = 1
        $("#V3HotUserCenter").addClass('vus1')
    $(".V3HotUserLeft").click(function(event) {
        if (fp == 3) {
            fp =1
        }else{
            fp++
        }
        $("#V3HotUserCenter").attr('class', 'vus'+fp);
    });
    $(".V3HotUserRight").click(function(event) {
        if (fp == 1) {
            fp = 3
        }else{
            fp--
        }
        $("#V3HotUserCenter").attr('class', 'vus'+fp);
    });
}

// 频道页面轮播
function pdlb() {
    var now = 0
    var oDiv = $("#playBox")
    var oPre = $(".pre")
    var oNext = $(".next") 
    var oUlBig = $(".oUlplay")
    var aBigLi = $(".oUlplay li") 
    var oDivSmall = $(".smalltitle")
    var aLiSmall = $(".smalltitle li")
    var linum = aBigLi.length
    if (linum == 1) {
        oPre.hide()
        oNext.hide()
    };
    // $(".listlb img:eq(1)").load(function() {
    //     var i =  $(this).height();
    //     console.log(i)
    //     $('.listlb').css('height', i+'px');
    // });
    function tab() {
        for (var i = 0; i < aLiSmall.length; i++) {
            aLiSmall[i].className = '';
        }
        aLiSmall[now].className = 'thistitle'
        oUlBig.animate({'top': -(now * aBigLi[0].offsetHeight)}, 300)
    }

    oPre.click(function(event) {
        now--
        if (now == -1) {
            now = aBigLi.length;
        }
        tab();
    });
    oNext.click(function(event) {
        now++
        if (now == aBigLi.length) {
            now = 0;
        }
        tab();
    });
    setInterval(function(){
        now++
        if (now == aBigLi.length) {
            now = 0;
        }
        tab();
    }, 3000) 
}
// 刷新登录状态
function getlogin(){
    $.post('/action/loginstatus.ashx',{'equip': 'mobile'}, function(data) {
        $(".mediaLogin").html(data)
    });
    $.post('/action/loginstatus.ashx',{'equip': 'pc'}, function(data) {
        $(".logincode").html(data)
    });
    gettwo()
}
// 刷新留言评论数
function gettwo() {
$.ajax({
   type: "GET",
   url: "/infocenter/Include/AjaxCount.aspx",
   data: { rnd: Math.random() },
   contentType: "application/json; charset=utf-8",
   dataType: "json",
   success: function(msg){
        if(msg.hea > "0"){
            $(".mediaLogin").find(".msgshowa").show()
            $(".logincode").find(".msgshowa").show()
        }else{
            $(".mediaLogin").find(".msgshowa").hide()
            $(".logincode").find(".msgshowa").hide()
        }
        if(msg.count > "0"){
            $(".mediaLogin").find(".msgshowl").html(msg.count).css('display', 'inline-block');
            $(".logincode").find(".msgshowl").html(msg.count).css('display', 'inline-block');
        }else{
            $(".mediaLogin").find(".msgshowl").hide()
            $(".logincode").find(".msgshowl").hide()
        }
        if(msg.msgcount > "0"){
            $(".mediaLogin").find(".msgshowb").show()
            $(".logincode").find(".msgshowb").show()
            $(".mediaLogin").find(".msgshowf").html(msg.msgcount).css('display', 'inline-block');
            $(".logincode").find(".msgshowf").html(msg.msgcount).css('display', 'inline-block');
        }else{
            $(".mediaLogin").find(".msgshowb").hide()
            $(".logincode").find(".msgshowb").hide()
            $(".mediaLogin").find(".msgshowf").hide()
            $(".logincode").find(".msgshowf").hide()
        }
        if(msg.dcscount > "0"){
            $(".mediaLogin").find(".msgshowpl").html(msg.dcscount).css('display', 'inline-block');
            $(".logincode").find(".msgshowpl").html(msg.dcscount).css('display', 'inline-block');
        }else{
            $(".mediaLogin").find(".msgshowpl").hide()
            $(".logincode").find(".msgshowpl").hide()
        }
   }
}); 
}
// 登陆弹窗 js
function PopupShowdl(){
    $(".loginboxbg,.loginbox").show()
    if ($.AMUI && $.AMUI.store.get('loginame')) {
        $("#name").val($.AMUI.store.get('loginame'))
        
    };

}
//获取登录状态
function StatusCheck(){
    var ge = self.setInterval(function(){
        $.get('/action/AjaxUser.ashx?op=getuser', function(data) {
            if (data.status == 1) {
                window.clearInterval(ge)
                $(".loginboxbg,.loginbox").hide()
                getlogin()
                gettwo()
            }
        });
    },1000)
    $(".closelb,.loginboxbg").click(function(event) {
        $(".loginboxbg").hide()
        $(".loginbox").hide()
        window.clearInterval(ge)
    });
}
// 发布博文页面自动本地保存文章内容
var autosave={
    "store":$.AMUI.store,
    "setdata":function(i,t,c){
        var titleval = $(t).val(),   //页面标题内容
            contentval = $(c).froalaEditor('html.get') //页面文章内容
        this.store.set(i, {'title':titleval,'content':contentval}) 
    },
    "getdata":function(i){
        return this.store.get(i)
    },
    "setval":function(i,t,c){
        var sc = this.getdata(i).content
            $(t).val(this.getdata(i).title)
            $(c).froalaEditor('html.set',sc);
            $(c).val(sc)
    },
    "getval":function(i,t,c){
           var idata = this.getdata(i)   //获取当前id 是否有缓存内容
            if (idata){
                if (window.confirm("\u662f\u5426\u8981\u52a0\u8f7d\u4e0a\u6b21\u672a\u7f16\u8f91\u5b8c\u6210\u7684\u6587\u7ae0\uff1f")) {
                    this.setval(i,t,c)
                }else{
                    autosave.cleardata(i)
                }
            }
            $(".toast").html('\u5df2\u542f\u7528\u5185\u5bb9\u7f13\u5b58\u529f\u80fd\uff0c\u518d\u4e5f\u4e0d\u9700\u8981\u62c5\u5fc3\u65ad\u7f51\u54af\uff01\u8be5\u529f\u80fd\u0069\u0065\u0038\u4ee5\u4e0b\u4e0d\u652f\u6301').show().addClass('toast-success')
                errorboxhide(4000)
    },
    "cleardata":function(i){
        this.store.remove(i)
    }
};  
// 获取文章分类
var getclasslist={
    "getclass":function(d){
        $.get('/action/ajaxbloghelper.ashx?op=GetBlogGroup', function(data) {
        var f1 = '',
            f2 = ''
            $.each(data, function(index, val) {
                if (val.id == d) {
                f1 +='<option value="'+val.id+'" selected>'+val.Name+'</option>'
                }else{
                f1 +='<option value="'+val.id+'">'+val.Name+'</option>'
                }
                f2 +='<li><i>'+(index+1)+'</i><i>'+val.Name+'</i><i>'+val.Number+'</i><i class="delclassi" data-id="'+val.id+'"></i></li>'
            });
            $("#blogtype").html(f1)
            $(".classlist").html(f2)
        });
    },
    "delclass":function(id){
        $.get('/action/ajaxbloghelper.ashx?op=DeleteBlogGroup&id='+id, function(data) {
                if (data.status == 1) {
                    $(".toast").html(data.msg).show().addClass('toast-success')
                    errorboxhide()
                }else{
                    $(".toast").html(data.msg).show().addClass('toast-error')
                    errorboxhide()   
                }
            getclasslist.getclass()
            });
    },
    "addclass":function(){
        var cn = $("#addclass").val()
        $.get('/action/ajaxbloghelper.ashx?op=AddBlogGroup&name='+cn, function(data) {
                if (data.status == 1) {
                    $(".toast").html(data.msg).show().addClass('toast-success')
                    errorboxhide()
                }else{
                    $(".toast").html(data.msg).show().addClass('toast-error')
                    errorboxhide()   
                }
            getclasslist.getclass()
            });
    },
    "getclub":function(d){
        $.get('/action/ajaxbloghelper.ashx?op=GetClub', function(data) {
            var ct = ''
            $.each(data, function(index, val) {
                if (d == val.id) {
                ct += '<label class="cbcheck" ><input type="checkbox" name="club" value="'+val.id+'" checked>'+val.Name+'</label>'
                }else{
                ct += '<label class="cbcheck" ><input type="checkbox" name="club" value="'+val.id+'">'+val.Name+'</label>'
                }
            });
            $(".clublistblog").html(ct)
        });
    }
}
function loginout(){
    $.get('/action/logout.ashx', function(data) {
        if (data.status == 1) {
            $(".toast").html(data.msg).show().addClass('toast-success')
            $.AMUI.store.remove('userinfo')
            setTimeout(function(){window.location.href="/"},3000)
        }else{
            $(".toast").html(data.msg).show().addClass('toast-error')
        }
        errorboxhide()   
    });
}

// 提示插件   tipbox('提示内容','success||error','停留时间默认2秒')
var tipbox = function (tip,status,time) {
  var demo = '<div id="toastfun" class="toastfun toastfun-'+status+'">'+tip+'</div>'
  $("body").append(demo)
  setTimeout(function(){
      $("#toastfun").remove()
    }, time?time:2000 )
}