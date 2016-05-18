<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PhotoAlbum.aspx.cs" Inherits="infocenter_PhotoAlbum" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="��http://open.weibo.com/wb��">
<head>
    <title><%=fName%></title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <meta property="wb:webmaster" content="a859eadcc5aee52a" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico"/>
    <script src="/Common/jQuery1.8.js" type="text/javascript"></script>
    <link href="/Common/index2.css?2012111" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="../Html/colorbox2/colorbox.css" />
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
</head>
<body>
    <script type="text/javascript" src="/Common/jWeibo.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Common/jHeader.js?2012111"></script>
    <div class="indecen">
        <div class="gameimg">
            <div class="gameimgtitle"></div>
            <div class="crumbs"><a href="/infocenter/images.aspx?f=<%=fid%>"><%=pName%></a> &gt; <%=fName%></div>
            <form id="form1" runat="server">
                <div class="gameimgs">
                    <ul>
                        <asp:Repeater ID="DataList1" runat="server" >
                    <ItemTemplate>
                        <li>
                            <a href="<%=HostInfo.imgName%><%#Eval("NormalPhoto").ToString().Replace("~","")%>" target="_blank" class="group1">
                                    <img  src="<%=HostInfo.imgName%><%#Eval("SmallPhoto").ToString().Replace("~","")%>" />
                                </a>
                                <%#Eval("Name") %>
                        </li>
                    </ItemTemplate>
                </asp:Repeater>
                    </ul>
                <div class="gmpage">
                    <asp:LinkButton ID="lbnPrevPage" runat="server" CommandName="prev" OnCommand="Page_OnClick">��һҳ</asp:LinkButton>
                    <asp:Label ID="lbCurrentPage" runat="server" Text=""></asp:Label>
                    &nbsp;&nbsp;<asp:Label ID="lbTotal" runat="server" Text=""></asp:Label>
                    <asp:LinkButton ID="lbnNextPage" runat="server" CommandName="next" OnCommand="Page_OnClick">��һҳ</asp:LinkButton>
                    &nbsp;&nbsp;��ת����<asp:DropDownList ID="lstPage" runat="server" OnSelectedIndexChanged="lstPage_SelectedIndexChanged1" AutoPostBack="True">
                    </asp:DropDownList>ҳ&nbsp;
                </div>
                </div>
            </form>
        </div>
    </div>
    <script>
    $(".group1").colorbox({rel:'group1',width:"70%", preloading:true});
    </script>
    <ERUN360:footer ID="footer" runat="server" />
</body>
</html>
