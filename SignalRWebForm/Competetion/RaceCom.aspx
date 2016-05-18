<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceCom.aspx.cs" Inherits="Admin_RaceCom" %>

<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body {
        background: #f6f6f6;
    }

        body .auditclub tr:first-child td {
            font-size: 16px;
            color: #637496;
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

    .fbtitle {
        font-size: 14px;
    }

    .eqmal a {
        margin-bottom: 10px;
    }

        .eqmal a:hover {
            color: #fff;
        }
</style>
<div class="banner">
    <div class="mine">
        <h1><%=title %></h1>
        <asp:literal id="ltlbanner" runat="server"></asp:literal>
    </div>
</div>
<form id="form1" runat="server">
    <div class="tbody">
        <div class="mine">
            <ERUN360:bmnav runat="server" ID="bmnav" />
            <div class="tbodyBox">
                <div class="event this clearfix">
                    <div class="eqma">
                        <div class="eqmal">
                            <a class="eqmaa eqmajd" href="RaceCom.aspx?sid=<%=idcompete %>">��Ŀ�б�<i></i></a>
                            <a class="eqmaa eqmajd" href="insertbooklb.aspx?sid=<%=idcompete %>">�����б�<i></i></a>
                            <a class="eqmaa eqmajd" href="Navigationlb.aspx?sid=<%=idcompete %>">�����б�<i></i></a>
                            <a class="eqmaa eqmajd" href="tblAnnex.aspx?sid=<%=idcompete %>">�������б�<i></i></a>
                            <a class="eqmaa eqmajd" href="ItemsZblb.aspx?sid=<%=idcompete %>">װ���б�<i></i></a>
                            <a class="eqmaa eqmajd" href="Itemsjdlb.aspx?sid=<%=idcompete %>">�Ƶ��б�<i></i></a>
                            <a class="eqmaa eqmajd" href="ItemsLylb.aspx?sid=<%=idcompete %>">�����б�<i></i></a>
                        </div>
                        <div class="eqmar am-form ">
                            <div class="fbtitle">
                                ��Ŀ�б�/<a class="addproject" href="RaceEdit.aspx?id=0&sid=<%=idcompete%>">�����Ŀ</a>
                                <div class="auditclub">
                                    <asp:repeater id="rptrunrecord" runat="server">
                        <HeaderTemplate>
                        <table class="maxm">
                            <tr>
                              <%--  <td>���</td>--%>
                                <td>���</td>
                                <td>����</td>
                                <td>����</td>
                                <td>����</td>
                                <td>��ע</td>
                                <td>��װ</td> 
                                <td>��Ь</td> 
                                <td>�ϸ�֤</td>
                                <td>���</td>
                                <td>���ֶһ�</td>                                                       
                                <td>����</td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <%--<td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>--%>
                             <td>
                                <%#  Eval("iType").ToString() == "1" ? "����": Eval("iType").ToString() == "2" ? "�⼮": Eval("iType").ToString() == "3" ? "���("+Eval("iNum").ToString()+"��)": Eval("iType").ToString() == "4" ? "�Ŷ�": "����"%>
                            </td>
                           <td><%# DataBinder.Eval(Container.DataItem, "cItemName")%></td>                            
                            <td><%# DataBinder.Eval(Container.DataItem, "iCost")%>Ԫ</td>
                            <td><%# DataBinder.Eval(Container.DataItem, "iLimit")%>��</td>
                              <td><%# DataBinder.Eval(Container.DataItem, "cComment")%></td>
                             <td>
                                <%#  Eval("iCloth").ToString() == "1" ? "��": "��"%>                                
                            </td>
                            <td>
                                <%#  Eval("iShoe").ToString() == "1" ? "��": "��"%>                                
                            </td>
                            <td>
                                <%#  Eval("ihealth").ToString() == "1" ? "��": "��"%>                                
                            </td>
                             <td>
                                <%#  Eval("iAudit").ToString() == "1" ? "��": "��"%>                                
                            </td> 
                             <td>
                                  <%#  Eval("iScore").ToString() == "0" ? "��":Eval("iScore").ToString() != "0"&& Eval("iMoney").ToString() == "0"?"��߿�ʹ��"+Eval("iScore").ToString()+"����": Eval("iScore").ToString()+"���ֶһ�"+ Eval("iMoney").ToString()+"Ԫ"%> 
                                 <%--<%#  Eval("iScore").ToString() == "0" ? "��": Eval("iScore").ToString()+"���ֶһ�"+ Eval("iMoney").ToString()+"Ԫ"%> --%>
                            </td>     
                             <td><a href='<%# "RaceEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&sid="+DataBinder.Eval(Container.DataItem, "idCompete") %>'>�༭</a>
                            <%--<a href='<%# "RaceEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>'>ɾ��</a>--%>
                             </td>
                        </tr>
                    </ItemTemplate>
                    <%--AlternatingItemTemplate������������е���һ�����--%>
                    <AlternatingItemTemplate>
                        <tr bgcolor="#e8e8e8">
                           <%-- <td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>--%>
                            <td>
                                <%#  Eval("iType").ToString() == "1" ? "����": Eval("iType").ToString() == "2" ? "�⼮": Eval("iType").ToString() == "3" ? "���("+Eval("iNum").ToString()+"��)": Eval("iType").ToString() == "4" ? "�Ŷ�": "����"%>
                            </td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cItemName")%></td>                            
                            <td><%# DataBinder.Eval(Container.DataItem, "iCost")%>Ԫ</td>
                            <td><%# DataBinder.Eval(Container.DataItem, "iLimit")%>��</td>
                              <td><%# DataBinder.Eval(Container.DataItem, "cComment")%></td>
                             <td>
                                <%#  Eval("iCloth").ToString() == "1" ? "��": "��"%>                                
                            </td>
                            <td>
                                <%#  Eval("iShoe").ToString() == "1" ? "��": "��"%>                                
                            </td>
                            <td>
                                <%#  Eval("ihealth").ToString() == "1" ? "��": "��"%>                                
                            </td>    
                             <td>
                                <%#  Eval("iAudit").ToString() == "1" ? "��": "��"%>                                
                            </td>
                            <td>                        
                                 <%#  Eval("iScore").ToString() == "0" ? "��":Eval("iScore").ToString() != "0"&& Eval("iMoney").ToString() == "0"?"��߿�ʹ��"+Eval("iScore").ToString()+"����": Eval("iScore").ToString()+"���ֶһ�"+ Eval("iMoney").ToString()+"Ԫ"%> 
                            </td>   
                            <td><a href='<%# "RaceEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&sid="+DataBinder.Eval(Container.DataItem, "idCompete") %>'>�༭</a>
                            <%--<a href='<%# "RaceEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>'>ɾ��</a>--%>
                            </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:repeater>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</form>
<ERUN360:footerv3 runat="server" ID="footerv3" />
