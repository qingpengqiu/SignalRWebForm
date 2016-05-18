<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ADFixed.aspx.cs" Inherits="Admin_ADFixed" %>

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

            .tnewuser {
                float: right;
                color: #f00;
            }
        </style>
        <div class="cont">
            <div class="conttop">
                <a href="ADFixedEdit.aspx?id=0" target="_blank" class="tnewuser">��ӹ��</a><a class="tnewuser">--</a>
                <a href="ADPosition.aspx" target="_blank" class="tnewuser">���λ</a>
                <a href="/">��ҳ</a> >
<a href="/admin/">������ҳ</a> > 
		�Ҳ�̶�λ���
            </div>
            <table style="width:100%">
		<tr>
			<td>ѡ�����:<asp:DropDownList ID="ddlADtype" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlADtype_SelectedIndexChanged">
                                <asp:ListItem Value="1">Ƶ��ҳ</asp:ListItem>
                                <asp:ListItem Value="2">����ҳ</asp:ListItem>
                                <asp:ListItem Value="3" >����ҳ</asp:ListItem>
			         </asp:DropDownList>
               </td>
		</tr>
		<tr>
			<td>ѡ��Ƶ����<asp:DropDownList ID="ddlChannel" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlChannel_SelectedIndexChanged"></asp:DropDownList>
                <%-- <asp:DropDownList ID="ddlClass" runat="server" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged"  AutoPostBack="True"></asp:DropDownList> --%>
                 <asp:DropDownList ID="ddlClass" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlClass_SelectedIndexChanged"> <asp:ListItem Value="80000">����ҳͨ�ù��</asp:ListItem></asp:DropDownList> 
                             <asp:DropDownList ID="ddllist" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddllist_SelectedIndexChanged">
                                  <asp:ListItem Value="90000">����ҳͨ�ù��</asp:ListItem>
                             </asp:DropDownList> 
            </td>
		</tr>
                </table>
            <div class="auditclub">
                <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <td>���</td>
                                <td>����</td>
                                <td>����</td>
                                <td>Ƶ��</td>
                                <td>���λ</td>
                                <td>HTML����</td>
                                <td>��ʼʱ��</td>
                                <td>����ʱ��</td> 
                                <td>��ʾ</td>
                                <td>����</td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>
                           <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>                            
                           <td><%# Eval("iType").ToString() == "1" ? "ͼƬ" : Eval("iType").ToString() == "2"?"flash":Eval("iType").ToString() == "3" ? "html":""%></td>
                             <td><%#GetChannelName( Eval("iADType").ToString(),Eval("idCode").ToString())%></td>
                            <%--<td><%# DataBinder.Eval(Container.DataItem, "idCode")%></td>--%>
                            <td><%# DataBinder.Eval(Container.DataItem, "idPosition")%></td>                        
                            <td><div style="width: 200px;height: 100px;overflow: hidden;"><%# DataBinder.Eval(Container.DataItem, "cHtml")%></div></td>                            
                            <td><%#string.Format("{0:yyyy-MM-dd HH:mm}",Eval("dBegintime"))%></td>
                            <td><%#string.Format("{0:yyyy-MM-dd HH:mm}",Eval("dEndtime"))%></td>
                            
                            <td><%# Eval("iShow").ToString() == "0" ? "<font color=\"#B23AEE\">ȫ��</font>" : Eval("iShow").ToString() == "1"?"<font color=\"#B23AEE\">����</font>":Eval("iShow").ToString() == "2" ? "<font color=\"#008800\">�ֻ�</font>":""%></td>
                            <td><a href='<%# "ADFixedEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>' target="_self">�༭</a><font color="red">|</font><a href='<%# "ADPosition.aspx?id="+DataBinder.Eval(Container.DataItem, "idCode") %>' target="_self">���λ</a></td>
                        </tr>
                    </ItemTemplate>
                    <%--AlternatingItemTemplate������������е���һ�����--%>
                    <AlternatingItemTemplate>
                        <tr bgcolor="#e8e8e8">
                           <td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>
                          <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>                            
                            <td><%# Eval("iType").ToString() == "1" ? "ͼƬ" : Eval("iType").ToString() == "2"?"flash":Eval("iType").ToString() == "3" ? "html":""%></td>
                            <td><%#GetChannelName( Eval("iADType").ToString(),Eval("idCode").ToString())%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "idPosition")%></td>                          
                            <td><div style="width: 200px;height: 100px;overflow: hidden;"><%# DataBinder.Eval(Container.DataItem, "cHtml")%></div></td>                            
                            <td><%#string.Format("{0:yyyy-MM-dd HH:mm}",Eval("dBegintime"))%></td>
                            <td><%#string.Format("{0:yyyy-MM-dd HH:mm}",Eval("dEndtime"))%></td>
                            <td><%# Eval("iShow").ToString() == "0" ? "<font color=\"#B23AEE\">ȫ��</font>" : Eval("iShow").ToString() == "1"?"<font color=\"#B23AEE\">����</font>":Eval("iShow").ToString() == "2" ? "<font color=\"#008800\">�ֻ�</font>":""%></td>
                         <td><a href='<%# "ADFixedEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>' target="_self">�༭</a><font color="red">|</font><a href='<%# "ADPosition.aspx?id="+DataBinder.Eval(Container.DataItem, "idCode") %>' target="_self">���λ</a></td>
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
