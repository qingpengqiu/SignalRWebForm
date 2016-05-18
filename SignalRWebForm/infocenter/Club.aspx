<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Club.aspx.cs" Inherits="infocenter_Club" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %><%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %><!DOCTYPE html>
<html>
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title><%=cTitle %>-���ܾ��ֲ�</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/themes-club.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/themes-club-<%=sBackground%>.css" />
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../Html/js/modernizr.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.pagination.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="../Common/jImage.js"></script>
    <script type="text/javascript" src="../FusionCharts/FusionCharts.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="club">
        <article class="clubtopt">
            
        </article>
        <article>
            <div class="clubl">
                <div class="cin">
                <a href="javascript:void(0)" class="clubimg"><img src="/Html/images/cAvatar.png" ></a>
                <h1><a href="javascript:void(0)">���ܾ��ֲ�</a></h1>
                <span>���£�0 | ��Ա��0/0</span>
                <p>���ֲ�����</p>
                <div class="dexiugai">
                    <textarea id="Idmsg"></textarea>
                    <input id="b2" type="text" readonly="readonly">
                </div>
                <a class="comec" href="javascript:void(0)" onclick="JoinClub()"></a>
                <div class="fenxiang"><a id="sharewb" href="javascript:void(0)"><img src="/Html/images/weiboc.png" alt=""> ��������΢��</a> | <a href="javascript:void(0)" id="copyUrl"><img src="/Html/images/fuzhi.png" alt="" >���Ƶ�ַ</a> | <a href="/infocenter/PostMessage.aspx?idClub=<%=ClubId %>" class="article-up-iframe"><img src="/Html/images/friend.png" alt="" >�����վ�ں���</a></div>
                </div>
                <div class="equip">
                    <span class="equip-ous">��������<em></em></span>
                    <%--<span class=""><em></em>ͼƬ</span>--%>
                    <span class=""><em></em>�</span>
                    <span class="" onclick="bbs()"><em></em>����</span>
                    <span class=""><em></em>��Ա</span>
                </div>
                <div class="clubn">
                    <ul>
                        <li id="f01" class="listmore">�鿴����</li>
                    </ul>

                </div>
                <%--   <div class="clubn clubimg account">
                    <ul>
                        <li><a href="/user/100000093.aspx" target="_blank" class="user-head">
                            <img src="http://img.erun360.com/member/uploads/2012-10-30/100000093.jpg"></a><a class="deusername" href="/user/100000093.aspx" target="_blank">��������</a> �ϴ��� <a href="/blog/200010169.aspx" target="_blank">2013�Ϻ�������������������֪</a><p>
                                <img src="http://s4.sinaimg.cn/mw690/8117bd0fgx6CH5RjHDt13&690"><img src="http://s4.sinaimg.cn/mw690/8117bd0fgx6CH5RjHDt13&690"><img src="http://s4.sinaimg.cn/mw690/8117bd0fgx6CH5RjHDt13&690">
                            </p>
                            <div class="relevance">2013/9/16 15:11:02</div>
                        </li>

                    </ul>
                </div>--%>
                <div class="clubn clubnhd account" style="display:none">
                    <a class="privacy" href="/infocenter/ToRan.aspx?uId=<%=cId%>" target="_blank" >[ ����� ]</a>
                    <ul>
                        <li class="listmore" id="c01">������ظ���...</li>
                    </ul>
                </div>
                <div  class="bbs clubn">
                    <a href="javascript:void(0)" onclick="privacy()" class="privacy">[ ��������˽���� ]</a>
                    <form id="Form1" runat="server">
                    <div class=" clubdisz ">
                        <div class="distip">�������Ǵ˾��ֲ���Ա���� <a onclick="JoinClub()" href="javascript:void(0)">����</a> ��鿴</div>
                        <div class="clubbbs">
                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                            <ContentTemplate>
                                <div class="discuss-text">
                                    <ERUN360:Phiz runat="server" ID="Phiz" />
                                    <input value="200006252" name="idBlog" id="idBlog" type="hidden">
                                    <textarea runat="server" name="cContent" id="cContent" style="font-size: 14px; padding: 5px;" rows="3" cols="70"></textarea>
                                    <span id="lbtip" style="color: Red;" runat="server"></span>
                                    <asp:Button ID="btnDiscuss" class="submit" runat="server" Text="�ύ" OnClick="btnDiscuss_Click" />
                                </div>
                                <ul id="text">
                                    <%=DiscussList %>
                                </ul>
                                <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
                                    NextPageText="��һҳ" CssClass="pages"
                                    CurrentPageButtonClass="cpb" PrevPageText="��һҳ"
                                    OnPageChanged="pager_PageChanged" PageSize="10">
                                </webdiyer:AspNetPager>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        </div>
                    </div>
                </form>
                </div>
                <div class="clubn focus account">
                    <ul class="clubsq" style="display: none;">
                        <li>��������</li>
                        <li id="unmore" style="display: none;"></li>
                        <div class="check"><input type="checkbox" id="allcheck" onclick="allcheck(this)"><label for="allcheck">ȫѡ</label> <img src="/Html/images/audit.png" onclick="check()"></div>
                    </ul>
                    <ul class="clubulist">
                        <li>ȫ����Ա</li>
                        <li class="listmore" id="Umore">������ظ���...</li>
                        <div class="check" style="display: none;"><input type="checkbox" id="allcheck" onclick="allcheckout(this)"><label for="allcheckout">ȫѡ</label> <img src="/Html/images/checkout.png" onclick="checkout()"></div>
                    </ul>
                </div>
            </div>
            <div class="clubr">
                <div class="clrtit ggao">
                    ���ֲ�����
                </div>
                <div class="notice ggaox">
                    ����
                </div>
                <div class="dexiugai2">
                    <textarea id="Idmsg2"></textarea>
                    <input type="text" readonly="readonly" id="b3">
                </div>
                <div class="clrtit newuser">
                    ���³�Ա
                </div>
                <ul class="clubu">
                </ul>
            <%--    <div class="clrtit">
                    ���»
                </div>--%>
                <%--<ul class="clubhd">
                    <li><a href="">
                        <img src="/Html/images/as.jpg"><em>&bull;</em>&nbsp;��ɭ��԰10����Լ�� �ܺ󸯰�</a></li>
                    <li><a href="">
                        <img src="/Html/images/as.jpg"><em>&bull;</em>&nbsp;��ɭ��԰10����Լ�� �ܺ󸯰�</a></li>
                    <li><a href="">
                        <img src="/Html/images/as.jpg"><em>&bull;</em>&nbsp;��ɭ��԰10����Լ�� �ܺ󸯰�</a></li>
                    <li><a href="">
                        <img src="/Html/images/as.jpg"><em>&bull;</em>&nbsp;��ɭ��԰10����Լ�� �ܺ󸯰�</a></li>
                </ul>--%>
            </div>
            <div class="clear"></div>
        </article>
    </div>
    <div style="display: none;">
        <div id="joinbox">
        <h3>��������</h3>
        <textarea id="Idmsg4"></textarea>
        <input type="text" readonly="readonly" id="b4">
        <a href="javascript:void(0)" onclick="JoinClubP()"></a>
        </div>
        <div id="closebox">
        <img src="/Html/images/question.png" >  �˳����������ݽ������ھ��ֲ�����ʾ�Ƿ�ȷ���˳��þ��ֲ��� <br>
        <a href="javascript:void(0)" onclick="Clubtcp()" class="closeqd"></a>&nbsp;&nbsp;
        <a href="javascript:void(0)" onclick="closeqx()" class="closeqx"></a>
        </div>
        <div id="privacybox">
            <div class="privacyn">
                <img src="/Html/images/question.png" alt=""> ��������˽���� <br>
                <input type="radio" checked="checked" name="privacy" id="privacya" value="1" /><label for="privacya">�����˿ɼ�</label> <br>
                <input type="radio" name="privacy" id="privacyb" value="0" /><label for="privacyb">���޾��ֲ���Ա�ɼ�</label> <br>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="privacyok()" class="closeqd"></a>&nbsp;
                <a href="javascript:void(0)" onclick="closeqx()" class="closeqx"></a>
            </div>
        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    <script type="text/javascript">
        var clubid = <%=ClubId%>,
            gly,
            shenhe = "<div class=\"shenhe\">����ˣ������ĵȴ�...</div>",
            fulling = "<div class=\"shenhe\">�þ��ֲ���Ա����</div>",
            tc = "<a class=\"Clubtc\" href=\"javascript:void(0)\" onclick=\"Clubtc()\">�˳����ֲ�</a>",
            shenqing = "<a onclick=\"JoinClub()\" href=\"javascript:void(0)\" class=\"comec\"></a>"
        //��������
        //�ö�״̬�л�
        function qding(id){
                $.ajax({
                url: '/action/AjaxClub.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "ZDing", idClub: clubid,idSlave:id},
                success: function (data) {
                    if(data == "1"){
                        $(".q"+id).attr("src","/Html/images/qding.png")
                    }else if(data == "0"){
                        $(".q"+id).attr("src","/Html/images/gding.png")
                    }else{
                        console.log("����")
                    }
                }
                });
        }
        //ɾ������
        function dding(id){
            $.ajax({
                url: '/action/AjaxClub.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "delBlog", idClub: clubid,idSlave:id},
                success: function (data) {
                    if(data == "1"){
                        $(".li"+id).remove()
                    }
                }
                });
        }   
        //ҳ����������������
        function Bio(){
            //�޸Ľ���
            $(".cin p").hide()
            $(".dedit").hide()
            $(".cin textarea").empty().append($(".cin p").html())
            $(".dexiugai").show()
            $("#b2").after("<a class=\"dedit\" href=\"javascript:void(0)\" onclick=\"Biop()\">[����]</a><a class=\"dedit\" href=\"javascript:void(0)\" onclick=\"delre()\">[ȡ��]</a>")
        }
        function delre(){
            //�޸Ľ���ȡ��
            $(".dexiugai").hide()
            $(".cin p").show()
            $(".dedit").show()
        }
        function Biop(){
            //�ύ�޸Ľ���
            $.ajax({
                url: '/action/AjaxClub.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "Bio", idClub: clubid ,bio:encodeURIComponent($("#Idmsg").val())},
                success: function (data, textStatus, xhr) {
                    if(data == "1"){
                        $(".dexiugai").hide()
                        $(".cin p").show()
                        $(".dedit").show()
                        $(".cin p").empty().append($(".cin textarea").val())
                    }
                }
            });
        }
        function Notice(){
            //�޸Ĺ���
            $(".ggaox").hide()
            $(".dexiugai2 textarea").empty().append($(".ggaox").html())
            $(".dexiugai2").show()
            $(".ggedit").replaceWith("<a class=\"dedit\" href=\"javascript:void(0)\" onclick=\"Noticed()\">[ȡ��]</a><a class=\"dedit\" href=\"javascript:void(0)\" onclick=\"Noticep()\">[����]</a>")
        }
        function Noticed(){
            //�޸Ĺ���ȡ��
            $(".dexiugai2").hide()
            $(".ggaox").show()
            $(".ggao a").remove()
            $(".ggao").prepend('<a class=\"ggedit\" href=\"javascript:void(0)\" onclick=\"Notice()\">[�޸�]</a>')
        }
        function Noticep(){
            //�ύ�޸Ĺ���
            $.ajax({
                url: '/action/AjaxClub.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "Notice", idClub: clubid ,msg:encodeURIComponent($("#Idmsg2").val())},
                success: function (data, textStatus, xhr) {
                    if(data == "1"){
                        $(".dexiugai2").hide()
                        $(".ggaox").show()
                        $(".ggao a").remove()
                        $(".ggao").prepend('<a class=\"ggedit\" href=\"javascript:void(0)\" onclick=\"Notice()\">[�޸�]</a>')
                        $(".ggaox").empty().append($(".dexiugai2 textarea").val())
                    }
                }
            });
        }
        //������ⷽ��
            textAreaLimit("Idmsg", { lastMsgLabel: "b2" })
            textAreaLimit("Idmsg2", { lastMsgLabel: "b3" })
            textAreaLimit("Idmsg4", { lastMsgLabel: "b4" })
            function textAreaLimit(area, op) {
                var defaultOp = {
                    maxLength: 240 //��󳤶� 
                , IsNumber: false //ֻ�������� 
                , lastMsgLabel: null //��ʱ��ʾ�����������Input 
                , msg: "����������{0}������"
                , errorMsg: "���ָ��������������"
                };
                var label;
                if (typeof area == "string") {
                    area = document.getElementById(area);
                }
                if (!area) {
                    return;
                }
                for (var i in op) {
                    defaultOp[i] = op[i];
                }
                if (defaultOp.lastMsgLabel) {
                    if (typeof defaultOp.lastMsgLabel == "string") {
                        label = document.getElementById(defaultOp.lastMsgLabel);
                    }
                }
                if (defaultOp.IsNumber) {
                    area.style.imeMode = "Disabled";//IE 
                    area.onkeydown = function () {
                        return event.keyCode != 229;
                    }
                }
                area.onkeyup = function () {
                    if (defaultOp.IsNumber) {
                        this.value = this.value.replace(/\D/g, "");//IE֮��� 
                    }
                    if (this.value.length > defaultOp.maxLength) {
                        //------------------------------------------------------------------------------- 
                        //������ 
                        this.disabled = "disabled";
                        this.value = this.value.slice(0, defaultOp.maxLength);
                        this.removeAttribute("disabled");
                        this.focus();
                        //������ 
                        //�� 
                        //alert(defaultOp.errorMsg); 
                        //this.value = this.value.slice(0,defaultOp.maxLength); 
                        //------------------------------------------------------------------------------- 
                    }
                    if (label) {
                        label.value = defaultOp.msg.replace(/\{0\}/, defaultOp.maxLength - this.value.length);
                    }
                }
            }
        //����js��һ����ѯ
            function JoinClub(){
                $.ajax({
                url: '/action/AjaxClub.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "Join", idClub: clubid,op:"0"},
                success: function (data, textStatus, xhr) {
                    if(data == "-1"){
                        //δ��¼������¼��
                        PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();
                        }else if(data == "0"){
                            //�ѵ�¼δ����
                            $.colorbox({ inline: true,href:"#joinbox", width: "484px", height: "306px", opacity: "0.4" });
                        }else if(data == "1"){
                            //�Ѽ�������
                            $.colorbox.close();
                            $(".comec").replaceWith(shenhe)
                        }else if(data == "2"){
                            $.colorbox.close();
                            $(".comec").hide()
                            $(".cin h1").append(tc)
                            $(".fenxiang").css('height', 'auto');
                        }else if(data == "4"){
                            //�ѵ�¼δ����
                            $(".comec").replaceWith(fulling)
                        }
                }
                });
            }
            //����js�ڶ���ִ�в���
            function JoinClubP(){
                $.ajax({
                url: '/action/AjaxClub.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "Join", idClub: clubid,op:"1",msg:encodeURIComponent($("#Idmsg4").val())},
                success: function (data, textStatus, xhr) {
                    if(data == "1"){
                        $.colorbox.close();
                        $(".comec").replaceWith(shenhe)
                    }else if(data == "2"){
                        
                    }
                }
                });
            }
            //�˳����ֲ�ѯ�ʿ�
            function Clubtc(){
                $.ajax({
                url: '/action/AjaxClub.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "Join", idClub: clubid,op:"0"},
                success: function (data, textStatus, xhr) {
                    if(data == "-1"){
                        //δ��¼������¼��
                        PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();
                        }else if(data == "0"){
                            //�ѵ�¼δ����
                            $(".Clubtc").replaceWith(shenqing)
                        }else if(data == "1"){
                            //�Ѽ�������
                            $.colorbox.close();
                            $(".comec").replaceWith(shenhe)
                        }else if(data == "2"){
                            //����ѯ��
                            $.colorbox({ inline: true,href:"#closebox", width: "356px", height: "172px", opacity: "0.4" });
                        }
                }
                });
            }
            //�˳����ֲ�
            function Clubtcp(){
                $.ajax({
                url: '/action/AjaxClub.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "Join", idClub: clubid,op:"1"},
                success: function (data, textStatus, xhr) {
                    $.colorbox.close();
                    if(data == "-1"){
                        //δ��¼������¼��
                        $(".Clubtc").replaceWith(shenqing)
                        PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();
                        }else if(data == "0"){
                            $(".Clubtc").remove()
                           $(".comec").show().replaceWith(shenqing)
                        }else if(data == "1"){
                            $(".Clubtc").remove()
                           $(".comec").show().replaceWith(shenhe)
                        }else if(data == "2"){
                            $(".comec").hide()
                            $(".cin h1").append(tc)
                            $(".fenxiang").css('height', 'auto');
                        }else if(data == "3"){
                           $(".Clubtc").remove()
                           $(".comec").show().replaceWith(shenqing)
                        }

                }
                });
            }
            function closeqx(){
                $.colorbox.close();
            }
        jQuery(document).ready(function($) {
            //���ػ�������
                    $.ajax({
                        url: '/action/AjaxClub.ashx?command=ClubInfo&idClub='+clubid,
                        type: 'get',
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',                        
                        cache: false,
                        beforeSend: function () {
                            $("body").append("<div class=\"cluberror\">���ڼ�����...</div>");
                        },
                        success: function (data) {
                            $.each(data.ds, function (i,item) {
                                gly = item.gly;
                                pageup("1", "10", clubid, "#f01", "0");
                                $(".clubimg").attr('href', "/user/"+item.idUser+".aspx")
                                $(".clubimg img").attr('src', item.cAvatar)
                                $(".cin h1 a").html(item.cTitle)
                                $(".cin h1 a").attr('href', "/user/"+item.idUser+".aspx")
                                $(".cin span").html("���£�"+item.BlogCount+" | ��Ա��"+item.MemberERCount+"/"+item.iMemberLimit)
                                $(".cin p").html(item.cDescription)
                                $(".notice").html(item.cNotice)
                                if(item.iStates == "1" ){
                                    $("input[name=privacy][value=1]").attr("checked",true);
                                }else if(item.iStates == "0"){
                                    $("input[name=privacy][value=0]").attr("checked",true);
                                }
                                if(item.state == "1"){
                                    $(".clubbbs").show()
                                    $(".distip").hide()
                                }
                                
                                
                                if(gly == "1"){
                                    $(".fenxiang").css('height', 'auto');
                                    $(".cin p").after("<a class=\"dedit\" href=\"javascript:void(0)\" onclick=\"Bio()\">[�޸�]</a>")
                                    $(".ggao").prepend('<a class=\"ggedit\" href=\"javascript:void(0)\" onclick=\"Notice()\">[�޸�]</a>')
                                    $(".comec").hide();
                                    //��˽������ʾ
                                    $(".privacy").show();

                                }else{
                                    //��������״̬
                                        $.ajax({
                                    url: '/action/AjaxClub.ashx',
                                    type: 'GET',
                                    dataType: 'text',
                                    data: { command: "Join", idClub: clubid,op:"0"},
                                    success: function (data, textStatus, xhr) {
                                        if(gly == "1"){
                                            $(".comec").hide();
                                        }else{
                                            if(data == "1"){
                                                //�Ѽ�������
                                                $(".comec").replaceWith(shenhe)
                                            }else if(data == "2"){
                                                //�Ѿ�������ֲ�
                                                $(".comec").hide()
                                                $(".cin h1").append(tc)
                                                $(".fenxiang").css('height', 'auto');
                                            }
                                        }
                                    }
                                    });
                                }
                            })
                        },
                        complete: function () { 
                            $(".cluberror").hide();
                        },
                        error: function (xhr) {
                            $("body").append("<div class=\"cluberror\">���ݼ���ʧ��</div>");
                        }
                    });
            //�������³�Ա
            $.ajax({
                        url: '/action/AjaxClub.ashx?command=ClubNewMember&idClub='+clubid,
                        type: 'get',
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',                        
                        cache: false,
                        success: function (data) {
                            $.each(data.ds, function (i,item) {
                                if(data.ds[i].States == "-1" || data.ds[i].States == "3"){
                                    $(".clubu").append("<li><a href=\"/user/" + data.ds[i].idUser + ".aspx\" target=\"_blank\"><img src=\"" + data.ds[i].cAvatar + "\">" + data.ds[i].cNickName + "</a><p>" + data.ds[i].cBio + "</p></li>");
                                }else if(data.ds[i].States == "0"){
                                    $(".clubu").append("<li><a href=\"/user/" + data.ds[i].idUser + ".aspx\" target=\"_blank\"><img src=\"" + data.ds[i].cAvatar + "\">" + data.ds[i].cNickName + "</a><p>" + data.ds[i].cBio + "</p><a class=\"focus-a focus0 uid"+data.ds[i].idUser+"\" onclick=\"ciFocus("+data.ds[i].idUser+")\">��עTA</a><a class=\"focus-b article-up-iframe cboxElement\" href=\"/infocenter/PostMessage.aspx?uId=" + data.ds[i].idUser + "\">��TA����</a></li>");
                                }else if(data.ds[i].States == "1"){
                                    $(".clubu").append("<li><a href=\"/user/" + data.ds[i].idUser + ".aspx\" target=\"_blank\"><img src=\"" + data.ds[i].cAvatar + "\">" + data.ds[i].cNickName + "</a><p>" + data.ds[i].cBio + "</p><a class=\"focus-a focus0\">�ѹ�ע</a><a class=\"focus-b article-up-iframe cboxElement\" href=\"/infocenter/PostMessage.aspx?uId=" + data.ds[i].idUser + "\">��TA����</a></li>");
                                }else if(data.ds[i].States == "2"){
                                    $(".clubu").append("<li><a href=\"/user/" + data.ds[i].idUser + ".aspx\" target=\"_blank\"><img src=\"" + data.ds[i].cAvatar + "\">" + data.ds[i].cNickName + "</a><p>" + data.ds[i].cBio + "</p><a class=\"focus-a focus0\">�໥��ע</a><a class=\"focus-b article-up-iframe cboxElement\" href=\"/infocenter/PostMessage.aspx?uId=" + data.ds[i].idUser + "\">��TA����</a></li>");
                                }

// $(".article-up-iframe").on('click', function(e){
// $(this).colorbox({href: $(this).attr('href'), iframe:true, width: 432, innerHeight:200, open:true,opacity: "0.4"});
// e.preventDefault();
// return false;
// });



                            })
                            //����
                            
                        }
                    });
            //��������
            function pageup(pageIndex, pageSize, cid, divid, group) {
                    //data = "pageIndex="+pageIndex+"&pageSize="+pageSize;
                    $.ajax({
                        url: '/action/AjaxClub.ashx?command=ClubBlog&idClub='+cid+'&pageIndex=' + pageIndex + '&pageSize=' + pageSize + '&group=' + group,
                        type: 'get',
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',                        
                        cache: false,
                        beforeSend: function () {
                            $(divid).html("<span class=\"load\"></span>���ڼ�����...");
                        },
                        success: function (data) {
                            var pagenum = data.count,
                                pagedata = data.ds,
                                ding
                            $.each(pagedata, function (i) {
                                switch (pagedata[i].idGroup) {
                                    case "22":
                                        if(gly == "1" ){
                                            if(pagedata[i].zDing){
                                                ding = "&nbsp;&nbsp;<img class=\"q"+pagedata[i].idBlog+"\" onclick=\"qding("+pagedata[i].idBlog+")\" src=\"/Html/images/qding.png\">&nbsp;&nbsp;<img class=\"qding\" onclick=\"dding("+pagedata[i].idBlog+")\" src=\"/Html/images/dding.png\">"
                                            }else{
                                                ding = "&nbsp;&nbsp;<img class=\"q"+pagedata[i].idBlog+"\" onclick=\"qding("+pagedata[i].idBlog+")\" src=\"/Html/images/gding.png\">&nbsp;&nbsp;<img class=\"qding\" onclick=\"dding("+pagedata[i].idBlog+")\" src=\"/Html/images/dding.png\">"
                                            }
                                        }else{
                                            if(pagedata[i].zDing){
                                                ding = "&nbsp;&nbsp;<img src=\"/Html/images/ding.png\">"
                                            }else{
                                                ding = "2"
                                            }
                                        }
                                        var simg = "";
                                            if(pagedata[i].cImageUrl){
                                                simg = "<a href=\"/blog/" + pagedata[i].idBlog + ".aspx\"><img src=\"" + pagedata[i].cImageUrl + "\"></a>"
                                            }
                                        $(divid).before("<li class=\"li"+pagedata[i].idBlog+"\"><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> �������ģ�<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a>"+ding+"<p>" + pagedata[i].cBio + simg +"</p><div class=\"relevance\">" + pagedata[i].dCreate + "<span>�Ķ�(" + pagedata[i].iShowTimes + ") ��ע(" + pagedata[i].iFocus + ") ��(" + pagedata[i].iDing + ") ����(" + pagedata[i].iDiscuss + ") </span></div></li>");
                                        break;
                                    case "23":
                                        $(divid).before("<li class=\"li"+pagedata[i].idBlog+"\"><a class=\"user-head\" target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\"><img src=\"" + pagedata[i].cAvatar + "\"></a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cNickName + "</a> �������£�<a target=\"_blank\" href=\"/blog/" + pagedata[i].idBlog + ".aspx\">" + pagedata[i].cTitle + "</a><p>" + pagedata[i].cBio + "<img src=\"" + pagedata[i].cImageUrl + "\"></p><div class=\"relevance\">" + pagedata[i].dCreate + "<span>�Ķ�(" + pagedata[i].iShowTimes + ") ��ע(" + pagedata[i].iFocus + ") ��(" + pagedata[i].iDing + ") ����(" + pagedata[i].iDiscuss + ") </span></div></li>");
                                        break;
                                }
                            })
                            thiscount = data.count;
                        },
                        complete: function () { //���ɷ�ҳ��
                            if (thiscount == "0") {
                                $(divid).html("ľ����...");
                            } else {
                                $(divid).html("������ظ���...");
                            }
                        },
                        error: function (xhr) {
                        }

                    });
                }
                var thispage = "2"
                $("#f01").click(function () {
                    pageup(thispage, "10", clubid, "#f01", "0");
                    thispage++
                })
        });
        // ��Ϣ�л�
        $(".equip span").click(function () {
            var a = $(this).index();
            $(".clubl .clubn").hide();
            $(".clubl .clubn").eq(a).show();
            $(".equip span").removeClass("equip-ous");
            $(this).addClass("equip-ous");
            location.href = "#"+a
        })
        function rewith(idx){
            $(".uid"+idx).replaceWith("<a class=\"focus-a focus0\">�ѹ�ע</a>")
        }
        function ciFocus(idx) {
            // if (confirm("ȷ��Ҫ��ע��") == true) {
                
            // }
            function refouc(idx){
                var idx = idx
            var refou = setTimeout("rewith("+idx+")",1000)
            }
            $.get("/action/GetFoucsList.ashx", { uId: idx, command: "addFoucs", timestamp: new Date().getTime() }, function (data) {
                    if (data == "1") {
                        focuscont = "<img src=\"/Html/images/right.png\"> ��ע�ɹ�";
                    } else {
                        focuscont = "<img src=\"/Html/images/false.png\">" + data;
                    }
                    $(".uid"+idx).append("<div class=\"focusalert\">" + focuscont + "</div>");
                    refouc(idx)
                    
                });
        }
        function cFocus(idx) {
            if (confirm("ȷ��Ҫȡ����ע��") == true) {
                $.get("/action/GetFoucsList.ashx", { uId: idx, command: "delFoucs", timestamp: new Date().getTime() }, function (result) {
                    if (result == "OK") {

                        alert(result);
                    }
                    else {
                        alert(result);
                    }
                });
            }
        }
        //���Ա���
        function EmotionAdd(v) {
            document.getElementById("cContent").value += "[" + v + "]";
        }
        $('#text').emotions();
        function ajax() {
            var obj = GetObject(cContent.value);
            alert(obj.String)
        }
        //��ʾ����
        function bbs(){
            $(".bbs").show()
        }
        //��ȡ��Ա�б�
        function Upageup(pageIndex, pageSize, cid, divid, op) {

                    $.ajax({
                        url: '/action/AjaxClub.ashx?command=ClubMember&idClub='+cid+'&pageIndex=' + pageIndex + '&pageSize=' + pageSize + '&op=' + op,
                        type: 'get',
                        dataType: 'json',
                        contentType: 'application/json;charset=utf-8',                        
                        cache: false,
                        beforeSend: function () {
                            $(divid).html("<span class=\"load\"></span>���ڼ�����...");
                        },
                        success: function (data) {
                            var pagenum = data.count,
                                ding
                            $.each(data.ds, function (i,item) {
                                var name
                                if(op == "1"){
                                     name = "check"
                                    if(pagenum > "0"){
                                        $(".newuser").html('<a onclick="newuser()" href="javascript:void(0)" >['+pagenum+'���³�Ա����]</a>���³�Ա')
                                    }
                                }else{
                                     name = "checkout"
                                }
                                if(gly == "1" ){
                                    ding = "<input type=\"checkbox\" name=\""+name+"\" value=\"" + data.ds[i].idUser + "\">"
                                }else{
                                    ding = ""
                                }
                                if(data.ds[i].States == "-1"||data.ds[i].States == "3"){
                                    $(divid).before("<li>"+ding+"<a href=\"/user/" + data.ds[i].idUser + ".aspx\" target=\"_blank\"><img src=\"" + data.ds[i].cAvatar + "\">" + data.ds[i].cNickName + "</a><p>" + data.ds[i].cBio + "</p></li>");
                                }else if(data.ds[i].States == "0"){
                                    $(divid).before("<li>"+ding+"<a href=\"/user/" + data.ds[i].idUser + ".aspx\" target=\"_blank\"><img src=\"" + data.ds[i].cAvatar + "\">" + data.ds[i].cNickName + "</a><p>" + data.ds[i].cBio + "</p><a class=\"focus-a focus0 uid"+data.ds[i].idUser+"\" onclick=\"ciFocus("+data.ds[i].idUser+")\">��עTA</a><a class=\"focus-b article-up-iframe cboxElement\" href=\"/infocenter/PostMessage.aspx?uId=" + data.ds[i].idUser + "\">��TA����</a></li>");
                                }else if(data.ds[i].States == "1"){
                                    $(divid).before("<li>"+ding+"<a href=\"/user/" + data.ds[i].idUser + ".aspx\" target=\"_blank\"><img src=\"" + data.ds[i].cAvatar + "\">" + data.ds[i].cNickName + "</a><p>" + data.ds[i].cBio + "</p><a class=\"focus-a focus0\">�ѹ�ע</a><a class=\"focus-b article-up-iframe cboxElement\" href=\"/infocenter/PostMessage.aspx?uId=" + data.ds[i].idUser + "\">��TA����</a></li>");
                                }else if(data.ds[i].States == "2"){
                                    $(divid).before("<li>"+ding+"<a href=\"/user/" + data.ds[i].idUser + ".aspx\" target=\"_blank\"><img src=\"" + data.ds[i].cAvatar + "\">" + data.ds[i].cNickName + "</a><p>" + data.ds[i].cBio + "</p><a class=\"focus-a focus0\">�໥��ע</a><a class=\"focus-b article-up-iframe cboxElement\" href=\"/infocenter/PostMessage.aspx?uId=" + data.ds[i].idUser + "\">��TA����</a></li>");
                                }
                            
                            })
                            //����
                            $(".article-up-iframe").on('click', function(e){
                            $(this).colorbox({href: $(this).attr('href'), iframe:true, width: 432, innerHeight:200, open:true,opacity: "0.4"});
                            e.preventDefault();
                            return false;
                            }); 
                            thiscount = data.count;
                        },
                        complete: function () { //���ɷ�ҳ��
                            if (thiscount == "0") {
                                $(divid).html("ľ����...");
                            } else {
                                $(divid).html("������ظ���...");
                            }
                        },
                        error: function (xhr) {
                        }

                    });
                }
                 userload = "0";
        function clubUser(){
                if (userload == "0") {
                    Upageup("1", "10", clubid, "#Umore", "2");
                    userload = "1";
                    var thispage = "2"
                    $("#Umore").click(function () {
                    Upageup(thispage, "10", clubid, "#Umore", "2");
                    thispage++
                    })
                    if(gly == "1"){
                        $(".clubsq").show();
                        $(".check").show();
                        Upageup("1", "10", clubid, "#unmore", "1");
                    }
                }
        }
        //�
        function pageuphd(pageIndex, pageSize, uid, divid, op) {
                $.ajax({
                    url: '/action/AjaxClub.ashx',
                    data: { command: "raceList", uId: uid, pageIndex: pageIndex, pageSize: pageSize, op: op, rnd: Math.random() },
                    type: 'get',
                    dataType: 'json',
                    contentType: 'application/json;charset=utf-8',
                    cache: false,
                    beforeSend: function () {
                        $(divid).html("<span class=\"load\"></span>���ڼ�����...");
                    },
                    success: function (data) {
                        var pagenum = data.count,
                            pagedata = data.ds
                        $.each(pagedata, function (i) {
                            $(divid).before("<li><a class=\"deusername\" href=\"/user/" + pagedata[i].idUser + ".aspx\" target=\"_blank\">"+ pagedata[i].cLoginname +"</a> ������ <a href=\"/race/" + pagedata[i].id + ".aspx\" target=\"_blank\">" + pagedata[i].cTitle + pagedata[i].state + "</a><div class=\"relevance\">" + pagedata[i].dCreate + "<span>�Ķ�(" + pagedata[i].iShowTimes + ") ��ע(" + pagedata[i].iFocus + ") ��(" + pagedata[i].iDing + ") ����(" + pagedata[i].iDiscuss + ") </span></div></li>");

//+ pagedata[i].state 




                        })
                        thiscount = data.count;
                        //$("ul li span a").css("float", "right");
                        $("ul li span a").css("display", "inline");
                    },
                    complete: function () { //���ɷ�ҳ��
                        if (thiscount == "") {
                            $(divid).html("ľ����");
                        } else {
                            $(divid).html("������ظ���...");
                        }
                    },
                    error: function (xhr) {
                    }

                });
            }
        pageuphd("1", "10", '<%=cId%>', "#c01", "1");
            var thispage = "2"
            $("#c01").click(function () {
                pageuphd(thispage, "10", '<%=cId%>', "#c01", "1");
                thispage++
            })
        //��˳�Ա�Ƴ���Ա����
        function check(){
            var cuid='',
                lieq='',
                fornum = "0"
            $('.clubsq input[name="check"]:checked').each(function(){
                cuid+=$(this).val()+','
                lieq+=$(this).parent('li').index()
                fornum++
            })
            lieq = lieq.split("").reverse()
            if(cuid){
                cuid = cuid.substring(0,cuid.length-1)
                $.ajax({
                url: '/action/AjaxClub.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "Audit", idClub: clubid,idUser:cuid},
                success: function (data) {
                    if(data == "1"){
                        for(var i=0;i<fornum;++i){
                            $(".clubsq li").eq(lieq[i]).remove();
                        }
                    }
                }
                });
            }
        }
        function allcheck(checkbox){
            $('.clubsq input[type=checkbox]').prop('checked', $(checkbox).prop('checked'));
        }
        function checkout(){
            var cuid='',
                lieq='',
                fornum = "0"
            $('.clubulist input[name="checkout"]:checked').each(function(){
                cuid+=$(this).val()+','
                lieq+=$(this).parent('li').index()
                fornum++
            })
            lieq = lieq.split("").reverse()
            if(cuid){
                cuid = cuid.substring(0,cuid.length-1)
                $.ajax({
                url: '/action/AjaxClub.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "DelUser", idClub: clubid,idUser:cuid},
                success: function (data) {
                    if(data == "1"){
                        for(var i=0;i<fornum;++i){
                            $(".clubulist li").eq(lieq[i]).remove();
                        }
                    }
                }
                });
            }
        }
        function allcheckout(checkbox){
            $('.clubulist input[type=checkbox]').prop('checked', $(checkbox).prop('checked'));
        }
        //��˽����
        function privacy(){
            $.colorbox({ inline: true,href:"#privacybox", width: "320px", height: "180px", opacity: "0.4" });
        }
        function privacyok(){
            var privacykey = $("input[name='privacy']:checked").val();
            $.ajax({
                url: '/action/AjaxClub.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "Setting", idClub: clubid,set:privacykey},
                success: function (data) {
                    if(data == "1"){
                        $.colorbox.close();
                    }
                }
                });
        }
        var t = setTimeout("clubUser()", 1000)
        function newuser(){
            location.href = "#3"
            $("article .clubn").hide();
            $("article .clubn").eq("3").show();
            $(".equip span").removeClass("equip-ous");
            $(".equip span").eq("3").addClass("equip-ous");
        }
        // ˢ��ҳ���ǩ�Զ��л�
            var loca=location.hash.split("#", 2)[1];
                if(!loca || loca > 4){
                    loca = "0"
                }
                $("article .clubn").hide();
                $("article .clubn").eq(loca).show();
                $(".equip span").removeClass("equip-ous");
                $(".equip span").eq(loca).addClass("equip-ous");
//���Ʋ��
$(document).ready(function(){
    thisurl = window.location.href
    $('#copyUrl').zclip({
        path:'/Html/js/ZeroClipboard.swf',
        copy:thisurl
    });
    $("#sharewb").click(function(event) {
        window.open("http://service.weibo.com/share/share.php?url="+thisurl+"&type=button&ralateUid=2961848493&language=zh_cn&appkey=1VDwW4&searchPic=true&style=simple")
    });
});
    </script>
</body>
</html>
