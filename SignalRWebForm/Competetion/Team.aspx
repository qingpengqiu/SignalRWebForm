<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Team.aspx.cs" Inherits="Channels_Competetion_Team" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Competetion/ICart.ascx" TagPrefix="ERUN360" TagName="ICart" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>
    <div class="banner">
        <div class="mine">
            <h1><%=title %></h1>
            <asp:Literal ID="ltlbanner" runat="server"></asp:Literal>
        </div>
    </div>
    <div class="tbody">
        <div class="mine">
            <ERUN360:bmnav runat="server" ID="bmnav" />
            <div class="tbodyBox">
                <div class="present this">
                    <form id="form1" runat="server">
                        <div class="indecen ">
                            <div class="racebody racetimew">
                                <h1>
                                    <asp:Literal ID="ltlTitle" runat="server"></asp:Literal><asp:Literal ID="ltlTeam" runat="server"></asp:Literal></h1>
                                <div class="racetip">
                                    1�����½����������ɹ���������
                                    <br>
                                    2���������󲻿����˳��������ؼ���
                                    <br>
                                    3����������������������ܼ��룬����ӳ���ͨ
                                </div>
                                <div class="racetime">

                                    <a class="timemm teamthis teamx" data-listid="0">δ���Ŷ�</a><a class="timem teamx" data-listid="1">�����Ŷ�</a>
                                    <ul class="timelist wmteam">
                                        <li class="noteam">��ǰ�޶���</li>
                                        <li class="pageli">
                                            <div class="racetimem racetimemn" onclick="moreteam();">��ʾ��������</div>
                                        </li>
                                    </ul>
                                    <ul class="timelist" style="display: none">
                                        <li class="noteam">��ǰ�޶���</li>
                                        <li class="pageliman">
                                            <div class="racetimem racetimemman" onclick="moreteamman();">��ʾ��������</div>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div class="both"></div>
                </div>
            </div>
        </div>
    </div>

    <div style="display: none;">
        <div id="newteam">
            <span>�����Ŷ� . ����</span>
            <table>
                <tr>
                    <td>
                        <label for="teamo">�����Ŷ�</label><input type="radio" value="1" id="teamo" name="team" checked>
                    </td>
                    <td>���κ��˶����Լ��룩</td>
                </tr>
                <tr>
                    <td>
                        <label for="teamm">˽���Ŷ�</label><input type="radio" value="0" id="teamm" name="team">
                    </td>
                    <td>����Ա��Ҫ������ܼ��룩</td>
                </tr>
                <tr>
                    <td>�趨����</td>
                    <td>
                        <input type="text" value="" tabindex="1" maxlength="6" id="passwd" disabled="disabled" class="teampass">
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <div class="teampasstip">ֻ����дС��6λ������,��Ϊ����Ϊ<br>
                            �����Ŷ�</div>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td><a href="javascript:void(0)" class="teament" onclick="maketeam();"></a><a href="javascript:void(0)" class="teamqx" onclick="cloxebox();"></a></td>
                </tr>
            </table>
        </div>
        <div id="sessteam">
            <span>�����Ŷ� . ����</span>
            <h1>�ŶӴ����ɹ���</h1>
            <div class="shareteam">
                �����Խ��Ŷ����ӷ��������
                <br>
                http://www.baidu.com/#wd=%E5%BA%A6
        <div class="fenxiang" style="height: auto;">
            <a href="javascript:void(0)" id="sharewb">
                <img alt="" src="/Html/images/weiboc.png">
                ��������΢��</a> | <a id="copyUrl" href="javascript:void(0)" class="">
                    <img alt="" src="/Html/images/fuzhi.png">���Ƶ�ַ</a> | <a class="article-up-iframe" href="/infocenter/PostMessage.aspx?idClub=600000000">
                        <img alt="" src="/Html/images/friend.png">�����վ�ں���</a>
            <div class="zclip" id="zclip-ZeroClipboardMovie_1" style="position: absolute; left: 338px; top: 127px; width: 68px; height: 15px; z-index: 99;">
                            <embed width="68" height="15" align="middle" wmode="transparent" flashvars="id=1&amp;width=68&amp;height=15" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" allowfullscreen="false" allowscriptaccess="always" name="ZeroClipboardMovie_1" bgcolor="#ffffff" quality="best" menu="false" loop="false" src="/Html/js/ZeroClipboard.swf" id="ZeroClipboardMovie_1"></div>
        </div>
            </div>
        </div>
        <div id="jionteam">
            <span>�����Ŷ�</span>
            <div class="ifteam">
                <img src="/Html/images/question.png">
                �Ƿ������Ŷ�,������޷��˳�?
                <br>
                <a class="teament" href="javascript:void(0)" onclick="jionteamok();"></a><a class="teamqx" href="javascript:void(0)" onclick="cloxebox();"></a>
            </div>
        </div>
        <div id="jionteamm">
            <span>�����Ŷ�</span>
            <div class="passteam">
                �������Ŷ����룬������޷��˳�<br>
                <input type="password" id="joinpasswd"><br>
                <a class="teament" href="javascript:void(0)" onclick="jionteamok();"></a><a class="teamqx" href="javascript:void(0)" onclick="cloxebox();"></a>
            </div>
        </div>
        <div id="okteam">
            <span>�ɹ�����</span>
            <div class="okteam">
                <img src="/Html/images/right.png">
                ���ѳɹ�������Ŷ�
            </div>
        </div>
        <div id="tipsbox">
        </div>
    </div>
    <script>
        var teamidd,
            pageSize = 1,
            manfou = 0,
            pageSizeman = 1;
        var sUserAgent = navigator.userAgent.toLowerCase();
        var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
        var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
        var bIsMidp = sUserAgent.match(/midp/i) == "midp";
        var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
        var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
        var bIsAndroid = sUserAgent.match(/android/i) == "android";
        var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
        var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";
        $(".racetime .teamx").click(function(event) {
            $(".racetime .teamx").removeClass('teamthis')
            $(this).addClass('teamthis')
            $(".racetime .timelist").hide()
            $(".racetime .timelist").eq($(this).data('listid')).show()
        });
        $(".timem").click(function(event) {
    
            if(manfou == "0"){
                $.ajax({
                    url: '/Competetion/Team.ashx',
                    data: { m: "team", id: "<%=idItem%>", op: 2, p: pageSizeman, rnd: Math.random() },
    type: 'get',
    dataType: 'json',
    contentType: 'application/json;charset=utf-8',
    cache: false,
    beforeSend: function () {
        $(".noteam").html("���ڼ�����...").show();
    },
    success: function (data) {
        var wmteam = ""
        $.each(data, function (i) {
            var teamuser = "",
                usergrouo = data[i].Group,
                suo = data[i].isOpen==0?'<b></b> ':''
            $.each(usergrouo, function(b) {
                teamuser += '<tr><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank"><img src="'+usergrouo[b].cAvatar+'" alt=""></a></td><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank">'+usergrouo[b].cName+'</a>'+usergrouo[b].cBio.substr(0, 14)+'</td></tr>'
            });
            wmteam +='<li><span><em>'+data[i].iSNo+'�Ŷ�</em>'+suo+data[i].iNum+'/'+data[i].iTotal+'</span><p>���ڳ�Ա��</p><table>'+teamuser+'</table></li>'
        })
        $(".noteam").remove()
        if(wmteam){
            $(".pageliman").before(wmteam)
        }else{
            $(".pageliman").before('<li class="noteam">��ǰ�޶���</li>')
        }
    }
});
}
    manfou = 1
});
jQuery(document).ready(function($) {
    $.ajax({
        url: '/Competetion/Team.ashx',
        data: { m: "team", id: "<%=idItem%>", op: 1, p: pageSize, rnd: Math.random() },
    type: 'get',
    dataType: 'json',
    contentType: 'application/json;charset=utf-8',
    cache: false,
    beforeSend: function () {
        $(".noteam").html("���ڼ�����...").show();
    },
    success: function (data) {
        var wmteam = ""
        $.each(data, function (i) {
            var teamuser = "",
                jionbott = "",
                isShow = <%=isShow%>,
        usergrouo = data[i].Group,
        suo = data[i].isOpen==0?'<b></b> ':''
    $.each(usergrouo, function(b) {
        teamuser += '<tr><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank"><img src="'+usergrouo[b].cAvatar+'" alt=""></a></td><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank">'+usergrouo[b].cName+'</a>'+usergrouo[b].cBio.substr(0, 14)+'</td></tr>'
    });
    jionbott = isShow==0?'style="display: none;"':'onclick="jionteam('+data[i].iSNo+','+data[i].isOpen+');"'
    wmteam +='<li><span><em>'+data[i].iSNo+'�Ŷ�</em>'+suo+data[i].iNum+'/'+data[i].iTotal+'</span><p>���ڳ�Ա��</p><table>'+teamuser+'</table><div class="jointime" '+jionbott+' >�����Ŷ�</div></li>'
})
        $(".noteam").remove()
        if(wmteam){
            $(".pageli").before(wmteam)
        }else{
            $(".pageli").before('<li class="noteam">��ǰ�޶���</li>')
        }
    }
});
});
function moreteam(){
    var date = "";
    pageSize++
    $.ajax({
        url: '/Competetion/Team.ashx',
        data: { m: "team", id: "<%=idItem%>", op: 1, p: pageSize, rnd: Math.random() },
    type: 'get',
    dataType: 'json',
    contentType: 'application/json;charset=utf-8',
    cache: false,
    success: function (data) {
        var wmteam = ""
        $.each(data, function (i) {
            var teamuser = "",
                jionbott = "",
                isShow = <%=isShow%>,
        usergrouo = data[i].Group,
        suo = data[i].isOpen==0?'<b></b> ':''
    $.each(usergrouo, function(b) {
        teamuser += '<tr><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank"><img src="'+usergrouo[b].cAvatar+'" alt=""></a></td><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank">'+usergrouo[b].cName+'</a>'+usergrouo[b].cBio.substr(0, 14)+'</td></tr>'
    });
    jionbott = isShow==0?'style="display: none;"':'onclick="jionteam('+data[i].iSNo+','+data[i].isOpen+');"'
    wmteam +='<li><span><em>'+data[i].iSNo+'�Ŷ�</em>'+suo+data[i].iNum+'/'+data[i].iTotal+'</span><p>���ڳ�Ա��</p><table>'+teamuser+'</table><div class="jointime" '+jionbott+' >�����Ŷ�</div></li>'
})
        $(".pageli").before(wmteam)
        date = wmteam
    },complete: function () { 
        if (date) {
               
        } else {
            $(".racetimemn").html("ľ����");
        }
    }
});
}
function moreteamman(){
    var date = "";
    pageSizeman++
    $.ajax({
        url: '/Competetion/Team.ashx',
        data: { m: "team", id: "<%=idItem%>", op: 2, p: pageSizeman, rnd: Math.random() },
    type: 'get',
    dataType: 'json',
    contentType: 'application/json;charset=utf-8',
    cache: false,
    success: function (data) {
        var wmteam = ""
        $.each(data, function (i) {
            var teamuser = "",
                usergrouo = data[i].Group,
                suo = data[i].isOpen==0?'<b></b> ':''
            $.each(usergrouo, function(b) {
                teamuser += '<tr><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank"><img src="'+usergrouo[b].cAvatar+'" alt=""></a></td><td><a href="/user/'+usergrouo[b].IdUser+'.aspx" target="_blank">'+usergrouo[b].cName+'</a>'+usergrouo[b].cBio.substr(0, 14)+'</td></tr>'
            });
            wmteam +='<li><span><em>'+data[i].iSNo+'�Ŷ�</em>'+suo+data[i].iNum+'/'+data[i].iTotal+'</span><p>���ڳ�Ա��</p><table>'+teamuser+'</table></li>'
        })
        $(".pageliman").before(wmteam)
        date = wmteam
    },complete: function () { 
        if (date) {
               
        } else {
            $(".racetimemman").html("ľ����");
        }
    }
});
}
function newteam(){
    if(bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM){
        $.colorbox({ inline: true,href:"#newteam", width: "100%", height: "296px", opacity: "0.4" });
    }else{
        $.colorbox({ inline: true,href:"#newteam", width: "425px", height: "296px", opacity: "0.4" });  
    }
    
}
function sessteam(){
    $.colorbox({ inline: true,href:"#sessteam", width: "425px", height: "296px", opacity: "0.4" });
}
function jionteam(teamid,teammm){
    teamidd = teamid
    if(teammm == 0){
        if(bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM){
            $.colorbox({ inline: true,href:"#jionteamm", width: '100%', height: "231px", opacity: "0.4",overlayClose:false });
        }else{
            $.colorbox({ inline: true,href:"#jionteamm", width: "425px", height: "231px", opacity: "0.4",overlayClose:false });    
        }
    }else if(teammm = 1){
        if(bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM){
            $.colorbox({ inline: true,href:"#jionteam", width: "100%", height: "231px", opacity: "0.4",overlayClose:false });
        }else{
            $.colorbox({ inline: true,href:"#jionteam", width: "425px", height: "231px", opacity: "0.4",overlayClose:false });
        }
    }
}
function jionteamok(){
    var psd = $("#joinpasswd").val()
    $.ajax({
        url: '/Competetion/Team.ashx',
        type: 'GET',
        dataType: 'text',
        data: { m: "Join", id: teamidd,psd:psd},
        success: function (data) {
            var teamtips = ""
            if(data == 0){
                teamtips = "<img src=\"/Html/images/false.png\"> ����ʧ��";
            }else if(data == 1){
                teamtips = "<img src=\"/Html/images/right.png\"> ����ɹ�";
            }
            else if(data == -1){
                teamtips = "<img src=\"/Html/images/false.png\"> �����µ�¼";
            }
            else if(data == -2){
                teamtips = "<img src=\"/Html/images/false.png\"> ���鲻����";
            }
            else if(data == -3){
                teamtips = "<img src=\"/Html/images/false.png\"> �ö���ɾ��";
            }
            else if(data == -4){
                teamtips = "<img src=\"/Html/images/false.png\"> �ö�����";
            }
            else if(data == -5){
                teamtips = "<img src=\"/Html/images/false.png\"> �����ظ�����";
            }
            else if(data == -6){
                teamtips = "<img src=\"/Html/images/false.png\"> δ����";
            }
            else if(data == -8){
                teamtips = "<img src=\"/Html/images/false.png\"> ���¹���";
            }
            else if(data == -10){
                teamtips = "<img src=\"/Html/images/false.png\"> ���ǻ�����";
            }
            else if(data == -11){
                teamtips = "<img src=\"/Html/images/false.png\"> �������";
            }
            else { teamtips = "<img src=\"/Html/images/false.png\"> �������������������"; }
            $("#tipsbox").html(teamtips)
            tipsbox();
            setTimeout("location.reload()", 2000)
        }
    })
}
function tipsbox(){
    if(bIsIpad || bIsIphoneOs || bIsMidp || bIsUc7 || bIsUc || bIsAndroid || bIsCE || bIsWM){
        $.colorbox({ inline: true,href:"#tipsbox", width: "100%", height: "161px", opacity: "0.4" });
    }else{
        $.colorbox({ inline: true,href:"#tipsbox", width: "325px", height: "161px", opacity: "0.4" });
    }
    
}
function maketeam(){
    var op  = $("input[name='team']:checked").val(),
        psd = $("#passwd").val()
    $.ajax({
        url: '/Competetion/Team.ashx',
        type: 'GET',
        dataType: 'text',
        data: { m: "Create", id: "<%=idItem%>",op:op,psd:psd},
        success: function (data) {
            var teamtips = ""
            if(data == 0){
                teamtips = "<img src=\"/Html/images/false.png\"> ����ʧ��";
            }else if(data == 1){
                teamtips = "<img src=\"/Html/images/right.png\"> �����ɹ�";
            }
            else if(data == -1){
                teamtips = "<img src=\"/Html/images/false.png\"> �����µ�¼";
            }
            else if(data == -2){
                teamtips = "<img src=\"/Html/images/false.png\"> �����ظ�����";
            }
            else if(data == -6){
                teamtips = "<img src=\"/Html/images/false.png\"> �Ѽ�����������";
            }
            else { teamtips = "<img src=\"/Html/images/false.png\"> ��������������������"; }
            $("#tipsbox").html(teamtips)
            tipsbox();
            setTimeout("location.reload()", 2000)
        }
    })
         
}
function okteam(){
    $.colorbox({ inline: true,href:"#okteam", width: "425px", height: "191px", opacity: "0.4" });
    setTimeout("location.reload()", 2000)
}
$("#passwd").keyup(function(){ 
    $(this).val($(this).val().replace(/\D|^0/g,''));  
}).bind("paste",function(){
    $(this).val($(this).val().replace(/\D|^0/g,''));  
}).css("ime-mode", "disabled");  
function cloxebox(){
    $.colorbox.close();
    $("#joinpasswd").val("")
}
$("#teamo").click(function(event) {
    $("#passwd").attr("disabled", "disabled");
});
$("#teamm").click(function(event) {
    $("#passwd").removeAttr("disabled"); 
});
$(".article-up-iframe").on('click', function(e){
    $(this).colorbox({href: $(this).attr('href'), iframe:true, width: 432, innerHeight:200, open:true,opacity: "0.4"});
    e.preventDefault();
    return false;
}); 
thisurl = window.location.href
$('#copyUrl').zclip({
    path:'/Html/js/ZeroClipboard.swf',
    copy:thisurl
});
$("#sharewb").click(function(event) {
    window.open("http://service.weibo.com/share/share.php?url="+thisurl+"&type=button&ralateUid=2961848493&language=zh_cn&appkey=1VDwW4&searchPic=true&style=simple")
});
    </script>
<ERUN360:footerv3 runat="server" ID="footerv3" />