<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Plan.aspx.cs" Inherits="Admin_Plan" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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

            #tips {
                background: #fff;
                height: 100%;
                line-height: 110px;
                text-align: center;
                font-size: 14px;
            }

                #tips img {
                    margin-right: 4px;
                }

            .gtable {
                width: 1700px;
                overflow: auto;
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
                        height: 36px;
                        line-height: 36px;
                    }

            .auditclubs table {
                width: 800px;
            }

                .auditclubs table tr td:first-child {
                    width: 240px;
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

            #bohuibox {
                width: 100%;
                height: 100%;
                background: #fff;
            }

                #bohuibox h2 {
                    color: #077fc6;
                    font-weight: bold;
                    font-size: 16px;
                    margin: 0;
                    padding-left: 18px;
                    line-height: 56px;
                }

                #bohuibox textarea {
                    font-size: 14px;
                    height: 140px;
                    margin-left: 20px;
                    padding: 2px;
                    width: 426px;
                }

            .tnewuser {
                float: right;
                color: #f00;
            }
        </style>
        <div class="cont">
            <div class="conttop">
                <a href="PlanEdit.aspx?id=0" target="_blank" class="tnewuser">添加训练计划</a>
		<a href="/">首页</a> >
<a href="/admin/">管理首页</a> > 
		训练计划
	</div>
            <table style="width:100%">
		<tr>
            <td>选择赛事：</td>
			<td><asp:DropDownList ID="ddlCode" runat="server" OnSelectedIndexChanged="ddlCode_SelectedIndexChanged"  AutoPostBack="True">
                </asp:DropDownList>
            </td>
		</tr>
                <tr>
                    <td>实例说明：</td>
                    <td>101_10_4_42 ：101：业余组1(1开头表示业余组，01:组1(组编号)，2开头表示专业组)，<br />10：10周（训练周数）；4：每周四次(每周训练次数)；42：42公里(公里数)</td>
                </tr>		
	</table>
            </div>
            <div class="auditclub">
                <asp:Repeater ID="Repeater1" runat="server">
                <HeaderTemplate>
                    <table>
                        <tr>
                            <td>编号</td>
                            <td>归属</td>
                            <td>周</td>
                            <td>日</td>
                            <td>说明</td>
                            <td>类型</td>
                            <td>时间</td>
                            <td>强度</td>
                            <td>间歇</td>
                            <td>备注</td>
                            <td>排序</td>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <a name='a<%# Eval("id")%>'></a>
                            <%# Container.ItemIndex + 1%>                          
                        </td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cPanCode")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "iweek")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "iDay")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMemo")%></td>                      
                         <td><%# Eval("iType").ToString() == "1" ? "时间" : Eval("iType").ToString() == "2"?"间歇":Eval("iType").ToString() == "3" ? "休息":Eval("iType").ToString() == "4" ? "比赛":""%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "iTime")%></td>
                        <td><%# Eval("iStrong").ToString() == "1" ? "GR" : Eval("iStrong").ToString() == "2"?"GE":Eval("iStrong").ToString() == "3" ? "OR":Eval("iStrong").ToString() == "4" ? "RO":""%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cspace")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMark")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "iOrder")%></td>
                        <td><a href='<%# "PlanEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>' target="_self">编辑</a></td>
                    </tr>
                </ItemTemplate>
                <AlternatingItemTemplate>
                    <tr bgcolor="#e8e8e8">
                         <td>
                            <a name='a<%# Eval("id")%>'></a>
                            <%# Container.ItemIndex + 1%>                          
                        </td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cPanCode")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "iweek")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "iDay")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMemo")%></td>                      
                         <td><%# Eval("iType").ToString() == "1" ? "时间" : Eval("iType").ToString() == "2"?"间歇":Eval("iType").ToString() == "3" ? "休息":Eval("iType").ToString() == "4" ? "比赛":""%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "iTime")%></td>
                        <td><%# Eval("iStrong").ToString() == "1" ? "GR" : Eval("iStrong").ToString() == "2"?"GE":Eval("iStrong").ToString() == "3" ? "OR":Eval("iStrong").ToString() == "4" ? "RO":""%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cspace")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "cMark")%></td>
                        <td><%# DataBinder.Eval(Container.DataItem, "iOrder")%></td>
                       <td><a href='<%# "PlanEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>' target="_self">编辑</a></td>
                    </tr>
                </AlternatingItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater> 
            </div>
             </center>
    </form>
</body>
</html>
