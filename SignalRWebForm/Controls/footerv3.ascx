<%@ Control Language="C#" AutoEventWireup="true" CodeFile="footerv3.ascx.cs" Inherits="Controls_footerv3" %>
<div class="footer">
    <a href="http://www.erun360.com/" title="">益跑首页</a> -  <a href="http://www.erun360.com/channels/about/" title="">关于益跑</a> -  <a href="http://www.erun360.com/channels/about/contact.aspx" title="">联系我们</a> -  <a href="/blog/200011619.aspx" title="">加入益跑</a> -  <a href="http://www.erun360.com/member/register.aspx" title="">会员中心</a><br>
    益跑网 京ICP证151068号 Copyright &copy;<i class="copyright" style="font-style: normal;"></i> 北京益跑科技股份有限公司 版权所有<br>
    地址：北京昌平区金域国际中心A座17层 电话：86-10-84374449
    <script src="http://s14.cnzz.com/stat.php?id=4723271&web_id=4723271&show=pic" language="JavaScript"></script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            var myDate = new Date();
            $("a[title='站长统计']").hide();
            $(".copyright").html('2012-' + myDate.getFullYear());
        });
    </script>
</div>
<!-- 提示框html -->
<div class="toast "></div>
<!-- 登陆框html全局 -->
<div class="loginboxbg"></div>
<div class="loginbox">
    <img src="/Html/images/wlogo.png" class="lblogo">
    <img src="/Html/images/logobig.png" class="lblogob">
    <div class="closelb"></div>
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
        <div class="tiplogin"><a href="javascript:void(0)" data-u="/Member/register.aspx">免费注册</a> 开启您精彩的跑步人生！</div>
        </form>
    </div>
</div>
<a href="#top" title="回到顶部" class="am-icon-btn am-icon-arrow-up" id="amz-go-top"></a>
<script src="/Html/js/echo.min.js"></script>
<script src="/Html/js/marathon.js" charset="UTF-8"></script>
</body>
</html>