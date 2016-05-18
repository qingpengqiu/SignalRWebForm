<%@ Page Language="C#" AutoEventWireup="true" CodeFile="minilogin.aspx.cs" Inherits="Member_minilogin" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。">
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <link rel="icon" type="image/png" href="/assets/i/favicon.png">
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI" />
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileImage" content="/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link rel="stylesheet" href="/assets/css/amazeui.min.css">
</head>
<body>
<style type="text/css">
/*登陆框css 全局*/
.loginbox{width: 430px;height: 330px;background:url(/Html/images/loginbox.jpg) #fff no-repeat;padding: 8px 0 0 14px;font-size:14px;}
.loginboxinput{padding-top: 50px;}
.v3lbt{padding-bottom: 15px;}
.v3lbt label{width: 136px;text-align: right;font-weight: 400;color: #7c8f7a;padding-right: 9px;}
.v3lbt input{outline: none;border: 1px solid #cfd5cf;width: 167px;height: 30px;padding-left: 6px;border-radius: 3px;}
.v3lbt input:focus{border-color: #87bb54}
.autologin{padding-left: 136px;font-size: 12px;color: #7c8f7a;}
.autologin label{font-weight: 400;}
.autologin a{color: #ff3000;line-height: 1.1;border-bottom: 1px solid #ff3000}
.autologin input{margin-right: 4px;}
.loginboxinput #boxlogingo{width: 200px;height: 30px;display: block;margin: 16px auto 10px auto;background: #33ab1b;line-height: 1;text-align: center;color: #fff;font-size: 12px;border-radius: 5px;border: 0;line-height: 30px;}
.loginboxinput #boxlogingo:hover{background: #3bc520}
.tiplogin{font-size: 14px;color: #4d5a4b;text-align: center;}
.tiplogin a{color: #f28b06;border-bottom: 1px solid #f28b06;}
.lblogo{width: 127px;}
.lblogob{display: none;}
.postbuttonbox{padding: 50px 0;text-align: center;}
.postblogbutton{color: #fff;width: 140px;height: 34px;border-radius: 3px;background: #87bb54;text-align: center;display: inline-block;line-height: 34px;}
.postblogbutton:hover,.postblogbutton:focus{color: #fff;}
.blogyl{font-size: 12px;display: inline-block;padding: 0 10px;}
</style>
<div class="loginbox">
    <img src="/Html/images/wlogo.png" class="lblogo">
    <img src="/Html/images/logobig.png" class="lblogob">
    <div class="loginboxinput">
        <form id="boxloginf">
        <div class="v3lbt">
            <label>登录名</label><input type="text" id="name" name="name"maxlength="32" placeholder="请输入手机号或登录名">
        </div>
        <div class="v3lbt">
            <label>密码</label><input type="password" id="psd" name="psd" maxlength="32" placeholder="">
        </div>
        <input type="hidden" name="op" value="login">
        <div class="autologin">
            <label><input type="checkbox" id="auto" name="auto" checked="" value="1">自动登录</label>
            <a href="/Member/CheckMember.aspx" target="_blank" class="gopass">找回密码</a>
        </div>
        <a href="javascript:void(0)" id="boxlogingo">登录</a>
        <div class="tiplogin"><a href="javascript:void(0)" data-u="/Member/register.aspx" >免费注册</a> 开启您精彩的跑步人生！</div>
        </form>
    </div>
</div>
    <script src="/assets/js/jquery.min.js"></script>
    <script src="/assets/js/amazeui.min.js"></script>
    <script type="text/javascript" src="/Html/js/action.js"></script>
    <script src="/Html/js/echo.min.js"></script>
    <script src="/Html/js/marathon.js" charset="UTF-8"></script>
</body>
</html>