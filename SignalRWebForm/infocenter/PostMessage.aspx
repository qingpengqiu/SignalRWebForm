<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PostMessage.aspx.cs" Inherits="infocenter_PostMessage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>益跑网个人中心</title>
    <link rel="stylesheet" type="text/css" href="../Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="../Html/css/base.css" />
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="../Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="../Html/js/Validform_v5.3.2_min.js"></script>
    <style>
        html {
            overflow: hidden;
        }

        form {
            margin: 0;
            padding: 17px 16px 2px 20px;
            position: relative;
        }

        h2 {
            display: block;
            font-size: 12px;
            font-weight: 100;
            height: 30px;
            line-height: 30px;
            margin: 0;
            padding-left: 20px;
            background: #f2f2f2;
        }

        th {
            font-weight: 100;
            color: #444444;
            line-height: 24px;
            padding-right: 5px;
            vertical-align: top;
        }

        p {
            position: absolute;
            right: 0px;
            top: 25px;
        }

        td {
            padding-bottom: 6px;
        }

        input {
            height: 24px;
            line-height: 24px;
            padding: 0 3px;
            vertical-align: 5px;
            width: 137px;
            border: 1px solid #E8E8E8;
            color: #000;
        }

        textarea {
            border: 1px solid #E8E8E8;
            width: 335px;
            height: 48px;
            line-height: 18px;
        }

        #btpost {
            background: #F6F6F6;
            float: right;
            font-size: 12px;
            height: 22px;
            padding: 0 0 1px;
            width: 46px;
            color: #535353;
            border: 1px solid #cccccc;
        }

            #btpost:hover {
                cursor: pointer;
                background: #ffae2e;
                color: #fff;
                border: 1px solid #ff9b00;
            }

        #b2 {
            border: 0px;
        }

        .icon {
            width: 27px;
            height: 27px;
            position: relative;
            background: url("/images/emotion/i_f_1.gif") no-repeat scroll 0 0 transparent;
            float: left;
            margin: -3px 0 0 48px;
        }

        .discuss-icon {
            position: absolute;
            width: 256px;
            height: 96px;
            top: -104px;
            left: 0;
            background: #fff;
            border: 1px solid #CCCCCC;
            padding: 4px;
            display: none;
        }

        .icon img {
            width: 22px;
        }

        .icon:hover {
            cursor: pointer;
        }

            .icon:hover .discuss-icon {
                display: block;
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
            .tishi{color: red}
    </style>
</head>
<body>
    <h2>发留言</h2>
    <form id="form1" runat="server">
        <table class="form_private">
            <tbody>
                <tr>
                    <th>发&nbsp;&nbsp;给：</th>
                    <td>
                        <input id="nick" runat="server" type="text" value="请输入对方昵称" onblur="if(this.value==''){this.value='请输入对方昵称';this.style.color='#a9a9a9'}" onfocus="if(this.value=='请输入对方昵称'){this.value='';this.style.color='#000000'}" class="text" maxlength="64" />
                    </td>
                </tr>
                <tr>
                    <th>内&nbsp;&nbsp;容：</th>
                    <td node-type="uploadTd">
                        <textarea id="Idmsg" runat="server" maxlength="1024"></textarea>
                        <p class="num">
                            <input type="text" id="b2" readonly="readonly" />
                            <%--  还可以输入<span>300</span>字--%>
                        </p>
                    </td>
                </tr>
            </tbody>
        </table>
        <div class="icon">
            <div class="discuss-icon">
                <img onclick="EmotionAdd('微笑')" src="/images/emotion/i_f_1.gif">
                <img onclick="EmotionAdd('大笑')" src="/images/emotion/i_f_2.gif">
                <img onclick="EmotionAdd('调皮')" src="/images/emotion/i_f_3.gif">
                <img onclick="EmotionAdd('惊讶')" src="/images/emotion/i_f_4.gif">
                <img onclick="EmotionAdd('耍酷')" src="/images/emotion/i_f_5.gif">
                <img onclick="EmotionAdd('发火')" src="/images/emotion/i_f_6.gif">
                <img onclick="EmotionAdd('害羞')" src="/images/emotion/i_f_7.gif">
                <img onclick="EmotionAdd('汗水')" src="/images/emotion/i_f_8.gif">
                <img onclick="EmotionAdd('大哭')" src="/images/emotion/i_f_9.gif">
                <img onclick="EmotionAdd('得意')" src="/images/emotion/i_f_10.gif">
                <img onclick="EmotionAdd('鄙视')" src="/images/emotion/i_f_11.gif">
                <img onclick="EmotionAdd('困')" src="/images/emotion/i_f_12.gif">
                <img onclick="EmotionAdd('夸奖')" src="/images/emotion/i_f_13.gif">
                <img onclick="EmotionAdd('晕倒')" src="/images/emotion/i_f_14.gif">
                <img onclick="EmotionAdd('疑问')" src="/images/emotion/i_f_15.gif">
                <img onclick="EmotionAdd('媒婆')" src="/images/emotion/i_f_16.gif">
                <img onclick="EmotionAdd('狂吐')" src="/images/emotion/i_f_17.gif">
                <img onclick="EmotionAdd('青蛙')" src="/images/emotion/i_f_18.gif">
                <img onclick="EmotionAdd('发愁')" src="/images/emotion/i_f_19.gif">
                <img onclick="EmotionAdd('亲吻')" src="/images/emotion/i_f_20.gif">
                <img onclick="EmotionAdd('爱心')" src="/images/emotion/i_f_22.gif">
                <img onclick="EmotionAdd('心碎')" src="/images/emotion/i_f_23.gif">
                <img onclick="EmotionAdd('玫瑰')" src="/images/emotion/i_f_24.gif">
                <img onclick="EmotionAdd('礼物')" src="/images/emotion/i_f_25.gif">
                <img onclick="EmotionAdd('哭')" src="/images/emotion/i_f_26.gif">
                <img onclick="EmotionAdd('坏笑')" src="/images/emotion/i_f_27.gif">
                <img onclick="EmotionAdd('呲牙')" src="/images/emotion/i_f_30.gif">
                <img onclick="EmotionAdd('暴汗')" src="/images/emotion/i_f_31.gif">
                <img onclick="EmotionAdd('楚楚可怜')" src="/images/emotion/i_f_32.gif">
                <img onclick="EmotionAdd('睡了')" src="/images/emotion/i_f_33.gif">
                <img onclick="EmotionAdd('泪')" src="/images/emotion/i_f_34.gif">
                <img onclick="EmotionAdd('生气')" src="/images/emotion/i_f_35.gif">
                <img onclick="EmotionAdd('吃惊')" src="/images/emotion/i_f_36.gif">
                <img onclick="EmotionAdd('灯泡')" src="/images/emotion/i_f_42.gif">
                <img onclick="EmotionAdd('咖啡')" src="/images/emotion/i_f_43.gif">
                <img onclick="EmotionAdd('蛋糕')" src="/images/emotion/i_f_44.gif">
                <img onclick="EmotionAdd('音乐')" src="/images/emotion/i_f_45.gif">
                <img onclick="EmotionAdd('爱')" src="/images/emotion/i_f_46.gif">
                <img onclick="EmotionAdd('胜利')" src="/images/emotion/i_f_47.gif">
                <img onclick="EmotionAdd('赞')" src="/images/emotion/i_f_48.gif">
            </div>
        </div>
        <asp:Button ID="btpost" runat="server" Text="发送" OnClick="btpost_Click" />
        <div style="display: none">
            <div id="tips">
            </div>
        </div>
        <script type="text/javascript">
            $("#btpost").click(function(){
                var postmsg = $("#Idmsg").val().replace(/(^\s+)|(\s+$)/g, "");
               if(postmsg == ""){
                $("body").append("<a class=\"tishi\">请输入内容</a>")
                return false;
                }else{
                    $(".tishi").empty();
                }
                
            })
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

            function EmotionAdd(v) {
                document.getElementById("Idmsg").value += "[" + v + "]";
                $(".discuss-icon").hide()
            }
            jQuery(document).ready(function ($) {
                $(".icon").hover(function () {
                    $(".discuss-icon").show()
                }, function () { })
            });
            //msg 提示信息，url 为空不跳转，否则调转到其他页面，imgname 为true 对号，为false叹号
            function tips(msg, url, imgname) {
                var img = "<img src=\"\/Html\/images\/" + imgname + "\.png\">"
                $("#tips").append(img).append(msg);


                $.colorbox({ inline: true, width: "50%", href: "#tips", width: "254px", height: "141px", opacity: "0.4" });
                var url = url;
                if (url == "") {
                    setTimeout("$.colorbox.close();", 5000)

                } else {
                    setTimeout("location.href = \"" + url + "\"", 3000)
                }

            }
        </script>
    </form>
</body>
</html>
