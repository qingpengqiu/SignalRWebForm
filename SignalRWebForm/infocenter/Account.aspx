<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Account.aspx.cs" Inherits="infocenter_Account" %>
<%@ Register Src="~/Controls/headerv3.ascx" TagPrefix="ERUN360" TagName="headerv3" %>
<%@ Register Src="~/Controls/footerv3.ascx" TagPrefix="ERUN360" TagName="footerv3" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<ERUN360:headerv3 runat="server" ID="headerv3" />
<link rel="stylesheet" href="/assets/css/amazeui.datetimepicker.css">
<script type="text/javascript" src="/assets/js/amazeui.datetimepicker.min.js"></script>
<script type="text/javascript" src="/Html/js/swfobject.js"></script>
<script type="text/javascript" src="/Html/js/fullAvatarEditor.js"></script>
<script type="text/javascript" src="../Common/jCity.js"></script>
<script src="../Common/jCheck.js"></script>
<article>
    <ERUN360:Erun_Left runat="server" ID="Erun_Left" />
        <div class="main-right account">
            <div class="equip">
                <span data-do="runcard">跑界名片</span>
                <span data-do="signinfo">报名信息</span>
                <span data-do="bodyinfo">身体数据</span>
                <span data-do="eidtthumb">修改头像</span>
                <span data-do="editpasswd">修改密码</span>
                <span data-do="bindphone">绑定手机</span>
                <span data-do="editcontacts">修改常用联系人</span>
            </div>
    <form method="post" id="form1" runat="server">
            <div class="blog runcard">
                <div class="table">
                    <div class="tr">
                        <div class="td">
                            <label for="run-year">哪年开始跑步</label>
                        </div>
                        <div class="td">
                            <select name="runyear" id="runyear" class="recorddata" runat="server">
                            </select>
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">
                            <label for="marathon-num">参加过多少场马拉松</label>
                        </div>
                        <div class="td">
                            <label><input type="text" name="name" id="marathonnum" value="0" runat="server" /> 场</label>
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">
                            <label for="country-num">参加过多少场越野跑</label>
                        </div>
                        <div class="td">
                            <label><input type="text" name="name" id="countrynum" value="0" runat="server" /> 场</label>
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">
                            <label for="marathon-best">马拉松最好成绩</label>
                        </div>
                        <div class="td">
                            <select id="marathonbest" runat="server">
                                <option value="1">全程马拉松</option>
                                <option value="2">半程马拉松</option>
                            </select>
                            <label for="results">成绩</label>
                            <input type="text" name="results" id="results" value="" runat="server"  placeholder="选择时间" readonly/>
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">
                            <label for="one-game">个人最满意的一场比赛</label>
                        </div>
                        <div class="td">
                            <input type="text" name="name" id="onegame" value="" runat="server" />
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">
                            <label for="record">赛事记录</label>
                        </div>
                        <div class="td" id="runidcard" runat="server">
                            <div class="table" id="add-records">
                                <div class="tr">
                                    <div class="td">年份</div>
                                    <div class="td">赛事名称</div>
                                    <div class="td">成绩</div>
                                </div>
                                <asp:Repeater ID="rptrunrecord" runat="server">
                                <ItemTemplate>
                                    <%#Eval("inner").ToString()%>
                                </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <a href="javascript:void(0)" class="add-records">+添加记录</a>
                        </div>
                    </div>
                </div>
                <asp:Button class="btn submit" ID="Button_Intro" runat="server" Text="" OnClick="Button_Intro_Click" />
            </div>
            <div class="blog signinfo">
                <div class="marathon-reg" action="#" method="post" id="form" runat="server">
                    <div class="table">
                        <div class="tr">
                            <div class="td">
                                <label for="name">姓名</label>
                            </div>
                            <div class="td">
                                <input type="text" name="name" id="name" value="" runat="server" />
                            </div>
                            <div class="td">
                                <label for="gender">性别</label>
                            </div>
                            <div class="td">
                                <label><input type="radio" name="gender" id="gendera" value="0" runat="server" /> 男</label>
                                <label><input type="radio" name="gender" id="genderb" value="1" runat="server" /> 女</label>
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="blood">血型</label>
                            </div>
                            <div class="td">
                                <label><input type="radio" name="blood" id="blooda" value="blood-a" runat="server" /> A</label>
                                <label><input type="radio" name="blood" id="bloodb" value="blood-b" runat="server" /> B</label>
                                <label><input type="radio" name="blood" id="bloodab" value="blood-ab" runat="server" /> AB</label>
                                <label><input type="radio" name="blood" id="bloodo" value="blood-o" runat="server" /> O</label>
                                <label><input type="radio" name="blood" id="bloodother" value="blood-other" runat="server" /> 其他</label>
                            </div>
                            <div class="td">
                                <label for="birthday">出生年月</label>
                            </div>
                            <div class="td">
                                <input type="text" runat="server" name="birthday" id="birday" value="" onclick="GDate(this);" />
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="education">学历</label>
                            </div>
                            <div class="td">
                                <select id="education" runat="server">
                                    <option value="其他">其他</option>
                                    <option value="大专">大专</option>
                                    <option value="本科">本科</option>
                                    <option value="研究生">研究生</option>
                                    <option value="博士">博士</option>
                                    <option value="硕士">硕士</option>
                                </select>
                            </div>
                            <div class="td">
                                <label for="occupation">职业</label>
                            </div>
                            <div class="td">
                                <asp:DropDownList ID="idOccupation" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="idtype">证件类型</label>
                            </div>
                            <div class="td">
                                <select id="idCard" class="card" runat="server">
                                    <option value="请选择">请选择</option>
                                    <option value="身份证">身份证</option>
                                    <option value="军官证">军官证</option>
                                    <option value="户口本">户口本</option>
                                    <option value="护照">护照</option>
                                    <option value="其它">其它</option>
                                </select>
                                <input type="text" id="prependedDropdown" class="span2" runat="server">
                            </div>
                            <div class="td">
                                <label for="mobile">手机</label>
                            </div>
                            <div class="td">
                                <input type="text" name="mobile" id="mobile" value="" runat="server" />
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="email">电子邮箱</label>
                            </div>
                            <div class="td">
                                <input type="text" name="email" id="email" value="" runat="server" />
                            </div>
                            <div class="td">
                                <label for="city">居住城市</label>
                            </div>
                            <div class="td">
                                <select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)" runat="server">
                                </select>
                                <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)" runat="server">
                                </select>
                                <script type="text/javascript">
                                    BindProvince("北京");
                                </script>
                                <input type="text" id="idCity" name="idCity" readonly value="0" runat="server">
                                <input type="text" id="cCityname" name="cCityname" readonly value="" runat="server">
                                <input type="hidden" runat="server" id="UpdatedFields" name="UpdatedFields" value="">
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="address">地址</label>
                            </div>
                            <div class="td">
                                <input type="text" name="address" id="address" value="" runat="server" />
                            </div>
                            <div class="td">
                                <label for="zipcode">邮编</label>
                            </div>
                            <div class="td">
                                <input type="text" name="zipcode" id="zipcode" value="" runat="server" />
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="emerger">紧急联系人</label>
                            </div>
                            <div class="td">
                                <input type="text" name="emerger" id="emerger" value="" runat="server" />
                            </div>
                            <div class="td">
                                <label for="emermobile">紧急联系电话</label>
                            </div>
                            <div class="td">
                                <input type="text" name="emermobile" id="emermobile" value="" runat="server" />
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="tjzm">上传体检证明或成绩证书</label>
                            </div>
                            <div class="td">
                                <asp:FileUpload ID="tjzm" runat="server" /><a id="tjzmt" runat="server" target="_blank">已上传&nbsp;<img src="/Html/images/img_icon.png"></a>
                            </div>
                            <div class="td"></div>
                            <div class="td"></div>
                        </div>
                    </div>
                    <asp:Button class="btn submitbc" ID="Button_Application" runat="server" Text="" OnClick="Button_Application_Click" />
                </div>
            </div>
            <div class="blog bodyinfo">
                <ul class="py-data">
                    <li>
                        <label for="height">身高：</label><input type="text" name="name" id="height" value="0" runat="server" /><label for="height">（厘米）</label></li>
                    <li>
                        <label for="weight">体重：</label><input type="text" name="name" id="weight" value="0" runat="server" /><label for="weight">（公斤）</label></li>
                    <li>
                        <label for="chest">胸围：</label><input type="text" name="name" id="chest" value="0" runat="server" /><label for="chest">（厘米）</label></li>
                    <li>
                        <label for="waistline">腰围：</label><input type="text" name="name" id="waistline" value="0" runat="server" /><label for="waistline">（厘米）</label></li>
                    <li>
                        <label for="hips">臀围：</label><input type="text" name="name" id="hips" value="0" runat="server" /><label for="hips">（厘米）</label></li>
                    <li>
                        <label for="feet-wide">脚宽：</label><input type="text" name="name" id="feetwide" value="0" runat="server" /><label for="feet-wide">（厘米）</label></li>
                    <li>
                        <label for="feet-long">脚长：</label><input type="text" name="name" id="feetlong" value="0" runat="server" /><label for="feet-long">（厘米）</label></li>
                </ul>
                <div class="control-group">
                    <div class="controls">
                        <asp:Button class="btn submit" ID="Button_Size" runat="server" Text="" OnClick="Button_Size_Click" />
                    </div>
                </div>
            </div>
            <div class="blog mf-image eidtthumb">
                <div id="altContent">
                    <img src="<%=imghead %>" id="upimg" class="upimg" />
                    <a href="javascript:void(0)" class="upimg">上传头像 </a>
                </div>

            </div>
            <div class="blog editpasswd">
                <div class="form-reg-info" action="#" method="post" id="form_reg_info" runat="server">
                    <table>
                        <tbody>
                             <tr>
                            <td>登录名</td>
                            <td><input type="text" name="cnickame" id="cnickame" value="" runat="server" readonly /></td>
                        </tr> 
                            <tr>
                                <td>原密码</td>
                                <td>
                                    <input type="password" name="orgpass" id="orgpass" value="" runat="server" />
                                </td>

                            </tr>

                            <tr>
                                <td>新密码</td>
                                <td>
                                    <input type="password" name="newpass" id="newpass" value="" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>重新输入新密码</td>
                                <td>
                                    <input type="password" name="newpassagain" id="newpassagain" value="" runat="server" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <div class="control-group">
                        <div class="controls">
                            <asp:Button class="btn submit" ID="Button_Reg" runat="server" Text="Button" OnClick="Button_Reg_Click" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="blog editcontacts contactlist">
                <div class="table lianxiren">
                    <div class="tr">
                        <div class="td">姓名</div><div class="td">性别</div><div class="td">手机</div><div class="td">证件类型</div><div class="td">证件号码</div><div class="td">操作</div>
                    </div>
                    <asp:Repeater ID="Cyuser" runat="server">
                    <ItemTemplate>
                        <div class="tr">
                            <div class="td">
                                <%# DataBinder.Eval(Container.DataItem, "cFullname")%>
                                </div>
                            <div class="td">
                                &nbsp;<%# DataBinder.Eval(Container.DataItem, "cGender")%>
                            </div>
                            <div class="td">
                                <%# DataBinder.Eval(Container.DataItem, "Phone")%>
                            </div>
                            <div class="td">
                                 <%# DataBinder.Eval(Container.DataItem, "IdType").ToString()%>
                                <%--<%# DataBinder.Eval(Container.DataItem, "IdType")%>--%>
                            </div>
                            <div class="td">
                                <%# DataBinder.Eval(Container.DataItem, "IdNo")%>
                            </div>
                            <div class="td">
                                <a href='javascript:void(0)' class="addcjs" data-id="<%# DataBinder.Eval(Container.DataItem, "id") %>">修改</a><a href="javascript:void(0)" class="delcjs" data-id="<%# DataBinder.Eval(Container.DataItem, "id") %>">删除</a>
                            </div>
                        </div>
                    </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div class="addcontact addcjs" data-id="0">+ 添加常用联系人</div>
            </div>
    </form>
            <div class="blog bindphone">
                <div class="bindmobile">
                <form id="baindmobile">
                <input type="hidden" value="" name="op">
                <input type="hidden" value="0" name="iscontinue" id="iscontinue">
                <input type="password" value="" name="loginpass" id="loginpass" class="ajaxve" data-op="verifyloginpass" data-get="0" placeholder="登录密码">
                <input type="text" placeholder="手机号" value="" name="mobile" id="bdmobile" class="ajaxve" data-op="verificationmobile" data-get="0"><br>
                <input type="text" name="txtCode" id="txtCode"  value=""  class="ajaxve" data-op="verificationcode" data-get="0" placeholder="图形验证码" /><img src="/Member/limg.aspx" id="vimg" class="vimg" onclick="change()"/><a onclick="change()" href="javascript:void(0)" class="rloadcode">换一张</a> <br>
                <input type="text" name="msgCode" id="msgCode"  value=""  class="ajaxve" data-op="msgcode" data-get="0" placeholder="短信验证码" disabled/><input id="btnSendCode" type="button" value="获取验证码" onClick="sendMessage()" class="bindgetmsgcode" /><br>
                <a id="ensure" href="javascript:void(0)" class="bindmobilebutton">确定</a> <a href="javascript:void(0)" class="backchangemobile" id="backchangemobile">放弃修改</a>
                </form>
                </div>
                <div class="changemobile">
                    已绑定手机号<i></i>
                    <a class="changemobilebutton" id="changemobilebutton" href="javascript:void(0)">更改号码</a>
                </div>
            </div>
        </div>
</article>
    <div style="display: none">
        <div id="tips">
        </div>
        <div id="bdmap">
            <div id="hdjmap">
            </div>
            <a href="javascript:void(0)" onclick="mapqd()" class="mapqd"></a>
        </div>
        <div id="thumb">
            <p id="swfContainer">
                本组件需要安装Flash Player后才可使用，请从<a href="http://www.adobe.com/go/getflashplayer">这里</a>下载安装。
            </p>
        </div>
    </div>
<div id="dpbg"></div>
<div class="dpbox contedit" id="dpbox">
    <form id="fromuser">
        <input type="hidden" name="id" id="id">
        <input type="hidden" name="op" value="SaveAddUp">
    <div class="dptitle">修改常用联系人 <i></i></div>
    <div class="conteditr">
        <div class="conteditd">中文名：</div>
        <div class="conteditd"><input type="text" class="cnfirstname puts" name="csurname" value="" placeholder="姓"><input type="text" class="cnlastname puts" name="cname" value="" placeholder="名"></div>
    </div>
    <div class="conteditr">
        <div class="conteditd">国籍：</div>
        <div class="conteditd"><input type="text" class="puts nationality" name="Nationality" value="" placeholder="中文/English"></div>
    </div>
    <div class="conteditr">
        <div class="conteditd">性别：</div>
        <div class="conteditd">
            <select class="gender" name="cGender" >
                <option value="男" selected="selected">男</option>
                <option value="女">女</option>
            </select>
        </div>
    </div>
    <div class="conteditr">
        <div class="conteditd">出生日期：</div>
        <div class="conteditd"><input type="text" readonly="" class="puts datatime birthday" name="dBirthday"></div>
    </div>
    <div class="conteditr">
        <div class="conteditd">联系电话：</div>
        <div class="conteditd"><input type="text" class="puts phoneid" name="Phone"></div>
    </div>
    <div class="conteditr">
        <div class="conteditd">Email：</div>
        <div class="conteditd"><input type="text" class="puts email" name="cMail"></div>
    </div>
    <div class="conteditr">
        <div class="conteditd">地址：</div>
        <div class="conteditd"><input type="text" class="address" name="cAddress"></div>
    </div>
    <div class="conteditr">
        <div class="conteditd">证件类型：</div>
        <div class="conteditd">
            <select class="catdtype" name="IdType" value="IN">
                <option value="IN" selected="selected">身份证</option>
                <option value="PP">护照</option>
                <option value="GA">港澳通行证</option>
                <option value="TW">台湾通行证</option>
                <option value="TB">台胞证</option>
                <option value="HX">回乡证</option>
                <option value="HY">国际海员证</option>
            </select>
            <input type="text" class="cardnum" name="IdNo" value="">
            <div class="qfd">有效期
            <input type="text" class="putss datatime validity" name="cValidity" readonly="" value="">签发地
            <input type="text" class="putss Issued" name="cIssued"></div>
        </div>
    </div>
    <div class="postfli saveporfile">保存联系人<div class="dderrorbox"></div></div>
</form>
</div>
<div class="dpbox contedit" id="delbox" style='width:400px;margin-left:-200px;  min-height: 200px;'>
    <form id="deluse">
        <input type="hidden" name="id" id="did">
        <input type="hidden" name="op" value="del">
        <div class="dptitle">确定删除此联系人? <i></i></div>
        <div class="postfli godel" style="margin: 51px auto">确定删除<div class="dderrorbox"></div></div>
    </form>
</div>
<div class="insertPace"></div>
<script type="text/javascript">
var loca = GetQueryString("tablep"),
    mobiletype = bindmobile
if ((loca != 'runcard') && (loca != 'signinfo') && (loca != 'bodyinfo') && (loca != 'eidtthumb') && (loca != 'editpasswd') && (loca != 'editcontacts') ) {
    loca = 'runcard'
};
//绑定手机
function showmobile(){
   if ($.AMUI.store.enabled && $.AMUI.store.get('userinfo')) {
        var mtype = $.AMUI.store.get('userinfo').memebertype
        if (mtype == 0 || mtype == 2) {
            $(".bindmobile").show()
            $(".changemobile").hide()
    mobiletype = 'bindmobile'
        }else{
    mobiletype = 'changemobile'

            $(".changemobile").show()
            $(".changemobile i").html($.AMUI.store.get('userinfo').mobile)
            $(".bindmobile").hide()
            $("#backchangemobile").show()
        }
    }; 
    $("input[name=op]").val(mobiletype)
}
showmobile()
$(".changemobilebutton").click(function(event) {
    $(".bindmobile").show()
    $(".changemobile").hide()
});
$("#backchangemobile").click(function(event) {
    $(".changemobile").show()
    $(".bindmobile").hide()
});
$(".ajaxve").blur(function(event) {
        var op = $(this).data("op"),
            code = $(this).val(),
            t = $(this)
        if (!code) {
            return false
        };

        if (op == "verificationcode" && $("#bdmobile").data('get') == 0) {
                $("#bdmobile").focus();
                $(".toast").html('请先填写正确的手机号').show().removeClass('toast-error').addClass('toast-error')
                errorboxhide()
                return false
            };
        if (op == 'msgcode') {
            var mobile = $("#bdmobile").val()
            $.get('/action/ChangeMobile.ashx?msgtype='+mobiletype+'&op=' + op + '&code=' + code + '&mobile=' + mobile, function (data) {
                if (data.status == 1) {
                    t.data('get', '1')
                }else{
                    $(".toast").html(data.msg).show().removeClass('toast-success').addClass('toast-error')
                    errorboxhide()
                }
            });
            return false
        };
        $.post('/action/ChangeMobile.ashx',{op: op,code:code}, function (data) {
        if (data.status == 1) {
            t.data('get', '1')
        }else{
            $(".toast").html(data.msg).show().removeClass('toast-success').addClass('toast-error')
                errorboxhide()
        }
    });
});
$(".bindphone input").change(function(event) {
    $(this).data('get', '0')
});
//获取短信验证码
var InterValObj;
var count = 60;
var curCount;
function sendMessage() {
    if ($("#bdmobile").data('get')==0 ) {

        $(".toast").html('请填写正确的手机号').show().removeClass('toast-success').addClass('toast-error')
        errorboxhide()
        return false
    }
    if ( $("#txtCode").data('get')==0  ) {

        $(".toast").html('请填写正确的验证码').show().removeClass('toast-success').addClass('toast-error')
        errorboxhide()
        return false
    }
    var tel = $("#bdmobile").val(),
        code = $("#txtCode").val()
    $.get('/action/ajaxsms.ashx?op=sendsms&type='+mobiletype+'&mobile=' + tel + '&code=' + code, function (data) {
        if (data.status == 1) {
            $("#msgCode").removeAttr("disabled").focus();
            curCount = count;
            $("#btnSendCode").val( + curCount + "秒再获取");
            InterValObj = window.setInterval(SetRemainTime, 1000);
            $(".toast").html(data.msg).show().removeClass('toast-error').addClass('toast-success')
            errorboxhide()
        }else{
            $(".toast").html(data.msg).show().removeClass('toast-success').addClass('toast-error')
            errorboxhide()
        }
    });
}
// 提交绑定手机
$("#ensure").click(function (event) {
    bindmobile()
});
function bindmobile(){
    var go = 1
    $("#baindmobile input").each(function(index, el) {
        if ($(this).data('get') == 0) {
            $(this).focus()
            go = 0
            if ($(this).data('op') == 'msgcode') {
                $(".toast").html('请先获取验证吗').show().addClass('toast-error')
                errorboxhide()
            };
            return false
        }
    }); 
    if (go == 1) {
        var postdata = $("#baindmobile").serialize()
        $.post('/action/ChangeMobile.ashx', postdata, function (data, textStatus, xhr) {
            if (data.status == 1) {
                $(".toast").html(data.msg).show().addClass('toast-success')
                var uinfo = $.AMUI.store.get('userinfo')
                    uinfo.memebertype = '3'
                    uinfo.mobile = $("#bdmobile").val()
                $.AMUI.store.set('userinfo', uinfo)
                $(".changemobile i").html($("#bdmobile").val())
                showmobile()
            }else if(data.status == -1){
                if(confirm(data.msg)){
                    $("#iscontinue").val('1')
                    bindmobile()
                }else{
                    $("#iscontinue").val('0')
                }
            }else {
                console.log(11)
                $(".toast").html(data.msg).show().addClass('toast-error')
            }
            errorboxhide()
        });
        
    };
}
//timer处理函数
function SetRemainTime() {
    if (curCount == 0) {                
        window.clearInterval(InterValObj);//停止计时器
        $("#btnSendCode").removeAttr("disabled");//启用按钮
        $("#btnSendCode").val("重新发送验证码");
        code = ""; //清除验证码。如果不清除，过时间后，输入收到的验证码依然有效    
    }
    else {
        curCount--;
        $("#btnSendCode").val( + curCount + "秒再获取");
    }
}
function change() {
    var imgNode = document.getElementById("vimg");
    imgNode.src = "/Member/limg.aspx?t=" + (new Date()).valueOf();
}


// 信息切换
$(".equip span").click(function () {
    loca = $(this).data('do')
    $(".equip span[data-do="+loca+"]").addClass('equip-ous').siblings('span').removeClass('equip-ous')
    $(".blog").hide()
    $('.'+loca).show()
})
$(".delcjs").click(function(event) {
    var id = $(this).data("id")
    $("#did").val(id)
    $("#dpbg").show()
    $("#delbox").show()
});
$(".godel").click(function(event) {
    $.ajax({
        url: '/action/Cycontact.ashx',
        type: 'get',
        dataType: 'json',
        data: encodeURI($("#deluse").serialize()),
        success:function(sdata){
          if (sdata.status==10) {
            window.location.reload()
          };
        }
      })
});
$(".saveporfile").click(function(event) {
    var go = 0;
  $("#fromuser").find('input').each(function(index, el) {
    if (!$(this).val() && !$(this).is(':hidden')) {
      go = 1
      $(this).addClass('errorinput').attr('placeholder', '不能为空').focus()
      $(".dderrorbox").html('资料请填写完整')
      return false
    }else{
      $(this).removeClass('errorinput').attr('placeholder', '');
    }
    if ($(this).attr('name') == 'phoneid') {
      if (!/^1\d{10}$/.test($(this).val())) {
        go = 1
        $(this).addClass('errorinput').focus()
        $(".dderrorbox").html('手机号不正确')
        return false
      };
    };
    if ($(this).attr('name') == 'email') {
      if (!/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/.test($(this).val())) {
        go = 1
        $(this).addClass('errorinput').focus()
        $(".dderrorbox").html('Email不正确')
        return false
      };
    };
  });
  if (go == 1) {
    return false
  };
  $(".dderrorbox").html('')
      $.ajax({
        url: '/action/Cycontact.ashx',
        type: 'get',
        dataType: 'json',
        data: encodeURI($("#fromuser").serialize()),
        success:function(sdata){
          if (sdata.status==7||sdata.status==8) {
            $(".dderrorbox").html(sdata.msg)
            window.location.reload()
          }else{
            $(".dderrorbox").html(sdata.msg)
          }

        }
      })
});
$(".catdtype").change(function(event) {
    if ($(this).val() == 'PP') {
        $(".qfd").css('display', 'inline-block');
    }else{
        $(".qfd").hide()
    }
});
function dpb(){
  $("#dpbg").show()
  $("#dpbox").show()
}
function dpc(){
  $("#dpbg").hide()
  $(".dpbox").hide()
}
$(".addcjs").click(function(event) {
    var id = $(this).data("id")
    $("#id").val(id)
        dpb()
    if(id==0){
        return false
    }
    $.ajax({
        url: '/action/Cycontact.ashx',
        type: 'get',
        dataType: 'json',
        data: {id: id,op:'upbind'},
        success:function(sdata){
            $(".cnfirstname").val(sdata[0].csurname)
            $(".cnlastname").val(sdata[0].cname)
            $(".nationality").val(sdata[0].Nationality)
            $(".birthday").val(sdata[0].dBirthday)
            $(".phoneid").val(sdata[0].Phone)
            $(".email").val(sdata[0].cMail)
            $(".catdtype").val(sdata[0].IdType)
            $(".address").val(sdata[0].cAddress)
            $(".cardnum").val(sdata[0].IdNo)
            $(".gender").val(sdata[0].cGender)
            $(".validity").val(sdata[0].cValidity)
            $(".Issued").val(sdata[0].cIssued)
            if(sdata[0].IdType == "pp"){
                $(".qfd").css('display', 'inline-block');
            }
        }
    })
});
$(".dptitle i").click(function(event) {
  dpc()
});
$('.datatime').datetimepicker({
  format:'yyyy-mm-dd',
      language:  'zh-CN',
      weekStart: 1,
      todayBtn:  1,
  autoclose: 1,
  todayHighlight: 1,
  startView: 2,
  minView: 2,
  forceParse: 0
});
jQuery(document).ready(function ($) {
$('.'+loca).show()
$(".equip span[data-do="+loca+"]").addClass('equip-ous').siblings('span').removeClass('equip-ous')
    $("#idCard").click(function () {
        if (jQuery("#idCard  option:selected").text() == "身份证") {
            $("#prependedDropdown").attr("datatype", "idcard")
        } else {
            $("#prependedDropdown").removeAttr("datatype");
        }
    })
    $(".group2").colorbox({ rel: 'group2', transition: "fade" });
    var focusalert = $(".focusalert-t").html();
    $(".focus").click(function () {
        $(this).append(focusalert);
    })
});
jQuery(document).ready(function ($) {
    var today_year = new Date().getFullYear();
    var num = '<%=racenum %>';
    for (var j = today_year; j >= 1900; j--) {
        if (j == <%=Year%>) {
            $('<option value="' + j + '" selected>' + j + '年</option>').appendTo(".recorddata");
        }else{$('<option value="' + j + '">' + j + '年</option>').appendTo(".recorddata");}
        
    }
    $(".add-records").click(function () {
        $("#add-records").append("<div class=\"tr\"><div class=\"td\"><input type=\"text\" class=\"input-mini\" name=\"record" + num + "\" id=\"record" + num + "\" value=\""+new Date().getFullYear()+"\"  ></div><div class=\"td\"><input type=\"text\" class=\"input-large\" name=\"Text1" + num + "\" id=\"Text1" + num + "\" value=\"\" tabindex=\"1\" /></div><div class=\"td\"><input type=\"text\" class=\"input-mini input-settime sstime\"  name=\"Text2" + num + "\" id=\"Text2" + num + "\" value=\"00:00:00\" tabindex=\"1\" /></div></div>");

        num++;
    });
});
$("#ddlCity").css("width", "110px");
$("#ddlProvince").css("width", "110px");
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
  if (bdmapkey == "0") {
      baidumap(cityname)
  }
});
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
$(".tshirt").colorbox({ rel: 'tshirt' });
function tipsimg(msg, url, imgname) {
    var img = "<img src=\"\/Html\/images\/" + imgname + "\.png\">"
    $("#tips").append(img).append(msg);


    $.colorbox({ inline: true, width: "50%", href: "#tips", width: "254px", height: "141px", opacity: "0.4" });
    var url = url;
    if (url == "") {
        setTimeout("window.location.reload()", 3000)

    } else {
        setTimeout("location.href = \"" + url + "\"", 3000)
    }

}
$(".tshirt").colorbox({ rel: 'tshirt' });
// 成绩插入 js
$(".upimg").colorbox({ inline: true, href: "#thumb", width: "641px", height: "504px", opacity: "0.4" });
swfobject.addDomLoadEvent(function () {
    var swf = new fullAvatarEditor("swfContainer", {
        id: 'swf',
        avatar_sizes: '150*150|50*50|32*32',
        upload_url: '/action/Upload.ashx?u=h+|<%=uId%>',
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
                                tipsimg("头像上传成功", "", "true")
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
    });
});
    </script>
<ERUN360:footerv3 runat="server" ID="footerv3" />