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
                <span data-do="runcard">�ܽ���Ƭ</span>
                <span data-do="signinfo">������Ϣ</span>
                <span data-do="bodyinfo">��������</span>
                <span data-do="eidtthumb">�޸�ͷ��</span>
                <span data-do="editpasswd">�޸�����</span>
                <span data-do="bindphone">���ֻ�</span>
                <span data-do="editcontacts">�޸ĳ�����ϵ��</span>
            </div>
    <form method="post" id="form1" runat="server">
            <div class="blog runcard">
                <div class="table">
                    <div class="tr">
                        <div class="td">
                            <label for="run-year">���꿪ʼ�ܲ�</label>
                        </div>
                        <div class="td">
                            <select name="runyear" id="runyear" class="recorddata" runat="server">
                            </select>
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">
                            <label for="marathon-num">�μӹ����ٳ�������</label>
                        </div>
                        <div class="td">
                            <label><input type="text" name="name" id="marathonnum" value="0" runat="server" /> ��</label>
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">
                            <label for="country-num">�μӹ����ٳ�ԽҰ��</label>
                        </div>
                        <div class="td">
                            <label><input type="text" name="name" id="countrynum" value="0" runat="server" /> ��</label>
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">
                            <label for="marathon-best">��������óɼ�</label>
                        </div>
                        <div class="td">
                            <select id="marathonbest" runat="server">
                                <option value="1">ȫ��������</option>
                                <option value="2">���������</option>
                            </select>
                            <label for="results">�ɼ�</label>
                            <input type="text" name="results" id="results" value="" runat="server"  placeholder="ѡ��ʱ��" readonly/>
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">
                            <label for="one-game">�����������һ������</label>
                        </div>
                        <div class="td">
                            <input type="text" name="name" id="onegame" value="" runat="server" />
                        </div>
                    </div>
                    <div class="tr">
                        <div class="td">
                            <label for="record">���¼�¼</label>
                        </div>
                        <div class="td" id="runidcard" runat="server">
                            <div class="table" id="add-records">
                                <div class="tr">
                                    <div class="td">���</div>
                                    <div class="td">��������</div>
                                    <div class="td">�ɼ�</div>
                                </div>
                                <asp:Repeater ID="rptrunrecord" runat="server">
                                <ItemTemplate>
                                    <%#Eval("inner").ToString()%>
                                </ItemTemplate>
                                </asp:Repeater>
                            </div>
                            <a href="javascript:void(0)" class="add-records">+��Ӽ�¼</a>
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
                                <label for="name">����</label>
                            </div>
                            <div class="td">
                                <input type="text" name="name" id="name" value="" runat="server" />
                            </div>
                            <div class="td">
                                <label for="gender">�Ա�</label>
                            </div>
                            <div class="td">
                                <label><input type="radio" name="gender" id="gendera" value="0" runat="server" /> ��</label>
                                <label><input type="radio" name="gender" id="genderb" value="1" runat="server" /> Ů</label>
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="blood">Ѫ��</label>
                            </div>
                            <div class="td">
                                <label><input type="radio" name="blood" id="blooda" value="blood-a" runat="server" /> A</label>
                                <label><input type="radio" name="blood" id="bloodb" value="blood-b" runat="server" /> B</label>
                                <label><input type="radio" name="blood" id="bloodab" value="blood-ab" runat="server" /> AB</label>
                                <label><input type="radio" name="blood" id="bloodo" value="blood-o" runat="server" /> O</label>
                                <label><input type="radio" name="blood" id="bloodother" value="blood-other" runat="server" /> ����</label>
                            </div>
                            <div class="td">
                                <label for="birthday">��������</label>
                            </div>
                            <div class="td">
                                <input type="text" runat="server" name="birthday" id="birday" value="" onclick="GDate(this);" />
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="education">ѧ��</label>
                            </div>
                            <div class="td">
                                <select id="education" runat="server">
                                    <option value="����">����</option>
                                    <option value="��ר">��ר</option>
                                    <option value="����">����</option>
                                    <option value="�о���">�о���</option>
                                    <option value="��ʿ">��ʿ</option>
                                    <option value="˶ʿ">˶ʿ</option>
                                </select>
                            </div>
                            <div class="td">
                                <label for="occupation">ְҵ</label>
                            </div>
                            <div class="td">
                                <asp:DropDownList ID="idOccupation" runat="server"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="idtype">֤������</label>
                            </div>
                            <div class="td">
                                <select id="idCard" class="card" runat="server">
                                    <option value="��ѡ��">��ѡ��</option>
                                    <option value="���֤">���֤</option>
                                    <option value="����֤">����֤</option>
                                    <option value="���ڱ�">���ڱ�</option>
                                    <option value="����">����</option>
                                    <option value="����">����</option>
                                </select>
                                <input type="text" id="prependedDropdown" class="span2" runat="server">
                            </div>
                            <div class="td">
                                <label for="mobile">�ֻ�</label>
                            </div>
                            <div class="td">
                                <input type="text" name="mobile" id="mobile" value="" runat="server" />
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="email">��������</label>
                            </div>
                            <div class="td">
                                <input type="text" name="email" id="email" value="" runat="server" />
                            </div>
                            <div class="td">
                                <label for="city">��ס����</label>
                            </div>
                            <div class="td">
                                <select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)" runat="server">
                                </select>
                                <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)" runat="server">
                                </select>
                                <script type="text/javascript">
                                    BindProvince("����");
                                </script>
                                <input type="text" id="idCity" name="idCity" readonly value="0" runat="server">
                                <input type="text" id="cCityname" name="cCityname" readonly value="" runat="server">
                                <input type="hidden" runat="server" id="UpdatedFields" name="UpdatedFields" value="">
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="address">��ַ</label>
                            </div>
                            <div class="td">
                                <input type="text" name="address" id="address" value="" runat="server" />
                            </div>
                            <div class="td">
                                <label for="zipcode">�ʱ�</label>
                            </div>
                            <div class="td">
                                <input type="text" name="zipcode" id="zipcode" value="" runat="server" />
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="emerger">������ϵ��</label>
                            </div>
                            <div class="td">
                                <input type="text" name="emerger" id="emerger" value="" runat="server" />
                            </div>
                            <div class="td">
                                <label for="emermobile">������ϵ�绰</label>
                            </div>
                            <div class="td">
                                <input type="text" name="emermobile" id="emermobile" value="" runat="server" />
                            </div>
                        </div>
                        <div class="tr">
                            <div class="td">
                                <label for="tjzm">�ϴ����֤����ɼ�֤��</label>
                            </div>
                            <div class="td">
                                <asp:FileUpload ID="tjzm" runat="server" /><a id="tjzmt" runat="server" target="_blank">���ϴ�&nbsp;<img src="/Html/images/img_icon.png"></a>
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
                        <label for="height">��ߣ�</label><input type="text" name="name" id="height" value="0" runat="server" /><label for="height">�����ף�</label></li>
                    <li>
                        <label for="weight">���أ�</label><input type="text" name="name" id="weight" value="0" runat="server" /><label for="weight">�����</label></li>
                    <li>
                        <label for="chest">��Χ��</label><input type="text" name="name" id="chest" value="0" runat="server" /><label for="chest">�����ף�</label></li>
                    <li>
                        <label for="waistline">��Χ��</label><input type="text" name="name" id="waistline" value="0" runat="server" /><label for="waistline">�����ף�</label></li>
                    <li>
                        <label for="hips">��Χ��</label><input type="text" name="name" id="hips" value="0" runat="server" /><label for="hips">�����ף�</label></li>
                    <li>
                        <label for="feet-wide">�ſ�</label><input type="text" name="name" id="feetwide" value="0" runat="server" /><label for="feet-wide">�����ף�</label></li>
                    <li>
                        <label for="feet-long">�ų���</label><input type="text" name="name" id="feetlong" value="0" runat="server" /><label for="feet-long">�����ף�</label></li>
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
                    <a href="javascript:void(0)" class="upimg">�ϴ�ͷ�� </a>
                </div>

            </div>
            <div class="blog editpasswd">
                <div class="form-reg-info" action="#" method="post" id="form_reg_info" runat="server">
                    <table>
                        <tbody>
                             <tr>
                            <td>��¼��</td>
                            <td><input type="text" name="cnickame" id="cnickame" value="" runat="server" readonly /></td>
                        </tr> 
                            <tr>
                                <td>ԭ����</td>
                                <td>
                                    <input type="password" name="orgpass" id="orgpass" value="" runat="server" />
                                </td>

                            </tr>

                            <tr>
                                <td>������</td>
                                <td>
                                    <input type="password" name="newpass" id="newpass" value="" runat="server" />
                                </td>
                            </tr>
                            <tr>
                                <td>��������������</td>
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
                        <div class="td">����</div><div class="td">�Ա�</div><div class="td">�ֻ�</div><div class="td">֤������</div><div class="td">֤������</div><div class="td">����</div>
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
                                <a href='javascript:void(0)' class="addcjs" data-id="<%# DataBinder.Eval(Container.DataItem, "id") %>">�޸�</a><a href="javascript:void(0)" class="delcjs" data-id="<%# DataBinder.Eval(Container.DataItem, "id") %>">ɾ��</a>
                            </div>
                        </div>
                    </ItemTemplate>
                    </asp:Repeater>
                </div>

                <div class="addcontact addcjs" data-id="0">+ ��ӳ�����ϵ��</div>
            </div>
    </form>
            <div class="blog bindphone">
                <div class="bindmobile">
                <form id="baindmobile">
                <input type="hidden" value="" name="op">
                <input type="hidden" value="0" name="iscontinue" id="iscontinue">
                <input type="password" value="" name="loginpass" id="loginpass" class="ajaxve" data-op="verifyloginpass" data-get="0" placeholder="��¼����">
                <input type="text" placeholder="�ֻ���" value="" name="mobile" id="bdmobile" class="ajaxve" data-op="verificationmobile" data-get="0"><br>
                <input type="text" name="txtCode" id="txtCode"  value=""  class="ajaxve" data-op="verificationcode" data-get="0" placeholder="ͼ����֤��" /><img src="/Member/limg.aspx" id="vimg" class="vimg" onclick="change()"/><a onclick="change()" href="javascript:void(0)" class="rloadcode">��һ��</a> <br>
                <input type="text" name="msgCode" id="msgCode"  value=""  class="ajaxve" data-op="msgcode" data-get="0" placeholder="������֤��" disabled/><input id="btnSendCode" type="button" value="��ȡ��֤��" onClick="sendMessage()" class="bindgetmsgcode" /><br>
                <a id="ensure" href="javascript:void(0)" class="bindmobilebutton">ȷ��</a> <a href="javascript:void(0)" class="backchangemobile" id="backchangemobile">�����޸�</a>
                </form>
                </div>
                <div class="changemobile">
                    �Ѱ��ֻ���<i></i>
                    <a class="changemobilebutton" id="changemobilebutton" href="javascript:void(0)">���ĺ���</a>
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
                �������Ҫ��װFlash Player��ſ�ʹ�ã����<a href="http://www.adobe.com/go/getflashplayer">����</a>���ذ�װ��
            </p>
        </div>
    </div>
<div id="dpbg"></div>
<div class="dpbox contedit" id="dpbox">
    <form id="fromuser">
        <input type="hidden" name="id" id="id">
        <input type="hidden" name="op" value="SaveAddUp">
    <div class="dptitle">�޸ĳ�����ϵ�� <i></i></div>
    <div class="conteditr">
        <div class="conteditd">��������</div>
        <div class="conteditd"><input type="text" class="cnfirstname puts" name="csurname" value="" placeholder="��"><input type="text" class="cnlastname puts" name="cname" value="" placeholder="��"></div>
    </div>
    <div class="conteditr">
        <div class="conteditd">������</div>
        <div class="conteditd"><input type="text" class="puts nationality" name="Nationality" value="" placeholder="����/English"></div>
    </div>
    <div class="conteditr">
        <div class="conteditd">�Ա�</div>
        <div class="conteditd">
            <select class="gender" name="cGender" >
                <option value="��" selected="selected">��</option>
                <option value="Ů">Ů</option>
            </select>
        </div>
    </div>
    <div class="conteditr">
        <div class="conteditd">�������ڣ�</div>
        <div class="conteditd"><input type="text" readonly="" class="puts datatime birthday" name="dBirthday"></div>
    </div>
    <div class="conteditr">
        <div class="conteditd">��ϵ�绰��</div>
        <div class="conteditd"><input type="text" class="puts phoneid" name="Phone"></div>
    </div>
    <div class="conteditr">
        <div class="conteditd">Email��</div>
        <div class="conteditd"><input type="text" class="puts email" name="cMail"></div>
    </div>
    <div class="conteditr">
        <div class="conteditd">��ַ��</div>
        <div class="conteditd"><input type="text" class="address" name="cAddress"></div>
    </div>
    <div class="conteditr">
        <div class="conteditd">֤�����ͣ�</div>
        <div class="conteditd">
            <select class="catdtype" name="IdType" value="IN">
                <option value="IN" selected="selected">���֤</option>
                <option value="PP">����</option>
                <option value="GA">�۰�ͨ��֤</option>
                <option value="TW">̨��ͨ��֤</option>
                <option value="TB">̨��֤</option>
                <option value="HX">����֤</option>
                <option value="HY">���ʺ�Ա֤</option>
            </select>
            <input type="text" class="cardnum" name="IdNo" value="">
            <div class="qfd">��Ч��
            <input type="text" class="putss datatime validity" name="cValidity" readonly="" value="">ǩ����
            <input type="text" class="putss Issued" name="cIssued"></div>
        </div>
    </div>
    <div class="postfli saveporfile">������ϵ��<div class="dderrorbox"></div></div>
</form>
</div>
<div class="dpbox contedit" id="delbox" style='width:400px;margin-left:-200px;  min-height: 200px;'>
    <form id="deluse">
        <input type="hidden" name="id" id="did">
        <input type="hidden" name="op" value="del">
        <div class="dptitle">ȷ��ɾ������ϵ��? <i></i></div>
        <div class="postfli godel" style="margin: 51px auto">ȷ��ɾ��<div class="dderrorbox"></div></div>
    </form>
</div>
<div class="insertPace"></div>
<script type="text/javascript">
var loca = GetQueryString("tablep"),
    mobiletype = bindmobile
if ((loca != 'runcard') && (loca != 'signinfo') && (loca != 'bodyinfo') && (loca != 'eidtthumb') && (loca != 'editpasswd') && (loca != 'editcontacts') ) {
    loca = 'runcard'
};
//���ֻ�
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
                $(".toast").html('������д��ȷ���ֻ���').show().removeClass('toast-error').addClass('toast-error')
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
//��ȡ������֤��
var InterValObj;
var count = 60;
var curCount;
function sendMessage() {
    if ($("#bdmobile").data('get')==0 ) {

        $(".toast").html('����д��ȷ���ֻ���').show().removeClass('toast-success').addClass('toast-error')
        errorboxhide()
        return false
    }
    if ( $("#txtCode").data('get')==0  ) {

        $(".toast").html('����д��ȷ����֤��').show().removeClass('toast-success').addClass('toast-error')
        errorboxhide()
        return false
    }
    var tel = $("#bdmobile").val(),
        code = $("#txtCode").val()
    $.get('/action/ajaxsms.ashx?op=sendsms&type='+mobiletype+'&mobile=' + tel + '&code=' + code, function (data) {
        if (data.status == 1) {
            $("#msgCode").removeAttr("disabled").focus();
            curCount = count;
            $("#btnSendCode").val( + curCount + "���ٻ�ȡ");
            InterValObj = window.setInterval(SetRemainTime, 1000);
            $(".toast").html(data.msg).show().removeClass('toast-error').addClass('toast-success')
            errorboxhide()
        }else{
            $(".toast").html(data.msg).show().removeClass('toast-success').addClass('toast-error')
            errorboxhide()
        }
    });
}
// �ύ���ֻ�
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
                $(".toast").html('���Ȼ�ȡ��֤��').show().addClass('toast-error')
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
//timer������
function SetRemainTime() {
    if (curCount == 0) {                
        window.clearInterval(InterValObj);//ֹͣ��ʱ��
        $("#btnSendCode").removeAttr("disabled");//���ð�ť
        $("#btnSendCode").val("���·�����֤��");
        code = ""; //�����֤�롣������������ʱ��������յ�����֤����Ȼ��Ч    
    }
    else {
        curCount--;
        $("#btnSendCode").val( + curCount + "���ٻ�ȡ");
    }
}
function change() {
    var imgNode = document.getElementById("vimg");
    imgNode.src = "/Member/limg.aspx?t=" + (new Date()).valueOf();
}


// ��Ϣ�л�
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
      $(this).addClass('errorinput').attr('placeholder', '����Ϊ��').focus()
      $(".dderrorbox").html('��������д����')
      return false
    }else{
      $(this).removeClass('errorinput').attr('placeholder', '');
    }
    if ($(this).attr('name') == 'phoneid') {
      if (!/^1\d{10}$/.test($(this).val())) {
        go = 1
        $(this).addClass('errorinput').focus()
        $(".dderrorbox").html('�ֻ��Ų���ȷ')
        return false
      };
    };
    if ($(this).attr('name') == 'email') {
      if (!/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/.test($(this).val())) {
        go = 1
        $(this).addClass('errorinput').focus()
        $(".dderrorbox").html('Email����ȷ')
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
        if (jQuery("#idCard  option:selected").text() == "���֤") {
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
            $('<option value="' + j + '" selected>' + j + '��</option>').appendTo(".recorddata");
        }else{$('<option value="' + j + '">' + j + '��</option>').appendTo(".recorddata");}
        
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
      cityname = "����"
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
// �ɼ����� js
$(".upimg").colorbox({ inline: true, href: "#thumb", width: "641px", height: "504px", opacity: "0.4" });
swfobject.addDomLoadEvent(function () {
    var swf = new fullAvatarEditor("swfContainer", {
        id: 'swf',
        avatar_sizes: '150*150|50*50|32*32',
        upload_url: '/action/Upload.ashx?u=h+|<%=uId%>',
        src_upload: 2
    }, function (msg) {
        switch (msg.code) {
            //case 1: alert("ҳ��ɹ������������"); break;
            //case 2: alert("�ѳɹ�����Ĭ��ָ����ͼƬ���༭��塣"); break;
            case 3:
                if (msg.type == 0) {
                    alert("����ͷ��׼���������û�������ʹ�á�");
                }
                else if (msg.type == 1) {
                    alert("����ͷ��׼���������û�δ����ʹ�ã�");
                }
                else {
                    alert("����ͷ��ռ�ã�");
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
                                tipsimg("ͷ���ϴ��ɹ�", "", "true")
                            }
                            if (data == "0") {
                                tipsimg("ʧ��", "", "false")
                            } if (data == "-1") {
                                tipsimg("δ��¼", "", "false")
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