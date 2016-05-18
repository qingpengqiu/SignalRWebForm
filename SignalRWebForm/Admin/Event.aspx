<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Event.aspx.cs" Inherits="Admin_Event" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head2" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>管理入口-益跑网</title>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Admin.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script language="javascript" src="/Common/jCheck.js?2012111"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script language="javascript" src="/Common/jCalendar.js?2012111"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jPopup.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>

<body>
    <form id="form1" runat="server">
        <center>           
        <div style="width: 100%; height: 85px; padding-top: 30px; background-color: #F8FFF8;">
            <div style="width: 950px; height: 85px; text-align: left;">
                <img src="/images/logo-u.gif" onclick="window.location='/';" style="margin-right: 80px;">
                <img src="/images/top-user.jpg">
            </div>
        </div>
        <style>
            .cont {
                width: 930px;
                padding: 10px;
                text-align: left;
                font-family: 微软雅黑;
            }

            .conttop {
                padding: 10px;
                height: 32px;
                font-size: 14px;
                font-weight: bold;
                color: #333;
            }
            body .auditclub tr:first-child td {
                font-size: 16px;
                color: #637496;
            }

            .auditclub {
                /* width: 100%;
                padding-left: 200px;*/
            }

                .auditclub table {
                    width: 100%;
                    text-align: center;
                }

                    .auditclub table tr {
                        
                        line-height: 20px;
                    }

            .auditclubs table {
                width: 100%;
            }

                .auditclubs table tr td:first-child {
                    /*width: 240px;*/
                    text-align: right;
                    padding-right: 10px;
                    color: #000;
                    font-weight: bold;
                }

                .auditclubs table tr {
                    height: 42px;
                }

            .auditclubs select {
                margin-bottom: 0;
            }

            .auditclubs table tr td.shcz {
                text-align: center;
                padding-top: 30px;
            }
             .tnewuser{float: right;color: #f00}
             .ta{text-align: left; padding-left: 30px;color: #f00}
        </style>
        <div class="cont">
            <div class="conttop">
                <a href="EventEdit.aspx?id=0" target="_blank" class="tnewuser">添加赛事</a>
		<a href="/" >首页</a>  >
<a href="/Admin/RaceList.aspx">赛事首页</a>>
		赛事设置列表
            </div>   
             <a class="ta" title="总成绩模版" target="_blank" href="/zs/All.xls">总成绩模版下载</a>
            <a class="ta" title="分段成绩模版" target="_blank" href="/zs/Part.xls">分段成绩模版下载</a>         
            <div class="auditclub">
  <asp:Repeater ID="rptRace" runat="server">
                        <HeaderTemplate>
                        <table>
                            <tr>
                                <td style="width: 40px">编号</td>
                                <td style="width: 80px">赛事id</td>
                                <td style="width: 120px">赛事名称</td>
                                <td style="width: 150px">查询方式</td>
                                <td style="width: 60px">证书</td>
                                <td>证书模版</td>
                                <td>头图</td>
                                <td style="width: 60px">状态</td>
                                <td style="width: 60px">操作</td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# DataBinder.Eval(Container.DataItem, "id")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "idRace")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "idRaceTitle")%></td>
                            <td><%#  Eval("istyle").ToString() == "1" ? "姓名+证件号码": "姓名+参赛号码"%></td>
                            <td><%#  Eval("iDoc").ToString() == "1" ? "有": "无"%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cModel")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cImage")%></td>
                            <td><%#  Eval("iStatus").ToString() == "1" ? "正常": "禁用"%></td>
                            <td><a href='<%# "EventEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>' target="_blank">编辑</a></td>
                        </tr>
                    </ItemTemplate>
                    <%--AlternatingItemTemplate描述交替输出行的另一种外观--%>
                    <AlternatingItemTemplate>
                        <tr bgcolor="#e8e8e8">
                          <td><%# DataBinder.Eval(Container.DataItem, "id")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "idRace")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "idRaceTitle")%></td>
                            <td><%#  Eval("istyle").ToString() == "1" ? "姓名+证件号码": "姓名+参赛号码"%></td>
                            <td><%#  Eval("iDoc").ToString() == "1" ? "有": "无"%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cModel")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cImage")%></td>
                            <td><%#  Eval("iStatus").ToString() == "1" ? "正常": "禁用"%></td>
                            <td><a href='<%# "EventEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>' target="_blank">编辑</a></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
             <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
                                    NextPageText="下一页" CssClass="pages"
                                    CurrentPageButtonClass="cpb" PrevPageText="上一页"
                                    OnPageChanged="pager_PageChanged" PageSize="50">
                                </webdiyer:AspNetPager>
        </div>
             </center>
    </form>
</body>
</html>
