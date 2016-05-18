<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Event.aspx.cs" Inherits="Admin_Event" %>

<%@ Register Assembly="AspNetPager" Namespace="Wuqi.Webdiyer" TagPrefix="webdiyer" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head2" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>�������-������</title>
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
                font-family: ΢���ź�;
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
                <a href="EventEdit.aspx?id=0" target="_blank" class="tnewuser">�������</a>
		<a href="/" >��ҳ</a>  >
<a href="/Admin/RaceList.aspx">������ҳ</a>>
		���������б�
            </div>   
             <a class="ta" title="�ܳɼ�ģ��" target="_blank" href="/zs/All.xls">�ܳɼ�ģ������</a>
            <a class="ta" title="�ֶγɼ�ģ��" target="_blank" href="/zs/Part.xls">�ֶγɼ�ģ������</a>         
            <div class="auditclub">
  <asp:Repeater ID="rptRace" runat="server">
                        <HeaderTemplate>
                        <table>
                            <tr>
                                <td style="width: 40px">���</td>
                                <td style="width: 80px">����id</td>
                                <td style="width: 120px">��������</td>
                                <td style="width: 150px">��ѯ��ʽ</td>
                                <td style="width: 60px">֤��</td>
                                <td>֤��ģ��</td>
                                <td>ͷͼ</td>
                                <td style="width: 60px">״̬</td>
                                <td style="width: 60px">����</td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td><%# DataBinder.Eval(Container.DataItem, "id")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "idRace")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "idRaceTitle")%></td>
                            <td><%#  Eval("istyle").ToString() == "1" ? "����+֤������": "����+��������"%></td>
                            <td><%#  Eval("iDoc").ToString() == "1" ? "��": "��"%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cModel")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cImage")%></td>
                            <td><%#  Eval("iStatus").ToString() == "1" ? "����": "����"%></td>
                            <td><a href='<%# "EventEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>' target="_blank">�༭</a></td>
                        </tr>
                    </ItemTemplate>
                    <%--AlternatingItemTemplate������������е���һ�����--%>
                    <AlternatingItemTemplate>
                        <tr bgcolor="#e8e8e8">
                          <td><%# DataBinder.Eval(Container.DataItem, "id")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "idRace")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "idRaceTitle")%></td>
                            <td><%#  Eval("istyle").ToString() == "1" ? "����+֤������": "����+��������"%></td>
                            <td><%#  Eval("iDoc").ToString() == "1" ? "��": "��"%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cModel")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cImage")%></td>
                            <td><%#  Eval("iStatus").ToString() == "1" ? "����": "����"%></td>
                            <td><a href='<%# "EventEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>' target="_blank">�༭</a></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
             <webdiyer:AspNetPager ID="pager" runat="server" FirstPageText="<<" LastPageText=">>"
                                    NextPageText="��һҳ" CssClass="pages"
                                    CurrentPageButtonClass="cpb" PrevPageText="��һҳ"
                                    OnPageChanged="pager_PageChanged" PageSize="50">
                                </webdiyer:AspNetPager>
        </div>
             </center>
    </form>
</body>
</html>
