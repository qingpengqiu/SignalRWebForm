<%@ Page Language="C#" AutoEventWireup="true" CodeFile="appClub.aspx.cs" Inherits="infocenter_appClub" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <title>������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico">
    <link rel="stylesheet" type="text/css" href="../Html/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <script type="text/javascript" src="../Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Common/jWeibo.js"></script>
    <script src="http://tjs.sjs.sinajs.cn/open/api/js/wb.js" type="text/javascript" charset="utf-8"></script>
    <script  type="text/javascript" src="../Html/js/jquery.blockUI.js"></script>
    <style type="text/css">
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
    <script language="javascript" src="/Common/jCheck.js"></script>
        <script language="javascript" src="/Common/jPopup.js"></script>
        <script language="javascript" src="/Common/jCalendar.js"></script>
        <script language="javascript" src="/Common/jPopupfbk.js?2012111"></script>
        <script language="javascript" src="/Common/jquery.colorbox.js"></script>
        <script type="text/javascript" src="../Common/jCity.js"></script>   
</head>
<body>
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <form id="form1" runat="server">
        <div class="indecen">
            <div class="newclub">
                <table>
                    <tr>
                        <td>
                            <label for="">���ֲ���</label></td>
                        <td>
                            <input type="text" tabindex="1" id="name" name="name" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">����</label></td>
                        <td>
                            <select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)"></select>
                            <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)"></select>
                            <script type="text/javascript">
                                BindProvince("����");
                            </script>
                             <input type="text" id="idCity" name="idCity" size="5" readonly value="0"  runat="server"/>
                             <input type="text" id="cCityname" name="cCityname" size="15" readonly value=""  runat="server"/>
                            <input name="UpdatedFields" type="hidden" id="UpdatedFields" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">����</label></td>
                        <td>
                            <select id="Style" runat="server">
                                <option value="0">��ѡ��</option>
                                <option value="1">�ܲ�</option>
                                <option value="2">�ﳵ</option>
                                <option value="3">ԽҰ</option>
                                <option value="4">ͽ��</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">���ֲ����</label></td>
                        <td>
                            <textarea id="Idmsg" cols="20" rows="2" runat="server"></textarea>
                            <input type="text" id="b2" readonly="readonly" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <label for="">ģ����ʽ</label></td>
                        <td>
                            <ul class="temx">
                                <%=tempModel.ToString() %>                         
                                <asp:HiddenField ID="radiotemp" runat="server" Value="v1" />
                                
                            </ul>
                        </td>
                    </tr>
                </table>
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Images/botton.png" OnClick="ImageButton1_Click" />
            </div>
        </div>
        <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
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
      $(".hdjmap").click(function (event) {         
          cityname = $("#ddlProvince").val() + $("#ddlCity").val()
          if (cityname) {
              cityname = "����"
          }
      });


        $(".temx input[name=temp]").click(function(event) {
            $("#radiotemp").val($(this).val())
        });
            textAreaLimit("Idmsg", { lastMsgLabel: "b2" })
            function textAreaLimit(area, op) {
                var defaultOp = {
                    maxLength: 120 //��󳤶� 
                , IsNumber: false //ֻ�������� 
                , lastMsgLabel: null //��ʱ��ʾ�����������Input 
                , msg: "����������{0}������"
                , errorMsg: "���ָ��������������"
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
                        this.value = this.value.replace(/\D/g, "");//IE֮��� 
                    }
                    if (this.value.length > defaultOp.maxLength) {
                        //------------------------------------------------------------------------------- 
                        //������ 
                        this.disabled = "disabled";
                        this.value = this.value.slice(0, defaultOp.maxLength);
                        this.removeAttribute("disabled");
                        this.focus();
                        //������ 
                        //�� 
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
    </form>
</body>
</html>
