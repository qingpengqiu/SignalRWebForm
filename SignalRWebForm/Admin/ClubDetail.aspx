<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClubDetail.aspx.cs" Inherits="Admin_ClubDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
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

    body .auditclub tr:first-child td {
        font-size: 16px;
        color: #637496;
    }

    .auditclub {
        width: 970px;
        padding-left: 200px;
    }

        .auditclub table {
            width: 400px;
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

    #bohuibox {
        width: 100%;
        height: 100%;
        background: #fff;
    }

        #bohuibox h2 {
            color: #077fc6;
            font-weight: bold;
            font-size: 16px;
            margin: 0;
            padding-left: 18px;
            line-height: 56px;
        }

        #bohuibox textarea {
            font-size: 14px;
            height: 140px;
            margin-left: 20px;
            padding: 2px;
            width: 426px;
        }
</style>
<div class="cont">
	<div class="conttop">
		<a href="/" >首页</a> >
		俱乐部审核
	</div>
    <div class="auditclubs">
        <table>
            <tr>
                <td>俱乐部名称：</td>
                <td><%=mClub.cTitle %>（<%=mClub.id %>）</td>
            </tr>
            <tr>
                <td>用户名称：</td>
                <td><%=mClub.cUserName %>（<%=mClub.idUser %>）</td>
            </tr>
            <tr>
                <td>城市：</td>
                <td><%=mClub.cCityname %></td>
            </tr>
            <tr>
                <td>类型：</td>
               <td><%=mClub.cCityname %></td>
            </tr>
            <tr>
                <td>俱乐部简介：</td>
                <td><%=mClub.cDescription %></td>
            </tr>
            <tr>
                <td>模板样式：</td>
                <td><img src="/Html/images/<%=mClub.cBackground %>s.jpg" alt=""></td>
            </tr>
            <tr>
                <td>人数限制：</td>
               <td><%=mClub.iMemberLimit %>人</td>
              
            </tr>
            <tr>
                <td>俱乐部状态：</td>
               <td>
                    <%=mClub.iAudit.ToString() == "-1" ? "关闭" :mClub.iAudit.ToString() == "0" ? "未审核" : mClub.iAudit.ToString() == "1"?"审核未通过":mClub.iAudit.ToString() == "2" ? "禁用":mClub.iAudit.ToString() == "3" ? "已通过" :mClub.iAudit.ToString() == "4" ? "定制" : "正常"%>
               </td>
              
            </tr>
            <tr>
                <td colspan=2 class="shcz">
                    <asp:ImageButton ID="ibttg" ImageUrl="/Html/images/shtg.png" runat="server" OnClick="ibttg_Click" />
                    <asp:ImageButton ID="ibtbh" ImageUrl="/Html/images/shbh.png" runat="server" OnClick="ibtbh_Click" />                             <asp:ImageButton ID="ibtbtg" ImageUrl="/Html/images/gbclub.png" runat="server" OnClick="ibtbtg_Click" />
                    <asp:ImageButton ID="ibtgb" ImageUrl="/Html/images/shgb.png" runat="server" OnClick="ibtgb_Click" />
                </td>
            </tr>
        </table>
    </div>

</div>
</center>
    </form>
    <div style="display: none">
        <div id="bohuibox">
            <h2>驳回理由</h2>
            <textarea name=""></textarea>
        </div>
    </div>
    <script>
        $(".bohuibox").colorbox({ inline: true, href: "#bohuibox", width: "484px", height: "306px", opacity: "0.4" });
    </script>
</body>
</html>
