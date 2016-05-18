<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register1.aspx.cs" Inherits="Member_Register1" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>恭喜您，注册成功！成为益跑网会员</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <link rel="icon" type="image/png" href="/assets/i/favicon.png">
    <meta name="mobile-web-app-capable" content="yes">
    <link rel="icon" sizes="192x192" href="/assets/i/app-icon72x72@2x.png">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-title" content="Amaze UI"/>
    <link rel="apple-touch-icon-precomposed" href="/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileImage" content="/assets/i/app-icon72x72@2x.png">
    <meta name="msapplication-TileColor" content="#0e90d2">
    <link rel="stylesheet" href="/assets/css/amazeui.min.css">
    <link rel="stylesheet" href="/assets/css/blueimp-gallery.min.css">
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" href="/Html/css/marathon.css">
    <link rel="stylesheet" type="text/css" href="/Html/css/infocenterv3.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/indexv3.css" />
    <link href="/Html/css/register.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/registmedia.css" />
</head>
<body class="registnbg">
<!--[if (gte IE 9)|!(IE)]><!-->
<script src="/assets/js/jquery.min.js"></script>
<script src="/assets/js/jquery.mobile.custom.min.js"></script>
<!--<![endif]-->
<!--[if lte IE 8 ]>
<script src="/assets/js/jquery.min.js"></script>
<script src="/assets/js/modernizr.js"></script>
<script src="/assets/js/amazeui.ie8polyfill.min.js"></script>
<![endif]-->
<script src="/assets/js/amazeui.min.js"></script>
<script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
<script type="text/javascript" src="/Common/jPopupfbk.js"></script>
<script type="text/javascript" src="/Html/js/action.js"></script>
    <script type="text/javascript" src="../Html/js/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script></head>
<body>
    <form id="form1" runat="server">
        <div class="rebox">
            <div class="retop">
                <a href="" class="rlogo">
                    <img src="/Html/images/tlogo.png" alt=""></a>
            </div>
            <div class="reok">
                <h1>恭喜您，注册成功！</h1>
                <h3><span>您已经获得200积分!</span> 下面填写个人信息、选择或者上传头像让大家更好的认识您；可以获得50积分！<a target="_blank" href="/blog/200016255.aspx">积分用途?</a></h3>
                <div class="refrome">
                        <div class="sex refrometr">
                            <div class="refrometd">
                                <label for="gendera">性别</label></div>
                            <div class="refrometd">
                                <em>
                                    <input runat="server" type="radio" checked tabindex="1" id="gendera" name="gender" />
                                    <label for="gendera">
                                        <img src="/Html/images/manico.png" alt="" /></label>
                                    <input runat="server" type="radio" tabindex="1" id="genderb" name="gender" />
                                    <label for="genderb">
                                        <img src="/Html/images/womicon.png" alt="" /></label>
                                </em>
                            </div>
                        </div>
                        <div class="uicon refrometr">
                            <div class="refrometd">
                                <label for="">头像</label></div>
                            <div class="refrometd">
                                <img src="/Html/images/uicon1.jpg" alt="" data-icon="/Html/images/uicon1.jpg" style="border: 3px solid rgb(155, 209, 22);opacity:1"/>
                                <img src="/Html/images/uicon2.jpg" alt="" data-icon="/Html/images/uicon2.jpg" />
                                <img src="/Html/images/uicon3.jpg" alt="" data-icon="/Html/images/uicon3.jpg" />
                                <img src="/Html/images/uicon4.jpg" alt="" data-icon="/Html/images/uicon4.jpg" />
                                <img src="/Html/images/uicon5.png" alt="" data-icon="/Html/images/uicon4.png" class="newicon" />
                                <asp:HiddenField ID="cAvatar" runat="server" />
                            </div>
                        </div>
                        <div class="refrometr">
                            <div class="refrometd">
                                <label for="">生日</label></div>
                            <div class="refrometd">
                                <input id="birthday" runat="server" readonly class="birthday" type="text"  onfocus="WdatePicker({startDate:'%y-%M-%d',dateFmt: 'yyyy-MM-dd',maxDate:'%y-%M-#{%d}'})" value="2008-08-08"/>
                                </div>
                        </div>
                        <div class="rebutton refrometr">
                            <div class="refrometd"></div>
                            <div class="refrometd">
                                <asp:Button ID="renext" runat="server" Text="下一步" CssClass="renext" OnClick="renext_Click" /><span class="gobakc">跳过，直接进入<a href="<%=UrlHelper.MemberUrl(CurrentUser.uId) %>">个人主页&gt;&gt;</a></span>
                            </div>
                        </div>
                </div>
            </div>
        </div>
    <div style="display: none">
        <div id="thumb">
            <p id="swfContainer">
                本组件需要安装Flash Player后才可使用，请从<a href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。
            </p>
        </div>
    </div>
        <script>
        jQuery(document).ready(function($) {
            $("#cAvatar").val("/Html/images/uicon1.jpg")
            store = $.AMUI.store;
            if (store.get('registurl')) {
                $(".gobakc").html('跳过，直接返回 <a href="'+store.get('registurl')+'">原页面&gt;&gt;</a>')
            };
        });
            $(".uicon img").click(function (event) {
                $(".uicon img").removeAttr('style')

                $(this).css({
                    border: '3px solid #9bd116',
                    opacity:'1'
                });
                $("#cAvatar").val($(this).data('icon'))
            });
            $(".newicon").colorbox({ inline: true, href: "#thumb", width: "641px", height: "504px", opacity: "0.4" });
            swfobject.addDomLoadEvent(function () {
            var swf = new fullAvatarEditor("swfContainer", {
                id: 'swf',
                avatar_sizes: '150*150|50*50|32*32',
                upload_url: '/action/Upload.ashx?u=h+|<%=idUser
%>',
                src_upload: 2
            }, function (msg) {
                switch (msg.code) {
                    //case 1: alert("页面成功加载了组件！"); break;
                    //case 2: alert("已成功加载默认指定的图片到编辑面板。"); break;
                    case 3:
                        if (msg.type == 0) {
                            alert("摄像头已准备就绪且用户已允许使用。");
                        }
                        else if (msg.type == 1) {
                            alert("摄像头已准备就绪但用户未允许使用！");
                        }
                        else {
                            alert("摄像头被占用！");
                        }
                        break;
                    case 5:
                        if (msg.type == 0) {
                            imgurl = "<%=HostInfo.imgName%>/Utility/Uploads" + msg.content.avatarUrls[0]
                            $("#upimg").attr('src', imgurl);
                            $.ajax({
                                url: '/action/GetPhotoList.ashx',
                                type: 'GET',
                                dataType: 'text',
                                data: { command: "upimg", img: imgurl },
                                success: function (data) {
                                    if (data == "1") {
                                        $(".newicon").attr('src', imgurl);
                                        $.colorbox.close();
                                        $("#cAvatar").val(imgurl)
                                    }
                                    if (data == "0") {
                                        tipsimg("失败", "", "false")
                                    } if (data == "-1") {
                                        tipsimg("未登录", "", "false")
                                    }
                                }
                            });
                        }
                        break;
                }
            }
            );
        });
        </script>
    </form>
<ERUN360:footerv3 runat="server" ID="footerv3" />