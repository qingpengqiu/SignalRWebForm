<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Images.aspx.cs" Inherits="infocenter_Images" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="��http://open.weibo.com/wb��">
<head>
    <title>�������</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <meta property="wb:webmaster" content="a859eadcc5aee52a" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico"/>
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link href="/Common/index.css?2012111" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
</head>
<body>
    <script type="text/javascript" src="/Common/jWeibo.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Common/jHeader.js?2012111"></script>
    <div class="indecen">
        <div class="left">
            <div class="gameimg">
                <div class="gameimgtitle">
                </div>
                <div class="crumbs"></div>
                <ul>
                    <li class="listmore" id="c01">������ظ���</li>
                </ul>
            </div>
        </div>
        <div class="right">
            <div class="rkuang wb">
                <div class="rkuangtitle">
                    <span><a href="/Channels/Competetion/RaceList.aspx">���±���</a></span>
                </div>
                <div class="wbnr">
                    <ul class="event" id="slider" style="top: 0px;"></ul>
                    <script type="text/javascript">
                        $.get("/Utility/Ajax/Weibo.aspx", { rnd: MinuteRand() }, function (result) {
                            document.getElementById("slider").innerHTML = result;
                            new slider({ id: 'slider' });
                        });
                    </script>
                </div>
            </div>
            <div class="rkuang wzph">
                <div class="rkuangtitle">���¹�ע����</div>
                <ul>
                    <% =pf.Focus(302100100, 26) %>
                </ul>
            </div>
        </div>
    </div>
    <ERUN360:footer ID="footer" runat="server" />
    <script>

        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        if (GetQueryString("f")) {
            id = GetQueryString("f")
        } else {
            id = "1"
        }
        function SerachPage() {
            divid = "#c01";
            $.ajax({
                url: '/action/GetPhoto.ashx',
                data: { m: "photo2", p: pageIndex, f: id },
                type: 'get',
                dataType: 'json',
                contentType: 'application/json;charset=utf-8',
                cache: false,
                beforeSend: function () {
                    $(divid).html("<span class=\"load\"></span>���ڼ�����");
                },
                success: function (data) {

                    var pagenum = data.count,
                        pagedata = data.ds
                    $.each(pagedata, function (i) {
                        if (pagedata[i].tag == "True") {
                            $(divid).before("<li><a href=\"/infocenter/images.aspx?f=" + pagedata[i].id + "\"><img src=\"" + pagedata[i].cImg + "\" alt=\"\" /><p>" + pagedata[i].cName + "</p></a></li>");
                        } else {
                            $(divid).before("<li><a href=\"/infocenter/PhotoAlbum.aspx?id=" + pagedata[i].id + "\"><img src=\"" + pagedata[i].cImg + "\" alt=\"\" /><p>" + pagedata[i].cName + "</p></a></li>");
                        }

                    })
                    thiscount = data.count;
                    if (data.parent == 0) {
                        pname = ""
                    } else {
                        pname = "<a href=\"/infocenter/images.aspx?f=" + data.parent + "\">" + data.pname + "</a> > "
                    }

                    tname = data.name
                    $(".crumbs").html(pname + tname)
                },
                complete: function () { //���ɷ�ҳ��
                    if (thiscount == "") {
                        $(divid).html("ľ����");
                    } else {
                        $(divid).html("������ظ���");
                    }
                },
                error: function (xhr) {
                }

            });
        }
        pageIndex = 1;
        SerachPage();
        $("#c01").click(function () {
            pageIndex++
            SerachPage();

        })
    </script>
</body>
</html>
