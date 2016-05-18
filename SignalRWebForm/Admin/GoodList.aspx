<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GoodList.aspx.cs" Inherits="Admin_GoodList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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
                .tnewuser{float: right;color: #f00}
                 .tip{color:red}
        </style>
        <div class="cont">
            <div class="conttop">                
                 <a href="GoodEdit.aspx?id=0" target="_blank" class="tnewuser">��ӻ��ֶһ���Ʒ</a>
                <a href="/">��ҳ</a> ><a href="/Admin/PayList.aspx">��Ʒ������ҳ</a>>������Ʒ����
            </div>
            <div class="auditclub">
               <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <td>���</td>
                                <td>��Ʒ����</td>
                                <td>��Ʒ����</td>
                                <td>��ʼʱ��</td>
                                <td>����ʱ��</td> 
                                <td>ʵ��</td>
                                <td>�޶�</td>
                                <td>����</td>                                
                                <td>״̬</td>
                                <td>����</td>
                                <td>����</td>
                                 <td>���</td> 
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                       <tr>
                            <td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>   
                           <td> <%#  Eval("iType").ToString() == "1" ? "���ֶһ�": Eval("iType").ToString() == "2" ? "�Ź���Ʒ":"��ͨ��Ʒ"%>  </td>                            
                            <td><%# Convert.ToDateTime(DataBinder.Eval(Container.DataItem, "dBeginTime")).ToString("yyyy-MM-dd HH:mm")%></td>
                            <td><%#  Convert.ToDateTime(DataBinder.Eval(Container.DataItem, "dEndTime")).ToString("yyyy-MM-dd HH:mm")%></td>
                           <td><%#  Eval("iEntity").ToString() == "1" ? "ʵ��": "����"%></td>
                           <td><%# DataBinder.Eval(Container.DataItem, "iQuantity")%></td>
                           <td><%#  Eval("fScore").ToString() == "1" ?  Eval("iScore").ToString()+"+"+ Eval("iMoney").ToString(): "��"%></td>                            
                            <td><%#  Eval("iState").ToString() == "0" ? "������": Eval("iState").ToString() == "1" ? "�ѷ���": "����"%></td>
                           <td><%# DataBinder.Eval(Container.DataItem, "iTotal")%></td>
                            <td><a href='<%#istour( Eval("id").ToString(), Eval("iType").ToString())==-1?"GoodEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id"):"GoodTourEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id")%>' target="_self">�༭</a><a href='<%# "GoodDetail.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>' target="_blank">�鿴</a></td>
                            <td><%# isReserve( Eval("id").ToString())==0?"<a href='ReserveEdit.aspx?id=0&idgood="+DataBinder.Eval(Container.DataItem, "id")+"' target=\"_blank\"><span class=\"tip\">��ӿ��</span></a>":"<a href='ReserveList.aspx?idgood="+DataBinder.Eval(Container.DataItem, "id")+"' target=\"_blank\">�鿴���</a>" %></td>
                        </tr>
                        </tr>
                    </ItemTemplate>
                    <%--AlternatingItemTemplate������������е���һ�����--%>
                    <AlternatingItemTemplate>
                       <tr  bgcolor="#e8e8e8">
                            <td>
                               
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>   
                           <td> <%#  Eval("iType").ToString() == "1" ? "���ֶһ�": Eval("iType").ToString() == "2" ? "�Ź���Ʒ":"��ͨ��Ʒ"%>  </td>                            
                   <td><%# Convert.ToDateTime(DataBinder.Eval(Container.DataItem, "dBeginTime")).ToString("yyyy-MM-dd HH:mm")%></td>
                            <td><%#  Convert.ToDateTime(DataBinder.Eval(Container.DataItem, "dEndTime")).ToString("yyyy-MM-dd HH:mm")%></td>
                           <td><%#  Eval("iEntity").ToString() == "1" ? "ʵ��": "����"%></td>
                           <td><%# DataBinder.Eval(Container.DataItem, "iQuantity")%></td>
                           <td><%#  Eval("fScore").ToString() == "1" ?  Eval("iScore").ToString()+"+"+ Eval("iMoney").ToString(): "��"%></td>   
                            <td><%#  Eval("iState").ToString() == "0" ? "������": Eval("iState").ToString() == "1" ? "�ѷ���": "����"%></td>
                           <td><%# DataBinder.Eval(Container.DataItem, "iTotal")%></td>
                            <td><a href='<%#istour( Eval("id").ToString(), Eval("iType").ToString())==-1?"GoodEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id"):"GoodTourEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id")%>' target="_self">�༭</a><a href='<%# "GoodDetail.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>' target="_blank">�鿴</a></td>
                            <td><%# isReserve( Eval("id").ToString())==0?"<a href='ReserveEdit.aspx?id=0&idgood="+DataBinder.Eval(Container.DataItem, "id")+"' target=\"_blank\"><span class=\"tip\">��ӿ��</span></a>":"<a href='ReserveList.aspx?idgood="+DataBinder.Eval(Container.DataItem, "id")+"' target=\"_blank\">�鿴���</a>" %></td>
                        </tr>
                    </AlternatingItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
            </div>
        </div>
             </center>
    </form>
</body>
</html>
