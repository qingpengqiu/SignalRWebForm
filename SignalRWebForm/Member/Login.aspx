<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="_Member_Login" %><!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <title>��¼-ERUN360.COM</title>
    <title>ע��-������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <script language="javascript" src="/Common/jQuery.js"></script>
    <script language="javascript" src="/Common/jCheck.js"></script>
    <script language="javascript" src="/Common/jCalendar.js"></script>
    <link href="/Common/login.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/loginmedia.css" />

</head>
<body>
    <div class="login_cen">
        <a class="lmediah" href="/">������ҳ</a>
        <img class="medialogo" src="/Html/images/medialogo.jpg">
        <a href="" class="fenxiang">���������ܹ� <font>38540km</font> ����·����
        </a>
        <a href="/" class="logo"></a>
        <div class="login_left" id="pageContent">
            <em>�û���¼</em>
            <form autocomplete="off" method="post" action="Login.aspx" name="form1" id="form1">
                <table width="100%" cellspacing="0" cellpadding="0" border="0" id="tableCreate">
                    <tbody>
                        <tr>
                            <td>
                                <input type="text" onblur="if(NullCheck(this)) LengthCheck(this,2,32);" value="" maxlength="32" size="24" name="cLoginName" id="cLoginName" placeholder="�û���">
                                <span class="check_echo" id="check_cLoginName"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <input type="password" onblur="if(NullCheck(this)) if(LengthCheck(this,6,32)) StringCheck(this);" value="" maxlength="32" size="24" name="cPassword" id="cPassword"  placeholder="�ܡ���">
                                <span class="check_echo" id="check_cPassword"></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto">
                                <input type="checkbox" value="1" checked="" name="auto" id="auto"><label class="autologin">�´��Զ���¼</label> <a href="/Member/Query.aspx">��������</a>
                                <div id="submit_command">
                                    <a class="loginbott" onmouseover="ShowSubmit();">��&nbsp;&nbsp;¼</a>
                                </div>
                                <div class="check_echo" id="total_echo">
                                    <% =PageResult %>
                                </div>
                                <div class="loginm"><a href="/Member/register.aspx">ע���ʺ�</a>   |   <a href="/Member/Query.aspx">��������</a></div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
            <em>��û�������ʺţ�</em>
            <div class="jryp">
                <a href="/Member/register.aspx">
                    <img src="/Images/login/jryp.png" alt="">
                </a>
            </div>
            <em>���Ǹոռ�������</em>
            <ul>
                <% =GetNewUser() %>
            </ul>
        </div>
        <div class="login_right">
            <span>���¿��</span>
            <ul class="sskd">
                <%=GetMatch() %>
            </ul>
            <span>����Լ��</span>
            <ul class="zxyp">
                <%=GetRunning() %>
            </ul>
            <span>��������</span>
            <p>
                <%=GetMileage() %>
            </p>
            <span>���²���</span>
            <ul class="zxbw">
                <%=GetNewBlog() %>
            </ul>
        </div>
    </div>
    <script type="text/javascript" language="javascript">

        document.onkeydown = function (event) {
            var e = event || window.event || arguments.callee.caller.arguments[0];
            if (e && e.keyCode == 13) {
                Finish();
            }
        };
        //document.form1.reset();
        $(function () {
            var ctrl = document.getElementById("cLoginName");
            ctrl.focus();
        });

        function ShowSubmit() {
            var obj = $("#cLoginName")[0];
            if (obj.value.length > 0) {
                obj = $("#cPassword")[0];
                if (obj.value.length > 0) {
                    $("#submit_command").html("<a class=\"loginbott\" onmouseover='Finish()'>��&nbsp;&nbsp;¼</a>");
                }
            }
        }

        function verifyAll() {
            var check_num = 2;
            var obj = $("#cLoginName")[0];
            if (NullCheck(obj)) if (StringCheck(obj)) if (LengthCheck(obj, 2, 32)) { check_num--; }
            obj = $("#cPassword")[0];
            if (NullCheck(obj)) if (LengthCheck(obj, 6, 32)) if (StringCheck(obj)) { check_num--; }

            return (check_num == 0) ? true : false;
        }

        function Finish() {
            if (verifyAll()) {
                document.form1.submit();
                return true;
            }
            else {
                $("#total_echo").html("���а����д���Ŷ��");
            }
            return false;
        }

    </script>
<script src="http://s14.cnzz.com/stat.php?id=4723271&web_id=4723271&show=pic" language="JavaScript"></script>
    <script type="text/javascript">
        jQuery(document).ready(function ($) {
            $("a[title='վ��ͳ��']").hide();
        });
    </script>
</body>
</html>
