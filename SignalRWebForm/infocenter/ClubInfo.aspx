<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClubInfo.aspx.cs" Inherits="infocenter_ClubInfo" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Phiz.ascx" TagPrefix="ERUN360" TagName="Phiz" %><%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="��http://open.weibo.com/wb��">
<head>
    <title><%=RaceName%>-����Լ��-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=B270492b31673137d9b3d5b1c8c8903a"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
        <div class="hdserchl">
            <div class="hntit">
                <a href="javascript:void(0)" class="title">����Լ��</a>
            </div>
            <div class="hntime">
                ������  <a href="javascript:void(0)" class="fdata"></a>
            </div>
            <div class="hnshow">
                <img src="/Html/images/ypimg.png" class="hdthumb">
                <table>
                    <tr>
                        <td><span>�ʱ��</span>��<a href="javascript:void(0)" class="dOpen"></a></td>
                        <td><span>��������</span>��<a href="javascript:void(0)" class="iLimit"></a></td>

                    </tr>
                    <tr>
                        <td><span>����ʱ��</span>��<a href="javascript:void(0)" class="dCollect"></a></td>
                        <td><span>�����</span>��<a href="javascript:void(0)" class="iFee"></a></td>

                    </tr>
                    <tr>
                        <td><span>ǿ��</span>��<a href="javascript:void(0)" class="iStrength"></a> </td>
                        <td><span>�����</span>��<a href="javascript:void(0)" class="iDistance"></a></td>

                    </tr>
                    <tr>
                        <td colspan="2"><p><span>��ص�</span>��<a href="javascript:void(0)" class="cAddress"></a></p></td>
                    </tr>
                    <tr>
                        <td colspan="2"><p><span>���ϵص�</span>��<a href="javascript:void(0)" class="cCollectAddress"></a></p></td>
                    </tr>
                    <tr>
                        <td colspan="2"><span>����ʱ��</span>��<a href="javascript:void(0)" class="dJoinBegin"></a></td>
                    </tr>
                    <tr>
                        <td colspan="2"><span>���ɫ</span>��<a href="javascript:void(0)" class="iWinner"></a></td>
                    </tr>
                </table>
                <a class="hnbm" href="javascript:void(0)" onclick="PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();"></a>
                <a class="hnsc" href="javascript:void(0)" onclick="PopupShowdl(520,305,'��¼','/utility/include/login.aspx');StatusCheck();"></a>
            </div>
            <div class="fenxiang"><a id="sharewb" href="javascript:void(0)"><img src="/Html/images/weiboc.png" alt=""> ��������΢��</a> | <a href="javascript:void(0)" id="copyUrl"><img src="/Html/images/fuzhi.png" alt="" >���Ƶ�ַ</a> | <a href="/infocenter/PostMessage.aspx" class="article-up-iframe"><img src="/Html/images/friend.png" alt="" >�����վ�ں���</a></div>
            <div class="equip"><span class="equip-ous">�����<em></em></span><span class=""><em></em>����</span><span class="userstate">��Ա״̬<em></em></span><span class="imgshare"><em></em>ͼ�ķ���</span></div>
            <div class="blog blognr">
                <div class="showmapw">
                    ���ϵص� <img src="/Html/images/hqx.png" alt="" />
                    <div id="showmap"></div>
                </div>
            </div>
            <div class="blog clubdisz  account">
                <form id="Form1" runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <div class="discuss-text">
                                <ERUN360:Phiz runat="server" ID="Phiz" />
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
                </form>
            </div>
            <div class="blog account mest">
                <span></span>
                <ul>
                </ul>
            </div>
            <div class="blog cfx account">
                <ul>
                    <li id="f01" class="listmore">������ظ���...</li>
                </ul>
            </div>
        </div>
        <div class="hdserchr">
            <div class="hdfq">
            </div>
            <div class="hdfo">
                <span><em></em>����������</span>
            </div>
            <div class="hdfu">
                <span>���ڳ�Ա</span>
            </div>
            <div class="hdfr">
                <span>���Ż</span>
            </div>
        </div>
    </div>
    <div style="display: none">
        <div id="delbox" class="tipbox">
            <img src="/Html/images/question.png">
            ȷ��ɾ����ɾ���󲻿ɻָ�
            <br>
            <a href="javascript:void(0)" onclick="Clubtcp()" class="closeqd"></a>&nbsp;&nbsp;
        <a href="javascript:void(0)" onclick="closeqx()" class="closeqx"></a>
        </div>
        <div id="successful">
            <img src="/Html/images/true.png">
            �ɹ�
        </div>
        <div id="failure">
            <img src="/Html/images/prompt.png">
            ʧ��
        </div>
        <div id="apply">

            <label for="name">������</label><input type="text" id="name" value="<%=Name%>"/>
            <label for="tel">�绰��</label><input type="text" id="tel" value="<%=tel%>" /><br />
            <label for="applybz">��ע��</label><textarea id="applybz" maxlength="50"></textarea><br />
            <p>���λ��Ҫ֧����<em></em>Ԫ </p>
            &nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" onclick="applyqd()" class="closeqd"></a>&nbsp;&nbsp;
        <a href="javascript:void(0)" onclick="closeqx()" class="closeqx"></a>
        </div>
        <div id="Signinyp" class="tipbox">
            <img src="/Html/images/question.png">
            �Ըó�Ա����ǩ����
            <br>
            <a href="javascript:void(0)" onclick="Signinypf()" class="closeqd"></a>&nbsp;&nbsp;
        <a href="javascript:void(0)" onclick="closeqx()" class="closeqx"></a>
        </div>
        <div id="deleteyp" class="tipbox">
            <img src="/Html/images/question.png">
            ɾ���ó�Ա��ɾ���󲻿ɻָ�
            <br>
            <a href="javascript:void(0)" onclick="deleteypf()" class="closeqd"></a>&nbsp;&nbsp;
        <a href="javascript:void(0)" onclick="closeqx()" class="closeqx"></a>
        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    <script type="text/javascript">
        idRace = <%=idRace%>
        gId = <%=gId%>
        //���Ż
        $.ajax({
            url: '/action/AjaxRace.ashx?command=toprace',
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
            },
            success: function (data) {
                $.each(data.ds, function (i, item) {
                    if (item.cImage) {
                        cimg = item.cImage
                    } else {
                        cimg = "/Html/images/ypimg.png"
                    }
                    $(".hdfr").append('<a href=\"/race/' + item.id + '.aspx\" title=\"' + item.cTitle + '\"><img src=\"' + cimg + '\"></a>')
                })
            },
            complete: function () {
                $(".cluberror").hide();
            },
            error: function (xhr) {
                $("body").append("<div class=\"cluberror\">���ݼ���ʧ��</div>");
            }
        });
        //����������
        $.ajax({
            url: '/action/AjaxRace.ashx?command=other&idRace=' + idRace,
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
            },
            success: function (data) {
                $.each(data.ds, function (i, item) {
                    if (item.cImage) {
                        cimg = item.cImage
                    } else {
                        cimg = "/Html/images/ypimg.png"
                    }
                    $(".hdfo").append('<a href=\"/race/' + item.id + '.aspx\" title=\"' + item.cTitle + '\"><img src=\"' + cimg + '\"></a>')
                })
            },
            complete: function () {
                $(".cluberror").hide();
            },
            error: function (xhr) {
                $("body").append("<div class=\"cluberror\">���ݼ���ʧ��</div>");
            }
        });
        //���ڳ�Ա
        $.ajax({
            url: '/action/AjaxRace.ashx?command=ClubNewMember&op=1&idRace=' + idRace,
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
            },
            success: function (data) {
                $.each(data.ds, function (i, item) {
                    $(".hdfu").append('<a href=\"/user/' + item.idUser + '.aspx\" title=\"' + item.cLoginname + '\"><img src=\"' + item.cAvatar + '\"></a>')
                })
            },
            complete: function () {
                $(".cluberror").hide();
            },
            error: function (xhr) {
                $("body").append("<div class=\"cluberror\">���ݼ���ʧ��</div>");
            }
        });
        // ��Ϣ�л�
        $(".equip span").click(function () {
            var a = $(this).index();
            $(".hdserchl .blog").hide();
            $(".hdserchl .blog").eq(a).show();
            $(".equip span").removeClass("equip-ous");
            $(this).addClass("equip-ous");
        })
        //���Ա���
        function EmotionAdd(v) {
            document.getElementById("cContent").value += "[" + v + "]";
        }
        //$('#text').emotions();
        //��ȡ����
        $.ajax({
            url: '/action/AjaxRace.ashx?command=race&idRace=' + idRace,
            type: 'get',
            dataType: 'json',
            contentType: 'application/json;charset=utf-8',
            cache: false,
            beforeSend: function () {
                $("body").append("<div class=\"cluberror\">���ڼ�����...</div>");
            },
            success: function (data) {
                var iStrength = ["��", "��", "��", "��"],
                    iWinner = ["�޸���", "�н�Ʒ", "�з�", "�а೵", "��װ��", "����", "רҵ����"]
                $.each(data.ds, function (i, item) {
                    if (item.gly == "1") {
                        $(".hnbm").replaceWith('');
                        $(".hnsc").replaceWith('');
                        $('.mest span').append('<b onClick="window.open(\'/infocenter/Include/RaceToExcel.aspx?id='+idRace+'\')">���ر�������</b>')
                    } else {
                        regist()
                        Focust()
                    }
                    if (item.iFee > "0") {
                        iFee = item.iFee + "Ԫ"
                        $("#apply p em").html(item.iFee)
                        $("#apply p").show()
                    } else {
                        iFee = "���"
                    }
                    if (item.qx == '1') {
                        $('.hntime').append('   [<a href=\"/infocenter/ToRan.aspx?uId=' + item.idUser + '&bId=' + item.idBlog + '\">�༭</a>] [<a href=\"javascript:void(0)\" onclick=\"racedel()\">ɾ��</a>] ')
                        
                    }
                    $(".hntit .title").html(item.cTitle)
                    $(".hntit").append(item.state)
                    $(".fdata").html(item.dCreate)
                    $(".dOpen").html(item.dOpen)
                    $(".dCollect").html(item.dCollect)
                    $(".cAddress").html(item.cCityname + item.cAddress).attr('title', item.cCityname + item.cAddress);
                    $(".cCollectAddress").html(item.cCollectAddress).attr('title', item.cCollectAddress);
                    if (item.cImage) {
                        $(".hdthumb").attr('src', item.cImage).attr('onerror', 'this.src=\'/Html/images/ypimg.png\'');
                    }
                    $(".iStrength").html(iStrength[item.iStrength])
                    $(".iLimit").html(item.iLimit + "��")
                    $(".iDistance").html(item.iDistance + "km")
                    $(".iFee").html(iFee)
                    $(".dJoinBegin").html(item.dJoinBegin + "~" + item.dJoinEnd)
                    $(".iWinner").html(iWinner[item.iWinner])
                    $(".blognr").append(item.cContent)
                    if (item.cPoints) {
                        $(".showmapw").show()
                        var zb = item.cPoints
                        var zbs = new Array();
                        zbs = zb.split(",")
                        var map = new BMap.Map("showmap");
                        var newzb = new BMap.Point(zbs[0], zbs[1]);
                        map.centerAndZoom(newzb, 15);
                        map.enableScrollWheelZoom();
                        var myIcon = new BMap.Icon("/Html/images/star.png", new BMap.Size(35, 36));
                        var marker = new BMap.Marker(newzb,{icon:myIcon});
                        map.addOverlay(marker);
                    }
                    if(item.gz == "1"){
                        gz = "<a class=\"focus-a hdgz\">�ѹ�ע</a>"
                    }else{
                        gz = "<a class=\"hdgz\" href=\"javascript:void(0)\" onclick=\"iFocus(" + item.idUser + ",'hdgz')\">+ ��עTA</a>"
                    }
                    ggz = ""
                    if (gId != "-1" ) {
                        $(".equip").append('<a target=\"_blank\" href=\"/infocenter/postBlog.aspx?uId=' + gId + '&from=' + idRace + '\" class=\"sharefb\"><img src=\"/Html/images/ffenxiang.png\"></a>')
                        if(item.gly != '1'){
                            ggz = gz+"<a class=\"hdly\" href=\"javascript:void(0)\" rel=\"/infocenter/PostMessage.aspx?uId=" + item.idUser + "\">��TA����</a>"
                            $(".article-up-iframe").show()
                        }
                    }
                    $(".hdfq").html("<span>������</span><a href=\"/user/" + item.idUser + ".aspx\"><img src=\"" + item.cAvatar + "\"></a><a class=\"hdfname\" href=\"/user/" + item.idUser + ".aspx\">" + item.cNickName + "</a>" + ggz)
                    $(".hdfo span em").html(item.cNickName)
                    $(".hdly").on('click', function (e) {
                        $(this).colorbox({ href: $(this).attr('rel'), iframe: true, width: 432, innerHeight: 200, open: true, opacity: "0.4" });
                        e.preventDefault();
                        return false;
                    });
                    $(".article-up-iframe").on('click', function (e) {
                        $(this).colorbox({ href: $(this).attr('rel'), iframe: true, width: 432, innerHeight: 200, open: true, opacity: "0.4" });
                        e.preventDefault();
                        return false;
                    });
                    
                })
            },
            complete: function () {
                $(".cluberror").hide();
            },
            error: function (xhr) {
                $("body").append("<div class=\"cluberror\">���ݼ���ʧ��</div>");
            }
        });
        //��ȡ����״̬
        function regist() {
            $.get("/action/AjaxRace.ashx", { idRace: idRace, command: "apply", op: 0 }, function (data) {
                if (data == "0") {
                    //δ����
                    $(".hnbm").replaceWith('<a class=\"hnbm\" href=\"javascript:void(0)\" onclick=\"apply()\"></a>');
                } else if (data == "1") {
                    //δ����
                    $(".hnbm").replaceWith('<a class=\"hnbm yppay\" href=\"javascript:void(0)\" onclick=\"pay()\"></a>');
                } else if (data == "2") {
                    //�ѱ���
                    $(".hnbm").replaceWith('<a class=\"hnbm bmy\" href=\"javascript:void(0)\"></a>');
                } else if (data == "6") {
                    //δ��ʼ
                    $(".hnbm").replaceWith('<a class=\"hnbm wkais\" href=\"javascript:void(0)\"></a>');
                } else if (data == "4") {
                    //������
                    $(".hnbm").replaceWith('<a class=\"hnbm bmm\" href=\"javascript:void(0)\"></a>');
                } else if (data == "5") {
                    //������ֹ
                    $(".hnbm").replaceWith('<a class=\"hnbm bmz\" href=\"javascript:void(0)\"></a>');
                } else if (data == "-2") {
                    //������ ��ת������ҳ
                    window.location.href = '/infocenter/ClubSearch.aspx'
                }
            });
        }
        //��ȡ��ע״̬
        function Focust() {
            $.get("/action/AjaxRace.ashx", { idRace: idRace, command: "focus", op: 0 }, function (data) {
                if (data == "2") {
                    //�ѹ�ע
                    $(".hnsc").replaceWith('<a class=\"hnsc ygz\" href=\"javascript:void(0)\"></a>');
                } else if (data == "3") {
                    //δ��ע
                    $(".hnsc").replaceWith('<a class=\"hnsc\" href=\"javascript:void(0)\" onclick=\"focusyp()\"></a>');
                }
            });
        }
        function pay() {
            window.location.href = '/infocenter/RacePay.aspx?id=' + idRace;
        }

        function apply() {
            $.colorbox({ inline: true, href: "#apply", width: "471px", height: "282px", opacity: "0.4" });
        }
        function applyqd() {
            $.get("/action/AjaxRace.ashx", { idRace: idRace, command: "apply", op: 1, name: encodeURIComponent($("#name").val()), tel: $("#tel").val(), bz: encodeURIComponent($("#applybz").val()) }, function (data) {
                if (data == "-1") {
                    //δ��¼
                    PopupShowdl(520, 305, '��¼', '/utility/include/login.aspx'); StatusCheck();

                } else if (data == "1") {
                    //�ɹ�
                    $.colorbox({ inline: true, href: "#successful", width: "266px", height: "102px", opacity: "0.4" });
                    setTimeout("$.colorbox.close();", 2000);                    
                    $(".hnbm").replaceWith('<a class=\"hnbm bmy\" href=\"javascript:void(0)\"></a>');
                    location.href = "/infocenter/RacePay.aspx?id=" + idRace;
                } else if (data == "0") {
                    //ʧ��
                    $.colorbox({ inline: true, href: "#failure", width: "266px", height: "102px", opacity: "0.4" });
                    setTimeout("window.location.reload()", 2000);

                }
            });
        }
        function focusyp() {
            $.get("/action/AjaxRace.ashx", { idRace: idRace, command: "focus", op: 1 }, function (data) {
                if (data == "-1") {
                    //δ��¼
                    PopupShowdl(520, 305, '��¼', '/utility/include/login.aspx'); StatusCheck();

                } else if (data == "1") {
                    //�ɹ�
                    $.colorbox({ inline: true, href: "#successful", width: "266px", height: "102px", opacity: "0.4" });
                    setTimeout("$.colorbox.close();", 2000);
                    $(".hnsc").replaceWith('<a class=\"hnsc ygz\" href=\"javascript:void(0)\"></a>');
                } else if (data == "0") {
                    //ʧ��
                    $.colorbox({ inline: true, href: "#failure", width: "266px", height: "102px", opacity: "0.4" });
                    setTimeout("window.location.reload()", 2000);

                } else if (data == "2") {
                    //�ѹ�ע
                    $.colorbox({ inline: true, href: "#successful", width: "266px", height: "102px", opacity: "0.4" });
                    setTimeout("$.colorbox.close();", 2000);
                    $(".hnsc").replaceWith('<a class=\"hnsc ygz\" href=\"javascript:void(0)\"></a>');
                }
            });
        }
        function iFocus(idx, thisa) {
            var thisa = "." + thisa;
            function thisare() {
                $(thisa).replaceWith("<a class=\"focus-a hdgz\">�ѹ�ע</a>")
            }
            if (confirm("ȷ��Ҫ��ע��") == true) {
                $.get("/action/GetFoucsList.ashx", { uId: idx, command: "addFoucs", timestamp: new Date().getTime() }, function (data) {
                    if (data == "1") {
                        focuscont = "<img src=\"/Html/images/right.png\"> ��ע�ɹ�";
                    } else {
                        focuscont = "<img src=\"/Html/images/false.png\">" + data;
                    }
                    $(thisa).append("<div class=\"focusalert\">" + focuscont + "</div>");
                    setTimeout(thisare, 2000);
                });
            }
        }
        //��Ա״̬
        mest = "0"
        $(".userstate").click(function (event) {
            if (mest == "0") {
                $.ajax({
                    url: '/action/AjaxRace.ashx?command=ClubNewMember&op=2&idRace=' + idRace,
                    type: 'get',
                    dataType: 'json',
                    contentType: 'application/json;charset=utf-8',
                    cache: false,
                    beforeSend: function () {
                    },
                    success: function (data) {
                        $(".mest span").append("����" + data.bmcount + "�˱�����" + data.wfkCount + "��δ���" + data.count + "��ǩ��")

                        $.each(data.ds, function (i, item) {
                            if (item.iStatus == "3") {
                                iStatus = '<em></em>'
                            } else {
                                iStatus = ''
                            }
                            if (item.cName) {
                                cName = item.cName
                                cstyle = "style=\"height:214px;line-height: 18px;\""
                            } else {
                                cName = ''
                                cstyle = ''
                            }
                            if (item.cTel) {
                                cTel = item.cTel
                                cstyle = "style=\"height:214px;line-height: 18px;\""
                            } else {
                                cTel = ''
                                cstyle = ''
                            }
                            var fk = ''
                            if(item.iStatus==1){
                                fk = '<i></i>'
                            }

                            $(".mest ul").append('<li '+cstyle+'><a data-mest=\"' + item.idUser + '\" href=\"/user/' + item.idUser + '.aspx\" title=\"' + item.cLoginname + '\"><img src=\"' + item.cAvatar + '\">' + item.cLoginname + '</a>' + '<br>' + cName + '&nbsp;&nbsp;' + cTel + iStatus + fk+'</li>')
                        })
                        mest = "1"
                        $(".mest a").on('click', function(event) {
                            event.preventDefault()
                            var idUser = $(this).data('mest')
                                url    = $(this).attr('href')
                            $.get("/action/AjaxRace.ashx", { command: "qdel", idRace: idRace,idUser:idUser,op:0 }, function (data) {
                                if (data == "0" || data == "-1" ) {
                                    location.href = url
                                }else if(data == "1"){
                                    //ǩ��
                                    $.colorbox({ inline: true, href: "#Signinyp", width: "306px", height: "132px", opacity: "0.4" });
                                    $("#Signinyp .closeqd").replaceWith('<a href=\"javascript:void(0)\" onclick=\"Signinypf('+idUser+')\" class=\"closeqd\"></a>');
                                }else if(data == "2"){
                                    //ɾ��
                                    $.colorbox({ inline: true, href: "#deleteyp", width: "306px", height: "132px", opacity: "0.4" });
                                    $("#deleteyp .closeqd").replaceWith('<a href=\"javascript:void(0)\" onclick=\"deleteypf('+idUser+')\" class=\"closeqd\"></a>');
                                }
                            });
                        });
                    },
                    complete: function () {
                        $(".cluberror").hide();
                    },
                    error: function (xhr) {
                        $("body").append("<div class=\"cluberror\">���ݼ���ʧ��</div>");
                    }
                });
            }
        });
        function Signinypf(idUser){
            $.get("/action/AjaxRace.ashx", { command: "qdel", idRace: idRace,idUser:idUser,op:1 }, function (data) {
                if (data == "-2" ) {
                    location.href = "/infocenter/ClubSearch.aspx"
                }else if(data == "-1"){
                    PopupShowdl(520, 305, '��¼', '/utility/include/login.aspx'); StatusCheck();
                }else if(data == "0" || data == "2"){
                    location.reload() 
                }else if(data == "1"){
                    $.colorbox({ inline: true, href: "#successful", width: "266px", height: "102px", opacity: "0.4" });
                    $(".mest a[data-mest="+idUser+"]").parent("li").append('<em></em>')
                    setTimeout("$.colorbox.close();", 2000);
                }
            });
        }
        function deleteypf(idUser){
            $.get("/action/AjaxRace.ashx", { command: "qdel", idRace: idRace,idUser:idUser,op:1 }, function (data) {
                if (data == "-2" ) {
                    location.href = "/infocenter/ClubSearch.aspx"
                }else if(data == "-1"){
                    PopupShowdl(520, 305, '��¼', '/utility/include/login.aspx'); StatusCheck();
                }else if(data == "0" || data == "2"){
                    location.reload() 
                }else if(data == "1"){
                    $.colorbox({ inline: true, href: "#successful", width: "266px", height: "102px", opacity: "0.4" });
                    $(".mest a[data-mest="+idUser+"]").parent("li").remove()
                    setTimeout("$.colorbox.close();", 2000);
                }
            });
        }
        //��ȡ����
        function pageup(pageIndex, pageSize, divid) {
            //data = "pageIndex="+pageIndex+"&pageSize="+pageSize;
            $.ajax({
                url: '/action/AjaxRace.ashx?command=blog&pageIndex=' + pageIndex + '&pageSize=' + pageSize + '&idRace=' + idRace,
                type: 'get',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                cache: false,
                beforeSend: function () {
                },
                success: function (data) {
                    var pagenum = data.count,
                        pagedata = data.ds
                    $.each(pagedata, function (i) {
                        if (pagedata[i].Thumbnails) {
                            cimg = pagedata[i].Thumbnails
                        } else {
                            cimg = ''
                        }
                        $(divid).before("<li><a class=\"user-head\" target=\"_blank\" href=\"/user/" + pagedata[i].idUser + ".aspx\">" + pagedata[i].cAvatar + "</a><a target=\"_blank\"  href=\"/user/" + pagedata[i].idUser + ".aspx\" class=\"deusername\">" + pagedata[i].cLoginname + "</a> �������ģ�<a target=\"_blank\" href=\"/blog/" + pagedata[i].id + ".aspx\">" + pagedata[i].cTitle + "</a><p>" + pagedata[i].cContent + cimg + "</p><div class=\"relevance\">" + pagedata[i].dCreate + "<span>�Ķ�(" + pagedata[i].iShowTimes + ") ��ע(" + pagedata[i].iFocus + ") ��(" + pagedata[i].iDing + ") ����(" + pagedata[i].iDiscuss + ") </span></div></li>");
                    })
                    thiscount = data.count;
                },
                complete: function () { //���ɷ�ҳ��
                    if (thiscount == "") {
                        $(divid).html("ľ����...");
                    } else {
                        $(divid).html("������ظ���...");
                    }
                },
                error: function (xhr) {
                }
            });
        }
        imgshare = "0"
        $(".imgshare").click(function (event) {
            if (imgshare == "0") {
                pageup("1", "10", "#f01");
                imgshare = "1"
            }
        });
        var thispage = "2"
        $("#f01").click(function () {
            pageup(thispage, "10", "#f01");
            thispage++
        })
        function racedel() {
            $.colorbox({ inline: true, href: "#delbox", width: "306px", height: "132px", opacity: "0.4" });
        }
        function closeqx() {
            $.colorbox.close();
        }
        function Clubtcp() {
            $.ajax({
                url: '/action/AjaxRace.ashx',
                type: 'GET',
                dataType: 'text',
                data: { command: "del", idRace: idRace },
                success: function (data) {
                    //$.colorbox.close();
                    if (data == "-1") {
                        //δ��¼������¼��
                        $(".Clubtc").replaceWith(shenqing)
                        PopupShowdl(520, 305, '��¼', '/utility/include/login.aspx'); StatusCheck();
                    } else if (data == "0") {
                        //ʧ����ʾ������
                        $.colorbox({ inline: true, href: "#failure", width: "266px", height: "102px", opacity: "0.4" });
                        setTimeout("window.location.href='/infocenter/Running.aspx?uId=" + gId + "'", 2000);
                    } else if (data == "1") {
                        //�ɹ�
                        $.colorbox({ inline: true, href: "#successful", width: "266px", height: "102px", opacity: "0.4" });
                        setTimeout("window.location.href='/infocenter/Running.aspx?uId=" + gId + "'", 2000);
                    }
                }
            });
        }
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
