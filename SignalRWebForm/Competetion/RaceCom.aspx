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
                            <a class="eqmaa eqmajd" href="RaceCom.aspx?sid=<%=idcompete %>">项目列表<i></i></a>
                            <a class="eqmaa eqmajd" href="insertbooklb.aspx?sid=<%=idcompete %>">赛记列表<i></i></a>
                            <a class="eqmaa eqmajd" href="Navigationlb.aspx?sid=<%=idcompete %>">导航列表<i></i></a>
                            <a class="eqmaa eqmajd" href="tblAnnex.aspx?sid=<%=idcompete %>">附加项列表<i></i></a>
                            <a class="eqmaa eqmajd" href="ItemsZblb.aspx?sid=<%=idcompete %>">装备列表<i></i></a>
                            <a class="eqmaa eqmajd" href="Itemsjdlb.aspx?sid=<%=idcompete %>">酒店列表<i></i></a>
                            <a class="eqmaa eqmajd" href="ItemsLylb.aspx?sid=<%=idcompete %>">旅游列表<i></i></a>
                        </div>
                        <div class="eqmar am-form ">
                            <div class="fbtitle">
                                项目列表/<a class="addproject" href="RaceEdit.aspx?id=0&sid=<%=idcompete%>">添加项目</a>
                                <div class="auditclub">
                                    <asp:repeater id="rptrunrecord" runat="server">
                        <HeaderTemplate>
                        <table class="maxm">
                            <tr>
                              <%--  <td>编号</td>--%>
                                <td>类别</td>
                                <td>名称</td>
                                <td>费用</td>
                                <td>名额</td>
                                <td>备注</td>
                                <td>服装</td> 
                                <td>跑鞋</td> 
                                <td>合格证</td>
                                <td>审核</td>
                                <td>积分兑换</td>                                                       
                                <td>操作</td>
                            </tr>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <tr>
                            <%--<td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>--%>
                             <td>
                                <%#  Eval("iType").ToString() == "1" ? "国内": Eval("iType").ToString() == "2" ? "外籍": Eval("iType").ToString() == "3" ? "组队("+Eval("iNum").ToString()+"人)": Eval("iType").ToString() == "4" ? "团队": "其他"%>
                            </td>
                           <td><%# DataBinder.Eval(Container.DataItem, "cItemName")%></td>                            
                            <td><%# DataBinder.Eval(Container.DataItem, "iCost")%>元</td>
                            <td><%# DataBinder.Eval(Container.DataItem, "iLimit")%>人</td>
                              <td><%# DataBinder.Eval(Container.DataItem, "cComment")%></td>
                             <td>
                                <%#  Eval("iCloth").ToString() == "1" ? "是": "否"%>                                
                            </td>
                            <td>
                                <%#  Eval("iShoe").ToString() == "1" ? "是": "否"%>                                
                            </td>
                            <td>
                                <%#  Eval("ihealth").ToString() == "1" ? "是": "否"%>                                
                            </td>
                             <td>
                                <%#  Eval("iAudit").ToString() == "1" ? "是": "否"%>                                
                            </td> 
                             <td>
                                  <%#  Eval("iScore").ToString() == "0" ? "无":Eval("iScore").ToString() != "0"&& Eval("iMoney").ToString() == "0"?"最高可使用"+Eval("iScore").ToString()+"积分": Eval("iScore").ToString()+"积分兑换"+ Eval("iMoney").ToString()+"元"%> 
                                 <%--<%#  Eval("iScore").ToString() == "0" ? "无": Eval("iScore").ToString()+"积分兑换"+ Eval("iMoney").ToString()+"元"%> --%>
                            </td>     
                             <td><a href='<%# "RaceEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&sid="+DataBinder.Eval(Container.DataItem, "idCompete") %>'>编辑</a>
                            <%--<a href='<%# "RaceEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>'>删除</a>--%>
                             </td>
                        </tr>
                    </ItemTemplate>
                    <%--AlternatingItemTemplate描述交替输出行的另一种外观--%>
                    <AlternatingItemTemplate>
                        <tr bgcolor="#e8e8e8">
                           <%-- <td>
                            <asp:Label ID="lblID" Text='<%# DataBinder.Eval(Container.DataItem, "id")%>' runat="server"></asp:Label></td>--%>
                            <td>
                                <%#  Eval("iType").ToString() == "1" ? "国内": Eval("iType").ToString() == "2" ? "外籍": Eval("iType").ToString() == "3" ? "组队("+Eval("iNum").ToString()+"人)": Eval("iType").ToString() == "4" ? "团队": "其他"%>
                            </td>
                            <td><%# DataBinder.Eval(Container.DataItem, "cItemName")%></td>                            
                            <td><%# DataBinder.Eval(Container.DataItem, "iCost")%>元</td>
                            <td><%# DataBinder.Eval(Container.DataItem, "iLimit")%>人</td>
                              <td><%# DataBinder.Eval(Container.DataItem, "cComment")%></td>
                             <td>
                                <%#  Eval("iCloth").ToString() == "1" ? "是": "否"%>                                
                            </td>
                            <td>
                                <%#  Eval("iShoe").ToString() == "1" ? "是": "否"%>                                
                            </td>
                            <td>
                                <%#  Eval("ihealth").ToString() == "1" ? "是": "否"%>                                
                            </td>    
                             <td>
                                <%#  Eval("iAudit").ToString() == "1" ? "是": "否"%>                                
                            </td>
                            <td>                        
                                 <%#  Eval("iScore").ToString() == "0" ? "无":Eval("iScore").ToString() != "0"&& Eval("iMoney").ToString() == "0"?"最高可使用"+Eval("iScore").ToString()+"积分": Eval("iScore").ToString()+"积分兑换"+ Eval("iMoney").ToString()+"元"%> 
                            </td>   
                            <td><a href='<%# "RaceEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id")+"&sid="+DataBinder.Eval(Container.DataItem, "idCompete") %>'>编辑</a>
                            <%--<a href='<%# "RaceEdit.aspx?id="+DataBinder.Eval(Container.DataItem, "id") %>'>删除</a>--%>
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
