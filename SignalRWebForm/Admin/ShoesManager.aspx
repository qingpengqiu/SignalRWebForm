<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ShoesManager.aspx.cs" Inherits="Admin_ShoesManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>管理入口-益跑网-跑鞋关联信息管理后台</title>
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Admin.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
     <link href="/Html/select2/select2.css" rel="stylesheet" />
    <script language="javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script language="javascript" src="/Common/jCheck.js?2012111"></script>
    <script language="javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script language="javascript" src="/Common/jCalendar.js?2012111"></script>
    <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script language="javascript" src="/Common/jPopup.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/select2/select2.min.js"></script>
    <script language="javascript" src="/Common/jPopupht.js"></script>
    <script>
        $(document).ready(function () {
            $("#DDLShoes").select2();
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <center>           
        <div style="width: 100%; height: 85px; padding-top: 30px; background-color: #F8FFF8;">
            <div style="width: 950px; height: 85px; text-align: left;">
                <img src="/images/logo-u.gif" onclick="window.location='/';" style="margin-right: 80px;">
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
                /* width: 100%;
                padding-left: 200px;*/
            }

                .auditclub table {
                    width: 100%;
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
                .tnewuser{float: right;color: #f00}
        </style>
        <div class="cont">
            <div class="conttop">
		        <a href="/" >首页</a>  >
                <a href="/Admin/">管理</a>>跑鞋管理后台
            <table style="width:100%">
		        <tr>
			        <td>选择鞋：<select id="DDLShoes" runat="server" style="width: 200px;" ></select>
                    </td>           
		        </tr>
                <tr>
                    <td><a href="javascript:void(0)" onclick="LinkBlog()">关联博文</a></td>
                </tr>
                <tr>
                    <td><a href="javascript:void(0)" onclick="LinkGroupBuy()">关联拼团</a></td>
                </tr>
	        </table>
        </div>
        </center>
    </form>
</body>
<script>
    function LinkBlog() {
        var shoesid = $("#DDLShoes").val();
        if (shoesid=="") {
            alert("请先选择鞋");
            return;
        }
        PopupShow(700, 350, "发布博客到相关栏目", "ShoesLinkEdit.aspx?linktype=1&shoeid=" + shoesid);
    }
    function LinkGroupBuy() {
        var shoesid = $("#DDLShoes").val();
        if (shoesid == "") {
            alert("请先选择鞋");
            return;
        }
        PopupShow(700, 350, "发布博客到相关栏目", "ShoesLinkEdit.aspx?linktype=2&shoeid=" + shoesid);
    }
</script>
</html>
