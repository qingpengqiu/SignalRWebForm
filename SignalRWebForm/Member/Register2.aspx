<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register2.aspx.cs" Inherits="Member_Register2" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<!doctype html>
<html class="no-js">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="keywords" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
    <title>填写报名信息</title>
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
    <script type="text/javascript" src="/Common/jCity.js"></script>
    <script type="text/javascript" src="/Html/js/swfobject.js"></script>
    <script type="text/javascript" src="../Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="rebox reboxma">
            <div class="retop">
                <a href="/" class="rlogo"><img src="/Html/images/tlogo.png" alt=""></a>
            </div>
            <div class="refrome bmfrome">
                <h3>填写报名信息——填写完成后您就可以在益跑网报名参加比赛、活动且无需每次重复填写；<span>可以获得100积分！</span><a target="_blank" href="/blog/200016255.aspx">积分用途?</a></h3>
                <div class="refrometable">
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="">真实姓名</label></div>
                        <div class="refrometd">
                            <input type="text" runat="server" value="" maxlength="16" tabindex="1" id="name" name="name"/></div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="">学历</label></div>
                        <div class="refrometd">
                            <asp:DropDownList ID="ddlEducation" runat="server" TabIndex="5">
                        <asp:ListItem Value="0" Selected="True">其他</asp:ListItem>
                        <asp:ListItem Value="1">大专</asp:ListItem>
                        <asp:ListItem Value="2">本科</asp:ListItem>
                        <asp:ListItem Value="3">研究生</asp:ListItem>
                        <asp:ListItem Value="4">博士</asp:ListItem> 
                        <asp:ListItem Value="5">硕士</asp:ListItem>     
                    </asp:DropDownList></div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="">国籍</label></div>
                        <div class="refrometd">
                            <input type="text" name="idgj" id="idgj" value="中国" tabindex="7" runat="server"/>
                        </div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="">手机</label></div>
                        <div class="refrometd">
                            <input type="text" name="mobile" id="mobile" value="" tabindex="10" runat="server" maxlength="11"/>
                        </div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="">邮编</label></div>
                        <div class="refrometd">
                            <input type="text" name="zipcode" id="zipcode" value="" tabindex="13" runat="server" maxlength="6" />
                        </div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="">紧急联系人</label></div>
                        <div class="refrometd">
                        <input type="text" name="emerger" id="emerger" value="" tabindex="17" runat="server" maxlength="30"/>
                        </div>
                    </div>
                </div>
                <div class="refrometable">
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="">血型</label></div>
                        <div class="refrometd">
                            <em><asp:RadioButtonList ID="idBlood" runat="server" RepeatLayout="UnorderedList"  tabindex="3">
                                <asp:ListItem Value="0" Selected="True">A</asp:ListItem>
                                <asp:ListItem Value="1">B</asp:ListItem>
                                <asp:ListItem Value="3">AB</asp:ListItem>
                                <asp:ListItem Value="2">O</asp:ListItem>
                                <asp:ListItem Value="4">其他</asp:ListItem>
                            </asp:RadioButtonList></em></div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="">职业</label></div>
                        <div class="refrometd">
                            <asp:DropDownList ID="idOccupation" runat="server" TabIndex="6"></asp:DropDownList></div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="">证件类型</label></div>
                        <div class="refrometd">
                         <asp:DropDownList ID="ddlCard"  class="card" runat="server" TabIndex="8">
                        <asp:ListItem Value="1">身份证</asp:ListItem>
                        <asp:ListItem Value="2">军官证</asp:ListItem>
                        <asp:ListItem Value="3">户口本</asp:ListItem>
                        <asp:ListItem Value="4">护照</asp:ListItem> 
                        <asp:ListItem Value="5">其它</asp:ListItem>  
                    </asp:DropDownList>
                   <input type="text" tabindex="9" id="prependedDropdownButton" class="cardin" runat="server" maxlength="24"/></div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="">电子邮箱</label></div>
                        <div class="refrometd">
                         <input type="text" name="email" id="email" value="" tabindex="12"  runat="server" maxlength="64" />
                         </div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="">地址</label></div>
                        <div class="refrometd">
                           <select tabindex="14" name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)" runat="server">
                        </select>
                        <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)" runat="server" tabindex="15" >
                        </select>
                        <script type="text/javascript">
                            BindProvince("北京");
                        </script>
                        <input type="hidden" id="idCity" name="idCity" size="5" runat="server" style="width: 30px" />
                        <input type="text" id="cCityname" name="cCityname" size="15" value="" readonly runat="server" style="display:none" />
                        <input type="text" name="address" id="address" value="" tabindex="16" runat="server" maxlength="128" />
                        
                        </div>
                    </div>
                    <div class="refrometr">
                        <div class="refrometd">
                            <label for="">紧急电话</label></div>
                        <div class="refrometd">
                        <input type="text" name="emermobile" id="emermobile" value="" tabindex="18" runat="server" maxlength="30"/>
                        </div>
                    </div>
                </div>
                <div class="upimg">
                    <label class="tjzbott">上传体检证明或参赛证书 <i class="upxzimg">选择文件</i><input type="file" name="tjzmOrcszs" id="tjzmOrcszs" class="fileupload"><input type="hidden" id="fileurl" name="fileurl"  tabindex="19" runat="server" /></label>
                </div>
                <div class="bottom">
                    <div class="renext">下一步</div><asp:Button ID="renextm" runat="server" Text="下一步" OnClick="renext_Click" />
                    <span class="gobakc">跳过，直接进入<a href="<%=UrlHelper.MemberUrl(CurrentUser.uId) %>">个人主页&gt;&gt;</a></span>
                </div>
            </div>
        </div>
        <script>
        jQuery(document).ready(function($) {
            store = $.AMUI.store;
            if (store.get('registurl')) {
                $(".gobakc").html('跳过，直接返回 <a href="'+store.get('registurl')+'">原页面&gt;&gt;</a>')
            };
        });
        $(".reboxma input").blur(function(event) {
                if (!$(this).val()) {
                    $(this).addClass('errorinput')
                }else{
                    $(this).removeClass('errorinput')
                }
            });
        $(".renext").click(function(event) {
            var go = 1
            $(".reboxma input").each(function(index, el) {
                if (!$(this).val()) {
                    if ($(this).attr('id') == 'tjzmOrcszs') {
                        $(".toast").html('请上传体检证明或参赛证书').show().addClass('toast-error')
                    }else{
                        $(".toast").html('所有都填写完成才可以提交哦！').show().addClass('toast-error')
                    }
                        $(this).addClass('errorinput').focus();
                        errorboxhide()
                        go = 0
                        return false
                }else{
                    $(this).removeClass('errorinput')
                    go = 1
                }
            });
            if(go == 1){
                $("#renextm").click();
            }
        });
        $(".fileupload").change(function(){
             var data = new FormData(),
                sthis = $(this),
                filename = ''
             $.each(sthis[0].files, function(i, file) {
                 data.append('upload_file', file);
                 filename = file.name
             });
             $.ajax({
                 url: '/action/fileUp.ashx?id=300002198&filename='+filename,
                 type:'POST',
                 data:data,
                 cache: false,
                 contentType: false,
                 processData: false,
                 success:function(data){
                    var data = data[0]
                    if(data.status == 1){
                        sthis.next("input").val(data.url)
                        $(".toast").html(data.message).show().addClass('toast-success')
                            errorboxhide()

                    }else{
                        $(".toast").html(data.message).show().addClass('toast-error')
                            errorboxhide()
                    }
                 }
             });
        });
        </script>
    </form>
<ERUN360:footerv3 runat="server" ID="footerv3" />