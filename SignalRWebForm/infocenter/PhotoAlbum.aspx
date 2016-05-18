<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PhotoAlbum.aspx.cs" Inherits="infocenter_PhotoAlbum" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns:wb="“http://open.weibo.com/wb”">
<head>
    <title><%=fName%></title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
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
                    <asp:LinkButton ID="lbnPrevPage" runat="server" CommandName="prev" OnCommand="Page_OnClick">上一页</asp:LinkButton>
                    <asp:Label ID="lbCurrentPage" runat="server" Text=""></asp:Label>
                    &nbsp;&nbsp;<asp:Label ID="lbTotal" runat="server" Text=""></asp:Label>
                    <asp:LinkButton ID="lbnNextPage" runat="server" CommandName="next" OnCommand="Page_OnClick">下一页</asp:LinkButton>
                    &nbsp;&nbsp;跳转至第<asp:DropDownList ID="lstPage" runat="server" OnSelectedIndexChanged="lstPage_SelectedIndexChanged1" AutoPostBack="True">
                    </asp:DropDownList>页&nbsp;
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
