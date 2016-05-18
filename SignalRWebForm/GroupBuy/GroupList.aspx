<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GroupList.aspx.cs" Inherits="GroupBuy_GroupList" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %><!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>拼团-益跑网个人中心</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/user-more.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/Group.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/groupmedia.css" />
    <script type="text/javascript" src="../Common/jCalendar.js"></script>
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../Html/js/modernizr.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="../Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="../Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../Html/js/bootstrap-validation.min.js"></script>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="../Common/jCity.js"></script>
    <script src="../Common/jCheck.js"></script>
    <script src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <style>
        .main-left ul .user-dq {
            filter: alpha(Opacity=100);
            -moz-opacity: 1;
            opacity: 1;
        }
    </style>


    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
</head>
<body>
    <form id="form1" runat="server">
        <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
        <div class="wrap">
            <article>
                <%--<div class="grouplistnav">
    			<a href="" class="this">全部商品</a><i>|</i><a href="">最新</a><i>|</i><a href="">最热</a>
    		</div>--%>
                <div class="groupnt">
                    <span>益跑拼团</span>
                    <img src="/Html/images/pbg.png">
                </div>
                <div class="grouptip">
                    <%=clj %>
                </div>
                <div class="grouplist">
                    <asp:Repeater ID="rptTour" runat="server">
                        <ItemTemplate>
                            <div class="groupbox">
                                <%#Eval("fScore").ToString()=="1"?"<img src=\"/Html/images/dkicon.png\">":"" %>
                                <%#DateTime.Now>Convert.ToDateTime(Eval("dBeginTime").ToString())?"":"<a class=\"wksicon\"><img src=\"/Html/images/wks.png\" ></a>" %>
                                <a class="groupthum" href="/GroupBuy/Group.aspx?id=<%#Eval("id").ToString()%>" target="_blank">
                                    <img src="<%#Eval("cImage").ToString()%>"></a>
                                <a class="grouptitle" href="/GroupBuy/Group.aspx?id=<%#Eval("id").ToString()%>" target="_blank"><%#Getems(Eval("id").ToString())+Eval("cName").ToString()%></a>
                                <p>
                                    市场价：<em><i>&yen;</i><%#Eval("fMarketPrice").ToString()%></em><i><%#Getzk(Eval("id").ToString(),Eval("fMarketPrice").ToString()) %>折</i><br>
                                    <%#Getems(Eval("id").ToString()).Trim().Length==0?"益跑拼团：<span><i>&yen;</i>"+GetTour(Eval("id").ToString())+"</span>（最低）":" 一口价：<span><i>&yen;</i>"+GetTour(Eval("id").ToString())+"</span>"%>
                                </p>

                            </div>

                        </ItemTemplate>
                        <FooterTemplate>
                            <asp:Label ID="lblEmpty" Text="拼团物品正在上架中，敬请期待……" runat="server" Visible='<%#bool.Parse((rptTour.Items.Count==0).ToString())%>' CssClass="lbEmpty"></asp:Label>
                        </FooterTemplate>
                    </asp:Repeater>
                </div>
                <webdiyer:AspNetPager ID="APager" runat="server" FirstPageText="<<" LastPageText=">>"
                    NextPageText="下一页" CssClass="pages"
                    CurrentPageButtonClass="cpb" PrevPageText="上一页"
                    OnPageChanged="APager_PageChanged" PageSize="16" UrlPaging="True">
                </webdiyer:AspNetPager>
            </article>
        </div>
    </form>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
