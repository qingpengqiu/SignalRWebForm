<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ClubEdit.aspx.cs" Inherits="Admin_ClubEdit" %>

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
    <script type="text/javascript" src="../Common/jCity.js"></script>  
    <style type="text/css">
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
        .newclub{width: 100%;overflow: hidden;margin-top: 70px;font-family: \5FAE\8F6F\96C5\9ED1}
    	.newclub tr td{font-size: 14px;color: #000;}
        .newclub tr td:first-child{width: 260px;text-align: right;}
        .newclub label{margin-bottom: 7px;padding-right: 10px;display: inline-block;}
        .newclub select{width:120px; }
        .newclub textarea{padding: 14px;width: 420px;height: 120px;}
        #idCity,#cCityname{display: none;}
        #b2 { border: 0px; background: none;box-shadow:none;font-size: 12px;margin: -10px 0 0 320px}
        #b2:focus{box-shadow: none;}
        .newclub li{float: left;width: 154px;text-align: center;height: 152px}
        .newclub ul{width: 464px;display: inline-block;padding-top: 20px;}
        .newclub ul label{margin: 0}
        #ImageButton1{margin: 40px auto;display: block;}
    </style>
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

<div class="cont">
	<div class="conttop">
		<a href="/" >首页</a> >
		俱乐部编辑
	</div>
   <div class="indecen">
            <div class="newclub">
                <table>
                    <tr>
                        <td>
                            <label for="">俱乐部名</label></td>
                        <td>
                            <input type="text" tabindex="1" id="name" name="name" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">城市</label></td>
                        <td>
                            <select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)"></select>
                            <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)"></select>
                            <script type="text/javascript">
                                BindProvince("北京");
                            </script>
                             <input type="text" id="idCity" name="idCity" size="5" readonly value="0"  runat="server"/>
                             <input type="text" id="cCityname" name="cCityname" size="15" readonly value=""  runat="server"/>
                            <input name="UpdatedFields" type="hidden" id="UpdatedFields" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">类型</label></td>
                        <td>
                            <select id="Style" runat="server">
                                <option value="0">请选择</option>
                                <option value="1">跑步</option>
                                <option value="2">骑车</option>
                                <option value="3">越野</option>
                                <option value="4">徒步</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">俱乐部简介</label></td>
                        <td>
                            <textarea id="Idmsg" cols="20" rows="2" runat="server"></textarea>
                            <input type="text" id="b2" readonly="readonly" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">模板样式</label></td>
                        <td>
                            <ul class="temx">
                                <%=tempModel.ToString() %>                         
                                <asp:HiddenField ID="radiotemp" runat="server" Value="v1" />
                            </ul>
                        </td>
                    </tr>
                     <tr>
                        <td>
                            <label for="">设定人数限制</label></td>
                        <td>
                             <select id="idNum" runat="server">
                                <option value="50">50</option>
                                <option value="100">100</option>
                                <option value="200">200</option>
                                <option value="300">300</option>
                                <option value="500">500</option>
                            </select>
                        </td>
                    </tr>
                </table>
                 <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/botton.png" OnClick="ImageButton1_Click" />
            </div>
        </div>
        
        <script type="text/javascript">
            var iCity = parseInt(<% =iCity %>) - 1
            _province = china[iCity][0];
            $("#ddlProvince").val(china[iCity])
            for (x in china[iCity]) {
                if (x != 0) {
                    if (x == [<% =iArea  %>]) {
                        $("#ddlCity").append('<option selected=\"selected\" value=' + china[iCity][x] + '>' + china[iCity][x] + '</option>')
                    } else {
                        $("#ddlCity").append('<option value=' + china[iCity][x] + '>' + china[iCity][x] + '</option>')
                    }
                }
            }
            var bdmapkey = "0",
                newzbkey = "0"
            $(".hdjmap").click(function (event) {
                $.colorbox({ inline: true, href: "#bdmap", width: "800px", height: "460px", opacity: "0.4" });
                cityname = $("#ddlProvince").val() + $("#ddlCity").val()
                if (cityname) {
                    cityname = "北京"
                }
            });

            $(".temx input[name=temp]").click(function (event) {
                $("#radiotemp").val($(this).val())
            });
            textAreaLimit("Idmsg", { lastMsgLabel: "b2" })
            function textAreaLimit(area, op) {
                var defaultOp = {
                    maxLength: 120 //最大长度 
                , IsNumber: false //只能是数字 
                , lastMsgLabel: null //即时显示可输入个数的Input 
                , msg: "还可以输入{0}个文字"
                , errorMsg: "文字个数超出最大限制"
                };
                var label;
                if (typeof area == "string") {
                    area = document.getElementById(area);
                }
                if (!area) {
                    return;
                }
                for (var i in op) {
                    defaultOp[i] = op[i];
                }
                if (defaultOp.lastMsgLabel) {
                    if (typeof defaultOp.lastMsgLabel == "string") {
                        label = document.getElementById(defaultOp.lastMsgLabel);
                    }
                }
                if (defaultOp.IsNumber) {
                    area.style.imeMode = "Disabled";//IE 
                    area.onkeydown = function () {
                        return event.keyCode != 229;
                    }
                }
                area.onkeyup = function () {
                    if (defaultOp.IsNumber) {
                        this.value = this.value.replace(/\D/g, "");//IE之外的 
                    }
                    if (this.value.length > defaultOp.maxLength) {
                        //------------------------------------------------------------------------------- 
                        //方案① 
                        this.disabled = "disabled";
                        this.value = this.value.slice(0, defaultOp.maxLength);
                        this.removeAttribute("disabled");
                        this.focus();
                        //方案② 
                        //或 
                        //alert(defaultOp.errorMsg); 
                        //this.value = this.value.slice(0,defaultOp.maxLength); 
                        //------------------------------------------------------------------------------- 
                    }
                    if (label) {
                        label.value = defaultOp.msg.replace(/\{0\}/, defaultOp.maxLength - this.value.length);
                    }
                }
            }
        </script>
</div>
</center>
    </form>
   
</body>
</html>
