<%@ Page Language="C#" AutoEventWireup="true" CodeFile="tblAnnex.aspx.cs" Inherits="Competetion_tblAnnex" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
</style>
<style>
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
.eqmal a{margin-bottom: 10px}
.eqmal a:hover{color:#fff}
</style>
	<div class="banner">
	     <div class="mine"><h1><%=title %></h1>
            <asp:Literal ID="ltlbanner" runat="server"></asp:Literal>
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
                			<a class="eqmaa eqmajd" href="RaceCom.aspx?sid=<%=id %>">��Ŀ�б�<i></i></a>
                            <a class="eqmaa eqmajd" href="insertbooklb.aspx?sid=<%=id %>">�����б�<i></i></a>
                            <a class="eqmaa eqmajd" href="Navigationlb.aspx?sid=<%=id %>">�����б�<i></i></a>
                            <a class="eqmaa eqmajd" href="tblAnnex.aspx?sid=<%=id %>">�������б�<i></i></a>
                            <a class="eqmaa eqmajd" href="ItemsZblb.aspx?sid=<%=id %>">װ���б�<i></i></a>
                            <a class="eqmaa eqmajd" href="Itemsjdlb.aspx?sid=<%=id %>">�Ƶ��б�<i></i></a>
                            <a class="eqmaa eqmajd" href="ItemsLylb.aspx?sid=<%=id %>">�����б�<i></i></a>
                		</div>
                		<div class="eqmar am-form ">
                                <div class="fbtitle">���������/<a href="tblAnnexAdd.aspx?id=0&sid=<%=id %>" class="tnewuser">��Ӹ�����</a>
<div class="auditclub">
               <asp:Repeater ID="Repeater1" runat="server">
                    <HeaderTemplate>
                        <table>
                            <tr>
                                <td>���</td>
                                <td>���±��</td>
                                <td>��Ʒ����</td>
                                <td>����</td>
                                <td>����</td>
                                <td>�޹�</td>
                                <%--<td>��ʾ����</td>--%>
                                <td>����</td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                       <tr>
                            <td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "idCompete")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "iNum")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "fPrice")%></td>
                           <td><%# DataBinder.Eval(Container.DataItem, "iBuyNum")%></td>
                           <%--<td><%# DataBinder.Eval(Container.DataItem, "iGlobal")%></td>--%>
                            <td><a href="tblAnnexAdd.aspx?id=<%#DataBinder.Eval(Container.DataItem, "id")%>&sid=<%=id%>" target="_self">�༭</a> </td>
                        </tr>
                    </ItemTemplate>
                    <%--AlternatingItemTemplate������������е���һ�����--%>
                    <AlternatingItemTemplate>
                       <tr  bgcolor="#e8e8e8">
                            <td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "idCompete")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "iNum")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "fPrice")%></td>
                           <td><%# DataBinder.Eval(Container.DataItem, "iBuyNum")%></td>
                           <%--<td><%# DataBinder.Eval(Container.DataItem, "iGlobal")%></td>--%>
                            <td><a href="tblAnnexAdd.aspx?id=<%#DataBinder.Eval(Container.DataItem, "id")%>&sid=<%=id%>" target="_self">�༭</a> </td>
                        </tr>
                    </AlternatingItemTemplate>
                    <FooterTemplate>
                        </table>
                    </FooterTemplate>
                </asp:Repeater>
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