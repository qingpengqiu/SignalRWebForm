<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SearchUser.aspx.cs" Inherits="infocenter_SearchUser" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="��http://open.weibo.com/wb��">
<head>
    <title>�����û�</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <meta property="wb:webmaster" content="a859eadcc5aee52a" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
    <style type="text/css">
        .serch-key {
            padding: 0 16px;
            line-height: 40px;
        }

            .serch-key a {
                font-size: 14px;
                color: #666;
                padding: 0 3px;
            }

                .serch-key a:hover {
                    text-decoration: none;
                }

            .serch-key .a1 {
                font-size: 30px;
                color: #ff3333;
                font-weight: bold;
            }

            .serch-key .a2 {
                font-size: 30px;
                color: #ff6600;
            }

            .serch-key .a3 {
                font-size: 24px;
                color: #666;
                font-weight: bold;
            }

            .serch-key .a4 {
                font-size: 24px;
                color: #0099cc;
            }

            .serch-key .a5 {
                font-size: 24px;
                color: #ff6600;
            }

            .serch-key .a6 {
                font-size: 18px;
                color: #666;
                font-weight: bold;
            }

            .serch-key .a7 {
                font-size: 18px;
                color: #cc66cc;
                font-weight: bold;
            }

            .serch-key .a8 {
                font-size: 18px;
                color: #0099cc;
                font-weight: bold;
            }

            .serch-key .a9 {
                font-size: 18px;
                color: #cc66cc;
            }

            .serch-key .a10 {
                font-size: 18px;
                color: #0099cc;
            }
            .searchuser{padding-top: 16px;width: 656px;}
            .sfbox{padding: 6px 0 0 0 }

.tfirend{height: 31px;background: url(/Html/images/bn5.png) no-repeat -3px top ;padding-top: 4px}
.sfbox .blog{overflow: hidden;min-height: 0px!important;margin-left: 0px;}
.tfirend input{margin: 0;padding: 0;background:none;border: 0;box-shadow:none;width: 142px;float: right;height: 28px;line-height: 28px;}
.tfirend input:focus{box-shadow:none;}
.tfirend a{float: right;width: 38px;height: 28px;margin-top: -2px;}
.tfirend a:hover{cursor: pointer;}
.focus{border: 0;background: none}
.focus .blog-top{border: 1px solid #DDDDDD}
.focus ul{margin: 0;}
.focus li{margin: 14px 0 0 0 ;width: 296px;height: 98px;border: 1px solid #e4e4e4;padding: 12px 12px 0 12px;float: left;background:hsla(0,0%,100%,0.8) ;color: #666}
.focus li:nth-child(even){margin-left: 12px;}
.focus li img{width: 50px;border: 1px solid #cecece;float: left;margin-right: 16px;margin-bottom: 40px;height: 50px;}
.focus li .focus-a img{border: 0 none; float: none; height: 21px; margin: 0;
    width: 21px;}
.focus li .focusgz:hover{background: none repeat scroll 0 0 #c3c1c1;}
.focus li a{color: #333;font-size: 14px;font-weight: bold;}    
.focus li a:hover{text-decoration: underline; color: #ff6600}
.focus li .focus-a:hover,.focus li .focus-b:hover{text-decoration: none; color: #fff}
.focus .focus-a{font-size: 12px;color: #fff;background: #afafaf;padding: 6px;line-height: 12px;float: left;border-radius: 5px;position: relative;outline: none;font-weight: 100;}
.focus .focus-b{font-size: 12px;color: #fff;background: #378ed6;padding: 6px;line-height: 12px;float: left;border-radius: 5px;margin-left: 12px;font-weight: 100;text-shadow:0.08em 0.08em 0.04em #296694}
.focus .focus-c{font-size: 12px;color: #fff;background: #ff9600;padding: 6px;line-height: 12px;float: left;border-radius: 5px;margin-left: 12px;}
.focus li p{padding-top: 4px;margin-bottom: 14px;}
.article-up-iframe{display: block;}
.focus-tly{width: 57px;height: 19px;background: url(/Html/images/tly.png);text-indent: -3333em;display: inline-block;margin-left: 4px;}
.focus-tlyn{width: 57px;height: 19px;background: url(/Html/images/tly.png);text-indent: -3333em;display: inline-block;margin-left: 4px;}
.focus-txh{width: 49px;height: 19px;background: url(/Html/images/txh.png);text-indent: -3333em;display: inline-block;}
.focus-tgz{width: 49px;height: 19px;background: url(/Html/images/tgz.png);text-indent: -3333em;display: inline-block;position: relative;}
.focus-tqx{width: 49px;height: 19px;background: url(/Html/images/tqx.png);text-indent: -3333em;display: inline-block;}
.focus-tygz{width: 49px;height: 19px;background: url(/Html/images/tygz.png);text-indent: -3333em;display: inline-block;}
.focus li .focusalert img{float: none;width: 21px;height: 21px;}
.focus li .focusalert img{float: none;width: 21px;height: 21px;border: 0;margin: 0}
.focus li .focusalert{text-indent: 0}
.ffindtip{font-size: 14px;color: #666;padding-top: 8px;}
.ffindtip span{font-weight: bold;color: #FF6633}
    </style>
</head>
<body>
    <script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Common/jPopup.js"></script>
    <script language="javascript" src="/Common/jCalendar.js"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
     <form id="form1" runat="server">
    
    <div class="indecen">
        <div class="left searchuser">
            <div class="sfbox">
						<div class="tfirend ">
							<a onclick="SearchUser();" class="serch" href="javascript:void(0)"></a>
							<input type="text" id="taword" runat="server" value="" onfocus="if(this.value=='����'){this.value='';this.style.color='#000000'}" onblur="if(this.value==''){this.value='����';this.style.color='#a9a9a9'}"/>
							
						</div>
                <div class="ffindtip">
							<%=searchTip %>
						</div>
						<div class="blog focus">
                           
<ul class="">
    <%=UserList %>
	<%--<li><a target="_blank" href="/user/100002013.aspx"><img src="/images/noname.gif"> ����</a><p>1111</p>	<a class="focus-tygz">�໥��ע</a><a href="/infocenter/PostMessage.aspx?uId=100002013" class="focus-tly">��TA����</a></li>
	<li><a target="_blank" href="/user/100002723.aspx"><img src="/images/noname.gif"> ����</a><p>�ú��ܲ����ú�����</p>	<a class="focus-txh">�໥��ע</a><a href="/infocenter/PostMessage.aspx?uId=100002723" class="focus-tly">��TA����</a></li>
	<li><a target="_blank" href="/user/100003123.aspx"><img src="/images/noname.gif"> daibo</a><p></p>	<a class="focus-tqx">�໥��ע</a><a href="/infocenter/PostMessage.aspx?uId=100003123" class="focus-tly">��TA����</a></li>
	<li><a target="_blank" href="/user/100000605.aspx"><img src="/images/noname.gif"> gggso</a><p>����</p>	<a class="focus-txh">�໥��ע</a><a href="/infocenter/PostMessage.aspx?uId=100000605" class="focus-tly">��TA����</a></li><li><a target="_blank" href="/user/100000466.aspx"><img src="/images/noname.gif"> joshuama</a><p></p>	<a class="focus-txh">�໥��ע</a><a href="/infocenter/PostMessage.aspx?uId=100000466" class="focus-tly">��TA����</a></li>
	<li><a target="_blank" href="/user/100000004.aspx"><img src="/images/noname.gif"> ����</a><p>�ܻ��ǲ��ܣ�����һ�����⣬������</p>	<a onclick="iFocus(100000004,'focus5')" class="focus-tgz  focus5" href="javascript:">��עTA</a><a href="/infocenter/PostMessage.aspx?uId=100000004" class="focus-tly">��TA����</a></li>
	<li><a target="_blank" href="/user/100000691.aspx"><img src="/images/noname.gif"> ������</a><p>ÿ���ܲ�1Сʱ</p>	<a onclick="iFocus(100000691,'focus6')" class="focus-tgz  focus6" href="javascript:">��עTA</a><a href="/infocenter/PostMessage.aspx?uId=100000691" class="focus-tly">��TA����</a></li>--%>
</ul>
                             <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
                                    NextPageText="��һҳ" CssClass="pages"
                                    CurrentPageButtonClass="cpb" PrevPageText="��һҳ"
                                    OnPageChanged="pager_PageChanged" PageSize="12">
                                </webdiyer:AspNetPager>
						</div>
                    </div>
            
        </div>
        <div class="right">
            <div class="rkuang wzph">
                <div class="rkuangtitle">��������</div>
                <div class="serch-key">
                    <a class="a1" href="/infocenter/Search.aspx?fname=title&word=ԽҰ��">ԽҰ��</a>
                    <a class="a2" href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a class="a3" href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a class="a4" href="/infocenter/Search.aspx?fname=title&word=ϥ��">ϥ��</a>
                    <a class="a5" href="/infocenter/Search.aspx?fname=title&word=ѡЬ">ѡЬ</a>
                    <a class="a6" href="/infocenter/Search.aspx?fname=title&word=��������">��������</a>
                    <a class="a7" href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a class="a8" href="/infocenter/Search.aspx?fname=title&word=ѵ���ƻ�">ѵ���ƻ�</a>
                    <a class="a9" href="/infocenter/Search.aspx?fname=title&word=�ָ�">�ָ�</a>
                    <a class="a10" href="/infocenter/Search.aspx?fname=title&word=װ��">װ��</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=ԽҰ">ԽҰ</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=������">������</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=�ܲ���">�ܲ���</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=ѵ���ƻ�">ѵ���ƻ�</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=ǿ��">ǿ��</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=�ٶ�">�ٶ�</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=Ƶ��">Ƶ��</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=ҵ��ѵ��">ҵ��ѵ��</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����ѵ��">����ѵ��</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=LSD">LSD</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=������">������</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=��Ъ">��Ъ</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=��������">��������</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=ƽ̨">ƽ̨</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����ѵ��">����ѵ��</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=�˶�ƣ��">�˶�ƣ��</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=�ָ�">�ָ�</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=��ͥ">��ͥ</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=�칫��">�칫��</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=ѡЬ">ѡЬ</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=�ֱ�">�ֱ�</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=ѹ����">ѹ����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=��">��</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=�۾�">�۾�</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=��ʳ">��ʳ</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=���׷�">���׷�</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����������CLA">����������CLA</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=�Ȱ�����">�Ȱ�����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=���">���</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=���">���</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=RICE">RICE</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=������">������</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=������">������</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=ά����">ά����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=������">������</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=�˶�Ա">�˶�Ա</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=Ԥ��">Ԥ��</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=�ؽ�">�ؽ�</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=�ʹ�">�ʹ�</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=��к">��к</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=��ʹ">��ʹ</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=������">������</a>
                    <a href="/infocenter/Search.aspx?fname=title&word=����">����</a>
                </div>
            </div>
            <script type="text/javascript">
                jQuery(document).ready(function ($) {
                    $(".a11").after($(".a1"))
                });
                function SearchIt() {
                    if (document.getElementById("word").value.length > 0) {
                        document.frmSearch.submit();
                        return true;
                    }
                    return false;
                }
                function SearchUser(){
    if(document.getElementById("taword").value.length > 0){
        $(".serch").attr("href","\/infocenter\/Searchuser.aspx?searchname="+document.getElementById("taword").value)
        return true;
    }
    return false;
}
function iFocus(idx,thisa) {
    var thisa = "."+thisa;
        function thisare() {
            $(thisa).replaceWith("<a class=\"focus-tygz\">�໥��ע</a>")
        }
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
$(".focus-tly").colorbox({ iframe: true, width: "432px", height: "200px", opacity: "0.4" });
            </script>

        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    						</form>
</body>
</html>
