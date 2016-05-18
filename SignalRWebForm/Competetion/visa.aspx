<%@ Page Language="C#" AutoEventWireup="true" CodeFile="visa.aspx.cs" Inherits="Competetion_visa" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<%@ Register Src="~/Competetion/headerv2.ascx" TagPrefix="ERUN360" TagName="headerv2" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<!DOCTYPE html>
<html lang="cn">
<head>
    <meta charset="gb2312">
    <title><%=title %>-签证-益跑网赛事报名</title>
    <link rel="stylesheet" href="/mz/css/amazeui.min.css">
    <link rel="stylesheet" href="/Html/css/marathon.css">
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />

    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <script src="/Html/js/jquery-1.11.1.min.js"></script>
    <script src="/Html/js/marathon.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.emotions.js"></script>
    <script type="text/javascript" src="/Common/jCity.js"></script>
</head>
<body>
    <ERUN360:headerv2 runat="server" ID="headerv2" />
    <div class="banner">
        <div class="mine">
            <h1><%=title %></h1>
            <asp:Literal ID="ltlbanner" runat="server"></asp:Literal>
        </div>
    </div>
    <div class="tbody">
        <div class="mine">
            <ERUN360:bmnav runat="server" ID="bmnav" />
            <div class="tbodyBox">
                <div class="event this clearfix">
                    <form id="form1" runat="server">

                    </form>
                </div>
            </div>
        </div>
    </div>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>