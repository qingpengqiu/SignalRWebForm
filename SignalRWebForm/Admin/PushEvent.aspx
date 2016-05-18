<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PushEvent.aspx.cs" Inherits="Admin_PushEvent" %>

<!DOCTYPE html>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>管理入口-益跑网</title>
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
    <script type="text/javascript" src="../Html/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="/Html/select2/select2.min.js"></script>

    <script>
        $(document).ready(function () {
            $("#DDLRace").select2();
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

                .tnewuser {
                    float: right;
                    color: #f00;
                }
            </style>
        <div class="cont">
            <div class="conttop">
		<a href="/" >首页</a>  >
<a href="/Admin/RaceList.aspx">赛事首页</a>>
		赛事信息推送
	</div>
            <table style="width:100%">
		        <tr>
			        <td>选择赛事：<select id="DDLRace" runat="server" style="width: 200px;" onchange="ForOnChange()"></select>
                    </td>           
		        </tr>
                <tr>
                    <td>
                        标题修改为:<asp:TextBox ID="txtNewTitle" runat="server"></asp:TextBox></td>
                </tr>
                 <tr>
                    <td>
                        摘要：<asp:TextBox ID="txtBio" runat="server" TextMode="MultiLine"></asp:TextBox></td>
                </tr>
                 <tr>
                    <td>
                        发布于：<asp:DropDownList ID="ddlClass" runat="server" ></asp:DropDownList></td>
                </tr>
                 <tr>
                    <td>
                        类型: <asp:DropDownList ID="ddltype" runat="server"></asp:DropDownList>
                       </td> 
                </tr>
                 <tr>
                    <td>
                        焦点图： <input type="file" class="input-large fileupload"><input type="hidden" id="jdtp" name="hdtt" runat="server"/><label>图片大小1M以下，360*200px</label></td>
                </tr>
                 <tr>
                    <td>
                        推送时间：<input id="pushtime" runat="server" class="Wdate input-large" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm',minDate:'%y-%M-#{%d}'})" /></td>
                </tr>
                 <tr>
                     <td style="color: #EE0000;">
                        <% =BlogList %>
                    </td>
                </tr>
		<tr>
			<td>
               <asp:ImageButton ID="imgbtn" runat="server" ImageUrl="/Images/submit.gif" OnClick="imgbtn_Click" />
            </td>
		</tr>
	</table>
            </div>
             </center>
        <div class="toast "></div>
        <script type="text/javascript">
            function ForOnChange() {
                var Idrace = $("#DDLRace").val();
                window.location.href = "/Admin/PushEvent.aspx?id=" + Idrace
            }

            $(".fileupload").change(function () {
                var data = new FormData(),
                   sthis = $(this)
                $.each(sthis[0].files, function (i, file) {
                    data.append('upload_file', file);
                });
                $.ajax({
                    url: '/action/fileUp.ashx?name=Filedata',
                    type: 'POST',
                    data: data,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (data) {
                        var data = data[0]
                        if (data.status == 1) {
                            sthis.next("input").val(data.url)
                            tipbox(data.message, 'success')

                        } else {
                            tipbox(data.message, 'error')
                        }
                    }
                });
            });
            function ItemDelete(idx, pos) {
                if (confirm("确定要删除本行记录吗？") == true) {
                    $.get("pushdel.aspx", { id: idx }, function (result) {
                        if (result == "OK") {
                            $("#trData_" + pos)[0].style.display = "none";
                        }
                        else {
                            alert(result);
                        }
                    });
                }
            }

            function Itempush(idx, pos) {
                if (confirm("确定要再推吗？") == true) {
                    $.get("pushecho.aspx", { id: idx }, function (result) {
                        if (result == "OK") {
                            window.location.reload();
                        }
                        else {
                            alert(result);
                        }
                    });
                }
            }
            // 提示插件   tipbox('提示内容','success||error','停留时间默认2秒')
            var tipbox = function (tip, status, time) {
                var demo = '<div id="toastfun" class="toastfun toastfun-' + status + '">' + tip + '</div>'
                $("body").append(demo)
                setTimeout(function () {
                    $("#toastfun").remove()
                }, time ? time : 2000)
            }
        </script>
    </form>
</body>
</html>
