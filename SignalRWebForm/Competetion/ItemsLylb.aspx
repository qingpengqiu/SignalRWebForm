<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ItemsLylb.aspx.cs" Inherits="Competetion_ItemsLylb" %>
<%@ Register Src="~/Competetion/bmnav.ascx" TagPrefix="ERUN360" TagName="bmnav" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<style type="text/css">
    body{background: #f6f6f6}
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
                			<a class="eqmaa eqmajd" href="RaceCom.aspx?sid=<%=sid %>">项目列表<i></i></a>
                            <a class="eqmaa eqmajd" href="insertbooklb.aspx?sid=<%=sid %>">赛记列表<i></i></a>
                            <a class="eqmaa eqmajd" href="Navigationlb.aspx?sid=<%=sid %>">导航列表<i></i></a>
                            <a class="eqmaa eqmajd" href="tblAnnex.aspx?sid=<%=sid %>">附加项列表<i></i></a>
                            <a class="eqmaa eqmajd" href="ItemsZblb.aspx?sid=<%=sid %>">装备列表<i></i></a>
                            <a class="eqmaa eqmajd" href="Itemsjdlb.aspx?sid=<%=sid %>">酒店列表<i></i></a>
                            <a class="eqmaa eqmajd" href="ItemsLylb.aspx?sid=<%=sid %>">旅游列表<i></i></a>
                		</div>
                		<div class="eqmar am-form ">
                                <div class="fbtitle">旅游列表/<a  class="addproject" href="ItemsLy.aspx?id=0&sid=<%=sid%>" >添加旅游</a>
<div class="auditclub">
               <asp:Repeater ID="rptrunrecord" runat="server">
                        <HeaderTemplate>
                        <table class="maxm">
                            <tr>
                                <td>编号</td>
                                <td>旅游名称</td>
                                <td>总数量</td>
                                <td>最大购买量</td>
                                <td>操作</td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>
                             
                           <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>                            
                            <td><%# DataBinder.Eval(Container.DataItem, "iTotal")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "iBuyMax")%></td>                            
                             <td><a href='<%# "ItemsLy.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&sid="+DataBinder.Eval(Container.DataItem, "idCompete") %>' >编辑</a>
                             </td>
                        </tr>
                    </ItemTemplate>
                    <%--AlternatingItemTemplate描述交替输出行的另一种外观--%>
                    <AlternatingItemTemplate>
                        <tr bgcolor="#e8e8e8">
                          <td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>
                             
                           <td><%# DataBinder.Eval(Container.DataItem, "cName")%></td>                            
                            <td><%# DataBinder.Eval(Container.DataItem, "iTotal")%></td>
                            <td><%# DataBinder.Eval(Container.DataItem, "iBuyMax")%></td>                            
                             <td><a href='<%# "ItemsLy.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&sid="+DataBinder.Eval(Container.DataItem, "idCompete") %>' >编辑</a>
                             </td>
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