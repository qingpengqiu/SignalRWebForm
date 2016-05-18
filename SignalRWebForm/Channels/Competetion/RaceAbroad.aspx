<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceAbroad.aspx.cs" Inherits="Channels_Competetion_RaceAbroad" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>������-�й����ȵ��ܲ��Ż���վ-ERUN360.COM</title>
    <meta name="description" content="�й���һ��רҵ�ܲ��Ż���վ��������������רҵ���ܲ����ݺͲ�Ʒ�������ܲ������ߡ����ֲ������̺�������֯�ߵ�ȫ��λרҵ���񣬴���ҵ��һ����ȫ�ܲ���̬��ƽ̨�����ܲ��������������Ľ�����������Ϊ��ᳱ����ʱ�С�" />
    <meta name="keywords" content="�ܲ�,ѵ��,����,�ܲ���վ,�ܲ���,ԽҰ,�ܲ���,�ܲ�ѵ��,�������,Ů���ܲ�,Ů���ܲ�,Ӫ��,����,����,����,�ܲ�����,��������,�ܲ�����,�ܲ�����,5KM,10KM,���������,ȫ��������,ԽҰ��,�ܲ�����,ר��ѵ��,��������,Ů��װ��,ѵ������,�ܲ�����,��Ь,�ܲ�Ь,��������,�ܲ���װ,�ܲ����,�����ܲ�,�˲��ָ�,�������,��ʳ,����,��������,��������,���ڸ���,��������,�ܲ�Ӣ��,�ܲ����,Ϊʲô��,��ο�ʼ,��һ�α���,�������� ,�ﾶ����,�ﾶ����,��·��,����,����,����,����,�̿�,����,�����,�п�,���,����,����,Ь��,ѹ��,�ָ�,���Ӳ�Ʒ,����,����,����,����,����,����,ñ��,ͷ��,��ˮϵͳ,����,����,��������,Ь��,�˶���,�ܲ��۾�,GPS,����,�ܲ��ֱ�,������,��Ƭ,��Ʒ,��Һ,������" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/race.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCity.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Html/js/My97DatePicker/WdatePicker.js"></script>
    <link rel="stylesheet" type="text/css" href="/Html/css/media.css?time=214" />
</head>
<body>
    <form id="form1" runat="server">
        <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
        <div class="indecen ">
            <div class="racebody">
                <h1><asp:Literal ID="ltlTitle" runat="server"></asp:Literal></h1>
                <div class="mprojectfrom">
                    <div class="total">
                        <p><asp:Literal ID="ltlDetail" runat="server"></asp:Literal><br>
                            <asp:Literal ID="ltlTotal" runat="server"></asp:Literal>��<asp:Literal ID="ltlfPrice" runat="server"></asp:Literal>Ԫ
                        </p>
                        <em><asp:Literal ID="ltlSelect" runat="server"></asp:Literal></em>
                    </div>
                    <div class="bmtable">
                        <div class="bmtr">
                            <div class="bmtd">
                                <span><label for="name"><asp:Literal ID="ltllastname" runat="server"></asp:Literal></label></span>
                                    <em><input type="text"  runat="server" maxlength="30" tabindex="1" id="surname" name="surname" datatype="pinyin" errormsg="����д����(ƴ��)" nullmsg="����д����(ƴ��)" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                            <div class="bmtd tdlabel">
                                <span><label for="name"><asp:Literal ID="ltlfamilyname" runat="server"></asp:Literal></label></span>
                                    <em><input type="text"   runat="server" maxlength="30" tabindex="2" id="cname" name="name" datatype="pinyin" errormsg="����д����(ƴ��)" nullmsg="����д����(ƴ��)" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr">
                            <div class="bmtd">
                                <span><label for="gendera"><asp:Literal ID="ltlGender" runat="server"></asp:Literal></label>
                                    </span>
                                        <asp:RadioButtonList ID="idgender" runat="server" RepeatLayout="UnorderedList" TabIndex="3">
                                            <asp:ListItem Value="0" Selected="True">��</asp:ListItem>
                                            <asp:ListItem Value="1">Ů</asp:ListItem>
                                        </asp:RadioButtonList>
                                        <div class="Validform_checktip"></div>
                            </div>
                            <div class="bmtd tdlabel">
                                <span><label for="blood"><asp:Literal ID="ltlBlood" runat="server"></asp:Literal></label>
                                    </span>
                                    <em>
                                        <asp:DropDownList ID="idBlood" runat="server" TabIndex="4">
                                            <asp:ListItem Value="0" Selected="True">A</asp:ListItem>
                                            <asp:ListItem Value="1">B</asp:ListItem>
                                            <asp:ListItem Value="3">AB</asp:ListItem>
                                            <asp:ListItem Value="2">O</asp:ListItem>
                                            <asp:ListItem Value="4">����</asp:ListItem>
                                        </asp:DropDownList>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr">
                            <div class="bmtd">
                                <span><label for="birthday"><asp:Literal ID="ltlBirthday" runat="server"></asp:Literal></label></span>
                                    <em><input id="birday" runat="server" name="birthday" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd'})" /></em>
                            </div>
                            <div class="bmtd tdlabel">
                                <span><label for="education"><asp:Literal ID="ltlEducation" runat="server"></asp:Literal></label>
                                    </span>
                                    <em>
                                        <asp:DropDownList ID="ddlEducation" runat="server" TabIndex="6">
                                            <asp:ListItem Value="0" Selected="True">����</asp:ListItem>
                                            <asp:ListItem Value="1">��ר</asp:ListItem>
                                            <asp:ListItem Value="2">����</asp:ListItem>
                                            <asp:ListItem Value="3">�о���</asp:ListItem>
                                            <asp:ListItem Value="4">��ʿ</asp:ListItem>
                                            <asp:ListItem Value="5">˶ʿ</asp:ListItem>
                                        </asp:DropDownList>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr">
                            <div class="bmtd">
                                <span><label for="idgj"><asp:Literal ID="ltlGJ" runat="server"></asp:Literal></label>
                                    </span>
                                    <em>
                                        <input type="text" name="idgj" id="idgj" value="�й�" tabindex="7" runat="server" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                            <div class="bmtd tdlabel">
                                <span><label for="idtype"><asp:Literal ID="ltlCard" runat="server"></asp:Literal></label></span>
                                    <em>
                                       
                                        <input type="text" tabindex="8" id="prependedDropdownButton"  runat="server" maxlength="24" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr">
                            <div class="bmtd">
                                <span><label for="Placeofissue"><asp:Literal ID="ltlPlaceofissue" runat="server"></asp:Literal></label>
                                    </span>
                                    <em>
                                        <input type="text" name="Placeofissue" id="Placeofissue" tabindex="9"  runat="server" datatype="*" errormsg="����ǩ���ص����" nullmsg="����ǩ���ص����"/>
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                            <div class="bmtd tdlabel">
                                <span><label for="Dateofissue"><asp:Literal ID="ltlDateofissue" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <input id="Dateofissue" runat="server" name="Dateofissue" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd'})" />
                                      
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr">
                            <div class="bmtd">
                                <span><label for="Dateofexpiry"><asp:Literal ID="ltlDateofexpiry" runat="server"></asp:Literal></label>
                                    </span>
                                    <em>
                                        <input id="Dateofexpiry" runat="server" name="Dateofexpiry" type="text" style="width: 185px" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd'})" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                            <div class="bmtd tdlabel">
                                <span><label for="mobile"><asp:Literal ID="ltlMobile" runat="server"></asp:Literal></label>
                                    </span>
                                    <em>
                                        <input type="text" name="mobile" id="mobile" value="" tabindex="12" runat="server" maxlength="11" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr">
                            <div class="bmtd">
                                <span><label for="email"><asp:Literal ID="ltlEmail" runat="server"></asp:Literal></label>
                                    </span>
                                    <em>
                                        <input type="text" name="email" id="email" value="" tabindex="13" runat="server" maxlength="64" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                            <div class="bmtd tdlabel">
                                <span><label for="occupation"><asp:Literal ID="ltlOccupation" runat="server"></asp:Literal></label>
                                    </span>
                                    <em><asp:DropDownList ID="idOccupation" runat="server" TabIndex="14"></asp:DropDownList></em>

                                
                            </div>
                        </div>
                        <div class="bmtr">
                            <div class="bmtd">
                                <span><label for="address"><asp:Literal ID="ltlAddress" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <select tabindex="15" name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)" runat="server" >
                                        </select>
                                        <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)" runat="server" >
                                        </select>
                                        <script type="text/javascript">
                                            BindProvince("����");
                                        </script>
                                        <input type="hidden" id="idCity" name="idCity" size="5" runat="server" style="width: 30px" />
                                        <input type="text" id="cCityname" name="cCityname" size="15" value=""  runat="server" style="display: none" />
                                        <input type="hidden" runat="server" id="UpdatedFields" name="UpdatedFields" value="" />
                                        <input type="text" name="address" id="address" value="" tabindex="15" runat="server" maxlength="128" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                            <div class="bmtd">
                                <span><label for="addressen"><asp:Literal ID="ltladdressen" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <input type="text" name="addressen" id="addressen" value="" tabindex="16"  runat="server" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr">
                            <div class="bmtd">
                                <span><label for="zipcode"><asp:Literal ID="ltlZipCode" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <input type="text" name="zipcode" id="zipcode" value="" tabindex="16" runat="server" maxlength="6" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                            <div class="bmtd">
                                <span><label for="emerger"><asp:Literal ID="ltlEmerger" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <input type="text" name="emerger" id="emerger" value="" tabindex="17" runat="server" maxlength="30" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                        </div>

                        <div class="bmtr">
                            <div class="bmtd">
                                <span class="sosp"><label for="emermobile"><asp:Literal ID="ltlEmermobile" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <input type="text" name="emermobile" id="emermobile" value="" tabindex="18" runat="server" maxlength="30" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                            <div class="bmtd" runat="server" id="idsize">
                                <span><label for="competetion"><asp:Literal ID="ltlShirts" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <asp:DropDownList ID="size" runat="server"  TabIndex="21">
                                            <asp:ListItem Selected="True">S</asp:ListItem>
                                            <asp:ListItem>M</asp:ListItem>
                                            <asp:ListItem>L</asp:ListItem>
                                            <asp:ListItem>XL</asp:ListItem>
                                            <asp:ListItem>XXL</asp:ListItem>
                                            <asp:ListItem>XXXL</asp:ListItem>
                                        </asp:DropDownList>
                                    </em>
                            </div>
                        </div>
                        
                       <%-- <div class="bmtr tdlabele">
                            <div class="bmtd">
                                
                            </div>
                            <div class="bmtd" runat="server" id="idShoe">
                                <span class="sosp"><label for="shoeno"><asp:Literal ID="ltlShoes" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <input type="text" name="shoeno" id="shoeno" value="" tabindex="16" runat="server" /></em>
                            </div>
                        </div>--%>
                        <div class="bmtr">
                            <div class="bmtd bmcolspan" runat="server" id="idFJSC">
                                 <span class="upimg"><label><asp:Literal ID="ltlTjzm" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <asp:FileUpload ID="FileUpload1" runat="server" />
                                        <strong>��ʽΪ.jpg/.gif/.bmp/.png</strong><input type="hidden" id="fileurl" runat="server" /><div class="Validform_checktip"></div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr"  runat="server" id="field1" visible="false">
                            <div class="bmtd bmcolspan">
                                <span class="upimg"><label><asp:Literal ID="ltlfield1" runat="server"></asp:Literal></label></span>
                                    <em><asp:FileUpload ID="fileurl1" runat="server" /><strong>��ʽΪ.jpg/.gif/.bmp/.png</strong><div class="Validform_checktip">
                                    <asp:Literal ID="ltltip1" runat="server"></asp:Literal></div> </em>
                            </div>
                        </div>
                        <div class="bmtr" runat="server" id="field2" visible="false">
                            <div class="bmtd bmcolspan">
                                <span class="upimg">
                                        <label>
                                            <asp:Literal ID="ltlfield2" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <asp:FileUpload ID="fileurl2" runat="server" />
                                        <strong>��ʽΪ.jpg/.gif/.bmp/.png</strong><div class="Validform_checktip">
                                            <asp:Literal ID="ltltip2" runat="server"></asp:Literal>
                                        </div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr" runat="server" id="field3" visible="false">
                            <div class="bmtd bmcolspan">
                                <span class="upimg">
                                        <label>
                                            <asp:Literal ID="ltlfield3" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <asp:FileUpload ID="fileurl3" runat="server" />
                                        <strong>��ʽΪ.jpg/.gif/.bmp/.png</strong><div class="Validform_checktip">
                                            <asp:Literal ID="ltltip3" runat="server"></asp:Literal>
                                        </div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr" runat="server" id="txtfield1" visible="false">
                            <div class="bmtd bmcolspan tdlabele">
                                <span>
                                        <label for="traffica">
                                            <asp:Literal ID="ltlbzfield1" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <input type="text" value="" id="bzfield1" runat="server" /><div class="Validform_checktip">
                                            <asp:Literal ID="ltlbztip1" runat="server"></asp:Literal>
                                        </div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr" runat="server" id="txtfield2" visible="false">
                            <div class="bmtd bmcolspan tdlabele">
                                <span>
                                        <label for="traffica">
                                            <asp:Literal ID="ltlbzfield2" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <input type="text" value="" id="bzfield2" runat="server" /><div class="Validform_checktip">
                                            <asp:Literal ID="ltlbztip2" runat="server"></asp:Literal>
                                        </div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr" runat="server" id="txtfield3" visible="false">
                            <div class="bmtd bmcolspan tdlabele">
                                <span>
                                        <label for="traffica">
                                            <asp:Literal ID="ltlbzfield3" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <input type="text" value="" id="bzfield3" runat="server" /><div class="Validform_checktip">
                                            <asp:Literal ID="ltlbztip3" runat="server"></asp:Literal>
                                        </div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr" runat="server" id="rbfield1" visible="false">
                            <div class="bmtd bmcolspan tdlabele">
                                <span>
                                        <label for="traffica">
                                            <asp:Literal ID="ltlrb1" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <asp:RadioButtonList ID="rbyes1" runat="server" RepeatDirection="Vertical" RepeatLayout="UnorderedList" TabIndex="17">
                                            <asp:ListItem>��</asp:ListItem>
                                            <asp:ListItem Selected="True">��</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr" runat="server" id="rbfield2" visible="false">
                            <div class="bmtd bmcolspan tdlabele">
                                <span>
                                        <label for="traffica">
                                            <asp:Literal ID="ltlrb2" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <asp:RadioButtonList ID="rbyes2" runat="server" RepeatDirection="Vertical" RepeatLayout="UnorderedList" TabIndex="17">
                                            <asp:ListItem>��</asp:ListItem>
                                            <asp:ListItem Selected="True">��</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr" runat="server" id="rbfield3" visible="false">
                            <div class="bmtd bmcolspan tdlabele">
                                <span>
                                        <label for="traffica">
                                            <asp:Literal ID="ltlrb3" runat="server"></asp:Literal></label></span>
                                    <em>
                                        <asp:RadioButtonList ID="rbyes3" runat="server" RepeatDirection="Vertical" RepeatLayout="UnorderedList" TabIndex="17">
                                            <asp:ListItem>��</asp:ListItem>
                                            <asp:ListItem Selected="True">��</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </em>
                            </div>
                        </div>
                    </div>
                </div>
                <asp:Button ID="projectpos" runat="server" OnClick="btSubmit_Click" text="��  ��"/>
            </div>
        </div>
        <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
        <script>
            jQuery(document).ready(function ($) {
                var fileimg = $("#fileurl").val()
                if (fileimg) {
                    $("#idFJSC em").append('<a target="_blank" href="<%=HostInfo.imgName %>/Utility/uploads/' + fileimg + '">&nbsp;���ϴ�&nbsp;<img src="/Html/images/img_icon.png"></a>')
                } else {
                    $("#idFJSC .Validform_checktip").append("<a>�����ϴ����֤����ɼ�֤�� </a>")
                }
                var iCityid = '<% =iCity %>',
                    iAreaid = '<% =iArea %>'
                if (iCityid == "") {
                    iCityid = 1
                }
                if (iAreaid == "") {
                    iAreaid = 1
                }
                $("#idCity").val(101)
                var iCity = parseInt(iCityid) - 1,
                    iArea = parseInt(iAreaid)

                $("#cCityname").val(china[iCity][0] + china[iCity][iArea])
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
                // if (GetQueryString("idcompete") == "300000445") {
                //     loadjscssfile("/Html/css/racetnf.css", "css")
                //     $(".logo").replaceWith('<div class="tnflogo"><a href="/"><img src="/Html/images/tnflogo1.png"></a><a href="http://www.quyeba.com" target="_blank"><img src="/Html/images/tnflogo2.png"></a><a href="http://www.quyeba.com/tnf100/" target="_blank"><img src="/Html/images/tnflogo3.png"></a></div>')
                // }
            });
        function loadjscssfile(filename, filetype) {
            if (filetype == "js") { //�ж��ļ����� 
                var fileref = document.createElement('script')//������ǩ 
                fileref.setAttribute("type", "text/javascript")//��������type��ֵΪtext/javascript 
                fileref.setAttribute("src", filename)//�ļ��ĵ�ַ 
            }
            else if (filetype == "css") { //�ж��ļ����� 
                var fileref = document.createElement("link")
                fileref.setAttribute("rel", "stylesheet")
                fileref.setAttribute("type", "text/css")
                fileref.setAttribute("href", filename)
            }
            if (typeof fileref != "undefined")
                document.getElementsByTagName("head")[0].appendChild(fileref)
        }
        function GetQueryString(name) {
            var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
            var r = window.location.search.substr(1).match(reg);
            if (r != null) return unescape(r[2]); return null;
        }
        $("#address").focus(function (event) {
            $(this).css('width', '200px');
        });
        $("#address").blur(function (event) {
            $(this).css('width', '100px');
        });
        // $("#prependedDropdownButton").focus(function (event) {
        //     $(this).css('width', '170px');
        // });
        // $("#prependedDropdownButton").blur(function (event) {
        //     $(this).css('width', '118px');
        // });
        var demo = $("#form1").Validform({
            tiptype: function (msg, o, cssctl) {
                if (!o.obj.is("form")) {
                    var objtip = o.obj.nextAll(".Validform_checktip");
                    cssctl(objtip, o.type);
                    objtip.text(msg);
                }
            },
            datatype:{
                "pinyin":function(gets,obj,curform,regxp){
                    //����gets�ǻ�ȡ���ı�Ԫ��ֵ��objΪ��ǰ��Ԫ�أ�curformΪ��ǰ��֤�ı���regxpΪ���õ�һЩ������ʽ������;
                    var reg=/^[A-Za-z]+$/;
         
                    if(reg.test(gets)){return true;}
                    return 'ֻ����дƴ��';
         
                    //ע��return���Է���true �� false �� �ַ������֣�true��ʾ��֤ͨ���������ַ�����ʾ��֤ʧ�ܣ��ַ�����Ϊ������ʾ��ʾ������false����errmsg��Ĭ�ϵĴ�����ʾ;
                },
            }
        });
        if (GetQueryString("la") == "cn") {
            demo.addRule([
                {
                    ele: "#name",
                    datatype: "s2-18",
                    nullmsg: "��������ʵ����!",
                    errormsg: "����6���ַ�,���18���ַ���"
                },
                {
                    ele: "#mobile",
                    datatype: "m",
                    nullmsg: "����д�ֻ�����!",
                    errormsg: "�ֻ����벻��ȷ"
                },
                {
                    ele: "#email",
                    datatype: "e",
                    nullmsg: "����д����",
                    errormsg: "�����ַ��ʽ����!"
                },
                {
                    ele: "#addressen",
                    datatype: "s",
                    nullmsg: "����дӢ�ĵ�ַ",
                },
                {
                    ele: "#zipcode",
                    datatype: "*",
                    nullmsg: "�����ʱ�"
                },
                {
                    ele: "#emerger",
                    datatype: "*",
                    nullmsg: "����д������ϵ��"
                },
                {
                    ele: "#emermobile",
                    datatype: "*",
                    nullmsg: "����д������ϵ�绰"
                },
                {
                    ele: "#prependedDropdownButton",
                    datatype: "*",
                    nullmsg: "֤���ű���"
                },
                {
                    ele: "#idgj",
                    datatype: "*",
                    nullmsg: "��������"
                },
                {
                    ele: "#address",
                    datatype: "*",
                    nullmsg: "��ϸ��ַ����"
                },
                {
                    ele: "#ddlProvince",
                    datatype: "*",
                    nullmsg: "��ѡ�����"
                },
                {
                    ele: "#ddlCity",
                    datatype: "*",
                    nullmsg: "��ѡ�����"
                },
                {
                    ele: "#bzfield1",
                    datatype: "*",
                    nullmsg: "����"
                }
                ,
                {
                    ele: "#bzfield2",
                    datatype: "*",
                    nullmsg: "����"
                }
                 ,
                {
                    ele: "#bzfield3",
                    datatype: "*",
                    nullmsg: "����"
                },
                {
                    ele: "#fileurl1",
                    datatype: "*",
                    nullmsg: "�����ϴ��ļ�"
                }
                ,
                {
                    ele: "#fileurl2",
                    datatype: "*",
                    nullmsg: "�����ϴ��ļ�"
                }
                 ,
                {
                    ele: "#fileurl3",
                    datatype: "*",
                    nullmsg: "�����ϴ��ļ�"
                }
            ]);
        } else {
            demo.addRule([
                {
                    ele: "#name",
                    datatype: "s2-18",
                    nullmsg: "em!",
                    errormsg: "����6���ַ�,���18���ַ���",
                    sucmsg: "Right"
                },
                {
                    ele: "#mobile",
                    datatype: "m",
                    nullmsg: "����д�ֻ�����!",
                    errormsg: "�ֻ����벻��ȷ",
                    sucmsg: "Right"
                },
                {
                    ele: "#email",
                    datatype: "e",
                    nullmsg: "����д����",
                    errormsg: "�����ַ��ʽ����!",
                    sucmsg: "Right"
                },
                {
                    ele: "#addressen",
                    datatype: "s",
                    nullmsg: "����дӢ�ĵ�ַ",
                    sucmsg: "Right"
                },
                {
                    ele: "#zipcode",
                    datatype: "*",
                    nullmsg: "�����ʱ�",
                    sucmsg: "Right"
                },
                {
                    ele: "#emerger",
                    datatype: "*",
                    nullmsg: "����д������ϵ��",
                    sucmsg: "Right"
                },
                {
                    ele: "#emermobile",
                    datatype: "*",
                    nullmsg: "����д������ϵ�绰",
                    sucmsg: "Right"
                },
                {
                    ele: "#prependedDropdownButton",
                    datatype: "*",
                    nullmsg: "֤���ű���",
                    sucmsg: "Right"
                },
                {
                    ele: "#idgj",
                    datatype: "*",
                    nullmsg: "��������",
                    sucmsg: "Right"
                },
                {
                    ele: "#address",
                    datatype: "*",
                    nullmsg: "��ϸ��ַ����",
                    sucmsg: "Address Right"
                },
                {
                    ele: "#ddlProvince",
                    datatype: "*",
                    nullmsg: "��ѡ�����",
                    sucmsg: "Province Right"
                },
                {
                    ele: "#ddlCity",
                    datatype: "*",
                    nullmsg: "��ѡ�����",
                    sucmsg: "City Right"
                },
                {
                    ele: "#bzfield1",
                    datatype: "*",
                    nullmsg: "����"
                }
                ,
                {
                    ele: "#bzfield2",
                    datatype: "*",
                    nullmsg: "����"
                }
                 ,
                {
                    ele: "#bzfield3",
                    datatype: "*",
                    nullmsg: "����"
                },
                {
                    ele: "#fileurl1",
                    datatype: "*",
                    nullmsg: "�����ϴ��ļ�"
                }
                ,
                {
                    ele: "#fileurl2",
                    datatype: "*",
                    nullmsg: "�����ϴ��ļ�"
                }
                 ,
                {
                    ele: "#fileurl3",
                    datatype: "*",
                    nullmsg: "�����ϴ��ļ�"
                }
            ]);

            $('label[for="idBlood_4"]').html("Other")
            $('label[for="idgender_0"]').html("Male")
            $('label[for="idgender_1"]').html("Female")

            $('#ddlEducation option[value="0"]').html("Other")
            $('#ddlEducation option[value="1"]').html("junior college")
            $('#ddlEducation option[value="2"]').html("bachelor")
            $('#ddlEducation option[value="3"]').html("postgraduate")
            $('#ddlEducation option[value="4"]').html("Ph.D")
            $('#ddlEducation option[value="5"]').html("master")

            $('#ddlCard option[value="1"]').html("ID card")
            $('#ddlCard option[value="2"]').html("Military identification")
            $('#ddlCard option[value="3"]').html("Residence booklet")
            $('#ddlCard option[value="4"]').html("Passport")
            $('#ddlCard option[value="5"]').html("Other")
            $('#ddlProvince option[value=""]').html("Province")
            // $('#ddlCity option[value=""]').html("City")
        }

        </script>
    </form>
</body>
</html>
