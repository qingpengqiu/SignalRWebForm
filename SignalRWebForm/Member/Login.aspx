<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="_Member_Login" %><!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <title>登录-ERUN360.COM</title>
    <title>注册-益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <script language="javascript" src="/Common/jQuery.js"></script>
    <script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Common/jCalendar.js"></script>
    <link href="/Common/login.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/loginmedia.css" />

</head>
<body>
    <div class="login_cen">
        <a class="lmediah" href="/">返回首页</a>
        <img class="medialogo" src="/Html/images/medialogo.jpg">
        <a href="" class="fenxiang">分享你我跑过 <font>38540km</font> 的心路历程
        </a>
        <a href="/" class="logo"></a>
        <div class="login_left" id="pageContent">
            <em>用户登录</em>
            <form autocomplete="off" method="post" action="Login.aspx" name="form1" id="form1">
                <table width="100%" cellspacing="0" cellpadding="0" border="0" id="tableCreate">
                    <tbody>
                        <tr>
                            <td>
                                <input type="text" onblur="if(NullCheck(this)) LengthCheck(this,2,32);" value="" maxlength="32" size="24" name="cLoginName" id="cLoginName" placeholder="用户名">
                                <span class="check_echo" id="check_cLoginName"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="password" onblur="if(NullCheck(this)) if(LengthCheck(this,6,32)) StringCheck(this);" value="" maxlength="32" size="24" name="cPassword" id="cPassword"  placeholder="密　码">
                                <span class="check_echo" id="check_cPassword"></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto">
                                <input type="checkbox" value="1" checked="" name="auto" id="auto"><label class="autologin">下次自动登录</label> <a href="/Member/Query.aspx">忘记密码</a>
                                <div id="submit_command">
                                    <a class="loginbott" onmouseover="ShowSubmit();">登&nbsp;&nbsp;录</a>
                                </div>
                                <div class="check_echo" id="total_echo">
                                    <% =PageResult %>
                                </div>
                                <div class="loginm"><a href="/Member/register.aspx">注册帐号</a>   |   <a href="/Member/Query.aspx">忘记密码</a></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
            <em>还没有益跑帐号？</em>
            <div class="jryp">
                <a href="/Member/register.aspx">
                    <img src="/Images/login/jryp.png" alt="">
                </a>
            </div>
            <em>他们刚刚加入益跑</em>
            <ul>
                <% =GetNewUser() %>
            </ul>
        </div>
        <div class="login_right">
            <span>赛事快递</span>
            <ul class="sskd">
                <%=GetMatch() %>
            </ul>
            <span>最新约跑</span>
            <ul class="zxyp">
                <%=GetRunning() %>
            </ul>
            <span>最新跑量</span>
            <p>
                <%=GetMileage() %>
            </p>
            <span>最新博文</span>
            <ul class="zxbw">
                <%=GetNewBlog() %>
            </ul>
        </div>
    </div>
    <script type="text/javascript" language="javascript">

        document.onkeydown = function (event) {
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if (e && e.keyCode == 13) {
                Finish();
            }
        };
        //document.form1.reset();
        $(function () {
            var ctrl = document.getElementById("cLoginName");
            ctrl.focus();
        });

        function ShowSubmit() {
            var obj = $("#cLoginName")[0];
            if (obj.value.length > 0) {
                obj = $("#cPassword")[0];
                if (obj.value.length > 0) {
                    $("#submit_command").html("<a class=\"loginbott\" onmouseover='Finish()'>登&nbsp;&nbsp;录</a>");
                }
            }
        }

        function verifyAll() {
            var check_num = 2;
            var obj = $("#cLoginName")[0];
            if (NullCheck(obj)) if (StringCheck(obj)) if (LengthCheck(obj, 2, 32)) { check_num--; }
            obj = $("#cPassword")[0];
            if (NullCheck(obj)) if (LengthCheck(obj, 6, 32)) if (StringCheck(obj)) { check_num--; }

            return (check_num == 0) ? true : false;
        }

        function Finish() {
            if (verifyAll()) {
                document.form1.submit();
                return true;
            }
            else {
                $("#total_echo").html("不行啊！有错误哦！");
            }
            return false;
        }

    </script>
<script src="http://s14.cnzz.com/stat.php?id=4723271&web_id=4723271&show=pic" language="JavaScript"></script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("a[title='站长统计']").hide();
        });
    </script>
</body>
</html>
