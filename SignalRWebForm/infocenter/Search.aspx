<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="infocenter_Search" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="��http://open.weibo.com/wb��">
<head>
    <title>����</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <style type="text/css">
        .wzph li {
            overflow: hidden;
        }

        .column-title {
            font-size: 15px;
            color: #666;
            height: 38px;
            line-height: 38px;
            border: 1px solid #ddd;
            background: #f5f5f5;
            margin-top: 12px;
        }

            .column-title span {
                ��font-weight: bold;
            }

            .column-title em {
                font-weight: bold;
                color: #4c98cc;
                ��;
            }

        .column-list .title {
            �� font-size: 22px;
            color: #4c98cc;
        }

            .column-list .title em {
                color: #ff6633;
            }

        .column-list ul {
            border: 1px solid #ddd;
            border-top: 0;
            padding: 0px 20px 20px 20px;
        }

            .column-list ul span {
                display: block;
                font-size: 12px;
                color: #999;
                padding: 4px 0 2px 0;
            }

            .column-list ul p {
                font-size: 14px;
                color: #666;
                line-height: 24px;
                word-wrap: break-word;
            }

            .column-list ul li {
                border-bottom: 1px dotted #b3ccc0;
                padding: 20px 0;
            }

        .column-list .article-bot {
            font-size: 12px;
            color: #666;
            padding-top: 6px;
        }

            .column-list .article-bot a {
                float: right;
            }

        .column-list .page {
            margin-top: 20px;
        }

        .search-title {
            border: 1px solid #ddd;
            background: #f5f5f5;
            margin-top: 12px;
            padding: 0 0 0 18px;
        }

            .search-title #frmSearch {
                float: none;
            }

            .search-title p {
                font-size: 14px;
                color: #666;
                padding: 6px 0;
            }

            .search-title em {
                color: #ff6633;
            }

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
    </style>
</head>
<script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Common/jPopup.js"></script>
    <script language="javascript" src="/Common/jCalendar.js"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
<body>
    
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
        <div class="left column-list">
            <div class="search-title">
                <form method="post" action="/infocenter/Search.aspx" name="frmSearch" id="frmSearch">
                    <select id="fname" name="fname" style="display: none">
                        <option value="loginname">����</option>
                        <option selected value="title">�ұ���</option>
                        <option selected value="content">������</option>
                    </select>
                    <input type="text" id="word" name="word" value="���������⡢�ؼ���" onfocus="if(this.value=='���������⡢�ؼ���'){this.value='';this.style.color='#000000'}" onblur="if(this.value==''){this.value='���������⡢�ؼ���';this.style.color='#a9a9a9'}">
                    <a onclick="SearchIt();" class="serch"></a>
                    <%-- <select style="display: none" name="fname" id="fname">
                        <option value="loginname">����</option>
                        <option value="title" selected="">�ұ���</option>
                        <option value="content" selected="">������</option>
                    </select>
                    <input type="text" onblur="if(this.value==''){this.value='���������⡢�ؼ���';this.style.color='#a9a9a9'}" onfocus="if(this.value=='���������⡢�ؼ���'){this.value='';this.style.color='#000000'}" value="���������⡢�ؼ���" name="word" id="word">
                    <a class="serch" onclick="SearchIt();"></a>--%>
                    <div id="result">
                    </div>
                </form>
                <script type="text/javascript" language="javascript">
                    jQuery(document).ready(function($) {
                        $("#word").keyup(function(){
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
                                        //�����ַ��ĳ��Ⱦ�����֮�����4
                                        str_length++;
                                    }
                                    str_cut = str_cut.concat(a);
                                    if(str_length>=len)
                                    {
                                        str_cut = str_cut.concat("...");
                                        return str_cut;
                                    }
                                }
                                //��������ַ���С��ָ�����ȣ��򷵻�Դ�ַ�����
                                if(str_length<len){
                                    return  str;
                                }
                            }   
                            xskey = cutstr(xskey,10);
                            html = "<ul><li><a href=\"/infocenter/Searchuser.aspx?searchname="+key+"\">�ѡ�<em>"+xskey+"</em>����ص��û�</a></li><li><a href=\"/infocenter/Search.aspx?fname=title&word="+key+"\">�ѡ�<em>"+xskey+"</em>����صı���</a></li><li style=\"border-bottom: 0\"><a href=\"/infocenter/Search.aspx?fname=content&word="+key+"\">�ѡ�<em>"+xskey+"</em>����ص�����</a></li></ul>";
                            $("#result").empty("");
                            if(key == ""){
                                $("#result").hide();    
                            }else{
                                $("#result").append(html);
                                $("#result").show();    
                            }
                            $("html").click(function(){
                                $("#result").hide();    
                            })
                
                        })
                    });     
                    //<!--
                    function SearchIt(){
                        if(document.getElementById("word").value.length > 0 && document.getElementById("word").value != "���������⡢�ؼ���"){
                           
                          window.location.href="/infocenter/Search.aspx?fname=title&word="+document.getElementById("word").value;
                            
                        }
                        return false;
                    }
                    //-->
                </script>
                <p>������<em><% =PageWord %></em>����عؼ��֣��ҵ�<%=num %>�����</p>
            </div>
            <form id="form1" runat="server">
            <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <webdiyer:AspNetPager ID="pager1" runat="server" FirstPageText="<<" LastPageText=">>"
                        NextPageText="��һҳ" CssClass="pages pagetop"
                        CurrentPageButtonClass="cpb" PrevPageText="��һҳ"
                        OnPageChanged="pager1_PageChanged" PageSize="10">
                    </webdiyer:AspNetPager>
                    <ul>
                        <% =PageBuffer %>
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
                // function SearchIt() {
                //     if (document.getElementById("word").value.length > 0) {
                //         document.frmSearch.submit();
                //         return true;
                //     }
                //     return false;
                // }
            </script>

        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
