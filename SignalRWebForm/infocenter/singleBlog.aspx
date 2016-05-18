<%@ Page Language="C#" AutoEventWireup="true" CodeFile="singleBlog.aspx.cs" Inherits="infocenter_singleBlog" %><%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %><%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %><!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title><%=m_title %>-<%=m_nav %>-��������������</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="../Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/media.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../Html/js/modernizr.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
     <script  type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript">
        function imageResize(obj) {
            if (obj.width > 600) {
                obj.width = 600;
            }
        }
    </script>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
    <style type="text/css">
<%=StyleLeft %>
</style>
</head>
<body>
    <form id="form1" runat="server">
        <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
        <div class="wrap">
            <article>
                <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
                <div class="main-right">
                    <div class="blog">
                        <%=fullText %>
                        <div class="page">
                            <%=Previous %>
                            <br>
                            <%=Next %>
                        </div>
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                        </div>
                    </div>
                </div>
                <div id="adm">
                    
                </div>
                <div class="main-right" id="pl">
                    <div class="blog">
                        <div class="blog-content">
                        <div class="discuss">
                            ��Ҫ���ۣ�
                        </div>
                        <div class="discuss-border">
                            <div class="discuss-text">
                                <ERUN360:Phiz runat="server" ID="Phiz" />
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <textarea style="font-size: 14px; padding: 5px;" rows="3" cols="70" name="cContent" id="cContent" runat="server"></textarea><br>
                                        <asp:Label ID="lbtip" runat="server" ForeColor="Red"></asp:Label>
                                        <%if (cId == 0) %>
                                        <%{ %>
                                        <div class="discuss-login">
                                            <a href="/Member/">ע��</a>|
                                            <a onclick="PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();" href="javascript:">��¼</a>

                                        </div>
                                        <%} %>
                                        <%else %>
                                        <%{ %>
                                        <asp:Button ID="btnDiscuss" class="submit" runat="server" Text="�ύ" OnClick="btnDiscuss_Click" />
                                        <%} %>
                            
                                    <%=DiscussList %>
                                       <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
                                NextPageText="��һҳ" CssClass="pages"
                                CurrentPageButtonClass="cpb" PrevPageText="��һҳ"
                                OnPageChanged="pager_PageChanged" PageSize="50">
                            </webdiyer:AspNetPager>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                    </div>
                </div>
            </article>
        </div>
        <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
        <script type="text/javascript">   
            var idpl=<%=bId%>;              
            if(idpl==200218084)
            {
                $("#pl").hide();
            }
            $("#btnDiscuss").bind("click", function () {
                var postmsg = $("#cContent").val().replace(/(^\s+)|(\s+$)/g, "");
                if (postmsg == "") {
                    $(".discuss-text").append("<a class=\"tishi\">���Բ���Ϊ��</a>")
                    return false;
                } else {
                    $(".tishi").empty();
                }

            });
            jQuery(document).ready(function ($) {
$.ajax({
    type: "post",
    url: "/action/AD.ashx?b=<%=bId%>",
    dataType: "json",
    success: function (data) {
             $.each(data.ds, function (i,item) {
                $("#adm").append("<a href=\""+item.Url+"\" title=\""+item.name+"\" target=\"_blank\"><img src=\""+item.Img+"\"></a>").show();
             })
    }
});                
                $(".article-up-iframe").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
                $(".close").click(function () {
                    $(".message").hide();
                });
                var lheight = $(".main-right").height() - "16";
                if (lheight > "530") {
                    $(".main-left").css("height", lheight);
                }
                $('#text').emotions();
                //ɾ������
                function GetQueryString(name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                }
                $(".blogdel").click(function () {
                    var blogDelUrl = $(this).attr("rel")
                    isDel(blogDelUrl)
                })

            });
function isDel(url){
 var is =confirm("ȷ��ɾ����");
 if(is){
  $.ajax({
                        url: url,
                        type: 'GET',
                        dataType: 'text',
                        success: function (data, textStatus, xhr) {
                            var strs = new Array();
                            strs = data.split(",");
                            if (strs[0] == "ok") {
                                focuscont = "<img src=\"/Html/images/right.png\"> ɾ���ɹ�";
                            } else {
                                focuscont = "<img src=\"/Html/images/false.png\">" + data;
                            }
                            function blogDelHref() {
                                //setTimeout("location.href = \"/infocenter/" + strs[1] + "?uId=" + GetQueryString("uId") + "\"", 3000)
                                setTimeout("location.href = \"/infocenter/" + strs[1] + "?uId=<%=cId%> \"", 3000)
                            }
                            $(".blogdel").append("<div class=\"focusalert\">" + focuscont + "</div>");
                            setTimeout(blogDelHref, 200);
                        },
                        error: function (xhr, textStatus, errorThrown) {
                            //called when there is an error
                        }
                    });
  }
 }
            function EmotionAdd(v) {
                document.getElementById("cContent").value += "[" + v + "]";
            }
            $(".house").click(function () {
                setTimeout("$('.collect').hide()", 2000);
            })

            $(".art-del").click(function () {
                var qa = $(this).attr("href");
                $(".cancel_enter").attr("href", qa);
                $(this).colorbox({ inline: true, width: "50%", href: "#cancel", width: "254px", height: "141px", opacity: "0.4" });
            })
            $(".close_cancel").click(function () {
                $("#cancel").colorbox.close();
            })
            function Ding() {
                $.get("/action/GetBlogList.ashx?command=Ding&bId=<% =bId %>&rnd=" + Math.random(), function (result) {
                    document.getElementById("isDing").innerHTML = result;
                });
            }
            function iHouse() {
                $.get("/action/GetBlogList.ashx?command=iHouse&bId=<% =bId %>&rnd=" + Math.random(), function (result) {

                    if (result == "1") {
                        focuscont = "<img src=\"/Html/images/right.png\"> ��ע�ɹ�";
                    } else {
                        focuscont = "<img src=\"/Html/images/false.png\">" + result;
                    }
                    function iHousere() {
                        setTimeout("$(\".focusalert\").remove()", 3000)
                    }
                    $(".house").append("<div class=\"focusalert\">" + focuscont + "</div>");
                    setTimeout(iHousere, 200);



                });
            }
            
            function JoinCreate(idUser, idx, bId) {
                $.get("/action/CompetitionList.ashx", { uId: idUser, id: idx, bId: bId, command: "FoucsCompetetion", rnd: Math.random() }, function (result) {
                    if (result == "OK") {
                        focuscont = "<img src=\"/Html/images/right.png\"> ��ע�ɹ�";
                         $("#guanzhu_info").append("<div class=\"focusalert\">" + focuscont + "</div>");
                            setTimeout(iHousere, 200);
                    }
                    else if (result == "nologin"){
                        PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();
                    }
                    else if (result == "error") {
                        
                    }
                    function iHousere() {
                        setTimeout("$(\".focusalert\").remove()", 3000);
                        $("#guanzhu_info").replaceWith("<a id=\"foucs_ss1\">�ѹ�ע</a>")

                    }
                    function ierror() {
                        setTimeout("$(\".focusalert\").remove()", 3000);
                        $("#guanzhu_info").replaceWith("<a id=\"foucs_ss1\">��������</a>")

                    }
                });
            }
            function huifuta(bid,uid,id){
                $("#text .huifuk").remove();
                $.get("/action/GetMessageList.ashx",{ command: "state"}, function (data) {
                    console.log(data)
                   if(data == "-1"){
                    PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();
                   }else {
                    $("#li"+id).append("<div class=\"huifuk\"><em></em>�ظ���<br><textarea id=\"reply\"></textarea><a class=\"reply\" onclick=\"replyd("+bid+","+uid+")\" href=\"javascript:void(0)\">����</a><a class=\"qreply\" onclick=\"qreply()\" href=\"javascript:void(0)\">ȡ��</a></div>")
                   }
                });
            }
            function replyd(bid,uid){
                msg = encodeURIComponent($("#reply").val());
                

                $.get("/action/GetMessageList.ashx", { command: "AddHuiFu", idBlog:bid,idUser: uid,op: "1",msg: msg}, function (data) {
                   if(data == "-1"){
                    PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();
                   }else if(data == "1"){
                       //location.replace(location+ "#text")
                       var replaceRegex = /\#text/g;
                       date = window.location.href.replace(replaceRegex, '')
                       location = date + "#text";
                       window.location.reload()
                    $("#reply").val("");
                    $(".huifuk").remove()
                   }else if(data == "0"){
                   }
                    
                });
            }
            function qreply(){
                $(".huifuk").remove()
            }
            var idGame = <%=idGame%>,
                idPay  = <%=idPay%>,
                idFoucs= <%=idFoucs%>,
                ppage  = 1,
                fpage  = 1,
                plast  = Math.ceil(idPay/50),
                flast  = Math.ceil(idFoucs/50)
                
            //���ɱ�����Ա������֧��״̬��ҳ
            if(idGame > 0 && idPay > 50){
                var ppagedemo = '<tr><td colspan="8" class="paypage">��'+idPay+'�� <a href=\"javascript:void(0)\" onclick=\"pfirstpage()\">��ҳ</a> <a href=\"javascript:void(0)\"  onclick=\"puppage()\">��һҳ</a> <a href=\"javascript:void(0)\"  onclick=\"pdownpage()\">��һҳ</a> <a href=\"javascript:void(0)\" onclick=\"plastpage()\">ĩҳ</a> </td></tr>'
               $(".mdnamet").append(ppagedemo)
            }
            function pfirstpage(){
                ppagen(1)
            }
            function puppage(){
                if(ppage  == 1){
                    ppage
                }else{
                    ppage--
                }
                ppagen(ppage)
            }
            function pdownpage(){
                if(ppage  == plast){
                    ppage
                }else{
                    ppage++
                }
                ppagen(ppage)
            }
            function plastpage(){
                ppagen(plast)
            }
            function ppagen(ppaget){
                $.ajax({
                        url: '/action/CompetitionList.ashx?command=pay&p='+ppaget+'&id='+idGame,
                        type: 'get',
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',                        
                        cache: false,
                        success: function (data) {
                            $(".mdnamet").html("")
                            ptext = "<tr><th>���</th><th>�ǳ�</th><th>����</th><th>״̬</th><th>���</th><th>�ǳ�</th><th>����</th><th>״̬</th></tr>"
                            
                            ic = 1
                           
                            $.each(data.ds, function (i,item) {
                                 var iState = "��֧��"
                                if(data.ds[i].iState==3){
                                    iState= "�����"
                                }
                                ic++
                                if(ic%2 == 0){
                                    ptext +=("<tr><td>" + data.ds[i].row_index + "</td><td title=\"" + data.ds[i].cNickName + "\">" + data.ds[i].cNickName + "</td><td>" + data.ds[i].cType + "</td><td>"+iState+"</td>");
                                    
                                }else{
                                    ptext +=("<td>" + data.ds[i].row_index + "</td><td title=\"" + data.ds[i].cNickName + "\">" + data.ds[i].cNickName + "</td><td>" + data.ds[i].cType + "</td><td>"+iState+"</td></tr>");
                                }

                                
                            })
                            if(ic%2 == 0){
                                ptext +=("<td></td><td></td><td></td><td></td></tr>")
                            }
                            ptext +=ppagedemo
                            $(".mdnamet").append(ptext)
                        }
                    });
            }
            //���ɹ�ע��������ҳ
            if(idGame > 0 && idFoucs > 50){
                var fpagedemo = '<div class="fpage">��'+idFoucs+'�� <a href=\"javascript:void(0)\" onclick=\"ffirstpage()\">��ҳ</a> <a href=\"javascript:void(0)\"  onclick=\"fuppage()\">��һҳ</a> <a href=\"javascript:void(0)\"  onclick=\"fdownpage()\">��һҳ</a> <a href=\"javascript:void(0)\" onclick=\"flastpage()\">ĩҳ</a> </div>'
               $(".cymd").append(fpagedemo)
            }
            function ffirstpage(){
                fpagen(1)
            }
            function fuppage(){
                if(fpage  == 1){
                    fpage
                }else{
                    fpage--
                }
                fpagen(fpage)
            }
            function fdownpage(){
                if(fpage  == flast){
                    fpage
                }else{
                    fpage++
                }
                fpagen(fpage)
            }
            function flastpage(){
                fpagen(flast)
            }
            function fpagen(fpaget){
                $.ajax({
                        url: '/action/CompetitionList.ashx?command=Foucs&p='+fpaget+'&id='+idGame,
                        type: 'get',
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',                        
                        cache: false,
                        success: function (data) {
                            $(".cymd ul").html("")
                            $.each(data.ds, function (i,item) {
                                $(".cymd ul").append('<li><a target="_blank" href="/user/'+ data.ds[i].id +'.aspx" title="'+ data.ds[i].cNickName +'"><img src="'+ data.ds[i].cAvatar +'">'+ data.ds[i].cNickName +'</a></li>')
                            })
                        }
                    });
            }
            $("#blog_content img").click(function(event) {
                window.open($(this).attr("src"));
            });
        </script>

    </form>
<script type="text/javascript">
if($("#hrefUrl")[0]){
     location.href=$("#hrefUrl").data('url')
}
var vid =$("#youkuplayer").data("vid")
</script>
<script type="text/javascript" src="http://player.youku.com/jsapi">
if(vid){

    player = new YKU.Player('youkuplayer',{
    client_id: 'bf9a4d4a668be0b8',
    vid: vid
});
    
}

</script>    
</body>
</html>
