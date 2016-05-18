<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Erun_Right.ascx.cs" Inherits="Controls_Erun_Right" %>
<div class="main-right-b">
    <%=cFans %>
    <%=cAction %>
  <%--  <ul class="recomul"><li><a target="_blank" href="/infocenter/Default.aspx?uId=100003195"><img src="/images/noname.gif">wangyi </a><br><em>推荐原因</em>：新注册用户<br><a href="javascript:void(0)" class="focus focus5" rel="/action/GetFoucsList.ashx?command=addFoucs&amp;uId=100003195&amp;timestamp=20140107164442594">+ 关注TA</a>
    <span>大丸子 等5个好友关注了TA</span></li></ul>--%>
    <div class="recom plcom">&nbsp;上周跑量排行</div>
    <ul class="recomul">
        <asp:Repeater ID="rptRanking" runat="server">
            <ItemTemplate>
                <li>
                    <a href="/user/<%#Eval("idUser") %>.aspx" target="_blank">
                        <img src="<%#Eval("cAvatar").ToString().Trim() %>" alt="placeholder+image">
                        <em><%#Eval("cName") %></em></a>
                    <br>
                    <%#Eval("num") %>公里
                </li>
            </ItemTemplate>
        </asp:Repeater>
    </ul>
</div>
