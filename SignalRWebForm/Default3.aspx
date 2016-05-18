<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default3.aspx.cs" Inherits="Default3" %>

<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/mediaIndex.css" />
    <script type="text/javascript" src="/Common/jWeibo.js"></script>
    <script type="text/javascript" src="/Common/jQuery1.8.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Common/jquery.colorbox.js"></script>
    <style type="text/css">
        .nav li.h_sy em {
            background: url(/Images/index/adqbj.png) no-repeat center 49px;
        }

        .qrcodex {
            position: fixed;
            top: 0;
            right: 50%;
            margin-right: -540px;
            z-index: 99999;
            width: 45px;
            height: 45px;
            background: url(/images/qrcodex.png);
            box-shadow: 0 0 4px #000;
        }

        .qrcoded {
            width: 258px;
            height: 289px;
            background: url(/images/qrcoded.png);
            box-shadow: 0 0 13px #000;
        }

        .gg {
            margin-top: 17px;
        }
    </style>
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <a class="qrcodex iframe" href="/qrcode-help.html"></a>
    <div class="indecen ">
        <div class="connav">
            <form id="frmSearch" name="frmSearch" action="/infocenter/Search.aspx" method="post">
                <select id="fname" name="fname" style="display: none">
                    <option value="loginname">����</option>
                    <option selected value="title">�ұ���</option>
                    <option selected value="content">������</option>
                </select>
                <input type="text" id="word" name="word" value="���������⡢�ؼ���" onfocus="if(this.value=='���������⡢�ؼ���'){this.value='';this.style.color='#000000'}" onblur="if(this.value==''){this.value='���������⡢�ؼ���';this.style.color='#a9a9a9'}">
                <a id="serch" class="serch"></a>
                <div id="result">
                </div>
            </form>
            <script type="text/javascript" language="javascript">
                jQuery(document).ready(function ($) {
                    $(".qrcodex").hover(function () {
                        $(this).addClass("qrcoded");
                    }, function () {
                        $(this).removeClass("qrcoded");
                    })
                    $(".iframe").colorbox({ iframe: true, width: "394px", height: "606px", opacity: 0.7, });
                    $("#word").keyup(function () {
                        key = $(this).val().replace(/(^\s*)|(\s*$)/g, "");
                        xskey = key;
                        function cutstr(str, len) {
                            var str_length = 0;
                            var str_len = 0;
                            str_cut = new String();
                            str_len = str.length;
                            for (var i = 0; i < str_len; i++) {
                                a = str.charAt(i);
                                str_length++;
                                if (escape(a).length > 4) {
                                    //�����ַ��ĳ��Ⱦ�����֮�����4
                                    str_length++;
                                }
                                str_cut = str_cut.concat(a);
                                if (str_length >= len) {
                                    str_cut = str_cut.concat("...");
                                    return str_cut;
                                }
                            }
                            //��������ַ���С��ָ�����ȣ��򷵻�Դ�ַ�����
                            if (str_length < len) {
                                return str;
                            }
                        }
                        xskey = cutstr(xskey, 10);
                        html = "<ul><li><a href=\"/infocenter/Searchuser.aspx?searchname=" + key + "\">�ѡ�<em>" + xskey + "</em>����ص��û�</a></li><li><a href=\"/infocenter/Search.aspx?fname=title&word=" + key + "\">�ѡ�<em>" + xskey + "</em>����صı���</a></li><li style=\"border-bottom: 0\"><a href=\"/infocenter/Search.aspx?fname=content&word=" + key + "\">�ѡ�<em>" + xskey + "</em>����ص�����</a></li></ul>";
                        $("#result").empty("");
                        if (key == "") {
                            $("#result").hide();
                        } else {
                            $("#result").append(html);
                            $("#result").show();
                            $("#serch").attr('href', '/infocenter/Search.aspx??fname=title&word=' + key);
                        }
                        $("html").click(function () {
                            $("#result").hide();
                        })

                    })
                });
                // function SearchIt(){
                //     if(document.getElementById("word").value.length > 0){
                //         document.frmSearch.submit();
                //         return true;
                //     }
                //     return false;
                // }
            </script>
            <a href="/infocenter/Search.aspx">���²���</a>&nbsp;|
        <a href="/infocenter/Search.aspx?word=.">��������</a>&nbsp;|
        <!-- <a href="">��������</a>&nbsp;| -->
            <a href="/zt.aspx">ר��</a>&nbsp;|
            <a href="/Channels/Competetion/Album.aspx">�������</a>&nbsp;|
            <a href="/Competetion/SearchEvent.aspx">���±���</a>&nbsp;|
            <a href="/Channels/Competetion/internationalEvents.aspx">����ֱͨ��</a>
            <!-- <a href="">���ֲ�</a>&nbsp;| 
        <a href="">����</a> -->
            <a class="topkong"></a>
            <span>����������</span>
            <a href="/infocenter/Search.aspx?fname=title&word=%D0%C2%CA%D6">����</a>&nbsp;&nbsp;&nbsp;
        <a href="/infocenter/Search.aspx?fname=title&word=%C2%ED%C0%AD%CB%C9">������</a>&nbsp;&nbsp;&nbsp;
        <a href="/infocenter/Search.aspx?fname=title&word=%BC%F5%B7%CA">����</a>
        </div>
        <div class="indexctop">
            <div class="left">
                <%--<% =pf.Show(300101100) %>--%>
                <%=pf.Focusmap() %>
            </div>
            <div class="right" id="preview">
            </div>
            <script type="text/javascript">
                $.get("/Utility/Ajax/News.aspx", { rnd: MinuteRand() }, function (result) {
                    document.getElementById("preview").innerHTML = result;
                });
            </script>
        </div>
        <div class="left">
            <%=Gg.Advert(1) %>
            <div class="bjtj">
                <a href="/topics/300104100.aspx">�༭�Ƽ�</a>
            </div>
            <ul class="ypzlx">
                <% =pf.Show(300104100) %>
            </ul>
            <%=Gg.Advert(2) %>
            <div class="ypzl">
                <a href="/topics/300103100.aspx">����ר��</a>
            </div>
            <ul class="ypzlx">
                <% =pf.Show(300103100) %>
            </ul>
            <%=Gg.Advert(3) %>
            <div class="ht httong">
                <a href="/channels/competetion/" class="httitle">����&bull;����</a>
                <% =pf.Show(300117100) %>
            </div>

            <div class="ht">
                <a href="/channels/shoe/" class="httitle">�ܲ�װ��</a>
                <% =pf.Show(300112100) %>
            </div>
            <div class="ht htr">
                <a href="/channels/train/" class="httitle">�ܲ�ѵ��</a>
                <% =pf.Show(300111100) %>
            </div>
            <div class="ht">
                <a href="/channels/nutrition/" class="httitle">Ӫ��&bull;����</a>
                <% =pf.Show(300114100) %>
            </div>
            <div class="ht htr">
                <a href="/channels/health/" class="httitle">����&bull;�ָ�</a>
                <% =pf.Show(300118100) %>
            </div>
            <div class="ht ">
                <a href="/channels/beginner/" class="httitle">��������</a>
                <% =pf.Show(300115100) %>
            </div>
            <div class="ht htr">
                <a href="/channels/life/" class="httitle">�ܲ�����</a>
                <% =pf.Show(300116100) %>
            </div>
        </div>
        <div class="right">
            <%=Gg.Advert(4) %>
            <div class="rkuang wb">
                <div class="rkuangtitle">
                    <a href="/Competetion/SearchEvent.aspx"><span>���±���</span></a>
                </div>
                <div class="wbnr">
                    <ul id="slider" class="event">
                    </ul>
                    <script type="text/javascript">
                        $.get("/Utility/Ajax/NewEvent.aspx", { rnd: MinuteRand() }, function (result) {
                            document.getElementById("slider").innerHTML = result;
                            new slider({ id: 'slider' });
                        });
                    </script>
                </div>
            </div>
            <%=Gg.Advert(5) %>
            <%=Gg.Advert(6) %>
            <div class="rkuang wb xiaok">
                <div class="rkuangtitle">
                    <span><a href="javascript:void(0)">���ܾ�ѡ</a></span>
                </div>
                <div class="wbnr" id="Choice">
                </div>
                <script type="text/javascript">
                    $.get("/Utility/Ajax/Choice.aspx", { rnd: MinuteRand() }, function (result) {
                        document.getElementById("Choice").innerHTML = result;
                    });
                </script>
            </div>
            <!-- <div class="rkuang xiaogj">
                <a href="" class="rkuangtitle">����С����</a>
                <form method="post" action="/Utility/RaceHistory.aspx" name="searchFrm" id="searchFrm">
                    �ҽ������ˣ�
                    <input type="hidden" value="" name="UpdatedFields" id="UpdatedFields">
                    <select onchange="UpdateHistory(this)" name="idRoadStyle" id="idRoadStyle">
                        <option selected="" value="0">��԰</option>
                        <option value="1">�ﾶ��</option>
                        <option value="2">��·</option>
                        <option value="3">ɽ·</option>
                        <option value="4">�ܲ���</option>
                        <option value="5">����</option>
                    </select>
                    <input type="text" onblur="this.className='input_cls1';" onmouseout="this.className='input_cls1';" onmouseover="this.className='input_cls2';" value="" class="input_cls1" maxlength="3" id="iDistance" name="iDistance">&nbsp;���<br>
                    ��ʱ��
                    <input type="text" onblur="this.className='input_cls1';" onmouseout="this.className='input_cls1';" onmouseover="this.className='input_cls2';" value="" class="input_cls1" maxlength="2" id="iHours" name="iHours">ʱ 
                    <input type="text" onblur="this.className='input_cls1';" onmouseout="this.className='input_cls1';" onmouseover="this.className='input_cls2';" value="" class="input_cls1" maxlength="2" id="iMinutes" name="iMinutes">�� 
                    <input type="text" onblur="this.className='input_cls1';" onmouseout="this.className='input_cls1';" onmouseover="this.className='input_cls2';" value="0" class="input_cls1" maxlength="2" id="iSeconds" name="iSeconds">&nbsp;�� 
                    <img onclick="document.searchFrm.submit();return true;" src="/Images/index/tijiao.png">
                </form>
            </div> -->
            <%=Gg.Advert(7) %>
            <div class="rkuang shipin">
                <a class="rkuangtitle" href="/topics/300130100.aspx">������Ƶ</a>
                <ul>
                    <% =pf.Show(300130100) %>
                </ul>
            </div>
            <div class="rkuang yiptp">
                <a class="rkuangtitle" href="/topics/300140100.aspx">����ͼƬ</a>
                <ul>
                    <% =pf.Show(300140100) %>
                </ul>
            </div>
            <div class="rkuang yphd" style="display: none">
                <div class="rkuangtitle">���ܻ</div>
                <form id="frmRace" name="frmRace" action="/Utility/MyRace.aspx" method="post">
                    <table id="smart">
                        <tr>
                            <td align="right" style="width: 60px;">���У�</td>
                            <td>
                                <script type="text/javascript" src="/Common/jCity.js"></script>
                                <select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)">
                                </select>
                                <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)">
                                </select>
                                <script type="text/javascript" language="javascript">
                    <!--
    BindProvince("����");
    // -->
                                </script>
                                <input type="hidden" id="idCity" name="idCity" size="5" readonly value="" onchange="UpdateHistory(this)">
                                <input type="hidden" id="cCityname" name="cCityname" size="16" readonly value="" onchange="UpdateHistory(this)">
                            </td>
                        </tr>
                        <tr>
                            <td align="right">ʱ�䣺</td>
                            <td>
                                <input type="radio" id="rtime" name="rtime" checked value="week1">���� 
                    <input type="radio" id="Radio1" name="rtime" value="day">����
                    <input type="radio" id="Radio2" name="rtime" value="week2">����
                            </td>
                        </tr>
                        <tr>
                            <td align="right"></td>
                            <td>
                                <img src="/Images/index/yphdss.png" onclick="Finish()">
                            </td>
                        </tr>
                    </table>
                </form>
                <script type="text/javascript" language="javascript">
<!--
    function Finish() {
        if (document.getElementById("idCity").value.length < 1) {
            alert("��ѡ�����ڳ��к�����!");
            return false;
        }
        document.frmRace.submit();
        return true;
    }
    // -->
                </script>
            </div>
        </div>
        <div class="hezhb">
            <span>�������</span>
            <a href="http://www.athletics.org.cn/" target="_blank" title="�й��ﾶЭ��">
                <img src="/Images/index/tjxh.png" alt="�й��ﾶЭ��">
            </a>
            <a href="http://sports.163.com/running/" target="_blank" title="�����ܲ�">
                <img src="/Images/index/wypb.png" alt="�����ܲ�">
            </a>
            <a href="http://running.sports.sohu.com/" target="_blank" title="�Ѻ�����">
                <img src="/Images/index/shty.png" alt="�Ѻ�����">
            </a>
            <a href="http://www.51running.com/" target="_blank" title="����">
                <img src="/Images/index/duowei.png" alt="����">
            </a>
            <a href="http://bbs.running8.com" target="_blank" title="�ܰ�">
                <img src="/Images/index/pb.png" alt="�ܰ�">
            </a>
            <a href="http://www.leevy.net/" target="_blank" title="��ά">
                <img src="/Images/index/liwei.gif" alt="��ά"></a>
            <a href="http://run.hupu.com/" target="_blank" title="�����ܲ�" style="margin-right: 0">
                <img src="/Images/index/hp_logo_run.jpg" alt="�����ܲ�"></a>
            <a href="http://zuicool.com/" target="_blank" title="����˶�����">
                <img src="/Html/images/erun360-zuicool.png" title="����˶����� - ��רҵ�����������˶����Ͽ������"></a>
            <a href="http://run.gmw.cn/" target="_blank" title="��������">
                <img src="/Html/images/gmbbs.jpg" title="��������"></a>
            <!-- <a href="http://www.sportgd.com/" target="_blank" >
                <img src="/Html/images/tbh.jpg" title="�岩��"></a> -->
            <a href="http://www.42trip.com/" target="_blank" title="42��">
                <img src="/Html/images/42trip.png" title="42��"></a>
            <a href="http://www.xnuts.cn/" target="_blank" title="�������">
                <img src="/images/xnuts.jpg" title="������ң��й���һ����ý��ƽ̨"></a>
            <a href="http://tw.running.biji.co/index.php" target="_blank" title="�˶��ʼ�">
                <img src="/images/ydbj.jpg" title="�˶��ʼ�"></a>
            <a href="http://www.asian-outdoor.com" target="_blank" title="�Ͼ�����չ" style="margin-right: 0">
                <img src="/images/huwai.jpg" title="�Ͼ�����չ"></a>

        </div>
        <div class="yqljwz">
            <a href="http://bbs.runbible.cn/" target="_blank">�ܲ�ʥ��</a>
            <a href="http://fashion.junzimen.com/" target="_blank">������</a>
            <a href="http://edooon.com/running/" target="_blank">�涯</a>
            <a href="http://www.out99.org/Home/Link#%E5%AA%92%E4%BD%93" target="_blank">����̽��</a>
            <a href="http://www.friends8.com/" target="_blank">�Ѱ��˶�</a>
        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
