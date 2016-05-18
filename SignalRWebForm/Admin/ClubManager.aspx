<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClubManager.aspx.cs" Inherits="Admin_ClubManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>管理入口-益跑网</title>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Admin.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script language="javascript" src="/Common/jCheck.js?2012111"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script language="javascript" src="/Common/jCalendar.js?2012111"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jPopup.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>

<body>
    <form id="form1" runat="server">
        <center>
<div style="width:100%;height:85px;padding-top:30px;background-color:#F8FFF8;">
	<div style="width:950px;height:85px;text-align:left;">
		<img src="/images/logo-u.gif" onclick="window.location='/';" style="margin-right:80px;">
		<img src="/images/top-user.jpg">
	</div>
</div>
<style>
    .cont {
        width: 930px;
        padding: 10px;
        text-align: left;
        font-family: 微软雅黑;
    }
    .conttop {
        padding: 10px;
        height: 32px;
        font-size: 14px;
        font-weight: bold;
        color: #333;
    }
    #tips {
        background: #fff;
        height: 100%;
        line-height: 110px;
        text-align: center;
        font-size: 14px;
    }
        #tips img {
            margin-right: 4px;
        }
    .gtable {
        width: 1700px;
        overflow: auto;
    }
    body .auditclub tr:first-child td{font-size: 16px;color: #637496}
    .auditclub{width: 970px;padding-left: 200px;}
    .auditclub table{width: 400px;text-align: center;}
    .auditclub table tr{height: 36px;line-height: 36px;}
    .auditclubs table{width: 800px}
    .auditclubs table tr td:first-child{width: 240px;text-align: right;padding-right: 10px;color: #000;font-weight: bold;}
    .auditclubs table tr{height: 42px;}
    .auditclubs select{margin-bottom: 0;}
    .auditclubs table tr td.shcz{text-align: center;padding-top: 30px;}
    #bohuibox{width: 100%;height: 100%;background: #fff}
    #bohuibox h2{color: #077fc6;font-weight: bold;font-size: 16px;margin: 0;padding-left: 18px;line-height: 56px;}
    #bohuibox textarea{ font-size: 14px;
    height: 140px;
    margin-left: 20px;
    padding: 2px;
    width: 426px;}
</style>
<div class="cont">
	<div class="conttop">
		<a href="/" >首页</a> >
		俱乐部审核
	</div>
	<div class="auditclub">
     <table>
         <tr>
             <td>俱乐部ID</td><td>申请时间</td><td>操作</td>
         </tr>
         <tr>
             <td>XXXXXXXXXXXX</td>
             <td>2013.4.23</td>
             <td><a href=""><img src="/Html/images/shck.png" alt=""></a></td>
         </tr>
         <tr>
             <td>XXXXXXXXXXXX</td>
             <td>2013.4.23</td>
             <td><a href=""><img src="/Html/images/shgb.png" alt=""></a></td>
         </tr>
         <tr>
             <td>XXXXXXXXXXXX</td>
             <td>2013.4.23</td>
             <td><a href=""><img src="/Html/images/shjh.png" alt=""></a></td>
         </tr>
     </table>   
    </div>
    <div class="auditclubs">
        <table>
            <tr>
                <td>用户id：</td>
                <td>100000691（用户名）</td>
            </tr>
            <tr>
                <td>城市：</td>
                <td>北京   朝阳区</td>
            </tr>
            <tr>
                <td>类型：</td>
                <td>跑步</td>
            </tr>
            <tr>
                <td>俱乐部简介：</td>
                <td>“作为工商界的成功人士，不仅仅是行动强者，更应该是思想巨人，或者是言论和传播者的强者，我们的感受和想法应该能够通过强有力的方式得到表达、得到传播，能够很好地影响这个社会更多的人，让他们受到我们曾经受到的那种温暖的阳光般的正向能量的温暖。”组委会主席曲向东说。</td>
            </tr>
            <tr>
                <td>模板样式：</td>
                <td><img src="/Html/images/v2s.jpg" alt=""></td>
            </tr>
            <tr>
                <td>设定人数限制：</td>
                <td>
                    <select onchange="selectOneCity(this)" id="ddlCity" name="ddlCity">
                        <option value="50">50</option>
                        <option value="30">30</option>
                        <option value="20">20</option>
                        <option value="10">10</option>
                        </select>
                </td>
            </tr>
            <tr>
                <td colspan=2 class="shcz"><img src="/Html/images/shtg.png" alt="">&nbsp;&nbsp;<img class="bohuibox" src="/Html/images/shbh.png" alt=""></td>
            </tr>
        </table>
    </div>

</div>
</center>
</form>
<div style="display:none">
    <div id="bohuibox" >
        <h2>驳回理由</h2>
        <textarea name=""></textarea>
    </div>  
</div>
<script>
    $(".bohuibox").colorbox({ inline: true,href:"#bohuibox", width: "484px", height: "306px", opacity: "0.4" });
</script>
</body>
</html>
