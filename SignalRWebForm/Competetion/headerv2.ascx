<%@ Control Language="C#" AutoEventWireup="true" CodeFile="headerv2.ascx.cs" Inherits="Controls_headerv2" %>
    <div class="header">
        <div class="mine">
            <a href="/" class="logo"><img src="/Html/images/logo.png" alt=""></a>
            <ul class="mnav">
            <li class="meidlogin"><a href="/" ><img src="/Html/images/logo-1.png"></a></li>
            <li><a href="/Competetion/SearchEvent.aspx">赛事报名</a></li>
            <li><a href="/Channels/Competetion/internationalEvents.aspx">国际直通车</a></li>
            <li><a href="/GroupBuy/GroupList.aspx">拼团</a></li>
            <li class="navmore"><i>&laquo;</i>
                <dl>
                    <!-- <dd><a href="/infocenter/ClubSearch.aspx">约跑</a></dd>
                    <dd><a href="/infocenter/SearchClub.aspx">俱乐部</a></dd> -->
                    <dd><a href="/Raceresult/RaceQuery.aspx">成绩查询</a></dd>
                    <dd><a href="/channels/nutrition/">营养瘦身</a></dd>
                    <dd><a href="/channels/health/">健康恢复</a></dd>
                    <dd><a href="/channels/beginner/">初级跑者</a></dd>
                    <dd><a href="/channels/life/">跑步人生</a></dd>
                    <dd><a href="/channels/shoe/">跑步装备</a></dd>
                    <dd><a href="/channels/train/">跑步训练</a></dd>
                    <dd><a href="/channels/tools/">小工具</a></dd>
                </dl>
            </li>
        </ul>
            <div class="nav">
                <div class="nava"><a href="/">首页</a>
                </div><i>&bull;</i>
                <div class="nava">赛事
                    <dl><em></em>
                        <dt><a href="/channels/competetion/">赛事<b>&bull;</b>城市</a></dt>
                        <dt><a href="/Competetion/SearchEvent.aspx">赛事报名</a></dt>
                        <dt><a href="/Channels/Competetion/internationalEvents.aspx">国际直通车</a></dt>
                        <dt><a href="/Channels/Competetion/Album.aspx">赛事相册</a></dt>
                        <dt><a href="/Raceresult/RaceQuery.aspx">成绩查询</a></dt>
                        <dt><a href="/channels/competetion/ApplyFrom.aspx">赛事发布申请</a></dt>
                        <dt><a href="/Flight/flightgroom.aspx">国内机票</a></dt>
                    </dl>
                </div><i>&bull;</i>
                <div class="nava">装备
                    <dl>
                        <dt><a href="/channels/shoe/">跑步装备</a></dt>
                        <dt><a href="/infocenter/ShoeFind.aspx">选鞋</a></dt>
                        <!-- <dt><a href="/channels/competetion/">装备测评</a></dt>
                        <dt><a href="/infocenter/ShoeFind.aspx">选鞋</a></dt>
                        <dt><a href="/channels/competetion/">穿衣推荐</a></dt> -->
                        <dt><a href="/GroupBuy/GroupList.aspx">拼团</a></dt>
                       
                    </dl>
                </div><i>&bull;</i>
                <div class="nava">训练
                    <dl>
                        <dt><a href="/channels/train/">跑步训练</a></dt>
                        <!-- <dt><a href="/channels/competetion/">训练计划</a></dt>
                        <dt><a href="/channels/competetion/">益跑教练</a></dt> -->
                    </dl>
                </div><i>&bull;</i>
                <div class="nava">营养恢复
                    <dl>
                        <dt><a href="/channels/nutrition/">营养瘦身</a></dt>
                        <dt><a href="/channels/health/">健康恢复</a></dt>
                    </dl>
                </div><i>&bull;</i>
                <div class="nava">跑者专栏
                    <dl>
                        <!-- <dt><a href="/channels/expert/">益跑专栏</a></dt> -->
                        <dt><a href="/channels/beginner/">初级跑者</a></dt>
                        <dt><a href="/channels/life/">跑步人生</a></dt>
                    </dl>
                </div><i>&bull;</i>
                <div class="nava"><a href="/infocenter/ClubSearch.aspx">约跑</a></div><i>&bull;</i>
                <div class="nava"><a href="/infocenter/SearchClub.aspx">俱乐部</a></div><i>&bull;</i>
                <div class="nava"><a href="/infocenter/Plaza.aspx">跑者广场</a></div><i>&bull;</i>
                <div class="nava"><a href="/channels/tools/">小工具</a></div>
            </div>
             <div class="icenter">
                 <asp:Literal ID="ltlstatus" runat="server"></asp:Literal>
                <%--<a href="" class="dla">登陆</a><a href="" class="zca">注册</a>--%>
            </div> 
            <%--<div class="icenter">Hello，<a href="/user/<%=cId %>.aspx"><%=cName %></a><i></i>
                <dl>
                    <dt><a href="/infocenter/Account.aspx?uId=100002013">帐户管理</a></dt>
                    <dt><a href="/infocenter/Message.aspx?uId=100002013">留言</a></dt>
                    <dt><a href="/infocenter/Comments.aspx?uId=100002013">评论</a></dt>
                    <dt><a href="/infocenter/Integral.aspx?uId=100002013">积分</a></dt>
                    <dt><a href="/Member/Logout.aspx">退出登录</a></dt>
                </dl>
            </div>--%>
            <div class="both"></div>
        </div>
    </div>
<script type="text/javascript">
$(".navmore").click(function(event) {
    $(".navmore dl").toggle()
});
</script>

<div class="mediaLogin">
            <%if (cId == 0) %>
            <%{ %>
            <a class="ml2" onclick="PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();" href="javascript:">登录</a>
            <a class="ml2" href="/Member/register.aspx">注册</a>
            <%} %>
            <%else %>
            <%{ %>
<!--             <label class="ml3 mnone"><i></i>俱乐部
                <input name="switch-field-1" class="ace ace-switch ace-switch-4 btn-flat" type="checkbox"  value="3"/>
                <ul>
                    <li><a href="/infocenter/ClubJoin.aspx">我加入的</a></li>
                    <li><a href="/infocenter/SearchClub.aspx" >搜索俱乐部</a></li>
                    <%=club %>  
                </ul>
            </label> -->
            <a class="ml3 uname" href="<%=UrlHelper.MemberUrl(cId) %>"><%=cName %></a>
            <label class="ml3 msgshowb"><i></i>我的好友
                <input name="switch-field-2" class="ace ace-switch ace-switch-4 btn-flat" type="checkbox"  value="2"/>
                <ul>
                    <li><a href="/infocenter/Focus.aspx?uId=<%=cId %>">关注</a></li>
                    <li><a href="/infocenter/Fans.aspx?uId=<%=cId %>" class="msgshowf">粉丝</a></li>
                    <li><a href="/infocenter/recom.aspx?uId=<%=cId %>">编辑推荐</a></li>
                    <li><a href="/infocenter/findpeople.aspx?uId=<%=cId %>">查找好友</a></li>
                    <li><a href="<%=UrlHelper.ClubUrl(600000000) %>">俱乐部</a><i></i></li>
                </ul>
            </label>
            <label class="ml3 msgshowa"><i></i>我的益跑
                <input name="switch-field-3" class="ace ace-switch ace-switch-4 btn-flat" type="checkbox"  value="3"/>
                <ul>
                    <li><a href="/infocenter/Account.aspx?uId=<%=cId %>">帐户管理</a></li>
                    <li><a href="/infocenter/Message.aspx?uId=<%=cId %>" class="msgshowl">留言</a></li>
                    <li><a href="/infocenter/Comments.aspx?uId=<%=cId %>" class="msgshowpl">评论</a></li>
                    <li><a href="/infocenter/Integral.aspx?uId=<%=cId %>">积分</a></li>
                    <!-- <li><a href="/infocenter/Default.aspx?uId=<%=cId %>">跑界名片</a><i></i></li> -->
                    <li><a href="/Member/Logout.aspx">退出登录</a><i></i></li>
                    <%=admin %>   
                </ul>
            </label>
        <%} %>
        </div>