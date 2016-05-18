<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Erun_Header_mini.ascx.cs" Inherits="Controls_Erun_Header_mini" %>
<div class="header headermini">
    <div class="articleh">
        <div class="mediaLogin">
            <a href="/" class="erunlogo"><img src="/Html/images/logo-1.png" ></a>
            <%if (cId == 0) %>
            <%{ %>
            <a class="ml2" onclick="PopupShowdl(520,305,'登录','/utility/include/login.aspx');StatusCheck();" href="javascript:">登录</a>
            <a class="ml2" href="/Member/register.aspx">注册</a>
            <%} %>
            <%else %>
            <%{ %>
            <label class="ml3 mnone"><i></i>俱乐部
                <input name="switch-field-1" class="ace ace-switch ace-switch-4 btn-flat" type="checkbox"  value="3"/>
                <ul>
                    <li><a href="/infocenter/ClubJoin.aspx">我加入的</a></li>
                    <li><a href="/infocenter/SearchClub.aspx" >搜索俱乐部</a></li>
                    <%=club %>  
                </ul>
            </label>
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
            <a class="ml3 uname" href="<%=UrlHelper.MemberUrl(cId) %>"><%=cName %></a>
        <%} %>

        </div>
        <ul class="mnav">
            <li class="meidlogin"><a href="/" ><img src="/Html/images/logo-1.png"></a></li>
            <li><a href="/channels/competetion/RaceList.aspx">赛事报名</a></li>
            <li><a href="/channels/shoe/">跑步装备</a></li>
            <li><a href="/channels/train/">跑步训练</a></li>
            <li class="navmore"><i>&laquo;</i>
                <dl>
                    <!-- <dd><a href="/infocenter/ClubSearch.aspx">约跑</a></dd>
                    <dd><a href="/infocenter/SearchClub.aspx">俱乐部</a></dd> -->
                    <dd><a href="/Raceresult/RaceQuery.aspx">证书查询</a></dd>
                    <dd><a href="/channels/nutrition/">营养瘦身</a></dd>
                    <dd><a href="/channels/health/">健康恢复</a></dd>
                    <dd><a href="/channels/beginner/">初级跑者</a></dd>
                    <dd><a href="/channels/life/">跑步人生</a></dd>
                    <dd><a href="/channels/tools/">小工具</a></dd>
                </dl>
            </li>
        </ul>
        <ul class="nav">
            <li class="h_sy"><a href="/"><em><img src="/Html/images/indexb.png" alt="">首页</em></a> </li>
            <li class="h_js"><em><a href="javascript:void(0)">赛事</a></em>
                <dl>
                    <dt><a href="/channels/competetion/">+ 赛事&bull;城市</a></dt>
                    <dt><a href="/channels/competetion/RaceList.aspx">+ 赛事报名</a></dt>
                    <dt><a href="/Channels/Competetion/Album.aspx">+ 赛事相册</a></dt>
                    <dt><a href="/Raceresult/RaceQuery.aspx">+ 成绩查询</a></dt>
                </dl>
            </li>
            <li class="h_zb"><em><a href="javascript:void(0)">装备</a></em>
                <dl>
                    <dt><a href="/channels/shoe/">+ 跑步装备</a></dt>
                    <dt><a href="/infocenter/ShoeFind.aspx">+ 选鞋</a></dt>
                    <!-- <dt><a href="/channels/competetion/">+ 装备测评</a></dt>
                    <dt><a href="/infocenter/ShoeFind.aspx">+ 选鞋</a></dt>
                    <dt><a href="/channels/competetion/">+ 穿衣推荐</a></dt> -->
                    <dt><a href="/GroupBuy/GroupList.aspx">+ 拼团</a></dt>
                </dl>
            </li>
            <li class="h_xl"><em><a href="javascript:void(0)">训练</a></em>
                <dl>
                    <dt><a href="/channels/train/">+ 跑步训练</a></dt>
                    <!-- <dt><a href="/channels/competetion/">+ 训练计划</a></dt>
                    <dt><a href="/channels/competetion/">+ 益跑教练</a></dt> -->
                </dl>
            </li>
            <li class="h_yy"><em><a href="javascript:void(0)">营养恢复</a></em>
                <dl>
                    <dt><a href="/channels/nutrition/">+ 营养瘦身</a></dt>
                    <dt><a href="/channels/health/">+ 健康恢复</a></dt>
                </dl>
            </li>
            <li class="h_zl"><em><a href="javascript:void(0)">跑者专栏</a></em>
                <dl>
                    <!-- <dt><a href="/channels/expert/">+ 益跑专栏</a></dt> -->
                    <dt><a href="/channels/beginner/">+ 初级跑者</a></dt>
                    <dt><a href="/channels/life/">+ 跑步人生</a></dt>
                </dl>
            </li>
            <li class="h_yp"><em><a href="/infocenter/ClubSearch.aspx">约跑</a></em> </li>
            <li class="h_jlb"><em><a href="/infocenter/SearchClub.aspx">俱乐部</a></em> </li>
            <li class="h_gc"><em><a href="/infocenter/Plaza.aspx">跑者广场</a></em> </li>
            <li class="h_gj"><em><a href="/channels/tools/">小工具</a></em> </li>
        </ul>
    </div>
</div>
<script type="text/javascript">
$(".navmore").click(function(event) {
    $(".navmore dl").toggle()
});

//定时获取新留言数新粉丝数
var int=self.setInterval("gettwo()",60000)
jQuery(document).ready(function($) {
    gettwo()
});
function gettwo() {
$.ajax({
   type: "GET",
   url: "/infocenter/Include/AjaxCount.aspx",
   data: { rnd: Math.random() },
   contentType: "application/json; charset=utf-8",
   dataType: "json",
   success: function(msg){
        if(msg.hea > "0"){
            $(".msgshowa").append("<em>"+msg.hea+"</em>")
        }
        if(msg.count > "0"){
            $(".msgshowl").append("<em>"+msg.count+"</em>")
        }
        if(msg.msgcount > "0"){
            $(".msgshowb").append("<em>"+msg.msgcount+"</em>")
            $(".msgshowf").append("<em>"+msg.msgcount+"</em>")
        }
        if(msg.dcscount > "0"){
            $(".msgshowpl").append("<em>"+msg.dcscount+"</em>")
        }
   }
}); 
}

function SearchIt(){
    if(document.getElementById("word").value.length > 0){
        $(".serch").attr("href","\/infocenter\/findpeople.aspx?searchname="+document.getElementById("word").value)
        return true;
    }
    return false;
}
$(".ml3 input").click(function(event) {
    $(".zhuanti").click();
    console.log(111)
});
</script>