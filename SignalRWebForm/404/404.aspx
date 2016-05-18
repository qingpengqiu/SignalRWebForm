<%@ Page Language="C#" AutoEventWireup="true" CodeFile="404.aspx.cs" Inherits="_404_404" %>

<!DOCTYPE html>
<!--[if lt IE 7]> <html class="no-js ie6 oldie" lang="en"> <![endif]-->
<!--[if IE 7]>    <html class="no-js ie7 oldie" lang="en"> <![endif]-->
<!--[if IE 8]>    <html class="no-js ie8 oldie" lang="en"> <![endif]-->
<!--[if gt IE 8]> <html class="no-js" lang="zh_CN"> <!--<![endif]-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8"/>
    <title>404错误提示页 - 益跑网</title>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <meta name="viewport" content="width=device-width,initial-scale=1"/>
    <!-- CSS: implied media=all -->
    <link rel="stylesheet" href="css/404style.css"/>
    <link rel="stylesheet" href="css/404blue.css"/>
    <script src="js/jquery-404.js"></script>
    <script src="js/404script.js"></script>
</head>
<body> 
    <div id="error-container">
        <div id="error">
            <div id="pacman"></div>
        </div>
        <div id="container">
            <div id="title">
                <h1>对不起, 你访问的页面不存在!</h1>
            </div>
            <div id="content">
                <div class="left">
                    <p class="no-top">&nbsp;&nbsp;&nbsp;可能是如下原因引起了这个错误:</p>
                    <ul>
                        <li>&nbsp;&nbsp;&nbsp;博文被删除</li>
                        <li>&nbsp;&nbsp;&nbsp;URL输入错误</li>
                        <li>&nbsp;&nbsp;&nbsp;链接已失效</li>
                        <li>&nbsp;&nbsp;&nbsp;其他原因...</li>
                    </ul>
                    <div class="clearfix"></div>
                </div>
                <div id="ShowDiv"></div>
                <div class="clearfix"></div>
            </div>
            <div id="footer">
                益跑网 京ICP备12042185号 Copyright &copy;2012北京益跑信息技术有限公司 版权所有
    <script src="http://s14.cnzz.com/stat.php?id=4723271&web_id=4723271&show=pic" language="JavaScript"></script>
                <script type="text/javascript">
                    jQuery(document).ready(function ($) {
                        $("a[title='站长统计']").hide();
                    });
                </script>
            </div>
        </div>
    </div>
    <script type='text/javascript'>
        var secs = 5; //倒计时的秒数
        var URL;
        function Load(url) {
            URL = url;
            for (var i = secs; i >= 0; i--) {
                window.setTimeout('doUpdate(' + i + ')', (secs - i) * 1000);
            }
        }
        function doUpdate(num) {
            document.getElementById('ShowDiv').innerHTML = '将在' + num + '秒后跳转到<a href="/"><%=Info%></a>';
            if (num == 0) { window.location = URL; }
        }
    </script>
    <script type="text/javascript">

        Load( "<%=url404 %>");
    </script>
</body>

</html>
