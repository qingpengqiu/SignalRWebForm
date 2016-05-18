<%@ Page Language="C#" AutoEventWireup="true" CodeFile="QueryResult.aspx.cs" Inherits="Channels_Competetion_QueryResult" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %><%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title><%=name %>-<%=RaceName %>-益跑网个人中心</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="/Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/user-more.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/Group.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/modernizr.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Html/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/Html/js/bootstrap-validation.min.js"></script>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js?appkey=" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="/Common/jCity.js"></script>
    <script src="/Common/jCheck.js"></script>
    <script src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.zclip.min.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <style>
        .main-left ul .user-dq {
            filter: alpha(Opacity=100);
            -moz-opacity: 1;
            opacity: 1;
        }
        .query{width: 980px;margin: 20px auto}
        .querytopimg{width: 100%;text-align: center;}
        .querytopimg img{max-width: 100%;}
        .query h1{font-size: 36px;color: #7e0000;text-align: center;padding: 21px 0;}
        .query h2{font-size: 36px;color: #333333;text-align: center;padding: 21px 0;letter-spacing:16px;}
        .querb{font-size: 18px;color: #666;overflow: hidden;text-align: center;padding-top: 26px;}
        .querb em{padding:0 16px;border-bottom: 1px solid #666;margin-right: 15px}
        .timelist{border: 1px solid #ddd;overflow: hidden;margin-top: 47px;background: #f4f4f4}
        .timelist li{float: left;width: 98px;background: #f1f7f0;height: 40px;line-height: 40px;font-size: 16px;color: #4fa500;text-align: center;border-right: 1px solid #ddd}
        .timelist li:nth-child(2n){width: 226px;background: #f4f4f4;color: #333}
        .timelist li:nth-child(6n){border: 0;}
        .lookzs{display: block;color: #5d7731;font-size: 14px;height: 36px;width: 100px;text-align: center;line-height: 36px;border-radius: 4px;margin: 88px auto;border: 1px solid #9cb95f;background: #aad163;box-shadow: #ccc 0px 3px 3px;text-shadow:#d3e7a7 1px 1px 1px;}
        .lookzs:hover{background: #b9d972;color: #5d7731}
    </style>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
</head>
<body>
    <form  id="rpfrom" runat="server">
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="wrap">
        <div class="query">
            <div class="querytopimg">
                <asp:Literal ID="ltlImg" runat="server"></asp:Literal><%--<img src="/Html/images/tztop.jpg">--%>
            </div>
             <h1>成绩查询结果</h1> 
            <%--<h1><asp:Literal ID="ltlTitle" runat="server"></asp:Literal>成绩查询结果</h1> --%>
            <h2><asp:Literal ID="ltlName" runat="server"></asp:Literal></h2>
            <div class="querb">
完赛时间：<em> <asp:Literal ID="ltlTime" runat="server"></asp:Literal></em>  组别：<em> <asp:Literal ID="ltlItem" runat="server"></asp:Literal>  </em>参赛号码：<em> <asp:Literal ID="ltlBib" runat="server"></asp:Literal> </em>本组名次：<em> <asp:Literal ID="ltlGroupRank" runat="server"></asp:Literal>  </em>总名次：<em> <asp:Literal ID="ltlRank" runat="server"></asp:Literal> </em>
            </div>
            <div class="timelist">
                <ul>
                    <asp:Literal ID="ltlResult" runat="server"></asp:Literal>
                    <%--<li>0KM</li><li>00:34:23</li><li>21KM</li><li>00:34:23</li><li>42.195KM</li><li>00:34:23</li>
                    <li>0KM</li><li>00:34:23</li><li>21KM</li><li>00:34:23</li><li>42.195KM</li><li>00:34:23</li>
                    <li>0KM</li><li>00:34:23</li><li>21KM</li><li>00:34:23</li><li>42.195KM</li><li>00:34:23</li>--%>
                </ul>
            </div>
            <a class="lookzs" href="javascript:void(0);">
                查看证书
            </a>
        </div>
    </div>
<script LANGUAGE="JavaScript">
    $(".lookzs").on('click', function(event) {
        var name = encodeURIComponent(GetQueryString("name")),
            opt = GetQueryString("opt"),
            idcard = GetQueryString("idcard")
        if(name && opt!=0 && idcard){
            //f_submit(980, 600, 'RacePrint.aspx?opt=' + opt + '&name=' + name + '&idcard=' + idcard + '#name
                 // f_submit('RacePrint.aspx?opt=' + opt + '&name=' + name + '&idcard=' + idcard)
                 window.open('RacePrint.aspx?opt=' + opt + '&name=' + name + '&idcard=' + idcard);
        }else{
            alert("请填写完整")
            window.location.href='RaceQuery.aspx'
        }
    });
    function f_submit(sWidth,sHeight,submitUrl){
        var sLeft =(screen.width-sWidth)/2;
        var sTop =(screen.height-sHeight)/2;
        window.open(submitUrl,"","height="+ sHeight +", width=" + sWidth+", top="+sTop+", left="+sLeft+", toolbar=no, menubar=no, scrollbars=yes, resizable=no, location=no,status=no");  
 }
    function f_submit(submitUrl) {        
        window.open(submitUrl, "", " toolbar=yes, menubar=yes, scrollbars=yes, resizable=yes, location=yes,status=yes");
    }
function GetQueryString(name) {
                    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
                    var r = window.location.search.substr(1).match(reg);
                    if (r != null) return unescape(r[2]); return null;
                    }
</script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
        </form>
</body>
</html>