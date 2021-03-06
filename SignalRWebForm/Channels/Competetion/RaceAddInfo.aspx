<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RaceAddInfo.aspx.cs" Inherits="Channels_Competetion_RaceAddInfo" %>

<%@ Register Src="~/Controls/Erun_Footer.ascx" TagPrefix="ERUN360" TagName="Erun_Footer" %><%@ Register Src="~/Controls/Erun_Header.ascx" TagPrefix="ERUN360" TagName="Erun_Header" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
    <title>益跑网-中国领先的跑步门户网站-ERUN360.COM</title>
    <meta name="description" content="中国第一大专业跑步门户网站。我们致力于以专业的跑步内容和产品，面向跑步爱好者、俱乐部、厂商和赛事组织者的全方位专业服务，打造业界一流的全跑步生态链平台，让跑步不仅能提升身心健康，更将成为社会潮流新时尚。" />
    <meta name="keywords" content="跑步,训练,健身,跑步网站,跑步网,越野,跑步机,跑步训练,红粉跑者,女性跑步,女生跑步,营养,瘦身,赛事,城市,跑步人生,初级跑者,跑步入门,跑步工具,5KM,10KM,半程马拉松,全程马拉松,越野跑,跑步技巧,专项训练,养颜塑身,女性装备,训练技巧,跑步问题,跑鞋,跑步鞋,铁人三项,跑步服装,跑步配件,健康跑步,伤病恢复,身体解密,饮食,减肥,国际赛事,国内赛事,跑在各地,我是跑者,跑步英雄,跑步随笔,为什么跑,如何开始,第一次比赛,新手问题 ,田径短跑,田径赛道,公路跑,无袖,背心,短袖,长袖,短裤,裤子,紧身裤,夹克,马甲,内衣,袜子,鞋套,压缩,恢复,电子产品,补剂,袖套,腿套,腰带,腰包,手套,帽子,头饰,饮水系统,反光,照明,保护治疗,鞋垫,运动包,跑步眼镜,GPS,心率,跑步手表,能量胶,嚼片,饮品,补液,能量棒" />
    <meta http-equiv="content-language" content="zh-cn" />
    <meta http-equiv="imagetoolbar" content="no" />
    <meta name="distribution" content="global" />
    <link href="favicon.ico" rel="shortcut icon" type="image/ico" />
    <link href="/Html/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="/Html/css/colorbox.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/public.css" />
    <link rel="stylesheet" type="text/css" href="/Html/css/rece.css" />
    <link href="/Common/cansai-from.css" rel="stylesheet" type="text/css" />
    <link href="/Common/Calendar.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript" src="/Html/js/jquery-1.9.1.min.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.colorbox-min.js"></script>
    <script type="text/javascript" src="/Html/js/Validform_v5.3.2_min.js"></script>
    <script type="text/javascript" src="/Common/jCheck.js"></script>
    <script type="text/javascript" src="/Common/jPopup.js"></script>
    <script type="text/javascript" src="/Common/jCalendar.js"></script>
    <script type="text/javascript" src="/Common/jPopupfbk.js?2012111"></script>
    <script type="text/javascript" src="/Common/jCity.js"></script>
    <script type="text/javascript" src="/Html/js/jquery.blockUI.js"></script>
</head>
<body onload="showimg()">
    <ERUN360:Erun_Header runat="server" ID="Erun_Header" />
    <div class="indecen">
        <form id="form1" runat="server" class="marathon-reg">
            <h1>
                <asp:Label ID="Labeltitle" runat="server" Text="报名"></asp:Label><a href="/Channels/Competetion/EventApply.aspx?idcompete=<%=id%>" class="lang">English</a></h1>
            <h4>凡在线报名过的用户我们将自动为您填写部分信息,如您需要修改信息，请直接修改表单内容即可,以下信息为必填项，请认真填写;若您帮朋友报名，请先注册账号再进行报名</h4>
            <table>
                <tr>
                    <td>
                        <span>
                            <label for="name">姓名</label></span>
                        <em>
                            <input type="text" name="name" id="name" value="" tabindex="1" runat="server" maxlength="16" /></em>
                    </td>
                    <td class="tdlabel">
                        <span>
                            <label for="gendera">性别</label></span>
                        <asp:RadioButtonList ID="idgender" runat="server" RepeatLayout="UnorderedList">
                            <asp:ListItem Value="0" Selected="True">男</asp:ListItem>
                            <asp:ListItem Value="1">女</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
                <tr>
                    <td class="xuexing">
                        <span>
                            <label for="blood">血型</label></span>
                        <em>
                            <asp:RadioButtonList ID="idblood" runat="server" RepeatLayout="UnorderedList" Width="250px">
                                <asp:ListItem Value="0" Selected="True">A</asp:ListItem>
                                <asp:ListItem Value="1">B</asp:ListItem>
                                <asp:ListItem Value="3">AB</asp:ListItem>
                                <asp:ListItem Value="2">O</asp:ListItem>
                                <asp:ListItem Value="4">其他</asp:ListItem>                                
                            </asp:RadioButtonList>
                            </em>
                    </td>
                    <td>
                        <span>
                            <label for="birthday">出生年月</label></span>
                        <em>
                            <input type="text" runat="server" name="birthday" id="birday" value="" tabindex="4" onclick="GDate(this);" /></em>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>
                            <label for="education">学历</label></span>
                        <em>
                            <select id="education" tabindex="5" runat="server">
                                <option value="其他">其他</option>
                                <option value="大专">大专</option>
                                <option value="本科">本科</option>
                                <option value="研究生">研究生</option>
                                <option value="博士">博士</option>
                                <option value="硕士">硕士</option>
                            </select>
                        </em>
                    </td>
                    <td>
                        <span>
                            <label for="occupation">职业</label></span>
                        <em>
                            <asp:DropDownList ID="idOccupation" runat="server"></asp:DropDownList></em>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>
                            <label for="idtype">证件类型</label></span>
                        <em>
                            <div class="input-prepend">
                                <select id="idCard" class="card" tabindex="7" runat="server">
                                    <option value="请选择">请选择</option>
                                    <option value="身份证">身份证</option>
                                    <option value="军官证">军官证</option>
                                    <option value="户口本">户口本</option>
                                    <option value="护照">护照</option>
                                    <option value="其它">其它</option>
                                </select>
                                <input type="text" tabindex="7" id="prependedDropdownButton" class="span2" runat="server" maxlength="24">
                            </div>
                        </em>
                    </td>
                    <td>
                        <span>
                            <label for="mobile">手机</label></span>
                        <em>
                            <input type="text" name="mobile" id="mobile" value="" tabindex="8" runat="server" maxlength="11" /></em>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>
                            <label for="email">电子邮箱</label></span>
                        <em>
                            <input type="text" name="email" id="email" value="" tabindex="9" check-type="mail" mail-message="邮箱格式不正确！" runat="server" maxlength="64" /></em>
                    </td>
                    <td>
                        <span>
                            <label for="city">居住城市</label></span>
                        <%--<em><input type="text" name="city" id="city" value="" tabindex="10"  runat="server"/></em>--%>
                        <select name="ddlProvince" id="ddlProvince" onchange="selectMoreCity(this)" runat="server" style="width: 110px;">
                        </select>
                        <select name="ddlCity" id="ddlCity" onchange="selectOneCity(this)" runat="server" style="width: 110px;">
                        </select>
                        <script type="text/javascript">
                            BindProvince("北京");
                        </script>
                        <input type="hidden" id="idCity" name="idCity" size="5" runat="server" style="width: 30px" />
                        <input type="text" id="cCityname" name="cCityname" size="15" value="" readonly runat="server" style="width: 100px" />
                        <input type="hidden" runat="server" id="UpdatedFields" name="UpdatedFields" value="" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>
                            <label for="address">地址</label></span>
                        <em>
                            <input type="text" name="address" id="address" value="" tabindex="11" runat="server" maxlength="128" /></em>
                    </td>
                    <td>
                        <span>
                            <label for="zipcode">邮编</label></span>
                        <em>
                            <input type="text" name="zipcode" id="zipcode" value="" tabindex="12" runat="server" maxlength="6" /></em>
                    </td>
                </tr>
                <tr>
                    <td>
                        <span>
                            <label for="emerger">紧急联系人</label></span>
                        <em>
                            <input type="text" name="emerger" id="emerger" value="" tabindex="13" runat="server" maxlength="30" /></em>
                    </td>
                    <td>
                        <span>
                            <label for="emermobile">紧急联系电话</label></span>
                        <em>
                            <input type="text" name="emermobile" id="emermobile" value="" tabindex="14" runat="server" maxlength="30" /></em>
                    </td>
                </tr>

                <tr class="tdlabele">
                    <td colspan="2">
                        <span>
                            <label for="competetion">参赛项目</label></span>
                        <em>
                            <asp:RadioButtonList ID="rdoEntries" runat="server" RepeatDirection="Vertical" AutoPostBack="True" OnSelectedIndexChanged="rdoEntries_SelectedIndexChanged" RepeatLayout="UnorderedList"></asp:RadioButtonList>
                        </em>
                    </td>
                </tr>
                <tr height="36">
                    <td colspan="2" style="height: 36px">
                        <span style="padding: 0">
                            <label>项目说明</label></span><div class="bmtip">
                                <%=Item%><%=bm%>
                            </div>
                    </td>
                </tr>
                <tr>
                    <td class="tdlabelf">
                        <div id="sizetd" runat="server">
                            <span>
                                <label for="size">纪念衫尺寸</label>
                            </span>
                            <em>
                                <asp:RadioButtonList ID="size" runat="server" RepeatDirection="Vertical" RepeatLayout="UnorderedList">
                                    <asp:ListItem Selected="True">S</asp:ListItem>
                                    <asp:ListItem>M</asp:ListItem>
                                    <asp:ListItem>L</asp:ListItem>
                                    <asp:ListItem>XL</asp:ListItem>
                                    <asp:ListItem>XXL</asp:ListItem>
                                    <asp:ListItem>XXXL</asp:ListItem>
                                </asp:RadioButtonList>
                            </em>
                        </div>
                    </td>
                    <td>
                        <div id="Divshoe" runat="server">
                            <span>
                                <label for="number">鞋号</label></span>
                            <em>
                                <input type="text" name="shoeno" id="shoeno" value="" tabindex="17" runat="server" /></em>
                        </div>
                    </td>
                </tr>
                <div id="gj" runat="server" visible="false">
                    <tr>
                        <td colspan="2">
                            <span>
                                <label for="nationality">国籍</label></span>
                            <em>
                                <input type="text" name="shoeno" id="idgj" value="" tabindex="17" runat="server" />
                            </em>
                        </td>
                    </tr>
                </div>
                <div id="jtfs" runat="server" visible="false">
                    <tr>
                        <td class="tdlabele" colspan="2">

                            <span>
                                <label for="traffica">前往比赛地交通方式</label></span>
                            <em>
                                <asp:RadioButtonList ID="idtjfs" runat="server" RepeatDirection="Vertical" RepeatLayout="UnorderedList">
                                    <asp:ListItem Selected="True">北京6日早8点出发</asp:ListItem>
                                    <asp:ListItem>石家庄6日早10点出发</asp:ListItem>
                                    <asp:ListItem>自驾</asp:ListItem>
                                </asp:RadioButtonList>
                            </em>

                        </td>
                    </tr>
                </div>
                <tr class="uptijian" runat="server" id="trupload">
                    <td colspan="2">
                        <span>
                            <label>上传体检证明或成绩证书</label></span>
                        <em>
                            <asp:FileUpload ID="FileUpload1" runat="server" />格式为.jpg/.gif/.bmp/.png<input type="hidden" id="fileurl" runat="server" /></em>
                    </td>
                </tr>
            </table>
            <div class="control-group">
                <div class="controls">
                    <asp:Button ID="Ctnsubmit" runat="server" Text="Button" OnClick="Ctnsubmit_Click" />
                </div>
            </div>
        </form>
        <div style="display: none">
            <div id="tips">
            </div>
            <div id="bdmap">
                <div id="hdjmap">
                </div>
                <a href="javascript:void(0)" onclick="mapqd()" class="mapqd"></a>
            </div>
        </div>
    </div>
    <script type="text/javascript">
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
        $("#ddlCity").css("width", "110px");
        $("#ddlProvince").css("width", "110px");
        var iCity = parseInt(<% =iCity %>) - 1
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
                cityname = "北京"
            }
        });


        function showimg() {
            var jkimgurl = $("#fileurl").val();
            if (jkimgurl != "") {
                //console.log(jkimgurl);
                $("#trupload td").append("<a href=\"<%=HostInfo.imgName %>/Utility/uploads/" + jkimgurl + "\" target=\"_blank\">上传成功&nbsp;<img src=\"/Html/images/img_icon.png\"></a>")
            } else {
                //console.log("jkimgurl");
                $("#trupload td").append("<a>请您上传体检证明或成绩证书 </a>")
            }
        }
    </script>
    <ERUN360:Erun_Footer runat="server" ID="Erun_Footer" />
</body>
</html>
