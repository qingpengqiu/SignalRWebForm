<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceAbroad.aspx.cs" Inherits="Channels_Competetion_RaceAbroad" %>
<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %><!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
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
                            <asp:Literal ID="ltlTotal" runat="server"></asp:Literal>￥<asp:Literal ID="ltlfPrice" runat="server"></asp:Literal>元
                        </p>
                        <em><asp:Literal ID="ltlSelect" runat="server"></asp:Literal></em>
                    </div>
                    <div class="bmtable">
                        <div class="bmtr">
                            <div class="bmtd">
                                <span><label for="name"><asp:Literal ID="ltllastname" runat="server"></asp:Literal></label></span>
                                    <em><input type="text"  runat="server" maxlength="30" tabindex="1" id="surname" name="surname" datatype="pinyin" errormsg="请填写姓氏(拼音)" nullmsg="请填写姓氏(拼音)" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                            <div class="bmtd tdlabel">
                                <span><label for="name"><asp:Literal ID="ltlfamilyname" runat="server"></asp:Literal></label></span>
                                    <em><input type="text"   runat="server" maxlength="30" tabindex="2" id="cname" name="name" datatype="pinyin" errormsg="请填写名字(拼音)" nullmsg="请填写名字(拼音)" />
                                        <div class="Validform_checktip"></div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr">
                            <div class="bmtd">
                                <span><label for="gendera"><asp:Literal ID="ltlGender" runat="server"></asp:Literal></label>
                                    </span>
                                        <asp:RadioButtonList ID="idgender" runat="server" RepeatLayout="UnorderedList" TabIndex="3">
                                            <asp:ListItem Value="0" Selected="True">男</asp:ListItem>
                                            <asp:ListItem Value="1">女</asp:ListItem>
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
                                            <asp:ListItem Value="4">其他</asp:ListItem>
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
                                            <asp:ListItem Value="0" Selected="True">其他</asp:ListItem>
                                            <asp:ListItem Value="1">大专</asp:ListItem>
                                            <asp:ListItem Value="2">本科</asp:ListItem>
                                            <asp:ListItem Value="3">研究生</asp:ListItem>
                                            <asp:ListItem Value="4">博士</asp:ListItem>
                                            <asp:ListItem Value="5">硕士</asp:ListItem>
                                        </asp:DropDownList>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr">
                            <div class="bmtd">
                                <span><label for="idgj"><asp:Literal ID="ltlGJ" runat="server"></asp:Literal></label>
                                    </span>
                                    <em>
                                        <input type="text" name="idgj" id="idgj" value="中国" tabindex="7" runat="server" />
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
                                        <input type="text" name="Placeofissue" id="Placeofissue" tabindex="9"  runat="server" datatype="*" errormsg="护照签发地点必填" nullmsg="护照签发地点必填"/>
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
                                            BindProvince("北京");
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
                                        <strong>格式为.jpg/.gif/.bmp/.png</strong><input type="hidden" id="fileurl" runat="server" /><div class="Validform_checktip"></div>
                                    </em>
                            </div>
                        </div>
                        <div class="bmtr"  runat="server" id="field1" visible="false">
                            <div class="bmtd bmcolspan">
                                <span class="upimg"><label><asp:Literal ID="ltlfield1" runat="server"></asp:Literal></label></span>
                                    <em><asp:FileUpload ID="fileurl1" runat="server" /><strong>格式为.jpg/.gif/.bmp/.png</strong><div class="Validform_checktip">
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
                                        <strong>格式为.jpg/.gif/.bmp/.png</strong><div class="Validform_checktip">
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
                                        <strong>格式为.jpg/.gif/.bmp/.png</strong><div class="Validform_checktip">
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
                                            <asp:ListItem>是</asp:ListItem>
                                            <asp:ListItem Selected="True">否</asp:ListItem>
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
                                            <asp:ListItem>是</asp:ListItem>
                                            <asp:ListItem Selected="True">否</asp:ListItem>
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
                                            <asp:ListItem>是</asp:ListItem>
                                            <asp:ListItem Selected="True">否</asp:ListItem>
                                        </asp:RadioButtonList>
                                    </em>
                            </div>
                        </div>
                    </div>
                </div>
                <asp:Button ID="projectpos" runat="server" OnClick="btSubmit_Click" text="提  交"/>
            </div>
        </div>
        <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
        <script>
            jQuery(document).ready(function ($) {
                var fileimg = $("#fileurl").val()
                if (fileimg) {
                    $("#idFJSC em").append('<a target="_blank" href="<%=HostInfo.imgName %>/Utility/uploads/' + fileimg + '">&nbsp;已上传&nbsp;<img src="/Html/images/img_icon.png"></a>')
                } else {
                    $("#idFJSC .Validform_checktip").append("<a>请您上传体检证明或成绩证书 </a>")
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
            if (filetype == "js") { //判断文件类型 
                var fileref = document.createElement('script')//创建标签 
                fileref.setAttribute("type", "text/javascript")//定义属性type的值为text/javascript 
                fileref.setAttribute("src", filename)//文件的地址 
            }
            else if (filetype == "css") { //判断文件类型 
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
                    //参数gets是获取到的表单元素值，obj为当前表单元素，curform为当前验证的表单，regxp为内置的一些正则表达式的引用;
                    var reg=/^[A-Za-z]+$/;
         
                    if(reg.test(gets)){return true;}
                    return '只能填写拼音';
         
                    //注意return可以返回true 或 false 或 字符串文字，true表示验证通过，返回字符串表示验证失败，字符串作为错误提示显示，返回false则用errmsg或默认的错误提示;
                },
            }
        });
        if (GetQueryString("la") == "cn") {
            demo.addRule([
                {
                    ele: "#name",
                    datatype: "s2-18",
                    nullmsg: "请输入真实姓名!",
                    errormsg: "至少6个字符,最多18个字符！"
                },
                {
                    ele: "#mobile",
                    datatype: "m",
                    nullmsg: "请填写手机号码!",
                    errormsg: "手机号码不正确"
                },
                {
                    ele: "#email",
                    datatype: "e",
                    nullmsg: "请填写邮箱",
                    errormsg: "邮箱地址格式不对!"
                },
                {
                    ele: "#addressen",
                    datatype: "s",
                    nullmsg: "请填写英文地址",
                },
                {
                    ele: "#zipcode",
                    datatype: "*",
                    nullmsg: "请填邮编"
                },
                {
                    ele: "#emerger",
                    datatype: "*",
                    nullmsg: "请填写紧急联系人"
                },
                {
                    ele: "#emermobile",
                    datatype: "*",
                    nullmsg: "请填写紧急联系电话"
                },
                {
                    ele: "#prependedDropdownButton",
                    datatype: "*",
                    nullmsg: "证件号必填"
                },
                {
                    ele: "#idgj",
                    datatype: "*",
                    nullmsg: "国籍必填"
                },
                {
                    ele: "#address",
                    datatype: "*",
                    nullmsg: "详细地址必填"
                },
                {
                    ele: "#ddlProvince",
                    datatype: "*",
                    nullmsg: "请选择地区"
                },
                {
                    ele: "#ddlCity",
                    datatype: "*",
                    nullmsg: "请选择城市"
                },
                {
                    ele: "#bzfield1",
                    datatype: "*",
                    nullmsg: "必填"
                }
                ,
                {
                    ele: "#bzfield2",
                    datatype: "*",
                    nullmsg: "必填"
                }
                 ,
                {
                    ele: "#bzfield3",
                    datatype: "*",
                    nullmsg: "必填"
                },
                {
                    ele: "#fileurl1",
                    datatype: "*",
                    nullmsg: "请您上传文件"
                }
                ,
                {
                    ele: "#fileurl2",
                    datatype: "*",
                    nullmsg: "请您上传文件"
                }
                 ,
                {
                    ele: "#fileurl3",
                    datatype: "*",
                    nullmsg: "请您上传文件"
                }
            ]);
        } else {
            demo.addRule([
                {
                    ele: "#name",
                    datatype: "s2-18",
                    nullmsg: "em!",
                    errormsg: "至少6个字符,最多18个字符！",
                    sucmsg: "Right"
                },
                {
                    ele: "#mobile",
                    datatype: "m",
                    nullmsg: "请填写手机号码!",
                    errormsg: "手机号码不正确",
                    sucmsg: "Right"
                },
                {
                    ele: "#email",
                    datatype: "e",
                    nullmsg: "请填写邮箱",
                    errormsg: "邮箱地址格式不对!",
                    sucmsg: "Right"
                },
                {
                    ele: "#addressen",
                    datatype: "s",
                    nullmsg: "请填写英文地址",
                    sucmsg: "Right"
                },
                {
                    ele: "#zipcode",
                    datatype: "*",
                    nullmsg: "请填邮编",
                    sucmsg: "Right"
                },
                {
                    ele: "#emerger",
                    datatype: "*",
                    nullmsg: "请填写紧急联系人",
                    sucmsg: "Right"
                },
                {
                    ele: "#emermobile",
                    datatype: "*",
                    nullmsg: "请填写紧急联系电话",
                    sucmsg: "Right"
                },
                {
                    ele: "#prependedDropdownButton",
                    datatype: "*",
                    nullmsg: "证件号必填",
                    sucmsg: "Right"
                },
                {
                    ele: "#idgj",
                    datatype: "*",
                    nullmsg: "国籍必填",
                    sucmsg: "Right"
                },
                {
                    ele: "#address",
                    datatype: "*",
                    nullmsg: "详细地址必填",
                    sucmsg: "Address Right"
                },
                {
                    ele: "#ddlProvince",
                    datatype: "*",
                    nullmsg: "请选择地区",
                    sucmsg: "Province Right"
                },
                {
                    ele: "#ddlCity",
                    datatype: "*",
                    nullmsg: "请选择城市",
                    sucmsg: "City Right"
                },
                {
                    ele: "#bzfield1",
                    datatype: "*",
                    nullmsg: "必填"
                }
                ,
                {
                    ele: "#bzfield2",
                    datatype: "*",
                    nullmsg: "必填"
                }
                 ,
                {
                    ele: "#bzfield3",
                    datatype: "*",
                    nullmsg: "必填"
                },
                {
                    ele: "#fileurl1",
                    datatype: "*",
                    nullmsg: "请您上传文件"
                }
                ,
                {
                    ele: "#fileurl2",
                    datatype: "*",
                    nullmsg: "请您上传文件"
                }
                 ,
                {
                    ele: "#fileurl3",
                    datatype: "*",
                    nullmsg: "请您上传文件"
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
