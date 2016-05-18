var p= 1
// 图片延迟加载
// src=\"/Html/images/blank.gif\" data-echo=\"\"
// src="/Html/images/blank.gif" data-echo=""
    echo.init({
        offset: 100,
        throttle: 250,
        unload: false
    });


//定时获取新留言数新粉丝数
var int=self.setInterval("gettwo()",60000)
jQuery(document).ready(function($) {
    if (GetQueryString('a') == 'login') {
        PopupShowdl();StatusCheck();
    };
    getlogin()
    // 页面加载完成获取登陆用户信息
    $.get('/action/AjaxUser.ashx?op=getuser', function(data) {
        if (data.status == 1) {
            $.AMUI.store.set('userinfo',data)
        }else{
            $.AMUI.store.remove('userinfo')
        }
    });
});
//点击注册按钮添加当前页面url到 data中. 使用store.get('registurl')取值
$(".logincode").on('click', '.registback', function(event) {
    event.preventDefault();
    registback($(this))
});
$(".mediaLogin").on('click', '.registback', function(event) {
    event.preventDefault();
    registback($(this))
});
$(".tiplogin a").click(function(event) {
    registback($(this))
});
// ajax 登录
$("#boxlogingo").click(function(event) {
    // var name = $("name").val(),
    //     tz = /['"#$%&\^*]/
    // if (tz.test(name)) {
    //     console.log('登录名不能包含特殊字符')
    //     return false
    // };
    var d = $('#boxloginf').serialize()
    $.post('/action/ajaxlogin.ashx', d, function(data, textStatus, xhr) {
        if (data.status == 0) {
            $(".toast").html(data.msg).show().addClass('toast-error')
        }else{
            $(".toast").html(data.msg).show().addClass('toast-success')
            $.AMUI.store.set('userinfo',data)
            $.AMUI.store.set('loginame',data.loginame)
            //自定义函数
            custom()
            $(".loginboxbg").hide()
            $(".loginbox").hide()
        }
        errorboxhide()
    });
});
$('#psd').bind('keypress',function(event){
    if(event.keyCode == "13")    
    {
        $("#boxlogingo").click();
    }
});

$(".bnav a").click(function(event) {
	var i = $(this).index()
	$(this).addClass('this').siblings('a').removeClass('this');
	$(".tbodyBox>div").hide().eq(i).show()
});

$(".openm").click(function(event) {
	$(".manueb").toggleClass('hauto');
});
$(".mxbox").hover(function() {
	$(".mxlibox").show()
}, function() {
	$(".mxlibox").hide()
});
$(window).scroll(function(){
    if ($(window).scrollTop()>210){
        $(".mxbox").addClass('mxboxfixed')
    }
    else
    {
        $(".mxbox").removeClass('mxboxfixed')
    }
});

//首页关注跑友
lbfried()
$(".V3HotUser em").click(function(event) {
    var id = $(this).data('id')
    $.get('/action/ajaxUser.ashx?op=addFoucs&uid='+id, function(data) {
        if (data.status == 1) {
            $(".toast").html(data.msg).show().addClass('toast-success')
            errorboxhide()    
        }else{
            $(".toast").html('关注失败').show().addClass('toast-error')
            errorboxhide()   
        }
    });
});
$(".navmore").click(function(event) {
    $(".navmore dl").toggle()
});
$(".mh").click(function(event) {
    $(".nav").toggleClass('navrighrf')
    $("body").toggleClass('bodyhiden');
    event.stopPropagation();
});
$(".nava").click(function(event) {
    if ($(this).get(0).tagName != 'A') {
        $(this).addClass('this').siblings().removeClass('this')
        event.stopPropagation(); 
    };
});
$("body").click(function(event) {
    $(".nav").removeClass('navrighrf')
    $("body").removeClass('bodyhiden');
});
//首页加载更多文章
$('#newsmore').click(function(event) {
    p++
    getmoreaction(p,GetQueryString('id'),'list')
});
//list 列表页加载分页
$('#newsmorelist').click(function(event) {
    p++
    getmoreaction(p,GetQueryString('id'),'cnlist')
});
//首页轮播
$(function(){
    var _index7=0;
    $(".V3BannerBox ul li").hover(function(){
        _index7=$(this).index();
        setTimeout(function(){
            $(".V3BannerBox li").removeClass("tm").eq(_index7).addClass("tm");
        }, 200 )
    });
     setInterval(function(){
        $(".V3BannerBox li").removeClass("tm").eq(_index7).addClass("tm");
        if (_index7 == 5) {
            _index7 = 0
        }else{
        _index7++
        }
     }, 3000)
});
//首页搜索js
$("#serchkey").keyup(function(){
    key = $(this).val().replace(/(^\s*)|(\s*$)/g, "");  
    xskey = key;
    function cutstr(str,len)
    {
        var str_length = 0;
        var str_len = 0;
        str_cut = new String();
        str_len = str.length;
        for(var i = 0;i<str_len;i++)
        {
            a = str.charAt(i);
            str_length++;
            if(escape(a).length > 4)
            {
                //中文字符的长度经编码之后大于4
                str_length++;
            }
            str_cut = str_cut.concat(a);
            if(str_length>=len)
            {
                str_cut = str_cut.concat("...");
                return str_cut;
            }
        }
        //如果给定字符串小于指定长度，则返回源字符串；
        if(str_length<len){
            return  str;
        }
    }   
    xskey = cutstr(xskey,10);
    html = "<ul><li><a href=\"/infocenter/Searchuser.aspx?searchname="+key+"\">\u641c“<em>"+xskey+"</em>”\u76f8\u5173\u7684\u7528\u6237</a></li><li><a href=\"/infocenter/Search.aspx?fname=title&word="+key+"\">\u641c“<em>"+xskey+"</em>”\u76f8\u5173\u7684\u6807\u9898</a></li><li style=\"border-bottom: 0\"><a href=\"/infocenter/Search.aspx?fname=content&word="+key+"\">\u641c“<em>"+xskey+"</em>”\u76f8\u5173\u7684\u5185\u5bb9</a></li></ul>";
    $(".serchresult").empty("");
    if(key == ""){
        $(".serchresult").hide();    
    }else{
        $(".serchresult").append(html);
        $(".serchresult").show();
        $(".hotserch").attr('href', '/infocenter/Search.aspx??fname=title&word='+key);
    }
    $("html").click(function(){
        $(".serchresult").hide();    
    })

})
$("#roadtime,#results").click(function(event) {
    var t = $(this),
        left =  $(this).offset().left,
        top =  $(this).offset().top+34,
        str = ''
str += '<select name="hour" id="hour">';
for (h = 0; h <= 9; h++) {
    str += '<option value="0'+h+'">0'+h+'</option>';
}
for (h = 10; h <= 99; h++) {
    str += '<option value="'+h+'">'+h+'</option>';
}
str += '</select><label>\u65f6</label><select name="minute" id="minute">';
for (m = 0; m <= 9; m++) {
    str += '<option value="0'+m+'">0'+m+'</option>';
}
for (m = 10; m <= 59; m++) {
    str += '<option value="'+m+'">'+m+'</option>';
}
str += '</select><label>\u5206</label><select name="second" id="second">';
for (s = 0; s <= 9; s++) {
    str += '<option value="0'+s+'">0'+s+'</option>';
}
for (s = 10; s <= 59; s++) {
    str += '<option value="'+s+'">'+s+'</option>';
}
str += '</select><label>\u79d2</label><input name="queding" type="button"  value="\u786e\u5b9a" />';
    $(".insertPace").html(str).css({
        top: top,
        left: left,
        display:'block'
    }).find('input').click(function(event) {
        t.val($("#hour").val()+':'+$("#minute").val()+':'+$("#second").val())
        $(".insertPace").hide()
    });
});

//插入插件
// document.writeln("<div id=\"_contents\" style=\" position:absolute; left:?px; top:?px; width:?px; height:?px; z-index:1; visibility:hidden\">");
// str += "<select name=\"_hour\" id=\"_hour\">";
// for (h = 0; h <= 9; h++) {
//     str += "<option value=\"0" + h + "\">0" + h + "</option>";
// }
// for (h = 10; h <= 99; h++) {
//     str += "<option value=\"" + h + "\">" + h + "</option>";
// }
// str += "</select><label>\u65f6</label><select name=\"_minute\" id=\"_minute\">";
// for (m = 0; m <= 9; m++) {
//     str += "<option value=\"0" + m + "\">0" + m + "</option>";
// }
// for (m = 10; m <= 59; m++) {
//     str += "<option value=\"" + m + "\">" + m + "</option>";
// }
// str += "</select><label>\u5206</label><select name=\"_second\" id=\"_second\">";
// for (s = 0; s <= 9; s++) {
//     str += "<option value=\"0" + s + "\">0" + s + "</option>";
// }
// for (s = 10; s <= 59; s++) {
//     str += "<option value=\"" + s + "\">" + s + "</option>";
// }
// str += "</select><label>\u79d2</label><input name=\"queding\" type=\"button\" onclick=\"_select()\" value=\"\u786e\u5b9a\" style=\"font-size:12px\" /></div>";
// document.writeln(str);
// var _fieldname;
// function _SetTime(tt) {
//     _fieldname = tt;
//     var ttop = tt.offsetTop;    //TT控件的定位点高
//     var thei = tt.clientHeight;    //TT控件本身的高
//     var tleft = tt.offsetLeft;    //TT控件的定位点宽
//     while (tt = tt.offsetParent) {
//         ttop += tt.offsetTop;
//         tleft += tt.offsetLeft;
//     }
//     document.getElementById("_contents").style.top = ttop + thei + 4;
//     document.getElementById("_contents").style.left = tleft;
//     document.getElementById("_contents").style.visibility = "visible";
// }
// function _select() {
//     _fieldname.value = document.getElementById("_hour").value + ":" + document.getElementById("_minute").value + ":" + document.getElementById("_second").value;
//     document.getElementById("_contents").style.visibility = "hidden";
// }