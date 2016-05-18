<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JsApiPayPage.aspx.cs" Inherits="weixinpay_JsApiPayPage" %>

<!DOCTYPE html>
<%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<%@ Register Src="~/Controls/Erun_Left.ascx" TagPrefix="ERUN360" TagName="Erun_Left" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %>
<!DOCTYPE html>
<html xmlns:wb="http://open.weibo.com/wb">
<head>
    <link rel="shortcut icon" href="/Html/images/erun.png" type="image/x-icon" />
    <title>΢��֧��</title>
    <%-- <meta http-equiv="content-type" content="text/html;charset=utf-8" />--%>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <link rel="stylesheet" type="text/css" href="/Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/base.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/colorbox.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/user-more.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/themes.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/Group.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/groupmedia.css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script src="/Html/js/jquery.blockUI.js"></script>
    <style>
        .main-left ul .user-dq {
            filter: alpha(Opacity=100);
            -moz-opacity: 1;
            opacity: 1;
        }
    </style>
    <!--[if lte IE 9]>
<link rel="stylesheet" type="text/css" href="js/IE9.js"/>
<![endif]-->
</head>
<script type="text/javascript">
    //����΢��JS api ֧��
    function jsApiCall()
    {
        WeixinJSBridge.invoke(
        'getBrandWCPayRequest',
        <%=wxJsApiParam%>,//josn��
                function (res)
                {              
                    //WeixinJSBridge.log(res.err_msg);
                    //alert(res.err_code + res.err_desc + res.err_msg);
                    if(res.err_msg == "get_brand_wcpay_request:ok" ) {                        
                        window.location.href="/weixinpay/payresult.aspx?idorder=<%=idorder%>";//֧���ɹ������תҳ��
                    }else
                    {
                        WeixinJSBridge.call('closeWindow');
                    }
                }
            );
            } 
            function callpay()
            {
                if (typeof WeixinJSBridge == "undefined")
                {
                    if (document.addEventListener)
                    {
                        document.addEventListener('WeixinJSBridgeReady', jsApiCall, false);
                    }
                    else if (document.attachEvent)
                    {
                        document.attachEvent('WeixinJSBridgeReady', jsApiCall);
                        document.attachEvent('onWeixinJSBridgeReady', jsApiCall);
                    }
                }
                else
                {
                    jsApiCall();
                }
            }
</script>
<body>

    <form id="form2" runat="server">
        <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
        <div class="wrap">
            <article>
                <div class="sbox">
                    <div class="sboxt" style="border-top: 0">
                        ȷ����Ʒ��֧��
                    </div>
                    <div class="spshow">
                        <asp:Literal ID="ltlImg" runat="server"></asp:Literal>
                        �����ţ�<asp:Literal ID="ltlidOrder" runat="server"></asp:Literal><br>
                        ��Ŀ���ƣ�
                        <asp:Literal ID="ltlTitle" runat="server"></asp:Literal><br>
                        ��Ʒ������
                        <asp:Literal ID="ltlNum" runat="server"></asp:Literal>
                        <br>
                        ��ɫ��<asp:Literal ID="ltlColor" runat="server"></asp:Literal>
                        <br>
                        ���ֵֿۣ�
                        <asp:Literal ID="ltlSocre" runat="server"></asp:Literal>
                        ���ֵֿ� <i>&yen;</i><asp:Literal ID="ltlMoney" runat="server"></asp:Literal>
                        <br>
                        ����Ҫ֧����<em><asp:Literal ID="ltlPrice" runat="server"></asp:Literal></em>Ԫ<em>(����2Сʱ֮����ɸ���)</em><br>
                    </div>
                </div>
                <div id="payb">
                  <a id="submit" class="topay" onclick="callpay()">����֧��</a>           
                   <%-- <asp:Button ID="submit" runat="server" Text="����֧��" OnClientClick="callpay()" CssClass="topay" />--%>
                </div>
            </article>
        </div>
        <asp:HiddenField ID="iswx" runat="server" Value="0" />
        <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
    </form>
</body>
</html>
